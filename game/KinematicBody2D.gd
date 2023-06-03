extends KinematicBody2D

onready var animation = $AnimationPlayer
var max_speed = 100
var speed = Vector2.LEFT
var acceleration = 50
onready var delta2 = 0

func set_delta(delta):
	delta2 = delta

func move():
	speed = speed.move_toward(Vector2.LEFT * max_speed, acceleration * get_physics_process_delta_time())
	speed = move_and_slide(speed)
	animation.play("run")
