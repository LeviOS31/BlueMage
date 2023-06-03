extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#
#
## Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("attack")
#	$AnimationPlayer2.play("roll_right")
#	$AnimationPlayer3.play("roll_up")
#	$AnimationPlayer4.play("roll_down")
#
