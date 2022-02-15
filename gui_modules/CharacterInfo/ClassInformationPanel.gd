extends Panel


#currently this is not required at all - due to similar effect of this closebutton and main charinfo's
func _ready():
	gui_controller.add_close_button(self)
#	hide()
#	move_child($Control, 0)


func open(classcode, person):
	input_handler.ClearContainer($ReqIcons, ["Icon"])
	var tempclass = classesdata.professions[classcode]
	$TextureRect.texture = tempclass.icon
	$name.text = ResourceScripts.descriptions.get_class_name(tempclass, person)
	
	input_handler.ClearContainer($SocialSkills/HBoxContainer)
	input_handler.ClearContainer($CombatSkills/HBoxContainer)
	
	$SocialSkills.visible = tempclass.skills.size() > 0
	$SocialLabel.visible = $SocialSkills.visible
	$CombatSkills.visible = tempclass.combatskills.size() > 0
	$CombatLabel.visible = $CombatLabel.visible
	var text = ResourceScripts.descriptions.get_class_bonuses(person, tempclass) 
	if text != '':
		text += '\n' 
	text += ResourceScripts.descriptions.get_class_traits_no_icons(person, tempclass)
	text = input_handler.text_cut_excessive_lines(text)
	$bonus.bbcode_text = text
	for i in tempclass.traits:
		var newicon = input_handler.DuplicateContainerTemplate($ReqIcons, "Icon")
		if i == "basic_spells":
			newicon.texture = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_basic_spells.png")
			globals.connecttexttooltip(newicon, tr("TRAITBASIC_SPELLS"))
		if i == "advanced_spells":
			newicon.texture = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_advanced_spells.png")
			globals.connecttexttooltip(newicon, tr("TRAITADVANCED_SPELLS"))
		if i == "basic_combat":
			newicon.texture = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_basic_combat.png")
			globals.connecttexttooltip(newicon, tr("TRAITBASIC_COMBAT"))
		if i == "advanced_combat":
			newicon.texture = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_advanced_combat.png")
			globals.connecttexttooltip(newicon, tr("TRAITADVANCED_COMBAT"))
		if newicon.texture == null:
			$ReqIcons.remove_child(newicon)
	
	text = tr('CLASSREQS')+":\n"
	if tempclass.reqs.size() > 0 && tempclass.reqs[0].code != 'disabled':
		if gui_controller.exploration != null && gui_controller.exploration.get_node("GuildShop").is_visible():
			text += ResourceScripts.descriptions.get_class_reqs(person, tempclass, false)
		else:
			text += ResourceScripts.descriptions.get_class_reqs(person, tempclass)
	elif tempclass.reqs.size() > 0  && tempclass.reqs[0].code == 'disabled':
		text += tr("UNIQUECLASS")
	else:
		text += tr("REQSNONE")
	$reqs.bbcode_text = text
	$descript.bbcode_text = person.translate(tempclass.descript)
	for i in tempclass.skills:
		var skill = Skilldata.Skilllist[i]
		var newnode = input_handler.DuplicateContainerTemplate($SocialSkills/HBoxContainer)
		newnode.texture = skill.icon
		globals.connectskilltooltip(newnode, skill.code, person)
		if skill.icon == null:
			newnode.texture = load("res://assets/images/gui/panels/noimage.png")
	for i in tempclass.combatskills:
		var skill = Skilldata.Skilllist[i]
		var newnode = input_handler.DuplicateContainerTemplate($CombatSkills/HBoxContainer)
		newnode.texture = skill.icon
		if skill.icon == null:
			newnode.texture = load("res://assets/images/gui/panels/noimage.png")
		globals.connectskilltooltip(newnode, skill.code, person)
	$CombatLabel.visible = tempclass.combatskills.size() > 0
	# show()
