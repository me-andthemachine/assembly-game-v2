extends Button

var mem_addr_counter = 0

func _ready() -> void:
	for i in 9:
		add_node()

func _on_pressed() -> void:
	add_node()

func add_node() -> void:
	mem_addr_counter += 1
	var new_mem_row := preload("res://scenes/memory_grid.tscn")
	var new_row_instance := new_mem_row.instantiate()
	var new_addr_num = new_row_instance.get_node("address_number")
	new_addr_num.text = str(mem_addr_counter)
	new_row_instance.position.x = 440
	new_row_instance.position.y = (mem_addr_counter * 81)
	add_child(new_row_instance)
