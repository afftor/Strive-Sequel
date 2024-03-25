extends Control

var craft_category = "cooking"
var item_filter = 'all'
var selected_item
var recipes = []
var default_part_texture = preload("res://assets/Textures_v2/MANSION/Craft/Buttons/button_craftchoose.png")
#warning-ignore-all:return_value_discarded

# func _init():
# 	yield(Items, "tree_entered")


func _ready():
	# input_handler.AddPanelOpenCloseAnimation($NumberSelect)
	$NumberSelect/NumberConfirm.connect("pressed", self, "confirm_craft")
	$NumberSelect/HSlider.connect("value_changed", self, "number_change")
#	$SelectCharacters.connect("pressed", self, "select_characters")
	$CraftSelect/BackButton.connect("pressed", get_parent(), "mansion_state_set", ["default"])
	$NumberSelect/BackButton2.connect("pressed", self, "cancel_choise")
	globals.connecttexttooltip($NumberSelect/TextureRect, tr("TOOLTIPPROGRESSREQUIRED"))
	# input_handler.AddPanelOpenCloseAnimation($MaterialSelect)

#	for i in $MaterialSetupPanel/ModularSetup/HBoxContainer.get_children(): #[get_node(part_container)+"Part1, $MaterialSetupPanel/ModularSetup/Part2, $MaterialSetupPanel/ModularSetup/Part3]:
#		i.get_node('ResourceSelect').connect("pressed", self, 'choosematerial', [i])

	for i in $categories.get_children():
		i.connect("pressed", self, 'select_category', [i.name])
	for i in $filter.get_children():
		i.connect('pressed',self, 'set_filter', [i.name])
		i.hint_tooltip = filtercategories[i.name]

func cancel_choise():
	$NumberSelect.hide()
	$MaterialSetupPanel.hide()
	$CraftSchedule.show()
	#$SelectCharacters.show()


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
	$CraftSchedule.show()
	# $CraftSelect.hide()

func open():
	show()
	gui_controller.clock.hide()
	for i in craftcategories:
		$categories.get_node(i).visible = globals.checkreqs(craftcategories[i].reqs)
	if craft_category != null:
		select_category(craft_category)
	input_handler.ActivateTutorial('crafting')
	build_char_list()

func clear():
	craft_category = null
	input_handler.ClearContainer($CraftSchedule/VBoxContainer)
	input_handler.ClearContainer($CraftSelect/VBoxContainer)

func select_category(category):
	if category == 'enchant':
		$Enchant.open()
		return
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
				var bonustext = "\n\nRequired for Craft: " + str(i.materials[k])
				globals.connectmaterialtooltip(newnode,recipeitem, bonustext)
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
	input_handler.ClearContainer($CraftSchedule/ScrollContainer/VBoxContainer)
	for i in ResourceScripts.game_res.craftinglists[craft_category]:
		var newnode = input_handler.DuplicateContainerTemplate($CraftSchedule/ScrollContainer/VBoxContainer)
		var recipe = Items.recipes[i.code]
		var item = Items.get(recipe.resultitemtype + 'list')[recipe.resultitem]
		newnode.get_node("icon").texture = item.icon
		if item.type == 'gear' && item.crafttype == 'modular':
			newnode.get_node("icon").material = load("res://assets/ItemShader.tres").duplicate()
		newnode.get_node("Label").text = tr(item.name) + ": " + globals.fastif(i.repeats != -1,str(i.repeats),'∞')
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
#	$SelectCharacters.show()
	$NumberSelect.hide()
	$MaterialSetupPanel.hide()
