extends GroundNormalState
class_name GrabState

var grab = false
# Called when the node enters the scene tree for the first time.
func _ready():
	tags.erase("normal")
	player.anim_player.play("grab")

func exit():
	super()
	if ((grab == false) and (player.get_node("Grabboxes/Throw").grabbed_player != null)):
		player.get_node("Grabboxes/Throw").release_no_dmg()

func grab_success():
	grab = true
	state_machine.call_deferred("change_state", ThrowState.new())
