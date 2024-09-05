extends GroundCommandNormalState
class_name Card3cState


# Called when the node enters the scene tree for the first time.
func enter():
	super()
	tags += ["command_normal", "crouching", "can_cancel", "can_jump_cancel"]
	player.anim_play("card/3c")


