extends Node2D


var outsidelocation: Vector2 = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	for house in self.get_children():
		house.connect("entering", self, "savinglocation")
		house.get_node("exithouse").connect("exiting", self, "loadinglocation")


func savinglocation():
	outsidelocation = $"../player".global_position

func loadinglocation():
	$"../player".global_position = outsidelocation
