extends State
class_name SoftKnockdownState

var max_timer = 40
var timer = max_timer
# Called when the node enters the scene tree for the first time.
func enter():
	player.velocity.x = 0
	player.anim_player.queue("knockdown")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if timer <= 0:
			state_machine.change_state(GetupState.new())
	elif timer <= 20:
		if (Input.is_action_pressed(player.input_down)):
			state_machine.change_state(GetupState.new())
		elif (Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right)):
			if player.my_facing == -1:
				state_machine.change_state(TechRollForwardState.new())
			else:
				state_machine.change_state(TechRollBackState.new())
		elif ((Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left))):
			if player.my_facing == -1:
				state_machine.change_state(TechRollBackState.new())
			else:
				state_machine.change_state(TechRollForwardState.new())
	timer -= 1
