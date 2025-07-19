extends Area2D

func _on_line_edit_text_submitted(new_text: String) -> void:
	# Import the node
	var line_edit = get_node("LineEdit")
	# Get the text value of the Label
	line_edit.text = new_text
	address_value = int(new_text)

extends LineEdit

func _on_text_submitted(new_text):
	# Import the node
	var program_counter = get_node("ProgramCounter")
	# Get the text value of the Label
	text = new_text
	program_counter.address_value = int(text)
	print("text submitted")
