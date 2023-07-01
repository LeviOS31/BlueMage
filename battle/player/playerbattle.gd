extends Node2D

var chosen = ""
var missC = 1
var DMGC = 1
var DFC = 1
onready var magi = Playerdata.maxmagi
var damage = 0

func _ready():
	magi = Playerdata.maxmagi
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name != "idle":
		$AniPlayer.play("idle");

func Magi():
	randomize()
	print(chosen);
	$AniPlayer.play(chosen.Animation)
	print(chosen.Animation)
	magi -= chosen.MagiCost
	if rand_range(0,100) < chosen.Hitprecentage:
		damage = chosen.Damage
		print(chosen.Damage) 
	else:
		print("miss")
		damage = 0

func Status():
	pass

func Attack():
	pass
