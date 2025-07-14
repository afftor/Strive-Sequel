extends Panel

var filter = []

func _ready():
	$left.connect("pressed", self, "change_filter")
	$right.connect("pressed", self, "change_filter")
	globals.connecttexttooltip($left, tr('LOGLEFTTTOOLTIP'))
	globals.connecttexttooltip($right, tr('LOGRIGHTTOOLTIP'))
	change_filter()


func change_filter(): #2fix later with adding new buttons
	filter.clear()
	if $left.pressed:
		input_handler.append_not_duplicate(filter, 'class')
		input_handler.append_not_duplicate(filter, 'char')
		input_handler.append_not_duplicate(filter, 'quest')
		input_handler.append_not_duplicate(filter, 'travel')
		input_handler.append_not_duplicate(filter, 'skill')
		input_handler.append_not_duplicate(filter, 'work')
		input_handler.append_not_duplicate(filter, 'food')
		input_handler.append_not_duplicate(filter, 'money')
		input_handler.append_not_duplicate(filter, 'dungeon')
		input_handler.append_not_duplicate(filter, 'materials')
		input_handler.append_not_duplicate(filter, 'crafting')
		input_handler.append_not_duplicate(filter, 'upgrades')
		input_handler.append_not_duplicate(filter, 'slaves')
	else:
		filter.erase('class')
		filter.erase('char')
		filter.erase('quest')
		filter.erase('travel')
		filter.erase('skill')
		filter.erase('work')
		filter.erase('food')
		filter.erase('money')
		filter.erase('dungeon')
		filter.erase('materials')
		filter.erase('crafting')
		filter.erase('upgrades')
		filter.erase('slaves')
	if $right.pressed:
		input_handler.append_not_duplicate(filter, 'brothel')
	else:
		filter.erase('brothel')
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
	newfield.get_node("label").bbcode_text = (data.type.to_upper() + '_LABEL')
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

