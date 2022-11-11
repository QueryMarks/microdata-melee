extends BlockState
class_name CrouchBlockState


# Called when the node enters the scene tree for the first time.
func enter():
	player.anim_player.play("crouch_block")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if !(Input.is_action_pressed(player.input_down)):
		state_machine.change_state(BlockState.new())
