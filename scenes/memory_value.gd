extends LineEdit

@export var data := ""

func _on_text_submitted(new_text: String) -> void:
	self.text = new_text
	data = new_text.to_upper()
