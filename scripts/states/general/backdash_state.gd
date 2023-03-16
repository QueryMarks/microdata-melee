extends State
class_name BackdashState


# Called when the node enters the scene tree for the first time.
func enter():
	player.anim_play(player.character_name+"/backdash")
	player.velocity.x = -200*player.my_facing
	player.velocity.y = -50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if player.is_on_floor():
		state_machine.change_state(player.move_list.my_idle.new())
	else:
		player.velocity.y += 5
		if abs(player.velocity.x) > 50:
			player.velocity.x -= 15*sign(player.velocity.x)
	
