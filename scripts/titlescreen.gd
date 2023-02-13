extends Control

var title_label = Label.new()
var start_button = Button.new()

func _ready():
	# Set up the title label
	title_label.text = "My Game"
	title_label.rect_position = Vector2(get_size().x / 2, get_size().y / 2)
	title_label.rect_size = Vector2(200, 50)
#	title_label.align = Label.ALIGN_CENTER
#	title_label.valign = Label.VALIGN_CENTER
	add_child(title_label)

	# Set up the start button
	start_button.text = "Start Game"
	start_button.rect_position = Vector2(get_size().x / 2, get_size().y / 2 + 100)
	start_button.rect_size = Vector2(200, 50)
	#start_button.connect("pressed", self, "_on_start_button_pressed")
	add_child(start_button)

func _on_start_button_pressed():
	# Start the game
	get_tree().change_scene("res://game.tscn")
