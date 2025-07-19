extends Button

func _ready():
	#var button = Button.new()
	#button.text = "Run script"
	#button.pressed.connect(self._button_pressed)
	#add_child(button)

func _button_pressed():
	#var current_moving_value = get_node("../program_counter_register/moving_value")
	#var direction_map = current_moving_value.direction_map
	#var map_index = current_moving_value.map_index
	#current_moving_value.current_direction = direction_map[map_index]
	
	var pc_register = get_node("../program_counter_register")
	pc_register.program_counter.visible = true


func _on_pressed() -> void:
	pass # Replace with function body.
