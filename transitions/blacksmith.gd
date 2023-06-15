extends Area2D

signal entering
var entered: bool = false

func _ready():
	pass # Replace with function body.


func _input(event):
	if(event.is_action_pressed("Interact")):
		if(entered == true):
			emit_signal("entering");
			$"../../player".global_position = $exithouse.global_position;



func _on_Blacksmith_area_entered(area):
	entered = true
	print("entered")


func _on_Blacksmith_area_exited(area):
	entered = false
	print("exited")
