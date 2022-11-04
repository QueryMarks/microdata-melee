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


func exit():
	pass

