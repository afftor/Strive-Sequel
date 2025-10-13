extends tooltip_main


onready var iconnode = $TopPanel/IconFrame/Icon
onready var textnode1 = $MidPanel/InfoText
onready var textnode2 = $LowPanel/InfoText

var currentdata
var currenttype
var mode = 'default'

var full_height = 0

func _init():
	init_timer = 0.01


func _input(event):
	if state != STATE_OPEN:
		return
	if event.is_pressed():
		if event.is_action("shift"):
			mode = 'advanced'
			update()
	elif event.is_action_released("shift"):
		mode = 'default'
		update()


func showup(node, data, type): #types material materialowned gear geartemplate
	if node == null:
		return
	if _setup(node):
		currentdata = data
		currenttype = type


func update():
	visible = false
	$TopPanel/IconFrame/quality_color.hide()
	
	var screen = get_viewport().get_visible_rect()
	iconnode.material = null
	$LowPanel/HBoxContainer/HoldShift.visible = false
	match currenttype:
		'material':
			material_tooltip(currentdata)
		'materialowned':
			var workers_data = {}
			$LowPanel/HBoxContainer/HoldShift.visible = true
			$LowPanel/HBoxContainer/HoldShift.text = tr('OWNED_LABEL') + ': ' + str(currentdata.amount)
			if parentnode.has_meta("max_workers"):
				workers_data = {
					max = parentnode.get_meta("max_workers"),
					current = parentnode.get_meta("current_workers"),
				}
			if parentnode.has_meta("gather_mod"):
				workers_data = {
					gather_mod = parentnode.get_meta("gather_mod"),
				}
			material_tooltip(currentdata, workers_data)
		'gear':
			if mode == 'default':
				gear_tooltip(currentdata)
				$LowPanel/HBoxContainer/HoldShift.visible = true
				$LowPanel/HBoxContainer/HoldShift.text = tr("INFOHOLDSHIFT")
			elif mode == 'advanced':
				$LowPanel/HBoxContainer/HoldShift.visible = false
				gear_detailed_tooltip(currentdata)
		'geartemplate':
			geartemplete_tooltip(currentdata)
	
	input_handler.GetTweenNode(self).stop_all()
	self.modulate.a = 1
	
	yield(fix_panels(), 'completed')
	visible = true
	var pos = parentnode.get_global_rect()
	if parentnode.has_meta("exploration"):
		pos = Vector2(pos.end.x + 10, pos.position.y - 30)
	else:
		pos = Vector2(pos.end.x + 10, pos.position.y)
	self.set_global_position(pos)
	
	if get_global_rect().end.x > screen.size.x:
		if parentnode.has_meta("exploration") || currenttype == "gear":
			pos = Vector2(pos.x - rect_size.x - parentnode.rect_size.x - 10, pos.y)
			self.set_global_position(pos)
		else:
			pos = Vector2(pos.x + screen.size.x - get_global_rect().end.x, pos.y)
			self.set_global_position(pos)
	
#	if get_global_rect().end.y > screen.size.y:
#		pos = Vector2(pos.x, pos.y - get_global_rect().end.y + screen.size.y)
#		self.set_global_position(pos)
	if pos.y + full_height > screen.size.y:
		pos = Vector2(pos.x, screen.size.y - full_height - 15)
		self.set_global_position(pos)
	emit_signal("update_completed")




func material_tooltip(data, workers_data = {}):
	var item = data.item
	var text = data.text
	$TopPanel/Title.text = tr("MATERIAL" + str(item.code).to_upper())
	var new_font = input_handler.font_size_calculator($TopPanel/Title)
	$TopPanel/Title.set("custom_fonts/font", new_font)
	if ResourceScripts.game_res.materials.has(data.item) && ResourceScripts.game_res.materials[data.item] > 0: #does not work in inventory, huh?
		text += "\n\n" + tr("CURRENTLYINPOSSESSION") + ": " + str(ResourceScripts.game_res.materials[data.item])
	if workers_data.has("max"):
		text += "\n" + tr("MAX_WORKERS_LABEL") + ": " + str(workers_data.max)
		text += "\n" + tr("CURRENT_WORKERS_LABEL") + ": " + str(workers_data.current)
	if workers_data.has("gather_mod"):
		text += "\n" + tr("GATHERING_MOD_LABEL") + ": " + str(workers_data.gather_mod) + "%"
