extends KinematicBody2D

var max_speed = 25
var speed = Vector2.ZERO
var acceleration = 12

func move(delta):
	speed = speed.move_toward(Vector2.DOWN * max_speed, acceleration * delta)
	speed = move_and_slide(speed)
