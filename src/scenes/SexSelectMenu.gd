extends Panel

var selected_characters = []
var _active_category = "all"
onready var _category_buttons = {
	"all": $Categories/all,
	"male": $Categories/male,
	"female": $Categories/female,
	"futa": $Categories/futa,
}
onready var _category_tooltips = {
	"all": tr("CAT_ALL"),
	"male": tr("SLAVESEXMALE"),
	"female": tr("SLAVESEXFEMALE"),
	"futa": tr("SLAVESEXFUTA"),
}
onready var _participant_label = $ParticipantLabel
onready var _interaction_limit_label = $InteractionLimitLabel
onready var _limit_icon = $TextureRect

func _ready():
	gui_controller.add_close_button(self)
	$ConfirmButton.connect("pressed",self, 'start_scene')
	for category in _category_buttons.keys():
		var button = _category_buttons[category]
		button.connect("pressed", self, "_on_category_pressed", [category])
		if _category_tooltips.has(category):
			globals.connecttexttooltip(button, _category_tooltips[category])
	_reset_category_buttons()
	globals.connecttexttooltip(_limit_icon, tr("SEXTOOLTIP"))

func open():
	hide_person_info()
	selected_characters.clear()
	_reset_category_buttons()
	rebuild_list()
	show()
	raise()
	input_handler.append_not_duplicate(gui_controller.windows_opened, self)

func hide():
	gui_controller.windows_opened.erase(self)
	.hide()


#gui_controller.close_scene() ends by raising the mansion, showing it and putting it back to
#its default state. That is right for a window opened over the mansion and wrong here:
#start_scene() has already handed the screen to the sex panel by the time it calls this, so
#the tail was pulling the mansion back over the scene that had just started. It used to be
#skipped only because the window was registered against the rail's sex button, and that
#button is gone - the master's bedroom opens this now.
func _custom_gui_controller_close():
	hide()


func rebuild_list():
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	input_handler.ClearContainer($SelectedContainer/VBoxContainer)

	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		var is_selected = selected_characters.has(person)
		if (!is_selected and !_is_person_in_active_category(person)) ||  person.is_on_quest():
			continue
		var workcontainer = $SelectedContainer/VBoxContainer if is_selected else $ScrollContainer/VBoxContainer
		var newbutton = input_handler.DuplicateContainerTemplate(workcontainer)
		var name_label = newbutton.get_node("Label")
		var consent_label = newbutton.get_node("Consent")
		name_label.text = person.get_short_name()
		name_label.add_color_override("font_color", Color(1, 1, 1))
		newbutton.get_node("Icon").texture = person.get_icon_small()
		newbutton.get_node("SexIcon").texture = images.get_icon(person.get_stat('sex'))
		consent_label.visible = !person.is_master()
		if consent_label.visible:
			consent_label.text = str(tr(variables.consent_dict[int(person.get_stat('consent'))]))
		if is_selected:
			newbutton.disabled = false
			newbutton.connect('pressed', self, 'deselect', [person, newbutton])
		else:
			var lock_reason = _get_participant_lock_reason(person)
			if lock_reason == "":
				newbutton.disabled = false
				newbutton.connect('pressed', self, 'select_for_sex', [person, newbutton])
			else:
				newbutton.disabled = true
				globals.connecttexttooltip(newbutton,lock_reason)

		var warning = ""
		if newbutton.disabled:
			warning = _get_participant_lock_reason(person)
		if _is_missing_sex_traits(person):
			name_label.add_color_override("font_color", Color(1, 0.67, 0.67))
			warning = person.translate(tr("SEXSELECT_MISSING_TRAITS")) + warning
		#Looking at a face fills the panel standing beside the window rather than opening a
		#tooltip at the cursor: the list is long, and a card that jumps about with the mouse is
		#not something two people can be compared in.
		newbutton.connect("mouse_entered", self, "show_person_info", [person])
		if warning != "":
			globals.connecttexttooltip(newbutton, warning)

	#whoever was being looked at is still worth showing once the list is drawn again
	if info_person != null:
		show_person_info(info_person)
	_update_participant_label()
	_update_interaction_label()
	update_sex_date_buttons()


#### the panel beside the window ####

#Consent and how far each practice has been trained, drawn the way the character screen draws
#the same thing - a name, a bar and the level it stands at - rather than as a wall of text.
const SEX_TRAINING_PROGRESS = {novice = 0, skilled = 50, mastered = 100}

var info_person = null


