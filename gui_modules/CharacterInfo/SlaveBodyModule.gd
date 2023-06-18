extends Panel

var person

#func _ready():
#	update()


func update(person = null):
	if person == null:
		person = input_handler.interacted_character
		if get_parent().SummaryModule.selected_person != null:
			person = get_parent().SummaryModule.selected_person
		if (
			gui_controller.previous_screen != null
			&& gui_controller.previous_screen == gui_controller.exploration
		):
			person = gui_controller.exploration.person_to_hire
	# if person != null:
	var stored_image = person.get_stored_body_image()
	if stored_image != null:
		$Body.texture = stored_image
		$Body.visible = true
		$ragdoll.visible = false
	else:
		$Body.visible = false
		$ragdoll.visible = true
		$ragdoll.test_mode = false
		$ragdoll.rebuild(person)
		$ragdoll.rebuild_cloth(true)
	
	globals.build_buffs_for_char(person, $buffscontainer, 'mansion')
	
	input_handler.ClearContainer($ScrollContainer/professions)
	if person.xp_module.professions.size() > 6:
		$ScrollContainer/professions.columns = 12
		$ScrollContainer/professions.set("custom_constants/hseparation", 6)
		$ScrollContainer/professions/Button.rect_min_size = Vector2(50, 50)
		$ScrollContainer/professions/Button/TextureRect.rect_size = Vector2(34, 34)
		$ScrollContainer/professions/Button/Label.hide()
	else:
		$ScrollContainer/professions.columns = 6
		$ScrollContainer/professions.set("custom_constants/hseparation", 14)
		$ScrollContainer/professions/Button.rect_min_size = Vector2(100, 100)
		$ScrollContainer/professions/Button/TextureRect.rect_size = Vector2(84, 84)
	for i in person.xp_module.professions:
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/professions)
		var prof = classesdata.professions[i]
		var name = ResourceScripts.descriptions.get_class_name(prof, person)
		newnode.get_node("Label").text = name
		# newnode.get_node("TextureRect").rect_size = Vector2(86,86)
		newnode.get_node("TextureRect").texture = prof.icon
		newnode.connect(
			'signal_RMB_release', gui_controller, 'show_class_info', [prof.code, person]
		)
		var temptext = (
			"[center]"
			+ ResourceScripts.descriptions.get_class_name(prof, person)
			+ "[/center]\n"
			+ ResourceScripts.descriptions.get_class_bonuses(person, prof)
			+ ResourceScripts.descriptions.get_class_traits(person, prof)
		)
		temptext += "\n\n{color=aqua|" + tr("CLASSRIGHTCLICKDETAILS") + "}"
		globals.connecttexttooltip(newnode, temptext)
