extends GroundSpecialState
class_name CardRefillState

var summon_anims = ["card_summon", "card_summon_2", "card_summon_3", "card_summon_4"]

func enter():
	super()
	var deck = player.get_node("Deck")
	var rando = randi_range(0, summon_anims.size()-1)
	player.anim_play(player.character_name+"/"+summon_anims[rando])
	deck.refill_hand()
