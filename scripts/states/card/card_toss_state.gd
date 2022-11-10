extends GroundSpecialState
class_name CardTossState

func enter():
	super()
	player.anim_signal.connect(self.toss_card)
	player.anim_player.play("card_toss")

func toss_card():
	if player.anim_var == "toss":
		var my_card = player.move_list.tossed_card.instantiate()
		my_card.state_machine = state_machine
		player.add_child(my_card)
		#my_card.set_owner(player)
		#my_card.get_node("Hitbox").set_owner(player)
		my_card.position.y -= 20 
		my_card.position.x += 10*player.my_facing
		#my_card.position = player.position
		my_card.velocity.x = 200*player.my_facing
