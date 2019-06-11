extends KinematicBody

var speed=100
var dir
var id
# Called when the node enters the scene tree for the first time.
func _ready():
	var stat=bdd.bullets[id]
	speed=stat.speed
	$Timer.start(stat.time)
	dir=Vector3(-sin(rotation.y),tan(rotation.x),-cos(rotation.y))
	translation+=dir*1.5
	
func _physics_process(delta):
	move_and_slide(speed*dir.normalized())


func _on_Timer_timeout():
	queue_free()
