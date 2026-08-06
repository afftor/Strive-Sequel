extends Control

var craft_category = 'cooking'
var current_craft_list = 'cooking_materials'
var item_filter = 'all'
var selected_item
var recipes = []
var default_part_texture = preload("res://assets/Textures_v2/MANSION/Craft/Buttons/button_craftchoose.png")

var itemtemplate
var itemparts = {}
var chosenpartbutton
#warning-ignore-all:return_value_discarded
var repeats = 1
var cap_low = 1
var cap_up = 999
var num_select_expanded = false

var cancelentry
var partdict

var enditem

func _ready():
	# input_handler.AddPanelOpenCloseAnimation($NumberSelect)
	$NumberSelect/NumberConfirm.connect("pressed", self, "open_number_select")
	$NumberSelect/NumberConfirm2.connect("pressed", self, "confirm_unique")
	globals.connecttexttooltip($NumberSelect/TextureRect, tr("TOOLTIPPROGRESSREQUIRED"))
	$CraftSelect/BackButton.connect("pressed", get_parent(), "mansion_state_set", ["default"])
	# input_handler.AddPanelOpenCloseAnimation($MaterialSelect)
	
	$NumberSelect2/CloseButton.connect('pressed', self, 'close_number_select')
	$NumberSelect2/Screen.connect('pressed', self, 'close_number_select')
	$NumberSelect2/VBoxContainer/HBoxContainer1/pt1/b1.connect('pressed', self, 'number_change', [-10])
	$NumberSelect2/VBoxContainer/HBoxContainer1/pt1/b2.connect('pressed', self, 'number_change', [-1])
	$NumberSelect2/VBoxContainer/HBoxContainer1/pt3/b3.connect('pressed', self, 'number_change', [1])
	$NumberSelect2/VBoxContainer/HBoxContainer1/pt3/b4.connect('pressed', self, 'number_change', [10])
	$NumberSelect2/VBoxContainer/AdvOption/HBoxContainer/TextureButton.connect('pressed', self, 'toggle_num_select_mode')
	$NumberSelect2/VBoxContainer/HBoxContainer2/pt1/b1.connect('pressed', self, 'cap_up_change', [-10])
	$NumberSelect2/VBoxContainer/HBoxContainer2/pt1/b2.connect('pressed', self, 'cap_up_change', [-1])
	$NumberSelect2/VBoxContainer/HBoxContainer2/pt3/b3.connect('pressed', self, 'cap_up_change', [1])
	$NumberSelect2/VBoxContainer/HBoxContainer2/pt3/b4.connect('pressed', self, 'cap_up_change', [10])
	$NumberSelect2/VBoxContainer/HBoxContainer3/pt1/b1.connect('pressed', self, 'cap_low_change', [-10])
	$NumberSelect2/VBoxContainer/HBoxContainer3/pt1/b2.connect('pressed', self, 'cap_low_change', [-1])
	$NumberSelect2/VBoxContainer/HBoxContainer3/pt3/b3.connect('pressed', self, 'cap_low_change', [1])
	$NumberSelect2/VBoxContainer/HBoxContainer3/pt3/b4.connect('pressed', self, 'cap_low_change', [10])
	$NumberSelect2/VBoxContainer/Button.connect('pressed', self, 'confirm_craft')
	$NumberSelect2/VBoxContainer/Button2.connect('pressed', self, 'confirm_craft_edit')
	for i in $categories.get_children():
		i.connect("pressed", self, 'select_category', [i.name])
	for i in $filter.get_children():
		i.connect('pressed',self, 'set_filter', [i.name])
		globals.connecttexttooltip(i, tr(filtercategories[i.name]))
	input_handler.register_btn_source('bread_button', self, 'tut_get_bread_btn')
	input_handler.register_btn_source('craft_confirm_button', self, 'tut_get_confirm_btn')
	input_handler.register_btn_source('craft_plus_button', self, 'tut_get_plus_btn')
	input_handler.register_btn_source('craft_confirm2_button', self, 'tut_get_confirm2_btn')
	input_handler.register_btn_source('craft_back_button', self, 'tut_get_back_btn')
	input_handler.register_btn_source('smith_button', self, 'tut_get_smith_cat_btn')
	input_handler.register_btn_source('cooking_button', self, 'tut_get_cooking_cat_btn')
	input_handler.register_btn_source('craft_matfilter_button', self, 'tut_get_mat_filter_btn')
	input_handler.register_btn_source('steel_button', self, 'tut_get_steel_btn')
	input_handler.register_btn_source('bread_delete', self, 'tut_get_bread_delete_btn')


