extends VideoPlayer

var current_scene

func _process(delta):
	if self.is_playing() == false && is_visible_in_tree() == true:
		self.play()


func open(background):
	if current_scene != background:
		current_scene = background
		stream = images.dynamic_backgrounds[background]
	show()
