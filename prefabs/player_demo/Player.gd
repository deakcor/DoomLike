extends KinematicBody

#constants
const GRAVITY = 9.8

#mouse sensitivity
export(float,0.1,1.0) var sensitivity_x = 0.5
export(float,0.1,1.0) var sensitivity_y = 0.4

#physics
export(float,10.0, 30.0) var speed = 15.0
export(float,10.0, 50.0) var jump_height = 25
export(float,1.0, 10.0) var mass = 8.0
export(float,0.1, 3.0, 0.1) var gravity_scl = 1.0

#instances ref
onready var player_cam = $Camera
onready var player_hand = $Arm
onready var ground_ray = $GroundRay
onready var player_weapon =$weapon
onready var fire_timer = $Timer
onready var reload_timer=$timer_reload

#variables
var mouse_motion = Vector2()
var gravity_speed = 0
var camrot_before:Vector2

#weapon
export(float, 0.1, 1.0, 0.01) var fire_rate = 0.16
export(int, 10, 30) var max_bullet = 15
export(int, 1, 10) var reload_time = 1.6
export(bool) var auto=true
var can_shoot = true
var bullet_count = -1
var reloading=false
var shooting=false
var second_fire=false
var type_second_fire:int
var current_weapon=0
var current_anim
var ammo_curr=[-1,0]
var ammo_weapon=[-1,100]
var bullet_id=0
signal s_ammo(b_count,b_max)
signal s_reload(r_delay)


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ground_ray.enabled = true
	set_weapon(current_weapon)
	
func set_weapon(id:int):
	can_shoot=false
	reloading=false
	ammo_curr[current_weapon]=bullet_count
	var stat:Dictionary=bdd.weapons[id]
	current_weapon=id
	fire_rate=stat.fire_rate
	reload_time=stat.reload_time
	max_bullet=stat.max_bullet
	fire_timer.wait_time = fire_rate
	reload_timer.wait_time=reload_time
	bullet_count = ammo_curr[id]
	type_second_fire=stat.second_fire
	bullet_id=stat.bullet_id
	reset_anim()
	current_anim=stat.anim
	$anim_weapon.play("down")
	_update_hud()

func _physics_process(delta):
	
	#camera and body rotation
	rotate_y(deg2rad(20)* - mouse_motion.x * sensitivity_x * delta)
	player_cam.rotate_x(deg2rad(20) * - mouse_motion.y * sensitivity_y * delta)
	player_cam.rotation.x = clamp(player_cam.rotation.x, deg2rad(-47), deg2rad(47))
	#player_hand.rotation.x = lerp(player_hand.rotation.x, player_cam.rotation.x, 0.2)
	#player_weapon.rotation = lerp(player_hand.rotation.x, player_cam.rotation.x, 0.2)
	$SpotLight.rotation.x = lerp($SpotLight.rotation.x, player_cam.rotation.x, 0.2)

	mouse_motion = Vector2()
	var tmpdif:Vector2
	tmpdif.x=camrot_before.y-rotation.y
	tmpdif.y=(camrot_before.x-player_cam.rotation.x)
	player_weapon.position.y=lerp(player_weapon.position.y,176-max(-8,min(8,tmpdif.y*100)),10*delta)
	player_weapon.position.x=lerp(player_weapon.position.x,-max(-16,min(16,tmpdif.x*100)),10*delta)
	camrot_before.x=player_cam.rotation.x
	camrot_before.y=rotation.y
	#gravity
	gravity_speed -= GRAVITY * gravity_scl * mass * delta
	
	#character moviment
	var velocity = Vector3()
	velocity = _axis() * speed
	velocity.y = gravity_speed
	
	#jump
	if Input.is_action_just_pressed("space") and ground_ray.is_colliding():
		velocity.y = jump_height
	
	gravity_speed = move_and_slide(velocity).y
	if second_fire:
		if can_shoot and not reloading:
			reset_anim()
	if shooting:
		if can_shoot:
			if bullet_count != 0:
				reloading=false
				bullet_count =max(-1, bullet_count-1)
				fire_timer.start()
				_shoot()
				can_shoot = false
				shooting=auto
			else:
				_reload()



func _input(event):
	
	if event is InputEventMouseMotion:
		mouse_motion = event.relative
	
	if event.is_action_pressed("fire"):
		shooting=true
	if event.is_action_released("fire"):
		shooting=false
	if event.is_action_pressed("secondary_fire"):
		second_fire=true
	if event.is_action_released("secondary_fire"):
		second_fire=false
	if event.is_action_pressed("reload"):
		_reload()
	if event.is_action_pressed("next_weapon"):
		set_weapon((current_weapon+1)%ammo_weapon.size())
		
func _reload():
	if bullet_count!=max_bullet and !reloading and ammo_weapon[current_weapon]>0:
		reloading=true
		ammo_weapon[current_weapon]+=bullet_count
		bullet_count = 0
		_update_hud()
		#emit_signal("s_reload", reload_time)
		player_weapon.play("reload")
		reload_timer.start()
func _shoot():
	if second_fire and type_second_fire==0:
		player_weapon.play("fire_aiming")
	else:
		player_weapon.play("fire"+str(randi()%2+1))
	player_weapon.set_frame(0)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var tmp=preload("res://prefabs/player_demo/projectile.tscn").instance()
	tmp.translation=translation+Vector3(0,3.4,0)

	tmp.rotation.x=player_cam.rotation.x
	tmp.rotation.y=rotation.y
	tmp.id=bullet_id
	get_parent().add_child(tmp)
	
	_update_hud()
func _update_hud():
	emit_signal("s_ammo", bullet_count, ammo_weapon[current_weapon])

func _on_Timer_timeout():
	can_shoot = true
func _axis():
	var direction = Vector3()
	
	if Input.is_action_pressed("up"):
		direction -= get_global_transform().basis.z.normalized()
		
	if Input.is_action_pressed("down"):
		direction += get_global_transform().basis.z.normalized()
		
	if Input.is_action_pressed("left"):
		direction -= get_global_transform().basis.x.normalized()
		
	if Input.is_action_pressed("right"):
		direction += get_global_transform().basis.x.normalized()
		
	return direction.normalized()
func reset_anim():
	if second_fire and type_second_fire==0:
		player_weapon.play("aiming")
	else:
		player_weapon.play("wait")
func _on_weapon_animation_finished():
	reset_anim()


func _on_timer_reload_timeout():
	if reloading:
		reloading=false
		bullet_count = min(max_bullet,ammo_weapon[current_weapon])
		ammo_weapon[current_weapon]=max(0,ammo_weapon[current_weapon]-max_bullet)
		_update_hud()


func _on_anim_weapon_animation_finished(anim_name):
	can_shoot=true

func update_anim():
	player_weapon.set_sprite_frames(current_anim)
