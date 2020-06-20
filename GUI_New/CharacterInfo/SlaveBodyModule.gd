extends Panel


var person
onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD)


func _ready():
	update()


func update():
	person = GUIWorld.gui_data["MANSION"].main_module.active_person
	if person != null:
		$Body.texture = person.get_body_image()

		input_handler.ClearContainer($buffscontainer)
		for i in person.get_mansion_buffs():
			var newnode = input_handler.DuplicateContainerTemplate($buffscontainer)
			newnode.texture = i.icon
			if i.get_duration() != null and i.get_duration() >= 0:
				newnode.get_node("Label").text = str(i.get_duration())
			else:
				newnode.get_node("Label").hide()
				newnode.hint_tooltip = person.translate(i.description)
