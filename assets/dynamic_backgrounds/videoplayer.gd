extends VideoPlayer

var current_scene

var x : bool = true

func _process(delta):
	if input_handler.globalsettings.animatedbackground == false && self.is_playing() == false && is_visible_in_tree() == true:
		self.play()
		x = true
	if input_handler.globalsettings.animatedbackground == true && x == true:
		yield(get_tree().create_timer(0.7), "timeout")
		self.stop()
		x = false

func open(background):
	if current_scene != background:
		current_scene = background
		stream = images.dynamic_backgrounds[background]
		self.play()
	show()
