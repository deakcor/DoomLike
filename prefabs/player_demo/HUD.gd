extends Control

onready var ammo_label = $VBoxContainer/AmmoLabel
onready var ammo_max_label = $VBoxContainer/maxammolabel
onready var hud_tween = $VBoxContainer/Tween

func _ready():
	
	ammo_label.text = str("Ammo: ", get_parent().max_bullet)


func _on_Player_s_ammo(b_count,b_max):
	ammo_label.text = str("Ammo: ", b_count)
	ammo_max_label.text=str(b_max)

