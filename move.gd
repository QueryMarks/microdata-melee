class_name Move

# Contains array of valid move input sequences, example: [["2", "3", "6", "a"], ["2", "3", "6", "b"]]
var move_input_sequences = []
# Number of frames allowed between inputs in sequence. Charge moves or moves with very unique inputs should inherit this class and alter its logic.
var lenience := 8
# State to change to on a valid input sequence.
var state : GDScript

func _init(mis, s, l = 8):
	move_input_sequences = mis
	state = s
	lenience = l
# Method to check if inputs match a move input sequence. Takes an array of inputs.
func check_inputs(input_log, facing):
	#reverse inputs, if necessary
	#for each input sequence that can perform the move, example: ["2", "3", "6", "a"]
	for input_sequence in move_input_sequences:
		#if not facing right, flip input sequence, example: ["2", "1", "4", "a"]
		if facing != 1:
			input_sequence = flip_input_sequence(input_sequence)
		var valid = true
		var current_log_index = input_log.size() -1 
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
			print(str(input_sequence) + " was valid.")
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
