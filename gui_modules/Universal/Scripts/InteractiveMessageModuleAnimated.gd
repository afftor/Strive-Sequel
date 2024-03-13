extends Panel

var previousscene
var dialogue_enemy
var current_scene
var hold_selection = false #pause for scene to load
var previous_dialogue_option = 0
var previous_text = ''
var base_text_size
var base_text_position
var doing_transition = false
var wait_for = 0

signal TransitionFinished

func _ready():
	if get_node_or_null("BackgroundT2/HideButton"):
		get_node("BackgroundT2/HideButton").connect("pressed", self, "hide_dialogue")
		get_node("ShowPanel/ShowButton").connect("pressed", self, "hide_dialogue", ["show"])
	$CharacterImage.material = load("res://assets/silouette_shader.tres").duplicate()
	if get_node_or_null("CharacterImage2") != null:
		$CharacterImage2.material = load("res://assets/silouette_shader.tres").duplicate()
	base_text_size = $RichTextLabel.rect_size
	base_text_position = $RichTextLabel.rect_position
	


func hide_dialogue(action = "hide"):
	for node in self.get_children():
		if node.get_class() == "Tween":
			continue
		if !node.name in ["ShowPanel", "CustomBackground", "ShowPanelBackground"]:
			node.visible = action != "hide"
	var tnode = get_node("ShowPanel")
	if tnode != null:
		tnode.visible = action == "hide"

func open(scene):
	if gui_controller.dialogue == null:
		gui_controller.dialogue = self
#	if get_tree().get_root().get_node_or_null("ANIMLoot") && get_tree().get_root().get_node("ANIMLoot").is_visible():
#		get_tree().get_root().get_node("ANIMLoot").raise()
	input_handler.PlaySound("speech")
	get_tree().get_root().set_disable_input(true)
	if scene.has("save_scene_to_gallery") && scene.save_scene_to_gallery:
		save_scene_to_gallery(scene)
	
	if scene.has("variations"):
		select_scene_variation_based_on_data(scene)
		get_tree().get_root().set_disable_input(false)
		return
	
	if scene.has("dialogue_type") && gui_controller.dialogue_window_type != scene.dialogue_type:
		set_dialogue_window_type(scene)
		return
	
	if input_handler.CurrentScreen != 'scene': previousscene = input_handler.CurrentScreen
	input_handler.CurrentScreen = 'scene'
	current_scene = scene
	hold_selection = true
	raise()
	if get_tree().get_root().get_node_or_null("ANIMLoot") && get_tree().get_root().get_node("ANIMLoot").is_visible():
		get_tree().get_root().get_node("ANIMLoot").raise()
	if scene.has("common_effects"):
		globals.common_effects(scene.common_effects)
	if typeof(scene.text) == TYPE_STRING:
		scene.text = [{text = scene.text, reqs = []}]
	
	if wait_for != 0:
		ResourceScripts.core_animations.OpenAnimation(self, wait_for, Tween.TRANS_EXPO, Tween.EASE_IN)
		wait_for = 0
	
	handle_scene_transition_fx(scene)
	if doing_transition:
#		print_debug("waiting")
		yield(self, "TransitionFinished")
#		print_debug("finished WAIT")
		doing_transition = false
#	print(self.visible)
	clear_character_images()
	$ImagePanel.hide()
	handle_scene_backgrounds(scene)
	handle_characters_sprites(scene)
	handle_loots(scene)
	update_scene_characters()
	generate_scene_text(scene)
	set_enemy(scene)
	handle_scene_options()
	
	yield(get_tree().create_timer(0.5), "timeout")
	if ResourceScripts.core_animations.BeingAnimated.has(self):
		ResourceScripts.core_animations.BeingAnimated.erase(self)
	hold_selection = false
#	input_handler.print_order()
#	get_tree().get_root().print_tree_pretty()
	show_buttons()
	gui_controller.is_dialogue_just_started = false
	if get_tree().get_root().get_node_or_null("lootwindow") && get_tree().get_root().get_node("lootwindow").is_visible():
		get_tree().get_root().get_node("lootwindow").raise()
	if get_tree().get_root().get_node_or_null("ANIMTaskAquared") && get_tree().get_root().get_node("ANIMTaskAquared").is_visible():
		get_tree().get_root().get_node("ANIMTaskAquared").raise()
	
	show()


func show_buttons():
	get_tree().get_root().set_disable_input(true)
	for button in $ScrollContainer/VBoxContainer.get_children():
		if button.name == "Button":
			continue
		ResourceScripts.core_animations.UnfadeAnimation(button, 0.3)
		yield(get_tree().create_timer(0.3), "timeout")
		button.set("modulate", Color(1, 1, 1, 1))
	get_tree().get_root().set_disable_input(false)

func complete_skirmish():
	hold_selection = true
	globals.complete_location(input_handler.active_location.id)
	globals.remove_location(input_handler.active_location.id)
	close()

func update_scene_characters():
	input_handler.ClearContainer($EventCharacters/VBoxContainer)
	input_handler.ClearContainer($PlayerCharacters/VBoxContainer)
	for i in input_handler.scene_characters:
		var newbutton = input_handler.DuplicateContainerTemplate($EventCharacters/VBoxContainer)
		newbutton.get_node("Label").text = i.get_short_name()
		newbutton.get_node('icon').texture = i.get_icon()
		globals.connectslavetooltip(newbutton, i)
		newbutton.indialog = true
#		if i.is_players_character == false:
#			newbutton.connect('signal_RMB_release',self, 'show_full_info', [i])
		newbutton.connect('signal_RMB_release',self, 'show_full_info', [i])


# Temporary
func show_full_info(person):
	gui_controller.close_all_closeable_windows()
	var FullSlaveInfo = input_handler.get_spec_node(input_handler.NODE_EXPLORE_SLAVEINFO)
	gui_controller.explore_slaveinfo = FullSlaveInfo
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.explore_slaveinfo
	FullSlaveInfo.show()
	FullSlaveInfo.show_summary(person, "from_dialogue")
	FullSlaveInfo.get_node("PurchaseButton").hide()
	FullSlaveInfo.get_node("Price").hide()
	FullSlaveInfo.get_node("TextureRect").hide()
