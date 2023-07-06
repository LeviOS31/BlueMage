extends Camera2D

func _ready():
	limit_left = $bottomleft.global_position.x
	limit_right = $topright.global_position.x
	limit_top = $topright.global_position.y
	limit_bottom = $bottomleft.global_position.y
