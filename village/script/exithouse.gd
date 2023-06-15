extends Area2D

signal exiting
var entered: bool = false

func _input(event):
	if(event.is_action_pressed("Interact")):
		if(entered == true):
			emit_signal("exiting")



func _on_exithouse_area_entered(area):
	entered = true


func _on_exithouse_area_exited(area):
	entered = false
