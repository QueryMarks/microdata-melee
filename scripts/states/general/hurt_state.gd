extends State
class_name HurtState
var friction = 1
# Called when the node enters the scene tree for the first time.
func enter():
	tags += ["ground","hurt"]
	player.anim_play(player.character_name+"/hurt")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if player.hitstun <= 0:
		player.un_combo()
		state_machine.change_state(IdleState.new())
	player.hitstun -= 1
	if abs(player.velocity.x) >= friction:
#		if abs(player.velocity.x) >= 200:
#			player.velocity.x -= 10*sign(player.velocity.x)
#		else:
#			player.velocity.x -= 1.0/20.0*player.velocity.x
		if abs(player.velocity.x) >= 10:
			player.velocity.x -= 1.0/15.0*player.velocity.x
		else:
			player.velocity.x = 0
	elif player.velocity.x != 0:
		player.velocity.x = 0

