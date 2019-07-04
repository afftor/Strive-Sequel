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