extends Node2D

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


func _on_Leave_area_entered(area):
	pass # Replace with function body.
