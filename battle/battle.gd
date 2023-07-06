extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal playerturn
signal enemyturn
signal execute

enum{
	Tplayer,
	Tenemy,
	Texecute
}

var turns = 0 
var state
var enemy
onready var player = $playercontrol/playerplatform/player
onready var playereffects = $playercontrol/effects
onready var buttons = $Camera2D/Hud/magibuttons
onready var enemyeffects = $enemycontrol/effects
onready var damagenumbers = preload("res://battle/scripts/number.tscn")
onready var Default_effect_load = preload("res://battle/statuseffects/default_effect.tscn")

func _ready():
	$Camera2D/Hud/magibuttons.connect("pressed", self, "_on_magi_pressed")
	randomize()
	if Global.enemy != null:
		var instance = load(Global.enemy)
		enemy = instance.instance()
		$enemycontrol/enemyplatform.add_child(enemy)
		enemy.battle()
		enemy.position = Vector2(0,10)
		enemy.scale = Vector2(1.5,1.5)
		enemy.start()
	var i = 1;
	print(Playerdata.skills);
	for skill in Playerdata.skills.values():
		var child = buttons.get_child(i)
		child.get_child(0).text = skill.Display_Name
		i += 1
	connect("playerturn", self, "turn")
	connect("enemyturn", self, "enemy")
	connect("execute", self, "execute_turn")
	emit_signal("playerturn");

func turn():
	state = Tplayer;
	for member in get_tree().get_nodes_in_group("Button"):
		member.disabled = false
		if member.get_child_count() > 0:
			if member.get_child(0).text == "":
				member.disabled = true
	
func enemy():
	print("enemy")
	state = Tenemy
	for member in get_tree().get_nodes_in_group("Button"):
		member.disabled = true;
	var chose = enemy.choose(Playerdata.health, turns)
	match chose:
		"attack":
			enemy.chosen = enemy.attack()
		"status":
			enemy.chosen = enemy.status()
	emit_signal("execute")
	
