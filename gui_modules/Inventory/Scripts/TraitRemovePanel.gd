extends "res://src/scenes/ClosingPanel.gd"

var person
onready var list = $ScrollContainer/VBoxContainer

func open(character):
	person = character
	input_handler.ClearContainer(list)
	for tr_id in person.get_traits_by_tag('negative') + person.get_traits_by_tag('neutral') + person.get_traits_by_tag('positive'):
		var trdata = Traitdata.traits[tr_id]
		if trdata.has('tags') and trdata.tags.has('permanent'): continue
		if !trdata.visible: continue
		var newnode = input_handler.DuplicateContainerTemplate(list)
		newnode.get_node('name').text = tr(trdata.name)
		newnode.get_node('desc').text = tr(trdata.descript)
		newnode.connect('pressed', self, 'traitpress', [tr_id])
		if  trdata.has('tags') and trdata.tags.has('simple_icon'):
			if trdata.icon is String:
				newnode.get_node('Button').texture = load(trdata.icon)
			else:
				newnode.get_node('Button').texture = trdata.icon
		else:
			if trdata.has('icon') and trdata.icon != null:
				if trdata.icon is String:
					newnode.get_node('Button/icon').texture = load(trdata.icon)
				else:
					newnode.get_node('Button/icon').texture = trdata.icon
				if trdata.has('cross') and trdata.cross:
					newnode.get_node('Button/cross').visible = true
				else:
					newnode.get_node('Button/cross').visible = false
					if trdata.tags.has('positive'):
						newnode.get_node('Button').texture = load("res://assets/images/iconstraits/green.png")
					if trdata.tags.has('negative'):
						newnode.get_node('Button').texture = load("res://assets/images/iconstraits/red.png")
	show()


func traitpress(tr_id):
	person.remove_trait(tr_id)
	ResourceScripts.game_res.remove_item("trait_removal", 1)
	if gui_controller.inventory != null && gui_controller.inventory.is_visible():
		gui_controller.inventory.set_active_hero(person)
	hide()



func hide():
	if !visible: return
	.hide()
