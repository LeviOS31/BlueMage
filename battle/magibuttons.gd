extends Control

signal pressed(value)


func _on_magi1_pressed():
	emit_signal("pressed", $magi1/Magi1Lbl.text)

func _on_magi2_pressed():
	emit_signal("pressed", $magi2/Magi2Lbl.text)

func _on_magi3_pressed():
	emit_signal("pressed", $magi3/Magi3Lbl.text)

func _on_magi4_pressed():
	emit_signal("pressed", $magi4/Magi4Lbl.text)
