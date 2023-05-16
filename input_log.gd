extends Node
class_name InputLog

@export var my_device = 0
@export var player : Node

var input_log = []

var temp_input_dict = {}
var input_leniency = 10
var first_input_leniency = 5
	
func _physics_process(_delta):
	var this_input_frame = InputFrames.new()

	#add inputs to this frame's dictionary.
	#numpad notation (1, 2, 3, etc) are used for precise inputs. direction notation (down, up, back, forward) are used for cardinal directions -- for example, 1, 2, and 3 would all still register "down". useful for crouching moves or moves that aren't picky about diagonals
	if Input.is_action_pressed(player.input_up) and !Input.is_action_pressed(player.input_down): 
		this_input_frame.input.append("up")
		if Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right):
			this_input_frame.input.append("back")
			this_input_frame.input.append("7")
		elif Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left):
			this_input_frame.input.append("forward")
			this_input_frame.input.append("9")
		else:
			this_input_frame.input.append("8")
	elif Input.is_action_pressed(player.input_down) and !Input.is_action_pressed(player.input_up):
		this_input_frame.input.append("down")
		if Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right):
			this_input_frame.input.append("back")
			this_input_frame.input.append("1")
			
		elif Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left):
			this_input_frame.input.append("forward")
			this_input_frame.input.append("3")
		else:
			this_input_frame.input.append("2")

	elif Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right):
		this_input_frame.input.append("back")
		this_input_frame.input.append("4")
	elif Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left):
		this_input_frame.input.append("forward")
		this_input_frame.input.append("6")
	else:
		this_input_frame.input.append("5")
	if Input.is_action_pressed(player.input_a):
		this_input_frame.input.append("a")
	if Input.is_action_pressed(player.input_b):
		this_input_frame.input.append("b")
	if Input.is_action_pressed(player.input_c):
		this_input_frame.input.append("c")
	if Input.is_action_pressed(player.input_d):
		this_input_frame.input.append("d")
	if Input.is_action_pressed(player.input_o):
		this_input_frame.input.append("o")
	if ((input_log == []) or !(this_input_frame.input == input_log.back().input)):
		if input_log != []:
			print("This frame's input is " + str(this_input_frame.input) + ". The previous input was " + str(input_log.back().input))
		input_log.append(this_input_frame)
		
	input_log.back().frames += 1

