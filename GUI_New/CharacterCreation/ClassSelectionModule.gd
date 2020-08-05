extends Panel

var class_array = []

func _ready():
	$ConfirmButton.connect("pressed", self, "select_class")
	$CancelButton.connect("pressed", self, "cancel_class_selection")


func open_class_list():
	var person = get_parent().person
	show()
	# $ClassPanel.show()
	if get_parent().mode == 'master':
		class_array = variables.master_starting_classes
	elif get_parent().mode == 'slave':
		if get_parent().guild == 'none':
			class_array = variables.slave_starting_classes
		else:
			class_array = variables.get(get_parent().guild+'_starting_classes')
	update_class_buttons()
	# for i in array:
	# 	var tempclass = classesdata.professions[i]
	# 	if person.checkreqs(tempclass.showupreqs) == false:
	# 		continue
	# 	var newbutton = input_handler.DuplicateContainerTemplate($ClassPanel/ScrollContainer/VBoxContainer)
	# 	newbutton.get_node("icon").texture = tempclass.icon
	# 	newbutton.get_node("name").text = tempclass.name
	# 	var text = ResourceScripts.descriptions.get_class_details(person, tempclass, true, true)
	# 	newbutton.connect('pressed', self, "show_class_info", [text, tempclass, person])
	# 	newbutton.set_meta('class', tempclass.code)
	# 	# newbutton.connect('pressed', self, "select_class", [tempclass.code])
	# 	# newbutton.connect('signal_RMB_release',input_handler,'show_class_info', [tempclass.code, person])
	# 	# globals.connecttexttooltip(newbutton, text)
	# 	var reqs_text = ""
	# 	for i in tempclass.reqs:
	# 		reqs_text += str(statdata.statdata[i.stat].abb) + ":" + str(i.value)
	# 	newbutton.get_node("Reqs").text = reqs_text
	# 	newbutton.disabled = !person.checkreqs(tempclass.reqs)
	input_handler.active_character = person
	update_pressed_buttons()

func update_class_buttons():
	input_handler.ClearContainer($ClassPanel/ScrollContainer/VBoxContainer)
	var person = get_parent().person
	for i in class_array:
		var tempclass = classesdata.professions[i]
		if !person.checkreqs(tempclass.showupreqs):
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($ClassPanel/ScrollContainer/VBoxContainer)
		newbutton.get_node("icon").texture = tempclass.icon
		newbutton.get_node("name").text = tempclass.name
		var text = ResourceScripts.descriptions.get_class_details(person, tempclass, true, true)
		newbutton.connect('pressed', self, "show_class_info", [text, tempclass, person])
		newbutton.set_meta('class', tempclass.code)
		# newbutton.connect('pressed', self, "select_class", [tempclass.code])
		# newbutton.connect('signal_RMB_release',input_handler,'show_class_info', [tempclass.code, person])
		# globals.connecttexttooltip(newbutton, text)
		newbutton.get_node("ReqsLabel").visible = (tempclass.reqs != [])
		var reqs_text = ""
		var req_value = ""
		for req in tempclass.reqs:
			reqs_text += "{color=k_yellow|" + str(statdata.statdata[req.stat].abb) + " - " + "}"
			if req.value > person.get_stat(req.stat):
				req_value += "{color=k_red|" + str(req.value) + "}"
			else:
				req_value += "{color=k_green|" + str(req.value) + "}"
		reqs_text += req_value
		newbutton.get_node("Reqs").bbcode_text = globals.TextEncoder(reqs_text)
		newbutton.disabled = !person.checkreqs(tempclass.reqs)
	update_pressed_buttons()


func update_pressed_buttons():
	for i in $ClassPanel/ScrollContainer/VBoxContainer.get_children():
		if i.has_meta('class'):
			i.pressed = get_parent().selected_class == i.get_meta('class')

func show_class_info(text, tempclass, person):
	get_parent().selected_class = tempclass.code
	# text += input_handler.show_class_info(tempclass.code, person)
	$ClassPanel/ClassDescript.bbcode_text = person.translate(text)
	update_pressed_buttons()


func cancel_class_selection():
	get_parent().selected_class = ''
	hide()


func select_class():
	hide()
	get_parent().rebuild_slave()
	get_parent().check_confirm_possibility()



