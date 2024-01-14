extends TextureRect

var selected_item = null
var selected_enchants = {}
var selected_curse = 'no'

func _ready():
	$Back.connect("pressed", self, 'close')
	$EnchantPanel/Curse1.connect("pressed", self, 'add_curse_minor')
	$EnchantPanel/Curse2.connect("pressed", self, 'add_curse_major')
	$EnchantPanel/Apply.connect('pressed', self, 'apply_selection')
	globals.connecttexttooltip($Tooltip, tr("TOOLTIPENCHANTSCREEN"))


func open():
#	gui_controller.current_screen = self
	if !gui_controller.windows_opened.has(self):
		gui_controller.windows_opened.append(self)
	selected_item = null
	build_item_list()
	build_item()
	show()
	ResourceScripts.core_animations.UnfadeAnimation(self, 0.2)


func close():
	gui_controller.windows_opened.erase(self)
	ResourceScripts.core_animations.FadeAnimation(self, 0.2)
	hide()
	get_parent().update()


func build_item_list():
	input_handler.ClearContainer($ItemList/ItemScroll/Items, ['Button'])
	for id in ResourceScripts.game_res.items:
		var item = ResourceScripts.game_res.items[id]
		if !item.tags.has('enchantable'):
			continue
		var panel = input_handler.DuplicateContainerTemplate($ItemList/ItemScroll/Items, 'Button')
		panel.connect('pressed', self, 'select_item', [id])
		item.set_icon(panel.get_node('Icon'))
		panel.pressed = selected_item == id


func select_item(id):
	selected_item = id
	selected_enchants.clear()
	build_item_list()
	build_item()


func build_item():
	if selected_item == null:
		$EnchantPanel.visible = false
	else:
		$EnchantPanel.visible = true
		var item = ResourceScripts.game_res.items[selected_item]
		build_item_description()
		build_enchantment_list()
		build_curses()
		#2add


func build_curses():
	var item = ResourceScripts.game_res.items[selected_item]
	if item.curse != null:
		$EnchantPanel/Curse1.disabled = true
		$EnchantPanel/Curse2.disabled = true
		selected_curse = 'no'
	else:
		$EnchantPanel/Curse1.disabled = false
		$EnchantPanel/Curse2.disabled = false
	
	$EnchantPanel/Curse1.pressed = (selected_curse == 'minor')
	$EnchantPanel/Curse2.pressed = (selected_curse == 'major')


func add_curse_minor():
	if selected_curse == 'minor':
		selected_curse = 'no'
	else:
		selected_curse = 'minor'
	build_item()


func add_curse_major():
	if selected_curse == 'major':
		selected_curse = 'no'
	else:
		selected_curse = 'major'
	build_item()


func build_ench_panel(panel):
	if !panel.has_meta('id'):
		return
	var id = panel.get_meta('id')
	var enchdata = Items.enchantments[id] 
	var item = ResourceScripts.game_res.items[selected_item]
	panel.get_node('Label').text = enchdata.name
	panel.get_node('icon').texture = enchdata.icon
	globals.connecttexttooltip(panel, enchdata.descript)
#	if item.enchants.has(id):
	if selected_enchants.has(id):
		var value = selected_enchants[id]
		panel.get_node('Lvl').text = str(value)
		if enchdata.levels.has(value + 1):
			panel.get_node('Rarr').visible = true
			var cost = enchdata.levels[value + 1].cap_cost - enchdata.levels[value].cap_cost
			panel.get_node('Rarr').disabled = (cost > titem.get_e_capacity())
			globals.connecttexttooltip(panel.get_node('Rarr'), "Capacity -%d" % cost )
		else:
			panel.get_node('Rarr').visible = false
		if item.enchants.has(id):
			if item.enchants[id] < value:
				panel.get_node('Larr').visible = true
				var cost
				if value > 1:
					cost = enchdata.levels[value].cap_cost - enchdata.levels[value - 1].cap_cost
				else:
					cost = enchdata.levels[value].cap_cost
					globals.connecttexttooltip(panel.get_node('Larr'), "Capacity +%d" % cost )
			else:
				panel.get_node('Larr').visible = false
		else:
			panel.get_node('Larr').visible = true
			var cost
			if value > 1:
				cost = enchdata.levels[value].cap_cost - enchdata.levels[value - 1].cap_cost
			else:
				cost = enchdata.levels[value].cap_cost
			globals.connecttexttooltip(panel.get_node('Larr'), "Capacity +%d" % cost )
	elif item.enchants.has(id):
		var value = item.enchants[id]
		selected_enchants[id] = value
		panel.get_node('Lvl').text = str(value)
		if enchdata.levels.has(value + 1):
			panel.get_node('Rarr').visible = true
			var cost = enchdata.levels[value + 1].cap_cost - enchdata.levels[value].cap_cost
			panel.get_node('Rarr').disabled = (cost > titem.get_e_capacity())
			globals.connecttexttooltip(panel.get_node('Rarr'), "Capacity -%d" % cost )
		else:
			panel.get_node('Rarr').visible = false
		panel.get_node('Larr').visible = false
	else:
		panel.get_node('Lvl').text = str(0)
		panel.get_node('Rarr').visible = true
		var cost = enchdata.levels[1].cap_cost
		panel.get_node('Rarr').disabled = (cost > titem.get_e_capacity())
		globals.connecttexttooltip(panel.get_node('Rarr'), "Capacity -%d" % cost )
		panel.get_node('Larr').visible = false


