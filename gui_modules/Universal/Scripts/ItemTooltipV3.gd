extends VBoxContainer

var parentnode
var shutoff = false
var prevnode
onready var iconnode = $TopPanel/IconFrame/Icon
onready var textnode1 = $MidPanel/InfoText
onready var textnode2 = $LowPanel/InfoText

var currentdata
var currenttype
var mode = 'default'

func _process(delta):
	if weakref(parentnode).get_ref() == null || weakref(parentnode) == null:
		_hide()
		return
	if parentnode != null && (parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
		set_process(false)
		_hide()


func _input(event):
	if event.is_pressed():
		if event.is_action("shift"):
			mode = 'advanced'
			update()
	elif event.is_action_released("shift"):
		mode = 'default'
		update()


func _init():
	set_process(false)


func update():
	showup(parentnode, currentdata, currenttype)


func cooldown():
	shutoff = true
	yield(get_tree().create_timer(0.2), 'timeout')
	shutoff = false


func _hide():
	parentnode = null
	set_process(false)
	ResourceScripts.core_animations.FadeAnimation(self, 0.2)
	hide()


func showup(node, data, type): #types material materialowned gear geartemplate
	if node == null:
		return
	parentnode = node
	currentdata = data
	currenttype = type
	
	var screen = get_viewport().get_visible_rect()
	if shutoff == true && prevnode == parentnode:
		return
	
	iconnode.material = null
	match type:
		'material':
			material_tooltip(data)
		'materialowned':
			var workers_data = {}
			if node.has_meta("max_workers"):
				workers_data = {
					max = node.get_meta("max_workers"),
					current = node.get_meta("current_workers"),
				}
			if node.has_meta("gather_mod"):
				workers_data = {
					gather_mod = node.get_meta("gather_mod"),
				}
			material_tooltip(data, workers_data)
		'gear':
			if mode == 'default':
				gear_tooltip(data)
			elif mode == 'advanced':
				gear_detailed_tooltip(data)
		'geartemplate':
			geartemplete_tooltip(data)
	prevnode = parentnode
	
	input_handler.GetTweenNode(self).stop_all()
	self.modulate.a = 1
	
	show()
	
	var pos = node.get_global_rect()
	if node.has_meta("exploration"):
		pos = Vector2(pos.end.x + 10, pos.position.y - 30)
	else:
		pos = Vector2(pos.end.x + 10, pos.position.y)
	self.set_global_position(pos)
	
	if get_rect().end.x > screen.size.x:
		if node.has_meta("exploration") || type == "gear":
			pos = Vector2(pos.x - rect_size.x - node.rect_size.x - 10, pos.y)
			self.set_global_position(pos)
		else:
			rect_global_position.x -= screen.size.x - get_rect().end.x
	if get_rect().end.y > screen.size.y:
		rect_global_position.y -= get_rect().end.y - screen.size.y
	
	set_process(true)


func material_tooltip(data, workers_data = {}):
	var item = data.item
	var text = data.text
	$TopPanel/Title.text = item.name
	if ResourceScripts.game_res.materials.has(data.item) && ResourceScripts.game_res.materials[data.item] > 0:
		text += "\n\n" + tr("CURRENTLYINPOSSESSION") + ": " + str(ResourceScripts.game_res.materials[data.item])
	if workers_data.has("max"):
		text += "\nMax Workers: " + str(workers_data.max)
		text += "\nCurrent Workers: " + str(workers_data.current)
	if workers_data.has("gather_mod"):
		text += "\nGathering Mod: " + str(workers_data.gather_mod) + "%"
	iconnode.texture = item.icon
	build_price(item.price)
	textnode2.bbcode_text = globals.TextEncoder(text)
	
	$LowPanel.show()
	$MidPanel.hide()
	fix_panels()


func build_price(price):
	price = int(price)
	if price == 0:
		$LowPanel/HBoxContainer/Label.visible = false
		$LowPanel/HBoxContainer/Cost.visible = false
	else:
		$LowPanel/HBoxContainer/Label.visible = true
		$LowPanel/HBoxContainer/Cost.visible = true
		$LowPanel/HBoxContainer/Label.text = str(price)


func materialowned_tooltip(data):
	material_tooltip(data)


func gear_tooltip(data, item = null):
	if data.item.type == "usable":
		self.get_stylebox("panel", "" ).set_texture(load("res://assets/Textures_v2/DisassembleNewTooltip/panel_tooltip_shift.png"))
	else:
		self.get_stylebox("panel", "" ).set_texture(load("res://assets/Textures_v2/DisassembleNewTooltip/panel_tooltip.png"))
	$TopPanel/Title.text = data.title
	if item == null:
		item = data.item
	var text1 = item.tooltiptext_1()
	var text2 = item.tooltiptext_2()
	build_price(data.price)
	
	$LowPanel/HBoxContainer/HoldShift.visible = item.get('partcolororder') != null
	if item.get('partcolororder') != null:
		input_handler.itemshadeimage(iconnode, item)
	else:
		iconnode.texture = input_handler.loadimage(item.icon, 'icons')
	
	textnode1.bbcode_text = text1
	textnode2.bbcode_text = text2
	$MidPanel.show()
	$LowPanel.show()
	fix_panels()


func gear_detailed_tooltip(data, item = null):
	gear_tooltip(data, item)
	item = data.item
	if item.parts.size() == 0:
		return
	$TopPanel/Title.text = data.item.name
	var text = ''
	for i in item.parts:
		var material = Items.materiallist[item.parts[i]]
		text += tr(Items.Parts[i].name) + ": {color=yellow|" + material.name +"}"
		for k in material.parts[i]:
			if material.parts[i][k] != 0:
				var value = material.parts[i][k]
				var change = ''
				text += '\n' + statdata.statdata[k].name + ': {color='
				match statdata.statdata[k].default_bonus:
					"add":
						if statdata.statdata[k].percent:
							value = value*100
						if value > 0:
							change = '+'
						if value > 0 and !statdata.statdata[k].is_negative or value < 0 and statdata.statdata[k].is_negative:
							text += 'green|' + change
						else:
							text += 'red|'
						value = str(value)
						if statdata.statdata[k].percent:
							value = value + '%'
					"add_part":
						value = value*100
						if value > 0:
							change = '+'
						if value > 0 and !statdata.statdata[k].is_negative or value < 0 and statdata.statdata[k].is_negative:
							text += 'green|' + change
						else:
							text += 'red|'
						value = str(value)
						value = value + '%'
					"mul":
						value = value - 1.0
						value = value*100
						if value > 0:
							change = '+'
						if value > 0 and !statdata.statdata[k].is_negative or value < 0 and statdata.statdata[k].is_negative:
							text += 'green|' + change
						else:
							text += 'red|'
						value = str(value)
						value = value + '%'
				text +=  value + '}'
		text += '\n'
	textnode2.bbcode_text = globals.TextEncoder(text)
	
	$LowPanel.show()
	$MidPanel.hide()
	fix_panels()


func geartemplete_tooltip(data):
	var item = data.item
	var text = '[center]' + item.name + '[/center]\n'
	
	if item.has('geartype'):
		text += 'Type: ' + item.geartype + "\n"
		if item.slots.size() > 0:
			text += "Slots: "
			for i in item.slots:
				text += tr("ITEMSLOT"+i.to_upper()) + ", "
			text = text.substr(0, text.length() -2) + ". \n"
	else:
		text += "Type: Usable\n"
	
	text += item.descript
	
	if item.itemtype in ['armor','weapon','tool']:
		text += "\n\n"
		for i in item.basestats:
			if item.basestats[i] != 0:
				var value = item.basestats[i]
				var change = ''
				text += '\n' + statdata.statdata[i].name + ': {color='
				match statdata.statdata[i].default_bonus:
					"add":
						if statdata.statdata[i].percent:
							value = value*100
						if value > 0:
							change = '+'
						if value > 0 and !statdata.statdata[i].is_negative or value < 0 and statdata.statdata[i].is_negative:
							text += 'green|' + change
						else:
							text += 'red|'
						value = str(value)
						if statdata.statdata[i].percent:
							value = value + '%'
					"add_part":
						value = value*100
						if value > 0:
							change = '+'
						if value > 0 and !statdata.statdata[i].is_negative or value < 0 and statdata.statdata[i].is_negative:
							text += 'green|' + change
						else:
							text += 'red|'
						value = str(value)
						value = value + '%'
					"mul":
						value = value - 1.0
						value = value*100
						if value > 0:
							change = '+'
						if value > 0 and !statdata.statdata[i].is_negative or value < 0 and statdata.statdata[i].is_negative:
							text += 'green|' + change
						else:
							text += 'red|'
						value = str(value)
						value = value + '%'
				text +=  value + '}'
				text += value + '}\n'
	
	
	for i in item.effects:
		text += Effectdata.effect_table[i].descript + "\n"
	
	iconnode.texture = item.icon
	
	if item.get('partcolororder') != null:
		input_handler.itemshadeimage(iconnode, item)
		
		text += "\n\n{color=yellow|Hold shift for details}"
	
	build_price(data.price)
	textnode2.bbcode_text = globals.TextEncoder(text)
	
	$LowPanel.show()
	$MidPanel.hide()
	fix_panels()

func fix_panels():
	yield(get_tree(), 'idle_frame')
	$MidPanel.rect_min_size.y = max(textnode1.get_content_height() + 18, 100)
	$LowPanel.rect_min_size.y = max(textnode2.get_content_height() + 63, 200)
