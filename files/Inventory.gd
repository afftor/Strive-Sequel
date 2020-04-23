extends "res://files/Close Panel Button/ClosingPanel.gd"

onready var itemcontainer = $ScrollContainer/GridContainer

var selectedhero
var mode
var show_list = true
var category = 'all'
var itemarray = []

var categories = ['all','weapon','gear','usable','material']

signal inventory_opened
signal inventory_hidden
signal item_used
signal item_equipped
signal item_discarded
signal item_sold

#warning-ignore-all:return_value_discarded
#warning-ignore-all:unused_signal

func _ready():
	$ScrollContainer/GridContainer/Button.set_meta('type', 'none')
	for i in $HBoxContainer.get_children():
		i.connect('pressed',self,'selectcategory', [i])
	
	#number select panel
	$NumberSelectPanel/ConfirmButton.connect("pressed", self, "NumberConfirm")
	$NumberSelectPanel/CancelButton.connect("pressed", self, "NumberClose")
	$NumberSelectPanel/SpinBox.connect('value_changed', self, 'NumberChanged')
	$NumberSelectPanel/MaxButton.connect("pressed",self, "NumberMax")
	
	$SwitchButton.connect("pressed",self,"switch_slave_stats")
	
	$SearchFilter.connect("text_changed", self, 'filter_changed')
	
	for i in $GearPanel.get_children():
		if i.name != 'BodyImage':
			i.connect("pressed", self, 'unequip', [i.name])
			i.connect("mouse_entered", self, 'show_equip_tooltip', [i.name])
			i.hint_tooltip = tr("ITEMSLOT" + i.name.to_upper())

func switch_slave_stats(newvalue = null):
	if (newvalue == false || show_list == true) && mode == 'all':
		$CharacterPanel.show()
		$StatsPanel.hide()
		$SwitchButton.text = tr("SWITCHLIST")
		rebuild_characters()
		return
	if newvalue == null:
		show_list = !show_list
	else:
		show_list = newvalue
	match show_list:
		true:
			$CharacterPanel.show()
			$StatsPanel.hide()
			$SwitchButton.text = tr("SWITCHLIST")
			rebuild_characters()
		false:
			$CharacterPanel.hide()
			$StatsPanel.show()
			$SwitchButton.text = tr("SWITCHSTATS")
			rebuildinventory()

func filter_changed(text):
	rebuildinventory()

func open(args):
	if args.mode == 'character':
		selectedhero = args.person
	mode = args.mode
	if mode == 'all':
		switch_slave_stats(true)
	move_child($Blockout, 0)
	show()
	buildinventory()
	rebuild_characters()
	
	$GearPanel.visible = args.mode == 'character'
	$StatsPanel.visible = args.mode == 'character'
	emit_signal("inventory_opened")

func hide():
	.hide()
	emit_signal("inventory_hidden")

func buildinventory():
	globals.ClearContainer(itemcontainer)
	globals.ClearContainer($HiddenContainer/GridContainer)
	itemarray.clear()
	for i in state.materials:
		if state.materials[i] <= 0:
			continue
		var newbutton = globals.DuplicateContainerTemplate(itemcontainer)
		var material = Items.materiallist[i]
		var type = get_item_category(material)
		newbutton.get_node('Image').texture = material.icon
		newbutton.get_node('Number').text = input_handler.transform_number(state.materials[i])
		newbutton.get_node('Number').show()
		newbutton.set_meta('type', type)
		newbutton.get_node("Name").text = material.name
		globals.connectmaterialtooltip(newbutton, material)
		newbutton.get_node("Type").texture = get_item_type_icon(material)
		newbutton.set_meta("item", i)
		newbutton.connect("pressed",self,'useitem', [i, 'material'])
		itemarray.append(newbutton)
	for i in state.items.values():
		if i.owner != null:
			continue
		var newnode = globals.DuplicateContainerTemplate(itemcontainer)
		if i.durability != null:
			newnode.get_node("Number").show()
			newnode.get_node("Number").text = str(globals.calculatepercent(i.durability, i.maxdurability)) + '%'
		if i.amount != null:
			newnode.get_node("Number").show()
			newnode.get_node("Number").text = input_handler.transform_number(i.amount)
		else:
			newnode.get_node("Number").hide()
		i.set_icon(newnode.get_node("Image"))
		var type = get_item_category(i)
		globals.connectitemtooltip(newnode, i)
		newnode.get_node("Name").text = i.name
		newnode.get_node("Type").texture = get_item_type_icon(i)
		newnode.set_meta('type', type)
		newnode.set_meta("item", i)
		newnode.connect("pressed",self,'useitem', [i, i.type])
		itemarray.append(newnode)
	rebuildinventory()


