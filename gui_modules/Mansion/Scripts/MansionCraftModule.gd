extends Panel

var craft_category = "cooking"
var item_filter = 'all'
var selected_item
var recipes = []
var default_part_texture = preload("res://assets/Textures_v2/MANSION/Craft/Buttons/button_craftchoose.png")
var placeholder = preload("res://assets/Textures_v2/MANSION/Craft/Buttons/button_craftchoose_placeholder.png")
var craft_one_side_panel = preload("res://assets/Textures_v2/MANSION/Craft/Panels/panel_craftbig_oneside.png")
var craft_two_sides_panel = preload("res://assets/Textures_v2/MANSION/Craft/Panels/panel_craftbig_twosides.png")
#warning-ignore-all:return_value_discarded

# func _init():
# 	yield(Items, "tree_entered")
	

func _ready():
	# input_handler.AddPanelOpenCloseAnimation($NumberSelect)
	$NumberSelect/NumberConfirm.connect("pressed", self, "confirm_craft")
	$NumberSelect/HSlider.connect("value_changed", self, "number_change")
	$SelectCharacters.connect("pressed", self, "select_characters")
	$CraftSelect/BackButton.connect("pressed", get_parent(), "mansion_state_set", ["default"])
	$NumberSelect/BackButton2.connect("pressed", self, "cancel_choise")
	# input_handler.AddPanelOpenCloseAnimation($MaterialSelect)
	
	for i in [$MaterialSetupPanel/ModularSetup/Part1, $MaterialSetupPanel/ModularSetup/Part2, $MaterialSetupPanel/ModularSetup/Part3]:
		i.connect("pressed", self, 'choosematerial', [i])
	
	for i in $categories.get_children():
		i.connect("pressed", self, 'select_category', [i.name])
	for i in $filter.get_children():
		i.connect('pressed',self, 'set_filter', [i.name])
		i.hint_tooltip = filtercategories[i.name]

func cancel_choise():
	$NumberSelect.hide()
	$MaterialSetupPanel.hide()
	$CraftScheldue.show()
	$SelectCharacters.show()


func set_filter(type):
	item_filter = type
	for i in $filter.get_children():
		i.pressed = i.name == type
	rebuild_recipe_list()

var craftcategories = {
	cooking = {reqs = []},
	tailor = {reqs = [{type = "has_upgrade", name = 'tailor', value = 1}]},
	alchemy = {reqs = [{type = "has_upgrade", name = 'alchemy', value = 1}]},
	smith = {reqs = [{type = "has_upgrade", name = 'forge', value = 1}]},
}
var filtercategories = {
	all = "All",
	materials = "Food&Materials",
	gear = "Gear",
	costume = "Costume",
	usables = "Usables",
}

func update():
	for i in $categories.get_children():
		i.pressed = false
		# i.get_node("Label").add_color_override("font_color", Color(224,244,244,255))
	select_category(craft_category)
	$CraftScheldue.show()
	# $CraftSelect.hide()

func open():
	show()
	for i in craftcategories:
		$categories.get_node(i).visible = globals.checkreqs(craftcategories[i].reqs)
	if craft_category != null:
		select_category(craft_category)
	input_handler.ActivateTutorial('crafting')

func clear():
	craft_category = null
	input_handler.ClearContainer($CraftScheldue/VBoxContainer)
	input_handler.ClearContainer($CraftSelect/VBoxContainer)

func select_category(category):
	$MaterialSelect.hide()
	$MaterialSetupPanel.hide()
	$NumberSelect.hide()
	get_parent().selected_craft_task = category
	craft_category = category
	for i in $categories.get_children():
		i.pressed = i.name == category
	
	for i in $filter.get_children():
		i.pressed = false
	item_filter = 'all'
	$filter/all.pressed = true
	$CraftSelect.show()
	$filter.show()
	rebuild_recipe_list()
	rebuild_scheldue()


