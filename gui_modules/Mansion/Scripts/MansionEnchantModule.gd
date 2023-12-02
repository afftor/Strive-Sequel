extends TextureRect

var selected_item = null
var selected_enchants = {}

func _ready():
	$Back.connect("pressed", self, 'hide')
	$EnchantPanel/Curse1.connect("pressed", self, 'add_curse_minor')
	$EnchantPanel/Curse2.connect("pressed", self, 'add_curse_major')
	$EnchantPanel/Apply.connect('pressed', self, 'apply_selection')


func open():
	selected_item = null
	build_item_list()
	build_item()
	show()


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
	build_item_list()
	build_item()


func build_item():
	if selected_item == null:
		$EnchantPanel.visible = false
	else:
		$EnchantPanel.visible = true
		var item = ResourceScripts.game_res.items[selected_item]
		build_enchantment_list()
		build_item_description()
		#2add


func add_curse_minor():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_curse_minor_confirm', tr('ADDCURSE')])


func add_curse_major():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_curse_major_confirm', tr('ADDCURSE')])


func add_curse_minor_confirm():
	var pool = []
	for id in Items.curses:
		if id.ends_with('_minor'):
			pool.push_back(id)
	var item = ResourceScripts.game_res.items[selected_item]
	item.add_curse(input_handler.random_from_array(pool))
	build_item()


func add_curse_major_confirm():
	var pool = []
	for id in Items.curses:
		if id.ends_with('_major'):
			pool.push_back(id)
	var item = ResourceScripts.game_res.items[selected_item]
	item.add_curse(input_handler.random_from_array(pool))
	build_item()


func build_ench_panel(panel):
	if !panel.has_meta('id'):
		return
	var id = panel.get_meta('id')
	var enchdata = Items.enchantments[id] 
	var item = ResourceScripts.game_res.items[selected_item]
	panel.get_node('Label').text = enchdata.name
#	if item.enchants.has(id):
	if selected_enchants.has(id):
		var value = selected_enchants[id]
		panel.get_node('Lvl').text = str(value)
		panel.get_node('Rarr').visible = enchdata.levels.has(value + 1)
		if item.enchants.has(id):
			panel.get_node('Larr').visible = (item.enchants[id] < value)
		else:
			panel.get_node('Larr').visible = true
	elif item.enchants.has(id):
		var value = item.enchants[id]
		selected_enchants[id] = value
		panel.get_node('Lvl').text = str(value)
		panel.get_node('Rarr').visible = enchdata.levels.has(value + 1)
		panel.get_node('Larr').visible = false
	else:
		panel.get_node('Lvl').text = str(0)
		panel.get_node('Rarr').visible = true
		panel.get_node('Larr').visible = false


func build_enchantment_list():
	selected_enchants.clear()
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
	if item.curse != null:
		$EnchantPanel/Curse1.disabled = true
		$EnchantPanel/Curse2.disabled = true
	else:
		$EnchantPanel/Curse1.disabled = false
		$EnchantPanel/Curse2.disabled = false


func build_item_panel(panel, item):
	panel.get_node('name').text = item.name
	item.set_icon(panel.get_node('icon'))
	input_handler.ClearContainer(panel.get_node('stats'), ['line', 'line2'])
	var enc_cap = input_handler.DuplicateContainerTemplate(panel.get_node('stats'), 'line')
	enc_cap.get_node('name').text = 'Enchant Capacity remains:'
	enc_cap.get_node('value').text = '%d/%d' % [item.get_e_capacity(), item.get_e_capacity_max()] #shows free cap, not used
	var quality = input_handler.DuplicateContainerTemplate(panel.get_node('stats'), 'line')
	quality.get_node('name').text = 'Quality:'
	quality.get_node('value').text = item.quality
	var stats_text = input_handler.DuplicateContainerTemplate(panel.get_node('stats'), 'line2')
	stats_text.bbcode_text = globals.TextEncoder(globals.build_desc_for_bonusstats(item.bonusstats))
	#free 2add other descriptions


func build_item_description():
	var item = ResourceScripts.game_res.items[selected_item]
	build_item_panel($EnchantPanel/Weapon1, item)
	
	var titem = item.clone()
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
	
	for panel in $EnchantPanel/VBoxContainer.get_children():
		if panel.has_meta('id') and panel.get_meta('id') == id:
			build_ench_panel(panel)
	
	build_item_description()


func apply_selection():
	var item = ResourceScripts.game_res.items[selected_item]
	for ench in selected_enchants:
		item.add_enchant(ench, selected_enchants[ench])
	build_item()
