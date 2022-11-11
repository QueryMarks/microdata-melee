extends State
class_name BlockState

var blockstun = 0
# Called when the node enters the scene tree for the first time.
func enter():
	tags += ["block", "grounded"]
	player.anim_player.play("block")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if blockstun <= 0:
		if Input.is_action_pressed(player.input_down):
			state_machine.change_state(CrouchState.new())
		state_machine.change_state(IdleState.new())
	blockstun -= 1
	if player.os.os_action_check(tags):
		return	
	elif (Input.is_action_pressed(player.input_down)):
		state_machine.change_state(CrouchState.new())
