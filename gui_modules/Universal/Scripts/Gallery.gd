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
			if state == "scenes":
				node.get_node("Image").texture = images.backgrounds[Gallery.get_image_for_seq(src[i])]
				node.connect("pressed", Gallery, "play_scene", [src[i]])
			else:
				node.get_node("Image").texture = images.backgrounds[src[i]]
				node.connect("pressed", self, "show_fullscreen", [src[i]])


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
func show_scene_images():
	var images = load_images(state)
	input_handler.ClearContainer($ImageContainer)
	if images != null:
		for image in images:
			var newbutton = input_handler.DuplicateContainerTemplate($ImageContainer)
			newbutton.get_node("Image").texture = load(image)
			newbutton.connect("pressed", self, "show_fullscreen", [image])


func show_fullscreen(image): # image:string 
	$FullScreenImage.show()
	Collection = image
#	$FullScreenImage.texture = load(image)
	$FullScreenImage.texture = images.backgrounds[image]
	ResourceScripts.core_animations.UnfadeAnimation($FullScreenImage)
	if !gui_controller.windows_opened.has($FullScreenImage):
		gui_controller.windows_opened.append($FullScreenImage)


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
	$FullScreenImage.texture = images.backgrounds[newimagename]
	Collection = newimagename
