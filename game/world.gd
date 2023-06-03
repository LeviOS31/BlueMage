extends Node2D

var map = false

func _ready():
	Engine.set_target_fps(60)
	$transitionscene.transition_to_normal()
	if Global.playerlocation != null:
		$YSort/player.position = Global.playerlocation
	if Global.battlefinish:
		print(Global.enemytoremove)
		get_node(Global.enemytoremove).queue_free()
		Global.battlefinish = false
	#print(filename)
	Global.currentlevel = filename

func _input(event):
	if Input.is_key_pressed(KEY_M):
		if !map:
			print("open map")
			$playercam.set_zoom(Vector2(8.5,11))
			$playercam.position = Vector2(715,254)
			map = true
		else:
			map = false
