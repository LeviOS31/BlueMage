extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maxhealth = 100
var health = 100
var maxmagi = 100
var magi = 100
var missC : float = 1.00
var DMGC = 1.00
var DFC = 1.00
var defence = 5
var weakness = "fire"
var chosen
var damage = 0
var duration = 0

var MinSestertii : int = 0
var MinDenarii : int = 0
var MinQuinarii : int = 4

var MaxSestertii : int = 0
var MaxDenarii : int = 1
var MaxQuinarii : int = 14

var spitload

# Called when the node enters the scene tree for the first time.
func start():
	randomize()
	spitload = load("res://enemies/cavedrop/test/spit_rigid.tscn")
	self.position = position + Vector2(-5,-20)
	$AniPlayer.connect("animation_finished", self, "idle")

func choose(Phealth, turnnum):
	var num = randf() * 100
	if magi > Skills.skill_data.Harden.MagiCost && health < 60 && num < 50:
		return "status"
	else:
		return "attack"
		
func attack():
	var num = randf() * 100
	if num < 20:
		return Skills.skill_data.Spit;
	else:
		return Skills.skill_data.Swing_arm;

func status():
	return Skills.skill_data.Harden;

func Attack():
	print(chosen)
	$AniPlayer.play(chosen.Animation)
	magi -= chosen.MagiCost

	for effect in $"../../effects".get_children():
		missC += (effect.ModulateMiss / 100)
	
	if rand_range(0,100) < (chosen.Hitprecentage * missC):
		damage = chosen.Damage
	else:
		print("miss")
		damage = 0

func Status():
	print(chosen)
	$AniPlayer.play(chosen.Animation)
	magi -= chosen.MagiCost

func Endeffect(effectname: String):
	pass

func idle(name):
	print("idle")
	$AniPlayer.play("idle_l")

func spit():
	var spitinstance = spitload.instance()
	add_child(spitinstance)
	print("test")
