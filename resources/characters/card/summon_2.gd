extends Projectile

var player : Player
var idle = true
var hitstop_timer
var hitstop = false

func _ready():
	hitstop_timer = $HitstopTimer
	hitstop_timer.timeout.connect(hit_restart)
	$AnimationPlayer.play("summon_2_idle")
	get_parent().get_parent().remove_me.append(get_parent())
	$Hitbox.player_index = player.player_index
	$Hitbox.player = player
	$Hitbox.this_hit_something.connect(hit_stop_do_it)
	state_machine = player.state_machine
	

func _physics_process(_delta):
	if idle and (!Input.is_action_pressed(player.input_a)):
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
