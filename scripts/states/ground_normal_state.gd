extends State
class_name GroundNormalState


# Called when the node enters the scene tree for the first time.
func enter():
	tags += ["ground","normal"]
	player.anim_player.animation_finished.connect(self._to_idle)

func _to_idle(_variable):
	state_machine.change_state(IdleState.new())
# Called every frame. 'delta' is the elapsed time since the previous frame.

