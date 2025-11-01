extends Node

#This script handles inputs, sounds, closes windows and plays animation
#warning-ignore-all:unused_signal
#warning-ignore-all:return_value_discarded
var file = File.new()
var dir = Directory.new()

var TranslationData = {}

var CloseableWindowsArray = []
var MousePositionScripts = []

var CurrentScreen = 'menu'
var GameStartNode

var CurrentScene #holds reference to instanced scene
var combat_node = null

var text_field_input = false

signal StartingSequenceComplete
signal ScreenChanged
signal BuildingEntered
signal ItemObtained
signal MaterialObtained
signal ExplorationStarted
signal CombatStarted
signal CombatEnded
signal WorkerAssigned
signal SpeedChanged
signal UpgradeUnlocked
signal EventFinished
signal QuestStarted
signal QuestCompleted
signal CharacterCreated
signal CharacterUpdated
signal EnemyKilled
signal ButtonUpdated (node)
signal LootGathered
signal LocationSlavesUpdate
signal PortraitUpdate
signal update_ragdoll
signal update_itemlist
signal survival_advance
signal fighter_changed
signal clear_cashed
signal SpellUsed

#animations queue
signal animation_finished
signal animations_compleated
var animations_queue = []

var last_action_data = {}
var text_characters = []

var slave_list_node
#Added
var skill_list_node
var Mansion
var SlaveModule
var PreviousScene
var interacted_character


var exploration_node
var active_character
var scene_characters = []
var scene_loot
var active_area
var selected_area
var active_location
var selected_location
var active_faction = {}

var activated_skill
var target_character

var ghost_items = []#probably not in use


var encounter_win_script = null
var encounter_lose_script = null
var explore_sound = 'exploration'

var musicfading = false
var musicraising = false
var musicvalue

var selectedquest

enum {
	NODE_CLASSINFO,
	NODE_CHAT,
	NODE_TUTORIAL,
	NODE_LOOTTABLE,
	NODE_DIALOGUE,
#	NODE_DIALOGUE_T2,
	NODE_INVENTORY,
	NODE_POPUP,
	NODE_ALERT_PANEL,
	NODE_CONFIRMPANEL,
	NODE_YESNOPANEL,
	NODE_YESORNOPANEL,
	NODE_SLAVESELECT,
	NODE_SKILLSELECT,
	NODE_EVENT,
	NODE_MUSIC,
	NODE_SOUND,
	NODE_BACKGROUND_SOUND,
	NODE_TEXTEDIT,
	NODE_SLAVETOOLTIP,
	NODE_SKILLTOOLTIP,
	NODE_ITEMTOOLTIP,
#	NODE_ITEMTOOLTIP_V2,
	NODE_TEXTTOOLTIP,
	NODE_GALLERYTOOLTIP,
	NODE_CHARCREATE,
	NODE_CHAREDIT,
	NODE_COMBATPOSITIONS,
	NODE_SYSMESSAGE,
	NODE_SLAVEMODULE,
	NODE_INVENTORY_NEW,
	NODE_SPELLS,
	NODE_MANSION_NEW,
	NODE_CLOCK,
	NODE_NAVIGATION,
	NODE_EXPLORATION,
	NODE_EXPLORATION_CITY,
	NODE_EXPLORATION_DUNGEON,
	NODE_EXPLORE_SLAVEINFO,
	NODE_GAMEMENU,
	NODE_SEX,
	NODE_DATE,
	NODE_TUTORIAL_PANEL,
	NODE_TRAIREM_PANEL,
	NODE_ARENA,
	#Animations
	ANIM_TASK_AQUARED,
	ANIM_BATTLE_START,
	ANIM_BATTLE_DEFEAT,
	ANIM_BATTLE_RUNAWAY,
	ANIM_CLASS_ACHIEVED,
	ANIM_CLASS_UNLOCKED,
	ANIM_TASK_COMPLETED,
	ANIM_LOOT,
	ANIM_SKILL_UNLOCKED,
	ANIM_GROWTHF,
	ANIM_MASTER_POINT,
} #, NODE_TWEEN, NODE_REPEATTWEEN}


var globalsettings = {
	ActiveLocalization = 'en',
	animatedbackground = false,
	mastervol = -15,
	mastermute = false,
	musicvol = -20,
	musicmute = false,
	soundvol = -15,
	soundmute = false,

	#Window settings
	fullscreen = true,
	window_size = Vector2(1366,768),
	window_pos = Vector2(0,0),

	factors_as_words = true,
	show_full_consent = false,
	disable_paperdoll = false,

	textspeed = 60,
	skipread = false,
	textmonocolor = false,
	warnseen = false,
	disabletips = false,
	easytrain = false,

	futa = false,
	furry = true,
	furry_multiple_nipples = false,
	futa_balls = true,
	futachance = 10,
	malechance = 50,
	meowing = true,
	#user_folders_settings
	portrait_folder = 'user://portraits/',
	body_folder = 'user://bodies/',
	#mod_folder = 'user://mods/',
	
	
	grid_inventory = true,
	
	no_breed_incompatibility = false,
	turn_based_time_flow = true,


	autosave = true,
	autosave_number = 3,
	autosave_frequency = 4,
	
	sex_filter = false, # if true skips erotic scenes that doesn't match up with masters gender
	
	generate_portraits = true,
	
	stop_log_alert = false

} setget settings_save

# Progress data template
var progress_data = {
	story_scenes = [],
	ero_scenes = [],
	gallery_seq = [],
	characters = [],#'amelia','duncan','sigmund','myr'
	monochrome = []
} setget save_progress_data

#var combat_advance = false #if any result in combat cause advance
#var combat_explore = false #if we can advance at all

func set_previous_scene(scene):
	PreviousScene = scene

func settings_load():
	var config = ConfigFile.new()
	if file.file_exists(variables.userfolder + "Settings.ini") == false:
		settings_save(globalsettings)
	config.load(variables.userfolder + "Settings.ini")
	var settings = config.get_section_keys("settings")
	for i in settings:
		globalsettings[i] = config.get_value("settings", i, null)
	#updatevolume
	var counter = 0
	for i in ['master','music','sound']:
		AudioServer.set_bus_mute(counter, globalsettings[i+'mute'])
		AudioServer.set_bus_volume_db(counter, globalsettings[i+'vol'])
		counter += 1

func settings_save(value):
	globalsettings = value
	var config = ConfigFile.new()
	config.load(variables.userfolder + "Settings.ini")
	for i in globalsettings:
		config.set_value('settings', i, globalsettings[i])
	config.save(variables.userfolder + "Settings.ini")
	if CurrentScene != null and weakref(CurrentScene) != null and CurrentScene.name == 'mansion':
		CurrentScene.set_time_buttons()

func load_progress_data():
	var text
	var file = File.new()
	var parse_result
	if file.file_exists(variables.userfolder + 'progress_data'):
		file.open(variables.userfolder + 'progress_data', file.READ)
		text = file.get_as_text()
#		parse_result = parse_json(text)
		parse_result = JSON.parse(text).result
		for key in parse_result:
			progress_data[key] = parse_result[key]
#		progress_data = parse_result.result
	else:
		save_progress_data(progress_data)
	file.close()

func save_progress_data(data):
	progress_data = data
	store_progress()


func update_progress_data(field, value):
	if !progress_data.has(field):
		print("Warning: progress data has no '", str(field), "' field.")
		return
	if typeof(value) != TYPE_STRING:
		return
	if progress_data[field].has(value):
		return
	progress_data[field].push_back(value)
	store_progress()


func store_progress():
	var text
	var file = File.new()
	file.open(variables.userfolder + 'progress_data', file.WRITE)
	text = JSON.print(progress_data)
	file.store_string(text)
	file.close()
#	var text
#	var parse_result
#	var data
#	var file = File.new()
#	if file.file_exists(variables.userfolder + 'progress_data'):
#		file.open(variables.userfolder + 'progress_data', file.READ)
#		text = file.get_as_text()
#		parse_result = JSON.parse(text)
#		data = parse_result.result
#	else:
#		data = progress_data
#	file.close()
#	match field:
#		"story_scenes":
#			append_not_duplicate(data.story_scenes, value.get_load_path()) #Passed "value" should be the type of StreamTexture
#		"ero_scenes":
#			append_not_duplicate(data.ero_scenes, value.get_load_path())
#		'character':
#			append_not_duplicate(data.characters, value)
#		_: #Default
#			append_not_duplicate(data[field], value)
#	file = File.new()
#	file.open(variables.userfolder + 'progress_data', file.WRITE)
#	text = JSON.print(data)
#	file.store_string(text)
#	file.close()


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		quit()
#		globalsettings.window_size = OS.window_size
#		globalsettings.window_pos = OS.window_position
#		settings_save(globalsettings)
#		get_tree().quit()


