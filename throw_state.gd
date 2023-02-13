extends GroundNormalState
class_name ThrowState

@onready var grab_box = player.get_node("Grabboxes/Throw")
# Called when the node enters the scene tree for the first time.
func _ready():
	tags.erase("normal")
	player.anim_player.play("throw")


func _to_idle(_variable):
	super(_variable)
# Called every frame. 'delta' is the elapsed time since the previous frame.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
