extends Node
class_name MoveList

@export var player : Node
@export var input_reader : Node
@export var state_machine : Node

#These arrays hold groups of inputs. Each array is used when checking for specific groups of moves via os_action_check.
#Override these variables in your character's move_list's _ready() or _init() method!
var ground_supers = []
var air_supers = []
var ground_specials = []
var air_specials = []
var ground_throw = []
var ground_command_normals = []
var air_command_normals = []
var ground_normals = []
var ground_normals_a = []
var ground_normals_b = []
var ground_normals_c = []
var ground_normals_d = []
var air_normals = []
var air_normals_a = []
var air_normals_b = []
var air_normals_c = []
var air_normals_d = []

#
var my_5a
var my_5b
var my_5c
var my_2a
var my_2b
var my_2c
var my_ja
var my_jb
var my_jc
var my_idle
var my_walk
var my_jump
var my_run
var my_grab
var my_throw


func _ready():
	player = self.get_parent()
	input_reader = player.get_node("InputReader")
	state_machine = player.get_node("StateMachine")

func move_change_state(_inputs : Array):
	pass
