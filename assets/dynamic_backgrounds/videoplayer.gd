extends VideoPlayer

func _process(delta):
	if self.is_playing() == false:
		self.play()

func _input(event):
	if event.is_action_pressed("+"):
		$TextureRect.visible = !$TextureRect.visible