func quit():
	characters_pool.cleanup(true)
	globalsettings.window_size = OS.window_size
	globalsettings.window_pos = OS.window_position
	settings_save(globalsettings)
	#get_tree().get_root().queue_free()
	get_tree().quit()


func _init():
	settings_load()
	OS.window_size = globalsettings.window_size
	OS.window_position = globalsettings.window_pos
	settings_load()
	load_progress_data()
	
	#Storing available translations
	for i in scanfolder(variables.LocalizationFolder):
		var loc_code = i.replace(variables.LocalizationFolder, '')
		TranslationData[i.replace(variables.LocalizationFolder, '')] = {data = (i + "/main.gd"), info = i + "/info.gd"}
		
#			file.open(ifile, File.READ)
#			var data = file.get_as_text()
#	for i in dir_contents(LocalizationFolder):
#		TranslationData[i.replace(LocalizationFolder + '/', '').replace('.gd','')] = i

	#Applying active translation
	var activetranslation = Translation.new()
	if TranslationData.has(globalsettings.ActiveLocalization) == false:
		globalsettings.ActiveLocalization = 'en'
	var translationscript = load(TranslationData[globalsettings.ActiveLocalization].data).new()
	activetranslation.set_locale(globalsettings.ActiveLocalization)
	for i in translationscript.TranslationDict:
		activetranslation.add_message(i, translationscript.TranslationDict[i])
	TranslationServer.add_translation(activetranslation)
	change_locale()

func change_locale(locale = globalsettings.ActiveLocalization):
	TranslationServer.set_locale(locale)


func _ready():
	GUISoundManagerInit()
	#Storing available translations
	for i in scanfolder(variables.LocalizationFolder):
		for ifile in dir_contents(i):
			TranslationData[i.replace(variables.LocalizationFolder, '')] = ifile
	
	connect("UpgradeUnlocked", self, "upgrade_unlocked")
	connect("animation_finished", self, "animation_queue_start_force")


func gather_skills_effects():
	for i in dir_contents(variables.SkilldataFolder):
		var tlib = load(i).new()
		for id in tlib.skills:
			Skilldata.Skilllist[id] = tlib.skills[id].duplicate(true)
		for id in tlib.effects:
			Effectdata.effect_table[id] = tlib.effects[id].duplicate(true)
		for id in tlib.atomic_effects:
			Effectdata.atomic[id] = tlib.atomic_effects[id].duplicate(true)
		for id in tlib.buffs:
			Effectdata.buffs[id] = tlib.buffs[id].duplicate(true)
		for id in tlib.stacks:
			Effectdata.stacks[id] = tlib.stacks[id].duplicate(true)


#func _unhandled_input(event):
func _input(event):
	if event.is_echo() == true && !event.is_action_type():
		return
	if gui_controller.current_screen == null:
		return
	for action in ['ui_accept', 'ui_left', 'ui_right']:
		if event.is_action(action) and !(CurrentScene.get_focus_owner() is LineEdit or CurrentScene.get_focus_owner() is TextEdit):
			get_tree().set_input_as_handled()
	for action in ['ui_cancel', 'ui_up', 'ui_down']:
		if event.is_action(action):
			get_tree().set_input_as_handled()
	if event.is_action_released("F1") \
		&& gui_controller.current_screen == gui_controller.mansion:
		if gui_controller.mansion_tutorial_panel == null || !gui_controller.mansion_tutorial_panel.is_visible():
			gui_controller.mansion.show_tutorial()
		else:
			gui_controller.mansion_tutorial_panel.hide()
	if event.is_action_released("F9"):
		OS.window_fullscreen = !OS.window_fullscreen
		input_handler.globalsettings.fullscreen = OS.window_fullscreen
		if input_handler.globalsettings.fullscreen == false:
			OS.window_position = Vector2(0,0)
	if (event.is_action_pressed("ESC") || event.is_action_released("RMB")):
#		get_tree().get_root().print_tree_pretty()
		for i in get_tree().get_nodes_in_group("disable_rmb_esc"):
			if i.is_visible_in_tree():
				if gui_controller.windows_opened.size() > 0:
					gui_controller.close_top_window()
				return
		var ignore_rightclick = false
		for i in get_tree().get_nodes_in_group("ignore_rightclicks"):
			if i.get_global_rect().has_point(i.get_global_mouse_position()) && i.is_visible():
				ignore_rightclick = true
				continue
		if ignore_rightclick == false:
			if gui_controller.windows_opened.size() > 0:
				gui_controller.close_top_window()
				for subscene in gui_controller.current_screen.get_children():
					if subscene.get_class() == "Tween":
						continue
					if subscene.has_method('update'):#stub
						subscene.update()
				return
			else:
				match gui_controller.current_screen:
					gui_controller.mansion:
						if gui_controller.mansion.Journal.is_visible_in_tree():
							gui_controller.mansion.MenuModule.open_journal(false)
							return
						if event.is_action("ESC") && gui_controller.mansion.mansion_state in ["default", "skills"]:
							if gui_controller.mansion_tutorial_panel != null && gui_controller.mansion_tutorial_panel.is_visible():
								gui_controller.mansion_tutorial_panel.hide()
								return
							gui_controller.mansion.show_menu()
						else:
							gui_controller.mansion.mansion_state_set("default")
						gui_controller.clock.raise()
					gui_controller.inventory:
						if gui_controller.inventory.list_mode == "tattoo":
							gui_controller.inventory.change_list_mode()
							return
						gui_controller.inventory.hide()
						gui_controller.current_screen = gui_controller.previous_screen
						if gui_controller.previous_screen == gui_controller.slavepanel:
							gui_controller.previous_screen = gui_controller.mansion
							gui_controller.slavepanel.update()
						gui_controller.current_screen.show()
						gui_controller.mansion.set_active_person(interacted_character)
						gui_controller.mansion.SlaveListModule.selected_location = "show_all"
						gui_controller.mansion.SlaveListModule.prev_selected_location = "show_all"
						gui_controller.mansion.SlaveListModule.show_location_characters()
					gui_controller.game_menu:
						gui_controller.game_menu.hide()
#						gui_controller.current_screen = gui_controller.previous_screen
					gui_controller.slavepanel:
						gui_controller.slavepanel.hide()
						# gui_controller.slavepanel.SummaryModule.selected_person = null
						gui_controller.current_screen = gui_controller.mansion
						gui_controller.mansion.set_active_person(interacted_character)
						gui_controller.current_screen.show()
						gui_controller.mansion.mansion_state_set("default")
						gui_controller.mansion.SlaveListModule.selected_location = "show_all"
						gui_controller.mansion.SlaveListModule.prev_selected_location = "show_all"
						gui_controller.mansion.SlaveListModule.show_location_characters()
					gui_controller.explore_slaveinfo:
						gui_controller.explore_slaveinfo.hide()
						gui_controller.current_screen = gui_controller.previous_screen
						gui_controller.update_modules()
						gui_controller.current_screen.show()

			if gui_controller.current_screen == gui_controller.mansion:
				gui_controller.clock.raise()
			if gui_controller.current_screen == gui_controller.exploration or gui_controller.current_screen == gui_controller.exploration_city or gui_controller.current_screen == gui_controller.exploration_dungeon:
#				var location = active_location
				var capital = false
				capital = active_location.type == "capital"
				if capital:
					gui_controller.clock.raise()
					gui_controller.clock.show()
		gui_controller.update_modules()
#	if !text_field_input:
	if  CurrentScene is Control and !(CurrentScene.get_focus_owner() is LineEdit or CurrentScene.get_focus_owner() is TextEdit):
		if str(event.as_text().replace("Kp ",'')) in str(range(1,9)):
			var num = event.as_text().replace("Kp ",'')
#			var tnode = get_tree().get_root().get_node_or_null("dialogue")
			var tnode = gui_controller.dialogue
			if tnode != null and tnode.visible:
				tnode.select_option(int(num) - 1)
			else:
				if gui_controller.clock != null and gui_controller.clock.is_visible_in_tree():
					if str(int(event.as_text())) in str(range(1,4)) && !event.is_pressed():
						gui_controller.clock.hotkey_pressed(int(num))
