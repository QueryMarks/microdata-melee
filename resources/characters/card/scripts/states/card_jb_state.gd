extends AirNormalState
class_name CardjbState

func enter():
	super()
	tags += ["b", "air", "can_cancel"]
	player.anim_play("jb")
# Called every frame. 'delta' is the elapsed time since the previous frame.