func build_enchantment_list():
	var item = ResourceScripts.game_res.items[selected_item]
	input_handler.ClearContainer($EnchantPanel/VBoxContainer, ['Button'])
	for id in Items.enchantments:
		var enchdata = Items.enchantments[id]
		if enchdata.has('reqs') and !item.check_reqs(enchdata.reqs):
			continue
		var newpanel = input_handler.DuplicateContainerTemplate($EnchantPanel/VBoxContainer, 'Button')
		newpanel.set_meta('id', id)
		newpanel.get_node('Larr').connect('pressed', self, 'change_enchant', [id, -1])
		newpanel.get_node('Rarr').connect('pressed', self, 'change_enchant', [id, 1])
		build_ench_panel(newpanel)
#	if item.curse != null:
#		$EnchantPanel/Curse1.disabled = true
#		$EnchantPanel/Curse2.disabled = true
#	else:
#		$EnchantPanel/Curse1.disabled = false
#		$EnchantPanel/Curse2.disabled = false


func build_item_panel(panel, item):
	panel.get_node('name').text = item.name
	item.set_icon(panel.get_node('icon'))
	input_handler.ClearContainer(panel.get_node('stats'), ['line', 'line2'])
	var enc_cap = input_handler.DuplicateContainerTemplate(panel.get_node('stats'), 'line')
	enc_cap.get_node('name').text = 'Enchant Capacity:'
	enc_cap.get_node('value').text = '%d/%d' % [item.get_e_capacity(), item.get_e_capacity_max()] #shows free cap, not used
	var quality = input_handler.DuplicateContainerTemplate(panel.get_node('stats'), 'line')
	quality.get_node('name').text = 'Quality:'
	quality.get_node('value').text = tr("QUALITY"+item.quality.to_upper())
	var stats_text = input_handler.DuplicateContainerTemplate(panel.get_node('stats'), 'line2')
	stats_text.bbcode_text = globals.TextEncoder(globals.build_desc_for_bonusstats(item.bonusstats))
	
	var curse_text = input_handler.DuplicateContainerTemplate(panel.get_node('stats'), 'line2')
	var text = ""
	if item.curse == null:
		pass
		#text += 'no'
	else:
		text = "Curse: "
		if item.curse_known:
			var cursedata = Items.curses[item.curse]
			text += cursedata.name
		elif item.curse.ends_with('minor'):
			text += 'unknown minor'
		elif item.curse.ends_with('major'):
			text += 'unknown major'
	curse_text.bbcode_text = text
	for id in item.enchants:
		var ench_text = input_handler.DuplicateContainerTemplate(panel.get_node('stats'), 'line2')
		ench_text.bbcode_text = "%s lv %d" % [tr(Items.enchantments[id].name), item.enchants[id]]
	#free 2add other descriptions


var titem
func build_item_description():
	var item = ResourceScripts.game_res.items[selected_item]
	build_item_panel($EnchantPanel/Weapon1, item)
	
	titem = item.clone()
	if selected_curse != 'no':
		titem.add_curse('stub_' + selected_curse)
	for ench in selected_enchants:
		titem.add_enchant(ench, selected_enchants[ench], true)
	build_item_panel($EnchantPanel/Weapon2, titem)
	
	var goldcost = 0
	for ench in selected_enchants:
		var enchdata = Items.enchantments[ench]
		if !item.enchants.has(ench) or selected_enchants[ench] > item.enchants[ench]:
			goldcost += enchdata.levels[selected_enchants[ench]].gold_cost
	$EnchantPanel/cost.text = "%d/%d" % [goldcost, ResourceScripts.game_res.money]
	
	if goldcost > ResourceScripts.game_res.money or titem.get_e_capacity() < 0:
		$EnchantPanel/Apply.disabled = true
	else:
		$EnchantPanel/Apply.disabled = false


func change_enchant(id, value):
	if selected_enchants.has(id):
		selected_enchants[id] += value
		if selected_enchants[id] == 0:
			selected_enchants.erase(id)
	else:
		if value == -1:
			print ('error - decreasing zero enchant level')
			return
		selected_enchants[id] = 1
	
	build_item_description()
	
	for panel in $EnchantPanel/VBoxContainer.get_children():
		if panel.has_meta('id'):# and panel.get_meta('id') == id:
			build_ench_panel(panel)


func apply_selection():
	var item = ResourceScripts.game_res.items[selected_item]
	if selected_curse != 'no':
		item.apply_random_curse(selected_curse)
	for ench in selected_enchants:
		item.add_enchant(ench, selected_enchants[ench])
	build_item()
