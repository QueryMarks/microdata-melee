extends GroundSpecialState
class_name CardSummonaState


# Called when the node enters the scene tree for the first time.
func enter():
	super()
	var deck = player.get_node("Deck")
	player.anim_play(player.character_name+"/card_summon")
	var my_summon = deck.hand[0].rank.summon.instantiate()
	var my_summon_script = my_summon.get_child(0)
	my_summon_script.player = player
	my_summon_script.my_rank = deck.hand[0].rank
	my_summon_script.my_suit = deck.hand[0].suit
	my_summon_script.my_input = player.input_a
	
	#my_summon.get_child(0).get_node("Sprite2D").material.set_shader_parameter("palette", player.get_node("Deck").)
	get_tree().get_root().get_node("RoundStart").add_child(my_summon)
	
	my_summon.position.x = player.position.x
	my_summon.scale.x *= player.my_facing

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
