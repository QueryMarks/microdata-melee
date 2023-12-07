extends Area2D
class_name Hitbox
var player
var projectile
@export var damage := 10
@export var hitstun := 15
@export var hitstop := 15
@export var player_hitstop = true
@export var blockstun := 7
@export var blockstop := 8
@export var knockback : Vector2
@export var hit_type := "mid"
@export var force_airborne := false

@export var player_index : int

signal this_hit_something

var my_hitbox
var hit_list = []

@export var my_hit_spark : PackedScene = preload("res://scenes/system/hit_spark.tscn")
@export var my_guard_spark : PackedScene = preload("res://scenes/system/guard_spark.tscn")

func _init() -> void:
	collision_layer = 2

func this_hit(hit_block, player_hit, box_hit):
	this_hit_something.emit()
	match hit_block:
		"hit":
			hit_list.append(player_hit)
			player.state_machine.current_state.has_hit = true
			if player_hitstop:
				player.call_deferred("hit_stop", hitstop)
			if projectile:
				projectile.call_deferred("hit_stop", hitstop)
			spawn_hitspark(box_hit)

		"block":
			player.state_machine.current_state.has_hit = true
			if player_hitstop:
				player.call_deferred("hit_stop", hitstop)
			if projectile:
				projectile.call_deferred("hit_stop", hitstop)
			spawn_guardspark(box_hit)
			
# Called when the node enters the scene tree for the first time.
func _ready():
	if projectile == null && owner is Projectile:
		projectile = owner
	elif player == null:
		player = owner
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
func _physics_process(_delta):
	if player_index == 0:
		player_index = player.player_index
	if my_hitbox.disabled && hit_list != []:
		hit_list = []
		
func spawn_hitspark(box_hit):
	var spawned_hit_spark = my_hit_spark.instantiate()
	get_tree().root.add_child(spawned_hit_spark)
	var pos_to_spawn : Vector2
	pos_to_spawn.x = (my_hitbox.global_position.x+box_hit.global_position.x)/2
	pos_to_spawn.y = my_hitbox.global_position.y
	spawned_hit_spark.global_position = pos_to_spawn
	spawned_hit_spark.z_index = 1
	pass

#identical function for now, things will change
func spawn_guardspark(box_hit):
	var spawned_hit_spark = my_guard_spark.instantiate()
	get_tree().root.add_child(spawned_hit_spark)
	var pos_to_spawn : Vector2
	pos_to_spawn.x = (my_hitbox.global_position.x+box_hit.global_position.x)/2
	pos_to_spawn.y = my_hitbox.global_position.y
	spawned_hit_spark.global_position = pos_to_spawn
	spawned_hit_spark.z_index = 1
	pass
