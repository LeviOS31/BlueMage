extends Node

var platform
onready var Newname : String
var Duration : int
var ModulateMiss : int
var ModulateDMG : int
var ModulateDFN : int

func _ready():
	name = Newname
	platform = get_parent().get_child(1)

func nextturn():
	if Duration == 0:
		var childcount = platform.get_child_count()
		platform.get_child(childcount-1).Endeffect(name)
		queue_free()
		return
	Duration -= 1
