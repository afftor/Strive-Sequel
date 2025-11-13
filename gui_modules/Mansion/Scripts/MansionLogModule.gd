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
	for btn in ResourceScripts.game_globals.log_btns:
		if has_node(btn):
			get_node(btn).pressed = true
	change_filter()

func change_filter():
	var pressed_btns = ResourceScripts.game_globals.log_btns
	pressed_btns.clear()
	filter.clear()
	for btn in ['travel', 'mansion', 'quest', 'char']:
		if get_node(btn).pressed:
			if btn == 'mansion':
				filter.append_array(['work', 'money', 'crafting'])
			filter.append(btn)
			pressed_btns.append(btn)
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

