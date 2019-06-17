extends Area

export var id=1
export var weapon=true

# Called when the node enters the scene tree for the first time.
func _ready():
	var stat=bdd.pickup[id]
	$Spatial/sprite.set_texture(stat.anim)

func _on_item_body_entered(body):
	if body is Player:
		body.add_ammo_weapon(id,weapon)
		queue_free()
