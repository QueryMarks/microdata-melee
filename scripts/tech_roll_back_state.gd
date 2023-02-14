extends GetupState
class_name TechRollBackState


# Called when the node enters the scene tree for the first time.
func enter():
	player.anim_play("tech_roll_back")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	player.velocity.x = -100 * player.my_facing
	super(_delta)

	
	
