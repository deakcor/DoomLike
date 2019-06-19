extends Area

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_key_body_entered(body):
	if body is Player and visible:
		body.havekey=true
		visible=false
		$audio_take.playing=true
