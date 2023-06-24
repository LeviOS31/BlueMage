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
onready var buttons = $Camera2D/Hud/magibuttons
onready var damagenumbers = preload("res://battle/scripts/number.tscn")

func _ready():
	randomize()
	if Global.enemy != null:
		var instance = load(Global.enemy)
		enemy = instance.instance()
		$enemycontrol/enemyplatform.add_child(enemy)
		enemy.battle()
		#enemy.position = Vector2(76,2)
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
		var newdamage = (player.damage * player.DMGC) / 100 * (100 - (enemy.defence * enemy.DFC))
		print(newdamage)
		enemy.health -= newdamage
		print(enemy.health)
		$Camera2D/Hud/HudBlueBanner/battletext.text = "You used " + player.chosen.Display_Name + " and dealt " + str(newdamage) + " damage"
		$enemycontrol/enemyplatform/enemyhealth.value = enemy.health

		var num = damagenumbers.instance()
		enemy.add_child(num)
		num.get_node("Label").text = str(newdamage)
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
		var newdamage2 = (enemy.damage * enemy.DMGC) / 100 * (100 - (Playerdata.defence * player.DFC))
		print(newdamage2)
		Playerdata.health -= newdamage2
		print(Playerdata.health)
		$playercontrol/playerplatform/playerhealth.value = Playerdata.health
		
		$Camera2D/Hud/HudBlueBanner/battletext.text = "The enemy used " + enemy.chosen.Display_Name + " and dealt " + str(newdamage2) + " damage"
		
		var num2 = damagenumbers.instance()
		player.add_child(num2)
		num2.get_node("Label").text = str(newdamage2)
				
	$enemycontrol/enemyplatform/enemymagi.value = enemy.magi
	enemy.Duration()
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


func _on_magi1_pressed(extra_arg_0):
	var button = get_node(extra_arg_0) 
	print("player")
	if state == Tplayer:
		player.chosen = Playerdata.skills[button.get_child(0).text]
		emit_signal("enemyturn");
		