#	FullSlaveInfo.update_purchase_btn()


var stored_scene

func dialogue_next(code, argument, args = {}):
	hold_selection = true
	previous_dialogue_option = argument
	if args.has("changed_window_type"): # transfering prev option on scene change
		match gui_controller.dialogue_window_type:
			1:
				input_handler.get_spec_node(input_handler.NODE_DIALOGUE).previous_dialogue_option = argument
			2:
				 input_handler.get_spec_node(input_handler.NODE_DIALOGUE_T2).previous_dialogue_option = argument
	input_handler.interactive_message_follow(code, '', args)


func chest_mimic_force_open():
	hold_selection = true
	var chest_data = input_handler.scene_loot
	match chest_data.lock.type:
		'mimic':
			input_handler.interactive_message_follow("chest_is_mimic_trapped", "story_event", {})
		'mimic_erotic':
			input_handler.interactive_message_follow("chest_is_erotic_mimic_trapped", "story_event", {})

func add_chest_options(scene):
	var chest_data = input_handler.scene_loot
	var text = ""
	var engineer
	for i in input_handler.get_location_characters():
		if i.check_trait("trap_analyze"):
			engineer = i
			break

	if engineer != null:
		var lock_read = false
		if engineer.lockpick_chance() > rand_range(0.5,2)*chest_data.lock.difficulty:
			lock_read = true

		text += "\n\n[Engineer]: "
		if lock_read == false:
			text += "[name] wasn't able to determine chest's lock mechanism and its potential danger."
		else:
			match chest_data.lock.type:
				'normal':
					text += "[name] concludes this chest is locked with a {color=aqua|mechanic lock} and has no additional danger."
				'none':
					text += "[name] concludes this chest is {color=aqua|unlocked} and safe to use."
				'bomb':
					text += "[name] concludes this chest is rigged with a {color=aqua|bomb trap}."
				'gas':
					text += "[name] concludes this chest is rigged with a {color=aqua|gas trap}."
				'mimic','mimic_erotic':
					text += "[name] wasn't able to determine chest's lock mechanism and its potential danger."
				'alarm':
					text += "[name] notices a hidden alarm mechanism tied to a lock, which wil llikely cause an uproar if triggered."

		text = globals.TextEncoder(engineer.translate(text))

	 #= "\n\nChest Lock: " +  str(chest_data.lock.type)
#	if chest_data.lock.type != 'none':
#		text += "\nDifficulty: " + ResourceScripts.custom_text.lock_difficulty(chest_data.lock.difficulty)

	scene.text.append({text = text, reqs = []})
	scene.options.insert(0,{code = 'lockpick_attempt', select_person = true, reqs = [], text = "DIALOGUECHESTLOCKPICK"})


func add_recruit_option(scene):
	if input_handler.scene_characters.empty():
		input_handler.scene_characters.push_back(input_handler.active_character)
		input_handler.active_character = null
	var char_to_recruit = input_handler.scene_characters[0]
	if char_to_recruit == null:
		print("error - no char")
		return
	var state = char_to_recruit.src
	if state == 'random_combat':
		scene.options.insert(1,{code = 'recruit_option_safe', reqs = [], text = "DIALOGUERECRUITFORCEATTEMPT"})
	var char2 = input_handler.active_character
	if char2 != null:
		scene.options.insert(1,{code = 'recruit_option', reqs = [], text = "DIALOGUERECRUITATTEMPT"})


func recruit_option_safe():
	var char_to_recruit = input_handler.scene_characters[0]
	if char_to_recruit == null:
		print("error - no char")
		return
	var state = char_to_recruit.src
	input_handler.interactive_message_follow("recruit_captured_enslave", "story_event", {})
	input_handler.active_location.captured_characters.erase(char_to_recruit.id)
	input_handler.emit_signal("LocationSlavesUpdate")


func recruit_option():
	var char_to_recruit = input_handler.scene_characters[0]
	if char_to_recruit == null:
		print("error - no char")
		return
	var state = char_to_recruit.src
	var char2 = input_handler.active_character
	var val1 = char_to_recruit.get_stat('charm_factor')
	var val2= char2.get_stat('charm')
	if state == 'random_combat':
		if val2 >= val1 * globals.rng.randf_range(10.0, 20.0):
			input_handler.interactive_message_follow("recruit_captured_success", "story_event", {})
		else:
			input_handler.interactive_message_follow("recruit_captured_fail", "story_event", {})
	else:
		if val2 >= val1 * globals.rng.randf_range(5.0, 15.0):
			input_handler.interactive_message_follow("recruit_meet_success", "story_event", {})
		else:
			input_handler.interactive_message_follow("recruit_meet_fail", "story_event", {})
	
	char2.add_stat('charm', globals.rng.randi_range(1, 3))
	input_handler.active_location.captured_characters.erase(char_to_recruit.id)
	input_handler.emit_signal("LocationSlavesUpdate")


func add_shrine_options(scene):
	var shrineoptions = Enemydata.shrines[scene.shrine].options
	var array = shrineoptions.keys()
	array.invert()
	for i in array:
		match shrineoptions[i].input:
			'material':
				scene.options.insert(0,{code = 'shrine_option', args = ['select_material'], reqs = [], text = "DIALOGUESHRINEITEM"})
			'character': #this can cause lock if called at empty combat party
				scene.options.insert(0,{code = 'shrine_option', args = ['character'], active_char_translate = true, reqs = [], text = "DIALOGUESHRINECHARACTER"})
			'destroy':
				scene.options.insert(0,{code = 'shrine_option', args = ['destroy'], reqs = [], text = "DIALOGUESHRINEDESTROY"})

