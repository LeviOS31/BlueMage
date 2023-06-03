extends Node

class_name Attack

onready var high;
onready var low;
onready var critdamage;
onready var damage;
onready var crit;
onready var miss;
onready var Aname;

func _init(H, L, CD, C, M, Name):
	high = H
	low = L
	critdamage = CD
	crit = C
	miss = M
	Aname = Name

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