#						if input_handler.globalsettings.turn_based_time_flow == false:
#							gui_controller.clock.changespeed(gui_controller.clock.timebuttons[int(num)-1])
#						else:
#							gui_controller.clock.timeflowhotkey(int(num))
	
	#there was an error in a code below
	#while during fix it was fully rewritten to reflect some functional change, i choose to keep a fixed old version as a comment
	#as an example of correct construction of complex negations
	#if you remember about exitence of similar constructions in a code out there - check if there are the same error  
	
#	if (gui_controller.current_screen == gui_controller.mansion || gui_controller.current_screen == gui_controller.exploration) \
#		&& str(event.as_text().replace("Kp ",'')) in str(range(1,9)) \
#		&& gui_controller.windows_opened.size() == 0 \
#		&& text_field_input == false \
#		&& !(get_tree().get_root().get_node_or_null("dialogue") && get_tree().get_root().get_node("dialogue").is_visible()):
#		if str(int(event.as_text())) in str(range(1,4)) && !event.is_pressed():
#			if input_handler.globalsettings.turn_based_time_flow == false:
#				gui_controller.clock.changespeed(gui_controller.clock.timebuttons[int(event.as_text())-1])
#			else:
#				gui_controller.clock.timeflowhotkey(int(event.as_text()))
#	elif str(event.as_text().replace("Kp ",'')) in str(range(1,9)) \
#		&& get_tree().get_root().get_node_or_null("dialogue") && get_tree().get_root().get_node("dialogue").is_visible():
#		get_tree().get_root().get_node("dialogue").select_option(int(event.as_text()))


# func _input(event):
# 	if event.is_echo() == true && !event.is_action_type():
# 		return
# 	#print(var2str(event))
# 	if (event.is_action("ESC") || event.is_action_released("RMB")):
# 		var ignore_rightclick = false
# 		for i in get_tree().get_nodes_in_group("ignore_rightclicks"):
# 			if i.visible == true:
# 				ignore_rightclick = true
# 				continue
# 		if ignore_rightclick == false:
# 			if CloseableWindowsArray.size() != 0:
# 				CloseTopWindow()
# 			else:
# 				if CurrentScene.name == 'mansion' && event.is_action("ESC"):
# 					CurrentScene.get_node("MenuPanel").open()
# 	if event.is_action_released("F9"):
# 		OS.window_fullscreen = !OS.window_fullscreen
# 		input_handler.globalsettings.fullscreen = OS.window_fullscreen
# 		if input_handler.globalsettings.fullscreen == false:
# 			OS.window_position = Vector2(0,0)
# 	if CurrentScreen == 'mansion' && str(event.as_text().replace("Kp ",'')) in str(range(1,9)) && CloseableWindowsArray.size() == 0 && text_field_input == false:
# 		if str(int(event.as_text())) in str(range(1,4)) && !event.is_pressed():
# 			if input_handler.globalsettings.turn_based_time_flow == false:
# 				CurrentScene.changespeed(CurrentScene.timebuttons[int(event.as_text())-1])
# 			else:
# 				CurrentScene.timeflowhotkey(int(event.as_text()))
# 	elif CurrentScreen == 'scene' && str(event.as_text().replace("Kp ",'')) in str(range(1,9)):
# 		get_tree().get_root().get_node("dialogue").select_option(int(event.as_text()))
# 	if event.is_action_pressed('full_screen'):
# 		OS.window_fullscreen = !OS.window_fullscreen
# 		input_handler.globalsettings.fullscren = OS.window_fullscreen


func _process(delta):
	if OS.window_position.y < 0:
		OS.window_position.y = 0

	for i in CloseableWindowsArray:
		if typeof(i) == TYPE_STRING: continue
		if i.is_visible_in_tree() == false:
			i.hide()
	soundcooldown -= delta

	for i in MousePositionScripts:
		if check_mouse_in_nodes(i.nodes) == false:
			i.targetnode.call(i.script)
			MousePositionScripts.erase(i)

	if musicfading:
		AudioServer.set_bus_volume_db(1, AudioServer.get_bus_volume_db(1) - delta*50)
		if AudioServer.get_bus_volume_db(1) <= -80:
			musicfading = false
	if musicraising:
		AudioServer.set_bus_volume_db(1, AudioServer.get_bus_volume_db(1) + delta*100)
		if AudioServer.get_bus_volume_db(1) >= input_handler.globalsettings.musicvol:
			AudioServer.set_bus_volume_db(1, input_handler.globalsettings.musicvol)
			musicraising = false




func LockOpenWindow():
	CloseableWindowsArray.append('lock')

func UnlockOpenWindow():
	var node = CloseableWindowsArray.back()
	if typeof(node) == TYPE_STRING:
		CloseableWindowsArray.pop_back();

func OpenClose(node):
	node.show()
	ResourceScripts.core_animations.OpenAnimation(node)
	CloseableWindowsArray.append(node)

func Close(node):
	if gui_controller.windows_opened.has(node):
		gui_controller.windows_opened.erase(node)
	CloseableWindowsArray.erase(node)
	ResourceScripts.core_animations.CloseAnimation(node)

func Open(node):
	if CloseableWindowsArray.has(node):
		return
	ResourceScripts.core_animations.OpenAnimation(node)
	CloseableWindowsArray.append(node)

func ChangeScene(name):
	ResourceScripts.core_animations.BlackScreenTransition(0.3)
	CloseableWindowsArray.clear()
	dialogue_array.clear()
	var loadscreen = load(ResourceScripts.scenedict.loadscreen).instance()
	get_tree().get_root().add_child(loadscreen)
	CurrentScene = loadscreen
	loadscreen.goto_scene(ResourceScripts.scenedict[name])

func GetTweenNode(node): #not compartible with get_spec_node due to not linking new node to root
	var tweennode
	if node.has_node('tween'):
#	if false:
		tweennode = node.get_node('tween')
	else:
		tweennode = Tween.new()
		tweennode.name = 'tween'
		node.add_child(tweennode)
	return tweennode

func GetRepeatTweenNode(node): #not compartible with get_spec_node due to not linking new node to root
	var pos = node.rect_position
	var tweennode
	if node.has_node('repeatingtween'):
		tweennode = node.get_node("repeatingtween")
		tweennode.repeat = true
	else:
		tweennode = Tween.new()
		tweennode.repeat = true
		tweennode.name = 'repeatingtween'
		node.add_child(tweennode)
	return tweennode

func StopTweenRepeat(node):
	var tween = GetRepeatTweenNode(node)
	tween.seek(0)
	tween.set_active(false)
	tween.remove_all()

#Music
func SetMusicRandom(category):
	var track = audio.music_categories[category]
	track = track[randi()%track.size()]
	SetMusic(track)

func SetMusic(name, store = false, delay = 0):
	if !audio.music.has(name):
		 return
	yield(get_tree().create_timer(delay), 'timeout')
	musicraising = true
	var musicnode = get_spec_node(self.NODE_MUSIC) #GetMusicNode()
	if musicnode.stream == audio.music[name]:
		return
	musicnode.stream = audio.music[name]
	if store:
		explore_sound = name
	musicnode.play(0)

func StopMusic(instant = false):
	musicfading = true

func GetMusicNode(): #get_spec_node(input_handler.NODE_MUSIC)
	var node = get_tree().get_root()
	var musicnode
	if node.has_node('music'):
		musicnode = node.get_node('music')
	else:
		musicnode = AudioStreamPlayer.new()
		musicnode.name = 'music'
		musicnode.bus = 'Music'
		node.call_deferred('add_child', musicnode)
	return musicnode

#Sounds
func GUISoundManagerInit():
	get_tree().connect("node_added", self, 'GUISoundManager')


func GUISoundManager(nd):
	for group in variables.GUISounds:
		if nd.is_in_group(group):
			nd.connect('pressed', self, 'PlaySound', [variables.GUISounds[group]])


func PlaySound(name, delay = 0):
	yield(get_tree().create_timer(delay), 'timeout')
	var soundnode = get_spec_node(self.NODE_SOUND) #GetSoundNode()
	soundnode.stream = audio.sounds[name]
	soundnode.seek(0)
	soundnode.play(0)
	yield(soundnode, 'finished')
	soundnode.queue_free()