func shrine_option(option):
	match option:
		'select_material':
			globals.ItemSelect(self, 'material', 'shrine_mat_select')
		"character":
			Enemydata.call(Enemydata.shrines[current_scene.shrine].options['character'].output, input_handler.active_character) 
		'destroy':
			Enemydata.call(Enemydata.shrines[current_scene.shrine].options['destroy'].output, input_handler.active_character)
		'material_selected':
			Enemydata.call(Enemydata.shrines[current_scene.shrine].options['material'].output, selected_item)

var selected_item

func shrine_mat_select(item):
	selected_item = item
	shrine_option('material_selected')

func add_loot_options(scene):
	scene.options.insert(0,{code = 'open_chest', reqs = [], text = "DIALOGUETAKELOOT", bonus_effects = [{code = 'advance_location'}]})

func add_location_resource_info():
	var text = '\nAfter defeating last enemies your party investigated the location and found a resources you can harvest:'
	var location = input_handler.active_location
	for i in location.gather_limit_resources:
		text += "\n" + Items.materiallist[i].name + ": " + str(location.gather_limit_resources[i])
	text += '\n\nHarvest speed modifier: ' + str(round(location.gather_mod*100)) + "%"
	return text

func lockpick_attempt(person):
	var lock = input_handler.scene_loot.lock.difficulty
	var type = input_handler.scene_loot.lock.type
	var lockpickskill = person.lockpick_chance()
	if type == 'none':
		lock = 0
	elif type in ['mimic','mimic_erotic']:
		lock = lock * randf()*2
	var open = lockpickskill >= lock
	if !type in ['none','mimic','mimic_erotic']:
		person.add_stat('wits', rand_range(2,3))

	if type in ['mimic','mimic_erotic'] && open == true:
		input_handler.interactive_message_follow("chest_is_mimic_discovered", "story_event", {})
	elif type in ['mimic']:
		input_handler.interactive_message_follow("chest_is_mimic_trapped", "story_event", {})
	elif type in ["mimic_erotic"]:
		input_handler.interactive_message_follow("chest_is_erotic_mimic_trapped", "story_event", {})
	elif type in ['alarm']:
		input_handler.interactive_message_follow("lockpick_alarm_failure", "story_event", {})
	elif open == true:
		input_handler.interactive_message_follow("lockpick_chest_success", "story_event", {})
		input_handler.add_random_chat_message(person, 'lockpick_success')
	else:
		match type:
			'normal':
				input_handler.interactive_message_follow("lockpick_chest_failure", "story_event", {})
			'bomb':
				input_handler.interactive_message_follow("lockpick_chest_bomb_failure", "story_event", {})
			'gas':
				input_handler.interactive_message_follow("lockpick_chest_gas_failure", "story_event", {})
		input_handler.add_random_chat_message(person, 'lockpick_failure')

func select_person_for_next_event(code):
	var reqs
	if code.find('marriage')!= -1:
		reqs = [
			{code = 'stat', stat = 'agreed_to_marry', operant = 'eq', value = true}
		]
	elif code.find('trap') != -1 or code.find('shrine') != -1: #imho there should be also a lockpicking events
		reqs = [
			{code = 'is_at_location', value = input_handler.active_location.id, check = true},
			{code = 'in_combat_party', value = true}
			]
	elif code.find('savra_talk_5') != -1:
		reqs = [
			{code = 'stat', stat = 'magic_factor', operant = 'gte', value = 5}
		]
	elif code.find('temple_1') != -1:
		reqs = [
			{code = 'stat', stat = 'physics_factor', operant = 'gte', value = 5}
		]
	elif code.find('lira_encounter_5_1_1') != -1:
		reqs = [ 
			{code = 'stat', stat = 'race', operant = 'eq', value = "TribalElf"},
#			{code = 'is_master', check = false}
		]
	elif code.find('cali_william_9') != -1:
		reqs = [ 
			{code = 'stat', stat = 'unique', operant = 'neq', value = "cali"},
			{code = 'is_master', check = false}
		]
	else:
		reqs = [
			{code = 'is_at_location', value = input_handler.active_location.id, check = true},
#			{code = 'in_combat_party', value = true}
			]
	stored_scene = code
	input_handler.ShowSlaveSelectPanel(self, 'event_person_selected', reqs)

func remove_person(code):
	var reqs = [{code = 'is_at_location', value = input_handler.active_location.id, check = true}]
	stored_scene = code
	input_handler.ShowSlaveSelectPanel(self, 'remove_selected', reqs)

func remove_non_master(code):
	var reqs = [{code = 'is_at_location', value = input_handler.active_location.id, check = true}, {code = 'is_master', check = false}]
	stored_scene = code
	input_handler.ShowSlaveSelectPanel(self, 'remove_selected', reqs)

func remove_servant(code):
	var reqs = [{code = 'stat', stat = 'slave_class', value = 'servant', check = true}]
	stored_scene = code
	input_handler.ShowSlaveSelectPanel(self, 'remove_selected', reqs)

func remove_selected(person):
	input_handler.active_character = person
	ResourceScripts.game_party.add_fate(person.id, tr("LOST"))
	ResourceScripts.game_party.remove_slave(person)
	input_handler.slave_list_node.rebuild()

	var event_type = 'story_event'
	if scenedata.scenedict[stored_scene].has('default_event_type'):
		event_type = scenedata.scenedict[stored_scene].default_event_type
	input_handler.interactive_message_follow(stored_scene, event_type, {})

func event_person_selected(person):
	input_handler.active_character = person
	if stored_scene == 'lockpick_attempt':
		lockpick_attempt(person)
		return
	var data = scenedata.scenedict[stored_scene]
	var event_type = 'story_event'
	if scenedata.scenedict[stored_scene].has('default_event_type'):
		event_type = scenedata.scenedict[stored_scene].default_event_type
	input_handler.interactive_message_follow(stored_scene, event_type, {})


