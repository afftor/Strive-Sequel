extends "res://files/Close Panel Button/ClosingPanel.gd"

var craft_category
var selected_item
var recipes = []
#warning-ignore-all:return_value_discarded

func _ready():
	globals.AddPanelOpenCloseAnimation($NumberSelect)
	$NumberSelect/NumberConfirm.connect("pressed", self, "confirm_craft")
	$NumberSelect/HSlider.connect("value_changed", self, "number_change")
	globals.AddPanelOpenCloseAnimation($NumberSelect/MaterialSelect)
	
	for i in [$NumberSelect/MaterialSetupPanel/Part1, $NumberSelect/MaterialSetupPanel/Part2, $NumberSelect/MaterialSetupPanel/Part3]:
		i.connect("pressed", self, 'choosematerial', [i])
	
	for i in $categories.get_children():
		i.connect("pressed", self, 'select_category', [i.name])

var craftcategories = {
	cook = {reqs = []},
	tailor = {reqs = [{type = "has_upgrade", name = 'tailor', value = 1}]},
	alchemy = {reqs = [{type = "has_upgrade", name = 'alchemy', value = 1}]},
	smith = {reqs = [{type = "has_upgrade", name = 'forge', value = 1}]},
}

func open():
	show()
	for i in craftcategories:
		$categories.get_node(i).visible = state.checkreqs(craftcategories[i].reqs)
	if craft_category != null:
		select_category(craft_category)

func clear():
	craft_category = null
	globals.ClearContainer($CraftScheldue/VBoxContainer)
	globals.ClearContainer($CraftSelect/VBoxContainer)

func select_category(category):
	craft_category = category
	globals.ClearContainer($CraftScheldue/VBoxContainer)
	globals.ClearContainer($CraftSelect/VBoxContainer)
	for i in Items.recipes.values():
		if i.worktype != category || state.checkreqs(i.unlockreqs) == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($CraftSelect/VBoxContainer)
		var item
		if i.resultitemtype == 'item':
			item = Items.itemlist[i.resultitem]
			globals.connecttempitemtooltip(newbutton.get_node('icon'),item)
		else:
			item = Items.materiallist[i.resultitem]
			globals.connectmaterialtooltip(newbutton.get_node('icon'),item)
		newbutton.get_node("number").text = str(i.resultamount)
		newbutton.get_node('Label').text = item.name
		newbutton.connect("pressed", self, 'selectcraftitem', [i])
		newbutton.get_node('icon').texture = item.icon
		
		if i.crafttype == 'basic':
			for k in i.items:
				var newnode = globals.DuplicateContainerTemplate(newbutton.get_node("HBoxContainer"))
				var recipeitem = Items.itemlist[k]
				newnode.texture = recipeitem.icon
				newnode.get_node("Label").text = str(i.items[k])
			for k in i.materials:
				var newnode = globals.DuplicateContainerTemplate(newbutton.get_node("HBoxContainer"))
				var recipeitem = Items.materiallist[k]
				globals.connectmaterialtooltip(newnode,recipeitem)
				newnode.texture = recipeitem.icon
				newnode.get_node("Label").text = str(i.materials[k])
		elif i.crafttype == 'modular':
			newbutton.get_node("icon").material = load("res://files/ItemShader.tres")
			for k in item.parts:
				var newnode = globals.DuplicateContainerTemplate(newbutton.get_node("HBoxContainer"))
				var partdata = Items.Parts[k]
				newnode.texture = partdata.icon
				newnode.hint_tooltip = "Materials required for: " + partdata.name
				newnode.get_node("Label").text = str(item.parts[k])
		
		
		var progressnode = globals.DuplicateContainerTemplate(newbutton.get_node("HBoxContainer"))
		progressnode.texture = load("res://assets/images/gui/taskmenu/timeicon.png")
		progressnode.get_node("Label").text = str(i.workunits)
		progressnode.hint_tooltip = 'Progress required per craft'
	
	
	for i in state.craftinglists[category]:
		var newnode = globals.DuplicateContainerTemplate($CraftScheldue/VBoxContainer)
		var recipe = Items.recipes[i.code]
		var item = Items[recipe.resultitemtype + 'list'][recipe.resultitem]
		newnode.get_node("icon").texture = item.icon
		newnode.get_node("Label").text = item.name + ": " + globals.fastif(i.repeats != -1,str(i.repeats),'∞')
		newnode.connect("pressed",self,'confirm_cancel_craft', [i])
		newnode.get_node("progress").text = str(floor(i.workunits)) + "/" + str(i.workunits_needed)

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
	state.craftinglists[list].append(data)
	if selected_item.crafttype == 'modular':
		data.partdict = partdict.duplicate()
	
	select_category(craft_category)

