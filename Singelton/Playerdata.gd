extends Node

var health = 100
var maxhealth = 100
var maxmagi = 100
var defence = 10
var weakness = "Poison"
var coins = 0

var inv_data = {}
var skills = {}

func _ready():
	var file = File.new()
	file.open("res://data/inv_data_file.json", File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	inv_data = json.result
	skills["Fireball"] = Skills.skill_data.Fireball;
