extends Area2D

var text_input_node
var text_input := "0"
var pc_richtext
var moving_value
var moving_value_label
var button
var flag

func _ready() -> void:
	# Connects signal to node
	set_collision_mask_value(1, true)
	pc_richtext = get_node("program_counter")
	pc_richtext.visible = false
	
	moving_value = get_node("moving_value")
	
	moving_value_label = get_node("moving_value/moving_value_label")
	moving_value_label.visible = false
	
	text_input_node = get_node("LineEdit")
	
	button = get_node("run_script_button")
	
	pc_richtext.text = text_input
	moving_value_label.text = text_input
	
	flag = false

func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_int():
		text_input = new_text
	
		pc_richtext.text = text_input
		moving_value_label.text = text_input

func _on_run_script_button_pressed() -> void:
	text_input_node.visible = false
	pc_richtext.visible = true
	moving_value_label.visible = true
	button.visible = false
	moving_value.current_direction = moving_value.direction_map[moving_value.map_index]
	moving_value.address_value = text_input

func _on_area_shape_exited(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
		var increase_counter = int(text_input) + 1
		text_input = str(increase_counter)
		pc_richtext.text = text_input

func _on_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	moving_value.data_value = pc_richtext.text
	moving_value.address_value = pc_richtext.text
	moving_value_label.text = moving_value.data_value
