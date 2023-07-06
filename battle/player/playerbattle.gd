extends Node2D

var chosen
var missC : float = 1.00
var DMGC = 1
var DFC = 1
var EDur
onready var magi = Playerdata.maxmagi
var damage = 0
var fireload
var duration = 0

func _ready():
	magi = Playerdata.maxmagi
	fireload = load("res://battle/player/attacks/fireball.tscn")
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name != "idle":
		$AniPlayer.play("idle");

func Magi():
	randomize()
	print(chosen);
	$AniPlayer.play(chosen.Animation)
	print(chosen.Animation)
	magi -= chosen.MagiCost
	
	for effect in $"../../effects".get_children():
		missC += (effect.ModulateMiss / 100)
	
	if rand_range(0,100) < (chosen.Hitprecentage * missC):
		damage = chosen.Damage
		print(chosen.Damage) 
	else:
		print("miss")
		damage = 0
	
	missC = 1.00

func Status():
	print(chosen)
	for effect in $"../../effects".get_children():
		missC += (effect.ModulateMiss / 100)
	
	$AniPlayer.play(chosen.Animation)
	magi -= chosen.MagiCost
	
	missC = 1.00

func Attack():
	
	print(chosen);
	$AniPlayer.play(chosen.Animation)
	print(chosen.Animation)
	
	for effect in $"../../effects".get_children():
		missC += (effect.ModulateMiss / 100)
	
	if rand_range(0,100) < (chosen.Hitprecentage * missC):
		damage = chosen.Damage
		print(chosen.Damage) 
	else:
		print("miss")
		damage = 0
	
	missC = 1.00

func Endeffect(effectname: String):
	pass

func _on_Area2D_body_entered(body):
	body.queue_free()
	
func fire():
	var fireinstance = fireload.instance()
	fireinstance.get_node("fireball").scale = Vector2(1.5,1.5)
	add_child(fireinstance)
	
