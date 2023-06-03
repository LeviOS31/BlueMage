extends Node

class_name Defend

onready var block;
onready var blockchance;

func _init( B,  BC):
	block = B;
	blockchance = BC;

func calc():
	var random = randf()
	var num = random * 100
	if (num > 0 && num < blockchance):
		var blocked = rand_range(40, block)
		print("blocked: " + blocked)
		return blocked
	else:
		return 0
