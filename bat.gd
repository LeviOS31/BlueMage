extends KinematicBody2D

const enemiedeath = preload("res://enemiedeath.tscn")

enum {
	IDLE,
	WANDER,
	CHASE
}

export var knockback = Vector2.ZERO
export var fly_speed = Vector2.ZERO
export var accerleration = 300
export var max_speed = 50
export var friction = 200

var state = CHASE

onready var animation = $Bat
onready var stats = $stats
onready var detection = $playerdetection
onready var hurtbox = $hurtbox
onready var softcollision = $softcollision
onready var wandercontroller = $wandercontrol
onready var blinkanimation = $blinkanimation

func _ready():
	randomize()
	state = pick_rand_state([IDLE, WANDER])

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 150 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			fly_speed = fly_speed.move_toward(Vector2.ZERO, friction * delta)
			seek_player()
			if wandercontroller.get_time() == 0:
				state = pick_rand_state([IDLE, WANDER])
				wandercontroller.start_timer(rand_range(1, 3))
		
		WANDER:
			seek_player()
			if wandercontroller.get_time() == 0:
				state = pick_rand_state([IDLE, WANDER])
				wandercontroller.start_timer(rand_range(1, 3))
			
			var direction = global_position.direction_to(wandercontroller.target_position)
			fly_speed = fly_speed.move_toward(direction * max_speed, accerleration * delta)
			
			if global_position.distance_to(wandercontroller.target_position) <= max_speed * delta:
				state = pick_rand_state([IDLE, WANDER])
				wandercontroller.start_timer(rand_range(1, 3))
			animation.flip_h = fly_speed.x < 0
		
		CHASE:
			var player = detection.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				fly_speed = fly_speed.move_toward(direction * max_speed, accerleration * delta)
			else:
				state = IDLE
			animation.flip_h = fly_speed.x < 0
	
	if softcollision.is_colliding():
		fly_speed += softcollision.get_push_vector() * delta * 400
	fly_speed = move_and_slide(fly_speed)
		
func seek_player():
	if detection.can_see_player():
		state = CHASE

func pick_rand_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_hurtbox_area_entered(area):
	stats.health -= area.dmg
	knockback = area.knockback_vector * 150
	hurtbox.create_hit_effect()
	hurtbox.start_invin(0.3)

func _on_stats_no_health():
	queue_free()
	var enemieDeath = enemiedeath.instance()
	get_parent().add_child(enemieDeath)
	enemieDeath.position = position


func _on_hurtbox_invincible_start():
	blinkanimation.play("start")


func _on_hurtbox_invincible_stop():
	blinkanimation.play("stop")

