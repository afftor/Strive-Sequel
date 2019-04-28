extends "res://files/Close Panel Button/ClosingPanel.gd"

var character

var emptygearicons = {}

func _ready():
#warning-ignore:return_value_discarded
	$Traits.connect("pressed", $Traitlist, 'open')
#warning-ignore:return_value_discarded
	$ClassInfo.connect("pressed", self, 'ClassInfo')
	globals.AddPanelOpenCloseAnimation($ClassPanel)
	for i in globals.gearlist:
		var node = get_node('Main/Panel/charandgear/' + i)
		node.connect("pressed",self,'unequip', [i])

func open(hero):
	input_handler.ShowGameTip('character')
	for i in globals.gearlist:
		var node = get_node('Main/Panel/charandgear/' + i)
		if node.has_meta("item") && node.get_meta("item") != null:
			globals.disconnectitemtooltip(node, node.get_meta("item"))
			node.set_meta("item", null)
	if hero != character:
		$Traitlist.hide()
		$ClassPanel.hide()
	
	character = hero
	globals.CurrentScene.openinventory(character)
	show()
	for i in globals.gearlist:
		var node = get_node('Main/Panel/charandgear/' + i)
		if character.gear[i] != null:
			var gear = state.items[character.gear[i]]
			node.set_meta("item", gear)
			input_handler.itemshadeimage(node, gear)
			globals.connectitemtooltip(node, gear)
		else:
			node.texture_normal = null
	$Main/image.texture = images.sprites[character.image]
	$Main/Panel/charandgear/hp.value = globals.calculatepercent(character.hp, character.hpmax())
	$Main/Panel/charandgear/hp/Label.text = str(character.hp) + '/' + str(character.hpmax())
	$Main/Panel/charandgear/mp.value = globals.calculatepercent(character.mana, character.manamax())
	$Main/Panel/charandgear/mp/Label.text = str(character.mana) + '/' + str(character.manamax())
	$Main/Panel/charandgear/xp.value = character.baseexp
	
	$Name.text = character.name + ' Level: ' + str(character.level)
	
	for i in ['damage','armorpenetration','hitrate','speed','armor', 'mdef','evasion', 'resistfire','resistearth','resistwater','resistair']:
		var node = get_node("Main/stats&skills/" + i)
		var text = Items.stats[i] + ": " + str(character[i])
		node.text = text
	$"Main/stats&skills/crit".text = tr("CRITICAL") + ": "+str(character.critchance) + "%/" + str(character.critmod*100) + "%"
	
	globals.ClearContainer($Main/skillcontainer)
	for i in character.skills:
		var skill = Skillsdata.skilllist[i]
		var newbutton = globals.DuplicateContainerTemplate($Main/skillcontainer)
		#newbutton.get_node("Label").text = skill.name
		#newbutton.connect("pressed", self, "SkillTooltip", [skill])
		#globals.connecttooltip(newbutton, character.skill_tooltip_text(i))
		globals.connectskilltooltip(newbutton, i, hero)
		newbutton.get_node("Icon").texture = skill.icon

func unequip(slot):
	if character.gear[slot] != null:
		var gear = state.items[character.gear[slot]]
		character.unequip(gear)
		globals.disconnectitemtooltip(get_node('Main/Panel/charandgear/' + slot), gear)
		input_handler.GetItemTooltip().hide()
		open(character)

var classinfo = {
	warrior = 'WARRIORDESCRIPT',
	mage = 'MAGEDESCRIPT',
	archer = 'ARCHERDESCRIPT',
	brawler = 'BRAWLERDESCRIPT',
}
var classtrait = {
	mage = 'MAGETRAITDESCRIPT',
	archer = 'ARCHERTRAITDESCRIPT',
}
var geartypes = {
	sword = 'GEARSWORD',
	axe = 'GEARAXE',
	bow = 'GEARBOW',
	staff = 'GEARSTAFF',
	pickaxe = "GEARPICKAXE",
}


func ClassInfo():
	$ClassPanel.show()
	var text = tr(classinfo[character.combatclass])
	
	text += "\n\n[color=grey]" + tr("CLASSALLOWEDWEAPONS") + "[/color]: "
	for i in combatantdata.classlist[character.combatclass].gearsubtypes:
		if geartypes.has(i):
			text += tr(geartypes[i]) + ", "
	text = text.substr(0,text.length()-2) + '.'
	
	if character.combatclass in ['mage','archer']:
		text += "\n\n[color=purple]" + tr("CLASSTRAIT") + ": " + tr(classtrait[character.combatclass]) + '[/color]'
	$ClassPanel/RichTextLabel.bbcode_text = text
