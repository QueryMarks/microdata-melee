extends State
class_name GroundBounceState


# Called when the node enters the scene tree for the first time.
func enter():
	player.hit_stop(60)
	player.velocity.y = -100
	player.velocity.x = clamp(player.velocity.x, -80, 80)  


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	player.velocity.y += player.gravity
	if player.is_on_floor():
		state_machine.change_state(IdleState.new())
