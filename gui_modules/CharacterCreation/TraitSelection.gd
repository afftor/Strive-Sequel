extends Panel

func _ready():
	$Cancel.connect("pressed",self,"hide")

var person

func build_sex():
	person = get_parent().person
	input_handler.ClearContainer($ScrollContainer/VBoxContainer, ['Button'])
	for i in Traitdata.sex_traits.values():
		if i.starting == false || person.checkreqs(i.acquire_reqs) == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.text = i.name
		if person.check_trait(i.code):
			newbutton.pressed = true
		newbutton.connect("pressed", get_parent(), "select_sex_trait", [i.code])
		globals.connecttexttooltip(newbutton, person.translate(i.descript))
	show()


func build_trait():
	person = get_parent().person
	input_handler.ClearContainer($ScrollContainer/VBoxContainer, ['Button'])
	for i in Traitdata.traits.values():
		if !i.tags.has('can_start'):
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.text = i.name
		if person.check_trait(i.code):
			newbutton.pressed = true
		newbutton.connect("pressed", get_parent(), "select_trait", [i.code])
		globals.connecttexttooltip(newbutton, person.translate(i.descript))
	show()
