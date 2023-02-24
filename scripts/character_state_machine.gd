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
	#Only applies if the player is in hitstop -- I want the hitstop to last the full length before transitioning.
	if my_player.hitstop == true:
		if state_to_change != null:
			state_to_change.queue_free()
		state_to_change = new_state
		new_state.set_physics_process(false)
	else:
		#change the state to the new State node given as an argument
		#exit and remove the current state
		current_state.exit()
		current_state.queue_free()		
		#don't think the below line is needed anymore, but leaving it in case we need to revert
		#current_state.set_physics_process(false)
		
		#play the "RESET" animation to put hurtboxes etc back in place
		my_player.anim_play(my_player.character_name + "/RESET")
		my_player.anim_player.advance(1.0/60.0)

		#change references for the new state and stuff like that
		current_state = new_state
		current_state.player = my_player
		current_state.state_machine = self
		current_state.input_reader = my_input_reader
		
		#add current state to the scene tree and enter it
		self.add_child(current_state)
		current_state.enter()
		state_to_change = null

func _physics_process(_delta):
	if state_to_change != null and my_player.hitstop == false:
		state_to_change.set_physics_process(true)
		change_state(state_to_change)
		

