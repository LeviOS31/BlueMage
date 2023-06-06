extends Control

onready var clouds = $clouds
onready var birbs = $birds
onready var player = $player
onready var buttonstart = $transitionscene/VBoxContainer/startButton
onready var pressed = false
onready var movetoggle = false
onready var timer = $player/Timer

func _ready():
	$transitionscene/VBoxContainer/startButton.grab_focus()

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

func _on_Timer_timeout():
	$transitionscene.transition_to_black()

