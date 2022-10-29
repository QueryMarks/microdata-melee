extends State
class_name CardCrouchState


# Called when the node enters the scene tree for the first time.
func enter():
	player.anim_player.play("crouch")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if !(Input.is_action_pressed("ui_down")):
		state_machine.change_state(IdleState.new())
