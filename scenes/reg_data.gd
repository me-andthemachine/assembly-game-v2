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
	data_register()

func data_register() -> void:
	moving_value.current_direction = "left"
