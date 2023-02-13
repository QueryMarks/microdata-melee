extends CharacterBody2D

@export var player_1 : Node2D
@export var player_2 : Node2D
var midpoint = 0
var left_bound = -82
var right_bound = 82
const SPEED = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	#midpoint = (player_1.get_position().x + player_2.get_position().x)/2
	#self.position.x = midpoint
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	midpoint = (player_1.get_position().x + player_2.get_position().x)/2
	var target
	if midpoint <= left_bound:
		target = left_bound	
	elif midpoint >= right_bound:
		target = right_bound
	else:
		target = midpoint
	position.x += clamp(target - position.x, -1, 1)
		
func disable_walls(yesno : bool):
	for child in get_children():
		if child is CollisionShape2D:
			child.set_disabled(yesno)
