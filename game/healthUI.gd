extends Control

var hearts = 100 setget set_hearts
var max_health = 110

onready var healthuifull = $healthUIFull

func set_hearts(value):
	hearts = clamp(value, 0, max_health)
	if healthuifull != null:
		healthuifull.rect_size.x = hearts/2

func _ready():
	max_health = Playerstats.max_health
	self.hearts = Playerstats.health
	Playerstats.connect("health_changed",self,"set_hearts")
	#Playerstats.connect("max_health_changed", self, "set_max_hearts")