func PlayBackgroundSound(name):
	var soundnode = get_spec_node(self.NODE_BACKGROUND_SOUND) #GetSoundNode()
	soundnode.stream = audio.background_noise[name]
	soundnode.seek(0)
	soundnode.play(0)

func StopBackgroundSound():
	var soundnode = get_spec_node(self.NODE_BACKGROUND_SOUND) #GetSoundNode()
	soundnode.stop()

func ResumeBackgroundSound():
	var soundnode = get_spec_node(self.NODE_BACKGROUND_SOUND) #GetSoundNode()
	soundnode.play(0)

var soundcooldown = 0

func PlaySoundIsolated(sound, cooldown):
	if soundcooldown > 0:
		return
	PlaySound(sound)
	soundcooldown = cooldown


func ShowSkillSelectPanel(person, type, TargetNode, TargetFunction): #very strange container method
	var node = get_spec_node(self.NODE_SKILLSELECT) #GetSkillSelectNode()
	node.open(person, type, TargetNode, TargetFunction)

func ShowSlaveSelectPanel(TargetNode, TargetFunction, reqs = [], allowcancel = false, challenge = null): #just a strange container method
	var node = get_spec_node(self.NODE_SLAVESELECT) #GetSlaveSelectNode()
	append_not_duplicate(gui_controller.windows_opened, node)
	node.open(TargetNode, TargetFunction, reqs, allowcancel, challenge)



#Item shading function

func itemshadeimage(node, item):
	var shader = load("res://assets/ItemShader.tres").duplicate()
	var icon
	var is_template = false
	if typeof(item.icon) == TYPE_STRING:
		icon = load(item.icon)
	else:
		icon = item.icon
		is_template = true
	if node.get_class() == "TextureButton":
		node.texture_normal = icon
	else:
		node.texture = icon
	if node.material != shader:
		node.material = shader
	else:
		shader = node.material
	if is_template == false:
		for i in item.parts:
			var part = 'part' +  str(item.partcolororder[i]) + 'color'
			var color = Items.materiallist[item.parts[i]].color
			node.material.set_shader_param(part, color)


func operate(operation, value1, value2):
	var result

	match operation:
		'eq':
			result = value1 == value2
		'neq':
			result = value1 != value2
		'gte':
			result = value1 >= value2
		'gt':
			result = value1 > value2
		'lte':
			result = value1 <= value2
		'lt':
			result = value1 < value2
		'has':
			result = value1.has(value2)
		'hasno':
			result = !value1.has(value2)
		'mask':
			result = (int(value1) & int(value2)) != 0
		'in':
			result = value1 in value2
	return result


func operant_translation(operant):
	var text = ''
	match operant:
		'gte':
			text = tr("OPERANTATLEAST")
		'lte':
			text = tr("OPERANTATMOST")
		'in':
			text = ""#tr("OPERANTONEOF")
		'gt':
			text = tr("OPERANTMORE")
		'lt':
			text = tr("OPERANTLESS")
		'eq':
			text = tr("OPERANTEQ")
		'neq':
			text = tr("OPERANTNEQ")
	return text

func math(operation, value1, value2):
	match operation:
		'+':
			value1 += value2
		'-':
			value1 -= value2
		'*':
			value1 *= value2
		'/':
			value1 /= value2
		'=':
			value1 = value2
	return value1

func string_to_math(value = 0, string = ''):
	var modvalue = float(string.substr(1, string.length()))
	var operator = string[0]

	match operator:
		'+':value += modvalue
		'-':value -= modvalue
		'*':value *= modvalue
		'/':value /= modvalue
		'_':value = max(value, modvalue)
		'^':value = min(value, modvalue)
		_: value = string
	return value


func weightedrandom_dict(dict, generator = null): #uses dict of value:weight, returns value
	var temp = []
	for i in dict:
		temp.push_back([i, dict[i]])
	return weightedrandom(temp, generator)


func weightedrandom(array, generator = null): #uses an array of [value, weight] with value being returned according to weight change
	if array.empty(): return null
	var total = 0
	var counter = 0
	for i in array:
		total += i[1]
	var random
	if generator != null:
		random = generator.randf_range(0, total)
	else:
		random = rand_range(0,total)
	for i in array:
		if counter + i[1] >= random:
			return i[0]
		counter += i[1]


func random_from_array(array, generator = null):
	var id
	if generator != null:
		id = generator.randi_range(0, array.size() - 1)
	else:
		id = randi() % array.size()
	return array[id]


func array_shuffle(arr, generator): #for deterministic shuffling
	var res = []
	var pool = []
	for i in range(arr.size()):
		pool.push_back(i)
	while !pool.empty():
		var id = random_from_array(pool, generator)
		pool.erase(id)
		res.push_back(arr[id])
	return res


func open_shell(string):
	var path = string
	match string:
		'Itch':
			path = 'https://strive4power.itch.io/strive-conquest'
		'Patreon':
			path = 'https://www.patreon.com/maverik'
		'Discord':
			path = "https://discord.gg/VXSx9Zk"
		'Wiki':
			path = "https://strive-conquest.fandom.com/wiki/Strive:_Conquest_Wiki"
		'Subscribestar':
			path = "https://subscribestar.adult/maverik"
	OS.shell_open(path)

func SystemMessage(text, time = 4):
	get_spec_node(self.NODE_SYSMESSAGE).show_message(text, time)

func ShowOutline(node):
	node.material = load('res://assets/portret_shader.tres').duplicate()
	node.material.set_shader_param('opacity', 1)

func HideOutline(node):
	node.material.set_shader_param('opacity', 0)

func ConnectSound(node, sound, action):
	node.connect(action, self, 'PlaySound', [sound])

#Slave Panel

func ShowSlavePanel(person): #not fully node getter
	if gui_controller.slavepanel == null:
		gui_controller.slavepanel = get_spec_node(self.NODE_SLAVEMODULE)
	gui_controller.slavepanel.raise()
	gui_controller.slavepanel.open(person)


func calculate_number_from_string_array(arr, caster, target):
	var array = arr.duplicate()
	if array is Dictionary:
		if target.checkreqs(array.condition):
			array = array.value
		else:
			array = array.altvalue
	if typeof(array) != TYPE_ARRAY:
		return float(array)
	var endvalue = 0
	var singleop = ''
	var firstrun = true
	for i in array:
		if typeof(i) == TYPE_ARRAY:
			i = str(calculate_number_from_string_array(i, caster, target))
		if i in ['+','-','*','/']:
			singleop = i
			continue
		var modvalue = i
		if (i.find('caster') >= 0) or (i.find('target') >= 0):
			i = i.split('.')
			if i[0] == 'caster':
				modvalue = str(caster.get_stat(i[1]))
			elif i[0] == 'target':
				modvalue = str(target.get_stat(i[1]))
		elif (i.find('random') >= 0):
			i = i.split(' ')
			modvalue = str(globals.rng.randi_range(0, int(i[1])))
		if singleop != '':
			endvalue = string_to_math(endvalue, singleop+modvalue)
			singleop = ''
			continue
		if !modvalue[0].is_valid_float():
			if modvalue[0] == '-' && firstrun == true:
				endvalue += float(modvalue)
			else:
				endvalue = string_to_math(endvalue, modvalue)
		else:
			endvalue += float(modvalue)
		firstrun = false
	return endvalue


var dialogue_array = []
var event_is_active = false


func interactive_message(code, type = '', args = {}):
	dialogue_array.append({code = code, type = type, args = args})
	start_event_attempt()

func interactive_message_follow(code, type, args): #not safe
	start_event(code, type, args)

func event_finished():
	event_is_active = false
	start_event_attempt()

func start_event_attempt():
	if dialogue_array.size() > 0:
		if event_is_active == true:
#			yield(self, "EventFinished")
			#yield is pointless here because of no code after it
			return
		else:
			var event = dialogue_array[0]
			start_event(event.code, event.type, event.args)
			dialogue_array.erase(event)



