extends GroundNormalState
class_name GrabState

var grab = false
# Called when the node enters the scene tree for the first time.
func enter():
	player.anim_player.animation_finished.connect(self._to_idle)
	player.anim_player.play("grab")

func exit():
	super()
	if ((grab == false) and (player.get_node("Grabboxes/Throw").grabbed_player != null)):
		player.get_node("Grabboxes/Throw").release_no_dmg()

func grab_success():
	grab = true
	throw()

func throw():
	if state_machine.current_state is GrabState:
		state_machine.change_state(ThrowState.new())
