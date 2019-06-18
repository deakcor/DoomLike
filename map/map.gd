extends StaticBody

onready var map=$MAP01

var player:Player
# Called when the node enters the scene tree for the first time.
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
