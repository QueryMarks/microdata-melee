extends Node

@export var p1_character : String
@export var p1_os : String
@export var p1_palette : Texture2D
var p1
var p1_bar
var p1_rounds = []

@export var p2_character : String
@export var p2_os : String
@export var p2_palette : Texture2D
var p2
var p2_bar
var p2_rounds = []

var max_wins = 2

var camera : Node2D

var round_winner := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if RoundStartInfo.p1_character != null:
		p1_character = RoundStartInfo.p1_character
	if RoundStartInfo.p2_character != null:
		p2_character = RoundStartInfo.p2_character
	camera = get_node("StageCamera")
	camera.position = Vector2(0,0)
	#var camera = get_node("StageCamera")
	p1 = load("res://resources/characters/"+p1_character+"/"+p1_character+".tscn").instantiate()
	p1.add_child(load("res://scripts/os/"+p1_os+".tscn").instantiate())
	if RoundStartInfo.p1_palette != "":
		p1.get_node("Sprite2D").material.set_shader_parameter("palette", load(RoundStartInfo.p1_palette))
	p1_bar = preload("res://scenes/hp_bar.tscn").instantiate()
	p1_bar.player = p1
	camera.add_child(p1_bar)
	p1_bar.position = Vector2(-70, -115)
	p1_bar.material.set_shader_parameter("palette", p1_palette)
	p1_bar.health_zero.connect(round_end_p1)
	
	
	p2 = load("res://resources/characters/"+p2_character+"/"+p2_character+".tscn").instantiate()
	p2.add_child(load("res://scripts/os/"+p2_os+".tscn").instantiate())
	if RoundStartInfo.p2_palette != "":
		p2.get_node("Sprite2D").material.set_shader_parameter("palette", load(RoundStartInfo.p2_palette))
	p2_bar = preload("res://scenes/hp_bar.tscn").instantiate()
	p2_bar.player = p2
	camera.add_child(p2_bar)
	p2_bar.scale.x = -1
	p2_bar.position = Vector2(70, -115)
	p2_bar.material.set_shader_parameter("palette", p2_palette)
	p2_bar.health_zero.connect(round_end_p2)
	
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
	
	players_act(false)

	$RoundAnims.play("round_start")
	$StageCamera/Label.text = "Round " + str(len(p1_rounds)+1)
	
func players_act(yesno : bool):
	if yesno:
		camera.disable_walls(false)
	p1.can_act = yesno
	p2.can_act = yesno

func next_round():

	p1.get_node("Sprite2D").material.set_shader_parameter("palette", p1_palette)
	p1_bar.position = Vector2(-70, -115)
	p1_bar.material.set_shader_parameter("palette", p1_palette)
	
	
	p2.get_node("Sprite2D").material.set_shader_parameter("palette", p2_palette)
	p2_bar.position = Vector2(70, -115)
	p2_bar.material.set_shader_parameter("palette", p2_palette)
	
	p1.opponent = p2
	p2.opponent = p1
	
	p1.hp = p1.max_hp
	p2.hp = p2.max_hp
	p1_bar.update_bar()
	p2_bar.update_bar()
	
	camera.disable_walls(true)
	
	camera.position = Vector2(0,0)
	
	p1.position = Vector2(-40, 1)
	p2.position = Vector2(40, 1)
	

	
	p1.state_machine.change_state(IdleState.new())
	p2.state_machine.change_state(IdleState.new())
	
	players_act(false)
	
	$StageCamera/Label.text = "Round " + str(len(p1_rounds)+1)
	$RoundAnims.play("round_start")
	round_winner = 0
	

func round_end(loser : Player):
	if round_winner == 0:
		if loser.hp <= 0 and loser.opponent.hp <= 0:
			print("tie")
		else:
			if loser == p1:
				p1_rounds.append("loss")
				p2_rounds.append("win")
				round_winner = 2
			else:
				p2_rounds.append("loss")
				p1_rounds.append("win")
				round_winner = 1
		players_act(false)
		
		var winner = null
		var rounds_array = [p1_rounds, p2_rounds]
		for count in range(2):
			var wins = 0
			for game_round in rounds_array[count]:
				if game_round == "win":
					wins += 1
			if wins >= max_wins:
				winner = count+1
				break
		if winner == null:
			$RoundAnims.play("round_end")
			print("It's not over yet...")
		else:
			print("This game's winner is... Player " + str(winner))
			$StageCamera/Label.text = "Player " + str(winner) + " wins!"
			$RoundAnims.play("match_end")
func round_end_p1():
	round_end(p1)
	
func round_end_p2():
	round_end(p2)
	
func match_end():
	RoundStartInfo.p1_character = null
	RoundStartInfo.p2_character = null
	get_tree().change_scene_to_file("res://scenes/character_select_screen.tscn")
	