func start_event(code, type, args):
	event_is_active = true
	var data
	if type == 'direct':
		data = code
	else:
		data = scenedata.scenedict[code].duplicate(true)
		if !ResourceScripts.game_progress.seen_events.has(code):
			ResourceScripts.game_progress.seen_events.push_back(code)
		if args.has('start_dialogue_option'):
			data.start_dialogue_option = args.start_dialogue_option
	#it seems to be a good idea, to set scene_characters and active_character here
	#instead of setting them manually prior interactive_message()
	if args.has('scene_characters_add'):
		for char_id in args.scene_characters_add:
			var chara = characters_pool.get_char_by_id(char_id)
			if !scene_characters.has(chara):
				scene_characters.push_back(chara)
	if args.has('set_active_character'):
		active_character = characters_pool.get_char_by_id(args.set_active_character)
	
	gui_controller.dialogue = get_spec_node(self.NODE_DIALOGUE)
#	if data.has('opp_characters'):
#		for i in data.opp_characters:
#			match i.type:
#				'pregen':
#					scene_characters.append(make_story_character(i.value))
	match type:
		'social_skill':
			#chars can now translate() text by numbered tags. Refactor advised
			for i in variables.dynamic_text_vars:
				data.text = data.text.replace("[" + i + '1' + ']', "[" + i + "]")
			data.text = args.name1.translate(data.text)
			for i in variables.dynamic_text_vars:
				data.text = data.text.replace("[" + i + '2' + ']', "[" + i + "]")
			data.text = args.name2.translate(data.text)
			scene_characters.append(args.name1)
			if args.has("bonustext"):
				data.text += args.bonustext
			if args.has('repeat'):
				data.options.append({code ='repeat', text = tr('DIALOGUEREPEATACTION'), disabled = !args.repeat})
		'scene_character_event':
			for i in range(0, scene_characters.size()):
				data.text = scene_characters[i].translate(data.text)
		'char_translate':
			active_character = args.ch
		'multichar_event':
			scene_characters.clear()
			scene_characters.push_back(characters_pool.get_char_by_id(args.char1))
			scene_characters.push_back(characters_pool.get_char_by_id(args.char2))
			active_character = characters_pool.get_char_by_id(args.char2)
		'char_event':
			scene_characters.clear()
			for ch in args.scene_chars:
				scene_characters.push_back(characters_pool.get_char_by_id(ch))
		'quest_finish_event':
			data.text = data.text.replace("[dungeonname]", args.locationname)
		'childbirth':
			active_character = args.pregchar
			active_character.set_stat('metrics_birth', active_character.get_stat('metrics_birth') + 1)
			var baby = ResourceScripts.game_party.babies[active_character.get_stat('pregnancy_baby')]
			scene_characters.append(baby)
		'event_selection':
			data.location = active_location
		'loot':
			match args.loot_data.type:
				'tableloot':
#					scene_loot = world_gen.make_chest_loot(weightedrandom(args.loot_data.pool))
					pass
		'area_oneshot_event':
			for i in active_area.events:
				if i.code == code:
					active_area.events.erase(i)
					break
		'location_purchase_event':
			var loc_data = ResourceScripts.world_gen.get_location_from_code(selected_location)
			data.text = tr(data.text)
			data.text = data.text.replace("[areaname]", tr(selected_area.name)).replace('[locationname]', tr(loc_data.name)).replace('[locationdescript]',tr(loc_data.descript)).replace("[locationtypename]", tr(loc_data.classname))
	
	gui_controller.dialogue.open(data)


func interactive_message_custom(data): #not safe
	event_is_active = true
	var scene = get_spec_node(self.NODE_DIALOGUE)
	scene.open(data.duplicate(true))

func interactive_dialogue_start(code, stage): #not safe
	event_is_active = true
	var scene = get_spec_node(self.NODE_DIALOGUE)
	scene.dialogue_next(code, stage)


# func ActivateTutorial(code): #disabled until rework
# 	return
# 	if ResourceScripts.game_progress.show_tutorial == true && ResourceScripts.game_progress.active_tutorials.has(code) == false && ResourceScripts.game_progress.seen_tutorials.has(code) == false:
# 		ResourceScripts.game_progress.active_tutorials.append(code)
# 		get_spec_node(self.NODE_TUTORIAL).rebuild()
# 		#get_tutorial_node().rebuild()


func ActivateTutorial(code):
	if ResourceScripts.game_progress.active_tutorials.has(code) == false && ResourceScripts.game_progress.seen_tutorials.has(code) == false:
		ResourceScripts.game_progress.active_tutorials.append(code)
	if gui_controller.mansion_tutorial_panel == null:
		gui_controller.mansion_tutorial_panel = get_spec_node(self.NODE_TUTORIAL_PANEL, null, false, false)
	if ResourceScripts.game_progress.show_tutorial && !ResourceScripts.game_progress.seen_tutorials.has(code):
		gui_controller.mansion_tutorial_panel.open(code)
		if !gui_controller.windows_opened.has(gui_controller.mansion_tutorial_panel):
			gui_controller.windows_opened.append(gui_controller.mansion_tutorial_panel)


func get_combat_node():
	var window
	var node = get_tree().get_root()
	if node.has_node('combat'):
		window = node.get_node('combat')
	else:
		window = load(ResourceScripts.scenedict.combat).instance()
		window.name = 'combat'
		node.add_child(window)
		#node.call_deferred('add_child',window)
	window.raise()
	return window

func AddPanelOpenCloseAnimation(node): #idk how this should work overall, but i cant remove it (and i want to remove it)
	if node.get_script() == null:
		node.set_script(ResourceScripts.scriptdict.closingpanel)
		node._ready() #i dont care about breaking anything with commenting this line - _ready SHOULD NEVER BE CALLED MANUALLY!!

func get_person_for_chat(array, event, bonus_args = []):
	var allowed_array = []
	var weight = 0
	for i in array:
		var person = characters_pool.get_char_by_id(i)
		if person.has_profession('master'):
			continue
		weight = 1
		allowed_array.append([person, weight])

	var person = weightedrandom(allowed_array)
	if person != null:
		add_random_chat_message(person, event, bonus_args)

func add_random_chat_message(person, event, bonus_args = []):
	if person.has_profession('master'): return
	var node = get_spec_node(self.NODE_CHAT)
	node.show_chat_line(person, event)

func get_random_chat_line(person, event):
	var node = get_spec_node(self.NODE_CHAT)
	return node.return_chat_line(person, event)

func repeat_social_skill():
	if last_action_data.code == 'social_skill':
		last_action_data.caster.use_social_skill(last_action_data.skill,last_action_data.target)
		rebuild_skill_list()

func update_slave_list():
	slave_list_node.update()
	gui_controller.mansion.SlaveModule.show_slave_info()

func rebuild_slave_list():
	slave_list_node.rebuild()
#	if gui_controller.inventory.visible:
#		gui_controller.inventory.SlaveList.update()

func rebuild_skill_list():
	skill_list_node.build_skill_panel()

func update_slave_panel():
	if gui_controller.slavepanel == null:
		gui_controller.slavepanel = get_spec_node(self.NODE_SLAVEMODULE)
	if gui_controller.slavepanel.visible == true:
		gui_controller.slavepanel.update()

func check_mouse_in_nodes(nodes):
	var check = false
	for i in nodes:
		if weakref(i) != null:
			if i.get_global_rect().has_point(CurrentScene.get_global_mouse_position()):
				check = true
	return check

func text_cut_excessive_lines(text:String):
	while text.ends_with(" ") || text.ends_with("\n"):
		text.erase(text.length()-1, text.length())
	return text

func text_form_recitation(string_array):
	var text = ""
	if string_array.size() == 1:
		text = string_array[0]
	else:
		for i in string_array:
			var last = false
			if i == string_array.back():
				text = text.substr(0,text.length()-2)
				if string_array.size() > 1:
					text += ' and ' + i
			else:
				text += i + ", "

	return text

func get_spec_node(type, args = null, raise = true, unhide = true):
	var window
	var node = get_tree().get_root()
	for n in modding_core.gui_nodes:
		if n.name == ResourceScripts.node_data[type].name and !ResourceScripts.node_data[type].has('no_return'):
			window = n
			node.add_child(window)
			modding_core.gui_nodes.erase(window)
			break

	if node.has_node(ResourceScripts.node_data[type].name) and !ResourceScripts.node_data[type].has('no_return'):
		window = node.get_node(ResourceScripts.node_data[type].name)
		#node.remove_child(window)
	elif window == null:
		match ResourceScripts.node_data[type].mode:
			'scene':
				window = ResourceScripts.node_data[type].scene.instance()
				window.visible = unhide
			'node':
				window = ResourceScripts.node_data[type].node.new()
		window.name = ResourceScripts.node_data[type].name
		node.add_child(window) #adding more than one sysmessages at one frame causes error here
	if raise: 
