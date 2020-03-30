extends VideoPlayer

func _process(delta):
	if self.is_playing() == false && is_visible_in_tree() == true:
		self.play()

func _input(event):
	if event.is_action_pressed("+"):
		$TextureRect.visible = !$TextureRect.visible

func open(background):
	stream = images.dynamic_backgrounds[background]
	show()
