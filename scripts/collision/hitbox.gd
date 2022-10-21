extends Area2D
class_name Hitbox

@export var damage := 10

func _init() -> void:
	collision_layer = 2

func this_hit(_hit_type):
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
