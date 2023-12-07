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
		if node.get_node("CollisionShape2D").disabled == false:
			node.get_node("CollisionShape2D").set_deferred("disabled",true)