func close(args = {}):
	hold_selection = true
	if !args.has('transition'):
		args.transition = false 
	if !args.has('finish_scene'):
		args.finish_scene = true
	hold_selection = true
	ch1 = null
	ch2 = null
	previous_dialogue_option = 0
	if gui_controller.dialogue_window_type == 2:
		previous_text = ""
		input_handler.get_spec_node(input_handler.NODE_DIALOGUE).hide()
		input_handler.get_spec_node(input_handler.NODE_DIALOGUE).previous_dialogue_option = 0
		gui_controller.dialogue_window_type = 1
		var screen_duration = 1.0
		if args.has('screen_duration'):
			screen_duration = args.screen_duration
		var transition_duration = screen_duration * 0.5
		if args.has('transition_duration'):
			transition_duration = args.transition_duration
		if screen_duration <= 0.001:
			ResourceScripts.core_animations.FadeAnimation(self, 0.2)
			yield(get_tree().create_timer(0.2), "timeout")
		else:
			ResourceScripts.core_animations.FadeAnimation(self, transition_duration, screen_duration * 0.25)
			ResourceScripts.core_animations.BlackScreenTransition(screen_duration * 0.5)
			yield(get_tree().create_timer(transition_duration + screen_duration * 0.25), "timeout")
		$RichTextLabel.bbcode_text = ''
	else:
		ResourceScripts.core_animations.FadeAnimation(self, 0.2)
		yield(get_tree().create_timer(0.2), "timeout")
	hold_selection = false
	hide()
	if args.transition == false:
		input_handler.scene_characters.clear()
	input_handler.CurrentScreen = previousscene
	if args.finish_scene: input_handler.emit_signal("EventFinished")
	input_handler.event_finished()
	gui_controller.is_dialogue_just_started = true


func cancel_skill_usage():
	input_handler.active_character.restore_skill_charge(gui_controller.mansion.SkillModule.active_skill)
	input_handler.scene_characters.pop_back()
	close()

func repeat():
	input_handler.repeat_social_skill()
	# input_handler.update_slave_panel()

func recruit_from_scene(order = 0):
	input_handler.active_character = input_handler.scene_characters[order]
	recruit()

func capture_from_scene(order = 0):
	input_handler.active_character = input_handler.scene_characters[order]
	recruit(true)


func recruit(capture = false):
	hold_selection = true
#	if ResourceScripts.game_party.characters.size() >= ResourceScripts.game_res.get_pop_cap():
#		if ResourceScripts.game_res.get_pop_cap() < variables.max_population_cap:
#			input_handler.SystemMessage("You don't have enough rooms")
#		else:
#			input_handler.SystemMessage("Population limit reached")
#		hold_selection = false
#		return
	input_handler.active_character.recruit(capture)
	close()

func create_location_recruit(args):
	var newchar = ResourceScripts.scriptdict.class_slave.new("location_recruit")
	input_handler.active_character = newchar
	newchar.generate_random_character_from_data(input_handler.active_location.races)
	$RichTextLabel.bbcode_text = newchar.translate($RichTextLabel.bbcode_text)

func execute():
	close()

func inspect_active_character():
	input_handler.ShowSlavePanel(input_handler.active_character)

func inspect_character_child():
	input_handler.ShowSlavePanel(ResourceScripts.game_party.babies[input_handler.active_character.get_stat('pregnancy').baby])

func keepbaby():
	var node = input_handler.get_spec_node(input_handler.NODE_TEXTEDIT) #input_handler.GetTextEditNode()
	var person = ResourceScripts.game_party.babies[input_handler.active_character.get_stat('pregnancy').baby]
	person.statlist.get_random_name(true)
#	input_handler.active_character.get_stat('pregnancy', true).baby = null
	node.open(self, 'set_baby_name', person.get_stat('name'))
	

func removebaby():
	ResourceScripts.game_party.add_fate(input_handler.active_character.get_stat('pregnancy').baby, tr("KEEPNOT"))
#	if (int(ResourceScripts.game_globals.date) % input_handler.globalsettings.autosave_frequency == 0) and int(ResourceScripts.game_globals.hour) == 1:
#		globals.autosave(true)
	close()
	ResourceScripts.game_party.babies[input_handler.active_character.get_stat('pregnancy').baby].is_active = false
	ResourceScripts.game_party.babies.erase(input_handler.active_character.get_stat('pregnancy').baby)
	input_handler.active_character.get_stat('pregnancy', true).baby = null

func set_baby_name(text):
	var person = ResourceScripts.game_party.babies[input_handler.active_character.get_stat('pregnancy').baby]
#	person.baby_transform()
	input_handler.active_character.get_stat('pregnancy', true).baby = null
	person.set_stat('obedience', 24)
	person.set_stat('name', text)
	person.setup_as_heir()
	ResourceScripts.game_party.add_slave(person, true)
	input_handler.interactive_message_follow('select_tutelage', '', '')
#	if (int(ResourceScripts.game_globals.date) % input_handler.globalsettings.autosave_frequency == 0) and int(ResourceScripts.game_globals.hour) == 1:
#		globals.autosave(true)
#	close()

func open_chest():
	hold_selection = true
	var loot_win = input_handler.get_spec_node(input_handler.ANIM_LOOT)
	if !gui_controller.windows_opened.has(loot_win):
		gui_controller.windows_opened.append(loot_win)
	loot_win.open(input_handler.scene_loot)
	loot_win.raise()
	# input_handler.get_spec_node(input_handler.NODE_LOOTTABLE).open(input_handler.scene_loot, '[center]Acquired Items:[/center]')
	# var loot_win = input_handler.get_spec_node(input_handler.ANIM_LOOT)
	# loot_win.get_node("AnimationPlayer").play("Loot")
	#input_handler.get_loot_node().open(input_handler.scene_loot, '[center]Acquired Items:[/center]')
	close()

func good_event():
	var eventlist = input_handler.active_location.event_pool
	var array = []
	for i in eventlist:
		if scenedata.scenedict[i[0]].has('tags') && scenedata.scenedict[i[0]].tags.has('good'):
			array.append(i)

	if array.size() == 0:
		print("no correct good event: " + input_handler.active_location.events)
		return
	var event = input_handler.weightedrandom(array)
	var eventtype = "event_selection"
	var dict = {}
	if scenedata.scenedict[event].has("default_event_type"):
		eventtype = scenedata.scenedict[event].default_event_type
	if scenedata.scenedict[event].has('bonus_args'):
		dict = scenedata.scenedict[event].bonus_args
	input_handler.interactive_message(event, eventtype, dict)

