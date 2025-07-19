extends Button

func _ready() -> void:
	var parent = get_parent()
	pressed.connect(parent._button_pressed)
