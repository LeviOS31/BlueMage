extends Sprite

var item: String
var PCK_itemforinventory : PackedScene
var itemforinventory : Control 
var entered: bool = false
var inventory: Control
export var amountSestertii: int
export var amountDenarii: int
export var amountQuinarii: int

# Called when the node enters the scene tree for the first time.
func _ready():
	item = self.name
	inventory = $"../../CanvasLayer/Inventory"
	PCK_itemforinventory = load("res://inventoryitems/" + item + ".tscn");
	print(inventory)

func _input(event):
	if(event.is_action_pressed("Interact")):
		if(entered == true):
			itemforinventory = PCK_itemforinventory.instance()
			itemforinventory.CostSestertii = amountSestertii
			itemforinventory.CostDenarii = amountDenarii
			itemforinventory.CostQuinarii = amountQuinarii
			itemforinventory.shop = true
			
			inventory.get_node("Panel").add_child(itemforinventory)
			itemforinventory.rect_position.x = 169 - (itemforinventory.rect_size.x/2)
			itemforinventory.rect_position.y = 35
			
			inventory.visible = true
			inventory.get_node("shop").visible = true
			inventory.forshop = true

func _on_itemarea_area_entered(area):
	entered = true

func _on_itemarea_area_exited(area):
	entered = false
