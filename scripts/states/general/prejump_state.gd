extends State
class_name PrejumpState


func enter():
	player.anim_play(player.character_name+"/prejump")
	player.anim_player.animation_finished.connect(self._to_jump)


func _to_jump(_variable):
	state_machine.change_state(JumpState.new())
	print("Transitioning to jump.")
func exit():
	player.anim_player.animation_finished.disconnect(self._to_jump)
