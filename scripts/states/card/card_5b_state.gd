extends GroundNormalState
class_name Card5bState


# Called when the node enters the scene tree for the first time.
func enter():
	super()
	tags += ["b", "standing", "can_cancel"]
	player.anim_player.play("5b")
