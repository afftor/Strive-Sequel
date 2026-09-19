extends Control
#The slave market's character card, laid out like the mansion list's unfolded card.
#A node carrying a tooltip must not ignore the mouse and its children must, or the tooltip never shows.

const EXPANDED = preload("res://gui_modules/Mansion/Scripts/MansionSlaveExpandedDetails.gd")

const SEX_SKILLS = [
	{code = 'sex_skills_petting', name = 'SEXSKILLPETTING', descript = 'SEXSKILLPETTINGDESCRIPT'},
	{code = 'sex_skills_penetration', name = 'SEXSKILLPENETRATION', descript = 'SEXSKILLPENETRATIONDESCRIPT'},
	{code = 'sex_skills_pussy', name = 'SEXSKILLPUSSY', descript = 'SEXSKILLPUSSYDESCRIPT'},
	{code = 'sex_skills_oral', name = 'SEXSKILLORAL', descript = 'SEXSKILLORALDESCRIPT'},
	{code = 'sex_skills_anal', name = 'SEXSKILLANAL', descript = 'SEXSKILLANALDESCRIPT'},
	{code = 'sex_skills_tail', name = 'SEXSKILLTAIL', descript = 'SEXSKILLTAILDESCRIPT'},
]

var person = null
var found = {}


func show_person(value):
	person = value
	if person == null:
		return
	fill_identity()
	fill_character()
	fill_base_stats()
	fill_classes()
	fill_factors()
	fill_traits()
	fill_sex_skills()


func refresh_portrait(value):
	if value != null and value == person:
		_node("Portrait").texture = person.get_icon()


func _node(node_name):
	if !found.has(node_name) or !is_instance_valid(found[node_name]):
		found[node_name] = find_node(node_name, true, false)
	return found[node_name]


func fill_identity():
	var name_label = _node("Name")
	name_label.text = person.get_full_name()
	globals.connecttexttooltip(name_label, person.show_race_description())
	input_handler.queue_portrait(person) #a slave nobody opened has no picture yet
	globals.build_attrs_for_char(_node("PortraitBlock"), person)
	fill_bar("hp", "STATHP", person.get_stat('hp'), person.get_stat('hpmax'))
	fill_bar("mp", "STATMP", person.get_stat('mp'), person.get_stat('mpmax'))
	var lust = _node("lust")
	lust.visible = person.check_trait('succubus')
	if lust.visible:
		fill_bar("lust", "STATLUST", person.get_stat('lust'), person.get_stat('lustmax'))
	var current_exp = int(floor(person.get_stat("base_exp")))
	var next_exp = int(floor(person.get_next_class_exp()))
	var experience = _node("Experience")
	experience.text = tr("STATBASE_EXP") + ": " + str(current_exp) + " / " + str(next_exp)
	if current_exp >= next_exp:
		experience.set("custom_colors/font_color", Color(variables.hexcolordict.levelup_text_color))
	else:
		experience.set("custom_colors/font_color", Color(variables.hexcolordict.k_yellow))
	var exp_tooltip = "[center]{color=yellow|" + tr("STATBASE_EXP") + "}[/center]\n" + tr("STATBASE_EXPDESCRIPT")
	exp_tooltip += "\n" + tr("EXPREQUIRED") + ": " + str(next_exp)
	globals.connecttexttooltip(experience, exp_tooltip)


func fill_bar(node_name, label, value, max_value):
	var bar = _node(node_name)
	bar.max_value = max(max_value, 1)
	bar.value = value
	globals.connecttexttooltip(bar, "%s %d/%d" % [tr(label), int(round(value)), int(round(max_value))])


func fill_character():
	var personality = person.get_stat('personality')
	_node("PersonalityIcon").texture = EXPANDED.PERSONALITY_ICONS.get(personality, EXPANDED.PERSONALITY_ICONS.neutral)
	_node("Personality").text = tr('PERSONALITYNAME' + personality.to_upper())
	globals.connecttexttooltip(_node("PersonalityRow"), globals.get_character_personality_tooltip(personality))
	var consent_value = int(person.get_stat('consent'))
	var consent = _node("Consent")
	consent.text = tr('SIBLINGMODULECONSENT') + tr(variables.consent_dict[consent_value]) + ' (' + str(consent_value) + ')'
	globals.connecttexttooltip(consent, tr('INFOCONSENT'))


