extends Area2D
class_name Hurtbox

func _init() -> void:
	collision_layer = 0
	collision_mask = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	self.area_entered.connect(_on_area_entered)
	
	#needed to make instances of players not interfere with each others' hurtbox shapes. it's weird!! leave this in tho
	for hurtbox in get_children():
		hurtbox.set_shape(hurtbox.get_shape().duplicate())

func _on_area_entered(hitbox) -> void:
	print("area")
	if hitbox == null:
		print("null??")
		return
	if hitbox.owner != owner and hitbox.owner.get_parent() != owner and owner.has_method("get_hit"):
		if hitbox is Grabbox:
			print("hurtbox registered it")
			hitbox.this_hit(owner.get_grabbed(hitbox), owner)
		elif hitbox is Hitbox:
			hitbox.this_hit(owner.get_hit(hitbox), owner)
