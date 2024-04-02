class_name Move

# Contains array of valid move input sequences, example: [["2", "3", "6", "a"], ["2", "3", "6", "b"]]
var move_input_sequences = []

# Number of frames allowed between inputs in sequence. Charge moves or moves with very unique inputs should inherit this class and alter its logic.
var lenience := 8

# Number of frames allowed between final input of the move being pressed and the input being checked. 5 by default.
var first_lenience := 3

# Number of frames allowed between "simultaneous" button inputs, such as ab for grab. 3 by default.
var simultaneous_button_lenience := 4

# State to change to on a valid input sequence.
var state : GDScript

func _init(mis, s, l = lenience, fl = first_lenience):
	move_input_sequences = mis
	state = s
	lenience = l
	first_lenience = fl
	
	
# Method to check if inputs match a move input sequence. Takes an array of inputs. This section is *really* hard to parse; I'd like to clean it up.
func check_inputs(input_log, facing):
	#for each input sequence that can perform the move, example: ["2", "3", "6", "a"]
	for input_sequence in move_input_sequences:
		#if not facing right, flip input sequence, example: ["2", "1", "4", "a"]
		if facing != 1:
			input_sequence = flip_input_sequence(input_sequence)
		var valid = true
		var current_log_index = input_log.size() -1 
		
		
		#do not perform input check if last input in sequence was not started in log within the past 5 frames
		var last_input_in_sequence = input_sequence.back()
		#first_lenience_check tracks how many frames backwards we've looked for the last input in the sequence. starts at 0. once it goes past first_lenience, we stop checking and the move input is invalid
		var first_lenience_check = 0
		var first_input_in_log = false
		#button_inputs tracks if the input is a button or a direction. inputs like 6a should be valid even if 6 is held, but inputs like ab should not be valid if one button has been held for too long
		var button_inputs = ["a", "b", "c", "d", "o", "s"]
		
		#iterate backwards through every input in the log. Will stop at 0, the first input recorded, although the for loop is broken when we get past "first_lenience_check".
		for j in range(current_log_index, -1, -1):
			#if the last input of the sequence is a singular button or direction, not a combination
			if typeof(last_input_in_sequence) == TYPE_STRING:
				#if we haven't yet found the first input, and if it's in the current log index,
				if (!first_input_in_log) and (last_input_in_sequence in input_log[j].input):
					first_input_in_log = true
					first_lenience_check += input_log[j].frames
				#else, if the first input has been found and *is not* still inputted at the current log. this means tapped inputs like "a" will not register as valid if "a" is held for too long.
				elif (first_input_in_log) and !(last_input_in_sequence in input_log[j].input):
					break
				else:
					first_lenience_check += input_log[j].frames
			elif typeof(last_input_in_sequence) == TYPE_ARRAY:
				#set a variable to track if all simultaneous inputs can be found. if so, execute the move. if one simultaneous input is found to be false, the move does not execute
				var simultaneous_inputs_valid = true
				for input_part in last_input_in_sequence:
					if !input_part in input_log[j].input:
						simultaneous_inputs_valid = false
						break
					else:
						for k in range(j, -1, -1):
							var simul_held_tracker = 0;
							#If this part of the input is a button, make sure it started being pressed in the past few frames.
							if input_part in button_inputs:
								if input_part in input_log[k].input:
									simul_held_tracker += input_log[k].frames
									if simul_held_tracker > simultaneous_button_lenience:
										simultaneous_inputs_valid = false
										break
								else:
									break
				if !first_input_in_log and simultaneous_inputs_valid:
					first_input_in_log = true
					first_lenience_check += input_log[j].frames
				elif first_input_in_log and !simultaneous_inputs_valid:
					break
				else:
					first_lenience_check += input_log[j].frames
				
			if first_lenience_check > first_lenience:
							break			
				
		if (first_lenience_check <= first_lenience) and (first_input_in_log):
			for i in range(input_sequence.size() -1, -1, -1):
				if !valid:
					break
				var distance = 0
				for j in range(current_log_index, -1, -1):
					#print(str(input_log[j].input))
					#time passed in frames since last valid input was pressed in input_sequence
					if input_sequence[i] is String:
						if input_sequence[i] in input_log[j].input:
							break
						else:
							distance += input_log[j].frames
							current_log_index -= 1
							if distance > lenience:
								valid = false
								break
					elif input_sequence[i] is Array:
						var array_input_valid = true
						for each_input in input_sequence[i]:
							if !(each_input in input_log[j].input):
								array_input_valid = false	
						if array_input_valid:
							break
						else:
							distance += input_log[j].frames
							current_log_index -= 1
							if distance > lenience:
								valid = false
								break
			if valid:
				return true
			else:
				pass
	return false	

func flip_input_sequence(input_sequence):
	input_sequence = input_sequence.duplicate()
	for i in input_sequence.size():
		if typeof(input_sequence[i]) == TYPE_STRING:
			match input_sequence[i]:
				"6":
					input_sequence[i] = "4"
				"3":
					input_sequence[i] = "1"
				"1":
					input_sequence[i] = "3"
				"4":
					input_sequence[i] = "6"
				"7":
					input_sequence[i] = "9"
				"9":
					input_sequence[i] = "7"
				"back":
					input_sequence[i] = "forward"
				"forward":
					input_sequence[i] = "back"
		elif typeof(input_sequence[i]) == TYPE_ARRAY:
			for j in input_sequence[i].size():
				match input_sequence[i][j]:
					"6":
						input_sequence[i][j] = "4"
					"3":
						input_sequence[i][j] = "1"
					"1":
						input_sequence[i][j] = "3"
					"4":
						input_sequence[i][j] = "6"
					"7":
						input_sequence[i][j] = "9"
					"9":
						input_sequence[i][j] = "7"
					"back":
						input_sequence[i][j] = "forward"
					"forward":
						input_sequence[i][j] = "back"
	return input_sequence
