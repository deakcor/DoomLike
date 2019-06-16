extends Area

export var id=1
export var weapon=true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_item_body_entered(body):
	if body is Player:
		body.add_ammo_weapon(id,weapon)
		queue_free()
