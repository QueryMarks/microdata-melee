extends GroundNormalState
class_name Card2aState


# Called when the node enters the scene tree for the first time.
func enter():
	super()
	tags += ["a", "crouching", "can_cancel"]
	player.anim_play("2a")