func show_person_info(person):
	info_person = person
	var info = $Info
	info.visible = true
	info.get_node("Name").text = person.get_short_name()
	var consent_label = info.get_node("Consent")
	consent_label.visible = !person.is_master()
	if consent_label.visible:
		var consent = int(person.get_stat('consent'))
		consent_label.text = tr('SIBLINGMODULECONSENT') + tr(variables.consent_dict[consent])
		globals.connecttexttooltip(consent_label, tr('INFOCONSENT'))
	var stamina = info.get_node("Stamina")
	stamina.text = tr("STATSEX_STAMINA") + ": " + str(person.get_stat('sex_stamina'))
	globals.connecttexttooltip(stamina, "[center]" + tr("STATSEX_STAMINA") + "[/center]\n"
		+ tr("STATSEX_STAMINADESCRIPT"))
	var list = info.get_node("Skills/VBoxContainer")
	input_handler.ClearContainer(list)
	var trained = 0
	var training = person.get_sex_training()
	for code in training:
		if _skill_says_nothing(person, code, training[code]):
			continue
		var row = input_handler.DuplicateContainerTemplate(list)
		var level = _sex_training_label(training[code])
		row.get_node("Label").text = tr("CHARINFO_" + code.to_upper())
		row.get_node("ProgressBar").value = SEX_TRAINING_PROGRESS.get(training[code], 0)
		row.get_node("ProgressBar/Label").text = level
		var text = person.translate(tr("STAT" + code.to_upper() + "DESCRIPT"))
		globals.connecttexttooltip(row, text + "\n" + tr("CUR_LEVEL_LABEL") + ": " + level)
		trained += 1
	info.get_node("SkillsHeader").visible = trained > 0
	info.get_node("Skills").visible = trained > 0
	info.get_node("Empty").visible = trained == 0


#The three that say nothing about somebody who has never been trained in them - the same three
#the character screen leaves out.
func _skill_says_nothing(person, code, state):
	if state != 'novice':
		return false
	if code == 'sex_training_tail':
		return true
	if code == 'sex_training_penetration' and person.get_stat('penis_size') == '':
		return true
	if code == 'sex_training_pussy' and person.get_stat('sex') == 'male':
		return true
	return false


func hide_person_info():
	info_person = null
	$Info.visible = false


func _sex_training_label(state):
	match state:
		'novice': return tr('SEX_TRAINING_LEVEL_NOVICE')
		'skilled': return tr('SEX_TRAINING_LEVEL_SKILLED')
		'mastered': return tr('SEX_TRAINING_LEVEL_MASTERED')
	return str(state).capitalize()


func _on_category_pressed(category):
	if _active_category == category:
		_category_buttons[category].set_pressed_no_signal(true)
		return
	for key in _category_buttons.keys():
		_category_buttons[key].set_pressed_no_signal(key == category)
	_active_category = category
	rebuild_list()

func _is_person_in_active_category(person):
	if _active_category == "all":
		return true
	var sex = person.get_stat('sex')
	if _active_category == "futa":
		return sex in ["futa", "futanari"]
	return sex == _active_category


func select_for_sex(person, button):
	selected_characters.append(person)

	rebuild_list()

func deselect(person, button):
	selected_characters.erase(person)

	rebuild_list()

func start_scene():
	for i in selected_characters:
		i.add_stat('metrics_sex', 1)
	if !ResourceScripts.game_globals.unlimited_date_sex:
		ResourceScripts.game_globals.weekly_sex_left -= 1
	ResourceScripts.core_animations.BlackScreenTransition()
	yield(get_tree().create_timer(0.5), "timeout")
	gui_controller.sex_panel = input_handler.get_spec_node(input_handler.NODE_SEX)
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.sex_panel
	gui_controller.sex_panel.raise()
	gui_controller.sex_panel.startsequence(selected_characters)
	ResourceScripts.core_animations.OpenAnimation(gui_controller.sex_panel)
	get_parent().mansion_state_set("hidden")
	gui_controller.close_scene(self)



func update_sex_date_buttons():
	$ConfirmButton.hint_tooltip = ""
	if ResourceScripts.game_globals.weekly_sex_left > 0:
		$ConfirmButton.disabled = selected_characters.size() < 2 || selected_characters.size() > calculate_sex_limits()
	else:
		$ConfirmButton.disabled = true

	for i in selected_characters:
		if i.has_status("no_sex"):
			$ConfirmButton.disabled = true
			$ConfirmButton.hint_tooltip = "One of unique characters has not proceeded their questline yet"
	_update_participant_label()


func calculate_sex_limits():
	if get_parent() != null && get_parent().get("in_test_mode") == true:
		return ResourceScripts.game_party.character_order.size()
	return ResourceScripts.game_res.get_sex_limit()


func _update_participant_label():
	if _participant_label == null:
		return
	var current_count = selected_characters.size()
	var max_count = calculate_sex_limits()
	_participant_label.text = tr("PARTICIPANTS_LABEL") % [str(current_count), str(max_count)]
	if current_count > max_count:
		_participant_label.add_color_override("font_color", Color(1, 0.4, 0.4))
	else:
		_participant_label.add_color_override("font_color", Color(1, 1, 1))


func _update_interaction_label():
	if _interaction_limit_label == null:
		return
	if ResourceScripts.game_globals.unlimited_date_sex:
		_interaction_limit_label.text = tr("SEXSELECT_INTERACTIONS_UNLIMITED")
	else:
		var remaining = ResourceScripts.game_globals.weekly_sex_left
		var maximum = ResourceScripts.game_globals.weekly_sex_max
		_interaction_limit_label.text = tr("SEXSELECT_INTERACTIONS") % [str(remaining), str(maximum)]


func _get_participant_lock_reason(person):
	if person.has_status("no_sex"):
		return tr("This character's questline prevents them from joining for now.")
	return ""


func _reset_category_buttons():
	_active_category = "all"
	for key in _category_buttons.keys():
		_category_buttons[key].set_pressed_no_signal(key == _active_category)


func _is_missing_sex_traits(person):
	return person.get_unlocked_sex_traits().empty()
