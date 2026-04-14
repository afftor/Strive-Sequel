extends "res://gui_modules/Universal/Scripts/tooltip_main.gd"

const MASKED_SPRITE = preload("res://assets/masked_sprite.tres")

var person = null
var classdata = null

onready var _main = $VBoxContainer
onready var _icon = $VBoxContainer/HBoxContainer/TextureRect2/ClassIcon
onready var _name = $VBoxContainer/Label
onready var _stat_container = $VBoxContainer/StatContainer
onready var _mastery_container = $VBoxContainer/MasteryContainer
onready var _skill_container = $VBoxContainer/SkillContainer
onready var _trait_container = $VBoxContainer/TraitsContainer
onready var _requirements_container = $VBoxContainer/ReqsContainer
onready var _bonus_panel = $VBoxContainer/BonusText
onready var _bonus_text = $VBoxContainer/BonusText/RichTextLabel


func showup(node, new_person, class_id):
	if !_setup(node):
		return
	person = new_person
	classdata = classesdata.professions[class_id]


func _open_panel(new_person, class_id):
	person = new_person
	classdata = classesdata.professions[class_id]
	_rebuild()


func update():
	_rebuild()
	_bonus_panel.visible = false
	yield(get_tree(), "idle_frame")
	if !weakref(parentnode).get_ref():
		emit_signal("update_completed")
		return
	rect_size.y = _main.rect_size.y + 20
	var parent_rect = input_handler.get_real_global_rect(parentnode, true)
	var screen = get_viewport().get_visible_rect()
	var pos = Vector2(parent_rect.position.x, parent_rect.end.y + 10)
	set_global_position(pos)
	if get_rect().end.x >= screen.size.x:
		rect_global_position.x -= get_rect().end.x - screen.size.x
	if get_rect().end.y >= screen.size.y:
		rect_global_position.y = parent_rect.position.y - (get_rect().size.y+10)
	if get_rect().end.y >= screen.size.y or get_rect().position.y < 0:
		#move to left or right from node
		pos.y = (screen.size.y - get_rect().size.y) / 2
		var offset_l = parent_rect.position.x
		var offset_r = screen.size.x - parent_rect.end.x
		if offset_l > offset_r:
			pos.x = parent_rect.position.x - 10 - get_rect().size.x
		else:
			pos.x = parent_rect.end.x + 10
		set_global_position(pos)
#	if rect_global_position.x + rect_size.x > screen.size.x:
#		rect_global_position.x = max(0, screen.size.x - rect_size.x)
#	if rect_global_position.y + rect_size.y > screen.size.y:
#		rect_global_position.y = parent_rect.position.y - rect_size.y - 10
#	if rect_global_position.y < 0:
#		rect_global_position.y = 0
	emit_signal("update_completed")


func _rebuild():
	_icon.texture = classdata.icon
	_name.text = tr(ResourceScripts.descriptions.get_class_name(classdata, person))
	_fill_stat_container()
	_fill_mastery_container()
	_fill_skill_container()
	_fill_trait_container()
	_fill_requirements_container()
	_fill_bonus_text()


func _fill_stat_container():
	var tmp = ""
	tmp = ResourceScripts.descriptions.get_class_bonuses(person, classdata)
	_stat_container.visible = !tmp.empty()
	_stat_container.get_node("RichTextLabel").bbcode_text = globals.TextEncoder(tmp)


func _fill_mastery_container():
	input_handler.ClearContainer(_mastery_container, ['Panel'])
	var has_rows = false
	for stat in classdata.statchanges:
		if stat.begins_with("mastery_point_"):
			has_rows = true
			var panel = input_handler.DuplicateContainerTemplate(_mastery_container, 'Panel')
			panel.get_node('HBoxContainer/frame').texture = images.get_icon('frame_trait')
			panel.get_node('HBoxContainer/frame/icon').texture = images.get_icon(stat)
			panel.get_node('HBoxContainer/statname').text = "%s +%d" % [tr(statdata.statdata[stat].name), classdata.statchanges[stat]]
	for stat in classdata.statchanges:
		if stat.begins_with("mastery_") and !stat.begins_with("mastery_point_"):
			has_rows = true
			var panel = input_handler.DuplicateContainerTemplate(_mastery_container, 'Panel')
			panel.get_node('HBoxContainer/frame').texture = images.get_icon('frame_skill')
			var mastery_id = stat.trim_prefix("mastery_")
			var mastery_data = Skilldata.masteries[mastery_id]
			panel.get_node('HBoxContainer/frame/icon').texture = images.get_icon(mastery_data.icon)
			panel.get_node('HBoxContainer/statname').text = "%s +%d" % [tr(statdata.statdata[stat].name), classdata.statchanges[stat]]
	_mastery_container.visible = has_rows


