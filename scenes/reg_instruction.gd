extends Area2D

var current_instruction: String
var current_destination_operand
var current_alu_value
var current_data_value
var moving_value
var direction_map

func _ready():
	moving_value = get_node("../program_counter_register/moving_value")

func _on_area_entered(_area: Area2D) -> void:
	moving_value.set_collision_mask_value(3, false)
	moving_value.set_collision_mask_value(1, true)
	moving_value.current_direction = "right"
	instruction_register()

func instruction_register() -> void:
	var opcode = moving_value.data_value
	var label = get_node("RichTextLabel")
	if opcode[0] == "L":
		load_address()
		label.text = opcode
	elif opcode[0] == "A":
		label.text = opcode
		add()
	elif opcode[0] == "S":
		store_address()
		label.text = opcode
	elif opcode == "HALT":
		moving_value.current_direction = "HALT"
		moving_value.visible = false
		label.text = "HALT"
	elif opcode == "READY":
		ready_function()
		label.text = ""
		
func add() -> void:
	var add_reset_map = ["down", "left", "up", "right", "down", "left", "down"]
	reset_map(add_reset_map)

func ready_function() -> void:
	moving_value.current_direction = "left"
	var ready_map = ["up", "right", "right", "up", "right", "down", "left", "down", "left", "down"]
	reset_map(ready_map)
	
func load_address() -> void:
	var split_opcode = (moving_value.data_value).split(" ")
	current_instruction = split_opcode[0]
	current_destination_operand = split_opcode[1]
	moving_value.data_value = current_destination_operand
	moving_value.address_value = current_destination_operand
	
	var lda_reset_map = ["up", "up", "right", "down", "left", "down", "left", "down"]
	reset_map(lda_reset_map)

func store_address() -> void:
	moving_value.read_or_write = "write"
	var split_opcode = (moving_value.data_value).split(" ")
	current_instruction = split_opcode[0]
	current_destination_operand = split_opcode[1]
	moving_value.data_value = current_destination_operand
	moving_value.address_value = current_destination_operand
	
	var lda_reset_map = ["up", "up", "right", "down", "left", "down", "left", "down"]
	reset_map(lda_reset_map)
	
func reset_map(new_map) -> void:
	direction_map = moving_value.direction_map
	var remove = direction_map.size() - 1
	for i in remove:
		direction_map.pop_back()
	
	for i in new_map:
		direction_map.append(i)
	
	moving_value.map_index = 0
