extends Node

var health: int = 100
var maxhealth: int = 100
var maxmagi: int = 100
var defence: int = 10
var weakness: String = "Poison"

export var Sestertii: int = 10
export var Denarii: int = 10
export var Quinarii: int = 10

var inv_data: Dictionary = {}
var skills: Dictionary = {}
var inventory: Dictionary = {} #"Sword":["res://inventoryitems/Sword.tscn", Vector2(2,0)]

func _ready():
	var file = File.new()
	file.open("res://data/inv_data_file.json", File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	inv_data = json.result
	skills["Fireball"] = Skills.skill_data.Fireball;
