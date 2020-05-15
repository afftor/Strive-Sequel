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

var SystemMessageNode

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
signal EnemyKilled

var last_action_data = {}
var text_characters = []

var slave_list_node
var exploration_node
var active_character
var scene_characters = []
var scene_loot
var active_area
var active_location
var active_faction = {}

var activated_skill
var target_character

var ghost_items = []


var encounter_win_script = null
var encounter_lose_scripts = []

var musicfading = false
var musicraising = false
var musicvalue

enum {NODE_CLASSINFO, NODE_CHAT, NODE_TUTORIAL, NODE_LOOTTABLE, NODE_DIALOGUE, NODE_INVENTORY, NODE_POPUP, NODE_CONFIRMPANEL, NODE_SLAVESELECT, NODE_SKILLSELECT, NODE_EVENT, NODE_MUSIC, NODE_SOUND, NODE_BACKGROUND_SOUND, NODE_TEXTEDIT, NODE_SLAVETOOLTIP, NODE_SKILLTOOLTIP, NODE_ITEMTOOLTIP, NODE_TEXTTOOLTIP, NODE_CHARCREATE, NODE_SLAVEPANEL, NODE_COMBATPOSITIONS, NODE_SYSMESSAGE} #, NODE_TWEEN, NODE_REPEATTWEEN}


var globalsettings = { 
	ActiveLocalization = 'en',
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
	
	textspeed = 60,
	skipread = false,
	textmonocolor = false,
	warnseen = false,
	disabletips = false,
	
	futa = true,
	furry = true,
	furry_multiple_nipples = true,
	futa_balls = true,
	futachance = 10,
	malechance = 50,
	meowing = true,
	#user_folders_settings
	portrait_folder = 'user://portraits/',
	body_folder = 'user://bodies/',
	#mod_folder = 'user://mods/',
	
	turn_based_time_flow = false,
	
	guilds_any_race = false, #unused
	
	autosave = true,
	autosave_number = 3,
	autosave_frequency = 24,
	
} setget settings_save

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

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		globalsettings.window_size = OS.window_size
		globalsettings.window_pos = OS.window_position
		settings_save(globalsettings)
		get_tree().quit()

func _init():
	#Storing available translations
	for i in scanfolder(variables.LocalizationFolder):
		for ifile in dir_contents(i):
			TranslationData[i.replace(variables.LocalizationFolder, '')] = ifile
#			file.open(ifile, File.READ)
#			var data = file.get_as_text()
#	for i in dir_contents(LocalizationFolder):
#		TranslationData[i.replace(LocalizationFolder + '/', '').replace('.gd','')] = i
	
	#Applying active translation
	var activetranslation = Translation.new()
	var translationscript = load(TranslationData[globalsettings.ActiveLocalization]).new()
	activetranslation.set_locale(globalsettings.ActiveLocalization)
	for i in translationscript.TranslationDict:
		activetranslation.add_message(i, translationscript.TranslationDict[i])
	TranslationServer.add_translation(activetranslation)

func _ready():
	OS.window_size = globalsettings.window_size
	OS.window_position = globalsettings.window_pos
	settings_load()

