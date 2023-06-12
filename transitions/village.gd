extends Area2D

signal tran

var minimap_icon = "village"
var entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if $"../../transitionscene/Timer".time_left < 0.1 && $"../../transitionscene/Timer".time_left > 0.00001:
		emit_signal("tran")

func _input(event):
	if(event.is_action_pressed("Interact")):
		if(entered == true):
			$"../../transitionscene".transition_to_black()
			yield(self, "tran")
			Global.playerlocation = null
			Coordinates.WorldCoord = $"../player".position
			get_tree().change_scene("res://worlds/"+self.name+".tscn")

func _on_village_Kald_area_entered(area):
	entered = true


func _on_village_Kald_area_exited(area):
	entered = false




