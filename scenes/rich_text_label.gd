extends Area2D

var speed := 700.0
var velocity := Vector2(0, 0)
var steering_factor := 3.0

@export var address_value := 0
@export var data_value = ""

@export var direction_map: Array[String] = ["right", "up", "right", "down", "left", "down"]
@export var map_index := 0
@export var current_direction: String = "halt"

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
		# Update current_direction to the new direction from direction_map
		current_direction = direction_map[map_index]
	#elif area_that_entered.is_in_group("instruction_movement"):
		#instruction_map_index = (instruction_map_index + 1) % instruction_direction_map.size()
		#current_direction = instruction_direction_map[instruction_map_index]
	elif area_that_entered.is_in_group("address"):
		# Get the Label node, which is a child of the Area2D node
		var label_node = area_that_entered.get_node("RichTextLabel")
		# Get the text value of the Label
		var area_address = label_node.text
		# Check if it matches the given address values
		if area_address == str(address_value):
			current_direction = "right"
	elif area_that_entered.is_in_group("mem_value"):
		# Get the text value from the label node
		var label_node = area_that_entered.get_node("opcode")
		data_value = label_node.data
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

func _process(delta: float) -> void:
	var direction := Vector2(0, 0)
	direction = movement_control(direction, current_direction)

	var pc_velocity := speed * direction
	position += pc_velocity * delta

func decoder() -> void:
	if data_value.is_valid_int():
		print("int")
		direction_map.append("down")
	else:
		print("string")
		direction_map.append("left")
		direction_map.append("up")
		direction_map.append("left")
		direction_map.append("halt")
