extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


func _on_attack_pressed():
	self.visible = false;
	$"../attackbuttons".visible = true;


func _on_magi_pressed():
	self.visible = false;
	$"../magibuttons".visible = true;

func _on_inventory_pressed():
	self.visible = false;
	$"../inventory".visible = true;

func _on_flee_pressed():
	if randf() < 0.3:
		get_tree().change_scene(Global.currentlevel)
