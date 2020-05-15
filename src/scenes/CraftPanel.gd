extends "res://src/scenes/ClosingPanel.gd"

var craft_category
var item_filter = 'all'
var selected_item
var recipes = []
#warning-ignore-all:return_value_discarded

func _ready():
	input_handler.AddPanelOpenCloseAnimation($NumberSelect)
	$NumberSelect/NumberConfirm.connect("pressed", self, "confirm_craft")
	$NumberSelect/HSlider.connect("value_changed", self, "number_change")
	input_handler.AddPanelOpenCloseAnimation($NumberSelect/MaterialSelect)
	
	for i in [$NumberSelect/MaterialSetupPanel/Part1, $NumberSelect/MaterialSetupPanel/Part2, $NumberSelect/MaterialSetupPanel/Part3]:
		i.connect("pressed", self, 'choosematerial', [i])
	
	for i in $categories.get_children():
		i.connect("pressed", self, 'select_category', [i.name])
	for i in $filter.get_children():
		i.connect('pressed',self, 'set_filter', [i.name])
		i.hint_tooltip = filtercategories[i.name]

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
	craft_category = category
	for i in $categories.get_children():
		i.pressed = i.name == category
	
	for i in $filter.get_children():
		i.pressed = false
	item_filter = 'all'
	$filter/all.pressed = true
	rebuild_recipe_list()
	rebuild_scheldue()

func rebuild_scheldue():
	input_handler.ClearContainer($CraftScheldue/VBoxContainer)
	
	for i in ResourceScripts.game_res.craftinglists[craft_category]:
		var newnode = input_handler.DuplicateContainerTemplate($CraftScheldue/VBoxContainer)
		var recipe = Items.recipes[i.code]
		var item = Items[recipe.resultitemtype + 'list'][recipe.resultitem]
		newnode.get_node("icon").texture = item.icon
		if item.type == 'gear' && item.crafttype == 'modular':
			newnode.get_node("icon").material = load("res://assets/ItemShader.tres").duplicate()
		newnode.get_node("Label").text = item.name + ": " + globals.fastif(i.repeats != -1,str(i.repeats),'∞')
		newnode.connect("pressed",self,'confirm_cancel_craft', [i])
		newnode.get_node("progress").text = str(floor(i.workunits)) + "/" + str(i.workunits_needed)
		newnode.arraydata = i
		newnode.parentnodearray = ResourceScripts.game_res.craftinglists[craft_category]
		newnode.target_node = self
		newnode.target_function = 'rebuild_scheldue'
	

func rebuild_recipe_list():
	var array = []
	input_handler.ClearContainer($CraftSelect/VBoxContainer)
	
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
		var newbutton = input_handler.DuplicateContainerTemplate($CraftSelect/VBoxContainer)
		var item
		if i.resultitemtype == 'item':
			item = Items.itemlist[i.resultitem]
			globals.connecttempitemtooltip(newbutton.get_node('icon'), item, 'geartemplate')
		else:
			item = Items.materiallist[i.resultitem]
			globals.connectmaterialtooltip(newbutton.get_node('icon'), item, '')
		newbutton.get_node("number").text = str(i.resultamount)
		newbutton.get_node('Label').text = item.name
		newbutton.connect("pressed", self, 'selectcraftitem', [i])
		newbutton.get_node('icon').texture = item.icon
		
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
		
		
		var progressnode = input_handler.DuplicateContainerTemplate(newbutton.get_node("HBoxContainer"))
		progressnode.texture = images.icons.craft_time
		progressnode.get_node("Label").text = str(i.workunits)
		progressnode.hint_tooltip = 'Progress required per craft'

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
	
	if enditem.name > enditem2.name:
		return false
	else:
		return true

var repeats = 1

func number_change(value):
	var text = ''
	$NumberSelect/HSlider.value = value
	repeats = value
	var visiblerepeats = str(repeats)
	if repeats >= 100:
		repeats = -1
		visiblerepeats = '∞'
	text = "Produce this item " + visiblerepeats + " times. "#" + selected_item.name + "
	$NumberSelect/RichTextLabel.bbcode_text = text
#
#func craft_select(item):
#	selected_item = item
#	number_change(1)
#	$NumberSelect.show()

func confirm_craft():
	$NumberSelect.hide()
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

func confirm_cancel_craft(entry):
	cancelentry = entry
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'cancel_item_craft', 'Cancel this task?'])
	#input_handler.ShowConfirmPanel(self, 'cancel_item_craft', 'Cancel this task?')

func cancel_item_craft():
	var entry = cancelentry
	ResourceScripts.game_res.craftinglists[craft_category].erase(entry)
	select_category(craft_category)

var itemtemplate
var itemparts = {}
var chosenpartbutton