func _input(event):
	if event.is_echo() == true && !event.is_action_type(): 
		return
	#print(var2str(event))
	if (event.is_action("ESC") || event.is_action_released("RMB")):
		var ignore_rightclick = false
		for i in get_tree().get_nodes_in_group("ignore_rightclicks"):
			if i.visible == true:
				ignore_rightclick = true
				continue
		if ignore_rightclick == false:
			if CloseableWindowsArray.size() != 0:
				CloseTopWindow()
			else:
				if CurrentScene.name == 'mansion' && event.is_action("ESC"):
					CurrentScene.get_node("MenuPanel").open()
	if event.is_action_released("F9"):
		OS.window_fullscreen = !OS.window_fullscreen
		input_handler.globalsettings.fullscreen = OS.window_fullscreen
		if input_handler.globalsettings.fullscreen == false:
			OS.window_position = Vector2(0,0)
	if CurrentScreen == 'mansion' && str(event.as_text().replace("Kp ",'')) in str(range(1,9)) && CloseableWindowsArray.size() == 0 && text_field_input == false:
		if str(int(event.as_text())) in str(range(1,4)) && !event.is_pressed():
			if input_handler.globalsettings.turn_based_time_flow == false:
				CurrentScene.changespeed(CurrentScene.timebuttons[int(event.as_text())-1])
			else:
				CurrentScene.timeflowhotkey(int(event.as_text()))
	elif CurrentScreen == 'scene' && str(event.as_text().replace("Kp ",'')) in str(range(1,9)):
		get_tree().get_root().get_node("dialogue").select_option(int(event.as_text()))
	if event.is_action_pressed('full_screen'):
		OS.window_fullscreen = !OS.window_fullscreen
		input_handler.globalsettings.fullscren = OS.window_fullscreen

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

func CloseAllCloseableWindows():
	while CloseableWindowsArray.size() > 0:
		CloseTopWindow()

func CloseTopWindow():
	var node = CloseableWindowsArray.back()
	if typeof(node) == TYPE_STRING:
		return
	elif ResourceScripts.core_animations.BeingAnimated.has(node):
		return
	node.hide()
	#CloseableWindowsArray.pop_back(); #i think this is required #It's not, breaks multiple windows order

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
	CloseableWindowsArray.erase(node)
	ResourceScripts.core_animations.CloseAnimation(node)

func Open(node):
	if CloseableWindowsArray.has(node):
		return
	ResourceScripts.core_animations.OpenAnimation(node)
	CloseableWindowsArray.append(node)

func ChangeScene(name):
	CloseableWindowsArray.clear()
	var loadscreen = load(ResourceScripts.scenedict.loadscreen).instance()
	get_tree().get_root().add_child(loadscreen)
	loadscreen.goto_scene(ResourceScripts.scenedict[name])

func GetTweenNode(node): #not compartible with get_spec_node due to not linking new node to root
	var tweennode
	if node.has_node('tween'):
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

func SetMusic(name, delay = 0):
	if audio.music.has(name) == false: return
	yield(get_tree().create_timer(delay), 'timeout')
	musicraising = true
	var musicnode = get_spec_node(self.NODE_MUSIC) #GetMusicNode()
	if musicnode.stream == audio.music[name]:
		return
	musicnode.stream = audio.music[name]
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

var soundcooldown = 0

func PlaySoundIsolated(sound, cooldown):
	if soundcooldown > 0:
		return
	PlaySound(sound)
	soundcooldown = cooldown


func ShowSkillSelectPanel(person, type, TargetNode, TargetFunction): #very strange container method
	var node = get_spec_node(self.NODE_SKILLSELECT) #GetSkillSelectNode()
	node.open(person, type, TargetNode, TargetFunction)

func ShowSlaveSelectPanel(TargetNode, TargetFunction, reqs = [], allowcancel = false): #just a strange container method
	var node = get_spec_node(self.NODE_SLAVESELECT) #GetSlaveSelectNode()
	node.open(TargetNode, TargetFunction, reqs, allowcancel)



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
	return result

func operant_translation(operant):
	var text = ''
	match operant:
		'gte':
			text = 'At least'
		'lte':
			text = 'At most'
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
	return value
	
func weightedrandom(array): #uses an array of [value, weight] with value being returned according to weight change
	var total = 0
	var counter = 0
	for i in array:
		total += i[1]
	var random = rand_range(0,total)
	for i in array:
		if counter + i[1] >= random:
			return i[0] 
		counter += i[1]

func open_shell(string):
	var path = string
	match string:
		'Itch':
			path = 'https://strive4power.itch.io/strive-for-power'
		'Patreon':
			path = 'https://www.patreon.com/maverik'
		'Discord':
			path = "https://discord.gg/VXSx9Zk"
	OS.shell_open(path)

