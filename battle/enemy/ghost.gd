extends Node2D

var maxhealth = 100
var health = 100
var maxmagi = 100
var magi = 100
var missC : float = 1.00
var DMGC = 1.00
var DFC = 1.00
var defence = 5
var weakness = "water"
var chosen
var damage = 0
var purple = false
var duration = 0

var MinSestertii : int = 0
var MinDenarii : int = 0
var MinQuinarii : int = 3

var MaxSestertii : int = 0
var MaxDenarii : int = 0
var MaxQuinarii : int = 6

# Called when the node enters the scene tree for the first time.
func start():
	$AniPlayer.connect("animation_finished", self, "idle")

func choose(Phealth, turnnum):
	var num = randf() * 100
	if Phealth - 10 > num && !purple && turnnum > 1 && magi > Skills.skill_data.Change_state.MagiCost:
		return "status"
	else:
		return "attack"
		
func attack():
	if magi > Skills.skill_data.Ghost_magi.MagiCost && (Playerdata.weakness == Skills.skill_data.Ghost_magi.Weakness || (int(Skills.skill_data.Ghost_magi.Damage) % int(Playerdata.health)) == 0):
		return Skills.skill_data.Ghost_magi;
	else :
		return Skills.skill_data.Ghost_push;
	

func status():
	return Skills.skill_data.Change_state;

func Attack():
	randomize()
	print(chosen)
	if purple:
		$AniPlayer.play(chosen.Animation + "_purple")
	else:
		$AniPlayer.play(chosen.Animation + "_white")
	magi -= chosen.MagiCost
	
	for effect in $"../../effects".get_children():
		missC += (effect.ModulateMiss / 100)
	
	if rand_range(0,100) < (chosen.Hitprecentage * missC):
		damage = chosen.Damage
	else:
		print("miss")
		damage = 0
	
	missC = 1.00

func Status():
	print(chosen)
	purple = true
	$AniPlayer.play(chosen.Animation)
	magi -= chosen.MagiCost

func Endeffect(effectname: String):
	if name == "Enhance":
		purple = false
		$AniPlayer.play("Purple_to_white")
		yield($AniPlayer, "animation_finished")

func idle(name):
	print("idle")
	if purple:
		$AniPlayer.play("idle_purple")
	else:
		$AniPlayer.play("idle_white_r")

func death():
	$AniPlayer.play("death")
	yield($AniPlayer, "animation_finished")

