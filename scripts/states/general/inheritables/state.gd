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
	player.take_damage(hitbox.damage)
	return "hit"
	
func get_grabbed(hitbox : Grabbox):
	print("state is checkin")
	var tag_check = true
	for tag in hitbox.valid_tags:
		if !tags.has(tag):
			tag_check = false
	if tag_check:
		print("state says yes")
		player.pushbox.get_node("CollisionBox").set_deferred("disabled", true)
		state_machine.call_deferred("change_state", GrabbedState.new())
		call_deferred("grab_reference", hitbox)
		return "grab"
	else:
		print("state says WHIFF")
		return "whiff"
		
func grab_reference(hitbox : Grabbox):
	state_machine.current_state.grabbox = hitbox

func block_check(hitbox : Hitbox):
	if player.position.x > player.opponent.position.x:
		if Input.is_action_pressed(player.input_right) and !Input.is_action_pressed(player.input_left):
			player.block(hitbox)
			return "block"
		else:
			player.take_damage(hitbox.damage)
			player.get_hurt(hitbox)
			return "hit"
	else:
		if Input.is_action_pressed(player.input_left) and !Input.is_action_pressed(player.input_right):
			player.block(hitbox)
			return "block"
		else:
			player.take_damage(hitbox.damage)
			player.get_hurt(hitbox)
			return "hit"

func exit():
	pass

