extends Control

signal closing

var activecharacter
var selected_category = "all"

onready var window = $Window
onready var tween = $Tween


func _ready():
	$Window/Header/CloseButton.connect("pressed", self, "close")
	$Window/Done.connect("pressed", self, "close")
	$Window/Loadout/RowSwitch/Previous.connect("pressed", self, "change_panel_row", [-1])
	$Window/Loadout/RowSwitch/Next.connect("pressed", self, "change_panel_row", [1])
	for button in $Window/Catalog/Categories.get_children():
		button.connect("pressed", self, "select_category", [button.name])
	$Window/Catalog/SkillScroll.target_node = self
	_connect_category_tooltips()
	clear_skill_info()
	hide()


func open(person):
	if person == null:
		return
	activecharacter = person
	selected_category = "all"
	$Window/Header/CharacterName.text = person.get_full_name()
	_reset_categories()
	clear_skill_info()
	rebuild()
	show()
	raise()
	_play_open_animation()
	if !gui_controller.windows_opened.has(self):
		gui_controller.windows_opened.append(self)


func close():
	if !visible and activecharacter == null:
		return
	tween.stop_all()
	tween.remove_all()
	hide()
	gui_controller.windows_opened.erase(self)
	_refresh_external_skillbar()
	activecharacter = null
	emit_signal("closing")


func _custom_gui_controller_close():
	close()


func select_category(category):
	selected_category = category
	for button in $Window/Catalog/Categories.get_children():
		button.pressed = button.name == selected_category
	apply_filter()


func _reset_categories():
	for button in $Window/Catalog/Categories.get_children():
		button.pressed = button.name == selected_category
	$Window/Catalog/SkillScroll.scroll_vertical = 0


func apply_filter():
	for button in $Window/Catalog/SkillScroll/Grid.get_children():
		if !button.has_meta("skill"):
			continue
		button.visible = _skill_matches_category(button.get_meta("skill"))


func _skill_matches_category(skill):
	match selected_category:
		"all":
			return true
		"skill", "spell":
			return skill.ability_type == selected_category
		"support", "aoe", "heal":
			return skill.tags.has(selected_category)
	return true


func rebuild():
	if activecharacter == null:
		update_row_display()
		return
	_build_catalog()
	_build_loadout()
	apply_filter()
	update_row_display()


func _build_catalog():
	var grid = $Window/Catalog/SkillScroll/Grid
	input_handler.ClearContainer(grid)
	for skill_code in activecharacter.get_combat_skills():
		var skill = Skilldata.get_template_combat(skill_code, activecharacter)
		var button = input_handler.DuplicateContainerTemplate(grid)
		button.dragdata = {skill = skill_code}
		button.target_node = self
		button.set_meta("skill", skill)
		button.get_node("Icon").texture = skill.icon
		_apply_aura_material(button.get_node("Icon"), skill)
		button.connect("mouse_entered", self, "show_skill_info", [skill])


func _build_loadout():
	var grid = $Window/Loadout/Slots/Grid
	input_handler.ClearContainer(grid)
	var source = activecharacter.skills.combat_skill_panel
	var row_offset = activecharacter.skills.get_combat_panel_row_offset()
	var row_size = variables.combat_panel_row_size
	for local_position in range(1, row_size + 1):
		var position = row_offset + local_position
		var slot = input_handler.DuplicateContainerTemplate(grid)
		slot.target_node = self
		slot.dragdata = {position = position}
		slot.get_node("Number").text = str(local_position) if local_position <= 10 else ""
		if source.has(position):
			var skill = Skilldata.get_template_combat(source[position], activecharacter)
			slot.get_node("Icon").texture = skill.icon
			_apply_aura_material(slot.get_node("Icon"), skill)
			slot.set_meta("skill", skill)
			slot.connect("mouse_entered", self, "show_skill_info", [skill])
		else:
			slot.draggable = false


func set_skill_to_pos(skill_code, position):
	if activecharacter == null:
		return
	var source = activecharacter.skills.combat_skill_panel
	var max_slots = activecharacter.skills.get_combat_panel_max_slots()
	if position < 1 or position > max_slots:
		return
	source[position] = skill_code
	rebuild()


