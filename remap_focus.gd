extends VBoxContainer


var input_set : InputSet
var accepting_inputs = false
func _input(event):
	if accepting_inputs:
		print(event.as_text())


# Called when the node enters the scene tree for the first time.