func SystemMessage(text, time = 4):
	var basetime = time
	SystemMessageNode = get_spec_node(self.NODE_SYSMESSAGE)
	text = '[center]' + tr(text) + '[/center]'
	SystemMessageNode.get_node('Text').bbcode_text = text
	SystemMessageNode.show()
	SystemMessageNode.modulate.a = 1
	ResourceScripts.core_animations.FadeAnimation(SystemMessageNode, 1, basetime)

func ShowOutline(node):
	node.material = load('res://assets/portret_shader.tres').duplicate()
	node.material.set_shader_param('opacity', 1)

func HideOutline(node):
	node.material.set_shader_param('opacity', 0)

func ConnectSound(node, sound, action):
	node.connect(action, self, 'PlaySound', [sound])

#Slave Panel

func ShowSlavePanel(person): #not fully node getter
	var node = get_spec_node(self.NODE_SLAVEPANEL)
	node.raise()
	node.open(person)


func calculate_number_from_string_array(arr, caster, target):
	if typeof(arr) != TYPE_ARRAY:
		return float(arr)
	var array = arr.duplicate()
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

func dialogue_option_selected(option):
	get_spec_node(self.NODE_DIALOGUE).previous_text = tr(option)
	if !ResourceScripts.game_progress.selected_dialogues.has(option):
		ResourceScripts.game_progress.selected_dialogues.append(option)

func interactive_message(code, type, args):
	var data = scenedata.scenedict[code].duplicate(true)
	var scene = get_spec_node(self.NODE_DIALOGUE) #get_dialogue_node()
#	if data.has('opp_characters'):
#		for i in data.opp_characters:
#			match i.type:
#				'pregen':
#					scene_characters.append(make_story_character(i.value))
	match type:
		'social_skill':
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
		'quest_finish_event':
			data.text = data.text.replace("[dungeonname]", args.locationname)
		'childbirth':
			active_character = args.pregchar
			var baby = ResourceScripts.game_party.babies[active_character.pregnancy.baby]
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
			data.text = data.text.replace("[areaname]", active_area.name).replace('[locationname]', active_location.name).replace('[locationdescript]',active_location.descript).replace("[locationtypename]", active_location.classname)
	
	scene.open(data)

func interactive_message_custom(data):
	var scene = get_spec_node(self.NODE_DIALOGUE) #get_dialogue_node()
	scene.open(data.duplicate(true), true)

func interactive_dialogue_start(code, stage):
	var scene = get_spec_node(self.NODE_DIALOGUE) #get_dialogue_node()
	scene.dialogue_next(code, stage)


func ActivateTutorial(code):
	if ResourceScripts.game_progress.show_tutorial == true && ResourceScripts.game_progress.active_tutorials.has(code) == false && ResourceScripts.game_progress.seen_tutorials.has(code) == false:
		ResourceScripts.game_progress.active_tutorials.append(code)
		get_spec_node(self.NODE_TUTORIAL).rebuild()
		#get_tutorial_node().rebuild()

func show_class_info(classcode, person = null):
	if person == null:
		person = active_character
	var node = get_spec_node(self.NODE_CLASSINFO) #get_class_info_panel()
	node.open(classcode, person)

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

func AddPanelOpenCloseAnimation(node):
	if node.get_script() == null:
		node.set_script(ResourceScripts.scriptdict.closingpanel)
	node._ready()

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
	var node = get_spec_node(self.NODE_CHAT) #get_chat_node()
	node.select_chat_line(person, event, bonus_args)

func get_random_chat_line(person, event):
	var node = get_spec_node(self.NODE_CHAT) #get_chat_node()
	return node.return_chat_line(person, event)

func repeat_social_skill():
	if last_action_data.code == 'social_skill':
		last_action_data.caster.use_social_skill(last_action_data.skill,last_action_data.target)

func update_slave_list():
	slave_list_node.update()

