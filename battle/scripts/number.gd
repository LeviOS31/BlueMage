extends Position2D



var velocity = Vector2(0,0)

func _ready():
	randomize()
	var random = rand_range(0,80) - 40
	
	velocity = Vector2(random, 25)
	
	var tween = $Tween
	tween.interpolate_property(self, "scale", scale, Vector2(1,1), 0.40, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(self, "scale", Vector2(1,1),Vector2(0.1,0.1),1,Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.4)
	tween.start()

func _process(delta):
	position -= velocity * delta



func _on_Tween_tween_all_completed():
	queue_free()