var cancelentry
var partdict

func confirm_cancel_craft(entry):
	cancelentry = entry
	input_handler.ShowConfirmPanel(self, 'cancel_item_craft', 'Cancel this task?')

func cancel_item_craft():
	var entry = cancelentry
	state.craftinglists[craft_category].erase(entry)
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
		
		
	else:
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
		$NumberSelect/MaterialSetupPanel/EndItem.texture = null
		
		$NumberSelect/MaterialSetupPanel/Part1.set_meta('part',array[0])
		$NumberSelect/MaterialSetupPanel/Part1.set_meta('cost',item.parts[array[0]])
		$NumberSelect/MaterialSetupPanel/Part2.set_meta('part',array[1])
		$NumberSelect/MaterialSetupPanel/Part2.set_meta('cost',item.parts[array[1]])
		if array.size() < 3:
			$NumberSelect/MaterialSetupPanel/Part3.hide()
		else:
			$NumberSelect/MaterialSetupPanel/Part3.show()
			$NumberSelect/MaterialSetupPanel/Part3.set_meta('part',array[2])
			$NumberSelect/MaterialSetupPanel/Part3.set_meta('cost',item.parts[array[3]])


func choosematerial(button):
	globals.ClearContainer($NumberSelect/MaterialSelect/Container/VBoxContainer)
	$NumberSelect/MaterialSelect.show()
	chosenpartbutton = button
	var part = button.get_meta('part')
	var cost = button.get_meta('cost')
	
	var text = Items.Parts[part].name + ' - ' + tr('REQUIREDMATERIAL') + ': ' + str(cost)
	$NumberSelect/MaterialSelect/PartLabel.text = text
	
	for i in Items.materiallist.values():
		var tempmaterial = state.materials[i.code]
#		if tempmaterial <= 0:
#			continue
#		for j in itemparts.values():
#			if j.material == i.code:
#				tempmaterial -= j.price
		if !i.has("parts"):
			continue
		if i.parts.has(part):
			var newbutton = $NumberSelect/MaterialSelect/Container/VBoxContainer/Button.duplicate()
			newbutton.show()
			$NumberSelect/MaterialSelect/Container/VBoxContainer.add_child(newbutton)
			newbutton.get_node('Icon').texture = i.icon
			newbutton.get_node("amount").text = str(tempmaterial)
			newbutton.get_node("Label").text = i.name
#			if tempmaterial < cost:
#				newbutton.disabled = true
#				newbutton.get_node("Label").text += '\nNot Enough Materials'
			globals.connecttexttooltip(newbutton, '[center]' + i.name + "[/center]\n" + i.descript)
			newbutton.connect("pressed",self,'selectmaterial',[i, part, cost])
			

func selectmaterial(material, part, cost):
	itemparts[part] = {material = material.code, price = cost}
	chosenpartbutton.texture_normal = material.icon
	chosenpartbutton.get_node("number").text = str(cost)
	chosenpartbutton.get_node("number").show()
	var text = Items.Parts[part].name + "\n" 
	$NumberSelect/MaterialSelect.hide()
	checkcreatingitem(itemtemplate)
	for i in material.parts[part]:
		if typeof(material.parts[part][i]) != TYPE_ARRAY:
			var endvalue = material.parts[part][i]
			if Items.itemlist[itemtemplate].basemods.has(i):
				endvalue = material.parts[part][i]*float(Items.itemlist[itemtemplate].basemods[i])
			if endvalue != 0:
				text += '\n' + Items.stats[i] + ': ' + str(endvalue)
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
	input_handler.SmoothValueAnimation($NumberSelect/CraftProgress, time, 0, 100)
	yield(get_tree().create_timer(time), 'timeout')
	$NumberSelect/CraftProgress.value = 0
	input_handler.SystemMessage(tr("ITEMCREATED") +": " + enditem.name)
	globals.AddItemToInventory(enditem)
	selectcraftitem(Items.itemlist[itemtemplate])
	#$NumberSelect.hide()

