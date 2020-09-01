extends Panel

var previousscene
var dialogue_enemy
var current_scene
var hold_selection = false #pause for scene to load
var previous_dialogue_option = 0
var previous_text = ''


func open(scene, not_save = false):
	if scene.has("variations"):
		for i in scene.variations:
			if globals.checkreqs(i.reqs):
				open(i)
				break
		
		return
	if input_handler.CurrentScreen != 'scene': previousscene = input_handler.CurrentScreen
	input_handler.CurrentScreen = 'scene'
	current_scene = scene
	hold_selection = true
	if scene.has("common_effects"): 
		globals.common_effects(scene.common_effects)
	if typeof(scene.text) == TYPE_STRING:
		scene.text = [{text = scene.text, reqs = []}]
	
	update_scene_characters()
	
	
	$CharacterImage.hide()
	$ImagePanel.hide()
	$RichTextLabel.modulate.a = 0
	$ScrollContainer.modulate.a = 0
	if scene.tags.has("blackscreen_transition_common"):
		ResourceScripts.core_animations.BlackScreenTransition(1)
		yield(get_tree().create_timer(1), "timeout")
		if scene.tags.has("close_guild"):
			var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false, false)
			var guild = GUIWorld.gui_data.EXPLORATION.main_module.City
			guild.opened_guild = {code = ""}
			guild.get_parent().get_node("GuildBG").hide()
			guild.Guild.hide()
			guild.get_node("GuildMenuBG").hide()
	elif scene.tags.has("blackscreen_transition_slow"):
		ResourceScripts.core_animations.BlackScreenTransition(2)
		yield(get_tree().create_timer(2), "timeout")
	
	if scene.has("character") == false:
		$ImagePanel.show()
		$CharacterImage.hide()
		if scene.image != '' && scene.image != null:
			$ImagePanel/SceneImage.texture = images.scenes[scene.image]
		else:
			$ImagePanel.hide()
			#$ImagePanel/SceneImage.texture = load("res://assets/images/scenes/image_wip.png")
	else:
		if $CharacterImage.texture == images.sprites[scene.character] == false:
			ResourceScripts.core_animations.UnfadeAnimation($CharacterImage,0.5)
		$ImagePanel.hide()
		$CharacterImage.texture = images.sprites[scene.character]
		$CharacterImage.show()
	
	if self.visible == false:
		self.visible = true
		ResourceScripts.core_animations.UnfadeAnimation(self, 0.2)
		$RichTextLabel.bbcode_text = ''
		previous_text = ''
		yield(get_tree().create_timer(0.2), "timeout")
	show()
	
	if scene.tags.has('locked_chest'):
		add_chest_options(scene)
	
	
	
	var scenetext = scene.text
	var newtext = ''
	for i in scenetext:
		if i.has("previous_dialogue_option") && typeof(i.previous_dialogue_option) != TYPE_ARRAY:
			i.previous_dialogue_option = [i.previous_dialogue_option]
		if (i.has("previous_dialogue_option") && !previous_dialogue_option in i.previous_dialogue_option) || !globals.checkreqs(i.reqs):
			continue
		if ResourceScripts.game_progress.seen_dialogues.has(i.text) == false && not_save == false:
			ResourceScripts.game_progress.seen_dialogues.append(i.text)
		if i.has("bonus_effects"):
			globals.common_effects(i.bonus_effects)
		newtext += tr(i.text)
	scenetext = newtext
	scenetext = tr(scenetext)
	
	if scenetext.find("[locationname]") >= 0:
		scenetext = scenetext.replace("[locationname]", input_handler.active_location.name)
		scenetext = scenetext.replace("[areaname]", input_handler.active_area.name)
		scenetext = scenetext.replace("[locationtypename]", input_handler.active_location.classname)
	if scene.tags.has("master_translate"):
		if ResourceScripts.game_party.get_master() == null:
			print("master_not_found")
			return
		scenetext = ResourceScripts.game_party.get_master().translate(scenetext)
	if scene.tags.has("active_character_translate"):
		scenetext = input_handler.active_character.translate(scenetext)
	if scene.tags.has("scene_character_translate"):
		scenetext = input_handler.scene_characters[0].translate(scenetext.replace("[scnchar","["))
	if scene.tags.has("location_resource_info"):
		scenetext = add_location_resource_info() 
	
	ResourceScripts.core_animations.UnfadeAnimation($RichTextLabel,1)
	ResourceScripts.core_animations.UnfadeAnimation($ScrollContainer,1)
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	if scene.tags.has("scene_characters_sell"):#
		var counter = 0
		var text = ''
		for i in input_handler.scene_characters:
			text += i.get_short_name() + " " + i.get_stat('sex') + " - " + races.racelist[i.get_stat('race')].name + ": " + str(i.calculate_price()) + " gold\n"
			scene.options.append({code = 'recruit_from_scene', args = counter, reqs = [{type = "has_money_for_scene_slave", value = counter}], not_hide = true, text = tr("DIALOGUESLAVERSPURCHASE") + " - " + i.get_short_name() + ": " + str(i.calculate_price()) + " Gold", bonus_effects = [{code = 'spend_money_for_scene_character', value = counter}]})
			counter += 1
		scenetext += "\n\n" + text
	
	if scene.has("set_enemy"):
		dialogue_enemy = scene.set_enemy
	var counter = 1
	var options = scene.options
	for i in options:
		#yield(get_tree(), 'idle_frame')
		if i.has('remove_after_first_use') && ResourceScripts.game_progress.selected_dialogues.has(i.text):
			continue
		var disable = false
		if globals.checkreqs(i.reqs) == false:
			if i.has('not_hide') == true:
				disable = true
			else:
				continue
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node("Label").bbcode_text = tr(i.text)
		newbutton.get_node("hotkey").text = str(counter)
		yield(get_tree(), 'idle_frame')
		if newbutton.get_node("Label").get_v_scroll().is_visible():
			newbutton.rect_min_size.y = newbutton.get_node("Label").get_v_scroll().get_max()+10
		newbutton.get_node("Label").rect_size.y = newbutton.rect_min_size.y
		newbutton.connect("pressed",input_handler,'dialogue_option_selected',[i.text])
		
		if i.has('select_person'):
			newbutton.connect("pressed", self, 'select_person_for_next_event', [i.code])
		elif i.code == 'chest_mimic_force_open':
			newbutton.connect("pressed",self,'chest_mimic_force_open')
		elif scene.tags.has('linked_event') && !i.code in ['close','leave', 'fight_skirmish','continue','recruit','recruit_from_scene']:
			var event_type = 'story_event'
			if scenedata.scenedict[i.code].has('default_event_type'):
				event_type = scenedata.scenedict[i.code].default_event_type
			newbutton.connect("pressed", input_handler, 'interactive_message_follow', [i.code, event_type, {}])
		elif scene.tags.has("skill_event") && !i.code == 'cancel_skill_usage':
			newbutton.connect("pressed", input_handler.active_character, 'use_social_skill', [i.code, input_handler.target_character])
		elif scene.tags.has("custom_effect"):
			newbutton.connect('pressed', ResourceScripts.custom_effects, i.code)
		elif scene.tags.has("dialogue_scene") && !i.code in ['close','quest_fight']:
			newbutton.connect('pressed', self, 'dialogue_next', [i.code, i.dialogue_argument])
		else:
			var args
			if i.has('args') == true: args = i.args
			if args != null:
				newbutton.connect("pressed", self, i.code, [args])
			else:
				newbutton.connect("pressed", self, i.code)
		
		if i.has('type'):
			match i.type:
				'next_dialogue':
					newbutton.get_node("Label").bbcode_text = globals.TextEncoder("{color=yellow|"+newbutton.get_node("Label").bbcode_text +"}")
		if ResourceScripts.game_progress.selected_dialogues.has(i.text):
			newbutton.get_node("Label").bbcode_text = globals.TextEncoder("{color=gray_text_dialogue|"+newbutton.get_node("Label").bbcode_text +"}")
		
		if i.has('disabled') && i.disabled == true:
			disable = true
		if i.has('bonus_effects'):
			newbutton.connect('pressed', globals, "common_effects", [i.bonus_effects])
		newbutton.disabled = disable
		counter += 1
	if $RichTextLabel.bbcode_text != '':
		$RichTextLabel.bbcode_text += "\n\n[color=yellow]"+previous_text+"[/color]\n\n" + globals.TextEncoder(scenetext)
	else:
		$RichTextLabel.bbcode_text = globals.TextEncoder(scenetext)
	yield(get_tree().create_timer(0.7), "timeout")
	hold_selection = false

