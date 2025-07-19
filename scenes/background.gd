extends Sprite2D

func _process(_delta: float) -> void:
	# Get the size of the viewport (the visible area of the window)
	var viewport_size = get_viewport().get_visible_rect().size
	
	# Set the sprite texture size to be the same as viewport size
	scale = viewport_size / texture.get_size()
