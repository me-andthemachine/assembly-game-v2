extends VScrollBar

# Reference to the VBoxContainer
@onready var vbox = $VBoxContainer

# Function to add an HBox dynamically
func add_hbox():
	var hbox = HBoxContainer.new()
	vbox.add_child(hbox)
	
	# Optionally, you can add child elements inside the HBox
	var label = Label.new()
	label.text = "Item " + str(vbox.get_child_count()) # Dynamic labeling
	hbox.add_child(label)

# Example: Add 10 HBoxes at runtime
func _ready():
	for i in range(10):
		add_hbox()
