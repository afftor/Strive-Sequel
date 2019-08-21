extends Panel

var operation_data

func open(scene):
	show()
	if scene.has("variations"):
		for i in scene.variations:
			if state.checkreqs(i.reqs):
				open(i)
				break
		
		return
	if scene.text.find("[locationname]") >= 0:
		scene.text = scene.text.replace("[locationname]", input_handler.active_location.name)
	if scene.tags.has("master_translate"):
		if state.get_master() == null:
			print("master_not_found")
			return
		scene.text = state.get_master().translate(scene.text)
	if scene.tags.has("scene_character_translate"):
		scene.text = input_handler.scene_character.translate(scene.text)
	$RichTextLabel.bbcode_text = scene.text
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	if scene.has("common_effects"):
		state.common_effects(scene.common_effects)
	for i in scene.options:
		if state.checkreqs(i.reqs) == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node("Label").text = i.text
		if scene.tags.has('linked_event'):
			newbutton.connect("pressed", input_handler, 'interactive_message', [i.code, 'story_event', {}])
		elif scene.tags.has("skill_event") && !i.code == 'cancel_skill_usage':
			newbutton.connect("pressed", input_handler.scene_character, 'use_social_skill', [i.code, input_handler.target_character])
		elif scene.tags.has("custom_effect"):
			newbutton.connect('pressed', globals.custom_effects, i.code)
		else:
			newbutton.connect("pressed", self, i.code)
		if i.has('disabled') && i.disabled == true:
			newbutton.disabled = true

func close():
	hide()
	input_handler.emit_signal("EventFinished")

func cancel_skill_usage():
	hide()
	input_handler.scene_character.restore_skill_charge(input_handler.activated_skill)
	input_handler.ShowSlavePanel(input_handler.scene_character)

func repeat():
	input_handler.repeat_social_skill()
	input_handler.slave_panel_node.open(null)

func recruit():
	if state.characters.size() >= state.get_pop_cap():
		if state.get_pop_cap() < variables.max_population_cap:
			input_handler.SystemMessage("You don't have enough rooms")
		else:
			input_handler.SystemMessage("Population limit reached")
		return
	var person = input_handler.scene_character
	state.add_slave(person)
	if variables.instant_travel == false:
		person.travel_target = {area = '', location = 'mansion'}
		person.travel_time = input_handler.active_area.travel_time + input_handler.active_location.travel_time
		person.location = 'travel'
	else:
		person.location = 'mansion'
	
	close()

func create_location_recruit(args):
	var newchar = Slave.new()
	input_handler.scene_character = newchar
	newchar.generate_random_character_from_data(input_handler.active_location.races)
	$RichTextLabel.bbcode_text = newchar.translate($RichTextLabel.bbcode_text)

func execute():
	close()

func inspect_scene_character():
	input_handler.ShowSlavePanel(input_handler.scene_character)

func inspect_character_child():
	input_handler.ShowSlavePanel(state.babies[input_handler.scene_character.pregnancy.baby])

func keepbaby():
	var node = input_handler.GetTextEditNode()
	var person = state.babies[input_handler.scene_character.pregnancy.baby]
	person.get_random_name()
	node.open(self, 'set_baby_name', person.name)

func removebaby():
	close()
	state.babies.erase(input_handler.scene_character.pregnancy.baby)
	input_handler.scene_character.pregnancy.baby = null

func set_baby_name(text):
	var person = state.babies[input_handler.scene_character.pregnancy.baby]
	person.name = text
	person.surname = input_handler.scene_character.surname
	state.add_slave(person)
	close()

func open_chest():
	var chest = world_gen.make_chest_loot(input_handler.active_location)

func good_event():
	var eventlist = input_handler.active_location.events
	var array = []
	for i in eventlist:
		if scenedata.scenedict[i[0]].has('tags') && scenedata.scenedict[i[0]].tags.has('good'):
			array.append(i)
	
	if array.size() == 0:
		print("no correct good event: " + input_handler.active_location.events)
		return
	var event = input_handler.weightedrandom(array)
	var eventtype = "event_selection"
	if scenedata.scenedict[event].has("default_event_type"):
		eventtype = scenedata.scenedict[event].default_event_type
	var dict = {}
	if scenedata.scenedict[event].has('bonus_args'):
		dict = scenedata.scenedict[event].bonus_args
	input_handler.interactive_message(event, eventtype, dict)

func evil_event():
	pass

func leave():
	close()