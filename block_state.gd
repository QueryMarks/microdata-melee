extends State
class_name BlockState


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player.os.os_action_check(tags):
		return	
	elif (Input.is_action_pressed(player.input_down)):
		state_machine.change_state(CardCrouchState.new())
