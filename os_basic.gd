extends OSStyle
class_name OSBasic

func os_action_check(tags : Array):
	var inputs
	#for states like idle, walk, crouch etc
	if tags.has("ground"):
		
		if tags.has("actionable"):
			inputs = input_reader.read_inputs(move_list.ground_supers + move_list.ground_specials + move_list.ground_command_normals + move_list.ground_normals + [["6","5","6"], ["o"]])
		
		elif tags.has("can_cancel"):
		
		#os will call any special actions for the os such as super moves, ex moves, dashing, super jumping, etc in order of priority.
		#input_list = player.movelist.
			if tags.has("normal"):
				if tags.has("a"):
					inputs = input_reader.read_inputs(move_list.ground_supers + move_list.ground_specials + move_list.ground_command_normals + move_list.ground_normals_b + move_list.ground_normals_c + move_list.ground_normals_d) 
			#os will then call the movelist's arrays for normal'
		
			elif tags.has("command_normal"):
				print("ground super, special ok")
			
			elif tags.has("special"):
				print("ground super ok")
		
	elif tags.has("air"):
		if tags.has("actionable"):
			print("all air actions ok")
		
		elif tags.has("can_cancel"):
		
		#os will call any special actions for the os such as super moves, ex moves, dashing, super jumping, etc in order of priority.
		#input_list = player.movelist.
			if tags.has("normal"):
				print("air super, special, and command normal cancel ok")
			#os will then call the movelist's arrays for normal'
		
			elif tags.has("command_normal"):
				print("air super, special ok")
			
			elif tags.has("special"):
				print("air super ok")
	if inputs != null:
		print(inputs)
		if player.hitstop == true:
			player.hit_restart
		move_list.move_change_state(inputs)
		return true
	else:
		return false
func os_change_state(inputs):
	match inputs:
		["6","5","6"]:
			player.state_machine.change_state(DashState.new())
		["o"]:
			player.state_machine.change_state(DashState.new())
