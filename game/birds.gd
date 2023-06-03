extends KinematicBody2D

var max_speed = 10
var speed = Vector2.ZERO
var acceleration = 5

func move(delta):
	speed = speed.move_toward(Vector2.RIGHT * max_speed, acceleration * delta)
	speed = move_and_slide(speed)