#	if data.has('amount'):
#		text += "\nOwned: " + str(data.amount)
	iconnode.texture = item.icon
	build_price(item.price)
	textnode2.bbcode_text = globals.TextEncoder(text)
	
	
	$LowPanel.show()
	$MidPanel.hide()
#	fix_panels()


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
	var new_font = input_handler.font_size_calculator($TopPanel/Title)
	$TopPanel/Title.set("custom_fonts/font", new_font)
	if item == null:
		item = data.item
	var text1 = item.tooltiptext_1()
	var text2 = item.tooltiptext_2()
	build_price(data.price)
	if item.quality != '':
		$TopPanel/IconFrame/quality_color.show()
		$TopPanel/IconFrame/quality_color.texture = variables.quality_colors[item.quality]
	$LowPanel/HBoxContainer/HoldShift.visible = item.get('partcolororder') != null
	if item.get('partcolororder') != null:
		input_handler.itemshadeimage(iconnode, item)
	else:
		iconnode.texture = input_handler.loadimage(item.icon, 'icons')

	textnode1.bbcode_text = text1
	textnode2.bbcode_text = text2
	$MidPanel.show()
	$LowPanel.show()
#	fix_panels()


func gear_detailed_tooltip(data, item = null):
	gear_tooltip(data, item)
	item = data.item
	if item.parts.size() == 0:
		return
	$TopPanel/Title.text = data.item.name
	var new_font = input_handler.font_size_calculator($TopPanel/Title)
	$TopPanel/Title.set("custom_fonts/font", new_font)
	var text = ''
	for i in item.parts:
		var material = Items.materiallist[item.parts[i]]
		text += tr(Items.Parts[i].name) + ": {color=yellow|" + material.name +"}\n"
		text += globals.build_desc_for_bonusstats(material.parts[i])
#		text += '\n\n'
	for i in item.enchants:
		text += "{color=yellow|%s}: %s\n" % [tr(Items.enchantments[i].name), tr(Items.enchantments[i].descript)]
	if item.curse != null:
		if !item.curse_known:
			text += "{color=red|Unknown curse}\n"
		else:
			text += "{color=red|%s}: %s\n" % [tr(Items.curses[item.curse].name), tr(Items.curses[item.curse].descript)]
		
	textnode2.bbcode_text = globals.TextEncoder(text)
#	$LowPanel/HBoxContainer/HoldShift.visible = true

	$LowPanel.show()
	$MidPanel.hide()
#	fix_panels()


func geartemplete_tooltip(data):
	$TopPanel/Title.text = data.item.name
	var new_font = input_handler.font_size_calculator($TopPanel/Title)
	$TopPanel/Title.set("custom_fonts/font", new_font)
	var item = data.item
	var text = '[center]' + item.name + '[/center]\n'

	if item.has('geartype'):
		text += tr('TYPE_LABEL') + ': ' + item.geartype + "\n"
		if item.slots.size() > 0:
			text += tr('SLOTS_LABEL') + ': '
			for i in item.slots:
				text += tr("ITEMSLOT"+i.to_upper()) + ", "
			text = text.substr(0, text.length() -2) + ". \n"
	else:
		text += tr("TYPE_USABLE_LABEL") + "\n"

	text += item.descript

	if item.itemtype in ['armor','weapon','tool']:
		text += "\n\n"
		text += globals.build_desc_for_bonusstats(item.basestats)

	for i in item.effects:
		if Effectdata.effect_table[i].has('descript'):
			text += "\n" + tr(Effectdata.effect_table[i].descript)

	iconnode.texture = item.icon
	
	
	if item.get('partcolororder') != null:
		input_handler.itemshadeimage(iconnode, item)
		$LowPanel/HBoxContainer/HoldShift.text = tr('INFOHOLDSHIFT')
		$LowPanel/HBoxContainer/HoldShift.visible = true
#		text += "\n\n{color=yellow|Hold shift for details}"

	build_price(data.price)
	textnode2.bbcode_text = globals.TextEncoder(text)

	$LowPanel.show()
	$MidPanel.hide()
#	fix_panels()

func fix_panels():
	yield(get_tree(), 'idle_frame')
	full_height = $TopPanel.rect_size.y
	$MidPanel.rect_min_size.y = max(textnode1.get_content_height() + 18, 100)
	if $MidPanel.visible:
		full_height += $MidPanel.rect_min_size.y
	$LowPanel.rect_min_size.y = max(textnode2.get_content_height() + 63, 200)
	if $LowPanel.visible:
		full_height += $LowPanel.rect_min_size.y
