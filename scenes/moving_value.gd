extends Area2D

var speed := 700.0
var velocity := Vector2(0, 0)
var steering_factor := 3.0

@export var address_value := 0: set = set_address_value
@export var data_value = "": set = set_data_value

@export var direction_map: Array[String] = ["right", "right", "up", "right", "down", "left", "down", "left", "down"]
@export var map_index := 0
@export var current_direction: String = "halt"

@export var alu_data = ""
@export var read_or_write := "read"
var rich_text_label

func movement_control(direction: Vector2, movement: String) -> Vector2:
	if movement == "up":
		direction.x = 0
		direction.y = -1
	elif movement == "down":
		direction.x = 0
		direction.y = 1
	elif movement == "left":
		direction.x = -1
		direction.y = 0
	elif movement == "right":
		direction.x = 1
		direction.y = 0
	else:
		direction.x = 0
		direction.y = 0
	
	return direction

func _on_area_entered(area_that_entered) -> void:
	if area_that_entered.is_in_group("movement"):
		# Increment map_index and wrap around using modulo operator
		map_index = (map_index + 1) % direction_map.size()
		print(direction_map)
		print(map_index, ": ", direction_map[map_index])
		# Update current_direction to the new direction from direction_map
		current_direction = direction_map[map_index]	
	elif area_that_entered.is_in_group("address"):
		# Get the Label node, which is a child of the Area2D node
		var address_num = area_that_entered.get_node("address_number")
		# Get the text value of the Label
		var area_address = address_num.text
		# Check if it matches the given address values
		if area_address == str(address_value):
			current_direction = "right"
	elif area_that_entered.is_in_group("mem_value"):
		var memory_value = area_that_entered.get_node("memory_value")
		if read_or_write == "read":
			# Get the text value from the label node
			data_value = memory_value.data
			rich_text_label.text = data_value
		elif read_or_write == "write":
			#write to memory block
			var memory_value_text = area_that_entered.get_node("RichTextLabel")
			memory_value_text.text = alu_data
			memory_value_text.z_index = 1
			memory_value.data = alu_data
			read_or_write = "read"
			data_value = "READY"
			rich_text_label.text = data_value
		# Change collision mask layer
		set_collision_mask_value(1, false)
		set_collision_mask_value(2, true)
		# Now change the direction
		current_direction = "up"
	elif area_that_entered.is_in_group("decoder"):
		decoder()
		set_collision_mask_value(2, false)
		set_collision_mask_value(3, true)
	
func _ready() -> void:
	# Connects signal to node
	area_entered.connect(_on_area_entered)
	set_collision_mask_value(1, true)
	rich_text_label = get_node("moving_value_label")

func _process(delta: float) -> void:
	var direction := Vector2(0, 0)
	direction = movement_control(direction, current_direction)

	var pc_velocity := speed * direction
	position += pc_velocity * delta
	
func set_data_value(new_value: String) -> void:
	data_value = new_value
	# Update the label text whenever data_value is updated
	if rich_text_label:
		rich_text_label.text = data_value

func set_address_value(new_value) -> void:
	address_value = new_value

func decoder() -> void:
	if data_value.is_valid_int():
		direction_map.append("down")
		direction_map.append("left")
	else:
		direction_map.append("up")
		direction_map.append("left")
		direction_map.append("halt")

#TODO:
#fix that weird read/write bug. very strange.
