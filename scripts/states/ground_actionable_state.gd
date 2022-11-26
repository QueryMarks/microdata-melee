extends State
class_name GroundActionableState


# Called when the node enters the scene tree for the first time.
func enter():
	tags += ["ground","actionable"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if (player.position.x > player.opponent.position.x) and (player.my_facing != -1):
		player.turn(-1)
	elif (player.position.x < player.opponent.position.x) and (player.my_facing != 1):
		player.turn(1)
		
	if (Input.is_action_pressed(player.input_down)):
		state_machine.change_state(CrouchState.new())
	elif (Input.is_action_pressed(player.input_up)): 
		state_machine.change_state(JumpState.new())
	elif ((Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right)) or (Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left))):
		state_machine.change_state(WalkState.new())

func get_hit(hitbox : Hitbox):
	return block_check(hitbox)




