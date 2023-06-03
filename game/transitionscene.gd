extends CanvasLayer

onready var animation = $AnimationPlayer
signal transitioned 

func transition_to_black():
	animation.play("fade_to_black")
	$Timer.start()
	
func transition_to_normal():
	$VBoxContainer.hide()
	$VBoxContainer/startButton.hide()
	$VBoxContainer/exitButton.hide()
	animation.play("fade_to_normal")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		emit_signal("transitioned")
		animation.play("fade_to_normal")


