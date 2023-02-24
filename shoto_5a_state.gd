extends GroundNormalState
class_name Shoto5aState

func enter():
	super()
	tags += ["a", "standing", "can_cancel"]
	player.anim_play("shoto/5a")
