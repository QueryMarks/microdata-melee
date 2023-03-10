extends GroundSpecialState
class_name CardSummonaState


# Called when the node enters the scene tree for the first time.
func enter():
	super()
	player.anim_play(player.character_name+"/card_summon")
	var my_summon = player.move_list.summon_2.instantiate()
	my_summon.get_child(0).player = player
	my_summon.get_child(0).get_node("Sprite2D").material = my_summon.get_child(0).get_node("Sprite2D").material.duplicate()
	my_summon.get_child(0).get_node("Sprite2D").material.set_shader_parameter("palette", player.get_node("Deck").which_suit(0))
	get_tree().get_root().get_node("RoundStart").add_child(my_summon)
	
	my_summon.position.x = player.position.x - (20*player.my_facing)
	my_summon.scale.x *= player.my_facing

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
