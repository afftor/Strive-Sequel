extends "res://files/Close Panel Button/ClosingPanel.gd"

var chosenpartbutton
var itemparts = {}
var itemtemplate
var repairitemlist = []

#warning-ignore-all:return_value_discarded

func _ready():
	for i in [$ItemCreationWindow/Part1, $ItemCreationWindow/Part2, $ItemCreationWindow/Part3]:
		i.connect("pressed", self, 'choosematerial', [i])
	
	$ItemCreationWindow.hide()
	$ItemCreationWindow/MaterialSelect.hide()
	$ButtonPanel/CraftButton.connect("pressed", self, 'chooseitem')
	$ButtonPanel/RepairButton.connect('pressed', self, 'repairitems')
	$RepairPanel/RepairConfirm.connect("pressed", self, 'repairallitems')
	$RepairPanel/RepairAll.connect('pressed', self, 'selectallrepair')
	$ItemCreationWindow/CreateItem.connect("pressed", self, 'CreateItem')
	$RepairPanel.hide()
	$ItemSelection.hide()

	globals.AddPanelOpenCloseAnimation($ItemCreationWindow)
	globals.AddPanelOpenCloseAnimation($ItemSelection)
	globals.AddPanelOpenCloseAnimation($ItemCreationWindow/MaterialSelect)
	globals.AddPanelOpenCloseAnimation($RepairPanel)



func chooseitem():
	$RepairPanel.hide()
	$ItemSelection.show()
	globals.ClearContainer($ItemSelection/ScrollContainer/GridContainer)
	
	for i in Items.Items.values():
		if i.tags.has('recipe'):
			var check = true
			for k in i.unlockreqs:
				if state.valuecheck(k) == false:
					check = false
			if check == false:continue
			var newbutton = globals.DuplicateContainerTemplate($ItemSelection/ScrollContainer/GridContainer)
			newbutton.texture_normal = i.icon
			globals.connecttooltip(newbutton, '[center]' + i.name + "[/center]\n"+ i.description)
			newbutton.connect('pressed', self, 'selectcraftitem', [i])

func selectcraftitem(item):
	globals.hidetooltip()
	cleartemplate()
	itemtemplate = item.code
	$ItemCreationWindow.show()
	var array = []
	for i in item.parts:
		array.append(i)
	array.sort()
	itemparts.clear()
	
	for i in ['Part1','Part2','Part3']:
		get_node("ItemCreationWindow/" + i).texture_normal = null
		get_node("ItemCreationWindow/" + i + '/number').hide()
		get_node("ItemCreationWindow/" + i + 'Descript').bbcode_text = ''
	$ItemCreationWindow/EndItem.texture = null
	
	$ItemCreationWindow/Part1.set_meta('part',array[0])
	$ItemCreationWindow/Part1.set_meta('cost',item.parts[array[0]])
	$ItemCreationWindow/Part2.set_meta('part',array[1])
	$ItemCreationWindow/Part2.set_meta('cost',item.parts[array[1]])
	if array.size() < 3:
		$ItemCreationWindow/Part3.hide()
	else:
		$ItemCreationWindow/Part3.show()
		$ItemCreationWindow/Part3.set_meta('part',array[2])
		$ItemCreationWindow/Part3.set_meta('cost',item.parts[array[3]])


func choosematerial(button):
	globals.ClearContainer($ItemCreationWindow/MaterialSelect/Container/VBoxContainer)
	$ItemCreationWindow/MaterialSelect.show()
	chosenpartbutton = button
	var part = button.get_meta('part')
	var cost = button.get_meta('cost')
	
	var text = Items.Parts[part].name + ' - ' + tr('REQUIREDMATERIAL') + ': ' + str(cost)
	$ItemCreationWindow/MaterialSelect/PartLabel.text = text
	
	for i in Items.Materials.values():
		var tempmaterial = state.materials[i.code]
		if tempmaterial <= 0:
			continue
		for j in itemparts.values():
			if j.material == i.code:
				tempmaterial -= j.price
		if i.parts.has(part):
			if state.checkreqs(i.unlockreqs) == false:
				continue
			var newbutton = $ItemCreationWindow/MaterialSelect/Container/VBoxContainer/Button.duplicate()
			newbutton.show()
			$ItemCreationWindow/MaterialSelect/Container/VBoxContainer.add_child(newbutton)
			newbutton.get_node('Icon').texture = i.icon
			newbutton.get_node("amount").text = str(tempmaterial)
			newbutton.get_node("Label").text = i.name
			if tempmaterial < cost:
				newbutton.disabled = true
				newbutton.get_node("Label").text += '\nNot Enough Materials'
			globals.connecttooltip(newbutton, '[center]' + i.name + "[/center]\n" + i.description)
			newbutton.connect("pressed",self,'selectmaterial',[i, part, cost])
			

func cleartemplate():
	$ItemCreationWindow/CreateItem.disabled = true
	$ItemCreationWindow/EndItemDescript.bbcode_text = ''
	globals.disconnecttooltip($ItemCreationWindow/EndItem)

func selectmaterial(material, part, cost):
	globals.hidetooltip()
	itemparts[part] = {material = material.code, price = cost}
	chosenpartbutton.texture_normal = material.icon
	chosenpartbutton.get_node("number").text = str(cost)
	chosenpartbutton.get_node("number").show()
	var text = Items.Parts[part].name + "\n" 
	$ItemCreationWindow/MaterialSelect.hide()
	checkcreatingitem(itemtemplate)
	for i in material.parts[part]:
		if typeof(material.parts[part][i]) != TYPE_ARRAY:
			var endvalue = material.parts[part][i]
			if Items.Items[itemtemplate].basemods.has(i):
				endvalue = material.parts[part][i]*float(Items.Items[itemtemplate].basemods[i])
			if endvalue != 0:
				text += '\n' + Items.stats[i] + ': ' + str(endvalue)
		else:
			for k in material.parts[part][i]:
				text += '\n' + Effectdata.effects[k].descript
	get_node('ItemCreationWindow/' + chosenpartbutton.name + 'Descript').bbcode_text = text

