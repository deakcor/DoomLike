extends KinematicBody

class_name Ennemi


var nav:Navigation
var player
var begin = Vector3()
var end = Vector3()
var path:Array
var fire=false
export var id=0

var cadence=0.5
var vie=3
var speed=10
var idbullet=3
# Called when the node enters the scene tree for the first time.
func _ready():
	nav=get_tree().get_nodes_in_group("nav").front()
	player=get_tree().get_nodes_in_group("player").front()
	init()
	$Timer.wait_time=cadence

	set_process(false)
func init():
	var stat=bdd.ennemis[id]
	cadence=stat.cadence
	speed=stat.speed
	idbullet=stat.idbullet
	vie=stat.vie
	$detect_area/CollisionShape.get_shape().radius=stat.detect_area
	$atk_area/CollisionShape.get_shape().radius=stat.atk_area
	$sprite.set_sprite_frames(stat.anim)
	$sprite.play("idle")
func _update_path():
	if vie>0:
		$sprite.play("idle")
		begin = nav.get_closest_point(translation)
		end = nav.get_closest_point(player.translation)
		var p = nav.get_simple_path(begin, end, true)
		path = Array(p) # Vector3array too complex to use, convert to regular array
		path.invert()
		set_process(true)

func _process(delta):
	if path.size() > 1:
		var to_walk = delta * speed
		var to_watch = Vector3(0, 1, 0)
		while to_walk > 0 and path.size() >= 2:
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			to_watch = (pto - pfrom).normalized()
			var d = pfrom.distance_to(pto)
			if d <= to_walk:
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
		
		var atpos = path[path.size() - 1]
		var atdir = to_watch
		atdir.y = 0
		
		var t = Transform()
		t.origin = atpos
		t = t.looking_at(atpos + atdir, Vector3(0, 1, 0))
		set_transform(t)
		
		if path.size() < 2:
			path = []
			set_process(false)
			_update_path()
	else:
		set_process(false)
		_update_path()

func dmg(degat:int):
	if vie>0:
		vie=max(0,vie-degat)
		$AnimationPlayer.play("dmg")
		if vie==0:
			$AnimationPlayer.play("destroy",0.5,0.01)
			$Timer.stop()
			set_process(false)
			$CollisionShape.disabled=true
			$sprite.play("death"+str(randi()%2+1))

func _on_Area_body_entered(body):
	if vie>0:
		if body is Player:
			set_process(false)
			$Timer.start()
			$sprite.play("atk")
			fire=true

func _shoot():
	var tmp=preload("res://prefabs/player_demo/projectile.tscn").instance()
	tmp.translation=translation+Vector3(0,3,0)
	tmp.id=idbullet
	tmp.to=player.translation+Vector3(0,3,0)
	tmp.tireur=self
	get_parent().add_child(tmp)


func _on_Area_body_exited(body):
	if vie>0:
		if body is Player:
			
			fire=false
			

func _on_Timer_timeout():
	
	_shoot()
	if not fire:
		_update_path()
		$Timer.stop()


func _on_detect_area_body_entered(body):
	if vie>0:
		if body is Player:
			_update_path()


func _on_detect_area_body_exited(body):
	if vie>0:
		if body is Player:
			set_process(false)
func _physics_process(delta):
	var h=$sprite.frames.get_frame($sprite.get_animation(),$sprite.get_frame()).get_height()/2
	$sprite.translation.y=h*0.07
