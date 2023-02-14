extends GroundActionableState
class_name WalkState


# Called when the node enters the scene tree for the first time.
func enter():
	super()
	player.anim_play("walk")
	player.anim_player.advance(1.0/60.0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	#for the love of god fix this later
	if (player.position.x > player.opponent.position.x) and (player.my_facing != -1):
		player.turn()
	elif (player.position.x < player.opponent.position.x) and (player.my_facing != 1):
		player.turn()
	if player.os.os_action_check(tags):
		return
	#elif (Input.is_action_just_pressed(player.input_right)) or (Input.is_action_just_pressed(player.input_left)):
	#	player.os.os_action_check(tags)
	elif (Input.is_action_pressed(player.input_down)):
		state_machine.change_state(CrouchState.new())
	elif (Input.is_action_pressed(player.input_up)): 
		state_machine.change_state(JumpState.new())

	elif (Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left)):
		if player.my_facing == 1:
			player.velocity.x = 80
		else:
			player.velocity.x = 60
	elif (Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right)):
		if player.my_facing == 1:
			player.velocity.x = -60
		else:
			player.velocity.x = -80
	else:
		state_machine.change_state(IdleState.new())

func exit():
	player.velocity.x = 0

