extends GroundNormalState
class_name Card2aState


# Called when the node enters the scene tree for the first time.
func enter():
	print("hellw orld")
	super()
	tags += ["a", "crouching", "can_cancel"]
	player.anim_player.play("2a")


