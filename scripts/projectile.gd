extends CharacterBody2D

var state_machine
@export var max_timer := 60
var timer = 0
# Called when the node enters the scene tree for the first time.
func hit_stop(_hit_type):
	self.queue_free()
func _physics_process(_delta):
	timer += 1
	if timer >= max_timer:
		self.queue_free()
	if $Hitbox.get_node("CollisionShape2D").disabled == true:
		$Hitbox.get_node("CollisionShape2D").disabled = false
	self.move_and_slide()
