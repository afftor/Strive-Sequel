extends VideoPlayer

var current_scene

#var x : bool = true

#func _process(delta):
##	print(stream_position)
##	if input_handler.globalsettings.animatedbackground == false && self.is_playing() == false && is_visible_in_tree() == true:
##		print('+')
##		self.play()
##		x = true
#	if input_handler.globalsettings.animatedbackground == true && x == true:
#		yield(get_tree().create_timer(0.7), "timeout")
#		self.stop()
#		x = false

func open(background):
	if current_scene != background:
		current_scene = background
		stream = images.dynamic_backgrounds[background]
		self.play()
		if input_handler.globalsettings.animatedbackground:
			#video seems to need 3 frames to put some image on screen
			#need to remake it somehow
			yield(get_tree(), "idle_frame")
			yield(get_tree(), "idle_frame")
			yield(get_tree(), "idle_frame")
			self.stop()
#	show()

func consider_stop():
	if input_handler.globalsettings.animatedbackground:
		self.stop()
	else:
		self.play()

func _ready():
	connect('finished', self, 'play')
	input_handler.connect('animatedbackground_changed', self, 'consider_stop')
