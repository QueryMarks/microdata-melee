extends State
class_name GetupState

var max_timer = 20
var timer = max_timer
# Called when the node enters the scene tree for the first time.
func enter():
	player.anim_player.queue("getup")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if timer <= 0:
		state_machine.change_state(IdleState.new())
	else:
		timer -= 1
