 extends Panel

onready var itemcontainer = $Scroller/ScrollContainer/GridContainer
var itemarray = []
var mode
var categories = ['all','weapon','gear','usable','material']
var category = 'all'

func _ready():
	$Scroller/ScrollContainer/GridContainer/Button.set_meta('type', 'none')
	for i in $HBoxContainer.get_children():
		i.connect('pressed',self,'selectcategory', [i])	
	$SearchFilter.connect("text_changed", self, 'filter_changed')


func buildinventory():

	input_handler.ClearContainer(itemcontainer)
	input_handler.ClearContainer($HiddenContainer/GridContainer)
	itemarray.clear()
	var list_mode = get_parent().list_mode
	$SearchFilter.visible = list_mode != "tattoo"
	$HBoxContainer.visible = list_mode != "tattoo"
	$ItemsListTitle.text = "Inventory" if list_mode == "inventory" else "Tattoo"
	get_parent().get_node("InventoryGearModule/InventorySlots").visible = list_mode == "inventory"
	get_parent().get_node("InventoryGearModule/TattooSlots").visible = !get_parent().get_node("InventoryGearModule/InventorySlots").is_visible()
	get_parent().get_node("InventoryGearModule/buffscontainer").visible = list_mode == "inventory"
	for i in ResourceScripts.game_res.materials:
		if ResourceScripts.game_res.materials[i] <= 0:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate(itemcontainer)
		var material = Items.materiallist[i]
		var type = get_item_category(material)
		newbutton.get_node('Image').texture = material.icon
		newbutton.get_node('Number').text = ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.materials[i])
		newbutton.get_node('Number').show()
		newbutton.set_meta('type', type)
		newbutton.get_node("Name").text = material.name
		globals.connectmaterialtooltip(newbutton, material)
		newbutton.get_node("Type").texture = get_item_type_icon(material)
		itemarray.append(newbutton)
		newbutton.set_meta("item", i)
		if material.type != "tattoo":
			newbutton.connect("pressed",self,'useitem', [i, 'material'])
		else:
			newbutton.set_meta("tattoo_item", i)
			newbutton.connect("pressed",self,'select_tattoo', [material.code, i])
		if list_mode == "tattoo":
			newbutton.visible = material.type == "tattoo"
		else:
			if ResourceScripts.game_res.upgrades.has("tattoo"):
				newbutton.visible = true
			else:
				newbutton.visible = material.type != "tattoo"

	for i in ResourceScripts.game_res.items.values():
		if list_mode == "tattoo":
			break
		if i.owner != null:
			continue
		var newnode = input_handler.DuplicateContainerTemplate(itemcontainer)
		if i.durability != null:
			newnode.get_node("Number").show()
			newnode.get_node("Number").text = str(input_handler.calculatepercent(i.durability, i.maxdurability)) + '%'
		if i.amount != null:
			newnode.get_node("Number").show()
			newnode.get_node("Number").text = ResourceScripts.custom_text.transform_number(i.amount)
		else:
			newnode.get_node("Number").hide()
		i.set_icon(newnode.get_node("Image"))
		var type = get_item_category(i)
		if type == "tattoo":
			continue
		globals.connectitemtooltip_v2(newnode, i)
		newnode.get_node("Name").text = i.name
		newnode.get_node("Type").texture = get_item_type_icon(i)
		newnode.set_meta('type', type)
		newnode.set_meta("item", i)
		newnode.connect("pressed",self,'useitem', [i, i.type])
		itemarray.append(newnode)
		newnode.visible = list_mode != "tattoo"
	rebuildinventory()


var selected_tattoo: String


func select_tattoo(tattoo_code: String, tattoo_meta: String):
	get_parent().list_mode = "tattoo"
	selected_tattoo = tattoo_code
	buildinventory()
	show_avalible_slots(tattoo_code)
	highlight_selected_tattoo(tattoo_meta)


func highlight_selected_tattoo(tattoo_meta: String):
	for button in itemcontainer.get_children():
		if !button.has_meta("tattoo_item"):
			continue
		button.pressed = button.get_meta("tattoo_item") == tattoo_meta

func show_avalible_slots(tattoo):
	var avalible_slots = Traitdata.tattoodata[tattoo].slots
	get_parent().get_node("InventoryGearModule").highlight_avalible_slots(avalible_slots)
	

func rebuildinventory():
	var list_mode = get_parent().list_mode
	match list_mode:
		"inventory":
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
				var selectedhero = input_handler.interacted_character
				$GearPanel/BodyImage.texture = selectedhero.get_body_image()
				for i in selectedhero.equipment.gear:
					if selectedhero.equipment.gear[i] == null:
						$GearPanel.get_node(i + "/icon").texture = null
					else:
						var item = ResourceScripts.game_res.items[selectedhero.equipment.gear[i]]
						item.set_icon($GearPanel.get_node(i + "/icon"))
				$StatsPanel.open(selectedhero)


func get_item_type_icon(item):
	return input_handler.loadimage(get_item_category(item), 'icons')


func selectcategory(button):
	var type = button.name
	for i in $HBoxContainer.get_children():
		i.pressed = i == button
	category = type
	
	rebuildinventory()


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


func filter_changed(text):
	rebuildinventory()


func useitem(item, type):
	var selectedhero = input_handler.interacted_character
	for button in itemcontainer.get_children():
		button.pressed = false
	if type == 'gear':
		var item_prev_id = item.id
#		var equiped_item = globals.CreateGearItem(item.itembase, item.parts, item.bonusstats, null)
		var equiped_item = item.clone()
		globals.AddItemToInventory(equiped_item, false)
		selectedhero.equip(equiped_item, item_prev_id)
		input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
		get_parent().emit_signal("item_equipped")
		item.amount -= 1
		get_parent().set_active_hero(selectedhero)
	elif type == 'usable':
		if Items.itemlist[item.itembase].has("mansion_effect"):
			input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
			selectedhero.use_mansion_item(item)
			get_parent().set_active_hero(selectedhero)
		else:
			input_handler.SystemMessage("Can't use this item from here.")
