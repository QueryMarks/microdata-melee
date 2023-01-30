extends Node2D

#Much of this logic comes from KindoSaur's tutorial: https://www.youtube.com/watch?v=aF9tqVOf8Rc

@export var player_index := 1
@export var preview : Node2D



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
			elif Input.is_action_just_pressed("p"+str(player_index)+"_b"):
				RoundStartInfo.p1_character = null
		2:
			if RoundStartInfo.p2_character == null:
				move_cursor()
			elif Input.is_action_just_pressed("p"+str(player_index)+"_b"):
				RoundStartInfo.p2_character = null


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
			2:
				RoundStartInfo.p2_character = CharacterList.character_list[currentSelected]
		if RoundStartInfo.p1_character != null and RoundStartInfo.p2_character != null:
			get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func update_preview():
	if len(CharacterList.character_list) > currentSelected:
		for child in preview.get_children():
			child.queue_free()
		var new_preview = load("res://resources/characters/"+CharacterList.character_list[currentSelected]+"/preview.tscn").instantiate()
		preview.add_child(new_preview)
		new_preview.get_node("AnimationPlayer").play("idle")
	