func _fill_skill_container():
	input_handler.ClearContainer(_skill_container, ['Panel'])
	var has_rows = false
	for skill_id in classdata.skills:
		has_rows = true
		var skill = Skilldata.get_template(skill_id, person)
		var panel = input_handler.DuplicateContainerTemplate(_skill_container, 'Panel')
		panel.get_node('HBoxContainer/frame').texture = images.get_icon('frame_explore')
		panel.get_node('HBoxContainer/frame/icon').texture = skill.icon
		panel.get_node('HBoxContainer/frame/icon').material = MASKED_SPRITE.duplicate(true)
		panel.get_node('HBoxContainer/frame/icon').material.set_shader_param("mask", images.get_icon('frame_explore_mask'))
		panel.get_node('HBoxContainer/skillname').text = "%s: %s" % [tr("SKILL"), tr(skill.name)]
		if skill.has("container"):
			globals.connecttexttooltip(panel, tr(skill.descript))
		else:
			globals.connectskilltooltip(panel, skill_id, person)
	if classdata.has('exploreskills'):
		for skill_id in classdata.exploreskills:
			has_rows = true
			var skill = Skilldata.get_template(skill_id, person)
			var panel = input_handler.DuplicateContainerTemplate(_skill_container, 'Panel')
			panel.get_node('HBoxContainer/frame').texture = images.get_icon('frame_explore_1')
			panel.get_node('HBoxContainer/frame/icon').texture = skill.icon
			panel.get_node('HBoxContainer/frame/icon').material = MASKED_SPRITE.duplicate(true)
			panel.get_node('HBoxContainer/frame/icon').material.set_shader_param("mask", images.get_icon('frame_explore_mask'))
			panel.get_node('HBoxContainer/skillname').text = "%s: %s" % [tr("SKILL"), tr(skill.name)]
			if skill.has("container"):
				globals.connecttexttooltip(panel, tr(skill.descript))
			else:
				globals.connectskilltooltip(panel, skill_id, person)
	for skill_id in classdata.combatskills:
		has_rows = true
		var skill = Skilldata.get_template(skill_id, person)
		var panel = input_handler.DuplicateContainerTemplate(_skill_container, 'Panel')
		panel.get_node('HBoxContainer/frame').texture = images.get_icon('frame_skill')
		panel.get_node('HBoxContainer/frame/icon').texture = skill.icon
		panel.get_node('HBoxContainer/frame/icon').material = MASKED_SPRITE.duplicate(true)
		panel.get_node('HBoxContainer/frame/icon').material.set_shader_param("mask", images.get_icon('frame_skill_mask'))
		panel.get_node('HBoxContainer/skillname').text = "%s: %s" % [tr("SKILL"), tr(skill.name)]
		if skill.has("container"):
			globals.connecttexttooltip(panel, tr(skill.descript))
		else:
			globals.connectskilltooltip(panel, skill_id, person)
	_skill_container.visible = has_rows




func _fill_trait_container():
	var tmp = ""
	tmp = ResourceScripts.descriptions.get_class_traits(person, classdata)
	_trait_container.visible = !tmp.empty()
	_trait_container.get_node("RichTextLabel").bbcode_text = globals.TextEncoder(tmp)


func _fill_requirements_container():
	var tmp = ""
	tmp = ResourceScripts.descriptions.get_class_reqs(person, classdata)
	_requirements_container.visible = !tmp.empty()
	_requirements_container.get_node("RichTextLabel").bbcode_text = globals.TextEncoder(tmp)


func _fill_bonus_text():
	var text = ""
	if classdata.has("descript") and classdata.descript != "":
		text += tr(classdata.descript)
	var extra = _build_extra_bonus_text()
	if extra != "":
		if text != "":
			text += "\n\n"
		text += extra
	_bonus_panel.visible = text != ""
	_bonus_text.bbcode_text = globals.TextEncoder(text)


func _build_extra_bonus_text():
	var lines = []
	if classdata.has("tags") and classdata.tags.has("stable_fame"):
		lines.append(tr("TAGSTABLE_FAME"))
	return PoolStringArray(lines).join("\n").strip_edges()


func _build_trait_tooltip(trait):
	var text = "[center]%s[/center]\n%s" % [tr(trait.name), tr(trait.descript)]
	if trait.has("bonusstats"):
		var bonus_text = person.translate(globals.build_desc_for_bonusstats(trait.bonusstats).strip_edges())
		if bonus_text != "":
			text += "\n" + bonus_text
	return text