func selectcraftitem(item):
	selected_item = item
	itemtemplate = item.resultitem
	$NumberSelect.show()
	
	if item.crafttype == 'basic':
		$NumberSelect/MaterialSetupPanel.hide()
		$NumberSelect/NumberConfirm.disabled = false
	else:
		$NumberSelect/NumberConfirm.disabled = true
		$NumberSelect/MaterialSetupPanel.show()
		$NumberSelect/MaterialSetupPanel/EndItemDescript.bbcode_text = ''
		item = Items.itemlist[item.resultitem]
		var array = []
		for i in item.parts:
			array.append(i)
		array.sort()
		itemparts.clear()
		
		for i in ['Part1','Part2','Part3']:
			get_node("NumberSelect/MaterialSetupPanel/" + i).texture_normal = null
			get_node("NumberSelect/MaterialSetupPanel/" + i + '/number').hide()
			get_node("NumberSelect/MaterialSetupPanel/" + i + 'Descript').bbcode_text = ''
			get_node("NumberSelect/MaterialSetupPanel/" + i + "/TextureRect").show()
		$NumberSelect/MaterialSetupPanel/EndItem.texture = null
		
		$NumberSelect/MaterialSetupPanel/Part1.set_meta('part',array[0])
		$NumberSelect/MaterialSetupPanel/Part1.set_meta('cost',item.parts[array[0]])
		$NumberSelect/MaterialSetupPanel/Part2.hide()
		$NumberSelect/MaterialSetupPanel/Part3.hide()
		match array.size():
			2:
				$NumberSelect/MaterialSetupPanel/Part2.show()
				$NumberSelect/MaterialSetupPanel/Part2.set_meta('part',array[1])
				$NumberSelect/MaterialSetupPanel/Part2.set_meta('cost',item.parts[array[1]])
			3:
				$NumberSelect/MaterialSetupPanel/Part2.show()
				$NumberSelect/MaterialSetupPanel/Part2.set_meta('part',array[1])
				$NumberSelect/MaterialSetupPanel/Part2.set_meta('cost',item.parts[array[1]])
				$NumberSelect/MaterialSetupPanel/Part3.show()
				$NumberSelect/MaterialSetupPanel/Part3.set_meta('part',array[2])
				$NumberSelect/MaterialSetupPanel/Part3.set_meta('cost',item.parts[array[3]])


func choosematerial(button):
	input_handler.ClearContainer($NumberSelect/MaterialSelect/Container/VBoxContainer)
	$NumberSelect/MaterialSelect.show()
	chosenpartbutton = button
	var part = button.get_meta('part')
	var cost = button.get_meta('cost')
	
	var text = tr(Items.Parts[part].name) + ' - ' + tr('REQUIREDMATERIAL') + ': ' + str(cost)
	$NumberSelect/MaterialSelect/PartLabel.text = text
	
	for i in Items.materiallist.values():
		var tempmaterial = ResourceScripts.game_res.materials[i.code]
		if !i.has("parts") || tempmaterial < 1:
			continue
		if i.parts.has(part):
			var newbutton = $NumberSelect/MaterialSelect/Container/VBoxContainer/Button.duplicate()
			newbutton.show()
			$NumberSelect/MaterialSelect/Container/VBoxContainer.add_child(newbutton)
			newbutton.get_node('Icon').texture = i.icon
			newbutton.get_node("amount").text = str(tempmaterial)
			var parttext = '[center]' + tr(i.name) + '[/center]\n'
			for k in i.parts[part]:
				if Items.itemlist[itemtemplate].itemtype == 'armor':
					parttext += statdata.statdata[k].name + ": " +  str(float(i.parts[part][k])/2) + ", "
				else:
					parttext += statdata.statdata[k].name + ": " +  str(i.parts[part][k]) + ", "
			parttext = parttext.substr(0, parttext.length()-2)
			newbutton.get_node("Label").bbcode_text = parttext
			globals.connecttexttooltip(newbutton, '[center]' + i.name + "[/center]\n" + i.descript)
			newbutton.connect("pressed",self,'selectmaterial',[i, part, cost])
			

func selectmaterial(material, part, cost):
	itemparts[part] = {material = material.code, price = cost}
	chosenpartbutton.texture_normal = material.icon
	chosenpartbutton.get_node('TextureRect').hide()
	chosenpartbutton.get_node("number").text = str(cost)
	chosenpartbutton.get_node("number").show()
	var text = tr(Items.Parts[part].name) + "\n" 
	$NumberSelect/MaterialSelect.hide()
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
	get_node('NumberSelect/MaterialSetupPanel/' + chosenpartbutton.name + 'Descript').bbcode_text = text

var enditem

func checkcreatingitem(item):
	enditem = null
	var baseitem = Items.itemlist[item]
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
	text = enditem.tooltiptext()
	if fullrecipe == false:
		text += '\n\n[color=red]' + tr('SELECTMATERIAL') + '[/color]\n\n'
		$NumberSelect/NumberConfirm.disabled = true
	else:
		text += '\n\n'
		$NumberSelect/NumberConfirm.disabled = false
	
	globals.TextEncoder(text, $NumberSelect/MaterialSetupPanel/EndItemDescript)
	#globals.connecttooltip($NumberSelect/EndItem, text)
	$NumberSelect/MaterialSetupPanel/EndItem.set_texture(baseitem.icon)
	input_handler.itemshadeimage($NumberSelect/MaterialSetupPanel/EndItem, enditem)


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

