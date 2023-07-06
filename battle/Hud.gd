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

func _on_magi2_mouse_entered():
	if !$magibuttons/magi2.disabled:
		$magibuttons/magi2/Magi2Lbl.add_color_override("font_color", Color(0,0,1))

func _on_magi2_mouse_exited():
	$magibuttons/magi2/Magi2Lbl.add_color_override("font_color", Color(1,1,1))

func _on_magi3_mouse_entered():
	if !$magibuttons/magi3.disabled:
		$magibuttons/magi3/Magi3Lbl.add_color_override("font_color", Color(0,0,1))

func _on_magi3_mouse_exited():
	$magibuttons/magi3/Magi3Lbl.add_color_override("font_color", Color(1,1,1))

func _on_magi4_mouse_entered():
	if !$magibuttons/magi4.disabled:
		$magibuttons/magi4/Magi4Lbl.add_color_override("font_color", Color(0,0,1))

func _on_magi4_mouse_exited():
	$magibuttons/magi4/Magi4Lbl.add_color_override("font_color", Color(1,1,1))
