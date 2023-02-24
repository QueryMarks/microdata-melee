extends GroundNormalState
class_name Card5cState


# Called when the node enters the scene tree for the first time.
func enter():
	super()
	tags += ["c", "standing", "can_cancel"]
	player.anim_play("card/5c")
