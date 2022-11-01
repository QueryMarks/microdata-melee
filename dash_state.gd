extends State
class_name DashState

var dash_timer = 0
# Called when the node enters the scene tree for the first time.
func enter():
	print("DASHING")
	player.anim_player.play("dash")
	player.velocity.x = 150 * player.my_facing	
	
func _physics_process(_delta):
	if ((Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right) and player.my_facing == -1)) or ((Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left) and player.my_facing == 1)) or dash_timer < 15:
		dash_timer += 1
	else:
		state_machine.change_state(IdleState.new())


