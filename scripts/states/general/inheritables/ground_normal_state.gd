extends State
class_name GroundNormalState


# Called when the node enters the scene tree for the first time.
func enter():
	tags += ["ground","normal"]
	player.anim_player.animation_finished.connect(self._to_idle)
	player.get_node("Sprite2D").z_index = 1

func _to_idle(_variable):
	print("TO IDLE")
	if (Input.is_action_pressed(player.input_down)):
		print("CROUCHING")
		state_machine.change_state(CrouchState.new())
	elif (Input.is_action_pressed(player.input_up)): 
		state_machine.change_state(JumpState.new())
	elif ((Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right)) or (Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left))):
		state_machine.change_state(WalkState.new())
	else:
		state_machine.change_state(IdleState.new())
	player.anim_player.advance(1.0/60.0)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func exit():
	player.anim_player.animation_finished.disconnect(self._to_idle)
	player.get_node("Sprite2D").z_index = 0
	for node in player.get_node("Hitboxes").get_children():
		if node.get_node("CollisionShape2D").disabled == false:
			node.get_node("CollisionShape2D").set_deferred("disabled",true)
