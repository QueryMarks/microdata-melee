extends Node
class_name OSStyle

var player : Node
var move_list : Node
var input_log : InputLog
# Called when the node enters the scene tree for the first time.
func _ready():
	player = self.get_parent()
	player.os = self
	for node in player.get_children():
		if node is MoveList:
			move_list = node
		elif node is InputLog:
			input_log = node


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if player.state_machine.current_state.tags.has("actionable") or player.state_machine.current_state.has_hit == true:
		os_action_check(player.state_machine.current_state.tags)

func os_action_check(_tags : Array):
	return false

func os_change_state_check(move : Move):
	if move.check_inputs(input_log.input_log, player.my_facing):
		player.state_machine.change_state(move.state.new())
		return true
	else:
		return false
