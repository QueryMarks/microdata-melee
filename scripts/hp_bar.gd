extends TextureProgressBar

var player : Node
signal health_zero
# Called when the node enters the scene tree for the first time.
func _ready():
	update_bar()
	player.damaged.connect(update_bar)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_bar():
	value = player.hp/player.max_hp*64
	if value <= 0:
		health_zero.emit()
