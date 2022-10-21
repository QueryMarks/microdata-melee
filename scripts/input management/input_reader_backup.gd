extends Node
#class_name InputReader

@export var my_device = 0
@export var my_player : Node
var input_history_buttons = []
var input_history_frames = []
var input_history_both = [input_history_buttons, input_history_frames]
var temp_input_dict = {}
var input_leniency = 20
	
func _physics_process(_delta):
	temp_input_dict.clear()

	#up/down axis
	if Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_down"): 
		if Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
			temp_input_dict["7"] = true
		elif Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_left"):
			temp_input_dict["9"] = true
		else:
			temp_input_dict["8"] = true
	elif Input.is_action_pressed("ui_down") and !Input.is_action_pressed("ui_up"):
		if Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
			temp_input_dict["1"] = true
		elif Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_left"):
			temp_input_dict["3"] = true
		else:
			temp_input_dict["2"] = true

	elif Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
		temp_input_dict["4"] = true
	elif Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_left"):
		temp_input_dict["6"] = true
	else:
		temp_input_dict["5"] = true
	if Input.is_action_pressed("ui_a"):
		temp_input_dict["a"] = true
	if Input.is_action_pressed("ui_b"):
		temp_input_dict["b"] = true
	if Input.is_action_pressed("ui_c"):
		temp_input_dict["c"] = true
	if Input.is_action_pressed("ui_d"):
		temp_input_dict["d"] = true
	if Input.is_action_pressed("ui_dash"):
		temp_input_dict["dash"] = true
	if ((input_history_buttons == []) or (temp_input_dict.hash() != input_history_buttons.back().hash())):
		if input_history_buttons != []:
			print("Releasing " + str(input_history_buttons.back()) + " after " + str(input_history_frames.back()))
			print("pressing" + str(temp_input_dict))
		input_history_buttons.append(temp_input_dict.duplicate())
		input_history_frames.append(0)
		
	input_history_frames[-1] += 1

#move_dict passed from state calling read_inputs()
func read_inputs(move_list : Array):
	for input_list in move_list:
		#alter each string to match player's current facing direction
		var i = 0
		while i < len(input_list):
			#if the current index in the input list is a single string we can just replace
			#NOT WORKING ATM? fix this!!!
			if typeof(input_list[i]) == TYPE_STRING:
				if my_player.my_facing != 1:
					input_list[i] = input_list[i].replace("6","4")
					input_list[i] = input_list[i].replace("3","1")
					input_list[i] = input_list[i].replace("1","3")
					input_list[i] = input_list[i].replace("4","6")
					input_list[i] = input_list[i].replace("7","9")
					input_list[i] = input_list[i].replace("9","7")
					print(input_list[i])

					
			#otherwise we need to enter the array for that frame's input and alter the interior strings
			elif typeof(input_list[i]) == TYPE_ARRAY:
				var j = 0
				while j < len(input_list[i]):
					if my_player.my_facing != 1:
						input_list[i][j] = input_list[i][j].replace("6","4")
						input_list[i][j] = input_list[i][j].replace("3","1")
						input_list[i][j] = input_list[i][j].replace("1","3")
						input_list[i][j] = input_list[i][j].replace("4","6")
						input_list[i][j] = input_list[i][j].replace("7","9")
						input_list[i][j] = input_list[i][j].replace("9","7")
					j += 1
					
			i += 1
		#we're done altering the strings to match our current direction, time to actually check for the input
		#set up variables for the current index of the input and history, they should be 0
		var current_list_index = -1
		var current_history_index = -1
		#variable to track time difference between inputs
		var input_distance = 0
		while ((current_list_index*-1)<=len(input_history_buttons)) and ((current_list_index*-1)<=len(input_history_buttons)) and (input_distance <= input_leniency):
			#if the current input list index is a string, check if the input history has that button within input leniency
			if typeof(input_list[current_list_index]) == TYPE_STRING:
				if input_history_buttons[current_history_index].has(input_list[current_list_index]):
					if current_list_index*-1 == input_list.size():
								return(input_list)
					else:
						input_distance = input_history_frames[current_history_index]
						if current_list_index != -1:
							current_history_index -= 1
						current_list_index -= 1
				else:
						input_distance += input_history_frames[current_history_index]
						current_history_index -= 1
			#if the current input list index is a string, check if a frame in input history has both pressed
			elif typeof(input_list[current_list_index]) == TYPE_ARRAY:
				var has_inputs = true
				for current_list_index_inputs in input_list[current_list_index]:
					if !input_history_buttons[current_history_index].has(current_list_index_inputs):
						has_inputs = false
				if has_inputs:
					if current_list_index*-1 == input_list.size():
								return(input_list)
					else:
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
