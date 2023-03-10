extends Projectile

var player : Player
var idle = true
var summon_timer = 0

func _ready():
	$AnimationPlayer.play("summon_2_idle")
	get_parent().get_parent().remove_me.append(get_parent())
	$Hitbox.player_index = player.player_index
	$Hitbox.player = player
	state_machine = player.state_machine
	

func _physics_process(delta):
	if idle:
		if summon_timer < 10:
			summon_timer += 1
		elif (!Input.is_action_pressed(player.input_a)):
			idle = false
			$AnimationPlayer.play("summon_2_dash")	
