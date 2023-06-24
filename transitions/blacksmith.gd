extends Area2D

signal entering
signal tran
var entered: bool = false

func _ready():
	pass # Replace with function body.
	

func _physics_process(delta):
	if $"../../../transitionscene/Timer".time_left < 0.1 && $"../../../transitionscene/Timer".time_left > 0.00001:
		emit_signal("tran")
	
	if $"../../player".global_position.y < $CollisionShape2D.global_position.y:
		$Sprite.z_index = 1
	else:
		$Sprite.z_index = 0

func _input(event):
	if(event.is_action_pressed("Interact")):
		if(entered == true):
			emit_signal("entering");
			
			$"../../../transitionscene".transition_to_black()
			yield(self,"tran")
			$"../../../playercam".smoothing_enabled = false
			yield(get_tree().create_timer(0.3), "timeout")
			$"../../player".global_position = $exithouse.global_position;
			yield(get_tree().create_timer(0.1), "timeout")
			$"../../../playercam".smoothing_enabled = true
			$"../../../transitionscene".transition_to_normal()

func _on_Blacksmith_area_entered(area):
	entered = true
	print("entered")


func _on_Blacksmith_area_exited(area):
	entered = false
	print("exited")
	