func complete_skirmish():
	globals.complete_location(input_handler.active_location.id)
	globals.remove_location(input_handler.active_location.id)
	close()

func update_scene_characters():
	var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false, false)
	input_handler.ClearContainer($EventCharacters/VBoxContainer)
	input_handler.ClearContainer($PlayerCharacters/VBoxContainer)
	for i in input_handler.scene_characters:
		var newbutton = input_handler.DuplicateContainerTemplate($EventCharacters/VBoxContainer)
		newbutton.get_node("Label").text = i.get_short_name()
		newbutton.get_node('icon').texture = i.get_icon()
		globals.connectslavetooltip(newbutton, i)
		if i.is_players_character == false:
			newbutton.connect('signal_RMB_release',GUIWorld.gui_data["EXPLORATION"].main_module, 'ShowSlavePanel', [i])

var stored_scene

func dialogue_next(code, argument):
	previous_dialogue_option = argument
	input_handler.interactive_message_follow(code, '', '')


func chest_mimic_force_open():
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
					text += "[name] concludes this chest is {color=aqua|unlocked} and safe to use."
				'none':
					text += "[name] concludes this chest is locked with a {color=aqua|mechanic lock} and has no additional danger."
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
	var reqs = [{code = 'is_at_location', value = input_handler.active_location.id, check = true}]
	stored_scene = code
	input_handler.ShowSlaveSelectPanel(self, 'event_person_selected', reqs)

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

