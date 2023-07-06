extends Control

onready var clouds = $clouds
onready var birbs = $birds
onready var player = $player
onready var buttonstart = $transitionscene/VBoxContainer/startButton
onready var pressed = false
onready var movetoggle = false
onready var timer = $player/Timer
onready var fadeout = $Tweenaudio

func _ready():
	$transitionscene.transition_to_normal()
#	$transitionscene/VBoxContainer/startButton.grab_focus()
	$transitionscene/VBoxContainer.show()
	$transitionscene/VBoxContainer/startButton.show()
	$transitionscene/VBoxContainer/exitButton.show()
	fadeout.interpolate_property($AudioStreamPlayer, "volume_db", $AudioStreamPlayer.volume_db, -60.0, 5.0, 1, Tween.EASE_IN)


func _physics_process(delta):
	clouds.move(delta)
	birbs.move(delta)
	player.set_delta(delta)
	checkpressed()
	if movetoggle == true:
		moveplayer()
	if $transitionscene/Timer.time_left < 0.1 && $transitionscene/Timer.time_left > 0.00001:
		get_tree().change_scene("res://worlds/world.tscn")


func checkpressed():
	if pressed == true:
		movetoggle = true
	

func moveplayer():
	player.move()


func _on_exitButton_pressed():
	get_tree().quit()

func _on_startButton_pressed():
	print("pressed")
	pressed = true
	timer.start()
	fadeout.start()

func _on_Timer_timeout():
	$transitionscene.transition_to_black()
