extends AirNormalState
class_name CardjcState

func enter():
	super()
	tags += ["c", "air", "can_cancel"]
	player.anim_play("card/jc")
# Called every frame. 'delta' is the elapsed time since the previous frame.
