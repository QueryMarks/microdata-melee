extends GetupState
class_name TechRollForwardState


# Called when the node enters the scene tree for the first time.
func enter():
	player.anim_player.queue("tech_roll_forward")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	player.velocity.x = 100 * player.my_facing
	super(delta)


