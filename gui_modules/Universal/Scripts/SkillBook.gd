extends TextureRect

var activecharacter

signal closing

func _ready():
	$CloseButton.connect("pressed", self, "close_skillbook")
	$TextureButton.connect("pressed", self, "close_skillbook")
	for ch in $Categories.get_children():
		ch.connect("pressed", self, "category_pressed", [ch])
	
	globals.connecttexttooltip($Categories/all, tr("SKILLS_CAT_ALL_DESC"))
	globals.connecttexttooltip($Categories/skill, tr("SKILLS_LABEL"))
	globals.connecttexttooltip($Categories/spell, tr("SKILLS_CAT_SPELLS_DESC"))
	globals.connecttexttooltip($Categories/support, tr("SKILLS_CAT_SUPPORT_DESC"))
	globals.connecttexttooltip($Categories/aoe, tr("SKILLS_CAT_AOE_DESC"))
	globals.connecttexttooltip($Categories/heal, tr("SKILLS_CAT_HEAL_DESC"))
	$ScrollContainer.target_node = self


func toggle():
	if visible:
		close_skillbook()
	else:
		open_skillbook()


func close_skillbook():
	gui_controller.windows_opened.erase(self)
	hide()

func open_skillbook():
	show()
#	activecharacter = get_parent().activecharacter 
	gui_controller.windows_opened.push_back(self)
	clear_skillinfo()
	RebuildSkillBook()


func category_pressed(button):
	for bt in $Categories.get_children():
		bt.pressed = false
		bt.get_node("On").visible = false
	button.pressed = true
	button.get_node("On").visible = true
	for ch in $ScrollContainer/GridContainer.get_children():
		if ch.has_meta("skill"):
			var skill = ch.get_meta("skill")
			if button.name in ["support","aoe", "heal"]:
				ch.visible = skill.tags.has(button.name)
			if button.name == "all":
				ch.visible = true
			if button.name in ["skill", "spell"]:
				ch.visible = skill.ability_type == button.name

func update_filter():
	var button
	for bt in $Categories.get_children():
		if bt.pressed:
			button = bt
	for ch in $ScrollContainer/GridContainer.get_children():
		if ch.has_meta("skill"):
			var skill = ch.get_meta("skill")
			ch.visible = skill.tags.has(button.name)
			if button.name == "all":
				ch.visible = true

func RebuildSkillBook():
	input_handler.ClearContainer($ScrollContainer/GridContainer)
	for i in activecharacter.skills.combat_skills:
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/GridContainer)
		var skill = Skilldata.get_template(i, activecharacter)
		newbutton.dragdata = {skill = i}
		newbutton.target_node = self
		newbutton.set_meta('skill', skill)
		newbutton.get_node("Icon").texture = skill.icon
		newbutton.connect("mouse_entered", self, "update_skillinfo", [skill])
		#newbutton.connect("mouse_exited", self, "clear_skillinfo")
	
	if activecharacter == null: return
	input_handler.ClearContainer($ScrollContainer2/GridContainer)

	var src = activecharacter.skills.combat_skill_panel
	for i in range(1,21):
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer2/GridContainer)
		newbutton.target_node = self
		newbutton.dragdata = {position = i}
		if src.has(i):
			var skill = Skilldata.get_template(activecharacter.skills.combat_skill_panel[i], activecharacter)
			newbutton.get_node("Icon").texture = skill.icon
			newbutton.set_meta('skill', skill)
			newbutton.connect("mouse_entered", self, "update_skillinfo", [skill])
			#newbutton.connect("mouse_exited", self, "clear_skillinfo")
		else:
			newbutton.draggable = false
	update_filter()

#func update_combat_skill_panel(skill):
#	for i in range(1,21):
#		var ch = $ScrollContainer2/GridContainer.get_child(i-1)
#		if ch.has_meta("skill"):
#			activecharacter.skills.combat_skill_panel[i] = ch.get_meta("skill").code
#		else:
#			activecharacter.skills.combat_skill_panel.erase(i)
#	RebuildSkillBook()

func set_skill_to_pos(skill, pos):
	var src = activecharacter.skills.combat_skill_panel
	var oldpos = []
	for ps in src:
		if src[ps] == skill:
			oldpos.push_back(ps)
	for ps in oldpos:
		src.erase(ps)
	src[pos] = skill
	RebuildSkillBook()

func swap_positions(pos1, pos2):
	var src = activecharacter.skills.combat_skill_panel
	if !src.has(pos1):
		src[pos1] = src[pos2]
		src.erase(pos2)
	elif !src.has(pos2):
		src[pos2] = src[pos1]
		src.erase(pos1)
	else:
		var tmp = src[pos1]
		src[pos1] = src[pos2]
		src[pos2] = tmp
	RebuildSkillBook()

func remove_skill_from_pos(pos):
	var src = activecharacter.skills.combat_skill_panel
	src.erase(pos)
	RebuildSkillBook()


func update_skillinfo(skill):
	$SkillInfo/frame.visible = true
	$SkillInfo/CooldownIcon.visible = true
	$SkillInfo/CostIcon.visible = true
	$SkillInfo/frame/icon.texture = skill.icon
	$SkillInfo/name.text = tr("SKILL" + skill.code.to_upper())
	$SkillInfo/desc.text = tr("SKILL" + skill.code.to_upper() + "DESCRIPT")
	if skill.cost.has("mp"):
		$SkillInfo/Cost.text = str(int(skill.cost.mp))
	else:
		$SkillInfo/Cost.text = "0"
	$SkillInfo/Cooldown.text = str(skill.cooldown)

func clear_skillinfo():
	$SkillInfo/frame.visible = false
	$SkillInfo/CooldownIcon.visible = false
	$SkillInfo/CostIcon.visible = false
	$SkillInfo/frame/icon.texture = null
	$SkillInfo/desc.text = ""
	$SkillInfo/name.text = ""
	$SkillInfo/Cost.text = ""
	$SkillInfo/Cooldown.text = ""

func hide():
#	get_parent().RebuildSkillPanel()
	activecharacter = null
	emit_signal("closing")
	.hide()