func rebuild_recipe_list():
	var array = []
	input_handler.ClearContainer($CraftSelect/ScrollContainer/VBoxContainer)
	
	for i in $filter.get_children():
		i.hide()
	
	$filter/all.show()
	
	for i in Items.recipes.values():
		if i.worktype != craft_category || globals.checkreqs(i.unlockreqs) == false:
			continue
		if item_filter == 'all':
			array.append(i)
		else:
			if i.resultitemtype == 'material' && item_filter == 'materials':
				array.append(i)
			else:
				if i.resultitemtype == 'item':
					var enditem = Items.itemlist[i.resultitem]
					if enditem.type == 'usable' && item_filter == 'usables':
						array.append(i)
					elif enditem.has('geartype') && enditem.geartype == 'costume' && item_filter == 'costume':
						array.append(i)
					elif enditem.type == 'gear' && enditem.geartype != 'costume' && item_filter == 'gear':
						array.append(i)
		if i.resultitemtype == 'material':
			$filter/materials.show()
		else:
			if i.resultitemtype == 'item':
				var enditem = Items.itemlist[i.resultitem]
				if enditem.type == 'usable':
					$filter/usables.show()
				elif enditem.has('geartype') && enditem.geartype == 'costume':
					$filter/costume.show()
				elif enditem.type == 'gear' && enditem.geartype != 'costume':
					$filter/gear.show()
	
	array.sort_custom(self, 'sort_craft_list')
	for i in array:
		var newbutton = input_handler.DuplicateContainerTemplate($CraftSelect/ScrollContainer/VBoxContainer)
		var item
		if i.resultitemtype == 'item':
			item = Items.itemlist[i.resultitem]
			globals.connecttempitemtooltip(newbutton.get_node('icon'), item, 'geartemplate')
		else:
			item = Items.materiallist[i.resultitem]
			globals.connectmaterialtooltip(newbutton.get_node('icon'), item, '')
		newbutton.get_node("number").text = str(i.resultamount)
		newbutton.get_node('Label').text = item.name
		newbutton.set_meta('item', i)
		newbutton.connect("pressed", self, 'selectcraftitem', [i])
		newbutton.get_node('icon').texture = item.icon
		###
		if i.crafttype == 'basic':
			for k in i.items:
				var newnode = input_handler.DuplicateContainerTemplate(newbutton.get_node("HBoxContainer"))
				var recipeitem = Items.itemlist[k]
				globals.connecttempitemtooltip(newnode, recipeitem, 'geartemplate')
				newnode.texture = recipeitem.icon
				newnode.get_node("Label").text = str(i.items[k])
			for k in i.materials:
				var newnode = input_handler.DuplicateContainerTemplate(newbutton.get_node("HBoxContainer"))
				var recipeitem = Items.materiallist[k]
				globals.connectmaterialtooltip(newnode,recipeitem,'')
				newnode.texture = recipeitem.icon
				newnode.get_node("Label").text = str(i.materials[k])
		elif i.crafttype == 'modular':
			newbutton.get_node("icon").material = load("res://assets/ItemShader.tres").duplicate()
			for k in item.parts:
				var newnode = input_handler.DuplicateContainerTemplate(newbutton.get_node("HBoxContainer"))
				var partdata = Items.Parts[k]
				newnode.texture = partdata.icon
				newnode.hint_tooltip = "Materials required for: " + tr(partdata.name)
				newnode.get_node("Label").text = str(item.parts[k])
		
		
		var progressnode = newbutton.get_node("WorkUnits")
		progressnode.texture = images.icons[i.worktype]
		progressnode.get_node("Label").text = str(i.workunits)
		progressnode.hint_tooltip = 'Progress required per craft'

func update_buttons(item):
	for button in $CraftSelect/ScrollContainer/VBoxContainer.get_children():
		if button == $CraftSelect/ScrollContainer/VBoxContainer.get_child($CraftSelect/ScrollContainer/VBoxContainer.get_children().size()-1):
			continue
		button.pressed = item == button.get_meta("item")