var icondict = {
	food = "res://assets/images/gui/inventory/icon_food1.png",
	material = "res://assets/images/gui/inventory/icon_res1.png",
	tool = "res://assets/images/gui/inventory/icon_craft1.png",
	weapon = "res://assets/images/gui/inventory/icon_weap1.png",
	armor = "res://assets/images/gui/inventory/icon_armor1.png",
	costume = "res://assets/images/gui/inventory/icon_cosm1.png",
	usable = "res://assets/images/gui/inventory/icon_potion1.png",
	
}

func get_item_type_icon(item):
	return load(icondict[get_item_category(item)])

func get_item_category(item):
	var type
	if Items.materiallist.has(item.code):
		if item.type == 'food':
			type = 'food'
		else:
			type = 'material'
	else:
		if item.itemtype == 'tool':
			type = 'tool'
#			if item.toolcategory != null:
#				type = 'tool'
#			else:
#				type = 'weapon'
		elif item.itemtype == 'weapon':
			type = 'weapon'
		elif item.itemtype == 'armor':
			if item.geartype == 'costume':
				type = 'costume'
			else:
				type = 'armor'
		else:
			type = 'usable'
	return type

func rebuildinventory():
	for i in itemarray:
		i.get_parent().remove_child(i)
		if category != 'all' && i.get_meta('type') != category:
			$HiddenContainer/GridContainer.add_child(i)
		else:
			var item = i.get_meta("item")
			if item == null:
				continue
			
			if $SearchFilter.text != '':
				var text = $SearchFilter.text
				if typeof(item) == TYPE_STRING:
					item = Items.materiallist[item]
					if (item.name.findn(text) < 0 && item.descript.findn(text) < 0 && item.adjective.findn(text) < 0): 
						$HiddenContainer/GridContainer.add_child(i)
					else:
						itemcontainer.add_child(i)
				else:
					if (item.name.findn(text) < 0 && item.description.findn(text) < 0 && item.itembase.findn(text) < 0) || item.owner != null || item.amount <= 0:
						$HiddenContainer/GridContainer.add_child(i)
					else:
						itemcontainer.add_child(i)
					if item.amount != null && (item.amount > 1 || item.type == 'usable'):
						i.get_node("Number").text = str(item.amount)
			else:
				var text = $SearchFilter.text
				if typeof(item) == TYPE_OBJECT && (item.owner != null || item.amount <= 0):
					$HiddenContainer/GridContainer.add_child(i)
				else:
					itemcontainer.add_child(i)
				if typeof(item) == TYPE_OBJECT && item.amount != null && (item.amount > 1 || item.type == 'usable'):
					i.get_node("Number").text = str(item.amount)
	if mode == 'character':
		$GearPanel/BodyImage.texture = selectedhero.get_body_image()
		for i in selectedhero.gear:
			if selectedhero.gear[i] == null:
				$GearPanel.get_node(i + "/icon").texture = null
			else:
				var item = state.items[selectedhero.gear[i]]
				item.set_icon($GearPanel.get_node(i + "/icon"))
		$StatsPanel.open(selectedhero)


func selectcategory(button):
	var type = button.name
	for i in $HBoxContainer.get_children():
		i.pressed = i == button
	category = type
	
	rebuildinventory()

func useitem(item, type):
	if mode == null:
		return
	elif mode == 'character' && selectedhero != null:
		if selectedhero.location != 'mansion':
			input_handler.SystemMessage("Can't use or equip items while away from Mansion.")
			return
		if type == 'gear':
			var item_prev_id = item.id
			var equiped_item = globals.CreateGearItem(item.itembase, item.parts, item.bonusstats, null)
			globals.AddItemToInventory(equiped_item, false)
			selectedhero.equip(equiped_item, item_prev_id)
			#input_handler.GetItemTooltip().hide()
			input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
			emit_signal("item_equipped")
			item.amount -= 1
			buildinventory()
		elif type == 'usable':
			if Items.itemlist[item.itembase].has("mansion_effect"):
				#input_handler.GetItemTooltip().hide()
				input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
				emit_signal("item_used")
				selectedhero.use_mansion_item(item)
				rebuildinventory()
			else:
				input_handler.SystemMessage("Can't use this item from here.")
		input_handler.update_slave_panel()
	elif mode == 'shop':
		sellwindow(item, type)

