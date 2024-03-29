extends State
class_name DashState

var dash_timer = 0
# Called when the node enters the scene tree for the first time.
func enter():
	player.anim_play(player.character_name+"/dash")
	player.velocity.x = 150 * player.my_facing	
	
func _physics_process(_delta):
	if (Input.is_action_pressed(player.input_up)):
		state_machine.change_state(JumpState.new())
	#INTENTIONALLY NOT AN ELIF!! We want the following statement to override the player's velocity with dash velocity *even if* we just set it in JumpState.enter(). This makes dash jumps faster! We might rework this when prejump is added.
	if ((Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right) and player.my_facing == -1)) or ((Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left) and player.my_facing == 1)) or (Input.is_action_pressed(player.input_o)) or dash_timer < 15:
		dash_timer += 1
		player.velocity.x = 150 * player.my_facing	
	else:
		state_machine.change_state(IdleState.new())