func sort_craft_list(first, second):
	var enditem 
	var enditem2 
	
	if first.resultitemtype == 'item':
		enditem = Items.itemlist[first.resultitem]
	else:
		enditem = Items.materiallist[first.resultitem]
	if second.resultitemtype == 'item':
		enditem2 = Items.itemlist[second.resultitem]
	else:
		enditem2 = Items.materiallist[second.resultitem]

	return enditem.name < enditem2.name

func rebuild_scheldue():
	input_handler.ClearContainer($CraftScheldue/ScrollContainer/VBoxContainer)
	#Should be deleted!!!
	var items = load("res://assets/data/Items.gd")
	var Items = items.new()
	###
	for i in ResourceScripts.game_res.craftinglists[craft_category]:
		var newnode = input_handler.DuplicateContainerTemplate($CraftScheldue/ScrollContainer/VBoxContainer)
		var recipe = Items.recipes[i.code]
		var item = Items[recipe.resultitemtype + 'list'][recipe.resultitem]
		newnode.get_node("icon").texture = item.icon
		if item.type == 'gear' && item.crafttype == 'modular':
			newnode.get_node("icon").material = load("res://assets/ItemShader.tres").duplicate()
		newnode.get_node("Label").text = item.code.capitalize() + ": " + globals.fastif(i.repeats != -1,str(i.repeats),'∞')
		newnode.connect("pressed",self,'confirm_cancel_craft', [i])
		newnode.set_meta("selected_craft", i)
		newnode.get_node("DeleteButton").connect("pressed",self,'delete_from_queue', [i])
		newnode.get_node("progress").text = str(floor(i.workunits)) + "/" + str(i.workunits_needed)
		newnode.arraydata = i
		newnode.parentnodearray = ResourceScripts.game_res.craftinglists[craft_category]
		newnode.target_node = self
		newnode.target_function = 'rebuild_scheldue'
	

var repeats = 1

func number_change(value):
	var text = ''
	$NumberSelect/HSlider.value = value
	repeats = value
	var visiblerepeats = str(repeats)
	if repeats >= 100:
		repeats = -1
		visiblerepeats = '∞'
	text = "[center]Repeat " + visiblerepeats + " times.[/center] "#" + selected_item.name + "
	$NumberSelect/RichTextLabel.bbcode_text = text
#
#func craft_select(item):
#	selected_item = item
#	number_change(1)
#	$NumberSelect.show()


func confirm_craft():
	self.get_stylebox("panel", "" ).set_texture(craft_two_sides_panel)
	$SelectCharacters.show()
	$NumberSelect.hide()
	$MaterialSetupPanel.hide()
	$CraftScheldue.show()
	var list = selected_item.worktype
	var data = {}
	data.code = selected_item.code
	data.repeats = repeats
	data.workunits = 0
	data.workunits_needed = selected_item.workunits
	data.materials = selected_item.items.duplicate()
	data.resources_taken = false
	ResourceScripts.game_res.craftinglists[list].append(data)
	if selected_item.crafttype == 'modular':
		data.partdict = partdict.duplicate()
	
	select_category(craft_category)

var cancelentry
var partdict

func delete_from_queue(entry):
	cancelentry = entry
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'cancel_item_craft', tr('CANCELTASKQUESTION')	])

func confirm_cancel_craft(entry):
	get_parent().is_craft_selected = true
	# $SelectCharacters.disabled = false
	for button in $CraftScheldue/ScrollContainer/VBoxContainer.get_children():
		if button.name == "Button":
			continue
		button.pressed = button.get_meta("selected_craft") == entry
	


func cancel_item_craft():
	var entry = cancelentry
	ResourceScripts.game_res.craftinglists[craft_category].erase(entry)
	select_category(craft_category)

var itemtemplate
var itemparts = {}
var chosenpartbutton

