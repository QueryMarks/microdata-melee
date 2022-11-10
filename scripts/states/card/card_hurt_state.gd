extends State
class_name CardHurtState
var friction = 1
var hitstun
# Called when the node enters the scene tree for the first time.
func enter():
	player.anim_player.play("hurt")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if hitstun <= 0:
		state_machine.change_state(IdleState.new())
	hitstun -= 1
	if abs(player.velocity.x) >= friction:
		if abs(player.velocity.x) >= 200:
			player.velocity.x -= 20
		else:
			player.velocity.x -= 4*sign(player.velocity.x)
	elif player.velocity.x != 0:
		player.velocity.x = 0

