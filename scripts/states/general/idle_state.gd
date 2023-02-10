extends GroundActionableState
class_name IdleState

func enter():
	super()
	player.anim_player.play("idle")
	player.velocity.x = 0

func _physics_process(_delta):
	super(_delta)
	#print(player.velocity)
	


