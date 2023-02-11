extends Node
var character_path = "res://resources/characters"
var character_list = []
# Called when the node enters the scene tree for the first time.
func _ready():
	character_list_make()
	
	#weird bug with the window being sized incorrectly -- maybe due to godot 4 weirdness? anyway this line is here so the window will be properly sized to the settings
	DisplayServer.window_set_size(Vector2i(ProjectSettings.get_setting("display/window/size/viewport_width"),ProjectSettings.get_setting("display/window/size/viewport_height")))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func character_list_make():
	var dir = DirAccess.open(character_path)
	if dir:
		print("gsdhjkhsd")
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
					character_list.append(file_name)
					print(file_name)
			file_name = dir.get_next()
	else:
		print("uh oh! problem")
	print(character_list)
