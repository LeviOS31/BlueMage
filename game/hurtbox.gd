extends Area2D

const hiteffect = preload("res://hiteffect.tscn")

var invincible = false setget set_invincible
onready var time = $Timer

signal invincible_start
signal invincible_stop

func set_invincible(value):
	invincible = value
	if  invincible == true:
		emit_signal("invincible_start")
	else:
		emit_signal("invincible_stop")
		
func start_invin(duration):
	self.invincible = true
	time.start(duration)

func create_hit_effect():
	var effect = hiteffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position


func _on_Timer_timeout():
	self.invincible = false


func _on_hurtbox_invincible_start():
	set_deferred("monitorable", false)


func _on_hurtbox_invincible_stop():
	monitorable = true
