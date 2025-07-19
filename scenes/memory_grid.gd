extends Area2D

var addr_num
@export var addr_num_text: String

func _ready() -> void:
	addr_num = get_node("address_number")
	addr_num_text = addr_num.text
