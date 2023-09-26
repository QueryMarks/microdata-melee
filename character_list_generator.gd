extends Node
var character_path = "res://resources/characters"
var character_list = ["card", "lamb"]
var p1_palettes = []
var p2_palettes = []
# Called when the node enters the scene tree for the first time.
func _ready():
	if character_list == []:
		character_list_make()
	
	#weird bug with the window being sized incorrectly -- maybe due to godot 4 weirdness? anyway this line is here so the window will be properly sized to the settings
	DisplayServer.window_set_size(Vector2i(ProjectSettings.get_setting("display/window/size/viewport_width"),ProjectSettings.get_setting("display/window/size/viewport_height")))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func character_list_make():
	
	var dir = DirAccess.open(character_path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				#if dir.file_exists(character_path+"/"+file_name+"/"+file_name+".tscn") or dir.file_exists(character_path+"/"+file_name+"/"+file_name+".tscn.import"):
					character_list.append(file_name)
			file_name = dir.get_next()
		print(character_list)
		
	else:
		print("uh oh! problem")
		
func palette_list_make(player_index : int, char_name : String):
	print("MAKIN A LIST CHECKIN IT LIST")
	if player_index == 1:
		p1_palettes = []
	elif player_index == 2:
		p2_palettes = []
	var dir = DirAccess.open(character_path+"/"+char_name+"/palettes")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		print(file_name)
		while file_name != "":
		#if dir.file_exists(character_path+"/"+file_name+"/"+file_name+".tscn") or dir.file_exists(character_path+"/"+file_name+"/"+file_name+".tscn.import"):
			if file_name.ends_with(".png"):
				if player_index == 1:
					p1_palettes.append(character_path+"/"+char_name+"/palettes/"+file_name)
					print(file_name)
					print(p1_palettes)
				elif player_index == 2:
					p2_palettes.append(character_path+"/"+char_name+"/palettes/"+file_name)
			file_name = dir.get_next()
	else:
		print("uh oh! problem")
