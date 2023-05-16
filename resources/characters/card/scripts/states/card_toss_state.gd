extends GroundSpecialState
class_name CardTossState

var card_index = 0

func _init(index = 0):
	card_index = index
	

func enter():
	super()
	if player.get_node("Deck").hand[card_index] != null:
		player.anim_signal.connect(self.toss_card)
		player.anim_play("card/card_toss")
	else:
		player.anim_play("card/card_toss_fail")

func toss_card():
	if player.anim_var == "toss":
		var my_card = player.move_list.tossed_card.instantiate()
		my_card.get_node("Sprite2D").material = my_card.get_node("Sprite2D").material.duplicate()
		my_card.get_node("Sprite2D").material.set_shader_parameter("palette", player.get_node("Sprite2D").material.get_shader_parameter("palette"))
		my_card.state_machine = state_machine
		my_card.get_node("Hitbox").player_index = player.player_index
		my_card.get_node("Hitbox").player = player
		
		
	
		my_card.position.y = player.position.y - 20 
		my_card.position.x = player.position.x + 10*player.my_facing
		my_card.velocity.x = 200*player.my_facing
		
		get_tree().get_root().add_child(my_card)
		print(card_index)
		player.get_node("Deck").card_used(card_index)
