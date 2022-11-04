extends Area2D
class_name Hurtbox

func _init() -> void:
	collision_layer = 0
	collision_mask = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
	pass # Replace with function body.

func _on_area_entered(hitbox : Hitbox) -> void:
	
	if hitbox == null:
		print("null??")
		return
	if hitbox.owner != owner and owner.has_method("get_hit"):
		hitbox.this_hit(owner.get_hit(hitbox))
# Called every frame. 'delta' is the elapsed time since the previous frame.

