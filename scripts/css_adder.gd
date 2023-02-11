extends Node
var css_icon = preload("res://scenes/css_icon.tscn")
var character_list

# Called when the node enters the scene tree for the first time.
func _ready():
	character_list = CharacterList.character_list
	call_deferred("add_icons")# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func add_icons():
	for character in character_list:
		var instance = css_icon.instantiate()
		instance.get_node("TextureRect").texture = load("res://resources/characters/" + character + "/sprites/css.png")
		get_parent().add_child(instance)
