extends KinematicBody2D


enum{
	IDLE,
	WANDER,
	CHASE,
	BATTLE,
}
export var FRICTION = 200
export var ACCELERATION = 90
export var MAX_SPEED = 30

onready var state = WANDER
onready var wandercontroller = $wandercontrol
onready var animation = $AniPlayer
onready var velocity = Vector2.ZERO



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			
			if animation.current_animation == "walk_l":
				animation.play("idle_l")
			if animation.current_animation == "walk_r" || animation.current_animation == "idle_r":
				animation.play("idle_r")
			else:
				animation.play("idle_l")
			
			if wandercontroller.get_time() == 0:
				state = pick_state([IDLE, WANDER])
				wandercontroller.start_timer(rand_range(1,3))
		WANDER:
			if wandercontroller.get_time() == 0:
				state = pick_state([IDLE, WANDER])
				wandercontroller.start_timer(rand_range(1,3))
				
			var direction = global_position.direction_to(wandercontroller.target_position)
			velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			if velocity.x < 0:
				animation.play("walk_l")
			else:
				animation.play("walk_r")
			
			if global_position.distance_to(wandercontroller.target_position) <= MAX_SPEED * delta:
				state = pick_state([IDLE, WANDER])
				wandercontroller.start_timer(rand_range(1,3))
		CHASE:
			pass
		BATTLE:
			velocity = Vector2.ZERO
	
	velocity = move_and_slide(velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func pick_state(state_list):
	state_list.shuffle()
	var nextstate = state_list.pop_front()
	if nextstate == BATTLE:
		nextstate == IDLE
	return nextstate

func battle():
	set_script(load("res://battle/enemy/cavedrop.gd"))

func _on_detection_area_entered(area):
	print(area)


