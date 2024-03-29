extends State
class_name GroundSpecialState


# Called when the node enters the scene tree for the first time.
func enter():
	tags += ["ground","special"]
	player.get_node("Sprite2D").z_index = 1
	player.anim_player.animation_finished.connect(self._to_idle)

func _to_idle(_variable):
	state_machine.change_state(player.move_list.my_idle.new())
# Called every frame. 'delta' is the elapsed time since the previous frame.

func exit():
	player.anim_player.animation_finished.disconnect(self._to_idle)
	player.get_node("Sprite2D").z_index = 0
	for node in player.get_node("Hitboxes").get_children():
		for shape in node.get_children():
			if shape.disabled == false:
				shape.set_deferred("disabled",true)