func selectcraftitem(item):
	globals.disconnect_text_tooltip($MaterialSetupPanel/EndItemFrame)
	globals.disconnect_temp_item_tooltip($MaterialSetupPanel/EndItemFrame)
	itemparts = {}
	update_buttons(item)
	checkcreatingitem(item.code)
	self.get_stylebox("panel", "" ).set_texture(craft_one_side_panel)
	$CraftScheldue.hide()
	$SelectCharacters.hide()
	# $SelectCharacters.disabled = true
	selected_item = item
	itemtemplate = item.resultitem
	$NumberSelect.show()
	$MaterialSetupPanel.show()
	get_node("MaterialSetupPanel/ModularSetup/").visible = item.crafttype != 'basic'
	get_node("MaterialSetupPanel/BasicSetup/").visible = !get_node("MaterialSetupPanel/ModularSetup/").visible
	# for i in ['Part1','Part2','Part3', 'Part1Descript', 'Part2Descript', 'Part3Descript', 'Label']:
	# 	get_node("MaterialSetupPanel/ModularSetup/" + i).visible = !item.crafttype == 'basic'
	if item.crafttype == 'basic':
		var baseitem
		if Items.materiallist.has(item.resultitem):
			baseitem = Items.materiallist[item.resultitem]
			globals.connecttempitemtooltip($MaterialSetupPanel/EndItemFrame, baseitem, 'material')
		elif item.crafttype == 'basic' && item.crafttype != 'modular':
			baseitem = Items.itemlist[item.resultitem]
			globals.connecttempitemtooltip($MaterialSetupPanel/EndItemFrame, baseitem, 'geartemplate')
		$NumberSelect/NumberConfirm.disabled = false
		$MaterialSetupPanel/EndItemFrame/EndItem.material = null
		$MaterialSetupPanel/EndItemFrame/EndItem.texture = baseitem.icon
		var item_name = baseitem.name
		var text = "{color=k_yellow|" + str(item_name) + "}"
		var encoded_text = globals.TextEncoder(text)
		encoded_text += "\n" + str(baseitem.descript)
		$MaterialSetupPanel/EndItemDescript.bbcode_text = encoded_text
		var basic_setup_container = $MaterialSetupPanel/BasicSetup/ScrollContainer/VBoxContainer
		
		input_handler.ClearContainer(basic_setup_container)
		###
		for m in item.materials:
			var newbutton = input_handler.DuplicateContainerTemplate(basic_setup_container)
			newbutton.get_node("Icon").texture = Items.materiallist[m].icon
			newbutton.get_node("Reqs").text = str(item.materials[m]) + '/' + str(ResourceScripts.game_res.materials[m])
			newbutton.get_node("Name").text = m.capitalize()
			newbutton.disabled = item.materials[m] > ResourceScripts.game_res.materials[m]
		for i in item.items:
			var amount = 0
			var newbutton = input_handler.DuplicateContainerTemplate(basic_setup_container)
			newbutton.get_node("Icon").texture = Items.itemlist[i].icon
			for item_value in ResourceScripts.game_res.items.values():
				if item_value.code == i:
					amount = item_value.amount
					break
			newbutton.get_node("Reqs").text = str(item.items[i]) + '/' + str(amount)
			newbutton.get_node("Name").text = str(Items.itemlist[i].name)
			newbutton.disabled = item.items[i] > amount

	else:
		$NumberSelect/NumberConfirm.disabled = true
		$MaterialSetupPanel/EndItemDescript.bbcode_text = ''
		item = Items.itemlist[item.resultitem]
		var array = []
		for i in item.parts:
			array.append(i)
		array.sort()
		itemparts.clear()
		for i in ['Part1','Part2','Part3']:
			get_node("MaterialSetupPanel/ModularSetup/" + i).texture_normal = default_part_texture
			get_node("MaterialSetupPanel/ModularSetup/" + i + '/number').hide()
			get_node("MaterialSetupPanel/ModularSetup/" + i + 'Descript').bbcode_text = ''
			get_node("MaterialSetupPanel/ModularSetup/" + i + "/TextureRect").texture = placeholder
			get_node("MaterialSetupPanel/ModularSetup/" + i + "/TextureRect").show()
		$MaterialSetupPanel/EndItemFrame/EndItem.texture = null
		
		$MaterialSetupPanel/ModularSetup/Part1.set_meta('part',array[0])
		$MaterialSetupPanel/ModularSetup/Part1.set_meta('cost',item.parts[array[0]])
		$MaterialSetupPanel/ModularSetup/Part2.hide()
		$MaterialSetupPanel/ModularSetup/Part3.hide()
		match array.size():
			2:
				$MaterialSetupPanel/ModularSetup/Part2.show()
				$MaterialSetupPanel/ModularSetup/Part2.set_meta('part',array[1])
				$MaterialSetupPanel/ModularSetup/Part2.set_meta('cost',item.parts[array[1]])
			3:
				$MaterialSetupPanel/ModularSetup/Part2.show()
				$MaterialSetupPanel/ModularSetup/Part2.set_meta('part',array[1])
				$MaterialSetupPanel/ModularSetup/Part2.set_meta('cost',item.parts[array[1]])
				$MaterialSetupPanel/ModularSetup/Part3.show()
				$MaterialSetupPanel/ModularSetup/Part3.set_meta('part',array[2])
				$MaterialSetupPanel/ModularSetup/Part3.set_meta('cost',item.parts[array[3]])



