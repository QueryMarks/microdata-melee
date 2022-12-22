extends State
class_name CrouchState


# Called when the node enters the scene tree for the first time.
func enter():
	tags += ["ground", "actionable"]
	player.anim_player.play("crouch")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if !(Input.is_action_pressed(player.input_down)):
		state_machine.change_state(IdleState.new())

func get_hit(hitbox : Hitbox):
	return block_check(hitbox)
