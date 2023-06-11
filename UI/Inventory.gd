extends Control

var tilesize = Vector2(16, 16)
export var invsize = Vector2(6,7)
export var invalidcolor: Color = Color(1,0.36,0.36,0.5)
export var validcolor: Color = Color(1,1,1,1)
var selectedzindex: int = 100
var cursoritemfoffset: Vector2 = Vector2(-8, -8)
var invposition: Vector2

var panel: ColorRect
var grids: Sprite
var inventory: Area2D

var selecteditem: Control
var itemprevposition: Vector2

var Isitemselected: bool = false
var isdragging: bool = false
var isselecteditemininventory: bool = false

var overlappingitems: Array
var inventoryitems: Dictionary
var inventoryitemsslots: Dictionary

func _ready():
	panel = get_node("Panel")
	grids = get_node("Grid")
	inventory = get_node("Grid/inventory")
	
	inventory.connect("area_entered", self, "itemininventory")
	inventory.connect("area_exited", self, "itemnotininventory")
	
	invposition = $Panel.rect_global_position
	
	for ctrl_Item in get_tree().get_nodes_in_group("items"):
		add_signal_connections(ctrl_Item)

func _process(delta):
	if isdragging:
		var movement: Vector2 = (get_global_mouse_position() + cursoritemfoffset - invposition)
		if isselecteditemininventory:
			selecteditem.rect_position = movement.snapped(tilesize)
		else:
			selecteditem.rect_position =  movement

func add_signal_connections(ctrl_Item):
	ctrl_Item.connect("gui_input", self, "cursor_in_item", [ctrl_Item])
	ctrl_Item.get_node("Sprite/Area2D").connect("area_entered", self, "overlapping_with_item", [ctrl_Item])
	ctrl_Item.get_node("Sprite/Area2D").connect("area_exited", self, "not_overlapping_with_item", [ctrl_Item])

func _input(event):
	if event.is_action_pressed("Inventory"):
		visible = !visible

func cursor_in_item(event: InputEvent, ctrl_Item: Control):
	if event.is_action_pressed("select_item"):
		Isitemselected = true
		selecteditem = ctrl_Item
		selecteditem.get_node("Sprite").set_z_index(selectedzindex)
		itemprevposition = selecteditem.rect_global_position
		if (selecteditem.rect_position > panel.rect_size || selecteditem.rect_position < Vector2(0,0)):
			isselecteditemininventory = false
		else:
			isselecteditemininventory = true

	if event is InputEventMouseMotion && Isitemselected == true:
		isdragging = true
	
	if event.is_action_released("select_item"):
		if overlappingitems.size() > 0:
			selecteditem.rect_global_position = itemprevposition
			selecteditem.get_node("Sprite").modulate = validcolor
		else:
			if isselecteditemininventory:
				if !add_item_to_inventory(selecteditem):
					selecteditem.rect_global_position = itemprevposition
					
					
		Isitemselected = false
		isdragging = false
		selecteditem.get_node("Sprite").set_z_index(1)
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

func itemininventory(area: Area2D):
	isselecteditemininventory = true

func itemnotininventory(area: Area2D):
	isselecteditemininventory = false

func add_item_to_inventory(selecteditem: Control) -> bool:
	var slotid: Vector2 = selecteditem.rect_position / tilesize
	var itemsize: Vector2 = selecteditem.rect_size / tilesize
	
	print(selecteditem.rect_size)
	
	var itemmaxslotID : Vector2 = slotid + itemsize - Vector2(1,1);
	var inventoryslotboundsBottomRight: Vector2 = invsize;
	var inventoryslotboundsTopLeft: Vector2 = Vector2(0,0);
	
	print(slotid)
	print(itemsize)
	print(itemmaxslotID)
	
	if itemmaxslotID.x > inventoryslotboundsBottomRight.x:
		return false
	
	if itemmaxslotID.x < inventoryslotboundsTopLeft.x:
		return false
	
	if itemmaxslotID.y > inventoryslotboundsBottomRight.y:
		return false
	
	if itemmaxslotID.y < inventoryslotboundsTopLeft.y:
		return false
	
	if inventoryitems.has(selecteditem):
		remove_item_in_inventory(selecteditem, inventoryitems[selecteditem])
	
	for Y_ctr in range(itemsize.y):
		for X_ctr in range(itemsize.x):
			inventoryitemsslots[Vector2(slotid.x + X_ctr, slotid.y + Y_ctr)] = selecteditem
	
	inventoryitems[selecteditem] = slotid
	return true


func remove_item_in_inventory(selecteditem: Control, slot: Vector2):
	var itemsize: Vector2 = selecteditem.rect_size / tilesize
	
	for Y_ctr in range(itemsize.y):
		for X_ctr in range(itemsize.x):
			if inventoryitemsslots.has(Vector2(slot.x + X_ctr, slot.y + Y_ctr)):
				inventoryitemsslots.erase(Vector2(slot.x + X_ctr, slot.y + Y_ctr))
	