#		print(window.name)
		window.raise()
	if ResourceScripts.node_data[type].has('args'):
		for param in ResourceScripts.node_data[type].args:
			window.set(param, ResourceScripts.node_data[type].args[param])
	if ResourceScripts.node_data[type].has('calls'):
		if args == null: args = []
		window.callv(ResourceScripts.node_data[type].calls, args)
	elif args != null:
		for param in args:
			window.set(param, args[param])
	return window


func finish_combat():
	emit_signal("CombatEnded", combat_node.encountercode, true)
	SetMusic(explore_sound, true)
	
	if encounter_win_script != null and !encounter_win_script.empty():
		globals.common_effects(encounter_win_script.duplicate(true))
		encounter_win_script = null
		globals.check_events("finish_combat")
		return
	if active_location.has('scriptedevents') && globals.check_events("finish_combat") == true:
		yield(input_handler, 'EventFinished') #actually not correct, but fail case never fires
	
	if gui_controller.exploration_dungeon != null:
		gui_controller.exploration_dungeon.move_to_room()
#	combat_explore = false


func finish_quest_dungeon(args):
#	interactive_message('finish_quest_dungeon', 'quest_finish_event', {locationname = active_location.name})
	autocomplete_quest(args.id)
#	globals.unquest_location(active_location.id)


func finish_quest_location(args):
#	interactive_message('finish_quest_location', 'quest_finish_event', {locationname = active_location.name})
	autocomplete_quest(args.id)
	exploration_node.clear_dungeon_confirm()


func autocomplete_quest(q_id):
	var questdata = ResourceScripts.game_world.get_quest_by_id(q_id)
	selectedquest = questdata
	play_animation("repeatable_quest_completed")
	globals.Reward(questdata)
	globals.text_log_add("quest", "Quest Complete: " + questdata.name)
	ResourceScripts.game_world.complete_quest(questdata, 'complete')
	



func start_scene(scene):
	interactive_message(scene.code, 'event_selection', scene.args)

func combat_defeat():
#	for i in active_location.group:
#		if ResourceScripts.game_party.characters.has(active_location.group[i]) && ResourceScripts.game_party.characters[active_location.group[i]].hp <= 0:
#			ResourceScripts.game_party.characters[active_location.group[i]].hp = 1
#			ResourceScripts.game_party.characters[active_location.group[i]].defeated = false
#			ResourceScripts.game_party.characters[active_location.group[i]].is_active = true
#			var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table.e_grave_injury)
#			ResourceScripts.game_party.characters[active_location.group[i]].apply_effect(effects_pool.add_effect(eff))
			#i totally disagree with the same code placed here and in combat.victory() (and in old exploration too)
			#add permadeath check here
	emit_signal("CombatEnded", combat_node.encountercode, false)
	if encounter_lose_script != null and !encounter_lose_script.empty():
		globals.common_effects(encounter_lose_script)
		encounter_lose_script = null
		return
	if gui_controller.exploration_dungeon != null:
		gui_controller.exploration_dungeon.build_location_group()
		gui_controller.exploration_dungeon.deny_combat()
		gui_controller.exploration_dungeon.update_map()
#	if combat_explore and combat_advance:
#		exploration_node.advance()
#	combat_explore = false
#	if exploration_node != null && active_location.has('progress'):
#		exploration_node.open_location_actions()

func character_boss_defeat():
	var character_race = []
	var character_class = []
	var difficulty
	if active_location.affiliation == 'local':
		character_race.append([weightedrandom(active_area.races), 1])
	if active_location.has("final_enemy_class"):
		for i in active_location.final_enemy_class:
			character_class.append([i, 1])

	character_race = weightedrandom(character_race)
	character_class = weightedrandom(character_class)
	difficulty = variables.power_adjustments_per_difficulty[active_location.difficulty]
	difficulty = rand_range(difficulty[0], difficulty[1])
	interactive_message('character_boss_defeat', 'character_event', {characterdata = {type = 'raw',race = character_race, class = character_class, difficulty = difficulty, slave_type = 'slave'}})

func loadimage(path, type = ""):
	#var file = File.new()
	if typeof(path) == TYPE_OBJECT:
		return path
	if path == null || path == '':
		return null
	#indexed image check
	if type != "":
		var lib = images.get(type)
		if lib != null:
			if lib.has(path): 
				var res = lib[path]
				if res is String:
					res = load(res)
				return res
	#indexed resource check
	if ResourceLoader.exists(path):
		return load(path)
	#custom path loader
	return load_image_from_path(path)

#	if ResourcePreloader.new().has_resource(statlist.icon_image) == false:
#		return globals.loadimage(statlist.icon_image)
#	else:
#		return load(statlist.icon_image)

func load_image_from_path(path:String):
	if !(path.is_abs_path() or path.is_rel_path()): return null
	if !File.new().file_exists(path): return null
	var temp = Image.new()
	temp.load(path)
	var prew = ImageTexture.new()
	prew.create_from_image(temp)
	return prew

func load_sound_from_path(path:String): #not sure if works, needs testing
	if !(path.is_abs_path() or path.is_rel_path()): return null
#	if path.is_rel_path() and path.begins_with("res"):
#		return load(path)
	if !File.new().file_exists(path): return null

	if path.to_lower().ends_with(".ogg"):
		var temp = AudioStreamOGGVorbis.new()
		temp.load(path)
		return temp
	elif path.to_lower().ends_with(".wav"):
		var temp = AudioStreamSample.new()
		temp.load(path)
		return temp
	else: return null


func copy_dict(from:Dictionary, to:Dictionary):
	to.clear()
	for key in from: to[key] = from[key]

func select_value_in_OB(node, value):
	if !(node is OptionButton): return
	for i in range(node.get_item_count()):
		if node.get_item_text(i) == value:
			node.select(i)
			return
	node.select(0)

func get_value_node(node):
	if node is OptionButton:
		if node.get_selected_metadata() != null: return node.get_selected_metadata()
		else: return node.get_item_text(node.selected)
	if node is ItemList:
		var tmp = node.get_selected_items()
		if node.select_mode == ItemList.SELECT_SINGLE:
			if tmp.size() == 0: return null
			if node.get_item_metadata(tmp[0]): return node.get_item_metadata(tmp[0])
			else: return node.get_item_text(tmp[0])
		else:
			var res = []
			for i in tmp:
				if node.get_item_metadata(i) != null: res.push_back(node.get_item_metadata(i))
				else: res.push_back(node.get_item_text(i))
			return res
	if node is CheckBox: return node.pressed
	#node has text field
	if node.name == 'number':
		return float(node.text)
	if node.name == 'index': return int(node.text)
	if node.name == 'formula': return parse_json(node.text)
	return node.text

func meowingcondition(character):
	var allow = false
	if input_handler.globalsettings.meowing == true && character.checkreqs([{code = 'one_of_races', value = ['BeastkinCat','HalfkinCat']}]) && character.has_profession('master') == false:
		allow = true
	return allow

func dir_contents(target):
	var dir = Directory.new()
	var array = []
	if dir.open(target) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				array.append(target + "/" + file_name)
			elif !file_name in ['.','..', null] && dir.current_is_dir():
				array += dir_contents(target + "/" + file_name)
			file_name = dir.get_next()
		array.sort()
		return array
	else:
		print("An error occurred when trying to access the path:"+target)
		return array


func evaluate(input): #used to read strings as conditions when needed
	#qickfix for moving charclass stat template
	var res = ''
	input = input.replace('  ', ' ')
	var temp = input.split(' == ')
	if temp[0].match("active_slave.*"):
		var temp1 = temp[0].split('.')
		temp[0] = "%s.get_stat('%s')" % [temp1[0], temp1[1]]
	if temp.size() > 1: res = "%s == %s" % [temp[0], temp[1]]
	else: res = temp[0]

	var script = GDScript.new()
	script.set_source_code("var active_slave\nfunc eval():\n\treturn " + res)
	script.reload()
	var obj = Reference.new()
	obj.set_script(script)
	obj.active_slave = text_characters[0]
	return obj.eval()

func ClearContainer(container, template = ['Button']):
	for i in container.get_children():
		if !template.has(i.name):
			i.hide()
			i.queue_free()
	emit_signal("ButtonUpdated", container)

