extends Area2D
class_name Hitbox

@export var damage := 10
@export var hitstun := 15
@export var hitstop := 15
@export var blockstun := 7
@export var blockstop := 8
@export var knockback : Vector2
@export var hit_type := "mid"

func _init() -> void:
	collision_layer = 2

func this_hit(hit_type):
	match hit_type:
		"hit":
			owner.state_machine.current_state.has_hit = true
			owner.hit_stop(hitstop)
		"block":
			owner.state_machine.current_state.has_hit = true
			owner.hit_stop(blockstop)
			
# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
