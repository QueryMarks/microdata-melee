extends CardSummon


func _ready():
	super()
	$AnimationPlayer.play("summon_2_idle")
	
func _physics_process(_delta):
	if idle:
		if summon_timer < 10:
			summon_timer += 1
		elif (!Input.is_action_pressed(player.input_a)):
			idle = false
			$AnimationPlayer.play("summon_2_dash")	
		
func hit_stop_do_it():
	hit_stop($Hitbox.hitstop)

func hit_stop(stop : int):
	hitstop = true
	if stop == 0:
		return
	set_physics_process(false)
	$AnimationPlayer.pause()
	hitstop_timer.stop()
	hitstop_timer.start(stop/60.0)
	
func hit_restart():
	hitstop_timer.stop()
	set_physics_process(true)
	state_machine.current_state.set_physics_process(true)
	$AnimationPlayer.play()
	hitstop = false
