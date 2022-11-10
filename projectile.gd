extends Node2D

var state_machine
# Called when the node enters the scene tree for the first time.
func hit_stop(_hit_type):
	self.queue_free()
func _physics_process(_delta):
	if $Hitbox.get_node("CollisionShape2D").disabled == true:
		$Hitbox.get_node("CollisionShape2D").disabled = false
	self.move_and_slide()
