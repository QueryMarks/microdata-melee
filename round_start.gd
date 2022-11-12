extends Node

@export var p1_character : String
@export var p1_os : String
@export var p1_palette : Texture2D
var p1

@export var p2_character : String
@export var p2_os : String
@export var p2_palette : Texture2D
var p2

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var camera = preload("res://scenes/stage_camera.tscn").instantiate()
	add_child(camera)
	camera.position = Vector2(0,0)
	#var camera = get_node("StageCamera")
	p1 = load("res://scenes/characters/"+p1_character+".tscn").instantiate()
	p1.add_child(load("res://scripts/os/"+p1_os+".tscn").instantiate())
	p1.get_node("Sprite2D").material.set_shader_parameter("palette", p1_palette)

	
	
	p2 = load("res://scenes/characters/"+p2_character+".tscn").instantiate()
	p2.add_child(load("res://scripts/os/"+p2_os+".tscn").instantiate())
	p2.get_node("Sprite2D").material.set_shader_parameter("palette", p2_palette)
	
	p1.player_index = 1
	p2.player_index = 2
	
	camera.player_1 = p1
	camera.player_2 = p2
	
	p1.opponent = p2
	p2.opponent = p1
	
	p1.position = Vector2(-40, 1)
	p2.position = Vector2(40, 1)
	

	add_child(p1)
	add_child(p2)
