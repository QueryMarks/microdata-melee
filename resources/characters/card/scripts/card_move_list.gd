extends MoveList
class_name CardMoveList

var tossed_card = load("res://resources/characters/card/tossed_card.tscn")
# Called when the node enters the scene tree for the first time.
func _init():
	super()
	#edit inputs here, godot hates letting me overwrite inherited variables
	ground_supers = []
	air_supers = []
	ground_specials = [
		["2","3","6","a"], #Card Throw A
		["2","3","6","b"],
		["2","3","6","c"] #also card throw A for now
		]
	air_specials = []
	ground_throw = [
		[["a","b"]]
	]
	ground_command_normals = []
	air_command_normals = []
	ground_normals = [
		#use "down" instead of "2" for crouching normals. this ensures that 3a and 1a still count for the move. if you want *exactly* 2a, use 2a.
		[["down","a"]],
		[["down","b"]],
		[["down","c"]],
		["a"], #5a
		["b"], #5b
		["c"],
		["d"]
	]
	ground_normals_a = [
		[["down","a"]],
		["a"]
	]
	ground_normals_b = [
		[["down","b"]],
		["b"]
	]
	ground_normals_c = [
		[["down","c"]],
		["c"]
	]
	ground_normals_d = [
		["d"]
	]
	air_normals = [
		
	["a"],
	["b"]
	]
	
	air_normals_a = [
		
		["a"]
	]
	
	air_normals_b = [
		
		["b"]
	]

	my_5a = Card5aState
	my_5b = Card5bState
	my_5c = Card5cState
	my_2a = Card2aState
	my_2b = Card2bState
	my_2c = Card2cState
	my_ja = CardjaState
	my_jb = CardjbState
	my_grab = GrabState
	my_throw = ThrowState
	#add below when CardjcState is implemented
	#my_jc = CardjcState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func move_change_state(inputs : Array):
	if player.state_machine.current_state.tags.has("ground"):
		match inputs:
			["a"]:
				state_machine.change_state(my_5a.new())
			["b"]:
				state_machine.change_state(my_5b.new())
			["c"]:
				state_machine.change_state(my_5c.new())
			["d"]:
				state_machine.change_state(Card5dState.new())
			[["down","a"]]:
				state_machine.change_state(my_2a.new())
			[["down","b"]]:
				state_machine.change_state(my_2b.new())
			[["down","c"]]:
				state_machine.change_state(my_2c.new())
			[["a","b"]]:
				state_machine.change_state(my_grab.new())
			["2","3","6","a"]:
				state_machine.change_state(CardTossState.new())
			["2","3","6","b"]:
				state_machine.change_state(CardTossState.new())
			["2","3","6","c"]:
				state_machine.change_state(CardTossState.new())
			_:
				player.os.os_change_state(inputs)
	elif player.state_machine.current_state.tags.has("air"):
		match inputs:
			["a"]:
				state_machine.change_state(my_ja.new())
			["b"]:
				state_machine.change_state(my_jb.new())
