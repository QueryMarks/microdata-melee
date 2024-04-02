extends GroundSpecialState
class_name CardSummonbState

var summon_anims = ["card_summon", "card_summon_2", "card_summon_3", "card_summon_4"]
# Called when the node enters the scene tree for the first time.
func enter():
	super()
	var deck = player.get_node("Deck")
	var rando = randi_range(0, summon_anims.size()-1)
	player.anim_play(player.character_name+"/"+summon_anims[rando])
	
	if (deck.hand[1]):
		
		var my_summon = deck.hand[1].rank.summon.instantiate()
		var my_summon_script = my_summon.get_child(0)
		my_summon_script.player = player
		my_summon_script.my_rank = deck.hand[1].rank
		my_summon_script.my_suit = deck.hand[1].suit
		my_summon_script.my_input = player.input_b
		
		deck.card_used(1)
		
		#my_summon.get_child(0).get_node("Sprite2D").material.set_shader_parameter("palette", player.get_node("Deck").)
		get_tree().get_root().get_node("RoundStart").add_child(my_summon)
		
		my_summon.position.x = player.position.x
		my_summon.scale.x *= player.my_facing
	else:
		print("no card in hand")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