func tut_get_bread_btn():
	return tut_get_recipe_btn("bread")
func tut_get_steel_btn():
	return tut_get_recipe_btn("steel")
func tut_get_recipe_btn(recipe):
	for btn in $CraftSelect/ScrollContainer/VBoxContainer.get_children():
		if btn.get_meta('item', {code = ""}).code == recipe:
			return btn
func tut_get_confirm_btn():
	return $NumberSelect/NumberConfirm
func tut_get_plus_btn():
	return $NumberSelect2/VBoxContainer/HBoxContainer1/pt3/b4
func tut_get_confirm2_btn():
	return $NumberSelect2/VBoxContainer/Button
func tut_get_back_btn():
	return $CraftSelect/BackButton
func tut_get_smith_cat_btn():
	return $categories/smith
func tut_get_cooking_cat_btn():
	return $categories/cooking
func tut_get_mat_filter_btn():
	return $filter/materials
func tut_get_bread_delete_btn():
	for btn in $CraftSchedule/ScrollContainer/VBoxContainer.get_children():
		var selected_craft = btn.get_meta("selected_craft", "")
		if !selected_craft.empty():
			var pdata = ResourceScripts.game_res.tasks_progresses[selected_craft]
			if pdata.id == "bread":
				return btn.get_node("DeleteButton")

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
	all = "CRAFTFILTERALL",
	materials = "CRAFTFILTERMATERIALS",
	gear = "CRAFTFILTERGEAR",
	costume = "CRAFTFILTERCOSTUME",
	usables = "CRAFTFILTERUSABLES",
}


func update():
	for i in $categories.get_children():
		i.pressed = false
		# i.get_node("Label").add_color_override("font_color", Color(224,244,244,255))
	select_category(craft_category)
	$CraftSchedule.show()
	# $CraftSelect.hide()


func open():
	close_number_select()
	show()
	gui_controller.clock.hide()
	for i in craftcategories:
		$categories.get_node(i).visible = globals.checkreqs(craftcategories[i].reqs)
	if craft_category != null:
		select_category(craft_category)
	input_handler.ActivateTutorial('TUTORIALLIST2')


func clear():
	craft_category = null
	input_handler.ClearContainer($CraftSchedule/VBoxContainer)
	input_handler.ClearContainer($CraftSelect/VBoxContainer)


