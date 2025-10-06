 extends Panel

onready var itemcontainer = $Scroller/ScrollContainer2/GridContainer
onready var itemcontainergrid = $Scroller/ScrollContainer2/GridContainer
onready var itemcontainervbox = $Scroller/ScrollContainer/GridContainer

var itemarray = []
var mode
var categories = ['all','weapon','gear','usable','material']
var category = 'all'

func _ready():
	$Scroller/ScrollContainer/GridContainer/Button.set_meta('type', 'none')
	for i in $HBoxContainer.get_children():
		i.connect('pressed',self,'selectcategory', [i])	
	$SearchFilter.connect("text_changed", self, 'filter_changed')
	$switchstyle.connect('pressed',self, 'switch_container')
	if input_handler.globalsettings.grid_inventory == false:
		switch_container()

func switch_container():
	if itemcontainer == itemcontainergrid:
		input_handler.globalsettings.grid_inventory = false
		itemcontainer = itemcontainervbox
		itemcontainergrid.get_parent().hide()
	else:
		itemcontainer = itemcontainergrid
		itemcontainervbox.get_parent().hide()
		input_handler.globalsettings.grid_inventory = false
	buildinventory()
	itemcontainer.get_parent().show()
	



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
	
	var array = []
	for i in ResourceScripts.game_res.materials:
		if ResourceScripts.game_res.materials[i] <= 0:
			continue
		array.append(i)
	array.sort_custom(self, 'sort_mats')
	for i in array:
		var newbutton = input_handler.DuplicateContainerTemplate(itemcontainer)
		var material = Items.materiallist[i]
		var type = get_item_category(material)
		newbutton.get_node('Image').texture = material.icon
		newbutton.get_node('Number').text = ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.materials[i])
		newbutton.get_node('Number').show()
		newbutton.set_meta('type', type)
		if itemcontainer == itemcontainervbox:
			newbutton.get_node("Name").text = material.name
			newbutton.get_node("Type").texture = get_item_type_icon(material)
		globals.connectmaterialtooltip(newbutton, material)
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
		if false: #i.tags.has('skill_tooltip'):
			var itemtemplate = Items.itemlist[i.itembase]
			newnode.set_meta('display_only', true)
			globals.connectskilltooltip(newnode, itemtemplate.skill, input_handler.interacted_character)
		else:
			globals.connectitemtooltip_v2(newnode, i)
		if itemcontainer == itemcontainervbox:
			newnode.get_node("Name").text = i.name
			newnode.get_node("Type").texture = get_item_type_icon(i)
		newnode.set_meta('type', type)
		newnode.set_meta("item", i)
		newnode.connect("pressed",self,'useitem', [i, i.type])
		itemarray.append(newnode)
		newnode.visible = list_mode != "tattoo"
		if i.quality != "":
			newnode.get_node("quality_color").show()
			newnode.get_node("quality_color").texture = variables.quality_colors[i.quality]
	rebuildinventory()

func sort_mats(first,second):
	var material1 = Items.materiallist[first]
	var material2 = Items.materiallist[second]
	if material1.name >= material2.name:
		return false
	else:
		return true

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

var titem
func useitem(item, type):
	var selectedhero = input_handler.interacted_character
	for button in itemcontainer.get_children():
		button.pressed = false
	if type == 'gear':
		equip(item)
	elif type == 'usable':
		if Items.itemlist[item.itembase].has("mansion_effect"):
			input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
			if Items.itemlist[item.itembase].tags.has('request_confirm'):
				titem = item
				input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'useitem_confirm', globals.TextEncoder(tr("ITEMUSECONFIRM") % tr(item.name))])
			else:
				selectedhero.use_mansion_item(item)
				get_parent().set_active_hero(selectedhero)
		else:
			input_handler.SystemMessage("Can't use this item from here.")


func useitem_confirm():
	var selectedhero = input_handler.interacted_character
	selectedhero.use_mansion_item(titem)
	get_parent().set_active_hero(selectedhero)


var tempitem
func equip(s_item):
	var selectedhero = input_handler.interacted_character
	tempitem = s_item
	for slot in tempitem.multislots:
		if selectedhero.get_gear(slot) != null:
			var item = ResourceScripts.game_res.items[selectedhero.equipment.gear[slot]]
			if item.curse != null:
				input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'equip_confirm', tr("CURSEUNEQUIPCONFIRM2")])
				return
	for slot in tempitem.slots:
		if slot == 'lhand' and tempitem.slots.has('rhand'):
			if selectedhero.has_status('strongarm') and tempitem.geartype != 'bow':
				continue
		if selectedhero.get_gear(slot) != null:
			var item = ResourceScripts.game_res.items[selectedhero.equipment.gear[slot]]
			if item.curse != null:
				input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'equip_confirm', tr("CURSEUNEQUIPCONFIRM2")])
				return
	equip_confirm()


func equip_confirm():
	var selectedhero = input_handler.interacted_character
	var item_prev_id = tempitem.id
#	var equiped_item = globals.CreateGearItem(item.itembase, item.parts, item.bonusstats, null)
	var equiped_item = tempitem.clone()
	globals.AddItemToInventory(equiped_item, false)
	selectedhero.equip(equiped_item, item_prev_id)
	input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
	get_parent().emit_signal("item_equipped")
	tempitem.amount -= 1
	get_parent().set_active_hero(selectedhero)
