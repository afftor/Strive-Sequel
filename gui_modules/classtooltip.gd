extends "res://gui_modules/Universal/Scripts/tooltip_main.gd"

const MASKED_SPRITE = preload("res://assets/masked_sprite.tres")

var person = null
var classdata = null

onready var _main = $VBoxContainer
onready var _icon = $VBoxContainer/TextureRect2/TextureRect
onready var _name = $VBoxContainer/Label
onready var _stat_container = $VBoxContainer/StatContainer
onready var _mastery_container = $VBoxContainer/MasteryContainer
onready var _skill_container = $VBoxContainer/SkillContainer
onready var _trait_container = $VBoxContainer/TraitContainer
onready var _requirements_container = $VBoxContainer/RequirementsContainer
onready var _bonus_panel = $VBoxContainer/BonusText
onready var _bonus_text = $VBoxContainer/BonusText/RichTextLabel




func showup(node, new_person, new_classdata):
	if !_setup(node):
		return
	person = new_person
	classdata = new_classdata
	_rebuild()
	show()


func update():
	yield(get_tree(), "idle_frame")
	if !weakref(parentnode).get_ref():
		emit_signal("update_completed")
		return
	rect_size = _main.rect_size + Vector2(20, 20)
	var parent_rect = input_handler.get_real_global_rect(parentnode, true)
	var screen = get_viewport().get_visible_rect()
	rect_global_position = Vector2(parent_rect.position.x, parent_rect.end.y + 10)
	if rect_global_position.x + rect_size.x > screen.size.x:
		rect_global_position.x = max(0, screen.size.x - rect_size.x)
	if rect_global_position.y + rect_size.y > screen.size.y:
		rect_global_position.y = parent_rect.position.y - rect_size.y - 10
	if rect_global_position.y < 0:
		rect_global_position.y = 0
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


func _clear_container_except_template(container):
	var template = container.get_child(0)
	for child in container.get_children():
		if child == template:
			continue
		child.queue_free()
	template.hide()
	return template


func _fill_stat_container():
	var template = _clear_container_except_template(_stat_container)
	var has_rows = false
	for stat in classdata.statchanges:
		if stat.begins_with("mastery_point_") or stat.begins_with("mastery_"):
			continue
		var row = template if !has_rows else input_handler.DuplicateContainerTemplate(_stat_container, template.name)
		row.show()
		row.get_node("HBoxContainer/statname").text = _get_stat_name(stat)
		row.get_node("HBoxContainer/value").text = _format_bonus_value(stat, classdata.statchanges[stat])
		has_rows = true
	_stat_container.visible = has_rows


func _fill_mastery_container():
	var template = _clear_container_except_template(_mastery_container)
	var has_rows = false
	for stat in classdata.statchanges:
		if !(stat.begins_with("mastery_point_") or stat.begins_with("mastery_")):
			continue
		var row = template if !has_rows else input_handler.DuplicateContainerTemplate(_mastery_container, template.name)
		row.show()
		if stat.begins_with("mastery_point_"):
			row.get_node("HBoxContainer/statname").text = "%s %s" % [tr(statdata.statdata[stat].name), _format_bonus_value(stat, classdata.statchanges[stat])]
			row.get_node("HBoxContainer/value2").texture = images.get_icon(stat)
		else:
			var mastery_id = stat.trim_prefix("mastery_")
			var mastery_name = mastery_id.capitalize()
			if Skilldata.masteries.has(mastery_id):
				mastery_name = Skilldata.masteries[mastery_id].name
				row.get_node("HBoxContainer/value2").texture = images.get_icon(Skilldata.masteries[mastery_id].icon)
			else:
				row.get_node("HBoxContainer/value2").texture = null
			row.get_node("HBoxContainer/statname").text = "%s %s" % [tr(mastery_name), _format_bonus_value(stat, classdata.statchanges[stat])]
		has_rows = true
	_mastery_container.visible = has_rows


