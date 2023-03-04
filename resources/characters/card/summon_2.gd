extends CharacterBody2D


func _ready():
	$AnimationPlayer.play("summon_2_idle")
	$AnimationPlayer.queue("summon_2_dash")

func _physics_process(delta):
	pass
