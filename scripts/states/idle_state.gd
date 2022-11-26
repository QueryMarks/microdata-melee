extends GroundActionableState
class_name IdleState

func enter():
	super()
	player.anim_player.play("idle")
	print(Time.get_datetime_string_from_system())
	player.velocity.x = 0

func _physics_process(delta):
	super(delta)
	


