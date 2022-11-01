extends CharacterBody2D
class_name Player

#Player script for generic stuff like holding components, turning the player, and a (WIP) getting hit function
@export var opponent: Node2D
@export var player_index := 1
var inputs: Node
var gravity = 6.0
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
# Called when the node enters the scene tree for the first time.
func _ready():

	for node in get_children():
		if node is MoveList:
			move_list = node
	state_machine = $StateMachine
	anim_player = $AnimationPlayer
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
	

func turn(facing: int):
	
	self.scale.x *= -1
	my_facing = facing
	
func get_hit(hitbox : Hitbox):
	return state_machine.current_state.get_hit(hitbox)
	
func _physics_process(delta):
	self.move_and_slide()