func evil_event():
	input_handler.SystemMessage("This feature is not implemented yet")

func leave():
	hold_selection = true
	close()

func fight_skirmish():
	globals.char_roll_data.no_roll = true
	if current_scene.has("winscene"):
		input_handler.encounter_win_script = current_scene.winscene
	globals.current_enemy_group = dialogue_enemy
	input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)
	#close(true)

func quest_fight(code):
	globals.char_roll_data.no_roll = true
	globals.current_enemy_group = code
	input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)
	#close(true)



func save_scene_to_gallery(scene):
	if scene.has("unlocked_gallery_seq"):
		input_handler.update_progress_data("gallery_seq", scene.unlocked_gallery_seq)
#i was forced to add this field to correctly bound unlock event with gallery object
#with this new syntax it unlocks a full gallery sequence and so it reqires to make some changes into scenes
#i still can add an option to unlock a sequences per scene
#but it will still force us to make a changes into scenes to correctly pass data (scenes ids)
	if scene.has("scene_type"):
		if scene.scene_type == "story_scene":
			input_handler.update_progress_data("story_scenes", scene.custom_background)
		elif scene.scene_type == "ero_scene":
			input_handler.update_progress_data("ero_scenes", scene.custom_background)


func select_scene_variation_based_on_data(scene):
	for i in scene.variations:
		if globals.checkreqs(i.reqs):
			open(i)
			break


func set_dialogue_window_type(scene):
	gui_controller.dialogue_window_type = scene.dialogue_type
	gui_controller.dialogue_txt = gui_controller.dialogue.get_node("RichTextLabel").bbcode_text
	match gui_controller.dialogue_window_type:
		1:
			input_handler.get_spec_node(input_handler.NODE_DIALOGUE_T2).hide()
			gui_controller.dialogue = input_handler.get_spec_node(input_handler.NODE_DIALOGUE)
			input_handler.get_spec_node(input_handler.NODE_DIALOGUE).previous_dialogue_option = input_handler.get_spec_node(input_handler.NODE_DIALOGUE_T2).previous_dialogue_option
		2:
			input_handler.get_spec_node(input_handler.NODE_DIALOGUE).hide()
			gui_controller.dialogue = input_handler.get_spec_node(input_handler.NODE_DIALOGUE_T2)
			input_handler.get_spec_node(input_handler.NODE_DIALOGUE_T2).previous_dialogue_option = input_handler.get_spec_node(input_handler.NODE_DIALOGUE).previous_dialogue_option
	gui_controller.dialogue.get_node("RichTextLabel").bbcode_text = gui_controller.dialogue_txt
	gui_controller.dialogue.open(scene)


func handle_scene_transition_fx(scene):
	if gui_controller.is_dialogue_just_started:
		$RichTextLabel.modulate.a = 0
		$ScrollContainer.modulate.a = 0
	else:
		$RichTextLabel.modulate.a = 1
		$ScrollContainer.modulate.a = 1
	if scene.tags.has("blackscreen_transition_common"):
		ResourceScripts.core_animations.BlackScreenTransition(1)
		doing_transition = true
		yield(get_tree().create_timer(1), "timeout")
	elif scene.tags.has("whitescreen_transition_common"):
		ResourceScripts.core_animations.WhiteScreenTransition(1)
		doing_transition = true
		yield(get_tree().create_timer(1), "timeout")
	elif scene.tags.has("blackscreen_transition_slow"):
		ResourceScripts.core_animations.BlackScreenTransition(2)
		doing_transition = true
		yield(get_tree().create_timer(2), "timeout")
	if self.visible == false:
		self.visible = true
		ResourceScripts.core_animations.UnfadeAnimation(self, 0.2)
		$RichTextLabel.bbcode_text = ''
		previous_text = ''
		yield(get_tree().create_timer(0.2), "timeout")
	emit_signal("TransitionFinished")

func clear_character_images():
	$CharacterImage.hide()
	if get_node_or_null("CharacterImage2") != null:
		$CharacterImage2.hide()

func handle_scene_backgrounds(scene):
	var node = $CustomBackground
	if scene.has("custom_background"):
		var newtexture = images.backgrounds[scene.custom_background]
		if node.visible == false:
			node.show()
			ResourceScripts.core_animations.UnfadeAnimation(node, 0.5)
		if node.texture != newtexture:
			ResourceScripts.core_animations.SmoothTextureChange(node, newtexture, 1)
	elif !scene.has("custom_background") && gui_controller.dialogue_window_type == 1:
		node.hide()


var ch1 = null
var ch2 = null
var ch1_shade = false
var ch2_shade = false


func get_spouse_sprite():
	var spousechar = characters_pool.get_char_by_id(ResourceScripts.game_progress.spouse)
	if spousechar == null: return null
	else:
		match spousechar.get_stat('unique'):
			'anastasia': return 'anastasia'
			'daisy': return 'daisy_maid'
			#2add
			_: return null

