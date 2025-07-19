extends LineEdit

@export var data := "HALT"

func _on_text_entered(new_text) -> void:
	self.text = new_text
	data = new_text
