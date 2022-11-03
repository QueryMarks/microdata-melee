extends State
class_name JumpState


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func enter():
	print("wheee")
	player.anim_player.play("jump")
	player.velocity.y = -180
	if (Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right)):
		player.velocity.x = -50
	elif (Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left)):
		player.velocity.x = 50
	else:
		player.velocity.x = 0



func _process(_delta):
	player.velocity.y += player.gravity
	if player.is_on_floor():
		state_machine.change_state(IdleState.new())
