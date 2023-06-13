extends Area2D

signal tran

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if $"../../transitionscene/Timer".time_left < 0.1 && $"../../transitionscene/Timer".time_left > 0.00001:
		emit_signal("tran")

func _on_Leave_area_entered(area):
		$"../../transitionscene".transition_to_black()
		yield(self, "tran")
		Global.playerlocation = null
		Coordinates.City1Coord = $"../player".position
		get_tree().change_scene("res://worlds/"+self.name+".tscn")
