extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_magi1_mouse_entered():
	if !$magibuttons/magi1.disabled:
		$magibuttons/magi1/Magi1Lbl.add_color_override("font_color", Color(0,0,1))


func _on_magi1_mouse_exited():
	$magibuttons/magi1/Magi1Lbl.add_color_override("font_color", Color(1,1,1))
