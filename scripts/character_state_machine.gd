extends Node

class_name CharacterStateMachine


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
	print("Current state ", current_state)
	print("New state ", new_state)
	if my_player.hitstop == true:
		my_player.hit_restart
	current_state.exit()
	current_state.queue_free()
	current_state = new_state
	current_state.player = my_player
	current_state.state_machine = self
	current_state.input_reader = my_input_reader
	self.add_child(current_state)
	current_state.enter()
