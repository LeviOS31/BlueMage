extends Control

var tilesize = Vector2(16, 16)
export var invsize = Vector2(8,8)
export var invalidcolor: Color = Color(1,0.36,0.36,0.5)
export var validcolor: Color = Color(1,1,1,1)
var selectedzindex: int = 100

var panel: ColorRect
var grids: Sprite
var inventory: Area2D

var selecteditem: Control
var itempreviewposition: Vector2

var Isitemselected: bool = false
var isdragging: bool = false
var isselecteditemininventory: bool = false

var overlappingitems: Array

func _ready():
	panel = get_node("Panel")
	grids = get_node("Grid")
	inventory = get_node("Grid/inventory")
	
	inventory.connect("area_entered", self, "itemininventory")
	inventory.connect("area_exited", self, "itemnotininventory")
	
	for ctrl_Item in get_tree().get_nodes_in_group("items"):
		add_signal_connections(ctrl_Item)

func _process(delta):
	if isdragging:
		selecteditem.rect_position = get_global_mouse_position()
	
	print(overlappingitems)

func add_signal_connections(ctrl_Item):
	ctrl_Item.connect("gui_input", self, "cursor_in_item", [ctrl_Item])
	ctrl_Item.get_node("Sprite/Area2D").connect("area_entered", self, "overlapping_with_item", [ctrl_Item])
	ctrl_Item.get_node("Sprite/Area2D").connect("area_exited", self, "not_overlapping_with_item", [ctrl_Item])

func cursor_in_item(event: InputEvent, ctrl_Item: Control):
	if event.is_action("select_item"):
		Isitemselected = true
		selecteditem = ctrl_Item
		selecteditem.get_node("Sprite").set_z_index(selectedzindex)
		itempreviewposition = selecteditem.rect_position
	
	if event is InputEventMouseMotion && Isitemselected == true:
		isdragging = true
	
	if event.is_action_released("select_item"):
		Isitemselected = false
		isdragging = false
		selecteditem.get_node("Sprite").set_z_index(0)
		selecteditem = null

func overlapping_with_item(area: Area2D, ctrl_Item: Control):
	if area.get_parent().get_parent() == selecteditem:
		return
	if area == inventory:
		return
		
	overlappingitems.append(ctrl_Item)
	
	if selecteditem:
		selecteditem.get_node("Sprite").modulate = invalidcolor

func not_overlapping_with_item(area: Area2D, ctrl_Item: Control):
	if area.get_parent().get_parent() == selecteditem:
		return
	if area == inventory:
		return
		
	overlappingitems.erase(ctrl_Item)
	
	if overlappingitems.size() == 0 && selecteditem:
		selecteditem.get_node("Sprite").modulate = validcolor

func itemininventory():
	isselecteditemininventory = true

func itemnotininventory():
	isselecteditemininventory = false
