extends OSStyle
class_name OSBasic

func os_action_check(tags : Array):
	if !player.can_act:
		return false
	var inputs
	#for states like idle, walk, crouch etc
	if tags.has("ground"):
		
		if tags.has("actionable"):
			#for move in [move_list.ground_supers + move_list.ground_specials + move_list.ground_throw + move_list.ground_command_normals + move_list.ground_normals + [Move.new([["5","4","5","4"], ["4","o"]], BackdashState, 8), ["5","6","5","6"], ["o"]]):
			for move in move_list.ground_supers + move_list.ground_specials + move_list.ground_grab + move_list.ground_command_normals + move_list.ground_normals + [Move.new([["5","6","5","6"], ["6","o"]], DashState, 8)] + [Move.new([["5","4","5","4"], ["4","o"]], BackdashState, 8)]:
				if os_change_state_check(move):
					return true

		elif tags.has("can_cancel"):

		#os will call any special actions for the os such as super moves, ex moves, dashing, super jumping, etc in order of priority.
		#input_list = player.movelist.
			if tags.has("normal"):
				if tags.has("a"):
					for move in (move_list.ground_supers + move_list.ground_specials + move_list.ground_command_normals + move_list.ground_normals_b + move_list.ground_normals_c + move_list.ground_normals_d):
						if os_change_state_check(move):
							return true
				elif tags.has("b"):
					for move in (move_list.ground_supers + move_list.ground_specials + move_list.ground_command_normals + move_list.ground_normals_c + move_list.ground_normals_d):
						if os_change_state_check(move):
							return true
				elif tags.has("c"):
					for move in (move_list.ground_supers + move_list.ground_specials + move_list.ground_command_normals + move_list.ground_normals_d):
						if os_change_state_check(move):
							return true
				elif tags.has("d"):
					for move in (move_list.ground_supers + move_list.ground_specials + move_list.ground_command_normals):
						if os_change_state_check(move):
							return true

						#os will then call the movelist's arrays for normal

			elif tags.has("command_normal"):
				print("ground super, special ok")

			elif tags.has("special"):
				print("ground super ok")

		if tags.has("can_grab"):
			#print("can_grab")
			for move in (move_list.ground_grab):
				if os_change_state_check(move):
					return true
	elif tags.has("air"):
		if tags.has("actionable"):
			for move in (move_list.air_normals):
				if os_change_state_check(move):
					return true

		elif tags.has("can_cancel"):

		#os will call any special actions for the os such as super moves, ex moves, dashing, super jumping, etc in order of priority.
		#input_list = player.movelist.
			if tags.has("normal"):
				if tags.has("a"):
					for move in (move_list.air_normals_b + move_list.air_normals_c + move_list.air_normals_d):
						if os_change_state_check(move):
							return true
			#os will then call the movelist's arrays for normal'

			elif tags.has("command_normal"):
				print("air super, special ok")

			elif tags.has("special"):
				print("air super ok")
	return false
func os_change_state_check(move : Move):
	if move.check_inputs(input_log.input_log, player.my_facing):
		player.state_machine.change_state(move.state.new())
		return true
	else:
		return false
