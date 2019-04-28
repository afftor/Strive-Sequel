extends "res://files/Close Panel Button/ClosingPanel.gd"

var selectedhero

func _ready():
	globals.AddPanelOpenCloseAnimation($HeroHire)
#warning-ignore:return_value_discarded
	$HeroHire/Button.connect('pressed', self, 'hirehero')

func open():
	show()
	globals.ClearContainer($Panel/ScrollContainer/VBoxContainer)
	selectedhero = null
	for i in state.heroguild:
		var newhero = globals.DuplicateContainerTemplate($Panel/ScrollContainer/VBoxContainer)
		newhero.get_node('Icon').texture = i.icon
		newhero.get_node('Label').text = i.name
		newhero.get_node('Price').text = str(i.price)
		newhero.connect('pressed',self,'selecthero',[i])

func selecthero(hero):
	var text = ''
	$HeroHire.show()
	selectedhero = hero
	globals.ClearContainer($HeroHire/traits)
	
	$HeroHire/hp.text = str(hero.hp) + '/' + str(hero.hpmax)
	$HeroHire/mana.text = str(hero.mana) + '/' + str(hero.manamax)
	
	text += 'Name: ' + hero.name + '\nClass: ' + combatantdata.classlist[hero.base].name + '\nPrice: ' + str(hero.price)
	$HeroHire/RichTextLabel.bbcode_text = text
	
	for i in hero.traits:
		var trait = Traitdata.traitlist[i]
		var newlabel = globals.DuplicateContainerTemplate($HeroHire/traits)
		newlabel.text = trait.name
		globals.connecttooltip(newlabel,trait.description)
	
	$HeroHire/Button.disabled = state.money < hero.price

func hirehero():
	state.money -= selectedhero.price
	state.heroes[selectedhero.id] = selectedhero
	state.heroguild.erase(selectedhero)
	$HeroHire.hide()
	open()

func show():
	state.CurBuild = "HeroGuild"
	input_handler.emit_signal("BuildingEntered", "HeroGuild");
	.show();
	pass

func hide():
	state.CurBuild = "";
	.hide();