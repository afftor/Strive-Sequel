extends Control

var person
var active_skill


func _ready():
	pass
	input_handler.skill_list_node = self
	$skillpanelswitch.connect("pressed", self, "change_panel_type")


func build_skill_panel():
	person = get_parent().skill_source
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
			var skill = Skilldata.Skilllist[src[i]]
			newbutton.get_node("icon").texture = skill.icon
			if skill.icon == null:
				newbutton.get_node("icon").texture = load("res://assets/images/gui/panels/noimage.png")
			newbutton.get_node("icon").show()
			if skill.manacost > 0:
				newbutton.get_node("manacost").visible = true
				newbutton.get_node("manacost").text = str(skill.manacost)
				if person.mp < skill.manacost:
					newbutton.disabled = true
					newbutton.get_node("icon").material = load("res://assets/sfx/bw_shader.tres")
			if skill.energycost > 0:
				newbutton.get_node("energycost").visible = true
				newbutton.get_node("energycost").text = str(skill.energycost)
				if person.energy < skill.energycost:
					newbutton.disabled = true
					newbutton.get_node("icon").material = load("res://assets/sfx/bw_shader.tres")
			var charges = Skilldata.get_charges(skill, person)
			var used_charges = 0
			if person.skills.social_skills_charges.has(skill.code):
				used_charges = person.skills.social_skills_charges[skill.code]
			if skill.has('custom_used_charges'):
				#stub - for i'm haiting to use injections and functors this way
				#additional functional can be added here
				if skill.custom_used_charges[0] == 'call':
					used_charges = person.call(skill.custom_used_charges[1], skill.custom_used_charges[2])
			text = str(charges - used_charges) + "/" + str(charges)
			
			if person.checkreqs(skill.reqs) == false:
				newbutton.disabled = true
				newbutton.get_node("icon").material = load("res://assets/sfx/bw_shader.tres")
			newbutton.get_node("charges").text = text
			newbutton.get_node("charges").show()
			if charges - used_charges <= 0:
				newbutton.disabled = true
			if person.skills.active_panel == variables.PANEL_COM: newbutton.disabled = true
			
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
	get_parent().chars_for_skill.clear()
	active_skill = skillcode
	# input_handler.ShowSlaveSelectPanel(self, 'use_skill', [{code = 'is_free', check = true}, {code = 'is_id', operant = 'neq', value = person.id}] + Skilldata.Skilllist[skillcode].targetreqs)
	var reqs = [{code = 'is_free', check = true}, {code = 'is_id', operant = 'neq', value = person.id}] + Skilldata.Skilllist[skillcode].targetreqs
	for i in ResourceScripts.game_party.characters.values():
		if i.checkreqs(reqs) == false:
			continue
		get_parent().chars_for_skill.append(i)
	get_parent().skill_manager()

func use_skill(target):
	person.use_social_skill(active_skill, target)
	# update()
	get_parent().mansion_state = "default"


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
