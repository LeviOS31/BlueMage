extends Node2D

export(int) var wander_range = 20

onready var start_position = global_position
onready var target_position = global_position
onready var timer = $Timer

func update_target():
	var target_vector = Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
	target_position = start_position + target_vector

func get_time():
	return timer.time_left

func start_timer(duration):
	timer.start(duration)

func _on_Timer_timeout():
	update_target()