func ClearContainerForced(container, template = ['Button']):
	for i in container.get_children():
		if !template.has(i.name):
			i.hide()
			i.free()

func DuplicateContainerTemplate(container, template = 'Button'):
	var newbutton = container.get_node(template).duplicate()
	newbutton.show()
	container.add_child(newbutton)
	container.move_child(container.get_node(template), newbutton.get_position_in_parent()) #this CAN break something in difficult cases
	emit_signal("ButtonUpdated", container)
	return newbutton


func CloseSelection(panel):
	panel.hide()

func calculatepercent(value1, value2):
	return value1*100/max(value2,1)

func AddOrIncrementDict(dict, newdict):
	for i in newdict:
		if dict.has(i):
			dict[i] += newdict[i]
		else:
			dict[i] = newdict[i]

func MergeDicts(dict1, dict2, overwrite = false):
	var returndict = dict1
	for i in dict2:
		if returndict.has(i) && overwrite == false:
			returndict[i] += dict2[i]
		else:
			returndict[i] = dict2[i]

	return returndict

func scanfolder(path): #makes an array of all folders in modfolder
	var dir = Directory.new()
	var array = []
	if dir.dir_exists(path) == false:
		dir.make_dir(path)
	if dir.open(path) == OK:
		dir.list_dir_begin()

		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() && !file_name in ['.','..',null]:
				array.append(path + file_name)
			file_name = dir.get_next()
		return array


