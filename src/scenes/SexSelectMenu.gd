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
onready var _max_participants_label = $MaxParticipantsLabel
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
	selected_characters.clear()
	_reset_category_buttons()
	rebuild_list()
	show()
	raise()
	input_handler.append_not_duplicate(gui_controller.windows_opened, self)

func hide():
	gui_controller.windows_opened.erase(self)
	.hide()


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

		if _is_missing_sex_traits(person):
			name_label.add_color_override("font_color", Color(1, 0.67, 0.67))
			globals.connecttexttooltip(newbutton, person.translate(tr("SEXSELECT_MISSING_TRAITS")))

	_update_participant_label()
	_update_interaction_label()
	update_sex_date_buttons()

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
	gui_controller.sex_panel.show()
	hide()



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
	var slavelimit = 2
	if ResourceScripts.game_res.upgrades.has('master_bedroom'):
		slavelimit += ResourceScripts.game_res.upgrades.master_bedroom
	return slavelimit


func _update_participant_label():
	if _participant_label == null:
		return
	var current_count = selected_characters.size()
	var max_count = calculate_sex_limits()
	_participant_label.text = tr("Participants: %s/%s") % [str(current_count), str(max_count)]
	if _max_participants_label != null:
		_max_participants_label.text = tr("Bedroom limit: %s") % str(max_count)
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
