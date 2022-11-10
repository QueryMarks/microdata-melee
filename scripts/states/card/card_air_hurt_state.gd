extends State
class_name CardAirHurtState
var hitstun
# Called when the node enters the scene tree for the first time.
func enter():
	tags += ["air","hurt"]
	player.anim_player.play("hurt")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if hitstun <= 0:
		state_machine.change_state(AirState.new())
	hitstun -= 1
	if abs(player.velocity.x) >= 1:
		if abs(player.velocity.x) >= 200:
			player.velocity.x -= 20
		else:
			player.velocity.x -= 2*sign(player.velocity.x)
	elif player.velocity.x != 0:
		player.velocity.x = 0
	player.velocity.y += player.gravity
	if player.is_on_floor():
		state_machine.change_state(IdleState.new())
