extends GroundActionableState
class_name IdleState

func enter():
	super()
	player.anim_play(player.character_name+"/idle")
	player.anim_player.advance(1.0/60.0)
	player.velocity.x = 0

func _physics_process(_delta):
	super(_delta)
	#print(player.velocity)
	