var enditem

func checkcreatingitem(item):
	enditem = null
	var baseitem = Items.Items[item]
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
	
	$ItemCreationWindow/CreateItem.disabled = !fullrecipe
	
	
	var partdict = {}
	for i in itemparts:
		partdict[i] = itemparts[i].material
	enditem = globals.CreateGearItem(item, partdict)
	#enditem.CreateGear(item, partdict)
	text = enditem.tooltiptext()
	if fullrecipe == false:
		text += '\n\n[color=red]' + tr('SELECTMATERIAL') + '[/color]\n\n'
	else:
		text += '\n\n'
	
	globals.TextEncoder(text, $ItemCreationWindow/EndItemDescript)
	#globals.connecttooltip($ItemCreationWindow/EndItem, text)
	$ItemCreationWindow/EndItem.set_texture(baseitem.icon)
	input_handler.itemshadeimage($ItemCreationWindow/EndItem, enditem)


func CreateItem():
	input_handler.PlaySound("itemcreate")
	$ItemCreationWindow/CreateItem.disabled = true
	enditem.substractitemcost()
	var time = 1.5
	input_handler.SmoothValueAnimation($ItemCreationWindow/CraftProgress, time, 0, 100)
	yield(get_tree().create_timer(time), 'timeout')
	$ItemCreationWindow/CraftProgress.value = 0
	input_handler.SystemMessage(tr("ITEMCREATED") +": " + enditem.name)
	globals.AddItemToInventory(enditem)
	selectcraftitem(Items.Items[itemtemplate])
	#$ItemCreationWindow.hide()
	

func selectallrepair():
	for i in $RepairPanel/ScrollContainer/GridContainer.get_children():
		i.pressed = !i.pressed
		i.emit_signal('pressed')


func repairitems():
	$ItemCreationWindow.hide()
	$ItemSelection.hide()
	$RepairPanel.show()
	repairitemlist.clear()
	globals.ClearContainer($RepairPanel/ScrollContainer/GridContainer)
	for i in state.items.values():
		if i.itemtype != 'gear' || i.durability >= i.maxdurability:
			continue
		var newbutton = globals.DuplicateContainerTemplate($RepairPanel/ScrollContainer/GridContainer)
		input_handler.itemshadeimage(newbutton.get_node("Icon"), i)
		newbutton.get_node("Label").text = str(globals.calculatepercent(i.durability, i.maxdurability)) + "%"
		globals.connecttooltip(newbutton, geartooltip(i))
		newbutton.connect('pressed', self, 'selectrepairitem', [i])
		newbutton.set_meta("item", i)
	updaterepairlist()

func updaterepairlist():
	var canexecute = true
	globals.ClearContainer($RepairPanel/MatScrollContainer/HBoxContainer)
	
	var resourcedict = {}
	
	for i in repairitemlist:
		globals.MergeDicts(resourcedict,i.counterepairmaterials())
	
	for i in resourcedict:
		var material = Items.Materials[i]
		var newicon = globals.DuplicateContainerTemplate($RepairPanel/MatScrollContainer/HBoxContainer)
		newicon.texture = material.icon
		newicon.get_node("Label").text = str(resourcedict[i]) + '/' + str(state.materials[i])
		if resourcedict[i] > state.materials[i]:
			newicon.get_node('Label').set("custom_colors/font_color", Color(1,0,0))
			canexecute = false
		globals.connecttooltip(newicon, mattooltip(material))
	if repairitemlist.size() > 0:
		$RepairPanel/ResourceLabel.text = tr('REQUIREDMATERIALS')
	else:
		$RepairPanel/ResourceLabel.text = tr('SELECTREPAIR')
	$RepairPanel/RepairConfirm.disabled = !canexecute


func mattooltip(item):
	return ("[center]" + item.name + "[/center]\n" + item.description)

func geartooltip(item):
	return item.tooltip()



func selectrepairitem(item):
	if repairitemlist.has(item):
		repairitemlist.erase(item)
	else:
		repairitemlist.append(item)
	updaterepairlist()

func repairallitems():
	for i in repairitemlist:
		i.repairwithmaterials()
	repairitems()
	updaterepairlist()

func open():
	state.CurBuild = "blacksmith"
	input_handler.ShowGameTip('blacksmith')
	input_handler.emit_signal("BuildingEntered", 'blacksmith')
	.show()

func hide():
		state.CurBuild = "";
		.hide();
#var selectedrepairingitem
#
#func repairingitemselected(item):
#	var repairmaterials = item.counterepairmaterials()
#	input_handler.itemshadeimage($RepairItem/Panel/ItemRepairIcon, item)
#	globals.ClearContainer($RepairItem/Panel/RepairMaterials)
#
#	for i in repairmaterials:
#		var newimage = globals.DuplicateContainerTemplate($RepairItem/Panel/RepairMaterials/Button)
#		var material = Items.Materials[i]
#		newimage.texture = material.icon
#		newimage.get_node('amount').text = str(repairmaterials[i]) +'/'+ str(state.materials[i]) 
#		if state.materials[i] < repairmaterials[i]:
#			newimage.get_node('amount').set("custom_colors/font_color", Color(1,0,0))

