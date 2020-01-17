extends Panel

var previousscene
var dialogue_enemy
var current_scene
var hold_selection = false #pause for scene to laod


func open(scene):
	if scene.has("variations"):
		for i in scene.variations:
			if state.checkreqs(i.reqs):
				open(i)
				break
		
		return
	if input_handler.CurrentScreen != 'scene': previousscene = input_handler.CurrentScreen
	input_handler.CurrentScreen = 'scene'
	current_scene = scene
	hold_selection = true
	if scene.has("common_effects"): 
		state.common_effects(scene.common_effects)
	
	update_scene_characters()
	
	if self.visible == false:
		input_handler.UnfadeAnimation(self, 0.2)
		yield(get_tree().create_timer(0.2), "timeout")
	$RichTextLabel.modulate.a = 0
	$ScrollContainer.modulate.a = 0
	if scene.image != '' && scene.image != null:
		$image.texture = images.scenes[scene.image]
	else:
		$image.texture = load("res://assets/images/scenes/noevent.png")
	show()
	if scene.text.find("[locationname]") >= 0:
		scene.text = scene.text.replace("[locationname]", input_handler.active_location.name)
	if scene.tags.has("master_translate"):
		if state.get_master() == null:
			print("master_not_found")
			return
		scene.text = state.get_master().translate(scene.text)
	if scene.tags.has("active_character_translate"):
		scene.text = input_handler.active_character.translate(scene.text)
	if scene.tags.has("scene_character_translate"):
		scene.text = input_handler.scene_characters[0].translate(scene.text.replace("[scnchar","["))
	input_handler.UnfadeAnimation($RichTextLabel,1)
	input_handler.UnfadeAnimation($ScrollContainer,1)
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	if scene.tags.has("scene_characters_sell"):#
		var counter = 0
		var text = ''
		for i in input_handler.scene_characters:
			text += i.get_short_name() + " " + i.sex + " - " + races.racelist[i.race].name + ": " + str(i.calculate_price()) + " gold\n"
			scene.options.append({code = 'recruit_from_scene', args = counter, reqs = [{type = "has_money_for_scene_slave", value = counter}], not_hide = true, text = tr("DIALOGUESLAVERSPURCHASE") + " - " + i.get_short_name() + ": " + str(i.calculate_price()) + " Gold", bonus_effects = [{code = 'spend_money_for_scene_character', value = counter}]})
			counter += 1
		scene.text += "\n\n" + text
	if scene.has("set_enemy"):
		dialogue_enemy = scene.set_enemy
	var counter = 1
	for i in scene.options:
		var disable = false
		if state.checkreqs(i.reqs) == false:
			if i.has('not_hide') == true:
				disable = true
			else:
				continue
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node("Label").text = i.text
		newbutton.get_node("hotkey").text = str(counter)
		
		if i.has('select_person'):
			newbutton.connect("pressed", self, 'select_person_for_next_event', [i.code])
		elif scene.tags.has('linked_event') && !i.code in ['leave', 'fight_skirmish','continue','recruit','recruit_from_scene']:
			var event_type = 'story_event'
			if scenedata.scenedict[i.code].has('default_event_type'):
				event_type = scenedata.scenedict[i.code].default_event_type
			newbutton.connect("pressed", input_handler, 'interactive_message', [i.code, event_type, {}])
		elif scene.tags.has("skill_event") && !i.code == 'cancel_skill_usage':
			newbutton.connect("pressed", input_handler.active_character, 'use_social_skill', [i.code, input_handler.target_character])
		elif scene.tags.has("custom_effect"):
			newbutton.connect('pressed', globals.custom_effects, i.code)
		else:
			var args
			if i.has('args') == true: args = i.args
			if args != null:
				newbutton.connect("pressed", self, i.code, [args])
			else:
				newbutton.connect("pressed", self, i.code)
		
		
		if i.has('disabled') && i.disabled == true:
			disable = true
		if i.has('bonus_effects'):
			newbutton.connect('pressed', state, "common_effects", [i.bonus_effects])
		newbutton.disabled = disable
		counter += 1
	$RichTextLabel.bbcode_text = globals.TextEncoder(scene.text)
	yield(get_tree().create_timer(0.7), "timeout")
	hold_selection = false

