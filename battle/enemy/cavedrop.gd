extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maxhealth = 100
var health = 100
var maxmagi = 100
var magi = 100
var missC = 1.00
var DMGC = 1.00
var DFC = 1.00
var defence = 5
var weakness = "fire"
var chosen
var damage = 0
var duration = 0

# Called when the node enters the scene tree for the first time.
func start():
	randomize()
	$Sprite.scale = Vector2(2,2)
	position = position + Vector2(-5,-20)
	$AniPlayer.connect("animation_finished", self, "idle")

func choose(Phealth, turnnum):
	var num = randf() * 100
	if magi > Skills.skill_data.Harden.MagiCost && health < 60 && num < 50:
		return "status"
	else:
		return "attack"
		
func attack():
	return Skills.skill_data.Swing_arm;

func status():
	return Skills.skill_data.Harden;

func Attack():
	print(chosen)
	$AniPlayer.play(chosen.Animation)
	magi -= chosen.MagiCost
	if rand_range(0,100) < chosen.Hitprecentage:
		damage = chosen.Damage
	else:
		print("miss")
		damage = 0

func Status():
	print(chosen)
	$AniPlayer.play(chosen.Animation)
	magi -= chosen.MagiCost
	duration = chosen.Duration
	missC -= float(chosen.ModulateMiss) / 100.00
	DMGC += float(chosen.ModulateDMG) / 100.00
	DFC += float(chosen.ModulateDFN) / 100.00
	
func Duration():
	var previous = 0
	if duration != 0:
		previous = duration
		duration -= 1
	elif duration == 0 && previous != 0:
		missC += chosen.ModulateMiss / 100.00
		DMGC -= chosen.ModulateDMG / 100.00
		DFC -= chosen.ModulateDFN / 100.00

func idle(name):
	print("idle")
	$AniPlayer.play("idle_l")

