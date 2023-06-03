extends Node

class_name Magi 

onready var high
onready var low
onready var critdamage
onready var damage
onready var crit
onready var miss
onready var Mname : String
onready var Effect : String
onready var Duration : int
onready var Type : int

func _init(Name, effect):
	Effect = effect
	Mname = Name

func calc():
	var random = randf()
	var num = random * 100
	if (num > 0 && num < miss):
		return 0
	else:
		if (critchance()):
			damage = random.Next(low, high) * critdamage;
			print("damage: " + damage)
			return damage
		
		else:
			damage = random.Next(low, high)
			print("damage: " + damage)
			return damage
		

func critchance():
	var random = randf()
	var num = random * 100
	if (num > 0 && num < crit):
		return true
	else:
		return false
