extends State
class_name GroundBounceState


# Called when the node enters the scene tree for the first time.
func enter():
	player.hit_stop(6)
	player.anim_play(player.character_name+"/ground_bounce")
	player.velocity.y *= -10
	player.velocity.x = clamp(player.velocity.x, -80, 80)  


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	player.velocity.y += player.gravity
	if player.is_on_floor():
		state_machine.change_state(SoftKnockdownState.new())
