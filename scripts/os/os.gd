extends Node
class_name OSStyle

var player : Node
var move_list : Node
var input_reader : InputReader
# Called when the node enters the scene tree for the first time.
func _ready():
	player = self.get_parent()
	player.os = self
	for node in player.get_children():
		if node is MoveList:
			move_list = node
		elif node is InputReader:
			input_reader = node


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if player.state_machine.current_state.tags.has("actionable") or player.state_machine.current_state.has_hit == true:
		os_action_check(player.state_machine.current_state.tags)

func os_action_check(_tags : Array):
	return false