extends Node2D

@export var my_animation : Animation
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("hit_spark")
	await $AnimationPlayer.animation_finished
	queue_free()
