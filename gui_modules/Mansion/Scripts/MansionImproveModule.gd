extends TextureRect

var selected_item = null
var selected_fuse_items = {}

var req_amount = 0
var req_quality = 'poor'
var req_itembase = null

onready var fuse_list = $EnchantPanel/SelectScroll/Items
onready var item_list = $ItemList/ItemScroll/Items

func _ready():
	$Back.connect("pressed", self, 'close')
	$EnchantPanel/Apply.connect('pressed', self, 'apply_selection')
	$EnchantPanel/reset.connect('pressed', self, 'select_item')
	$Mode.connect("pressed", self, 'change_mode')
	
	globals.connecttexttooltip($Tooltip, tr("TOOLTIPIMPROVESCREEN"))


func open():
#	gui_controller.current_screen = self
	if !gui_controller.windows_opened.has(self):
		gui_controller.windows_opened.append(self)
	selected_item = null
	build_item_list()
	build_item()
	build_hint()
	show()
	ResourceScripts.core_animations.UnfadeAnimation(self, 0.2)


func close():
	gui_controller.windows_opened.erase(self)
	ResourceScripts.core_animations.FadeAnimation(self, 0.2)
	hide()
	get_parent().update()


func build_item_list():
	input_handler.ClearContainer(item_list, ['Button'])
	for id in ResourceScripts.game_res.items:
		var item = ResourceScripts.game_res.items[id]
		if item.type != 'gear':
			continue
		if item.tags.has('recipe'):
			continue
		if !Items.fixed_quality_stats.has(item.itembase):
			continue
		if item.quality == 'legendary':
			continue
		var panel = input_handler.DuplicateContainerTemplate(item_list, 'Button')
		panel.connect('pressed', self, 'select_item', [id])
		item.set_icon(panel.get_node('Icon'))
		panel.pressed = selected_item == id
		if item.owner != null:
			panel.get_node("WornIcon").show()
			globals.connecttexttooltip(panel.get_node("WornIcon"),'Is equipped by ' + item.get_owner().get_short_name())
	for id in ResourceScripts.game_res.items:
		var item = ResourceScripts.game_res.items[id]
		if item.type != 'gear':
			continue
		if !item.tags.has('recipe'):
			continue
		if item.quality == 'legendary':
			continue
		var panel = input_handler.DuplicateContainerTemplate(item_list, 'Button')
		panel.connect('pressed', self, 'select_item', [id])
		item.set_icon(panel.get_node('Icon'))
		panel.pressed = selected_item == id
		if item.owner != null:
			panel.get_node("WornIcon").show()
			globals.connecttexttooltip(panel.get_node("WornIcon"),'Is equipped by ' + item.get_owner().get_short_name())


func build_hint(): #2change to translation codes
	if selected_item == null:
		$Hint.text = "Select item to improve"
	else:
		$Hint.text = "Select total %d items of %s quality" % [req_amount, req_quality]


func select_item(id = null):
	if id != null:
		selected_item = id
	selected_fuse_items.clear()
	build_item()
	build_item_list()
	build_hint()
	


func select_fuse_item(id):
	var item = ResourceScripts.game_res.items[id]
	var limit = item.amount
	if id == selected_item:
		limit -= 1
	var amount = 1
	if selected_fuse_items.has(id):
		amount = selected_fuse_items[id] + 1
	if amount > limit:
		return
	selected_fuse_items[id] = amount
	build_fuse_list()
	check_confirm()


func build_item():
	if selected_item == null:
		$EnchantPanel.visible = false
	else:
		$EnchantPanel.visible = true
		var item = ResourceScripts.game_res.items[selected_item]
		#setup filter
		if Items.fixed_quality_stats.has(item.itembase):
			req_itembase = null
			var tmp = item.quality
			req_quality = Items.next_quality[tmp]
			req_amount = Items.amount_to_improve_unique[req_quality]
		else:
			req_itembase = item.itembase
			req_quality = item.quality
			req_amount = Items.amount_to_improve[req_quality]
		
		build_item_description()
		build_fuse_list()
		check_confirm()


