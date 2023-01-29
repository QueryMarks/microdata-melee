extends GroundActionableState
class_name IdleState

func enter():
	super()
	player.anim_player.play("idle")
	player.velocity.x = 0

func _physics_process(delta):
	super(delta)
	#print(player.velocity)
	


