extends State
class_name GrabbedState
var grabbox

# Called when the node enters the scene tree for the first time.
func _ready():
	tags += ["grabbed", "air"]
	player.anim_play(player.character_name+"/air_hurt")
	player.toggle_pushbox_disabled(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	player.global_position = Vector2(grabbox.grab_point.global_position.x, grabbox.grab_point.global_position.y+20)
	
func exit():
	super()
	player.toggle_pushbox_disabled(false)
