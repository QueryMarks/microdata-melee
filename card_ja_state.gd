extends AirNormalState
class_name CardjaState

func enter():
	super()
	tags += ["a", "air", "can_cancel"]
	player.anim_player.queue("ja")
# Called every frame. 'delta' is the elapsed time since the previous frame.
