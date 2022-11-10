extends State
class_name AirState


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func enter():
	player.anim_player.play("jump")
	
func get_hit(hitbox : Hitbox):
	player.get_hurt(hitbox)
	return "hit"

func _physics_process(_delta):
	player.velocity.y += player.gravity
	if player.is_on_floor():
		state_machine.change_state(IdleState.new())
