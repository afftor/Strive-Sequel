extends Control

var state

var close_state : bool

var scenes_per_page = 12

var Collection : String
var imagename

export var test_mode:bool

func test_mode():
	gui_controller.current_screen = self
	globals.common_effects([
		{code = "unlock_asset", dir = "gallery_seq", key = "lich_aire_talkk"},
		{code = "unlock_asset", dir = "ero_scenes", key = "anastasia_sex_1"},
		])

func _ready():
	if test_mode: test_mode()
	$StoryButton.connect("pressed", self, "set_state", ["story"])
	$StoryButton.set_meta("type", "story")
	$EroButton.connect("pressed", self, "set_state", ["ero"])
	$EroButton.set_meta("type", "ero")
	$SceneButton.connect("pressed", self, "set_state", ["scenes"])
	$SceneButton.set_meta("type", "scenes")
	$MonoButton.connect("pressed", self, "set_state", ["mono"])
	$MonoButton.set_meta("type", "mono")
	$CharButton.connect("pressed", self, "set_state", ["char"])
	$CharButton.set_meta("type", "char")
	$CloseButton.connect("pressed", self, "close_gallery")
	set_state("story")
	
	$FullScreenImage.connect("gui_input", self, '_on_FullScreenImage_gui_input')
#	load_images("story")
#	show_scene_images() 


func set_state(value):
	state = value
	for button in get_children():
		if !button.has_meta("type"):
			continue
		button.pressed = button.get_meta("type") == state
#	show_scene_images()
	build_gallery(0)


func build_gallery(page):
	var src 
	var src_unlock
	match state:
		"ero":
			src = Gallery.ero_scenes
			src_unlock = input_handler.progress_data.ero_scenes
		"story":
			src = Gallery.story_scenes
			src_unlock = input_handler.progress_data.story_scenes
		"scenes":
			src = Gallery.scenes_order
			src_unlock = input_handler.progress_data.gallery_seq
		"mono":
			src = Gallery.mono_scenes
			src_unlock = input_handler.progress_data.monochrome
		"char":
			src = Gallery.char_scenes
			src_unlock = input_handler.progress_data.characters
	
	#building pages buttons
	input_handler.ClearContainer($Pagination)
	var page_max = (src.size() - 1) / scenes_per_page + 1
	if page >= page_max:
		page = page_max - 1
	for i in range(page_max):
		var node = input_handler.DuplicateContainerTemplate($Pagination)
		node.get_node("Label").text = str(i+1)
		node.pressed = (i == page)
		node.connect("pressed", self, "build_gallery", [i])
	
	#building container
	input_handler.ClearContainer($ImageContainer)
	for i in range(page * scenes_per_page, (page + 1) * scenes_per_page):
		if i >= src.size(): break
		var node = input_handler.DuplicateContainerTemplate($ImageContainer)
		if !src_unlock.has(src[i]):
			node.disabled = true
			node.get_node("Image").texture = load("res://assets/Textures_v2/Travel/placer_travel_question.png")
			if state == 'ero':
				node.get_node("QuestionMark").visible = true#state == "ero"
				globals.connectgallerytooltip(node.get_node("QuestionMark"), Gallery.scene_tooltips[src[i]])
#			node.get_node("SceneName").text = "Scene Name"
		else:
			node.get_node("Image").texture = get_texture_by_name(src[i])
			if state == "scenes":
				node.connect("pressed", Gallery, "play_scene", [src[i]])
			else:
				node.connect("pressed", self, "show_fullscreen", [src[i]])

func get_texture_by_name(image_name):
	if state == "scenes":
		return images.get_background(Gallery.get_image_for_seq(image_name))
	elif state == "ero" or state == "story":
		return images.get_background(image_name)
	elif state == "mono":
		return images.get_scene(image_name)
	elif state == "char":
		return images.get_sprite(image_name)

#possibly obsolete
func load_images(scene_type):
	#var data
#	var file = File.new()
#	if !file.file_exists(variables.userfolder + 'progress-data'):
#		return
#	else:
#		file.open(variables.userfolder + 'progress-data', file.READ)
#	var text = file.get_as_text()
#	file.close()
#	var parse_result
#	parse_result = JSON.parse(text)
	var data = input_handler.progress_data
	var image_list
	match scene_type:
		"ero":
			image_list = data.ero_scenes
		"story":
			image_list = data.story_scenes
	return image_list

#possibly obsolete
#func show_scene_images():
#	var images = load_images(state)
#	input_handler.ClearContainer($ImageContainer)
#	if images != null:
#		for image in images:
#			var newbutton = input_handler.DuplicateContainerTemplate($ImageContainer)
#			newbutton.get_node("Image").texture = load(image)
#			newbutton.connect("pressed", self, "show_fullscreen", [image])


func show_fullscreen(image): # image:string 
	var FS_node = $FullScreenImage
	FS_node.show()
	Collection = image
#	FS_node.texture = load(image)
	if state == "char":
		FS_node.stretch_mode = FS_node.STRETCH_KEEP_ASPECT_CENTERED
	else:
		FS_node.stretch_mode = FS_node.STRETCH_KEEP_ASPECT_COVERED
	FS_node.texture = get_texture_by_name(image)
	ResourceScripts.core_animations.UnfadeAnimation(FS_node)
	if !gui_controller.windows_opened.has(FS_node):
		gui_controller.windows_opened.append(FS_node)


func open_gallery():
	ResourceScripts.core_animations.UnfadeAnimation(self)
	yield(get_tree().create_timer(0.3), "timeout")
	gui_controller.current_screen = self
	show()


func close_gallery():
	
	if close_state == true:
		gui_controller.close_scene(self)
		queue_free()
		return
		
	ResourceScripts.core_animations.FadeAnimation(self)
	yield(get_tree().create_timer(0.3), "timeout")
	hide()


func _on_FullScreenImage_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			match state:
				"ero":
					FindNextImagesInPlayer()
				"story":
					pass
				"scenes":
					pass
	
func FindNextImagesInPlayer():
	#делим Collection 
	imagename = Collection
	Collection = Collection.rstrip("1234567890")
	#
	var content : Array = Gallery.ero_scenes_collection[str(Collection)]
	var count = content.size() # сколько всего картинок в коллекции
	var currentCount = 0 # номер текущего изображения в коллеции
	
	for i in content:# узнаем номер картинки в коллекции
		if i == imagename:
			break
		currentCount += 1
	if currentCount == content.size() - 1:#если картинка была последняя в коллекции то выходим
		$FullScreenImage.hide()
		return
	
	var progress : Array = input_handler.progress_data.ero_scenes
	var newimagename = content[currentCount + 1]
	#Если изображение у игрока не открыто, то показываем другую картинку
	if !progress.has(content[currentCount + 1]):
		$FullScreenImage.texture = load("res://assets/Textures_v2/back_charinfo.png")
		Collection = newimagename
		return
	#
	$FullScreenImage.texture = images.get_background(newimagename)
	Collection = newimagename


func _on_ResetProgress_pressed():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'reset_gallery_progress', tr("GALLERYRESETTEXT")])

func reset_gallery_progress():
	input_handler.progress_data.story_scenes = []
	input_handler.progress_data.ero_scenes = []
	input_handler.progress_data.gallery_seq = []
	input_handler.save_progress_data(input_handler.progress_data)
	set_state("story")
