extends CharacterBody2D
class_name Player

#Player script for generic stuff like holding components, turning the player, and a (WIP) getting hit function
@export var opponent: Node2D
var gravity = 4.0
var my_facing = 1
var state_machine : CharacterStateMachine
var anim_player : AnimationPlayer
var idle_start = IdleState.new()
var os : OSStyle
var move_list : MoveList
# Called when the node enters the scene tree for the first time.
func _ready():

	for node in get_children():
		if node is MoveList:
			move_list = node
	state_machine = $StateMachine
	anim_player = $AnimationPlayer
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