func CenterNode(node):
	node.set_global_position((Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height")) - node.rect_size) / 2)

func swap_items(arr: Array, pos1, pos2):
	if pos1 < 0 or pos2 < 0: return
	if pos1 >= arr.size() or pos2 >= arr.size(): return
	var tmp = arr[pos1]
	arr[pos1] = arr[pos2]
	arr[pos2] = tmp

func repeat_string(ch, n):
	var res = ""
	for i in range(n): res += ch
	return res


func get_active_party():
	var res = []
	for ch in active_location.group.values():
		if ResourceScripts.game_party.characters[ch] != null: res.push_back(ResourceScripts.game_party.characters[ch])
	return res

func get_location_characters():
	return get_location_characters_by_id(active_location.id)

func get_location_characters_by_id(loc_id):
	var array = []
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if i.check_location(loc_id, true):
			array.append(i)
	return array

func play_animation(animation, args = {}):
	animations_queue.push_back({animation = animation, args = args})
	animation_queue_start_attempt()


func animation_queue_start_attempt(): #animation added, onto empty or not empty queue
	if animations_queue.empty():
		print("error - try to start empty animation queue")
		return
	if animations_queue.size() != 1: #added animation is not first - so animation is playing
		return
	var anim_to_play = animations_queue.front()
	play_animation_noq(anim_to_play.animation, anim_to_play.args)


func animation_queue_start_force(): #animtion just ended
	if animations_queue.empty():
#		print("error - try to start empty animation queue")
		#as an end animation trigger it is not guaranteed that queue is not empty
		return
	yield(get_tree(), 'idle_frame')
	animations_queue.pop_front()
	if animations_queue.empty():
		emit_signal("animations_compleated")
		return
	var anim_to_play = animations_queue.front()
	play_animation_noq(anim_to_play.animation, anim_to_play.args)


func play_animation_noq(animation, args = {}):
	var anim_scene
	match animation:
		"fight":
			PlaySound("battle_start")
			anim_scene = get_spec_node(ANIM_BATTLE_START)
			anim_scene.play("battle_start")
		"quest":
			anim_scene = get_spec_node(ANIM_TASK_AQUARED)
			if args.has("sound"):
				anim_scene.sound = args.sound
			anim_scene.get_node("Label").text = args.label
			anim_scene.get_node("SelectedQuest").text = args.info
			anim_scene.play("task_aquared")
		"class_unlocked": #(new_class)
			anim_scene = get_spec_node(ANIM_CLASS_UNLOCKED)
			anim_scene.get_node("TextureRect11").texture = classesdata.professions[args.new_class].icon
			anim_scene.get_node("Label2").text = args.new_class.capitalize()
			anim_scene.play("class_unlocked")
		"class_aquired":
			anim_scene = get_spec_node(ANIM_CLASS_ACHIEVED)
			anim_scene.get_node("TextureRect").texture = classesdata.professions[args.current_class].icon
			anim_scene.get_node("Label").text = "Class Acquired"
			anim_scene.get_node("Label2").text = args.current_class.capitalize()
			anim_scene.get_node("Label3").text = args.person.get_full_name()
			anim_scene.play("class_achieved")
		"trait_aquired":
			var tdata = Traitdata.traits[args.current_trait]
			anim_scene = get_spec_node(ANIM_CLASS_ACHIEVED)
			if tdata.icon is String:
				anim_scene.get_node("TextureRect").texture = load(tdata.icon)
			else:
				anim_scene.get_node("TextureRect").texture = tdata.icon
			anim_scene.get_node("Label").text = "Training"
			anim_scene.get_node("Label2").text = tdata.name
			anim_scene.get_node("Label3").text = args.person.get_full_name()
			anim_scene.play("class_achieved")
		"slave_spec_aquired":
			var tdata = Traitdata.slave_profs[args.current_trait]
			anim_scene = get_spec_node(ANIM_CLASS_ACHIEVED)
			if tdata.icon is String:
				anim_scene.get_node("TextureRect").texture = load(tdata.icon)
			else:
				anim_scene.get_node("TextureRect").texture = tdata.icon
			anim_scene.get_node("Label").text = "Training"
			anim_scene.get_node("Label2").text = tdata.name
			anim_scene.get_node("Label3").text = args.person.get_full_name()
			anim_scene.play("class_achieved")
		"mastery_aquired":
			var masdata = Skilldata.masteries[args.mastery]
			anim_scene = get_spec_node(ANIM_CLASS_ACHIEVED)
			if masdata.icon is String:
				anim_scene.get_node("TextureRect").texture = images.get_icon(masdata.icon)
			else:
				anim_scene.get_node("TextureRect").texture = masdata.icon
			anim_scene.get_node("Label").text = "Mastery"
			anim_scene.get_node("Label2").text = masdata.name
			anim_scene.get_node("Label3").text = args.person.get_full_name()
			anim_scene.play("class_achieved")
		"quest_completed":
			anim_scene = get_spec_node(ANIM_TASK_COMPLETED)
			anim_scene.get_node("Label3").text = args.name
			anim_scene.play("task_completed")
		"repeatable_quest_completed":
			anim_scene = get_spec_node(ANIM_TASK_COMPLETED)
			var name =  selectedquest.name
			if selectedquest.has("source"):
				name += " (" + worlddata.factiondata[selectedquest.source].name + ")"
			anim_scene.get_node("Label3").text = name
			anim_scene.play("task_completed")
		"skill_unlocked":
			anim_scene = get_spec_node(ANIM_SKILL_UNLOCKED)
			anim_scene.get_node("TextureRect7").texture = args["skill"].icon
			anim_scene.get_node("Label2").text = tr("SKILL" + args["skill"].code.to_upper())
			anim_scene.get_node("Label3").text = args.person.get_full_name()
			anim_scene.play("Ability_unlocked")
		"factor":
			anim_scene = get_spec_node(ANIM_GROWTHF)
			anim_scene.get_node("TextureRect5").texture = args.character.get_icon()
			anim_scene.get_node('Label').text = args.character.get_short_name()
			var value = int(args.character.get_stat(args.stat))
			anim_scene.get_node('Label2').text = "%s: %s" % [tr(statdata.statdata[args.stat].name), ResourceScripts.descriptions.factor_descripts[value]]
			for i in range(1, 6):
				anim_scene.get_node('fill%d' % i).visible = (i < value)
			anim_scene.get_node("TextureRect6").rect_position.x += (value - 1) * 57
			anim_scene.get_node("TextureRect4").rect_position.x += (value - 1) * 57
			anim_scene.get_node("TextureRect7").rect_position.x += (value - 1) * 57
#			anim_scene.get_node("Label2").text = tr("SKILL" + args["skill"].code.to_upper())
#			anim_scene.get_node("Label3").text = args.person.get_full_name()
			anim_scene.play("Animation_growth_factor")
		"master_points":
			anim_scene = get_spec_node(ANIM_MASTER_POINT)
			if args.has("sound"):
				anim_scene.sound = args.sound
			var master_points = args.master_points
			if master_points > 1:
				anim_scene.get_node("TopLabel").text = tr("MASTERPOINTSTOP")
				anim_scene.get_node("BottomLabel").text = tr("MASTERPOINTSBOTTOM") % master_points
			else:
				anim_scene.get_node("TopLabel").text = tr("MASTERPOINTTOP")
				anim_scene.get_node("BottomLabel").text = tr("MASTERPOINTBOTTOM") % master_points
			anim_scene.play("master_point")
		"defeat":
			anim_scene = input_handler.get_spec_node(input_handler.ANIM_BATTLE_DEFEAT)
			anim_scene.play("defeated")
		"runaway":
			anim_scene = input_handler.get_spec_node(input_handler.ANIM_BATTLE_RUNAWAY)
			anim_scene.play("runaway")




const PADDINGS = 40
#this function did not work properly
#idk how this was supposed to work - so i remade it into my best assumtion of used math to avoid multiple text rendering in binary-search approach

#func font_size_calculator(label): #, text, font):
#	var font = label.get_font("font")
#	var new_font = DynamicFont.new()
#	new_font.use_filter = true
#	new_font.font_data = load(font.get_font_data().get_font_path())
#	new_font.size = font.get_size()
#	var text_width = new_font.get_string_size(label.get_text()).x
#	var label_width = label.get_size().x
#	var diff = (text_width / (label_width * 0.01)) - 100
#	if text_width >= (label_width - PADDINGS):
#		var old_size = new_font.get_size()
#		var new_size = round((old_size - (old_size * 0.01 * (abs(diff) + PADDINGS / 2))))
#		new_font.size = new_size
#	return new_font


func font_size_calculator(label): #, text, font):
	var font = label.get_font("font")
	var new_font = DynamicFont.new()
	new_font.use_filter = true
	new_font.font_data = load(font.get_font_data().get_font_path())
	new_font.size = font.get_size()
	var text_width = new_font.get_string_size(label.get_text()).x
	var label_text_width = label.get_size().x - PADDINGS
	var diff = text_width / label_text_width
	if text_width >= label_text_width:
		var old_size = new_font.get_size()
		var new_size = round(old_size / diff)
		new_font.size = new_size
	return new_font


func RTLabel_height_fix(label): #bugged and wrong
	var font = label.get("custom_fonts/normal_font")
	var new_font = DynamicFont.new()
	new_font.use_filter = true
	new_font.font_data = load(font.get_font_data().get_font_path())
	var new_size = font.get_size()
	var text_height = label.get_content_height()
	var label_height = label.get_size().y
#	var diff = (text_he / (label_width * 0.01)) - 100
	if text_height > label_height:
		new_size *= label_height
		new_size /= text_height
	new_font.size = new_size
	label.set("custom_fonts/normal_font", new_font)


func append_not_duplicate(list, value):
	if !list.has(value):
		list.append(value)


func get_actual_size_for_container(node):
	var res = Vector2(0, 0)
	if !(node is VBoxContainer) and !(node is HBoxContainer):
		return node.rect_size
	var separation = node.get("custom_constants/separation")
	if separation == null: separation = 4 #don't know how to get default separation value
	if node is VBoxContainer:
		for tnode in node.get_children():
			if !(tnode is CanvasItem): continue
			if !tnode.visible: continue
			res.x = tnode.rect_size.x
			res.y += tnode.rect_size.y + separation
		if res.y > 0: res.y -= separation
	if node is HBoxContainer:
		for tnode in node.get_children():
			if !tnode.visible: continue
			res.x += tnode.rect_size.x + separation
			res.y = tnode.rect_size.y
		if res.x > 0: res.x -= separation
	return res


func if_translation_key(text:String):
	var ntext = tr(text)
	return ntext != text


func upgrade_unlocked(upgrade):
	if upgrade.code == 'exotic_trader':
		ResourceScripts.game_world.areas.plains.factions.exotic_slave_trader.slavelevel = ResourceScripts.game_res.upgrades.exotic_trader*2+1

func print_order():
	print("{")
	for node in get_tree().get_root().get_children():
		print ("\t" + node.name)
	print("}")


#func lock_focus(node:Control):
#	node.focus_neighbour_bottom = node.get_path()
#	node.focus_neighbour_left = node.get_path()
#	node.focus_neighbour_right = node.get_path()
#	node.focus_neighbour_top = node.get_path()
#	node.grab_focus()

func import_recolor_parameter(to_mat, from_mat, ids = [1,2,3]):
	for param in ["target%dcolor", "part%dcolor", "part%d"]:
		for i in ids:
			var parname = param % (i)
			to_mat.set_shader_param(parname, from_mat.get_shader_param(parname))
	to_mat.set_shader_param('overlay', from_mat.get_shader_param('overlay'))


func import_recolor_mask(to_mat, from_mat, ids = [1,2,3]):
	for param in ["part%d"]:
		for i in ids:
			var parname = param % (i)
			to_mat.set_shader_param(parname, from_mat.get_shader_param(parname))


func import_recolor_mask_path(to_mat, mask, ids = [1,2,3]):
	for param in ["part%d"]:
		for i in ids:
			if mask == null:
				var oldcolorparam = "target%dcolor" % (i)
				var newcolorparam = "part%dcolor" % (i)
				to_mat.set_shader_param(newcolorparam, to_mat.get_shader_param(oldcolorparam))
			var parname = param % (i)
			to_mat.set_shader_param(parname, mask)


func import_deform_parameter(to_mat, from_mat, ids = [1,2,3,4,5,6]):
	for param in ["anchor%d", "move%d", "range%d"]:
		for i in ids:
			var parname = param % (i)
			to_mat.set_shader_param(parname, from_mat.get_shader_param(parname))
	to_mat.set_shader_param('power', from_mat.get_shader_param('power'))

func is_descendant_of_current_screen(nd):
	if gui_controller.current_screen == null:
		return true
	while nd != null:
		if nd == gui_controller.current_screen:
			return true
		nd = nd.get_parent()
	return false


func array_replace(arr, from, to):
	for i in range(arr.size()):
		if arr[i] == from:
			arr[i] = to


func _reset_mouse_events(): #stub, not, STUB - for set_disable_input is bugged
	get_tree().get_root().notification(MainLoop.NOTIFICATION_WM_FOCUS_OUT)
	get_tree().get_root().notification(MainLoop.NOTIFICATION_WM_FOCUS_IN)


func get_real_global_rect(nd, ignore_vp = false):
	var rect = nd.get_global_rect()
	var transform = nd.get_global_transform()
	var transform2 = nd.get_viewport_transform()
	
	if !ignore_vp:
		transform.origin = transform2.basis_xform(transform.origin)
		transform.x = transform2.basis_xform(transform.x)
		transform.y = transform2.basis_xform(transform.y)
	
	var res: Rect2
	res.position = transform.get_origin()
	res.size = transform.basis_xform(rect.size)
	if res.size.x < 0:
		res.position.x += res.size.x
		res.size.x = -res.size.x
	if res.size.y < 0:
		res.position.y += res.size.y
		res.size.y = -res.size.y
	return res


func node_children_visible(node, exception, value):
	for nd in node.get_children():
		if nd == exception:
			continue
		if nd is CanvasItem:
			nd.visible = value


func roman_number_converter(number): #only supports numbers up to 10 currently. INT > STRING
	if variables.roman_numbers.has(number) == false:
		#print("number does not exist in dictionary")
		return str(number)
	else:
		return variables.roman_numbers[number]


func rect2rombus(vec : Vector2):
	if vec.length() == 0.0:
		return vec
	var k1 = max(abs(vec.x), abs(vec.y))
	var vec1 = vec / k1
	var res
	if vec.x * vec.y > 0:
		res = vec1.project(Vector2(1.0, 1.0))
	else:
		res = vec1.project(Vector2(1.0, -1.0))
	var k = res.length()
	k *= sqrt(2.0)
	
	return vec / k


func timestamp_sort(a, b):
	return a[1] < b[1]


func timestamp_sort_dict(a, b):
	return a.timestamp < b.timestamp


func compare_list(list_new, list_old):
	var res_add = []
	var res_remove = []
	for i in list_new:
		if !list_old.has(i):
			res_add.push_back(i)
	for i in list_old:
		if !list_new.has(i):
			res_remove.push_back(i)
	return {add = res_add, remove = res_remove}
