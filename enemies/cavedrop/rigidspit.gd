extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	yield(get_tree().create_timer(1), "timeout")
	print("aaa")
	$"../AniPlayer".play("Spit")
	yield($"../AniPlayer", "animation_finished")
	yield(get_tree().create_timer(1), "timeout")
	print("bbb")
	$"../AniPlayer".play("Spit")
	return

func move():
	mode = RigidBody2D.MODE_RIGID
	linear_velocity = Vector2(-100,-20)
	angular_velocity = -2
	print(sleeping)
	gravity_scale = 1
	

func reset():
	mode = RigidBody2D.MODE_STATIC
	translate()
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	gravity_scale = 0