#	$CraftSchedule.show()
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
	for button in $CraftSchedule/ScrollContainer/VBoxContainer.get_children():
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
#	$CraftSchedule.hide()
#	$SelectCharacters.hide()
	# $SelectCharacters.disabled = true
	selected_item = item
	itemtemplate = item.resultitem
	if item.resultamount > 1:
		$MaterialSetupPanel/EndItemFrame/Label.text = str(item.resultamount)
		$MaterialSetupPanel/EndItemFrame/Label.visible = true
	else:
		$MaterialSetupPanel/EndItemFrame/Label.visible = false
	$NumberSelect.show()
	$MaterialSetupPanel.show()
	get_node("MaterialSetupPanel/ModularSetup/").visible = item.crafttype != 'basic'
	get_node("MaterialSetupPanel/BasicSetup/").visible = !get_node("MaterialSetupPanel/ModularSetup/").visible
	# for i in ['Part1','Part2','Part3', 'Part1Descript', 'Part2Descript', 'Part3Descript', 'Label']:
	# 	get_node("MaterialSetupPanel/ModularSetup/" + i).visible = !item.crafttype == 'basic'
	if item.has('unique'):
		if item.unique:
			$NumberSelect/HSlider.value = 1
			$NumberSelect/HSlider.hide()
			for i in ResourceScripts.game_res.craftinglists[craft_category]:
				if i.code == item.code:
					$NumberSelect.hide()
	else:
		$NumberSelect/HSlider.show()
	$NumberSelect/workunits.text = str(selected_item.workunits)
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
		$MaterialSetupPanel/Label.text = item_name
		var font = input_handler.font_size_calculator($MaterialSetupPanel/Label)
		$MaterialSetupPanel/Label.set("custom_fonts/font", font)
		var encoded_text = str(globals.TextEncoder(baseitem.descript))
		$MaterialSetupPanel/EndItemDescript.bbcode_text = encoded_text
		var basic_setup_container = $MaterialSetupPanel/BasicSetup/ScrollContainer/VBoxContainer

		input_handler.ClearContainer(basic_setup_container)
		###
		for m in item.materials:
			var newbutton = input_handler.DuplicateContainerTemplate(basic_setup_container)
			newbutton.get_node("Icon").texture = Items.materiallist[m].icon
			newbutton.get_node("Reqs").text =  str(ResourceScripts.game_res.materials[m]) + "/" + str(item.materials[m])
			newbutton.get_node("Name").text = tr("MATERIAL" + m.to_upper())
			newbutton.disabled = item.materials[m] > ResourceScripts.game_res.materials[m]
			globals.connectmaterialtooltip(newbutton, Items.materiallist[m])
		for i in item.items:
			var amount = 0
			var newbutton = input_handler.DuplicateContainerTemplate(basic_setup_container)
			newbutton.get_node("Icon").texture = Items.itemlist[i].icon
			for item_id in ResourceScripts.game_res.items:
				var item_value = ResourceScripts.game_res.items[item_id]
				if item_value.code == i || item_value.itembase == i:
					if item_value.owner == null:
						amount += item_value.amount
			newbutton.get_node("Reqs").text = str(amount)+ "/" +str(item.items[i])
			newbutton.get_node("Name").text = str(Items.itemlist[i].name)
			newbutton.disabled = item.items[i] > amount
#			globals.connectitemtooltip_v2(newbutton, Items.itemlist[i])
	
	else:
		$NumberSelect/NumberConfirm.disabled = true
		$MaterialSetupPanel/Label.text = ''
		$MaterialSetupPanel/EndItemDescript.bbcode_text = ''
		item = Items.itemlist[item.resultitem]
		var array = []
		for i in item.parts:
			array.append(i)
		#array.sort()
		var part_container = "MaterialSetupPanel/ModularSetup/HBoxContainer/"
		itemparts.clear()
		for i in ['Part1','Part2','Part3']:
			get_node(part_container + i).texture = default_part_texture
			get_node(part_container + i + '/number').hide()
			get_node(part_container + i + '/PartDescript').text = ''
#			get_node("MaterialSetupPanel/ModularSetup/" + i + "/TextureRect").texture = placeholder
			get_node(part_container + i + "/TextureRect").show()
