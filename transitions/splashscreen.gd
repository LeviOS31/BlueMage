extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer = 0
var blink = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$transitionscene.transition_to_normal()
	$Timer.start(5)

func _on_Timer_timeout():
	if timer == 0:
		$transitionscene.transition_to_black()
	timer += 1;
	$Timer.start(2)

func _process(delta):
	if timer == 2:
		pass
		get_tree().change_scene("res://menu.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):
	$ColorRect/LOGO.animation = "blink"
	blink +=1

func _on_LOGO_animation_finished():
	if blink == 1:
		print("test1")
		yield(get_tree().create_timer(1), "timeout")
		print("test2")
		$ColorRect/LOGO.animation = "default"
		$ColorRect/LOGO.animation = "blink"
		blink +=1
	else:
		$ColorRect/LOGO.animation = "default"
