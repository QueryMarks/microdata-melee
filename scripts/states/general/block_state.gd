extends State
class_name BlockState

# Called when the node enters the scene tree for the first time.
func enter():
	tags += ["block", "grounded"]
	player.anim_play(player.character_name+"/block")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if player.hitstun <= 0:
		if Input.is_action_pressed(player.input_down):
			state_machine.change_state(CrouchState.new())
		state_machine.change_state(IdleState.new())
	player.hitstun -= 1
	if player.os.os_action_check(tags):
		return	
	elif (Input.is_action_pressed(player.input_down)):
		state_machine.change_state(CrouchBlockState.new())
		
func get_hit(hitbox : Hitbox):
	return block_check(hitbox)