func handle_characters_sprites(scene):
	#--i do not understand conditions and sequencing of most of code in cases of characters do exist
	#--so i think that there are some logical errors here
	#reworked with additional functional
	var scene_char = null
	var char_shade = false
	
	if !scene.has("character") and !scene.has("character2"):
		$ImagePanel.show()
		if self.name == "dialogue":
			hide_long_text()
			$CharacterImage2.hide()
		$CharacterImage.hide()
		if scene.has('image') && scene.image != '' && scene.image != null:
			$ImagePanel/SceneImage.texture = images.scenes[scene.image]
		else:
			$ImagePanel.hide()
			if self.name == "dialogue":
				show_long_text()
	else:
		$ImagePanel.hide()
		if self.name == "dialogue":
			show_long_text()

		if scene.has("character"):
			if scene.character.ends_with('_shade'):
				scene_char = scene.character.trim_suffix('_shade')
				char_shade = true
			else:
				scene_char = scene.character
				char_shade = false
				if scene_char == 'spouse':
					scene_char = get_spouse_sprite()
				if scene_char != null and !input_handler.progress_data.characters.has(scene_char):
					input_handler.progress_data.characters.append(scene_char)
					input_handler.save_progress_data(input_handler.progress_data)
			if scene_char != null and ch1 != scene_char:
				ResourceScripts.core_animations.UnfadeAnimation($CharacterImage, 0.5)
				$CharacterImage.texture = images.sprites[scene_char]
				if char_shade:
					$CharacterImage.material.set_shader_param('opacity', 1.0)
					ch1_shade = true
				else:
					$CharacterImage.material.set_shader_param('opacity', 0.0)
					ch1_shade = false
				ch1 = scene_char
				$CharacterImage.show()
			elif scene_char != null:
				if char_shade != ch1_shade:
					if char_shade: ResourceScripts.core_animations.ShadeAnimation($CharacterImage, 0.5)
					else: ResourceScripts.core_animations.UnshadeAnimation($CharacterImage, 0.5)
					ch1_shade = char_shade
				$CharacterImage.show()
			else:
				$CharacterImage.hide()
#			$CharacterImage.show()
		if scene.has("character2"):
			if scene.character2.ends_with('_shade'):
				scene_char = scene.character2.trim_suffix('_shade')
				char_shade = true
			else:
				scene_char = scene.character2
				char_shade = false
				if scene_char == 'spouse':
					scene_char = get_spouse_sprite()
				if scene_char != null and !input_handler.progress_data.characters.has(scene_char):
					input_handler.progress_data.characters.append(scene_char)
					input_handler.save_progress_data(input_handler.progress_data)
			if scene_char != null and ch2 != scene_char:
				ResourceScripts.core_animations.UnfadeAnimation($CharacterImage2, 0.5)
				$CharacterImage2.texture = images.sprites[scene_char]
				if char_shade:
					$CharacterImage2.material.set_shader_param('opacity', 1.0)
					ch2_shade = true
				else:
					$CharacterImage2.material.set_shader_param('opacity', 0.0)
					ch2_shade = false
				ch2 = scene_char
				$CharacterImage2.show()
			elif scene_char != null:
				if char_shade != ch2_shade:
					if char_shade: ResourceScripts.core_animations.ShadeAnimation($CharacterImage2, 0.5)
					else: ResourceScripts.core_animations.UnshadeAnimation($CharacterImage2, 0.5)
					ch2_shade = char_shade
				$CharacterImage2.show()
			else:
				$CharacterImage2.hide()
#			$CharacterImage2.show()
	
	#handle modulation
#	$CharacterImage.self_modulate.a = 255
#	$CharacterImage2.self_modulate.a = 255
#	if scene.has("character_alpha"):
#		$CharacterImage.self_modulate.a = scene.character_alpha
#	if scene.has("character2_alpha"):
#		$CharacterImage2.self_modulate.a = scene.character2_alpha
	
	# setting nude versions here
	if scene.has("character"):
		scene_char = scene.character
		for i in ResourceScripts.game_party.characters: 
			var person = ResourceScripts.game_party.characters[i]
			if scene_char != null && person.get_stat("unique") == scene_char && person.has_work_rule('nudity') && worlddata.pregen_character_sprites[scene_char].has("nude"):
				var non_body = person.statlist.statlist.body_image.replace("_body", "")
	#			var image = input_handler.loadimage(images.sprites[non_body], 'shades')
				var image = images.sprites[worlddata.pregen_character_sprites[scene_char].nude.path.replace("_body", "")]
				if images.sprites.has(non_body):
					$CharacterImage.texture = image
				else:
					$CharacterImage.texture = person.get_body_image()
				ch1 = person.get_stat("unique").to_lower()
	if scene.has("character2"):
		scene_char = scene.character2
		for i in ResourceScripts.game_party.characters: 
			var person = ResourceScripts.game_party.characters[i]
			if scene_char != null && person.get_stat("unique") == scene_char && person.has_work_rule('nudity') && worlddata.pregen_character_sprites[scene_char].has("nude"):
				var non_body = person.statlist.statlist.body_image.replace("_body", "")
	#			var image = input_handler.loadimage(images.sprites[non_body], 'shades')
				var image = images.sprites[worlddata.pregen_character_sprites[scene_char].nude.path.replace("_body", "")]
				if images.sprites.has(non_body):
					$CharacterImage2.texture = image
				else:
					$CharacterImage2.texture = person.get_body_image()
				ch1 = person.get_stat("unique").to_lower()
			
	# setting wed versions here
	if scene.has("character"):
		scene_char = scene.character
		if ResourceScripts.game_progress.spouse != null && globals.valuecheck({type = 'has_spouse', check = true}) and !ResourceScripts.game_progress.marriage_completed:
			# set wed sprite here
			var spouse_person = characters_pool.get_char_by_id(ResourceScripts.game_progress.spouse)
			var spouse_unique_name = spouse_person.get_stat('unique')
			if scene_char == spouse_unique_name and worlddata.pregen_character_sprites[scene_char].has("wed"):
				var image = images.sprites[worlddata.pregen_character_sprites[scene_char].wed.path]
				$CharacterImage.texture = image
	
	
	#handle unique character script
	if scene.has("unique_character"):
		for i in ResourceScripts.game_party.characters: 
			var person = ResourceScripts.game_party.characters[i]
			if person.get_stat("unique") == scene.unique_character:
				$CharacterImage.show()
				var non_body = person.statlist.statlist.body_image.replace("_body", "")
				var image = input_handler.loadimage(images.sprites[non_body], 'shades')
				if $CharacterImage.texture != image:
					ResourceScripts.core_animations.UnfadeAnimation($CharacterImage, 0.5)
				if images.sprites.has(non_body):
					$CharacterImage.texture = image
				else:
					$CharacterImage.texture = person.get_body_image()
				$CharacterImage.material.set_shader_param('opacity', 0.0)
				ch1_shade = false
				ch1 = person.get_stat("unique").to_lower()
				return
	if scene.has("unique_character2"):
		for i in ResourceScripts.game_party.characters: 
			var person = ResourceScripts.game_party.characters[i]
			if person.get_stat("unique") == scene.unique_character2:
				$CharacterImage2.show()
				var non_body = person.statlist.statlist.body_image.replace("_body", "")
				var image = input_handler.loadimage(images.sprites[non_body], 'shades')
				if $CharacterImage2.texture != image:
					ResourceScripts.core_animations.UnfadeAnimation($CharacterImage2, 0.5)
				if images.sprites.has(non_body):
					$CharacterImage2.texture = image
				else:
					$CharacterImage2.texture = person.get_body_image()
				$CharacterImage2.material.set_shader_param('opacity', 0.0)
				ch2_shade = false
				ch2 = person.get_stat("unique")
				return
