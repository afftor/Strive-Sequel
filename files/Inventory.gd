extends "res://files/Close Panel Button/ClosingPanel.gd"

onready var itemcontainer = $ScrollContainer/GridContainer

var selectedhero
var mode
var category = 'all'
var itemarray = []

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
	
	
	for i in $GearPanel.get_children():
		if i.name != 'BodyImage':
			i.connect("pressed", self, 'unequip', [i.name])
			i.connect("mouse_entered", self, 'show_equip_tooltip', [i.name])
	

func open(args):
	if args.mode == 'character':
		selectedhero = args.person
	mode = args.mode
	move_child($Blockout, 0)
	show()
	buildinventory()
	
	
	$GearPanel.visible = args.mode == 'character'
	emit_signal("inventory_opened")

func hide():
	.hide()
	emit_signal("inventory_hidden")

func buildinventory():
	globals.ClearContainer(itemcontainer)
	globals.ClearContainer($HiddenContainer/GridContainer)
	itemarray.clear()
	if mode == 'all':
		for i in state.materials:
			if state.materials[i] <= 0:
				continue
			var newbutton = globals.DuplicateContainerTemplate(itemcontainer)
			var material = Items.materiallist[i]
			newbutton.get_node('Image').texture = material.icon
			newbutton.get_node('Number').text = str(state.materials[i])
			newbutton.get_node('Number').show()
			newbutton.set_meta('type', 'mat')
			newbutton.get_node("Name").text = material.name
			globals.connectmaterialtooltip(newbutton, material)
			newbutton.get_node("Type").text = material.type
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
		if i.amount != null && i.amount > 1:
			newnode.get_node("Number").show()
			newnode.get_node("Number").text = str(i.amount)
		i.set_icon(newnode.get_node("Image"))#input_handler.itemshadeimage(newnode.get_node('Image'), i)
		globals.connectitemtooltip(newnode, i)
		newnode.get_node("Name").text = i.name
		newnode.get_node("Type").text = i.itemtype
		newnode.set_meta('type', i.itemtype)
		newnode.set_meta("item", i)
		newnode.connect("pressed",self,'useitem', [i, i.itemtype])
		itemarray.append(newnode)
	rebuildinventory()

func rebuildinventory():
	for i in itemarray:
		i.get_parent().remove_child(i)
		match mode:
			'all':
				if (category == 'all' || i.get_meta('type') == category):
					itemcontainer.add_child(i)
				else:
					$HiddenContainer/GridContainer.add_child(i)
			'character':
				var item = i.get_meta("item")
				if item.owner == null:
					itemcontainer.add_child(i)
				else:
					$HiddenContainer/GridContainer.add_child(i)
	if mode == 'character':
		$GearPanel/BodyImage.texture = selectedhero.get_body_image()
		for i in selectedhero.gear:
			if selectedhero.gear[i] == null:
				$GearPanel.get_node(i + "/icon").texture = null
			else:
				var item = state.items[selectedhero.gear[i]]
				item.set_icon($GearPanel.get_node(i + "/icon"))

func selectcategory(button):
	var type = button.name
	for i in $HBoxContainer.get_children():
		i.pressed = i == button
	category = type
	
	rebuildinventory()

func useitem(item, type):
	activeitem = item
	if mode == null:
		return
	elif mode == 'character' && selectedhero != null:
		selectedhero.equip(item)
		input_handler.GetItemTooltip().hide()
		emit_signal("item_equipped")
		rebuildinventory()
	elif mode == 'shop':
		sellwindow(item, type)

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
		itemprice = item.calculateprice()
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
	if selectedhero.gear[slot] != null:
		selectedhero.unequip(state.items[selectedhero.gear[slot]])
		input_handler.GetItemTooltip().hide()
		rebuildinventory()

