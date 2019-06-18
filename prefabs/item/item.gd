extends Area

export var id=1
export var weapon=true

# Called when the node enters the scene tree for the first time.
func _ready():
	var stat=bdd.pickup[id]
	$Spatial/sprite.set_texture(stat.anim if weapon else stat.anim2)

func _on_item_body_entered(body):
	if body is Player and visible:
		body.add_ammo_weapon(id,weapon)
		visible=false
		$audio.playing=true
