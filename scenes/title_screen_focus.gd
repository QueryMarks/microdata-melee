extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button1.grab_focus()
	$Button1.pressed.connect(css_pressed)
	$Button2.pressed.connect(quit_game)
	
func css_pressed():
	get_tree().change_scene_to_file("res://scenes/character_select_screen.tscn")

func quit_game():
	get_tree().quit()
