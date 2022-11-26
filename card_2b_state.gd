extends GroundNormalState
class_name Card2bState

# called when the state machine changes state to this one
func enter():
	super()
	tags += ["b", "crouching", "can_cancel"]
	player.anim_player.queue("2b")



