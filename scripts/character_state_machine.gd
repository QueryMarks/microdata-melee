extends Node

class_name CharacterStateMachine

var state_to_change : State
var current_state
var my_player
var my_input_reader


func initialize(starting_state, player, input_reader):
	current_state = starting_state
	my_player = player
	my_input_reader = input_reader
	
	current_state.player = player
	current_state.state_machine = self
	current_state.input_reader = my_input_reader
	self.add_child(current_state)
	current_state.enter()
	
	
func change_state(new_state: State):
	if my_player.hitstop == true:
		print("new_state is" + str(new_state))
		if state_to_change != null:
			state_to_change.queue_free()
		state_to_change = new_state	
		new_state.set_physics_process(false)
	else:
		current_state.exit()
		current_state.queue_free()
		my_player.anim_player.play("RESET")
		#my_player.anim_player.call_deferred("advance",1.0/60.0)
		#my_player.anim_player.advance(1.0/60.0)
		#my_player.anim_player.call_deferred("advance", 1)
		current_state.set_physics_process(false)
		current_state = new_state
		current_state.player = my_player
		current_state.state_machine = self
		current_state.input_reader = my_input_reader
		self.add_child(current_state)
		current_state.enter()
		state_to_change = null

func _physics_process(_delta):
	if state_to_change != null and my_player.hitstop == false:
		state_to_change.set_physics_process(true)
		change_state(state_to_change)
		

