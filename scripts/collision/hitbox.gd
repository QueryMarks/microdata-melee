extends Area2D
class_name Hitbox

@export var damage := 10
@export var hitstun := 15
@export var knockback : Vector2

func _init() -> void:
	collision_layer = 2

func this_hit(_hit_type):
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2d.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
