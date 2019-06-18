extends StaticBody

onready var map=$MAP01

var player:Player
var doorplayer:bool=false
var wallplayer:bool=false
var wall2player:bool=false
func _ready():
	var count=map.get_surface_material_count()
	var mesh=map.get_mesh()
	for k in range(1,count-1):
		var mat=mesh.surface_get_material(k)
		mat.set_cull_mode(2)
		mat.set_roughness(1)
		mat.transmission_enabled=true
		mat.transmission=Color(1,1,1,1)


func _on_Area_body_entered(body):
	if body is Player:
		player=body
		$Timer.start()
		player.dmg(1)


func _on_Area_body_exited(body):
	if body is Player:
		player=null
		$Timer.stop()

func _on_Timer_timeout():
	if player!=null:
		player.dmg(1)

func _input(event):
	if event.is_action_pressed("action"):
		if doorplayer:
			$door/AnimationPlayer.play("door",1)
		elif wallplayer:
			$door/AnimationPlayer.play("wall",1)
		elif wall2player:
			$door/AnimationPlayer.play("wall2",1)
func _on_door_area_body_entered(body):
	if body is Player:
		doorplayer=true


func _on_door_area_body_exited(body):
	if body is Player:
		doorplayer=false


func _on_wall_area_body_entered(body):
	if body is Player:
		wallplayer=true


func _on_wall_area_body_exited(body):
	if body is Player:
		wallplayer=false


func _on_wall2_area_body_entered(body):
	if body is Player:
		wall2player=true


func _on_wall2_area_body_exited(body):
	if body is Player:
		wallplayer=false
