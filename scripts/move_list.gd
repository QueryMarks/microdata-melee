extends Node
class_name MoveList

@export var player : Node
@export var input_reader : Node
@export var state_machine : Node

var ground_supers = []
var air_supers = []
var ground_specials = []
var air_specials = []
var ground_command_normals = []
var air_command_normals = []
var ground_normals = []
var ground_normals_a = []
var ground_normals_b = []
var ground_normals_c = []
var ground_normals_d = []
var air_normals = []

func _ready():
	player = self.get_parent()
	input_reader = player.get_node("InputReader")
	state_machine = player.get_node("StateMachine")

func move_change_state(_inputs : Array):
	pass
