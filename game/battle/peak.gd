extends Camera2D

func _input(event):
	if event is InputEventMouseMotion:
		self.position = get_global_mouse_position() / 40
