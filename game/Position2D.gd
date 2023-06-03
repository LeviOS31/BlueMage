extends Position2D

enum States { IDLE, MOVE }

var _state = States.IDLE
var speed = 200

var _path = []
var _target_world_point = Vector2()
var _target_position = Vector2()
var _velocity = Vector2()
onready var player = $player
var _timer
signal arrived()

onready var board = get_parent().get_parent().get_node("board")


func _ready():
	_change_state(States.IDLE)
	connect("arrived", self, "moving")

func _process(delta):
	if _state == States.MOVE:
		if global_position != _target_world_point:
			if global_position.x < _target_world_point.x:
				global_position += Vector2(64,0).normalized() * 2
			elif global_position.x >  _target_world_point.x:
				global_position -= Vector2(64,0).normalized() * 2
			elif global_position.x ==  _target_world_point.x:
				global_position -= Vector2(0,0).normalized() * 2
			if global_position.y <  _target_world_point.y:
				global_position += Vector2(0,64).normalized() * 2
			elif global_position.y >  _target_world_point.y:
				global_position -= Vector2(0,64).normalized() * 2
			elif global_position.y ==  _target_world_point.y:
				global_position -= Vector2(0,0).normalized() * 2
		if global_position == _target_world_point:
			print("arrived")
			emit_signal("arrived")
	
	
func moving ():
	if _state != States.MOVE:
		return
	player.rotate_deg(_path)
	if len(_path) != 1:
		_path.remove(0)
		if len(_path) == 0:
			_change_state(States.IDLE)
			return
		_target_position = _target_world_point
		_target_world_point = _path[0]
	else:
		_target_position = _target_world_point
		_target_world_point = _path[0]
		_path.remove(0)

func move (path):
	if len(path) > 1:
		_path = path
		player.rotate_deg(_path)
		_change_state(States.MOVE)
		moving()
	
func _change_state(new_state):
	print ("state change: " , new_state)
	if new_state == States.MOVE:
		if not _path or len(_path) == 1:
			_change_state(States.IDLE)
			return
			
		_target_world_point = _path[1]
		_path.remove(0)
	if new_state == States.IDLE:
		player.animation.set("parameters/idle/blend_position", Vector2.DOWN)
		player.anistate.travel("idle")
	_state = new_state
