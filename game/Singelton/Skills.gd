extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var skill_data
# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://data/skills.json", File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	skill_data = json.result
	#print(skill_data)
