extends Control

onready var progression = $Popup/Progression
onready var skill_loadout = $SkillLoadout

var clock_was_visible = false
var popup_target_position = Vector2.ZERO
var popup_target_margins = Rect2()
var progression_target_position = Vector2.ZERO
var open_sequence = 0


func _ready():
	$Popup/ClassesSelector.connect("pressed", self, "open_tab", ["classes"])
	$Popup/MasteriesSelector.connect("pressed", self, "open_tab", ["masteries"])
	$Popup/CloseButton.connect("pressed", self, "close")
	popup_target_margins = Rect2(
		Vector2($Popup.margin_left, $Popup.margin_top),
		Vector2($Popup.margin_right - $Popup.margin_left, $Popup.margin_bottom - $Popup.margin_top)
	)
	progression_target_position = progression.rect_position
	progression.set_popup_owner(self)
	_reset_popup_visuals()
	input_handler.register_btn_source("progression_classes_tab", self, "tut_get_classes_tab")
	input_handler.register_btn_source("progression_masteries_tab", self, "tut_get_masteries_tab")
	input_handler.register_btn_source("progression_close_button", self, "tut_get_close_button")


func tut_get_classes_tab():
	return $Popup/ClassesSelector


func tut_get_masteries_tab():
	return $Popup/MasteriesSelector


func tut_get_close_button():
	return $Popup/CloseButton


func open(person, tab = "classes"):
	if person == null:
		return
	if skill_loadout.visible:
		skill_loadout.close()
	input_handler.interacted_character = person
	open_sequence += 1
	var sequence = open_sequence
	_reset_popup_visuals()
	$Popup/Header/CharacterName.text = person.get_full_name()
	show()
	raise()
	_hide_clock()
	progression.reset_popup_state()
	progression.open(person)
	open_tab(tab, false)
	progression.call_deferred("reset_popup_scrolls")
	update_footer()
	$Popup/ClassesSelector/IconViewport.scroll_vertical = 0
	call_deferred("_play_open_animation", sequence)
	if !gui_controller.windows_opened.has(self):
		gui_controller.windows_opened.append(self)


func close():
	open_sequence += 1
	$Popup/Tween.stop_all()
	$Popup/Tween.remove_all()
	_reset_popup_visuals()
	hide()
	set_process(false)
	gui_controller.windows_opened.erase(self)
	if skill_loadout.visible:
		skill_loadout.close()
	progression.reset_popup_state()
	_restore_clock()


func _custom_gui_controller_close():
	close()


func open_tab(tab, animate = true):
	progression.set_active_tab(tab)
	$Popup/ClassesSelector.pressed = tab == "classes"
	$Popup/MasteriesSelector.pressed = tab == "masteries"
	if animate and visible:
		_play_tab_animation(tab)


func update_footer():
	var person = progression.person
	if person == null:
		return
	var current_exp = floor(person.get_stat("base_exp"))
	var required_exp = person.get_next_class_exp()
	$Popup/Footer/Experience.text = tr("EXPREQUIRED") + ": %d / %d" % [
		current_exp, required_exp
	]
	if current_exp >= required_exp:
		$Popup/Footer/Experience.set("custom_colors/font_color", Color(variables.hexcolordict.levelup_text_color))
	else:
		$Popup/Footer/Experience.set("custom_colors/font_color", Color(variables.hexcolordict.k_yellow))
	$Popup/Footer/Combat/Value.text = str(person.get_stat("mastery_point_combat"))
	$Popup/Footer/Magic/Value.text = str(person.get_stat("mastery_point_magic"))
	$Popup/Footer/Universal/Value.text = str(person.get_stat("mastery_point_universal"))
	$Popup/Footer/Combat/Icon.texture = images.get_icon("mastery_point_combat")
	$Popup/Footer/Magic/Icon.texture = images.get_icon("mastery_point_magic")
	$Popup/Footer/Universal/Icon.texture = images.get_icon("mastery_point_universal")
	globals.connecttexttooltip($Popup/Footer/Combat, tr("STATMASTERY_POINT_COMBAT"))
	globals.connecttexttooltip($Popup/Footer/Magic, tr("STATMASTERY_POINT_MAGIC"))
	globals.connecttexttooltip($Popup/Footer/Universal, tr("STATMASTERY_POINT_UNIVERSAL"))
	update_learned_classes(person)
	update_learned_masteries(person)


