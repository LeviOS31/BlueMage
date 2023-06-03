extends AudioStreamPlayer

func _ready():
	connect("finished", self, "queue_free")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
