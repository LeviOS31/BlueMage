extends KinematicBody2D

var stats = Playerstats

signal tran

onready var panimation = $AnimationPlayer
onready var animation = $AnimationTree
onready var anistate =  animation.get("parameters/playback")
onready var sprite = $Sprite
enum{
	WORLD,
	BATTLE
}

var state = WORLD
export var speed = 75
export var friction = 200
var velocity = Vector2.ZERO

func _ready():
	animation.active = true
	Coordinates.PlacePlayer()
	yield(get_tree().create_timer(0.2), "timeout")
	$"../../playercam".smoothing_enabled = true
	

func _physics_process(delta):
	move(delta)
	if $"../../transitionscene/Timer".time_left < 0.1 && $"../../transitionscene/Timer".time_left > 0.00001:
		emit_signal("tran")

func move(delta):
	var input = Vector2.ZERO
	
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input = input.normalized()
	
	if input != Vector2.ZERO:
		animation.set("parameters/idle/blend_position", input)
		animation.set("parameters/attack/blend_position", input)
		animation.set("parameters/run/blend_position", input)
		anistate.travel("run")
		velocity += input * speed
		velocity = velocity.clamped(speed)
	else:
		anistate.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	velocity = move_and_slide(velocity);
	

func _on_detection_body_entered(body):
	print(body.get_path())
	
	if body.is_in_group("building"):
		global_position = body.location
	
	if "enemies" in str(body.get_path()):
		Global.enemytoremove = body.get_path()
		Global.enemy = body.filename
		Global.playerlocation = position;
		var img = $"../..".get_viewport().get_texture().get_data()
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
		img.flip_y()
		Global.screenshot.create_from_image(img)
		get_tree().change_scene("res://battle/battle.tscn")
