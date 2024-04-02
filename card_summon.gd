extends Projectile
class_name CardSummon

var player : Player
var idle = true
var hitstop_timer
var hitstop = false
var my_rank : CardRank
var my_suit : CardSuit
var my_input : String
@export var my_idle_anim : String
@export var my_release_anim : String
var sprite

var summon_timer = 0

func _ready():
	sprite = $Sprite2D
	sprite.material = sprite.material.duplicate()
	sprite.material.set_shader_parameter("palette", player.get_node("Sprite2D").material.get_shader_parameter("palette"))
	
	#var suit_colors = $SuitColors
	#suit_colors.material = suit_colors.material.duplicate()
	#suit_colors.material.set_shader_parameter("palette", my_suit.palette)
	
	
	hitstop_timer = $HitstopTimer
	hitstop_timer.timeout.connect(hit_restart)
	get_parent().get_parent().remove_me.append(get_parent())
	var hitbox = $Hitbox
	hitbox.player_index = player.player_index
	hitbox.player = player
	hitbox.this_hit_something.connect(hit_stop_do_it)
	state_machine = player.state_machine
	if my_idle_anim == "":
		my_idle_anim = "card_summons/summon_" + my_rank.rank_abbrev.to_lower() + "_idle"
	if my_release_anim == "":
		my_release_anim = "card_summons/summon_" + my_rank.rank_abbrev.to_lower() + "_release"
	$AnimationPlayer.play(my_idle_anim)
	
func _physics_process(_delta):
	if idle:
		if summon_timer < 10:
			summon_timer += 1
		elif (!Input.is_action_pressed(my_input)):
			idle = false
			$AnimationPlayer.play(my_release_anim)
		
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
