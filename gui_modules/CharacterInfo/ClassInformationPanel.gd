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
		var tex
		var tooltip_str
		if i == "basic_spells":
			tex = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_basic_spells.png")
			tooltip_str = tr("TRAITBASIC_SPELLS")
		elif i == "advanced_spells":
			tex = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_advanced_spells.png")
			tooltip_str = tr("TRAITADVANCED_SPELLS")
		elif i == "basic_combat":
			tex = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_basic_combat.png")
			tooltip_str = tr("TRAITBASIC_COMBAT")
		elif i == "advanced_combat":
			tex = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_advanced_combat.png")
			tooltip_str = tr("TRAITADVANCED_COMBAT")
		elif i == "trainer":
			tex = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_advanced_combat.png") #2fix
			tooltip_str = tr("TRAITTRAINER")
		if tex != null:
			var newicon = input_handler.DuplicateContainerTemplate($ReqIcons, "Icon")
			newicon.texture = tex
			globals.connecttexttooltip(newicon, tooltip_str)
	
	text = tr('CLASSREQS')+":\n"
	if tempclass.reqs.size() > 0 && tempclass.reqs[0].code != 'disabled':
		if gui_controller.exploration_city != null && gui_controller.exploration_city.get_node("GuildShop").is_visible():
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
