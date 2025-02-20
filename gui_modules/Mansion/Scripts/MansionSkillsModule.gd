extends Control

var person
var active_skill


func _ready():
	pass
	input_handler.skill_list_node = self
	$skillpanelswitch.connect("pressed", self, "change_panel_type")


func build_skill_panel():
#	person = input_handler.interacted_character
	person = get_parent().active_person
	if person == null:
		return
	input_handler.ClearContainer($SkillPanel)
	var src
	if person.skills.active_panel == variables.PANEL_SOC:
		src = person.skills.social_skill_panel
		$skillpanelswitch.pressed = false
	else:
		src = person.skills.combat_skill_panel
		$skillpanelswitch.pressed = true
	for i in range(1,11):
		var text = ''
		var newbutton = input_handler.DuplicateContainerTemplate($SkillPanel)
		if src.has(i):
			var skill = Skilldata.get_template(src[i], person)
			newbutton.get_node("icon").texture = skill.icon
			if skill.icon == null:
				newbutton.get_node("icon").texture = load("res://assets/images/gui/panels/noimage.png")
			newbutton.get_node("icon").show()
			if skill.cost.has('mp'): #need to implement other costs
				newbutton.get_node("manacost").visible = true
				newbutton.get_node("manacost").text = str(int(skill.cost.mp))
			if !person.check_cost(skill.cost):
				newbutton.disabled = true
				newbutton.get_node("icon").material = load("res://assets/sfx/bw_shader.tres")
			var charges = skill.charges
			var used_charges = 0
			if person.skills.social_skills_charges.has(skill.code):
				used_charges = person.skills.social_skills_charges[skill.code]
			text = str(charges - used_charges) + "/" + str(charges)

			if (person.checkreqs(skill.reqs) == false) or (person.has_status('no_social_skills') and person.skills.active_panel == variables.PANEL_SOC) or person.get_work() == 'disabled':
				newbutton.disabled = true
				newbutton.get_node("icon").material = load("res://assets/sfx/bw_shader.tres")
			newbutton.get_node("charges").text = text
			newbutton.get_node("charges").show()
			if charges - used_charges <= 0:
				newbutton.disabled = true
				if person.skills.social_cooldowns.has(skill.code):
					newbutton.get_node('cooldown').visible = true
					newbutton.get_node('cooldown').text = str(person.skills.social_cooldowns[skill.code])
				if person.skills.daily_cooldowns.has(skill.code):
					newbutton.get_node('cooldown').visible = true
					newbutton.get_node('cooldown').text = str(person.skills.daily_cooldowns[skill.code])
			if person.skills.active_panel == variables.PANEL_COM: newbutton.disabled = true
			newbutton.set_meta('skill', skill.code)
			newbutton.connect("pressed",self,"select_skill_target", [skill.code])
			globals.connectskilltooltip(newbutton, skill.code, person)
		else:
			newbutton.connect('pressed',self,'select_skill_for_position', [i])

		newbutton.set_script(load("res://src/scenes/RightClickReactButton.gd"))
		newbutton.connect('signal_RMB_release',self,'select_skill_for_position', [i])
		if person.skills.active_panel == variables.PANEL_COM:
			newbutton.texture_disabled = load("res://assets/images/gui/universal/skill_frame.png")
			newbutton.get_node("charges").hide()

func select_skill_target(skillcode):
	input_handler.ActivateTutorial('TUTORIALLIST7')
	active_skill = skillcode
	var template = Skilldata.get_template(skillcode, person)
	if template.tags.has('no_target'):
		use_skill(person)
		return
	input_handler.SystemMessage("Select target for Ability", 3)
	get_parent().chars_for_skill.clear()
	var skill_source = get_parent().skill_source
	for i in $SkillPanel.get_children():
		if i.has_meta('skill'):
			i.pressed = i.get_meta("skill") == skillcode
	# input_handler.ShowSlaveSelectPanel(self, 'use_skill', [{code = 'is_free', check = true}, {code = 'is_id', operant = 'neq', value = person.id}] + Skilldata.Skilllist[skillcode].targetreqs)
	var reqs = [{code = 'is_id', operant = 'neq', value = person.id}] + template.targetreqs
	for i in ResourceScripts.game_party.characters.values():
		if !i.checkreqs(reqs) || !i.same_location_with(skill_source):
			continue
		if i.is_on_quest():
			continue
		get_parent().chars_for_skill.append(i)
	get_parent().skill_manager()

func use_skill(target):
	get_tree().get_root().get_node("skilltooltip").hide()
	person.use_social_skill(active_skill, target)
	# update()
	get_parent().mansion_state = "default"
	get_parent().slave_list_manager()

func change_panel_type():
	if get_parent().active_person == null:
		get_parent().active_person = ResourceScripts.game_party.get_master()
	if person.skills.active_panel == variables.PANEL_SOC:
		person.skills.active_panel = variables.PANEL_COM
	elif person.skills.active_panel == variables.PANEL_COM: #redundant check for the case of any of future changes
		person.skills.active_panel = variables.PANEL_SOC
	build_skill_panel()

var active_position
func select_skill_for_position(position):
	active_position = position
	input_handler.ShowSkillSelectPanel(person, person.skills.active_panel, self, 'skill_selected')

func skill_selected(skill):
	if skill == null:
		if person.skills.active_panel == variables.PANEL_SOC:
			person.skills.social_skill_panel.erase(active_position)
		else:
			person.skills.combat_skill_panel.erase(active_position)
	else:
		if person.skills.active_panel == variables.PANEL_SOC:
			person.skills.social_skill_panel[active_position] = skill
		else:
			person.skills.combat_skill_panel[active_position] = skill
	build_skill_panel()
