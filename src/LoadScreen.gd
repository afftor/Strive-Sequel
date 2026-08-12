extends Node

var loader
var wait_frames
var time_max = 8 # msec; keep enough frame time for the loading UI to redraw
var current_scene
var progress_start = 0.0
var progress_end = 100.0
var loading_screen_prepared = false

var loadingtipnumber = 16

var load_lore = [
	{name = "LOADLORE1NAME", text = "LOADLORE1", characters = ['duncan','myr']},
	{name = "LOADLORE2NAME", text = "LOADLORE2", characters = ['amelia','sigmund']},
	{name = "LOADLORE3NAME", text = "LOADLORE3", characters = ['anastasia','greg']},
	{name = "LOADLORE4NAME", text = "LOADLORE4", characters = ['daisy_default','cali','leon']},
	{name = "LOADLORE5NAME", text = "LOADLORE5", characters = ['lilia']},
	{name = "LOADLORE6NAME", text = "LOADLORE6", characters = ['zephyra']},
	{name = "LOADLORE7NAME", text = "LOADLORE7", characters = ['amelia','duncan','daisy_default']}
	
]

var scene_loaded = false

var mainmenu = "res://GUI_New/Menu.tscn"

func _ready():
	var root = get_tree().get_root()
	set_process(true)
	current_scene = root.get_child(root.get_child_count() -1)
	#goto_scene(mainmenu)

func prepare_loading(initial_progress = 0.0):
	if !loading_screen_prepared:
		loading_screen_prepared = true
		$loading/HintText.text = tr("TIPLABEL") + ": " + tr(
			"LOADINGTIP"+str(round(rand_range(1, loadingtipnumber)))
		)

		var lore_data = load_lore[rand_range(0, load_lore.size())]
		$loading/Loretext.bbcode_text = tr(lore_data.text)
		$loading/Lorelabel.text = tr(lore_data.name)
		$loading/Sprite.texture = images.get_sprite(input_handler.random_from_array(lore_data.characters))

	scene_loaded = false
	$loading_finished_label.hide()
	set_progress(initial_progress)
	get_node("animation").play("loading")
	set_process(true)


func goto_scene(path, initial_progress = 0.0, final_progress = 100.0): # game requests to switch to this scene
	progress_start = initial_progress
	progress_end = final_progress
	prepare_loading(progress_start)
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
		#show_error()
		return
	#print(true)

	#current_scene.queue_free() # get rid of the old scene

	wait_frames = 1

func _input(event):
	if !event.is_pressed():# || (!event.button_index == BUTTON_LEFT && !event.button_index == BUTTON_RIGHT):
		return
	if scene_loaded == true:
		set_new_scene()

func _process(delta):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return
	if wait_frames > 0: # wait for frames to let the "loading" animation show up
		wait_frames -= 1
		return
	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max: # use "time_max" to control how much time we block this thread
		# poll your loader
		var err = loader.poll()
		if err == ERR_FILE_EOF: # load finished
			var resource = loader.get_resource()
			loader = null
			scene_loading_finished(resource)
			#set_process(false)
			break
		elif err == OK:
			update_progress()
		else: # error during loading
			#show_error()
			loader = null
			break

func update_progress():
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	set_progress(lerp(progress_start, progress_end, progress))


func set_progress(progress):
	progress = clamp(progress, 0.0, 100.0)
	$loading/ProgressTexture/ProgressBar.value = progress

	# Keep the progress animation aligned with the overall load, including save data.
	var length = get_node("animation").get_current_animation_length()
	if length > 0:
		get_node("animation").seek(progress * 0.01 * length, true)

func scene_loading_finished(scene_resource):
	scene_loaded = true
	set_progress(progress_end)
	$loading_finished_label.show()
	new_scene = scene_resource

var new_scene

func set_new_scene():
	ResourceScripts.core_animations.BlackScreenTransition(1)
	$loading_finished_label.hide()
	scene_loaded = false
	current_scene = new_scene.instance()
	gui_controller.current_screen = current_scene
	# gui_controller.mansion
	input_handler.CurrentScene = current_scene
	globals.emit_signal("scene_change_start")
	get_node("/root").add_child(current_scene)
	get_node("/root").remove_child(self)
	if input_handler.CurrentScene.name == "MansionMainModule":
		input_handler.interacted_character = null
		input_handler.CurrentScene.mansion_state_set("default")
	globals.emit_signal("scene_changed")
	self.queue_free()