func select_category(category):
	if category == 'enchant':
		$Enchant.open()
		return
	if category == 'improve':
		$Improve.open()
		return
	$MaterialSelect.hide()
	$MaterialSetupPanel.hide()
	$NumberSelect.hide()
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
		newbutton.get_node('Label').text = tr(item.name)
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
				var bonustext = "\n\n" + tr('CRAFTREQUIREDFOR') % str(i.materials[k])
				globals.connectmaterialtooltip(newnode,recipeitem, bonustext)
				newnode.texture = recipeitem.icon
				newnode.get_node("Label").text = str(i.materials[k])
		elif i.crafttype == 'modular':
			newbutton.get_node("icon").material = load("res://assets/ItemShader.tres").duplicate()
			for k in item.parts:
				var newnode = input_handler.DuplicateContainerTemplate(newbutton.get_node("HBoxContainer"))
				var partdata = Items.Parts[k]
				newnode.texture = partdata.icon
				globals.connecttexttooltip(newnode, tr('CRAFTMATERIALSREQUIREDFOR') % tr(partdata.name))
				newnode.get_node("Label").text = str(item.parts[k])


		var progressnode = newbutton.get_node("WorkUnits")
		progressnode.texture = images.get_icon(i.worktype)
		progressnode.get_node("Label").text = str(i.workunits)
		globals.connecttexttooltip(progressnode, tr('TOOLTIPPROGRESSREQUIRED'))


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
	input_handler.ClearContainer($CraftSchedule2/ScrollContainer/VBoxContainer)
	for i in ResourceScripts.game_res.crafting_lists[craft_category + '_material']:
		var pdata = ResourceScripts.game_res.tasks_progresses[i]
		var newnode = input_handler.DuplicateContainerTemplate($CraftSchedule/ScrollContainer/VBoxContainer)
		var recipe_data = Items.recipes[pdata.id]
		var item_data = Items.materiallist[recipe_data.resultitem]
		newnode.get_node("icon").texture = item_data.icon
		if pdata.has('repeat'):
			newnode.get_node("Label").text = tr(item_data.name) + ": " +  str(pdata.repeat) 
		else:
			newnode.get_node("Label").text = "%s: %d / %d" % [tr(item_data.name), pdata.cap_up, ResourceScripts.game_res.materials[recipe_data.resultitem]]
		newnode.connect("pressed", self, 'select_entry', [i])
		newnode.set_meta("selected_craft", i)
		newnode.get_node("DeleteButton").connect("pressed",self,'delete_from_queue', [i])
		newnode.get_node("ProgressBar").visible = true
		newnode.get_node("progress").visible = false
		newnode.get_node("ProgressBar").value = pdata.progress
		newnode.get_node("ProgressBar").max_value = pdata.progress_limit
		newnode.arraydata = i
		newnode.parentnodearray = ResourceScripts.game_res.crafting_lists[craft_category + '_material']
		newnode.target_node = self
		newnode.target_function = 'rebuild_scheldue'
	for i in ResourceScripts.game_res.crafting_lists[craft_category + '_item']:
		var pdata = ResourceScripts.game_res.tasks_progresses[i]
		var newnode = input_handler.DuplicateContainerTemplate($CraftSchedule2/ScrollContainer/VBoxContainer)
		var recipe_data = Items.recipes[pdata.id]
		var item_data = Items.itemlist[recipe_data.resultitem]
		newnode.get_node("icon").texture = item_data.icon
		if recipe_data.crafttype == 'modular':
			newnode.get_node("icon").material = load("res://assets/ItemShader.tres").duplicate()
		if pdata.has('repeat'):
			newnode.get_node("Label").text = tr(item_data.name) + ": " +  str(pdata.repeat) 
		else:
			newnode.get_node("Label").text = "%s: %d / %d" % [tr(item_data.name), pdata.cap_up, ResourceScripts.game_res.get_item_amount(recipe_data.resultitem)]
		newnode.connect("pressed", self, 'select_entry', [i])
		newnode.set_meta("selected_craft", i)
		newnode.get_node("DeleteButton").connect("pressed",self,'delete_from_queue', [i])
		newnode.get_node("progress").text = str(floor(pdata.progress)) + "/" + str(pdata.progress_limit)
		newnode.arraydata = i
		newnode.parentnodearray = ResourceScripts.game_res.crafting_lists[craft_category + '_item']
		newnode.target_node = self
		newnode.target_function = 'rebuild_scheldue'


#func craft_select(item):
#	selected_item = item
#	number_change(1)
#	$NumberSelect.show()


func confirm_craft():
#	$SelectCharacters.show()
	$NumberSelect2.hide()
	$MaterialSetupPanel.hide()
#	$CraftSchedule.show()
	var amount = {}
	if num_select_expanded:
		amount.max = cap_up
		amount.min = cap_low
	else:
		amount.fixed = repeats
	var parts = {}
	if selected_item.crafttype == 'modular':
		parts = partdict.duplicate()
	ResourceScripts.game_res.add_recipe_task(selected_item.code, parts, amount)
	select_category(craft_category)


