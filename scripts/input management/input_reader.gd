extends Node
class_name InputReader

@export var my_device = 0
@export var player : Node
var input_history_buttons = []
var input_history_frames = []
var input_history_both = [input_history_buttons, input_history_frames]
var temp_input_dict = {}
var input_leniency = 15
var first_input_leniency = 5
	
func _physics_process(_delta):
	temp_input_dict.clear()

	#a note: the dictionaries here should be replaced with just values in an array, i'll do that later
	#up/down axis
	if Input.is_action_pressed(player.input_up) and !Input.is_action_pressed(player.input_down): 
		if Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right):
			temp_input_dict["7"] = true
		elif Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left):
			temp_input_dict["9"] = true
		else:
			temp_input_dict["8"] = true
	elif Input.is_action_pressed(player.input_down) and !Input.is_action_pressed(player.input_up):
		if Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right):
			temp_input_dict["1"] = true
		elif Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left):
			temp_input_dict["3"] = true
		else:
			temp_input_dict["2"] = true

	elif Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right):
		temp_input_dict["4"] = true
	elif Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left):
		temp_input_dict["6"] = true
	else:
		temp_input_dict["5"] = true
	if Input.is_action_pressed(player.input_a):
		temp_input_dict["a"] = true
	if Input.is_action_pressed(player.input_b):
		temp_input_dict["b"] = true
	if Input.is_action_pressed(player.input_c):
		temp_input_dict["c"] = true
	if Input.is_action_pressed(player.input_d):
		temp_input_dict["d"] = true
	if Input.is_action_pressed(player.input_o):
		temp_input_dict["o"] = true
	if ((input_history_buttons == []) or (temp_input_dict.hash() != input_history_buttons.back().hash())):
		#uncomment the following 3 lines when debugging inputs
#		if input_history_buttons != []:
#			print("Releasing " + str(input_history_buttons.back()) + " after " + str(input_history_frames.back()))
#			print("pressing" + str(temp_input_dict))
		input_history_buttons.append(temp_input_dict.duplicate())
		input_history_frames.append(0)
		
	input_history_frames[-1] += 1


func read_inputs(move_list : Array):
	for original_input_list in move_list:
		#alter each string to match player's current facing direction
		var i = 0
		var input_list = original_input_list.duplicate()
		if player.my_facing != 1:
			while i < len(input_list):
				if typeof(input_list[i]) == TYPE_STRING:

					match input_list[i]:
						"6":
							input_list[i] = "4"
						"3":
							input_list[i] = "1"
						"1":
							input_list[i] = "3"
						"4":
							input_list[i] = "6"
						"7":
							input_list[i] = "9"
						"9":
							input_list[i] = "7"
							
			#if that entry in input_list is an array (for multiple inputs on the same frame) edit those as well
				elif typeof(input_list[i]) == TYPE_ARRAY:
					var j = 0
					while j < len(input_list[i]):
						match input_list[i][j]:
							"6":
								input_list[i][j] = "4"
							"3":
								input_list[i][j] = "1"
							"1":
								input_list[i][j] = "3"
							"4":
								input_list[i][j] = "6"
							"7":
								input_list[i][j] = "9"
							"9":
								input_list[i][j] = "7"
					
				i += 1
		#we're done altering the strings to match our current direction, time to actually check for the input
		#set up variables for the current index of the input and history, they should be 0
		var current_list_index = -1
		var current_history_index = -1
		#variable to track time difference between inputs
		var input_distance = 0
		while ((current_history_index*-1) <= len(input_history_buttons)) and (input_distance <= input_leniency):
			#if the current input list index is a string, check if the input history has that button within input leniency
			if typeof(input_list[current_list_index]) == TYPE_STRING:
				#if this is the first input of the move being checked, and the current frame in the history has that input
				if current_list_index == -1 and input_history_buttons[current_history_index].has(input_list[current_list_index]):
					#conduct a while loop to see how long that input has been held
					var k = -1
					var k_frame_check = 0
					while input_history_buttons[k].has(input_list[current_list_index]):
						k_frame_check += input_history_frames[k]
						if k_frame_check + input_distance > first_input_leniency:
							break
						else:
							k -= 1
					if k_frame_check + input_distance > first_input_leniency:
						break
				if input_history_buttons[current_history_index].has(input_list[current_list_index]):
					if current_list_index*-1 == input_list.size():
						return(original_input_list)
					else:
						input_distance = input_history_frames[current_history_index]
						if current_list_index != -1:
							current_history_index -= 1
						current_list_index -= 1
				else:				
					input_distance += input_history_frames[current_history_index]
					current_history_index -= 1
					
			#if the current input list index is an array, check if a frame in input history has both pressed
			elif typeof(input_list[current_list_index]) == TYPE_ARRAY:
				var has_inputs = true
				for current_list_index_inputs in input_list[current_list_index]:
					if !input_history_buttons[current_history_index].has(current_list_index_inputs):
						has_inputs = false
				if has_inputs:
					if current_list_index*-1 == input_list.size():
								return(original_input_list)
					else:
						input_distance = input_history_frames[current_history_index]
						if current_list_index != -1:
							current_history_index -= 1
						current_list_index -= 1
				else:
						input_distance += input_history_frames[current_history_index]
						current_history_index -= 1
	return(null)
#			for input in input_dict:
#				if input contains 
#		if all inputs are there:
#			return move's state
