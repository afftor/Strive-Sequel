extends "res://files/Close Panel Button/ClosingPanel.gd" 

var character


func open():
	character = get_parent().character
	get_parent().open(character)
	globals.hidetooltip()
	var charclass = character.base
	var text = tr('TRAITPOINTS') + ": "
	
	var usedpoints = 0
	show()
	for i in character.traits:
		if character.traits[i] == true:
			usedpoints += Traitdata.traitlist[i].cost
	
	text += str(usedpoints) + "/" + str(character.traitpoints+usedpoints)
	
	$Label.text = text
	
	globals.ClearContainer($ScrollContainer/GridContainer)
	for i in Traitdata.traitlist.values():
		if !i.req_class.has("all") && !i.req_class.has(character.base):
			continue
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/GridContainer)
		newbutton.connect("pressed",self,"activatetrait", [i])
		if character.traits.has(i.code):
			newbutton.material = null
			if character.traits[i.code] == true:
				newbutton.get_node("Padding").material = null
		newbutton.texture_normal = i.icon
		text = i.description + '\n\n' + tr("TRAITPOINTSCOST") + ": " + str(i.cost)
		if character.traits.has(i.code) == false:
			text += "\n" + tr("GOLDPRICE") + ": " + str(i.price)
		globals.connecttooltip(newbutton, text)

var selectedtrait

func activatetrait(trait):
	selectedtrait = trait
	if character.traits.has(trait.code):
		if character.traits[trait.code] == true:
			character.deactivate_trait(trait.code)
			open()
		else:
			character.activate_trait(trait.code)
			open()
	else:
		if trait.price <= state.money:
			input_handler.ShowConfirmPanel(self, 'purchasetrait', tr("PURCHASETHISTRAIT") + ": " + str(trait.price) + tr("GOLD") + "?")
		else:
			input_handler.SystemMessage(tr("NOTENOUGHGOLD"))
		#purchasesuggestion

func purchasetrait():
	character.add_trait(selectedtrait.code)
	state.money -= selectedtrait.price
	open()