extends Node

var activecharacter

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
		if src.has(i):
			var skill = Skilldata.Skilllist[activecharacter.skills.combat_skill_panel[i]]
			newbutton.get_node("Icon").texture = skill.icon
			newbutton.set_meta('skill', skill.code)
			newbutton.connect("pressed", self, "on_skill_pressed", [skill])
			newbutton.connect("signal_RMB", self, "on_skill_RMB", [skill])

func update_combat_skill_panel(skill): # do actions in skill_drop_node
	for i in range(1,21):
		var ch = $ScrollContainer2/GridContainer.get_child(i-1)
		if ch.has_meta("Skill"):
			activecharacter.skills.combat_skill_panel[i] = ch.get_meta("Skill").code
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