func _fill_skill_container():
	var template = _clear_container_except_template(_skill_container)
	var has_rows = false
	for skill_id in classdata.skills:
		has_rows = _add_skill_row(template, skill_id, "frame_explore", "frame_explore_mask", has_rows) or has_rows
	for skill_id in classdata.combatskills:
		has_rows = _add_skill_row(template, skill_id, "frame_skill", "frame_skill_mask", has_rows) or has_rows
	_skill_container.visible = has_rows


func _add_skill_row(template, skill_id, frame_icon, frame_mask, has_rows):
	var skill = Skilldata.get_template(skill_id, person)
	if skill == null:
		return false
	var row = template if !has_rows else input_handler.DuplicateContainerTemplate(_skill_container, template.name)
	row.show()
	var frame = row.get_node("HBoxContainer/value/TextureRect")
	var icon = row.get_node("HBoxContainer/value")
	icon.texture = skill.icon
	icon.material = MASKED_SPRITE.duplicate(true)
	icon.material.set_shader_param("mask", images.get_icon(frame_mask))
	frame.texture = images.get_icon(frame_icon)
	row.get_node("HBoxContainer/statname").text = "%s: %s" % [tr("SKILL"), tr(skill.name)]
	if skill.has("container"):
		globals.connecttexttooltip(row, tr(skill.descript))
	else:
		globals.connectskilltooltip(row, skill_id, person)
	return true


func _fill_trait_container():
	var template = _clear_container_except_template(_trait_container)
	var has_rows = false
	for trait_id in classdata.traits:
		var trait = Traitdata.traits[trait_id]
		var row = template if !has_rows else input_handler.DuplicateContainerTemplate(_trait_container, template.name)
		row.show()
		row.get_node("HBoxContainer/statname").text = tr(trait.name)
		globals.connecttexttooltip(row, _build_trait_tooltip(trait))
		has_rows = true
	_trait_container.visible = has_rows


func _fill_requirements_container():
	var template = _clear_container_except_template(_requirements_container)
	var req_text = ResourceScripts.descriptions.get_class_reqs(person, classdata, false)
	if req_text == "":
		_requirements_container.visible = false
		return
	var lines = req_text.split("\n", false)
	var has_rows = false
	for line in lines:
		if line.strip_edges() == "":
			continue
		var row = template if !has_rows else input_handler.DuplicateContainerTemplate(_requirements_container, template.name)
		row.show()
		row.get_node("HBoxContainer/statname").text = line
		has_rows = true
	_requirements_container.visible = has_rows


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


func _get_stat_name(stat):
	if statdata.statdata.has(stat):
		return "%s:" % tr(statdata.statdata[stat].name)
	return "%s:" % stat.capitalize()


func _format_bonus_value(stat, value):
	if value is bool:
		return tr("%s_%s" % [statdata.statdata[stat].name, str(value).to_upper()])
	if value is Array:
		return str(value)
	var stat_info = statdata.statdata.get(stat, null)
	var display_value = value
	var suffix = ""
	if stat_info != null and stat_info.has("default_bonus"):
		match stat_info.default_bonus:
			"add_part", "add_part2":
				display_value *= 100
				suffix = "%"
			"mul", "mul2":
				display_value = (display_value - 1.0) * 100
				suffix = "%"
			_:
				if stat_info.percent:
					if !stat_info.has("base_100") or !stat_info.base_100:
						display_value *= 100
					suffix = "%"
	elif stat_info != null and stat_info.percent:
		display_value *= 100
		suffix = "%"
	var dsign = "+"
	if float(display_value) < 0:
		dsign = ""
	if display_value == int(display_value):
		display_value = int(display_value)
	return "%s%s%s" % [dsign, str(display_value), suffix]


func _build_trait_tooltip(trait):
	var text = "[center]%s[/center]\n%s" % [tr(trait.name), tr(trait.descript)]
	if trait.has("bonusstats"):
		var bonus_text = person.translate(globals.build_desc_for_bonusstats(trait.bonusstats).strip_edges())
		if bonus_text != "":
			text += "\n" + bonus_text
	return text
