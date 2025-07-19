extends Area2D

var current_instruction: String
var current_destination_operand
var current_alu_value
var current_data_value
var moving_value
var direction_map
var data_value
@export var label = ""

func _ready():
	moving_value = get_node("../program_counter_register/moving_value")	

func _on_area_entered(_area: Area2D) -> void:
	moving_value.set_collision_mask_value(3, false)
	moving_value.set_collision_mask_value(1, true)
	data_value = moving_value.data_value
	label = get_node("RichTextLabel")
	#label.text = data_value
	alu_register()
	moving_value.data_value = "READY"
	reset_map()
	
func reset_map() -> void:
	direction_map = moving_value.direction_map
	var remove = direction_map.size() - 1
	for i in remove:
		direction_map.pop_back()
	
	var new_map = ["up", "up", "right", "right", "up", "right", "down", "left", "down", "left", "down"]
	for i in new_map:
		direction_map.append(i)
	
	moving_value.map_index = 0
	
func alu_register() -> void:
	if data_value[0] == "A":
		var sum = add()
		label.text = str(sum)
	else:
		label.text = data_value
	moving_value.current_direction = "left"
	moving_value.alu_data = label.text

func add():
	var split_opcode = (moving_value.data_value).split(" ")
	var operand = int(split_opcode[1])
	var num = int(label.text)
	var sum = operand + num
	return sum