func rebuild_slave_list():
	slave_list_node.rebuild()

func update_slave_panel():
	var node = get_spec_node(self.NODE_SLAVEPANEL, null, false)#, false)
	if node.visible == true:
		node.update()

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

func get_spec_node(type, args = null, raise = true, unhide = true):
	var window
	var node = get_tree().get_root()
	if node.has_node(ResourceScripts.node_data[type].name) and !ResourceScripts.node_data[type].has('no_return'):
		window = node.get_node(ResourceScripts.node_data[type].name)
		#node.remove_child(window)
	else:
		match ResourceScripts.node_data[type].mode:
			'scene':
				window = ResourceScripts.node_data[type].scene.instance()
			'node':
				window = ResourceScripts.node_data[type].node.new()
		window.name = ResourceScripts.node_data[type].name
		node.add_child(window)
	if raise: window.raise()
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
	emit_signal("CombatEnded", combat_node.encountercode)
	SetMusic("exploration")
	
	encounter_lose_scripts.clear()
	
	if encounter_win_script != null:
		globals.common_effects(encounter_win_script)
#		var data = scenedata.scenedict[encounter_win_script]
#		interactive_message(encounter_win_script, data.default_event_type, {})
		encounter_win_script = null
		return
	if active_location.has('scriptedevents') && globals.check_events("finish_combat") == true:
		yield(self, 'EventFinished')
	if active_location.has('randomevents') && globals.check_random_event() == true:
		yield(self, 'EventFinished')
	
	exploration_node.finish_combat()

func finish_quest_dungeon(args):
	interactive_message('finish_quest_dungeon', 'quest_finish_event', {locationname = active_location.name})

func finish_quest_location(args):
	interactive_message('finish_quest_location', 'quest_finish_event', {locationname = active_location.name})
	exploration_node.clear_dungeon_confirm()

func start_scene(scene):
	interactive_message(scene.code, 'event_selection', scene.args)

func combat_defeat():
	for i in active_location.group:
		if ResourceScripts.game_party.characters.has(active_location.group[i]) && ResourceScripts.game_party.characters[active_location.group[i]].hp <= 0:
			ResourceScripts.game_party.characters[active_location.group[i]].hp = 1
			ResourceScripts.game_party.characters[active_location.group[i]].defeated = false
			ResourceScripts.game_party.characters[active_location.group[i]].is_active = true
	get_spec_node(input_handler.NODE_DIALOGUE).close()
	if exploration_node != null && active_location.has('progress'):
		exploration_node.enter_level(globals.current_level)

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
			if lib.has(path): return lib[path]
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
		return node.get_item_text(node.selected)
	if node is ItemList:
		var tmp = node.get_selected_items()
		if node.select_mode == ItemList.SELECT_SINGLE:
			if tmp.size() == 0: return null
			return node.get_item_text(tmp[0])
		else:
			var res = []
			for i in tmp:
				res.push_back(node.get_item_text(i))
			return res
	if node is CheckBox: return node.pressed
	#node has text field
	if node.name == 'number': return float(node.text)
	if node.name == 'index': return int(node.text)
	if node.name == 'formula': return parse_json(node.text)
	return node.text

func meowingcondition(character):
	var allow = false
	if input_handler.globalsettings.meowing == true && character.checkreqs([{code = 'one_of_races', value = ['BeastkinCat','HalfkinCat']}]):
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
		return array
	else:
		print("An error occurred when trying to access the path.")

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

func ClearContainer(container):
	for i in container.get_children():
		if i.name != 'Button':
			i.hide()
			i.queue_free()

func ClearContainerForced(container):
	for i in container.get_children():
		if i.name != 'Button':
			i.hide()
			i.free()

func DuplicateContainerTemplate(container):
	var newbutton = container.get_node('Button').duplicate()
	newbutton.show()
	container.add_child(newbutton)
	container.move_child(container.get_node('Button'), newbutton.get_position_in_parent())
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