func build_fuse_list():
	input_handler.ClearContainer(fuse_list, ['Button'])
	for id in ResourceScripts.game_res.items:
		var item = ResourceScripts.game_res.items[id]
		if item.type != 'gear':
			continue
		if !item.tags.has('recipe'):
			continue
		if item.quality != req_quality:
			continue
		if req_itembase != null and item.itembase != req_itembase:
			continue
		var panel = input_handler.DuplicateContainerTemplate(fuse_list, 'Button')
		panel.connect('pressed', self, 'select_fuse_item', [id])
		globals.connectitemtooltip_v2(panel, item)
		item.set_icon(panel.get_node('Icon'))
#		panel.pressed = selected_fuse_items.has(id)
		var am1 = item.amount
		var am2 = 0
		if selected_fuse_items.has(id):
			am2 = selected_fuse_items[id]
		if id == selected_item:
			am1 -= 1
			if am1 == 0:
				panel.visible = false
			panel.pressed = true
			panel.get_node('amount').text = "%d/%d" % [am1, am2]
		elif selected_fuse_items.has(id):
			panel.pressed = true
			panel.get_node('amount').text = "%d/%d" % [am1, am2]
		else:
			panel.pressed = false
			panel.get_node('amount').text = "%d" % am1
		if item.owner != null:
			panel.get_node("WornIcon").show()
			globals.connecttexttooltip(panel.get_node("WornIcon"),'Is equipped by ' + item.get_owner().get_short_name())


func build_item_panel(panel, item):
	panel.get_node('name').text = item.name
	item.set_icon(panel.get_node('icon'))
	input_handler.ClearContainer(panel.get_node('stats'), ['line', 'line2'])
	if item.get_e_capacity_max() > 0:
		var enc_cap = input_handler.DuplicateContainerTemplate(panel.get_node('stats'), 'line')
		enc_cap.get_node('name').text = 'Enchant Capacity:'
		enc_cap.get_node('value').text = '%d/%d' % [item.get_e_capacity(), item.get_e_capacity_max()] #shows free cap, not used
	var quality = input_handler.DuplicateContainerTemplate(panel.get_node('stats'), 'line')
	quality.get_node('name').text = 'Quality:'
	quality.get_node('value').text = tr("QUALITY"+item.quality.to_upper())
	var stats_text = input_handler.DuplicateContainerTemplate(panel.get_node('stats'), 'line2')
	stats_text.bbcode_text = globals.TextEncoder(globals.build_desc_for_bonusstats(item.bonusstats))
	
	if panel.name == 'Weapon1' && item.get_owner() != null:
		var person = item.get_owner()
		panel.get_node('Frame/wearericon').set_texture(person.get_icon())
		panel.get_node('Frame').show()
		
	elif panel.name == 'Weapon1':
		panel.get_node('Frame').hide()
		
		
	if item.curse == null:
		pass
		#text += 'no'
	else:
		var text = ""
		var curse_text = input_handler.DuplicateContainerTemplate(panel.get_node('stats'), 'line2')
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
	titem.clear_enchants()
	titem.set_quality_level(Items.next_quality[item.quality])
	build_item_panel($EnchantPanel/Weapon2, titem)


func check_confirm():
	var nsel = 0
	for fuse in selected_fuse_items.values():
		nsel += fuse
	if req_amount == nsel:
		$EnchantPanel/Apply.visible = true
	else:
		$EnchantPanel/Apply.visible = false


func apply_selection():
	var item = ResourceScripts.game_res.items[selected_item]
	if item.amount > 1:
		item.amount -= 1
		item = item.clone()
		globals.AddItemToInventory(item, false)
		selected_item = item.id
	
	for id in selected_fuse_items:
		var tmp = ResourceScripts.game_res.items[id]
		if tmp.owner != null:
			characters_pool.get_char_by_id(tmp.owner).unequip(tmp, false)
		tmp.amount -= selected_fuse_items[id]
	
	item.clear_enchants()
	item.set_quality_level(Items.next_quality[item.quality])
	
	selected_item = null
	
	yield(get_tree(),'idle_frame')
	build_item_list()
	build_item()


func change_mode():
	gui_controller.windows_opened.erase(self)
	ResourceScripts.core_animations.FadeAnimation(self, 0.2)
	hide()
	get_parent().update()
	get_parent().select_category('enchant')
