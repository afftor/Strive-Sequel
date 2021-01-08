extends Control

var state


func _ready():
	$StoryButton.connect("pressed", self, "set_state", ["story"])
	$StoryButton.set_meta("type", "story")
	$EroButton.connect("pressed", self, "set_state", ["ero"])
	$EroButton.set_meta("type", "ero")
	$CloseButton.connect("pressed", self, "close_galery")
	load_images("story")
	show_scene_images() 


func set_state(value):
	state = value
	for button in get_children():
		if !button.has_meta("type"):
			continue
		button.pressed = button.get_meta("type") == state
	show_scene_images()


func load_images(scene_type):
	var data
	var file = File.new()
	if !file.file_exists(variables.userfolder + 'progress-data'):
		return
	else:
		file.open(variables.userfolder + 'progress-data', file.READ)
	var text = file.get_as_text()
	file.close()
	var parse_result
	parse_result = JSON.parse(text)
	data = parse_result.result
	var image_list
	match scene_type:
		"ero":
			image_list = data.ero_scenes
		"story":
			image_list = data.story_scenes
	return image_list


func show_scene_images():
	var images = load_images(state)
	input_handler.ClearContainer($ImageContainer)
	if images != null:
		for image in images:
			var newbutton = input_handler.DuplicateContainerTemplate($ImageContainer)
			newbutton.get_node("Image").texture = load(image)
			newbutton.connect("pressed", self, "show_fullscreen", [image])


func show_fullscreen(image):
	$FullScreenImage.show()
	$FullScreenImage.texture = load(image)
	ResourceScripts.core_animations.UnfadeAnimation($FullScreenImage)


func open_galery():
	ResourceScripts.core_animations.UnfadeAnimation(self)
	yield(get_tree().create_timer(0.3), "timeout")
	show()


func close_galery():
	ResourceScripts.core_animations.FadeAnimation(self)
	yield(get_tree().create_timer(0.3), "timeout")
	hide()
