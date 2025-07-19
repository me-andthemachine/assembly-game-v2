extends Area2D

var current_instruction: String
var current_destination_operand
var current_alu_value
var current_data_value
var moving_value
var direction_map

func _ready():
	pass	

func _on_area_entered(_area: Area2D) -> void:
	moving_value = get_node("../program_counter_register/moving_value")
	
	if self.is_in_group("reg_instruction"):
		instruction_register()
	elif self.is_in_group("reg_alu"):
		alu_register()
	elif self.is_in_group("reg_data"):
		data_register()
	else:
		print("something went wrong.")

func instruction_register() -> void:
	var opcode = moving_value.data_value
	if opcode[0] == "l":
		load_address()
		self.richtextlabel.text = "LDA"
	elif opcode == "HALT":
		moving_value.current_direction = "HALT"
	
func alu_register() -> void:
	moving_value.current_direction = "HALT"

func data_register() -> void:
	moving_value.current_direction = "left"

func load_address() -> void:
	var split_opcode = (moving_value.data_value).split(" ")
	current_instruction = split_opcode[0]
	current_destination_operand = split_opcode[1]
	moving_value.data_value = current_destination_operand
	moving_value.address_value = current_destination_operand
	moving_value.set_collision_mask_value(3, false)
	moving_value.set_collision_mask_value(1, true)

	direction_map = moving_value.direction_map
	var remove = direction_map.size() - 1
	for i in remove:
		direction_map.pop_back()
	
	var reset_map = ["right", "up", "right", "up", "right", "down", "left", "down"]
	for i in reset_map:
		direction_map.append(i)
	
	moving_value.map_index = 0
