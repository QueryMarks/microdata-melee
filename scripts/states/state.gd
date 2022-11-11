extends Node
class_name State

var player
var state_machine
var input_reader
var tags := []
var hitstop := false
var has_hit := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	pass

func get_hit(hitbox : Hitbox):
	player.get_hurt(hitbox)
	return "hit"

func block_check(hitbox : Hitbox):
	if player.position.x > player.opponent.position.x:
		if Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left):
			player.block(hitbox)
			return "block"
		else:
				player.get_hurt(hitbox)
				return "hit"
	else:
		if Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right):
			player.block(hitbox)
			return "block"
		else:
				player.get_hurt(hitbox)
				return "hit"

func exit():
	pass

