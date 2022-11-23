extends GroundActionableState
class_name IdleState

func enter():
	super()
	player.anim_player.queue("idle")
	player.velocity.x = 0

func _physics_process(delta):
	super(delta)
	


