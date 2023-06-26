extends MoveList
class_name CardMoveList

var tossed_card = load("res://resources/characters/card/tossed_card.tscn")
var summon_2 = load("res://resources/characters/card/summon_2.tscn")

func get_summon_path(rank : String):
	return ("res://resources/characters/card/summon_" + rank + ".tscn")




# Called when the node enters the scene tree for the first time.
func _init():
	super()
	my_5a = Move.new([["a"]], Card5aState)
	my_5b = Move.new([["b"]], Card5bState)
	my_5c = Move.new([["c"]], Card5cState)
	my_2a = Move.new([[["down","a"]]], Card2aState)
	my_2b = Move.new([[["down","b"]]],Card2bState)
	my_2c = Move.new([[["down","c"]]],Card2cState)
	my_ja = Move.new([["a"]],CardjaState)
	my_jb = Move.new([["a"]],CardjbState)
	my_grab = Move.new([[["a","b"]]],GrabState)
	my_throw = ThrowState
	
	
	var my_card_toss_a = Move.new([["2","3","6","a"]], CardTossState)
	var my_card_summon_a = Move.new([["2","1","4","a"]], CardSummonaState)
	var my_card_refill = Move.new([["2","5","2","a"]], CardRefillState)
	var my_card_shuffle = Move.new([["2","5","2","c"]], CardShuffleState)
	#edit inputs here, godot hates letting me overwrite inherited variables
	ground_supers = []
	air_supers = []
	ground_specials = [
		my_card_toss_a, #Card Throw A
		my_card_summon_a,
		my_card_refill,
		my_card_shuffle
		]
	air_specials = []
	ground_grab = [
		my_grab
	]
	ground_command_normals = []
	air_command_normals = []
	ground_normals = [
		#use "down" instead of "2" for crouching normals. this ensures that 3a and 1a still count for the move. if you want *exactly* 2a, use 2a.
		my_2a,
		my_2b,
		my_2c,
		my_5a, #5a
		my_5b, #5b
		my_5c,
	]
	ground_normals_a = [
		my_2a,
		my_5a
	]
	ground_normals_b = [
		my_2b,
		my_5b
	]
	ground_normals_c = [
		my_2c,
		my_5c
	]
	ground_normals_d = [
		
	]
	air_normals = [
		
	my_ja,
	my_jb
	]
	
	air_normals_a = [
		
		my_ja
	]
	
	air_normals_b = [
		
		my_jb
	]


# Old. Does nothing anymore.
func move_change_state(inputs : Array):
	pass
#	if player.state_machine.current_state.tags.has("ground"):
#		match inputs:
#			["a"]:
#				state_machine.change_state(my_5a.new())
#			["b"]:
#				state_machine.change_state(my_5b.new())
#			["c"]:
#				state_machine.change_state(my_5c.new())
#			["d"]:
#				state_machine.change_state(Card5dState.new())
#			[["down","a"]]:
#				state_machine.change_state(my_2a.new())
#			[["down","b"]]:
#				state_machine.change_state(my_2b.new())
#			[["down","c"]]:
#				state_machine.change_state(my_2c.new())
#			[["a","b"]]:
#				state_machine.change_state(my_grab.new())
#			["2","3","6","a"]:
#				state_machine.change_state(CardTossState.new())
#			["2","3","6","b"]:
#				state_machine.change_state(CardTossState.new())
#			["2","3","6","c"]:
#				state_machine.change_state(CardTossState.new())
#			["2","1","4","a"]:
#				state_machine.change_state(CardSummonaState.new())
#			_:
#				player.os.os_change_state(inputs)
#	elif player.state_machine.current_state.tags.has("air"):
#		match inputs:
#			["a"]:
#				state_machine.change_state(my_ja.new())
#			["b"]:
#				state_machine.change_state(my_jb.new())
