extends Node

var WorldCoord = Vector2(0,0)
var Cave1Coord = Vector2(0,0)
var City1Coord = Vector2(0,0)

func PlacePlayer():
	var wNode =  $"../".get_children()[-1]
	var Wname = wNode.name;
	var player = wNode.get_node("YSort/player");
	
	if Wname == "world" && WorldCoord != Vector2(0,0):
		player.position = WorldCoord;
	if Wname == "cave1" && Cave1Coord != Vector2(0,0):
		player.position = Cave1Coord;
	if Wname == "city1" && City1Coord != Vector2(0,0):
		player.position = City1Coord;