func fill_base_stats():
	var rows = _node("StatRows")
	input_handler.ClearContainer(rows)
	for code in EXPANDED.OVERVIEW_STATS:
		var row = input_handler.DuplicateContainerTemplate(rows)
		row.get_node("Icon").texture = EXPANDED.OVERVIEW_ICONS[code]
		var value = row.get_node("Value")
		if code == "productivity":
			value.text = str(int(floor(person.get_stat(code)))) + "%"
			globals.connecttexttooltip(row, productivity_tooltip())
		else:
			value.text = globals.base_stat_text(person, code)
			globals.connecttexttooltip(row, stat_tooltip(code))
		value.set("custom_colors/font_color", Color(variables.hexcolordict.k_yellow))


func fill_classes():
	var classes = _node("Classes")
	input_handler.ClearContainer(classes)
	var professions = person.get_professions()
	for code in professions:
		var newnode = input_handler.DuplicateContainerTemplate(classes)
		newnode.get_node("ProfIcon").texture = classesdata.professions[code].icon
		newnode.connect('signal_RMB_release', gui_controller, 'show_class_info', [code, person])
		globals.connectclasstooltip(newnode, person, code)
	_node("ClassesEmpty").visible = professions.empty()


#fresh template copies every time: a fitted font never grows back
func fill_factors():
	var rows = _node("FactorRows")
	input_handler.ClearContainer(rows)
	var as_words = input_handler.globalsettings.factors_as_words
	for code in EXPANDED.OVERVIEW_FACTORS:
		if person.is_master() and code in ["tame_factor", "authority_factor"]:
			continue
		var row = input_handler.DuplicateContainerTemplate(rows)
		row.get_node("Icon").texture = EXPANDED.OVERVIEW_ICONS[code]
		var step = int(clamp(floor(person.get_stat(code)), 1, 6))
		var colour = Color(variables.hexcolordict["factor" + str(step)])
		var number = row.get_node("Value")
		var word = row.get_node("Word")
		number.visible = !as_words
		word.visible = as_words
		if as_words:
			word.text = ResourceScripts.descriptions.factor_descripts[step]
			word.set("custom_colors/font_color", colour)
			input_handler.font_size_adjust(word, EXPANDED.FACTOR_WORD_PADDING)
		else:
			number.text = str(int(floor(person.get_stat(code))))
			number.set("custom_colors/font_color", colour)
		globals.connecttexttooltip(row, stat_tooltip(code))


func fill_traits():
	var traits = _node("Traits")
	globals.build_traitlist_for_char(person, traits)
	var shown = 0
	for child in traits.get_children():
		if child is CanvasItem and child.visible and !(child.name in ['Button', 'Button2']):
			shown += 1
	_node("TraitsEmpty").visible = shown == 0


func fill_sex_skills():
	var skills = _node("SexSkills")
	input_handler.ClearContainer(skills, ['Skill'])
	var sex_training = person.get_sex_training()
	var shown = 0
	for skill in SEX_SKILLS:
		if person.get_stat(skill.code) <= 0:
			continue
		var training_code = skill.code.replace('sex_skills_', 'sex_training_')
		var training_state = sex_training.get(training_code, 'novice')
		if skill.code == 'sex_skills_tail' and training_state == 'novice':
			continue
		if skill.code == 'sex_skills_penetration' and training_state == 'novice' and person.get_stat('penis_size') == '':
			continue
		if skill.code == 'sex_skills_pussy' and training_state == 'novice' and person.get_stat('sex') == 'male':
			continue
		var newnode = input_handler.DuplicateContainerTemplate(skills, 'Skill')
		newnode.get_node("Icon").texture = load(ResourceScripts.slave_quests.REQ_ICON_PATHS[training_code])
		var level = globals.get_sex_training_label(training_state)
		newnode.get_node("Level").text = level
		globals.connecttexttooltip(newnode, '[center]' + tr(skill.name) + '[/center]\n' + tr(skill.descript) + '\n' + tr('CUR_LEVEL_LABEL') + ': ' + level)
		shown += 1
	_node("SexSkillsSection").visible = shown > 0


func stat_tooltip(code):
	return "[center]{color=yellow|" + tr("STAT" + code.to_upper()) + "}[/center]\n" + person.translate(statdata.statdata[code].descript)


func productivity_tooltip():
	var text = "[center]" + statdata.statdata.productivity.name + "[/center]\n"
	text += person.translate(statdata.statdata.productivity.descript)
	text += "\n" + tr("TOTALPRODUCTIVITY") + ": " + str(floor(person.get_stat("productivity")))
	for mod_code in variables.productivity_mods:
		var mod_value = person.get_stat(mod_code)
		var line = str(round(mod_value * 100)) + " - " + statdata.statdata[mod_code].name
		if mod_value > 1:
			text += "\n{color=green|" + line + "}"
		elif mod_value < 1:
			text += "\n{color=red|" + line + "}"
		else:
			text += "\n" + line
	return text
