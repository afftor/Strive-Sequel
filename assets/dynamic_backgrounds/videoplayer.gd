extends VideoPlayer

func _process(delta):
	if self.is_playing() == false && is_visible_in_tree() == true:
		self.play()


func open(background):
	stream = images.dynamic_backgrounds[background]
	show()
