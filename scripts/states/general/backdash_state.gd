extends State
class_name BackdashState


# Called when the node enters the scene tree for the first time.
func enter():
	player.velocity.x = -500*player.my_facing


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
