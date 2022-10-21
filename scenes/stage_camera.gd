extends CharacterBody2D

@export var player_1 : Node2D
@export var player_2 : Node2D
var midpoint
const SPEED = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	midpoint = (player_1.get_position().x + player_2.get_position().x)/2
	self.position.x = midpoint


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	midpoint = (player_1.get_position().x + player_2.get_position().x)/2
	self.position.x = midpoint
