extends Area2D

signal entering
signal transition

var entered: bool = false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if $"../../../transitionscene/Timer".time_left < 0.1 && $"../../../transitionscene/Timer".time_left > 0.00001:
		emit_signal("transition")

func _input(event):
	if(event.is_action_pressed("Interact")):
		if(entered == true):
			emit_signal("entering");
			$"../../../transitionscene".transition_to_black()
			yield(self, "transition")
			print("AAAAAA")
			$"../../player".global_position = $exithouse.global_position;
			$"../../../transitionscene/Timer".start(1)
			yield($"../../../transitionscene/Timer", "timeout")
			$"../../../transitionscene".transition_to_normal()
			

func _on_Blacksmith_area_entered(area):
	entered = true
	print("entered")


func _on_Blacksmith_area_exited(area):
	entered = false
	print("exited")
	

