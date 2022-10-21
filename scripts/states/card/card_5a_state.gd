extends GroundNormalState
class_name Card5aState

# called when the state machine changes state to this one
func enter():
	super()
	player.anim_player.play("5a")