func confirm_craft_edit():
#	$SelectCharacters.show()
	$NumberSelect2.hide()
	$MaterialSetupPanel.hide()
#	$CraftSchedule.show()
	if cancelentry == null: 
		return
	var pdata = ResourceScripts.game_res.tasks_progresses[cancelentry]
	if num_select_expanded:
		pdata.erase('repeat')
		pdata.cap_up = cap_up
		pdata.cap_low = cap_low
	else:
		pdata.repeat = repeats
	select_category(craft_category)


func confirm_unique():
#	$SelectCharacters.show()
	$NumberSelect.hide()
	$MaterialSetupPanel.hide()
	ResourceScripts.game_res.add_recipe_task(selected_item.code) #for unique recipes are not modular
	select_category(craft_category)


func delete_from_queue(entry):
	cancelentry = entry
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'cancel_item_craft', tr('CANCELTASKQUESTION')])


func select_entry(entry):
	cancelentry = entry
	for button in $CraftSchedule/ScrollContainer/VBoxContainer.get_children():
		if button.name == "Button":
			continue
		button.pressed = button.get_meta("selected_craft") == entry
	open_number_edit()


func cancel_item_craft():
	var entry = cancelentry
	ResourceScripts.game_res.clean_task(entry)
	select_category(craft_category)


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
	$NumberSelect/TextureRect.texture = images.get_icon(item.worktype)
	$NumberSelect/TextureRect.show()
	$NumberSelect/workunits.text = str(item.workunits)
	$NumberSelect/workunits.show()
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
	$NumberSelect/NumberConfirm.visible = true
	$NumberSelect/NumberConfirm2.visible = false
	if item.has('unique'):
		if item.unique:
			$NumberSelect/NumberConfirm.visible = false
			$NumberSelect/NumberConfirm2.visible = true
			if ResourceScripts.game_res.if_has_crafting_recipe(item.code):
				$NumberSelect/NumberConfirm2.visible = false
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
		var item_name = tr(baseitem.name)
		$MaterialSetupPanel/Label.text = item_name
		var font = input_handler.font_size_calculator($MaterialSetupPanel/Label)
		$MaterialSetupPanel/Label.set("custom_fonts/font", font)
		var encoded_text = str(globals.TextEncoder(tr(baseitem.descript)))
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
			newbutton.get_node("Name").text = tr(Items.itemlist[i].name)
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
			get_node(part_container + i + "/TextureRect").show()
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
			
			var temptext = '[center]' + tr(i.name) + "[/center]\n" + tr('CRAFTINPOSSESSION') + ": " + str(ResourceScripts.game_res.materials[i.code]) +  "\n" + tr('CRAFTPARTEFFECTS') + ":" + get_mat_bonuses(i, part)
			
			newbutton.get_node("name").text = tr(i.name)
			newbutton.set_meta('material', i.code)
			globals.connecttexttooltip(newbutton,temptext)
			
			newbutton.connect("pressed",self,'selectmaterial',[i, part, cost])
	yield(get_tree(),"idle_frame")
	container.get_parent().get_node("nomats").visible = container.get_node("VBoxContainer").get_children().size() <= 1
	container.get_parent().get_node("nomats").bbcode_text = tr("NOMATERIALSFORITEMPART")


