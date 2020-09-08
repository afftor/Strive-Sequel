extends Panel


var person
#onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)


#func _ready():
#	update()


func update(person = null):
#	if GUIWorld.BaseScene == null:
#		return
	if person == null:
		person = gui_controller.mansion.active_person
		if gui_controller.previous_screen != null && gui_controller.previous_screen == gui_controller.exploration:
			person = gui_controller.exploration.person_to_hire
	# if person != null:
	$Body.texture = person.get_body_image()

	input_handler.ClearContainer($buffscontainer)
	for i in person.get_mansion_buffs():
		var newnode = input_handler.DuplicateContainerTemplate($buffscontainer)
		newnode.texture = i.icon
		if i.get_duration() != null and i.get_duration() >= 0:
			newnode.get_node("Label").text = str(i.get_duration())
		else:
			newnode.get_node("Label").hide()
		globals.connecttexttooltip(newnode, person.translate(i.description))
	input_handler.ClearContainer($professions)
	if person.xp_module.professions.size() > 6:
		$professions.columns = 12
		$professions.set("custom_constants/hseparation", 6)
		$professions/Button.rect_min_size = Vector2(50,50)
		$professions/Button/TextureRect.rect_size = Vector2(34,34)
		$professions/Button/Label.hide()
	else:
		$professions.columns = 6
		$professions.set("custom_constants/hseparation", 14)
		$professions/Button.rect_min_size = Vector2(100,100)
		$professions/Button/TextureRect.rect_size = Vector2(84,84)
	for i in person.xp_module.professions:
		var newnode = input_handler.DuplicateContainerTemplate($professions)
		var prof = classesdata.professions[i]
		var name = ResourceScripts.descriptions.get_class_name(prof, person)
		newnode.get_node("Label").text = name
		# newnode.get_node("TextureRect").rect_size = Vector2(86,86)
		newnode.get_node("TextureRect").texture = prof.icon
		newnode.connect('signal_RMB_release', gui_controller, 'show_class_info', [prof.code, person])
		var temptext = "[center]"+ResourceScripts.descriptions.get_class_name(prof,person) + "[/center]\n"+ResourceScripts.descriptions.get_class_bonuses(person, prof) + ResourceScripts.descriptions.get_class_traits(person, prof)
		temptext += "\n\n{color=aqua|" + tr("CLASSRIGHTCLICKDETAILS") + "}"
		globals.connecttexttooltip(newnode, temptext)
