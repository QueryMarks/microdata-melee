extends State
class_name SoftKnockdownState

var max_timer = 40
var timer = max_timer
# Called when the node enters the scene tree for the first time.
func enter():
	player.velocity.x = 0
	player.anim_play(player.character_name+"/knockdown")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if player.can_act:
		if timer <= 0:
			player.un_combo()
			state_machine.change_state(GetupState.new())
		elif timer <= 20:
			if (Input.is_action_pressed(player.input_down)):
				player.un_combo()
				state_machine.change_state(GetupState.new())
			elif (Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right)):
				player.un_combo()
				if player.my_facing == -1:
					state_machine.change_state(TechRollForwardState.new())
				else:
					state_machine.change_state(TechRollBackState.new())
			elif ((Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left))):
				player.un_combo()
				if player.my_facing == -1:
					state_machine.change_state(TechRollBackState.new())
				else:
					state_machine.change_state(TechRollForwardState.new())
		timer -= 1
