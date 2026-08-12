extends Node

var loader
var wait_frames
var time_max = 8 # msec; keep enough frame time for the loading UI to redraw
var current_scene
var progress_start = 0.0
var progress_end = 100.0
var resource_progress_end = 100.0
var loading_screen_prepared = false
var prepare_scene_before_continue = false
var scene_prepared = false
var scene_transition_in_progress = false

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
	get_node("animation").play("loading")
	set_progress(initial_progress)
	set_process(true)


func goto_scene(path, initial_progress = 0.0, final_progress = 100.0, prepare_scene = false, resource_final_progress = -1.0): # game requests to switch to this scene
	progress_start = initial_progress
	progress_end = final_progress
	prepare_scene_before_continue = prepare_scene
	resource_progress_end = progress_end
	if prepare_scene_before_continue:
		resource_progress_end = min(progress_end, 99.0)
		if resource_final_progress >= 0:
			resource_progress_end = clamp(resource_final_progress, progress_start, progress_end)
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
	if scene_loaded == true and !scene_transition_in_progress:
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
	var displayed_progress = lerp(progress_start, resource_progress_end, progress)
	set_progress(displayed_progress)


func set_progress(progress):
	progress = clamp(progress, 0.0, 100.0)
	$loading/ProgressTexture/ProgressBar.value = progress

	# Keep the progress animation aligned with the overall load, including save data.
	var length = get_node("animation").get_current_animation_length()
	if length > 0:
		get_node("animation").seek(progress * 0.01 * length, true)

func scene_loading_finished(scene_resource):
	new_scene = scene_resource
	if prepare_scene_before_continue:
		set_progress(resource_progress_end)
		call_deferred("prepare_new_scene")
	else:
		scene_loaded = true
		set_progress(progress_end)
		$loading_finished_label.show()

var new_scene


func prepare_new_scene():
	# Let the resource-loading progress render before instance() blocks this thread.
	yield(get_tree(), "idle_frame")
	current_scene = new_scene.instance()
	set_progress(lerp(resource_progress_end, progress_end, 0.125))
	yield(get_tree(), "idle_frame")
	if current_scene is CanvasItem:
		current_scene.hide()
	if current_scene.name == "MansionMainModule":
		current_scene.loading_progress_node = self
		current_scene.loading_progress_range = [
			lerp(resource_progress_end, progress_end, 0.25),
			lerp(resource_progress_end, progress_end, 0.75)
		]
	gui_controller.current_screen = current_scene
	input_handler.CurrentScene = current_scene
	globals.emit_signal("scene_change_start")
	get_node("/root").add_child(current_scene)
	get_node("/root").move_child(self, get_node("/root").get_child_count() - 1)
	set_progress(lerp(resource_progress_end, progress_end, 0.25))

	# Mansion initialization continues after its own idle-frame yield. Its completion
	# signal makes sure list rebuilding and the rest of _ready() count as loading too.
	if current_scene.has_signal("initialization_finished"):
		yield(current_scene, "initialization_finished")
	else:
		yield(get_tree(), "idle_frame")
	set_progress(lerp(resource_progress_end, progress_end, 0.80))
	yield(get_tree(), "idle_frame")
	if input_handler.CurrentScene.name == "MansionMainModule":
		input_handler.interacted_character = null
		input_handler.CurrentScene.mansion_state_set("default")
	set_progress(lerp(resource_progress_end, progress_end, 0.975))
	yield(get_tree(), "idle_frame")

	scene_prepared = true
	get_node("/root").move_child(self, get_node("/root").get_child_count() - 1)
	set_progress(progress_end)
	$loading_finished_label.show()
	scene_loaded = true


func set_new_scene():
	if scene_transition_in_progress:
		return
	scene_transition_in_progress = true
	scene_loaded = false
	var transition_duration = 0.3
	var tree = get_tree()
	var root = tree.get_root()
	var blackscreen = load(ResourceScripts.scenedict.black).instance()
	root.add_child(blackscreen)
	yield(ResourceScripts.core_animations.UnfadeAnimation(blackscreen, transition_duration), "completed")

	# The loading screen remains visible until the overlay is fully opaque. Only then
	# reveal the prepared scene, so no mansion frame can flash before the transition.
	$loading_finished_label.hide()
	if scene_prepared:
		if current_scene is CanvasItem:
			current_scene.show()
		if current_scene.has_method("loading_screen_finished"):
			current_scene.loading_screen_finished()
	else:
		current_scene = new_scene.instance()
		gui_controller.current_screen = current_scene
		# gui_controller.mansion
		input_handler.CurrentScene = current_scene
		globals.emit_signal("scene_change_start")
		root.add_child(current_scene)
	root.remove_child(self)
	if input_handler.CurrentScene.name == "MansionMainModule":
		input_handler.interacted_character = null
		input_handler.CurrentScene.mansion_state_set("default")

	root.move_child(blackscreen, root.get_child_count() - 1)
	ResourceScripts.core_animations.FadeAnimation(blackscreen, transition_duration)
	yield(tree.create_timer(transition_duration + 0.05), "timeout")
	blackscreen.queue_free()
	globals.emit_signal("scene_changed")
	self.queue_free()