#			get_node(part_container + i + "/ResourceSelect/icon").texture = null
#			get_node(part_container + i + "/ResourceSelect/name").text = "Select Resource"
#			get_node(part_container + i + "/ResourceSelect/amount").text = ""
		$MaterialSetupPanel/EndItemFrame/EndItem.texture = null

		get_node(part_container+"Part1/ScrollContainer").set_meta('part',array[0])
		get_node(part_container+"Part1/ScrollContainer").set_meta('cost',item.parts[array[0]])
		get_node(part_container+"Part1/PartDescript").text = tr(Items.Parts[array[0]].name)
		make_material_list(get_node(part_container+"Part1/ScrollContainer"))
		get_node(part_container+"Part2").hide()
		get_node(part_container+"Part3").hide()
		get_node(part_container+"Part1/number").text = str(item.parts[array[0]])
		get_node(part_container+"Part1/number").show()
		get_node(part_container+"Part1/TextureRect").texture = Items.Parts[array[0]].icon
		match array.size():
			2:
				get_node(part_container+"Part2").show()
				get_node(part_container+"Part2/ScrollContainer").set_meta('part',array[1])
				get_node(part_container+"Part2/ScrollContainer").set_meta('cost',item.parts[array[1]])
				get_node(part_container+"Part2/number").text = str(item.parts[array[1]])
				get_node(part_container+"Part2/number").show()
				get_node(part_container+"Part2/PartDescript").text = tr(Items.Parts[array[1]].name)
				get_node(part_container+"Part2/TextureRect").texture = Items.Parts[array[1]].icon
				make_material_list(get_node(part_container+"Part2/ScrollContainer"))
			3:
				get_node(part_container+"Part2").show()
				get_node(part_container+"Part2/PartDescript").text = tr(Items.Parts[array[1]].name)
				get_node(part_container+"Part2/ScrollContainer").set_meta('part',array[1])
				get_node(part_container+"Part2/ScrollContainer").set_meta('cost',item.parts[array[1]])
				get_node(part_container+"Part2/number").text = str(item.parts[array[1]])
				get_node(part_container+"Part2/number").show()
				make_material_list(get_node(part_container+"Part2/ScrollContainer"))
				get_node(part_container+"Part2/TextureRect").texture = Items.Parts[array[1]].icon
				get_node(part_container+"Part3").show()
				get_node(part_container+"Part3/PartDescript").text = tr(Items.Parts[array[2]].name)
				get_node(part_container+"Part3/ScrollContainer").set_meta('part',array[2])
				get_node(part_container+"Part3/ScrollContainer").set_meta('cost',item.parts[array[2]])
				get_node(part_container+"Part3/number").text = str(item.parts[array[2]])
				get_node(part_container+"Part3/number").show()
				make_material_list(get_node(part_container+"Part3/ScrollContainer"))
				get_node(part_container+"Part3/TextureRect").texture = Items.Parts[array[2]].icon


func make_material_list(container):
	input_handler.ClearContainer(container.get_node("VBoxContainer"))
	
	var part = container.get_meta('part')
	var cost = container.get_meta('cost')

	var text = tr(Items.Parts[part].name) + ' - ' + tr('REQUIREDMATERIAL') + ': ' + str(cost)
	$MaterialSelect/PartLabel.text = text

	for i in Items.materiallist.values():
		var tempmaterial = ResourceScripts.game_res.materials[i.code]
		if !i.has("parts") || tempmaterial < 1:
			continue
		if i.parts.has(part):
			var newbutton = input_handler.DuplicateContainerTemplate(container.get_node("VBoxContainer"), 'Button')
#			var newbutton = $MaterialSelect/ScrollContainer/VBoxContainer/Button.duplicate()
#			newbutton.show()
#			$MaterialSelect/ScrollContainer/VBoxContainer.add_child(newbutton)
			newbutton.get_node('icon').texture = i.icon
			newbutton.get_node("amount").text = str(tempmaterial)
#			var part_name = "{color=k_yellow|" + tr(i.name) + '}'
#			var name_encoded = globals.TextEncoder(part_name)
#			var parttext = str(name_encoded) + "\n"
#			for k in i.parts[part]:
#				if Items.itemlist[itemtemplate].itemtype == 'armor':
#					parttext += statdata.statdata[k].name + ": " +  str(float(i.parts[part][k])/2) + ", "
#				else:
#					parttext += statdata.statdata[k].name + ": " +  str(i.parts[part][k]) + ", "
#			parttext = parttext.substr(0, parttext.length()-2)
#			newbutton.get_node("Label").bbcode_text = parttext

			var temptext = '[center]' + i.name + "[/center]\nIn possession: " + str(ResourceScripts.game_res.materials[i.code]) +  "\nPart Effects:" + get_mat_bonuses(i, part)
				
			newbutton.get_node("name").text = i.name
			newbutton.set_meta('material', i.code)
			globals.connecttexttooltip(newbutton,temptext)
			
			
			newbutton.connect("pressed",self,'selectmaterial',[i, part, cost])

