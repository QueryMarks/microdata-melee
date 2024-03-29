extends AirState
class_name AirNormalState


# Called when the node enters the scene tree for the first time.
func enter():
	tags += ["air","normal"]
	player.get_node("Sprite2D").z_index = 1


func _physics_process(_delta):
	super(_delta)

func exit():
	player.get_node("Sprite2D").z_index = 0
	for node in player.get_node("Hitboxes").get_children():
		for shape in node.get_children():
			if shape.disabled == false:
				shape.set_deferred("disabled",true)
