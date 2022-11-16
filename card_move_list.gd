extends MoveList
class_name CardMoveList

var tossed_card = load("res://scenes/tossed_card.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	#edit inputs here, godot hates letting me overwrite inherited variables
	ground_supers = []
	air_supers = []
	ground_specials = [
		["2","3","6","a"], #Card Throw A
		["2","3","6","c"] #also card throw A for now
		]
	air_specials = []
	ground_command_normals = []
	air_command_normals = []
	ground_normals = [
		#use "down" instead of "2" for crouching normals. this ensures that 3a and 1a still count for the move. if you want *exactly* 2a, use 2a.
		[["down","a"]],
		["a"], #5a
		["b"], #5b
		["c"],
		["d"]
	]
	ground_normals_a = [
		["a"]
	]
	ground_normals_b = [
		["b"]
	]
	ground_normals_c = [
		["c"]
	]
	ground_normals_d = [
		["d"]
	]
	air_normals = [
		
	["a"],
	["b"]
	]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func move_change_state(inputs : Array):
	if player.state_machine.current_state.tags.has("ground"):
		match inputs:
			["a"]:
				state_machine.change_state(Card5aState.new())
			["b"]:
				state_machine.change_state(Card5bState.new())
			["c"]:
				state_machine.change_state(Card5cState.new())
			["d"]:
				state_machine.change_state(Card5dState.new())
			[["down","a"]]:
				print("down a works")
			["2","3","6","a"]:
				state_machine.change_state(CardTossState.new())
			["2","3","6","c"]:
				state_machine.change_state(CardTossState.new())
			_:
				player.os.os_change_state(inputs)
	elif player.state_machine.current_state.tags.has("air"):
		match inputs:
			["a"]:
					state_machine.change_state(CardjaState.new())
			["b"]:
				state_machine.change_state(CardjbState.new())