func get_mat_bonuses(material, part):
	var text = ''
	var itemdata = Items.itemlist[itemtemplate]
	for k in material.parts[part]:
		var endvalue = material.parts[part][k]
		if endvalue is Array:
			for j in endvalue:
				text += '\n' + tr(Effectdata.effect_table[j].descript)
		elif endvalue is String:
			text += '\n' + tr(statdata.statdata[k].name) + ': ' + endvalue
		else:
			if itemdata.basemods.has(k):
				endvalue = endvalue * float(itemdata.basemods[k])
			if itemdata.itemtype == 'armor':
				endvalue = float(endvalue) / 2
			if endvalue != 0:
				var data
				if statdata.statdata.has(k):
					data = statdata.statdata[k]
				else:
					for suffix in ['add', 'add_part', 'add2', 'add_part2', 'mul', 'mul2', 'set', 'append', 'maxcap', 'mincap']:
						if k.ends_with('_' + suffix):
							data = statdata.statdata[k.trim_suffix('_' + suffix)]
							break
				text += '\n' + tr(data.name) + ': ' + str(endvalue)
			
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
			newbutton.get_node('icon').texture = i.icon
			newbutton.get_node("number").text = str(tempmaterial)
			newbutton.get_node("Label").text = tr(i.name)
			globals.connecttexttooltip(newbutton, '[center]' + tr(i.name) + "[/center]\n" + tr(i.descript))
			newbutton.connect("pressed",self,'selectmaterial',[i, part, cost])


func selectmaterial(material, part, cost):
	$filter.show()
	itemparts[part] = {material = material.code, price = cost}
	var text = tr(Items.Parts[part].name)
	$MaterialSelect.hide()
	$CraftSelect.show()
	for i in get_node("MaterialSetupPanel/ModularSetup/HBoxContainer").get_children():
		for k in i.get_node("ScrollContainer/VBoxContainer").get_children():
			if !i.get_node("ScrollContainer").has_meta('part'):
				continue
			var checkpart = i.get_node("ScrollContainer").get_meta('part')
			if itemparts.has(checkpart) && k.has_meta('material'):
				var is_pressed = itemparts[checkpart].material == k.get_meta('material')
				k.pressed = is_pressed
				var fontcolor = globals.fastif(is_pressed, variables.hexcolordict.yellow, variables.hexcolordict.white)
				k.get_node("name").set("custom_colors/font_color", Color(fontcolor))
			
			if checkpart == part:
				var temptext = tr(Items.Parts[part].name) + "\n" + tr(material.name) #+ ": " + str(cost)
				#i.get_node("number").text = str(cost)
				i.get_node("PartDescript").text = temptext 
	
	checkcreatingitem(itemtemplate)
	var itemdata = Items.itemlist[itemtemplate]
	text += globals.build_desc_for_bonusstats(material.parts[part])
			
#	get_node("MaterialSetupPanel/ModularSetup/" + chosenpartbutton.name + 'Descript').bbcode_text = text

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
		text += "\n" + tr(Items.materiallist[i].name) + ' - ' + str(resourcedict[i])

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
	$MaterialSetupPanel/Label.text = tr(baseitem.name)
	globals.TextEncoder(text, $MaterialSetupPanel/EndItemDescript)
	#globals.connecttooltip($NumberSelect/EndItem, text)
	enditem.set_icon($MaterialSetupPanel/EndItemFrame/EndItem)
#	$MaterialSetupPanel/EndItemFrame/EndItem.set_texture(baseitem.icon)
#	input_handler.itemshadeimage($MaterialSetupPanel/EndItemFrame/EndItem, enditem)


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
	#before the item is added: merging into an existing stack zeroes enditem.amount
	ResourceScripts.core_animations.ItemFlight(enditem, $NumberSelect, {amount = enditem.amount})
	globals.AddItemToInventory(enditem)
	selectcraftitem(Items.itemlist[itemtemplate])
	$NumberSelect.hide()


func close_number_select():
	$NumberSelect2.hide()


func open_number_select():
	repeats = 1
	num_select_expanded = false
	build_num_select()
	$NumberSelect2/VBoxContainer/Button2.visible = false
	$NumberSelect2/VBoxContainer/Button.visible = true
	$NumberSelect2.show()


