extends State
class_name GroundNormalState


# Called when the node enters the scene tree for the first time.
func enter():
	tags += ["ground","normal"]
	player.anim_player.animation_finished.connect(self._to_idle)
	player.get_node("Sprite2D").z_index = 1

func _to_idle(_variable):
	state_machine.change_state(IdleState.new())
# Called every frame. 'delta' is the elapsed time since the previous frame.

func exit():
	player.get_node("Sprite2D").z_index = 0
	for node in player.get_node("Hitboxes").get_children():
		if node.get_node("CollisionShape2D").disabled == false:
			node.get_node("CollisionShape2D").set_deferred("disabled",true)
