extends Node


var item_data = {}

func _ready():
	var file = File.new()
	file.open("res://data/itemData - Sheet1.json", File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	item_data = json.result