#	if !scene.has("character"):
#		$ImagePanel.show()
#		$CharacterImage.hide()
#		if scene.image != '' && scene.image != null:
#			$ImagePanel/SceneImage.texture = images.scenes[scene.image]
#		else:
#			$ImagePanel.hide()
#			#$ImagePanel/SceneImage.texture = load("res://assets/images/scenes/image_wip.png")
#	else:
#		if !($CharacterImage.texture == images.sprites[scene.character]):
#			ResourceScripts.core_animations.UnfadeAnimation($CharacterImage,0.5)
#		$ImagePanel.hide()
#		$CharacterImage.texture = images.sprites[scene.character]
#		$CharacterImage.show()
#	if !scene.has("character2"):
#		$ImagePanel.show()
#		if get_node_or_null("CharacterImage2"):
#			$CharacterImage2.hide()
#		if scene.image != '' && scene.image != null:
#			$ImagePanel/SceneImage.texture = images.scenes[scene.image]
#		else:
#			$ImagePanel.hide()
#			#$ImagePanel/SceneImage.texture = load("res://assets/images/scenes/image_wip.png")
#	else:
#		if !($CharacterImage2.texture == images.sprites[scene.character2]):
#			ResourceScripts.core_animations.UnfadeAnimation($CharacterImage2,0.5)
#		$ImagePanel.hide()
#		$CharacterImage2.texture = images.sprites[scene.character2]
#		$CharacterImage2.show()

func show_long_text():
	self.get_stylebox("panel", "").modulate_color.a = 0
	$LongFrame.show()
	$DialogueBG.rect_size.y = $LongFrame.rect_size.y - $OptionsBackground.rect_size.y
	$DialogueBG.rect_position.y = $LongFrame.rect_position.y
	$RichTextLabel.rect_size.y = $LongFrame.rect_size.y - 249 - 50
	$RichTextLabel.rect_position.y = $LongFrame.rect_position.y + 46#($ScrollContainer.rect_size.y * 0.5)

func hide_long_text():
	self.get_stylebox("panel", "").modulate_color.a = 255
	$LongFrame.hide()
	$DialogueBG.rect_size.y = self.rect_size.y - $OptionsBackground.rect_size.y
	$DialogueBG.rect_position.y = 0
	$RichTextLabel.rect_size = base_text_size
	$RichTextLabel.rect_position = base_text_position


func handle_loots(scene):
	if scene.tags.has('locked_chest'):
		add_chest_options(scene)
	if scene.tags.has("shrine"):
		add_shrine_options(scene)
	if scene.tags.has("recruit"):
		add_recruit_option(scene)
	if scene.tags.has("free_loot"):
		add_loot_options(scene)


func generate_scene_text(scene):
	var scenetext = scene.text
	var newtext = ''
	for i in scenetext:
		if i.has("previous_dialogue_option") && typeof(i.previous_dialogue_option) != TYPE_ARRAY:
			i.previous_dialogue_option = [i.previous_dialogue_option]
		if (i.has("previous_dialogue_option") && !(previous_dialogue_option in i.previous_dialogue_option)) || !globals.checkreqs(i.reqs):
			continue
		# if ResourceScripts.game_progress.seen_dialogues.has(i.text) == false && is_should_save == false:
		if input_handler.if_translation_key(i.text):
			ResourceScripts.game_progress.seen_dialogues.append(i.text)
		if i.has("bonus_effects"):
			globals.common_effects(i.bonus_effects)
		newtext += tr(i.text)
	scenetext = newtext
	scenetext = tr(scenetext)
	if scene.has('bonus_effects'):
		globals.common_effects(scene.bonus_effects)

	if scenetext.find("[locationname]") >= 0:
		scenetext = scenetext.replace("[locationname]", input_handler.selected_location.name)
		scenetext = scenetext.replace("[areaname]", input_handler.selected_area.name)
		scenetext = scenetext.replace("[locationtypename]", input_handler.selected_location.classname)
	if scene.tags.has("master_translate"):
		if ResourceScripts.game_party.get_master() == null:
			print("Error: Master not found")
#			return
		else:
			scenetext = ResourceScripts.game_party.get_master().translate(scenetext)
	if scene.tags.has("active_character_translate"):
		if input_handler.active_character != null:
			scenetext = input_handler.active_character.translate(scenetext)
	if scene.tags.has("scene_character_translate"):
		scenetext = input_handler.scene_characters[0].translate(scenetext.replace("[scnchar","["))
	if scene.tags.has("location_resource_info"):
		scenetext = add_location_resource_info()
	if gui_controller.is_dialogue_just_started:
		ResourceScripts.core_animations.UnfadeAnimation($RichTextLabel,1)
		ResourceScripts.core_animations.UnfadeAnimation($ScrollContainer,1)
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	if scene.tags.has("scene_characters_sell"):#
		var counter = 0
		var text = ''
		for i in input_handler.scene_characters:
			text += i.get_short_name() + " " + i.get_stat('sex') + " - " + races.racelist[i.get_stat('race')].name + ": " + str(i.calculate_price(true)) + " gold\n"
			scene.options.append({code = 'recruit_from_scene', args = counter, reqs = [{type = "has_money_for_scene_slave", value = counter}], not_hide = true, text = tr("DIALOGUESLAVERSPURCHASE") + " - " + i.get_short_name() + ": " + str(i.calculate_price(true)) + " Gold", bonus_effects = [{code = 'spend_money_for_scene_character', value = counter}]})
			counter += 1
		scenetext += "\n\n" + text

	if $RichTextLabel.bbcode_text != '':
		$RichTextLabel.bbcode_text += "\n\n[color=yellow]"+previous_text+"[/color]\n\n" + globals.TextEncoder(scenetext)
	else:
		$RichTextLabel.bbcode_text = globals.TextEncoder(scenetext)


