extends Node2D

var mem_addresses = 0

func _ready():
	add_node()
	
func add_node() -> void:
	var mem_row := preload("res://scenes/address_trigger.tscn")
	var mem_row_instance := mem_row.instantiate()
	var addr_label = mem_row_instance.get_node("Label")
	addr_label.text = str(mem_addresses)
	mem_row_instance.position.y = mem_addresses * 120
	mem_addresses += 1
	add_child(mem_row_instance)

func _on_memory_button_pressed():
	add_node()