func get_mat_bonuses(material, part):
	var text = ''
	for k in material.parts[part]:
		if typeof(material.parts[part][k]) != TYPE_ARRAY:
			var endvalue = material.parts[part][k]
			if Items.itemlist[itemtemplate].basemods.has(k):
				endvalue = material.parts[part][k]*float(Items.itemlist[itemtemplate].basemods[k])
			if Items.itemlist[itemtemplate].itemtype == 'armor':
				endvalue = float(endvalue) / 2
			if endvalue != 0:
				text += '\n' + statdata.statdata[k].name + ': ' + str(endvalue)
		else:
			for j in material.parts[part][k]:
				text += '\n' + Effectdata.effects[j].descript
	return text

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
			var newbutton = input_handler.DuplicateContainerTemplate($MaterialSelect/ScrollContainer/VBoxContainer, 'Button')
#			var newbutton = $MaterialSelect/ScrollContainer/VBoxContainer/Button.duplicate()
#			newbutton.show()
#			$MaterialSelect/ScrollContainer/VBoxContainer.add_child(newbutton)
			newbutton.get_node('icon').texture = i.icon
			newbutton.get_node("number").text = str(tempmaterial)
#			var part_name = "{color=k_yellow|" + tr(i.name) + '}'
#			var name_encoded = globals.TextEncoder(part_name)
#			var parttext = str(name_encoded) + "\n"
#			for k in i.parts[part]:
#				if Items.itemlist[itemtemplate].itemtype == 'armor':
#					parttext += statdata.statdata[k].name + ": " +  str(float(i.parts[part][k])/2) + ", "
#				else:
#					parttext += statdata.statdata[k].name + ": " +  str(i.parts[part][k]) + ", "
#			parttext = parttext.substr(0, parttext.length()-2)
#			newbutton.get_node("Label").bbcode_text = parttext
			newbutton.get_node("Label").text = i.name
			globals.connecttexttooltip(newbutton, '[center]' + i.name + "[/center]\n" + i.descript)
			newbutton.connect("pressed",self,'selectmaterial',[i, part, cost])


func selectmaterial(material, part, cost):
	$filter.show()
	itemparts[part] = {material = material.code, price = cost}
#	chosenpartbutton.get_node("TextureRect").texture = material.icon
	#chosenpartbutton.get_node("ResourceSelect/icon").texture = material.icon
	# chosenpartbutton.get_node('TextureRect').hide()
	#chosenpartbutton.get_node("PartDescript").text = tr(Items.Parts[part].name)
	#chosenpartbutton.get_node("ResourceSelect/name").text = material.name
	#chosenpartbutton.get_node("ResourceSelect/amount").text = str(ResourceScripts.game_res.materials[material.code])
	#chosenpartbutton.get_node("ResourceSelect/amount").show()
	var text = tr(Items.Parts[part].name)
	$MaterialSelect.hide()
	$CraftSelect.show()
	for i in get_node("MaterialSetupPanel/ModularSetup/HBoxContainer").get_children():
		for k in i.get_node("ScrollContainer/VBoxContainer").get_children():
			var checkpart = i.get_node("ScrollContainer").get_meta('part')
			if itemparts.has(checkpart) && k.has_meta('material'):
				var is_pressed = itemparts[checkpart].material == k.get_meta('material')
				k.pressed = is_pressed
				var fontcolor = globals.fastif(is_pressed, variables.hexcolordict.yellow, variables.hexcolordict.white)
				k.get_node("name").set("custom_colors/font_color", Color(fontcolor))
			
			if checkpart == part:
				var temptext = tr(Items.Parts[part].name) + "\n" + material.name #+ ": " + str(cost)
				#i.get_node("number").text = str(cost)
				i.get_node("PartDescript").text = temptext 
	
	checkcreatingitem(itemtemplate)
	for i in material.parts[part]:
		if typeof(material.parts[part][i]) != TYPE_ARRAY:
			var endvalue = material.parts[part][i]
			if Items.itemlist[itemtemplate].basemods.has(i):
				endvalue = material.parts[part][i]*float(Items.itemlist[itemtemplate].basemods[i])
			if Items.itemlist[itemtemplate].itemtype == 'armor':
				endvalue = float(endvalue) / 2
			if endvalue != 0:
				if  statdata.statdata[i].percent:
					endvalue *= 100
				text += '\n' + statdata.statdata[i].name + ': ' + str(endvalue)
				if  statdata.statdata[i].percent:
					text += '%'
		else:
			for k in material.parts[part][i]:
				text += '\n' + Effectdata.effects[k].descript
