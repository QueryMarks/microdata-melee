extends GroundNormalState
class_name Card2cState

# called when the state machine changes state to this one
func enter():
	super()
	tags += ["c", "crouching", "can_cancel"]
	player.anim_player.queue("2c")



