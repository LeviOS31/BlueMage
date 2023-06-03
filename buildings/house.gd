extends KinematicBody2D


var location: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	location = $"../Position2D".global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
