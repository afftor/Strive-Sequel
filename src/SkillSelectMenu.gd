extends PopupPanel

var person
var trigger_node
var trigger_function

func open(character, category, triggernode, triggerfunction):
	person = character
	trigger_node = triggernode
	trigger_function = triggerfunction
	var skillarray = []
	match category:
		variables.PANEL_SOC:
			for i in person.social_skills:
				skillarray.append(Skilldata.Skilllist[i])
		variables.PANEL_COM:
			for i in person.combat_skills:
				skillarray.append(Skilldata.Skilllist[i])
	
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.get_node("Label").text = "Clear"
	newbutton.connect("pressed",self,"select", [null])
	for i in skillarray:
		newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node('icon').texture = i.icon
		newbutton.get_node("Label").text = i.name
		newbutton.connect("pressed", self, "select", [i.code])
		globals.connectskilltooltip(newbutton, i.code, person)
	rect_size.y = min(50 + skillarray.size() * 50+45, 500)
	popup()
	self.rect_position = get_global_mouse_position()
	var pos = get_global_rect()
	var screen = get_viewport().get_visible_rect()
	if get_rect().end.x > screen.size.x:
		rect_global_position.x -= get_rect().end.x - screen.size.x
	if get_rect().end.y > screen.size.y:
		rect_global_position.y -= get_rect().end.y - screen.size.y

func select(skill):
	hide()
	trigger_node.call(trigger_function, skill)