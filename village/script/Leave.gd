extends Area2D



func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Leave_area_entered(area):
		$"../../transitionscene".transition_to_black()
		yield(self, "tran")
		Global.playerlocation = null
		Coordinates.VillageCoord = $"../player".position
		get_tree().change_scene("res://worlds/"+self.name+".tscn")