func execute_turn():
	print("execute")
	for child in playereffects.get_children():
		child.nextturn()
	
	state = Texecute
	match player.chosen.Type:
		"ATTACK":
			player.Attack()
			yield($playercontrol/playerplatform/player/AniPlayer, "animation_finished")
			var num = damagenumbers.instance()
			enemy.add_child(num)
			num.get_node("Label").text = str(player.damage)

		"MAGI":
			player.Magi()
			if player.damage == 0:
				$Camera2D/Hud/HudBlueBanner/battletext.text = "You used " + player.chosen.Display_Name + " and missed"
			
			yield($playercontrol/playerplatform/player/AniPlayer, "animation_finished")

		"STATUS":
			player.Status()
			yield($playercontrol/playerplatform/player/AniPlayer, "animation_finished")

	if player.damage > 0:
		print(enemy.health)

		var DamageMod : float = player.DMGC
		var DefenceMod : float = enemy.DFC

		for child in playereffects.get_children():
			DamageMod += (child.ModulateDMG / 100)

		for child in enemyeffects.get_children():
			DefenceMod += (child.ModulateDFN / 100)

		var newdamage = (player.damage * DamageMod) / 100 * (100 - (enemy.defence * DefenceMod))
		print(newdamage)
		enemy.health -= newdamage
		print(enemy.health)
		$Camera2D/Hud/HudBlueBanner/battletext.text = "You used " + player.chosen.Display_Name + " and dealt " + str(newdamage) + " damage"
		$enemycontrol/enemyplatform/enemyhealth.value = enemy.health
		var num = damagenumbers.instance()
		enemy.add_child(num)
		num.get_node("Label").text = str(newdamage)

	if player.chosen.SModulateMiss > 0 || player.chosen.SModulateDMG > 0 || player.chosen.SModulateDFN > 0:
		var effect = Default_effect_load.instance()
		effect.Newname = player.chosen.Display_Name
		effect.Duration = player.chosen.Duration
		effect.ModulateMiss = player.chosen.SModulateMiss
		effect.ModulateDMG = player.chosen.SModulateDMG
		effect.ModulateDFN = player.chosen.SModulateDFN
		playereffects.add_child(effect)

	if player.chosen.EModulateMiss != 0 || player.chosen.EModulateDMG != 0 || player.chosen.EModulateDFN != 0:
		var effect = Default_effect_load.instance()
		effect.Newname = player.chosen.Display_Name
		effect.Duration = player.chosen.Duration
		effect.ModulateMiss = player.chosen.EModulateMiss
		effect.ModulateDMG = player.chosen.EModulateDMG
		effect.ModulateDFN = player.chosen.EModulateDFN
		enemyeffects.add_child(effect)
	
	
	$playercontrol/playerplatform/playermagi.value = player.magi
	print(0)
	$TurnTimer.start(1)
	yield($TurnTimer, "timeout")
	print(1)
	$TurnTimer.start(1)
	yield($TurnTimer, "timeout")
	print(2)
	
	if enemy.health < 1:
		battleend()
		return
	
	for child in enemyeffects.get_children():
		child.nextturn()
	
	match enemy.chosen.Type:
		"ATTACK":
			enemy.Attack()
			print(Playerdata.health)
			yield(enemy.get_node("AniPlayer"), "animation_finished")
			if enemy.damage == 0:
				$Camera2D/Hud/HudBlueBanner/battletext.text = "The enemy used " + enemy.chosen.Display_Name + " and missed"
		"STATUS":
			enemy.Status()
			$Camera2D/Hud/HudBlueBanner/battletext.text = "The enemy used " + enemy.chosen.Display_Name
			yield(enemy.get_node("AniPlayer"), "animation_finished")

	if enemy.damage > 0:
		print(Playerdata.health)

		var DamageMod : float = enemy.DMGC
		var DefenceMod : float = player.DFC

		for child in enemyeffects.get_children():
			DamageMod += (child.ModulateDMG / 100)

		for child in playereffects.get_children():
			DefenceMod += (child.ModulateDFN / 100)

		var newdamage2 = (enemy.damage * DamageMod) / 100 * (100 - (Playerdata.defence * DefenceMod))
		print(newdamage2)
		Playerdata.health -= newdamage2
		print(Playerdata.health)
		$playercontrol/playerplatform/playerhealth.value = Playerdata.health
		
		$Camera2D/Hud/HudBlueBanner/battletext.text = "The enemy used " + enemy.chosen.Display_Name + " and dealt " + str(newdamage2) + " damage"
		
		var num2 = damagenumbers.instance()
		player.add_child(num2)
		num2.get_node("Label").text = str(newdamage2)

	if enemy.chosen.SModulateMiss > 0 || enemy.chosen.SModulateDMG > 0 || enemy.chosen.SModulateDFN > 0:
		var effect = Default_effect_load.instance()
		effect.Newname = enemy.chosen.Display_Name
		effect.Duration = enemy.chosen.Duration
		effect.ModulateMiss = enemy.chosen.SModulateMiss
		effect.ModulateDMG = enemy.chosen.SModulateDMG
		effect.ModulateDFN = enemy.chosen.SModulateDFN
		enemyeffects.add_child(effect)

	if enemy.chosen.EModulateMiss != 0 || enemy.chosen.EModulateDMG != 0 || enemy.chosen.EModulateDFN != 0:
		var effect = Default_effect_load.instance()
		effect.Newname = enemy.chosen.Display_Name
		effect.Duration = enemy.chosen.Duration
		effect.ModulateMiss = enemy.chosen.EModulateMiss
		effect.ModulateDMG = enemy.chosen.EModulateDMG
		effect.ModulateDFN = enemy.chosen.EModulateDFN
		playereffects.add_child(effect)
	
	$enemycontrol/enemyplatform/enemymagi.value = enemy.magi
	turns += 1
	player.damage = 0
	enemy.damage = 0
	print(0)
	$TurnTimer.start(1)
	yield($TurnTimer, "timeout")
	print(1)
	$TurnTimer.start(1)
	yield($TurnTimer, "timeout")
	print(2)
	
	emit_signal("playerturn")
	

func battleend():
		Global.battlefinish = true
		
		var gainedSestertii = round(rand_range(enemy.MinSestertii, enemy.MaxSestertii))
		var gainedDenarii = round(rand_range(enemy.MinDenarii, enemy.MaxDenarii))
		var gainedQuinarii = round(rand_range(enemy.MinQuinarii, enemy.MaxQuinarii))
		
		$Camera2D/Hud/HudBlueBanner/battletext.text = "You won the battle and gained " + str(gainedSestertii) + " Sesterii, " + str(gainedDenarii) + " Denarii, " + str(gainedQuinarii) + " Quinarii"
		
		Playerdata.Sestertii += gainedSestertii
		Playerdata.Denarii += gainedDenarii
		Playerdata.Quinarii += gainedQuinarii
		
		$TurnTimer.start(3)
		yield($TurnTimer, "timeout")
		
		#enemy.death()
		get_tree().change_scene(Global.currentlevel)

func _on_starttimer_timeout():
	$start.play("load");

func _on_magi_pressed(attack):
	print("player")
	if state == Tplayer:
		player.chosen = Playerdata.skills[attack]
		emit_signal("enemyturn");