func choosematerial(button):
	if !get_parent().submodules.has($MaterialSelect):
		get_parent().submodules.append($MaterialSelect)
	input_handler.ClearContainer($MaterialSelect/ScrollContainer/VBoxContainer)
	$MaterialSelect.show()
	$CraftSelect.hide()
	$filter.hide()
	chosenpartbutton = button
	var part = button.get_meta('part')
	var cost = button.get_meta('cost')
	
	var text = tr(Items.Parts[part].name) + ' - ' + tr('REQUIREDMATERIAL') + ': ' + str(cost)
	$MaterialSelect/PartLabel.text = text
	
	for i in Items.materiallist.values():
		var tempmaterial = ResourceScripts.game_res.materials[i.code]
		if !i.has("parts") || tempmaterial < 1:
			continue
		if i.parts.has(part):
			var newbutton = $MaterialSelect/ScrollContainer/VBoxContainer/Button.duplicate()
			newbutton.show()
			$MaterialSelect/ScrollContainer/VBoxContainer.add_child(newbutton)
			newbutton.get_node('Icon').texture = i.icon
			newbutton.get_node("amount").text = str(tempmaterial)
			var part_name = "{color=k_yellow|" + tr(i.name) + '}'
			var name_encoded = globals.TextEncoder(part_name)
			var parttext = str(name_encoded) + "\n"
			for k in i.parts[part]:
				if Items.itemlist[itemtemplate].itemtype == 'armor':
					parttext += statdata.statdata[k].name + ": " +  str(float(i.parts[part][k])/2) + ", "
				else:
					parttext += statdata.statdata[k].name + ": " +  str(i.parts[part][k]) + ", "
			parttext = parttext.substr(0, parttext.length()-2)
			newbutton.get_node("Label").bbcode_text = parttext
			globals.connecttexttooltip(newbutton.get_node("ButtonOverlay"), '[center]' + i.name + "[/center]\n" + i.descript)
			newbutton.get_node("ButtonOverlay").connect("pressed",self,'selectmaterial',[i, part, cost])
			

func selectmaterial(material, part, cost):
	$filter.show()
	itemparts[part] = {material = material.code, price = cost}
	chosenpartbutton.get_node("TextureRect").texture = material.icon
	# chosenpartbutton.get_node('TextureRect').hide()
	chosenpartbutton.get_node("number").text = str(cost)
	chosenpartbutton.get_node("number").show()
	var text = tr(Items.Parts[part].name)
	$MaterialSelect.hide()
	$CraftSelect.show()
	checkcreatingitem(itemtemplate)
	for i in material.parts[part]:
		if typeof(material.parts[part][i]) != TYPE_ARRAY:
			var endvalue = material.parts[part][i]
			if Items.itemlist[itemtemplate].basemods.has(i):
				endvalue = material.parts[part][i]*float(Items.itemlist[itemtemplate].basemods[i])
			if Items.itemlist[itemtemplate].itemtype == 'armor':
				endvalue = float(endvalue) / 2
			if endvalue != 0:
				text += '\n' + tr(Items.stats[i]) + ': ' + str(endvalue)
		else:
			for k in material.parts[part][i]:
				text += '\n' + Effectdata.effects[k].descript
	get_node("MaterialSetupPanel/ModularSetup/" + chosenpartbutton.name + 'Descript').bbcode_text = text

