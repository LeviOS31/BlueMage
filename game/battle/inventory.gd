extends Control

var inv_slot = preload("res://battle/item.tscn")

onready var grid = $N/items/Grid

func _ready():
	for i in Playerdata.inv_data.keys():
		var inv_slot_new = inv_slot.instance()
		grid.add_child(inv_slot_new, true)



