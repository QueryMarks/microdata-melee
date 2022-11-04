extends GroundNormalState
class_name Card5aState

# called when the state machine changes state to this one
func enter():
	super()
	tags += ["a", "standing", "can_cancel"]
	player.anim_player.play("5a")