#func useitem(item, type):
#	if mode == null:
#		return
#	elif mode == 'character' && selectedhero != null:
#		if selectedhero.location != 'mansion':
#			input_handler.SystemMessage("Can't use or equip items while away from Mansion.")
#			return
#		if type == 'gear':
#			var item_prev_id = item.id
#			if item.amount == 1:
#				selectedhero.equip(item)
#				#input_handler.GetItemTooltip().hide()
#				input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
#				emit_signal("item_equipped")
#				buildinventory()
#				return
#			var equiped_item = globals.CreateGearItem(item.itembase, item.parts, item.bonusstats, null, false)
#			globals.AddItemToInventory(equiped_item)
#			selectedhero.equip(equiped_item, item_prev_id)
#			item.amount -= 1	
#			#input_handler.GetItemTooltip().hide()
#			input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
#			emit_signal("item_equipped")
#			buildinventory()
#		elif type == 'usable':
#			if Items.itemlist[item.itembase].has("mansion_effect"):
#				#input_handler.GetItemTooltip().hide()
#				input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
#				emit_signal("item_used")
#				selectedhero.use_mansion_item(item)
#				rebuildinventory()
#			else:
#				input_handler.SystemMessage("Can't use this item from here.")
#		input_handler.update_slave_panel()
#	elif mode == 'shop':
#		sellwindow(item, type)


var numbermode
var operatingitem
var itemprice = 0
var amount = 0
var maxamount = 0
var activeitem

func sellwindow(item, type):
	var text = ''
	operatingitem = item
	numbermode = 'sell'
	$NumberSelectPanel.show()
	$NumberSelectPanel/SpinBox.value = 0
	if type == 'material':
		var material = Items.Materials[item]
		maxamount = state.materials[item]
		itemprice = material.price
		amount = 1
		text = tr("SELLCONFIRM") + " " + material.name + "?" 
	else:
		itemprice = item.calculateprice()/3
		amount = 1
		maxamount = item.amount
		text = tr("SELLCONFIRM") + " " + item.name + "?" 
	$NumberSelectPanel/RichTextLabel.bbcode_text = text
	updateprice()

func updateprice():
	if amount > maxamount:
		amount = maxamount
	elif amount == 0:
		amount = 1
	$NumberSelectPanel/SpinBox.value = amount
	$NumberSelectPanel/BasePrice.text = str(itemprice) + " *"
	$NumberSelectPanel/EndPrice.text = "= " + str(itemprice * amount)


func NumberConfirm():
	if numbermode == 'sell':
		state.money += amount*itemprice
		if typeof(activeitem) == TYPE_STRING:
			state.materials[activeitem] -= amount
		else:
			activeitem.amount -= amount# (activeitem.id)
	$NumberSelectPanel.hide()
	emit_signal("item_sold")
	buildinventory()

func NumberClose():
	$NumberSelectPanel.hide()

func NumberChanged(value):
	amount = value
	updateprice()

func NumberMax():
	amount = maxamount
	updateprice()

func show_equip_tooltip(slot):
	if selectedhero.gear[slot] == null:
		return
	else:
		var item = state.items[selectedhero.gear[slot]]
		item.tooltip($GearPanel.get_node(slot))

func unequip(slot):
	if selectedhero.location != 'mansion':
		input_handler.SystemMessage("Can't use or equip items while away from Mansion.")
		return
	if selectedhero.gear[slot] != null:
		selectedhero.unequip(state.items[selectedhero.gear[slot]])
		#input_handler.GetItemTooltip().hide()
		input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
		input_handler.update_slave_panel()
		buildinventory()

func rebuild_characters():
	globals.ClearContainer($CharacterPanel/ScrollContainer/VBoxContainer)
	for id in state.character_order:
		var i = state.characters[id]
		var newnode = globals.DuplicateContainerTemplate($CharacterPanel/ScrollContainer/VBoxContainer)
		newnode.get_node("Label").text = i.get_full_name()
		if i == selectedhero: newnode.pressed = true
		newnode.connect("pressed", self, "open", [{mode = 'character', person = i}])
