extends GroundNormalState
class_name ThrowState

@onready var grab_box = player.get_node("Grabboxes/Throw")
# Called when the node enters the scene tree for the first time.
func enter():
	player.anim_play("throw")
	player.anim_player.animation_finished.connect(self._to_idle)
	if (Input.is_action_pressed(player.input_left) && !Input.is_action_pressed(player.input_right) && player.my_facing == 1) or (!Input.is_action_pressed(player.input_left) && Input.is_action_pressed(player.input_right) && player.my_facing == -1):
		player.turn()

func _to_idle(_variable):
	super(_variable)
# Called every frame. 'delta' is the elapsed time since the previous frame.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
