extends Node
class_name State

var player
var state_machine
var input_reader
var tags := []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	pass
	if (player.position.x > player.opponent.position.x) and (player.my_facing != -1):
		player.turn(-1)
	elif (player.position.x < player.opponent.position.x) and (player.my_facing != 1):
		player.turn(1)

func get_hit(_hitbox : Hitbox):
	return null


func exit():
	pass

