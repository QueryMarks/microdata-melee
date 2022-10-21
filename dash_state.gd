extends State
class_name DashState


# Called when the node enters the scene tree for the first time.
func enter():
	print("DASHING")
	player.velocity.x = 150 * player.my_facing	


