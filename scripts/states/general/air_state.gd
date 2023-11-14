extends State
class_name AirState


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func enter():
	player.anim_play(player.character_name+"/jump")
	
func get_hit(hitbox : Hitbox):
	player.get_hurt(hitbox)
	return "hit"

func _physics_process(_delta):
	player.velocity.y += player.gravity
	if player.is_on_floor():
		if (player.position.x > player.opponent.position.x) and (player.my_facing != -1):
			player.turn()
		elif (player.position.x < player.opponent.position.x) and (player.my_facing != 1):
			player.turn()
		state_machine.change_state(IdleState.new())
