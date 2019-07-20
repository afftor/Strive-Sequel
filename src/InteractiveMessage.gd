extends Panel

var operation_data

func open(scene):
	show()
	$RichTextLabel.bbcode_text = scene.text
	globals.ClearContainer($VBoxContainer)
	for i in scene.options:
		var newbutton = globals.DuplicateContainerTemplate($VBoxContainer)
		newbutton.text = i.text
		newbutton.connect("pressed", self, i.code)
		if i.has('disabled') && i.disabled == true:
			newbutton.disabled = true

func close():
	hide()
	input_handler.emit_signal("EventFinished")

func repeat():
	input_handler.repeat_social_skill()
	input_handler.slave_panel_node.open(null)

func recruit():
	var person = input_handler.scene_character
	state.add_slave(person)
	if variables.instant_travel == false:
		person.travel_target = {area = '', location = 'mansion'}
		person.travel_time = input_handler.active_area.travel_time + input_handler.active_location.travel_time
		person.location = 'travel'
	else:
		person.location = 'mansion'
	
	close()

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

func open_chest_easy():
	var chest = world_gen.make_chest_loot(input_handler.active_location)

func leave():
	close()