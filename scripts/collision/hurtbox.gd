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
	if hitbox == null:
		print("null??")
		return
	call_deferred("check_hitbox", hitbox)
	
func check_hitbox(hitbox):
	if hitbox.player_index != owner.player_index and owner.has_method("get_hit") and !hitbox.hit_list.has(owner):
		if hitbox is Grabbox:
			call_deferred("check_grabbox",hitbox)
		elif hitbox is Hitbox:
			hitbox.this_hit(owner.get_hit(hitbox), owner, self)
func check_grabbox(hitbox):
	if hitbox.owner.state_machine.current_state is GrabState:
		hitbox.this_hit(owner.get_grabbed(hitbox), owner, self)