func update_scene_characters():
	globals.ClearContainer($EventCharacters/VBoxContainer)
	globals.ClearContainer($PlayerCharacters/VBoxContainer)
	for i in input_handler.scene_characters:
		var newbutton = globals.DuplicateContainerTemplate($EventCharacters/VBoxContainer)
		newbutton.get_node("Label").text = i.get_short_name()
		newbutton.get_node('icon').texture = i.get_icon()
		globals.connectslavetooltip(newbutton, i)
		if i.is_players_character == false:
			newbutton.connect('signal_RMB_release',input_handler,'ShowSlavePanel', [i])

var stored_scene

func slave_sold():
	pass

func select_person_for_next_event(code):
	var reqs = [{code = 'is_at_location', value = input_handler.active_location.id}]
	stored_scene = code
	input_handler.ShowSlaveSelectPanel(self, 'event_person_selected', reqs)

func event_person_selected(person):
	var data = scenedata.scenedict[stored_scene]
	var event_type = 'story_event'
	if scenedata.scenedict[stored_scene].has('default_event_type'):
		event_type = scenedata.scenedict[stored_scene].default_event_type
	input_handler.active_character = person
	input_handler.interactive_message(stored_scene, event_type, {})

func select_option(number):
	if $ScrollContainer/VBoxContainer.get_children().size() >= number && hold_selection == false:
		var button = $ScrollContainer/VBoxContainer.get_child(number-1)
		if button.disabled == false && button.visible == true:
			button.toggle_mode = true
			button.pressed = true
			hold_selection = true
			yield(get_tree().create_timer(0.2), "timeout")
			button.emit_signal("pressed")

func close():
	input_handler.FadeAnimation(self, 0.2)
	yield(get_tree().create_timer(0.2), "timeout")
	hide()
	input_handler.scene_characters.clear()
	input_handler.CurrentScreen = previousscene
	input_handler.emit_signal("EventFinished")

func cancel_skill_usage():
	input_handler.active_character.restore_skill_charge(input_handler.activated_skill)
	input_handler.get_spec_node(input_handler.NODE_SLAVEPANEL).update()
	#input_handler.get_spec_node(input_handler.NODE_SLAVEPANEL, [input_handler.active_character])
	close()

func repeat():
	input_handler.repeat_social_skill()
	input_handler.update_slave_panel()

func recruit_from_scene(order = 0):
	input_handler.active_character = input_handler.scene_characters[order]
	recruit()

func recruit():
	if state.characters.size() >= state.get_pop_cap():
		if state.get_pop_cap() < variables.max_population_cap:
			input_handler.SystemMessage("You don't have enough rooms")
		else:
			input_handler.SystemMessage("Population limit reached")
		return
	var person = input_handler.active_character
	if variables.instant_travel == false:
		person.travel_target = {area = '', location = 'mansion'}
		person.travel_time = input_handler.active_area.travel_time + input_handler.active_location.travel_time
		person.work = 'travel'
		person.location = 'travel'
	else:
		person.location = 'mansion'
	state.add_slave(person)
	close()

func create_location_recruit(args):
	var newchar = Slave.new()
	input_handler.active_character = newchar
	newchar.generate_random_character_from_data(input_handler.active_location.races)
	$RichTextLabel.bbcode_text = newchar.translate($RichTextLabel.bbcode_text)

func execute():
	close()

func inspect_active_character():
	input_handler.ShowSlavePanel(input_handler.active_character)
	#input_handler.get_spec_node(input_handler.NODE_SLAVEPANEL, [input_handler.active_character])

func inspect_character_child():
	input_handler.ShowSlavePanel(state.babies[input_handler.active_character.pregnancy.baby])
	#input_handler.get_spec_node(input_handler.NODE_SLAVEPANEL, [state.babies[input_handler.active_character.pregnancy.baby]])

func keepbaby():
	var node = input_handler.get_spec_node(input_handler.NODE_TEXTEDIT) #input_handler.GetTextEditNode()
	var person = state.babies[input_handler.active_character.pregnancy.baby]
	person.get_random_name()
	node.open(self, 'set_baby_name', person.name)

func removebaby():
	close()
	state.babies.erase(input_handler.active_character.pregnancy.baby)
	input_handler.active_character.pregnancy.baby = null

func set_baby_name(text):
	var person = state.babies[input_handler.active_character.pregnancy.baby]
	person.name = text
	person.surname = input_handler.active_character.surname
	state.add_slave(person)
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
#	if dialogue_enemy != null:
#		input_handler.StartCombat(dialogue_enemy)
	input_handler.current_enemy_group = dialogue_enemy
	if current_scene.has("winscene"):
		input_handler.encounter_win_script = current_scene.winscene
	input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)
	#close()
