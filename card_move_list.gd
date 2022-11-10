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
		["2","3","6","a"] #Card Throw A
		]
	air_specials = []
	ground_command_normals = []
	air_command_normals = []
	ground_normals = [
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
	air_normals = []



# Called every frame. 'delta' is the elapsed time since the previous frame.
func move_change_state(inputs : Array):
	match inputs:
		["a"]:
			state_machine.change_state(Card5aState.new())
		["b"]:
			state_machine.change_state(Card5bState.new())
		["c"]:
			state_machine.change_state(Card5cState.new())
		["d"]:
			state_machine.change_state(Card5dState.new())
		["2","3","6","a"]:
			state_machine.change_state(CardTossState.new())
		_:
			player.os.os_change_state(inputs)