func update_learned_classes(person):
	var container = $Popup/ClassesSelector/IconViewport/Icons
	input_handler.ClearContainer(container, ["ClassTemplate"])
	for class_code in person.get_professions():
		if !classesdata.professions.has(class_code):
			continue
		var class_data = classesdata.professions[class_code]
		var class_icon = input_handler.DuplicateContainerTemplate(container, "ClassTemplate")
		class_icon.get_node("Icon").texture = class_data.icon
		globals.connectclasstooltip(class_icon, person, class_code)


func update_learned_masteries(person):
	var container = $Popup/MasteriesSelector/IconViewport/Icons
	input_handler.ClearContainer(container, ["MasteryTemplate"])
	var learned_masteries = []
	for mastery_code in Skilldata.masteries:
		var level = int(person.get_stat("mastery_" + mastery_code))
		if level <= 0:
			continue
		learned_masteries.append({"code": mastery_code, "level": level})
	learned_masteries.sort_custom(self, "_sort_masteries_descending")
	for mastery in learned_masteries:
		var mastery_code = mastery.code
		var level = mastery.level
		var mastery_data = Skilldata.masteries[mastery_code]
		var mastery_icon = input_handler.DuplicateContainerTemplate(container, "MasteryTemplate")
		mastery_icon.get_node("Icon").texture = images.get_icon(mastery_data.icon)
		mastery_icon.get_node("Level").text = str(level)
		globals.connecttexttooltip(mastery_icon, tr(mastery_data.name))


func _sort_masteries_descending(first, second):
	if first.level == second.level:
		return str(first.code) < str(second.code)
	return first.level > second.level


func open_skill_loadout(person):
	skill_loadout.open(person)


func _play_open_animation(sequence):
	if !visible or sequence != open_sequence:
		return
	var popup = $Popup
	var tween = $Popup/Tween
	tween.stop_all()
	tween.remove_all()
	popup.rect_pivot_offset = popup.rect_size * 0.5
	var target_position = popup_target_position
	popup.rect_position = target_position + Vector2(0, 24)
	popup.rect_scale = Vector2(0.94, 0.94)
	popup.modulate = Color(1, 1, 1, 0)
	$Dim.modulate = Color(1, 1, 1, 0)
	tween.interpolate_property(popup, "rect_position", popup.rect_position, target_position, 0.28, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(popup, "rect_scale", popup.rect_scale, Vector2(1, 1), 0.28, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(popup, "modulate:a", 0.0, 1.0, 0.22, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property($Dim, "modulate:a", 0.0, 1.0, 0.22, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()


func _play_tab_animation(tab):
	var tween = $Popup/TabTween
	tween.stop_all()
	tween.remove_all()
	var direction = -1 if tab == "classes" else 1
	progression.rect_position = progression_target_position + Vector2(72 * direction, 0)
	progression.modulate = Color(1, 1, 1, 0)
	tween.interpolate_property(progression, "rect_position", progression.rect_position, progression_target_position, 0.24, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(progression, "modulate:a", 0.0, 1.0, 0.18, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()


func _reset_popup_visuals():
	$Popup/TabTween.stop_all()
	$Popup/TabTween.remove_all()
	$Popup.margin_left = popup_target_margins.position.x
	$Popup.margin_top = popup_target_margins.position.y
	$Popup.margin_right = popup_target_margins.position.x + popup_target_margins.size.x
	$Popup.margin_bottom = popup_target_margins.position.y + popup_target_margins.size.y
	popup_target_position = $Popup.rect_position
	$Popup.rect_scale = Vector2.ONE
	$Popup.modulate = Color.white
	$Dim.modulate = Color.white
	progression.rect_position = progression_target_position
	progression.modulate = Color.white


func _hide_clock():
	clock_was_visible = gui_controller.clock != null and gui_controller.clock.visible
	if gui_controller.clock != null:
		gui_controller.clock.hide()
	set_process(true)


func _restore_clock():
	if clock_was_visible and gui_controller.clock != null:
		gui_controller.clock.show()
	clock_was_visible = false


func _process(_delta):
	if visible and gui_controller.clock != null and gui_controller.clock.visible:
		gui_controller.clock.hide()
