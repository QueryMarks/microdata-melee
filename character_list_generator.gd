extends Node
var char_path = "res://resources/characters"
var char_array = []
# Called when the node enters the scene tree for the first time.
func _ready():
	character_array_make() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func character_array_make():
	var dir = DirAccess.open(char_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				if dir.file_exists(char_path+"/"+file_name+"/"+file_name+".tscn"):
					char_array.append(file_name)
			file_name = dir.get_next()
	else:
		print("uh oh! problem")
	print(char_array)
