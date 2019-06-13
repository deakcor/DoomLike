extends KinematicBody

class_name Projectiles

var speed=100
var to
var dir
var id
var dmg
var to_destroy=false
var tireur

func _ready():
	var stat=bdd.bullets[id]
	speed=stat.speed
	$Timer.start(stat.time)
	dir=(to-translation).normalized()
	dmg=stat.dmg
	#dir=Vector3(-sin(rotation.y),tan(rotation.x),-cos(rotation.y))
	#translation+=dir*2
	$sprite.set_sprite_frames(stat.anim)
	$sprite.play("bullet")
	#set_collision_layer_bit(0,
	
func _physics_process(delta):
	if speed>0:
		if !to_destroy and !is_on_ceiling() and !is_on_wall() and !is_on_floor():
			move_and_slide(speed*dir.normalized(),Vector3(0,1,0))
		else:
			deleting()
	elif translation.distance_to(to)<abs(speed):
		translation=to
func deleting():
	to_destroy=true
		
	$sprite.play("hit")

func _on_Timer_timeout():
	queue_free()


func _on_Area_body_entered(body):
	if not to_destroy:
		if body is StaticBody:
			deleting()
		if body!=tireur:
			if body.is_in_group("ennemi"):
				deleting()
				body.dmg(dmg)
			if body.is_in_group("player"):
				deleting()
				body.dmg(dmg)
