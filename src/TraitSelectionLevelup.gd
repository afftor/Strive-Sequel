extends TextureRect

var character

func _ready():
#warning-ignore:return_value_discarded
	$GoldButton.connect("pressed",self,'goldbuttonpress')
#	character = globals.combatant.new()
#	character.createfromname('Arron')
#	levelup(character)

func levelup(arg):
	character = arg
	show()
	$Portrait.texture = character.portrait_circle()
	globals.ClearContainer($HBoxContainer)
	var text = tr(character.namebase) + tr("LEVEUPTEXT")
	for i in combatantdata.classlist[character.combatclass].learnableskills:
		if combatantdata.classlist[character.combatclass].learnableskills[i] == character.level:
			text += "\nNew skill unlocked: "+"[color=aqua]" + Skillsdata.skilllist[i].name + "[/color]!"
	$Label.bbcode_text = text
	
	var array = character.get_lvup_traits()
	for i in array:
		var newtrait = Traitdata.traitlist[i]
		var newbutton = globals.DuplicateContainerTemplate($HBoxContainer)
		newbutton.get_node("Icon").texture = newtrait.icon
		newbutton.get_node("RichTextLabel").bbcode_text = newtrait.description
		newbutton.get_node("Button").connect("pressed", self, "selecttrait", [i])
		input_handler.ConnectSound(newbutton.get_node("Button"), 'button_click', 'pressed')

func selecttrait(trait):
	character.add_trait(trait)
	character.activate_trait(trait)
	hide()
	get_parent().levelupscheck()

func goldbuttonpress():
	state.money += 100
	hide()
	get_parent().levelupscheck()