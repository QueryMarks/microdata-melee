extends MoveList


func _init():
	super()
	ground_normals = [
		["a"]
	]
	
	my_5a = Shoto5aState

func move_change_state(inputs : Array):
	if player.state_machine.current_state.tags.has("ground"):
		match inputs:
			["a"]:
				state_machine.change_state(my_5a.new())
