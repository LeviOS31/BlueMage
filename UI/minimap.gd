extends Control

export (NodePath) var player
export var zoom = 1.5

onready var grid = $MarginContainer/grid
onready var playerM = $MarginContainer/grid/player
onready var caveM = $MarginContainer/grid/cave
onready var villageM = $MarginContainer/grid/village
onready var anchorM = $MarginContainer/grid/anchor

onready var icons = {"cave":caveM, "village":villageM, "anchor":anchorM}

var grid_scale
var marker = {}
var num = 0

func _ready():
	playerM.position = grid.rect_size / 2
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)
	var map_objects = get_tree().get_nodes_in_group("minimap_objects")
	for item in map_objects:
		var new_marker = icons[item.minimap_icon].duplicate()
		grid.add_child(new_marker)
		new_marker.show()
		marker[item] = new_marker

func _process(delta):
	if !player:
		return
	for item in marker:
		if item.name != "mapanchor":
			var obj_pos = (item.position - get_node(player).position) * grid_scale + grid.rect_size / 2
			if obj_pos.x > 60 || obj_pos.x < -60 || obj_pos.y > 60 || obj_pos.y < -60:
				marker[item].visible = false
			else:
				marker[item].visible = true
			obj_pos.x = clamp(obj_pos.x , 0, grid.rect_size.x)
			obj_pos.y = clamp(obj_pos.y , 0, grid.rect_size.y)
			marker[item].position = obj_pos
		else:
			var obj_pos = (item.position - get_node(player).position) * grid_scale + grid.rect_size / 2
			marker[item].visible = false
			marker[item].position = obj_pos
			marker[item].scale = Vector2(2.1, 2.1)