func open_number_edit():
	if cancelentry == null: 
		return
	var pdata = ResourceScripts.game_res.tasks_progresses[cancelentry]
	selected_item = Items.recipes[pdata.id]
	if pdata.has('repeat'):
		num_select_expanded = false
		repeats = pdata.repeat
	else:
		num_select_expanded = true
		repeats = 1
		cap_up = pdata.cap_up
		cap_low = pdata.cap_low
	build_num_select()
	$NumberSelect2/VBoxContainer/Button2.visible = true
	$NumberSelect2/VBoxContainer/Button.visible = false
	$NumberSelect2.show()


func build_num_select():
	var item_data = Items.recipes[selected_item.code]
	var newitem = item_data.resultitem
	var amount
	if item_data.resultitemtype == 'material':
		var matdata = Items.materiallist[newitem]
		$NumberSelect2/Label2.text = "Craft %s" % tr(matdata.name)
		amount = ResourceScripts.game_res.materials[newitem]
		$NumberSelect2/VBoxContainer/icon.texture = matdata.icon
		$NumberSelect2/VBoxContainer/name.text = tr(matdata.name)
	else:
		amount = ResourceScripts.game_res.get_item_amount(newitem)
		var itemdata = Items.itemlist[newitem]
		$NumberSelect2/Label2.text = "Craft %s" % tr(itemdata.name)
		$NumberSelect2/VBoxContainer/icon.texture = itemdata.icon
		$NumberSelect2/VBoxContainer/name.text = tr(itemdata.name)
		if item_data.crafttype == 'modular':
			$NumberSelect2/VBoxContainer/icon.material = load("res://assets/ItemShader.tres").duplicate()
		else:
			$NumberSelect2/VBoxContainer/icon.material = null
	$NumberSelect2/VBoxContainer/HBoxContainer1/pt2/Amount.text = str(repeats)
	$NumberSelect2/VBoxContainer/HBoxContainer2/pt2/Amount.text = "%d (%d)" % [cap_up, amount]
	$NumberSelect2/VBoxContainer/HBoxContainer3/pt2/Amount.text = "%d (%d)" % [cap_low, amount]
	if num_select_expanded:
		$NumberSelect2/VBoxContainer/AdvOption/HBoxContainer/TextureButton.pressed = true
		$NumberSelect2/VBoxContainer/label1.visible = false
		$NumberSelect2/VBoxContainer/HBoxContainer1.visible = false
		$NumberSelect2/VBoxContainer/label2.visible = true
		$NumberSelect2/VBoxContainer/HBoxContainer2.visible = true
		$NumberSelect2/VBoxContainer/label3.visible = true
		$NumberSelect2/VBoxContainer/HBoxContainer3.visible = true
	else:
		$NumberSelect2/VBoxContainer/AdvOption/HBoxContainer/TextureButton.pressed = false
		$NumberSelect2/VBoxContainer/label1.visible = true
		$NumberSelect2/VBoxContainer/HBoxContainer1.visible = true
		$NumberSelect2/VBoxContainer/label2.visible = false
		$NumberSelect2/VBoxContainer/HBoxContainer2.visible = false
		$NumberSelect2/VBoxContainer/label3.visible = false
		$NumberSelect2/VBoxContainer/HBoxContainer3.visible = false


func toggle_num_select_mode():
	num_select_expanded = !num_select_expanded
	var item_data = Items.recipes[selected_item.code]
	var amount
	if item_data.resultitemtype == 'material':
		amount = ResourceScripts.game_res.materials[item_data.resultitem]
	else:
		amount = ResourceScripts.game_res.get_item_amount(item_data.resultitem)
	cap_up = amount + repeats
	cap_low = 1
	build_num_select()


func number_change(value):
	repeats += value
	if repeats < 1:
		repeats = 1
	build_num_select()


func cap_up_change(value):
	cap_up += value
	if cap_up < 1:
		cap_up = 1
	if cap_up < cap_low:
		cap_up = cap_low
	build_num_select()


func cap_low_change(value):
	cap_low += value
	if cap_low < 1:
		cap_low = 1
	if cap_up < cap_low:
		cap_low = cap_up
	build_num_select()
