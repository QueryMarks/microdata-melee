extends GroundNormalState
class_name Card5dState


# Called when the node enters the scene tree for the first time.
func enter():
	super()
	tags += ["d", "standing", "can_cancel"]
	player.anim_player.queue("5d")
