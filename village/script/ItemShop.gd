extends Sprite


var item: String
var PCK_itemforinventory : PackedScene
var itemforinventory : Control 
var entered: bool = false
var inventory: Control

# Called when the node enters the scene tree for the first time.
func _ready():
	item = self.name
	inventory = $"../../CanvasLayer/Inventory"
	PCK_itemforinventory = load("res://inventoryitems/" + item + ".tscn");
	print(inventory)

func _input(event):
	if(event.is_action_pressed("Interact")):
		if(entered == true):
			inventory.visible = true
			itemforinventory = PCK_itemforinventory.instance()
			inventory.get_node("Panel").add_child(itemforinventory)
			itemforinventory.rect_position = Vector2(150, 20);


func _on_itemarea_area_entered(area):
	entered = true


func _on_itemarea_area_exited(area):
	entered = false
