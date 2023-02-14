extends Hitbox
class_name Grabbox
@export var grab_point : Node2D
@export var valid_tags := ["ground"]
var grabbed_player
signal released


# Called every frame. 'delta' is the elapsed time since the previous frame.
func this_hit(grab_check, player_hit):
	match grab_check:
		"grab":
			grabbed_player = player_hit
			owner.state_machine.current_state.grab_success()
			
func release():
	grabbed_player.get_hurt(self)
	grabbed_player.take_damage(self.damage)
	grabbed_player = null

func release_no_dmg():
	grabbed_player.get_hurt(self)
	grabbed_player = null
	
func _physics_process(_delta):
	if grabbed_player != null and owner.state_machine.current_state.tags.has("hurt"):
		release_no_dmg()
