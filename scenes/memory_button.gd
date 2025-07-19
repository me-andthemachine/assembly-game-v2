extends Button

func _ready():
	self.text = "Add Memory"
	self.pressed.connect(self._button_pressed)

func _button_pressed():
	pass
