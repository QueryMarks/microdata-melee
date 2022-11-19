extends CharacterBody2D
class_name Player

#Player script for generic stuff like holding components, turning the player, and a (WIP) getting hit function
@export var character_name : String
@export var gravity = 7.5
@export var max_hp := 100.0
var hp := 100.0

var opponent: Node2D
var player_index := 1
var my_facing = 1
var state_machine : CharacterStateMachine
var anim_player : AnimationPlayer
var idle_start = IdleState.new()
var os : OSStyle
var move_list : MoveList
var input_a
var input_b
var input_c
var input_d
var input_o
var input_up
var input_down
var input_left
var input_right
var pushbox : Area2D
var hitstop = false

#hitstop stuff, clean up later?
var hitstop_timer : Timer
var temp_velocity : Vector2

#for use with anim_signal()
var anim_var : String
signal anim_signal

signal damaged

# Called when the node enters the scene tree for the first time.
func _ready():

	for node in get_children():
		if node is MoveList:
			move_list = node
	state_machine = $StateMachine
	anim_player = $AnimationPlayer
	pushbox = $Pushbox
	hitstop_timer = $HitstopTimer
	hitstop_timer.timeout.connect(hit_restart)
	#set up inputs
	input_a = str("p"+str(player_index)+"_a")
	input_b = str("p"+str(player_index)+"_b")
	input_c = str("p"+str(player_index)+"_c")
	input_d = str("p"+str(player_index)+"_d")
	input_o = str("p"+str(player_index)+"_o")
	input_up = str("p"+str(player_index)+"_up")
	input_down = str("p"+str(player_index)+"_down")
	input_left = str("p"+str(player_index)+"_left")
	input_right = str("p"+str(player_index)+"_right")
	state_machine.initialize(idle_start, self, $InputReader)
	if self.position.x < opponent.position.x:
		my_facing = 1
	else:
		turn(-1)
	
	hp = max_hp
	

func turn(facing: int):
	
	self.scale.x *= -1
	my_facing = facing
	
func take_damage(damage):
	hp -= damage
	hp = clamp(hp, 0, max_hp)
	print(hp)
	emit_signal("damaged")

func get_hit(hitbox : Hitbox):
	return state_machine.current_state.get_hit(hitbox)
	
func get_hurt(hitbox : Hitbox):
	hitstop = false
	print("i am player " + str(player_index) + " with hitbox knockback " + str(hitbox.knockback))
	if self.is_on_floor():
		state_machine.change_state(HurtState.new())
		velocity.x = hitbox.knockback.x * sign(global_position.x - hitbox.global_position.x)
	else:
		state_machine.change_state(AirHurtState.new())
		velocity.x = hitbox.knockback.x * sign(global_position.x - hitbox.global_position.x)
		velocity.y = hitbox.knockback.y
	state_machine.current_state.hitstun = hitbox.hitstun
	hit_stop(hitbox.hitstop)
	
func block(hitbox : Hitbox):
	if self.is_on_floor():
		if hitbox.hit_type == "mid":
			if Input.is_action_pressed(input_down):
				state_machine.change_state(CrouchBlockState.new())

			else:
				state_machine.change_state(BlockState.new())
			state_machine.current_state.blockstun = hitbox.blockstun
			hit_stop(hitbox.blockstop)
		elif hitbox.hit_type == "high":
			if !Input.is_action_pressed(input_down):
				state_machine.change_state(BlockState.new())
				state_machine.current_state.blockstun = hitbox.blockstun
				hit_stop(hitbox.blockstop)
			else:
				get_hurt(hitbox)
		elif hitbox.hit_type == "low":
			if Input.is_action_pressed(input_down):
				state_machine.change_state(CrouchBlockState.new())
				state_machine.current_state.blockstun = hitbox.blockstun
				hit_stop(hitbox.blockstop)
			else:
				get_hurt(hitbox)

func _physics_process(delta):
	self.move_and_slide()
	#push other player
	if pushbox.get_overlapping_areas().has(opponent.pushbox):
		if pushbox.global_position.x == opponent.pushbox.global_position.x:
			pushbox.global_position.x += 0.001
		if abs(pushbox.global_position.x - opponent.pushbox.global_position.x) < 0.1:
			self.position.x += 1*sign(pushbox.global_position.x - opponent.pushbox.global_position.x)
		else:
			self.position.x += 10/(pushbox.global_position.x - opponent.pushbox.global_position.x)

func hit_stop(stop : int):
	set_physics_process(false)
	state_machine.current_state.set_physics_process(false)
	if state_machine.current_state.tags.has("hurt") or state_machine.current_state.tags.has("block"):
		anim_player.call_deferred("advance", 1.0/60.0)
	anim_player.stop(false)
	hitstop_timer.stop()
	hitstop_timer.start(stop/60.0)
	hitstop = true

func hit_restart():
	hitstop_timer.stop()
	set_physics_process(true)
	state_machine.current_state.set_physics_process(true)
	anim_player.play()
	hitstop = false
	
func anim_emit_signal(string : String):
	anim_var = string
	emit_signal("anim_signal")
