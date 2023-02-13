extends Area2D
class_name Hitbox

@export var damage := 10
@export var hitstun := 15
@export var hitstop := 15
@export var blockstun := 7
@export var blockstop := 8
@export var knockback : Vector2
@export var hit_type := "mid"
@export var force_airborne := false

var my_hitbox

func _init() -> void:
	collision_layer = 2

func this_hit(hit_block, player_hit):
	match hit_block:
		"hit":
			owner.state_machine.current_state.has_hit = true
			owner.call_deferred("hit_stop", hitstop)
		"block":
			owner.state_machine.current_state.has_hit = true
			owner.call_deferred("hit_stop", hitstop)
			
# Called when the node enters the scene tree for the first time.
func _ready():
	for hitbox in get_children():
		if hitbox is CollisionShape2D:
			my_hitbox = hitbox
			break
	
	#needed to make instances of players not interfere with each others' hurtbox shapes. it's weird!! leave this in tho
	for hitbox in get_children():
		if hitbox is CollisionShape2D:
			hitbox.set_shape(hitbox.get_shape().duplicate())

func disable_child(truefalse : bool):
	my_hitbox.disabled = truefalse

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
