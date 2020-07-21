extends Panel

func _ready():
	$ConfirmButton.connect("pressed", self, "select_class")
	$CancelButton.connect("pressed", self, "cancel_class_selection")


func open_class_list():
	var person = get_parent().person
	show()
	# $ClassPanel.show()
	input_handler.ClearContainer($ClassPanel/ScrollContainer/VBoxContainer)
	var array
	if get_parent().mode == 'master':
		array = variables.master_starting_classes
	elif get_parent().mode == 'slave':
		if get_parent().guild == 'none':
			array = variables.slave_starting_classes
		else:
			array = variables.get(get_parent().guild+'_starting_classes')
	for i in array:
		var tempclass = classesdata.professions[i]
		if person.checkreqs(tempclass.showupreqs) == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($ClassPanel/ScrollContainer/VBoxContainer)
		newbutton.get_node("icon").texture = tempclass.icon
		newbutton.get_node("name").text = tempclass.name
		var text = ResourceScripts.descriptions.get_class_details(person, tempclass, true, true)
		newbutton.connect('pressed', self, "show_class_info", [text, tempclass, person])
		# newbutton.connect('pressed', self, "select_class", [tempclass.code])
		# newbutton.connect('signal_RMB_release',input_handler,'show_class_info', [tempclass.code, person])
		# globals.connecttexttooltip(newbutton, text)
		if person.checkreqs(tempclass.reqs) == false:
			newbutton.disabled = true
	input_handler.active_character = person


func show_class_info(text, tempclass, person):
	get_parent().selected_class = tempclass.code
	# text += input_handler.show_class_info(tempclass.code, person)
	$ClassPanel/ClassDescript.bbcode_text = text


func cancel_class_selection():
	get_parent().selected_class = ''
	hide()


func select_class():
	hide()
	get_parent().rebuild_slave()
	get_parent().check_confirm_possibility()