var enditem

func checkcreatingitem(item):
	if !Items.itemlist.has(item):
		return
	enditem = null
	var baseitem = Items.itemlist[item]
	if !baseitem.has("parts"):
		return
	var text = tr('TOTALPRICE') + ': '
	var resourcedict = {}
	for i in itemparts.values():
		if resourcedict.has(i.material):
			resourcedict[i.material] += i.price
		else:
			resourcedict[i.material] = i.price
	for i in resourcedict:
		text += "\n" + i.capitalize() + ' - ' + str(resourcedict[i])
	
	
	
	var fullrecipe = true
	for i in baseitem.parts:
		if !itemparts.has(i):
			fullrecipe = false
	
	#$NumberSelect/CreateItem.disabled = !fullrecipe
	
	
	var temppartdict = {}
	for i in itemparts:
		temppartdict[i] = itemparts[i].material
	enditem = globals.CreateGearItem(item, temppartdict)
	partdict = temppartdict
	#enditem.CreateGear(item, partdict)
	text = multipart_item_text(enditem)
	globals.connecttexttooltip($MaterialSetupPanel/EndItemFrame, enditem.tooltiptext())
	if fullrecipe == false:
		text += '\n{color=k_red|' + tr('SELECTMATERIAL') + '}\n'
		$NumberSelect/NumberConfirm.disabled = true
	else:
		text += '\n'
		$NumberSelect/NumberConfirm.disabled = false
	
	globals.TextEncoder(text, $MaterialSetupPanel/EndItemDescript)
	#globals.connecttooltip($NumberSelect/EndItem, text)
	$MaterialSetupPanel/EndItemFrame/EndItem.set_texture(baseitem.icon)
	input_handler.itemshadeimage($MaterialSetupPanel/EndItemFrame/EndItem, enditem)


func multipart_item_text(item):
	var text = ''
	text += '{color=k_yellow|' + item.name + '}\n'
	if item.geartype != null:
		text += 'Type: ' + item.geartype + "\n"
	else:
		text += "Type: Usable\n"
	
	if item.slots.size() > 0:
		text += "Slots: "
		for i in item.slots:
			text += tr("ITEMSLOT"+i.to_upper()) + ", "
		text = text.substr(0, text.length() -2)
	
	if item.toolcategory != null:
		text += tr("TOOLWORKCATEGORY") + ": " 
		for i in item.toolcategory:
			text += statdata.worktoolnames[i] +", "
		text = text.substr(0, text.length()-2) 
	if item.description != null:
		text += item.description
	if !item.reqs.empty():
		var tempslave = ResourceScripts.scriptdict.class_slave.new()
		text += "\n" + tempslave.decipher_reqs(item.reqs)
	text = globals.TextEncoder(text)
	return text	


func CreateItem():
	input_handler.PlaySound("itemcreate")
	#$NumberSelect/CreateItem.disabled = true
	enditem.substractitemcost()
	var time = 1.5
	ResourceScripts.core_animations.SmoothValueAnimation($NumberSelect/CraftProgress, time, 0, 100)
	yield(get_tree().create_timer(time), 'timeout')
	$NumberSelect/CraftProgress.value = 0
	input_handler.SystemMessage(tr("ITEMCREATED") +": " + enditem.name)
	globals.AddItemToInventory(enditem)
	selectcraftitem(Items.itemlist[itemtemplate])
	#$NumberSelect.hide()

func select_characters():
	get_parent().craft_state = "confirm"
	get_parent().match_state()

# func rebuild_craft_module(state):
# 	match state:
# 		"confirm":
# 			hide()