func swap_positions(first, second):
	if activecharacter == null:
		return
	var source = activecharacter.skills.combat_skill_panel
	var max_slots = activecharacter.skills.get_combat_panel_max_slots()
	if first < 1 or second < 1 or first > max_slots or second > max_slots:
		return
	if !source.has(first):
		source[first] = source[second]
		source.erase(second)
	elif !source.has(second):
		source[second] = source[first]
		source.erase(first)
	else:
		var temporary = source[first]
		source[first] = source[second]
		source[second] = temporary
	rebuild()


func remove_skill_from_pos(position):
	if activecharacter == null:
		return
	activecharacter.skills.combat_skill_panel.erase(position)
	rebuild()


func change_panel_row(delta):
	if activecharacter == null:
		return
	activecharacter.skills.change_combat_panel_row(delta)
	clear_skill_info()
	rebuild()


func update_row_display():
	if activecharacter == null:
		$Window/Loadout/RowSwitch/Value.text = "--/--"
		return
	var current = activecharacter.skills.clamp_combat_panel_row()
	$Window/Loadout/RowSwitch/Value.text = str(current) + "/" + str(variables.combat_panel_rows)


func show_skill_info(skill):
	$Window/Info/EmptyHint.hide()
	$Window/Info/SkillInfo.show()
	$Window/Info/SkillInfo/IconFrame/Icon.texture = skill.icon
	$Window/Info/SkillInfo/Name.text = tr("SKILL" + skill.code.to_upper())
	$Window/Info/SkillInfo/Description.bbcode_text = globals.TextEncoder(tr("SKILL" + skill.code.to_upper() + "DESCRIPT"))
	if skill.has("container"):
		$Window/Info/SkillInfo/Cost.hide()
		$Window/Info/SkillInfo/CostIcon.hide()
	else:
		$Window/Info/SkillInfo/Cost.show()
		$Window/Info/SkillInfo/CostIcon.show()
		$Window/Info/SkillInfo/Cost.text = str(int(skill.cost.get("mp", 0)))
	$Window/Info/SkillInfo/Cooldown.text = str(skill.cooldown)


func clear_skill_info():
	$Window/Info/SkillInfo.hide()
	$Window/Info/EmptyHint.show()
	$Window/Info/SkillInfo/IconFrame/Icon.texture = null
	$Window/Info/SkillInfo/Name.text = ""
	$Window/Info/SkillInfo/Description.bbcode_text = ""


func _apply_aura_material(icon, skill):
	icon.material = null
	if skill.tags.has("aura_active"):
		icon.material = load("res://assets/book_shader.tres")


func _connect_category_tooltips():
	globals.connecttexttooltip($Window/Catalog/Categories/all, tr("SKILLS_CAT_ALL_DESC"))
	globals.connecttexttooltip($Window/Catalog/Categories/skill, tr("SKILLS_LABEL"))
	globals.connecttexttooltip($Window/Catalog/Categories/spell, tr("SKILLS_CAT_SPELLS_DESC"))
	globals.connecttexttooltip($Window/Catalog/Categories/support, tr("SKILLS_CAT_SUPPORT_DESC"))
	globals.connecttexttooltip($Window/Catalog/Categories/aoe, tr("SKILLS_CAT_AOE_DESC"))
	globals.connecttexttooltip($Window/Catalog/Categories/heal, tr("SKILLS_CAT_HEAL_DESC"))


func _refresh_external_skillbar():
	if gui_controller.mansion == null:
		return
	var skillbar = gui_controller.mansion.get_node_or_null("MansionSkillsModule")
	if skillbar != null and skillbar.has_method("build_skill_panel"):
		skillbar.build_skill_panel()


func _play_open_animation():
	tween.stop_all()
	tween.remove_all()
	window.rect_pivot_offset = window.rect_size * 0.5
	window.rect_scale = Vector2(0.95, 0.95)
	window.modulate = Color(1, 1, 1, 0)
	$Dim.modulate = Color(1, 1, 1, 0)
	tween.interpolate_property(window, "rect_scale", window.rect_scale, Vector2.ONE, 0.24, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(window, "modulate:a", 0.0, 1.0, 0.18, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property($Dim, "modulate:a", 0.0, 1.0, 0.18, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
