extends Node2D

const grasseffect = preload("res://grasseffect.tscn")

func grasseffect():
	var grassdied = grasseffect.instance()
	get_parent().add_child(grassdied)
	grassdied.position = position



func _on_hurtbox_area_entered(area):
	grasseffect()
	queue_free()