func select_option(number):
	if $ScrollContainer/VBoxContainer.get_children().size() >= number && hold_selection == false:
		var button = $ScrollContainer/VBoxContainer.get_child(number-1)
		if button.disabled == false && button.visible == true:
			button.toggle_mode = true
			button.pressed = true
			hold_selection = true
			yield(get_tree().create_timer(0.2), "timeout")
			button.emit_signal("pressed")

func close(transition = false):
	var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false, false)
	ResourceScripts.core_animations.FadeAnimation(self, 0.2)
	yield(get_tree().create_timer(0.2), "timeout")
	hide()
	if transition == false:
		input_handler.scene_characters.clear()
	input_handler.CurrentScreen = previousscene
	input_handler.emit_signal("EventFinished")
	if get_tree().get_root().get_node_or_null("GUIWorld"):
		GUIWorld.CurrentScene = GUIWorld.BaseScene

func cancel_skill_usage():
	input_handler.active_character.restore_skill_charge(input_handler.activated_skill)
	input_handler.get_spec_node(input_handler.NODE_SLAVEPANEL).update()
	#input_handler.get_spec_node(input_handler.NODE_SLAVEPANEL, [input_handler.active_character])
	close()

func repeat():
	input_handler.repeat_social_skill()
	# input_handler.update_slave_panel()

func recruit_from_scene(order = 0):
	input_handler.active_character = input_handler.scene_characters[order]
	recruit()

func recruit():
	if ResourceScripts.game_party.characters.size() >= ResourceScripts.game_res.get_pop_cap():
		if ResourceScripts.game_res.get_pop_cap() < variables.max_population_cap:
			input_handler.SystemMessage("You don't have enough rooms")
		else:
			input_handler.SystemMessage("Population limit reached")
		return
	input_handler.active_character.recruit()
	close()

func create_location_recruit(args):
	var newchar = ResourceScripts.scriptdict.class_slave.new()
	input_handler.active_character = newchar
	newchar.generate_random_character_from_data(input_handler.active_location.races)
	$RichTextLabel.bbcode_text = newchar.translate($RichTextLabel.bbcode_text)

func execute():
	close()

func inspect_active_character():
	input_handler.ShowSlavePanel(input_handler.active_character)
	#input_handler.get_spec_node(input_handler.NODE_SLAVEPANEL, [input_handler.active_character])

func inspect_character_child():
	input_handler.ShowSlavePanel(ResourceScripts.game_party.babies[input_handler.active_character.get_stat('pregnancy').baby])
	#input_handler.get_spec_node(input_handler.NODE_SLAVEPANEL, [state.babies[input_handler.active_character.get_stat('pregnancy').baby]])

func keepbaby():
	var node = input_handler.get_spec_node(input_handler.NODE_TEXTEDIT) #input_handler.GetTextEditNode()
	var person = ResourceScripts.game_party.babies[input_handler.active_character.get_stat('pregnancy').baby]
	person.statlist.get_random_name()
	node.open(self, 'set_baby_name', person.get_stat('name'))

func removebaby():
	close()
	ResourceScripts.game_party.babies[input_handler.active_character.get_stat('pregnancy').baby].is_active = false
	ResourceScripts.game_party.babies.erase(input_handler.active_character.get_stat('pregnancy').baby)
	input_handler.active_character.get_stat('pregnancy').baby = null

func set_baby_name(text):
	var person = ResourceScripts.game_party.babies[input_handler.active_character.get_stat('pregnancy').baby]
	person.baby_transform()
	person.set_stat('obedience', 24)
	person.set_stat('name', text)
	ResourceScripts.game_party.add_slave(person, true)
	close()

func open_chest():
	input_handler.get_spec_node(input_handler.NODE_LOOTTABLE).open(input_handler.scene_loot, '[center]Acquired Items:[/center]')
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
	close()

func fight_skirmish():
	if current_scene.has("winscene"):
		input_handler.encounter_win_script = current_scene.winscene
	globals.current_enemy_group = dialogue_enemy
	input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)
	close(true)

func quest_fight(code):
	globals.current_enemy_group = code
	input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)
	close(true)

