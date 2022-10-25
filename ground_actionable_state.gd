extends State
class_name GroundActionableState


# Called when the node enters the scene tree for the first time.
func _ready():
	tags += ["ground","actionable"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if (player.position.x > player.opponent.position.x) and (player.my_facing != -1):
		player.turn(-1)
	elif (player.position.x < player.opponent.position.x) and (player.my_facing != 1):
		player.turn(1)
		
	if (Input.is_action_just_pressed("ui_a")):
		player.os.os_action_check(tags)
	#if (Input.is_action_just_pressed("ui_right")) or (Input.is_action_just_pressed("ui_left")):
		#player.os.os_action_check(tags)

	elif (Input.is_action_pressed("ui_up")): 
		state_machine.change_state(JumpState.new())
	elif ((Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right")) or (Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_left"))):
		state_machine.change_state(WalkState.new())
