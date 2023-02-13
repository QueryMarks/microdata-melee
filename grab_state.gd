extends GroundNormalState
class_name GrabState

# Called when the node enters the scene tree for the first time.
func _ready():
	tags.erase("normal")
	player.anim_player.play("grab")


func grab_success():
	state_machine.call_deferred("change_state", ThrowState.new())
