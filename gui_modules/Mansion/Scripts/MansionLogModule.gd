extends Panel

var filter = []

func _ready():
	$travel.connect("pressed", self, "change_filter")
	$mansion.connect("pressed", self, "change_filter")
	$quest.connect("pressed", self, "change_filter")
	$char.connect("pressed", self, "change_filter")
	globals.connecttexttooltip($mansion, tr('LOGMANSIONTOOLTIP'))
	globals.connecttexttooltip($travel, tr('LOGTRAVELTOOLTIP'))
	globals.connecttexttooltip($quest, tr('LOGQUESTTOOLTIP'))
	globals.connecttexttooltip($char, tr('LOGCHARTOOLTIP'))
	change_filter()


func change_filter(): #2fix later with adding new buttons
	filter.clear()
	if $travel.pressed:
		input_handler.append_not_duplicate(filter, 'travel')
	else:
		filter.erase('travel')
	if $mansion.pressed:
		input_handler.append_not_duplicate(filter, 'work')
		input_handler.append_not_duplicate(filter, 'money')
		input_handler.append_not_duplicate(filter, 'crafting')
		input_handler.append_not_duplicate(filter, 'mansion')
	else:
		filter.erase('work')
		filter.erase('money')
		filter.erase('crafting')
		filter.erase('mansion')
	if $quest.pressed:
		input_handler.append_not_duplicate(filter, 'quest')
	else:
		filter.erase('quest')
	if $char.pressed:
		input_handler.append_not_duplicate(filter, 'char')
	else:
		filter.erase('char')
	update_log()


func clear_log():
	for nd in $ScrollContainer/VBoxContainer.get_children():
		if !nd.has_meta('type'):
			continue
		nd.queue_free()


func add_log_message(data):
	var newfield = $ScrollContainer/VBoxContainer/field.duplicate()
	newfield.visible = filter.has(data.type)
	newfield.set_meta('type', data.type)
	newfield.get_node("label").bbcode_text = tr(data.type.to_upper() + '_LABEL')
	newfield.get_node("text").bbcode_text = data.text
	newfield.get_node("date").bbcode_text = "[right]W %d D %d - %s[/right]" % [(data.date -1) / 7 + 1, (data.date - 1) % 7 + 1, tr(variables.timeword[data.hour])]
	$ScrollContainer/VBoxContainer.add_child(newfield)
#	yield(get_tree(), 'idle_frame')
#	var textfield = newfield.get_node('text')
#	textfield.rect_size.y = textfield.get_v_scroll().get_max()
#	newfield.rect_min_size.y = textfield.rect_size.y


func update_log():
	for nd in $ScrollContainer/VBoxContainer.get_children():
		if !nd.has_meta('type'):
			continue
		nd.visible = filter.has(nd.get_meta('type'))

