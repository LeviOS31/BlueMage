extends KinematicBody2D

var max_speed = 10
var speed = Vector2.ZERO
var acceleration = 5
onready var moving: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func moving():
	moving = true

func stopmoving():
	moving = false

func _physics_process(delta):
	if moving:
		speed = speed.move_toward(Vector2.RIGHT * max_speed, acceleration * delta)
		speed = move_and_slide(speed)
	else:
		position = Vector2(-11, -2)
		$Sprite.frame = 6
