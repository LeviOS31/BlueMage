extends Node2D

signal tran

var outsidelocation: Vector2 = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	for house in self.get_children():
		house.connect("entering", self, "savinglocation")
		house.get_node("exithouse").connect("exiting", self, "loadinglocation")

func _physics_process(delta):
	if $"../../transitionscene/Timer".time_left < 0.1 && $"../../transitionscene/Timer".time_left > 0.00001:
		emit_signal("tran")

func savinglocation():
	outsidelocation = $"../player".global_position

func loadinglocation():
	
	$"../../transitionscene".transition_to_black()
	yield(self,"tran")
	$"../../playercam".smoothing_enabled = false
	yield(get_tree().create_timer(0.3), "timeout")
	$"../player".global_position = outsidelocation
	yield(get_tree().create_timer(0.1), "timeout")
	$"../../playercam".smoothing_enabled = true
	$"../../transitionscene".transition_to_normal()
