extends Node2D

#Much of this logic comes from KindoSaur's tutorial: https://www.youtube.com/watch?v=aF9tqVOf8Rc

@export var player_index := 1
@export var preview : Node2D

var my_palettes
var palette_index = 0

var currentSelected = 0
var currentColumnSpot = 0
var currentRowSpot = 0

@export var portraitOffset : Vector2
@export var maxColumn := 2 #0-2, 3 columns. 2 is the max position
@export var maxRow := 2 #0-2, 3 rows. 2 is the max rows
#@onready var grid_container = get_parent().get_node("GridContainer")
func _ready():
	call_deferred("update_preview")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match player_index:
		1:
			if RoundStartInfo.p1_character == null:
				move_cursor()
			elif RoundStartInfo.p1_palette == null:
				color_select()
			elif Input.is_action_just_pressed("p"+str(player_index)+"_b"):
				RoundStartInfo.p1_palette = null
		
		2:
			if RoundStartInfo.p2_character == null:
				move_cursor()
			elif RoundStartInfo.p2_palette == null:
				color_select()
			elif Input.is_action_just_pressed("p"+str(player_index)+"_b"):
				RoundStartInfo.p1_palette = null


func move_cursor():
	if(Input.is_action_just_pressed("p"+str(player_index)+"_right")) and (currentColumnSpot < maxColumn):
		currentSelected += 1
		currentColumnSpot += 1
		update_preview()
		
		position.x += portraitOffset.x
	elif(Input.is_action_just_pressed("p"+str(player_index)+"_left") and (currentColumnSpot > 0)):
		currentSelected -= 1
		currentColumnSpot -= 1
		update_preview()
		
		position.x -= portraitOffset.x
	if(Input.is_action_just_pressed("p"+str(player_index)+"_down") and (currentRowSpot < maxRow)):
		currentSelected += 3
		currentRowSpot += 1
		update_preview()
		
		position.y += portraitOffset.y
	elif(Input.is_action_just_pressed("p"+str(player_index)+"_up") and (currentRowSpot > 0)):
		currentSelected -= 3
		currentRowSpot -= 1
		update_preview()
		
		position.y -= portraitOffset.y
		
	if Input.is_action_just_pressed("p"+str(player_index)+"_a") and len(CharacterList.character_list) > currentSelected:
		match player_index:
			1:
				RoundStartInfo.p1_character = CharacterList.character_list[currentSelected]
				CharacterList.palette_list_make(1, CharacterList.character_list[currentSelected])
				my_palettes = CharacterList.p1_palettes
			2:
				RoundStartInfo.p2_character = CharacterList.character_list[currentSelected]
				CharacterList.palette_list_make(2, CharacterList.character_list[currentSelected])
				my_palettes = CharacterList.p2_palettes

	
func color_select():
	if (Input.is_action_just_pressed("p"+str(player_index)+"_right")):
		if palette_index < my_palettes.size() -1:
			palette_index += 1
			preview.get_child(0).get_node("Sprite2D").material.set_shader_parameter("palette", load(my_palettes[palette_index]))
			
	elif (Input.is_action_just_pressed("p"+str(player_index)+"_left")):
		if palette_index > 0:
			palette_index -= 1
			
			if my_palettes[palette_index] == "":
				preview.get_child(0).get_node("Sprite2D").material.set_shader_parameter("palette", null)
			else:
				preview.get_child(0).get_node("Sprite2D").material.set_shader_parameter("palette", load(my_palettes[palette_index]))
				
				
	if Input.is_action_just_pressed("p"+str(player_index)+"_a"):
		match player_index:
			1:
				if (my_palettes[palette_index] != RoundStartInfo.p2_palette) or (RoundStartInfo.p1_character != RoundStartInfo.p2_character):
					RoundStartInfo.p1_palette = my_palettes[palette_index]
					print(RoundStartInfo.p1_palette)
			2:
				if (my_palettes[palette_index] != RoundStartInfo.p1_palette) or (RoundStartInfo.p1_character != RoundStartInfo.p2_character):
					RoundStartInfo.p2_palette = my_palettes[palette_index]
					print(RoundStartInfo.p2_palette)
		
		if (RoundStartInfo.p1_palette != null) and (RoundStartInfo.p2_palette != null):
			get_tree().change_scene_to_file("res://scenes/main.tscn")
			
	elif Input.is_action_just_pressed("p"+str(player_index)+"_b"):
		match player_index:
			1:
				RoundStartInfo.p1_character = null
				palette_index = 0
			2:
				RoundStartInfo.p2_character = null
				palette_index = 0
		preview.get_child(0).get_node("Sprite2D").material.set_shader_parameter("palette", null)

func update_preview():
	if len(CharacterList.character_list) > currentSelected:
		for child in preview.get_children():
			child.queue_free()
		var new_preview = load("res://resources/characters/"+CharacterList.character_list[currentSelected]+"/preview.tscn").instantiate()
		preview.add_child(new_preview)
		new_preview.get_node("AnimationPlayer").play("idle")
	
