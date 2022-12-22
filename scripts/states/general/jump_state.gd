extends State
class_name JumpState


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func enter():
	tags += ["air", "actionable"]
	player.anim_player.queue("jump")
	player.velocity.y = -200
	if (Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right)):
		player.velocity.x = -80
	elif (Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left)):
		player.velocity.x = 80
	else:
		player.velocity.x = 0

func get_hit(hitbox : Hitbox):
	player.get_hurt(hitbox)
	return "hit"

func _physics_process(_delta):
	player.velocity.y += player.gravity
	if player.is_on_floor():
		state_machine.change_state(IdleState.new())
