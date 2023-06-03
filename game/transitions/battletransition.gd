extends Sprite


func _ready():
	if Global.screenshot != null:
		texture = Global.screenshot
		var viewportscale = get_viewport().size
		scale.x = 320 / viewportscale.x
		scale.y = 180 / viewportscale.y
		$AnimationPlayer.play("transition");