func set_enemy(scene):
	if scene.has("set_enemy"):
		dialogue_enemy = scene.set_enemy


func handle_scene_options():
		var option_number = 1
		var options = current_scene.options
		for id in range(options.size()):
			var i = options[id]
			if i.has("previous_dialogue_option") && typeof(i.previous_dialogue_option) != TYPE_ARRAY:
				i.previous_dialogue_option = [i.previous_dialogue_option]
			if (i.has("previous_dialogue_option") && !(previous_dialogue_option in i.previous_dialogue_option)):
				continue
			if i.has('remove_after_first_use') && ResourceScripts.game_progress.selected_dialogues.has(i.text):
				continue
			var disable = false
			if globals.checkreqs(i.reqs) == false:
				if i.has('not_hide') == true:
					disable = true
				else:
					continue
			if i.has("repeat_next_day"):
				var cont = false
				for d in ResourceScripts.game_progress.daily_dialogues:
					if d.option == i.code:
						if d.last_activation >= ResourceScripts.game_globals.date:
							cont = true
							break
				if cont:
					continue
			
			var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.set_meta("id", id)
			newbutton.set("modulate", Color(1, 1, 1, 0))
			i.text_key = i.text
			i.text = tr(i.text)
			if i.has('active_char_translate'):
				i.text = input_handler.active_character.translate(tr(i.text))
			elif i.has('master_translate'):
				i.text = ResourceScripts.game_party.get_master().translate(i.text)
			newbutton.get_node("Label").bbcode_text = i.text
			newbutton.hotkey = option_number
			yield(get_tree(), 'idle_frame')
			newbutton.get_node("Label").rect_size.y += 8
			newbutton.rect_min_size.y = newbutton.get_node("Label").rect_size.y
			newbutton.connect("pressed",self,'select_option', [option_number - 1])
			
			
			if ResourceScripts.game_progress.selected_dialogues.has(i.text_key):
				newbutton.status = 'seen'
			if i.has('type'):
				match i.type:
					'next_dialogue':
						newbutton.status = 'next_dialogue'
			
			if i.has('disabled') && i.disabled == true:
				newbutton.status = 'disabled'
				disable = true
			if disable:
				newbutton.disabled = true
				newbutton.status = 'disabled'
			option_number += 1


func select_option(number):
#	if $ScrollContainer/VBoxContainer.get_children().size() >= number && hold_selection == false:
#		var button = $ScrollContainer/VBoxContainer.get_child(number-1)
#		if button.disabled == false && button.visible == true:
#			button.toggle_mode = true
#			button.pressed = true
#			hold_selection = true
#			yield(get_tree().create_timer(0.2), "timeout")
#			button.emit_signal("pressed")
	if hold_selection: 
		return
	if $ScrollContainer/VBoxContainer.get_child_count() <= number: return
	var button = $ScrollContainer/VBoxContainer.get_child(number)
	if button.disabled or !button.visible: 
		return
	
	button.toggle_mode = true
	button.pressed = true
#	hold_selection = true
	var options = current_scene.options
	var option = options[button.get_meta("id")]
	var code = option.code
	
	if option.has("repeat_next_day"):
		var dup = false
		for i in ResourceScripts.game_progress.daily_dialogues:
			if i.option == option.code:
				i.last_activation = ResourceScripts.game_globals.date
				dup = true
		if !dup:
			ResourceScripts.game_progress.daily_dialogues.append({
				option = option.code,
				last_activation = ResourceScripts.game_globals.date
			})
	
	input_handler.dialogue_option_selected(option) #need to remove this at next rework
	if option.has('bonus_effects'):
		globals.common_effects(option.bonus_effects)
	
	if option.has('select_person'):
		select_person_for_next_event(code)
	elif option.has('remove_person'):
		remove_person(code)
	elif option.has('remove_non_master'):
		remove_non_master(code)
	elif code == 'shrine_option':
		shrine_option(option.args[0])
	elif option.code == 'chest_mimic_force_open':
		chest_mimic_force_open()
	elif current_scene.tags.has('linked_event') && !code in ['close','leave', 'fight_skirmish','continue','recruit','recruit_from_scene']:
		hold_selection = true
		var event_type = 'story_event'
		if scenedata.scenedict[code].has('default_event_type'):
			event_type = scenedata.scenedict[code].default_event_type
		input_handler.interactive_message_follow(code, event_type, {})
	elif current_scene.tags.has("skill_event"):
		if !code == 'cancel_skill_usage':
			input_handler.active_character.use_social_skill(code, input_handler.target_character)
		elif code == 'cancel_skill_usage':
			cancel_skill_usage()
	elif current_scene.tags.has("custom_effect"):
		ResourceScripts.custom_effects.call(code) #controvertial moment cause most of those methods have a different signature
	elif current_scene.tags.has("dialogue_scene") && !(code in ['close','quest_fight']):
		hold_selection = true
		if option.has('change_dialogue_type'):
			dialogue_next(code, option.dialogue_argument, {changed_window_type = true})
		else:
			dialogue_next(code, option.dialogue_argument)
	else:
		var args
		if option.has('args'): args = option.args
		if args != null:
			call(code, args)
		else:
			call(code)