#	get_node("MaterialSetupPanel/ModularSetup/" + chosenpartbutton.name + 'Descript').bbcode_text = text

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

	var temppartdict = {}
	for i in itemparts:
		temppartdict[i] = itemparts[i].material
	enditem = globals.CreateGearItemQuality(item, temppartdict, '') #item emulation, no enchants, no quality
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
	$MaterialSetupPanel/Label.text = baseitem.name
	globals.TextEncoder(text, $MaterialSetupPanel/EndItemDescript)
	#globals.connecttooltip($NumberSelect/EndItem, text)
	$MaterialSetupPanel/EndItemFrame/EndItem.set_texture(baseitem.icon)
	input_handler.itemshadeimage($MaterialSetupPanel/EndItemFrame/EndItem, enditem)


func multipart_item_text(item):
	var text = ''
	#text += '{color=k_yellow|' + item.name + '}\n'
	if item.geartype != null:
		text += tr('TYPE_LABEL') + ': ' + item.geartype + "\n"
	else:
		text += tr("TYPE_USABLE_LABEL") + "\n"

	if item.slots.size() > 0:
		text += tr("SLOTS_LABEL") + ": "
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
		var tempslave = ResourceScripts.scriptdict.class_slave.new("temp_tooltip_multipart")
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

func update_char_button(newbutton, person):
	var twork = person.get_work()
	match twork:
		'':
			if !person.has_status('basic_servitude') and !person.is_master():
				newbutton.get_node("job").text = tr('NOSERVITUDE')
				newbutton.pressed = false
				newbutton.disabled = true
			else:
				newbutton.get_node("job").text = tr('TASKREST')
				newbutton.pressed = false
				newbutton.disabled = false
		'learning', 'Assignment', 'disabled':
			newbutton.get_node("job").text = tr('CHAR_UNAVALIABLE')
			newbutton.pressed = false
			newbutton.disabled = true
		_:
			if Items.materiallist.has(twork):
				newbutton.get_node("job").text =  Items.materiallist[twork].name
			else:
				newbutton.get_node("job").text =  tasks.tasklist[twork].name
			newbutton.disabled = false
			newbutton.pressed = (twork == craft_category)


func build_char_list():
	input_handler.ClearContainer($CharList/VBoxContainer, ['Button'])
	for ch in ResourceScripts.game_party.character_order:
		var person = characters_pool.get_char_by_id(ch)
		var newbutton = input_handler.DuplicateContainerTemplate($CharList/VBoxContainer, 'Button')
		newbutton.get_node("name").text = person.get_stat("name")
		newbutton.get_node("Icon").texture = person.get_icon_small()
		newbutton.set_meta('character', ch)
		newbutton.connect('pressed', self, 'toggle_char', [ch])
		update_char_button(newbutton, person)


func update_char_list():
	for newbutton in $CharList/VBoxContainer.get_children():
		if !newbutton.has_meta('character'):
			continue
		var ch = newbutton.get_meta('character')
		var person = characters_pool.get_char_by_id(ch)
		update_char_button(newbutton, person)


func toggle_char(ch):
	var person = characters_pool.get_char_by_id(ch)
	if person.get_work() == craft_category:
		person.remove_from_task()
	else:
		person.assign_to_task(craft_category, craft_category)
	update_char_list()
