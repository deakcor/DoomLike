extends KinematicBody

class_name Projectiles

var speed=100
var to
var dir
var id
var to_destroy=false
func _ready():
	var stat=bdd.bullets[id]
	speed=stat.speed
	$Timer.start(stat.time)
	dir=Vector3(-sin(rotation.y),tan(rotation.x),-cos(rotation.y))
	#translation+=dir*2
	$sprite.set_sprite_frames(stat.anim)
	$sprite.play("bullet")
	
func _physics_process(delta):
	if speed>0:
		if !to_destroy and !is_on_ceiling() and !is_on_wall() and !is_on_floor():
			move_and_slide(speed*dir.normalized(),Vector3(0,1,0))
		else:
			deleting()
	elif translation.distance_to(to)<abs(speed):
		translation=to
		deleting()
func deleting():
	to_destroy=true
		
	$sprite.play("hit")

func _on_Timer_timeout():
	queue_free()


func _on_Area_body_entered(body):
	if body is StaticBody:
		deleting()
