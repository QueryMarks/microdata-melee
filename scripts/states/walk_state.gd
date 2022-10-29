extends GroundActionableState
class_name WalkState


# Called when the node enters the scene tree for the first time.
func enter():
	player.anim_player.play("walk")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	#for the love of god fix this later
	if (player.position.x > player.opponent.position.x) and (player.my_facing != -1):
		player.turn(-1)
	elif (player.position.x < player.opponent.position.x) and (player.my_facing != 1):
		player.turn(1)
	if player.os.os_action_check(tags):
		return
	#elif (Input.is_action_just_pressed("ui_right")) or (Input.is_action_just_pressed("ui_left")):
	#	player.os.os_action_check(tags)
	elif (Input.is_action_pressed("ui_down")):
		state_machine.change_state(CardCrouchState.new())
	elif (Input.is_action_pressed("ui_up")): 
		state_machine.change_state(JumpState.new())
	elif (Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right")):
		player.velocity.x = -50
	elif (Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_left")):
		player.velocity.x = 50


	else:
		state_machine.change_state(IdleState.new())

func exit():
	player.velocity.x = 0

