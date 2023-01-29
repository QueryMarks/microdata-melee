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
	if RoundStartInfo.p1_character != null:
		p1_character = RoundStartInfo.p1_character
	if RoundStartInfo.p2_character != null:
		p2_character = RoundStartInfo.p2_character
	var camera = preload("res://scenes/stage_camera.tscn").instantiate()
	add_child(camera)
	camera.position = Vector2(0,0)
	#var camera = get_node("StageCamera")
	p1 = load("res://resources/characters/"+p1_character+"/"+p1_character+".tscn").instantiate()
	p1.add_child(load("res://scripts/os/"+p1_os+".tscn").instantiate())
	p1.get_node("Sprite2D").material.set_shader_parameter("palette", p1_palette)
	var p1_bar = preload("res://scenes/hp_bar.tscn").instantiate()
	p1_bar.player = p1
	camera.add_child(p1_bar)
	p1_bar.position = Vector2(-70, -115)
	p1_bar.material.set_shader_parameter("palette", p1_palette)
	
	
	p2 = load("res://resources/characters/"+p2_character+"/"+p2_character+".tscn").instantiate()
	p2.add_child(load("res://scripts/os/"+p2_os+".tscn").instantiate())
	p2.get_node("Sprite2D").material.set_shader_parameter("palette", p2_palette)
	var p2_bar = preload("res://scenes/hp_bar.tscn").instantiate()
	p2_bar.player = p2
	camera.add_child(p2_bar)
	p2_bar.scale.x = -1
	p2_bar.position = Vector2(70, -115)
	p2_bar.material.set_shader_parameter("palette", p2_palette)
	
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
