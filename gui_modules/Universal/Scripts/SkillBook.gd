extends TextureRect

var activecharacter

func _ready():
	$CloseButton.connect("pressed", self, "close_skillbook")
	$TextureButton.connect("pressed", self, "close_skillbook")
	for ch in $Categories.get_children():
		ch.connect("pressed", self, "category_pressed", [ch])

func close_skillbook():
	get_parent().RebuildSkillPanel()
	hide()

func category_pressed(button):
	for bt in $Categories.get_children():
		bt.pressed = false
	button.pressed = true
	for ch in $ScrollContainer/GridContainer.get_children():
		if ch.has_meta("skill"):
			var skill = ch.get_meta("skill")
			ch.visible = skill.tags.has(button.name)
			if button.name == "all":
				ch.visible = true

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
	activecharacter = get_parent().activecharacter 
	input_handler.ClearContainer($ScrollContainer/GridContainer)
	for i in activecharacter.skills.combat_skills:
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/GridContainer)
		var skill = Skilldata.Skilllist[i]
		newbutton.dragdata = skill
		newbutton.set_meta('skill', skill)
		newbutton.get_node("Icon").texture = skill.icon
		newbutton.connect("pressed", self, "on_skill_pressed", [skill])
	
	if get_parent().activecharacter == null: return
	input_handler.ClearContainer($ScrollContainer2/GridContainer)

	var src = activecharacter.skills.combat_skill_panel
	for i in range(1,21):
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer2/GridContainer)
		newbutton.target_node = self
		newbutton.target_function = 'update_combat_skill_panel'
		newbutton.dragdata = newbutton
		if src.has(i):
			var skill = Skilldata.Skilllist[activecharacter.skills.combat_skill_panel[i]]
			newbutton.get_node("Icon").texture = skill.icon
			newbutton.set_meta('skill', skill)
			newbutton.connect("pressed", self, "on_skill_pressed", [skill])
	update_filter()

func update_combat_skill_panel(skill):
	for i in range(1,21):
		var ch = $ScrollContainer2/GridContainer.get_child(i-1)
		if ch.has_meta("skill"):
			activecharacter.skills.combat_skill_panel[i] = ch.get_meta("skill").code
		else:
			activecharacter.skills.combat_skill_panel.erase(i)
	RebuildSkillBook()

func on_skill_pressed(skill):
	$SkillInfo/frame/icon.texture = skill.icon
	$SkillInfo/name.text = tr("SKILL" + skill.code.to_upper())
	$SkillInfo/desc.text = tr("SKILL" + skill.code.to_upper() + "DESCRIPT")
	if skill.cost.has("mp"):
		$SkillInfo/Cost.text = str(skill.cost.mp)
	else:
		$SkillInfo/Cost.text = "0"
	$SkillInfo/Cooldown.text = str(skill.cooldown)

func clear_skillinfo():
	$SkillInfo/frame/icon.texture = null
	$SkillInfo/desc.text = ""
	$SkillInfo/name.text = ""
	$SkillInfo/Cost.text = ""
	$SkillInfo/Cooldown.text = ""
