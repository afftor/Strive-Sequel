extends Panel

var selected_characters = []
var _active_category = "all"
onready var _category_buttons = {
	"all": $Categories/all,
	"male": $Categories/male,
	"female": $Categories/female,
	"futa": $Categories/futa,
}

func _ready():
	gui_controller.add_close_button(self)
	$ConfirmButton.connect("pressed",self, 'start_scene')
	for category in _category_buttons.keys():
		var button = _category_buttons[category]
		button.connect("pressed", self, "_on_category_pressed", [category])

func open():
	selected_characters.clear()
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
		if !is_selected and !_is_person_in_active_category(person):
			continue
		var workcontainer = $SelectedContainer/VBoxContainer if is_selected else $ScrollContainer/VBoxContainer
		var newbutton = input_handler.DuplicateContainerTemplate(workcontainer)
		newbutton.get_node("Label").text = person.get_short_name()
		newbutton.get_node("Icon").texture = person.get_icon_small()
		newbutton.get_node("Consent").text = str(tr(variables.consent_dict[int(person.get_stat('consent'))]))
		if is_selected:
			newbutton.connect('pressed', self, 'deselect', [person, newbutton])
		else:
			newbutton.connect('pressed', self, 'select_for_sex', [person, newbutton])

func _on_category_pressed(category):
	if _active_category == category:
		return
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



func update_sex_date_buttons():
	if ResourceScripts.game_globals.weekly_sex_left > 0:
		$ConfirmButton.disabled = selected_characters.size() < 2 || selected_characters.size() > calculate_sex_limits()
	else:
		$ConfirmButton.disabled = true

	for i in selected_characters:
		if i.has_status("no_sex"):
			$ConfirmButton.disabled = true
			$ConfirmButton.hint_tooltip = "One of unique characters has not proceeded their questline yet"


func calculate_sex_limits():
	var slavelimit = 2
	if ResourceScripts.game_res.upgrades.has('master_bedroom'):
		slavelimit += ResourceScripts.game_res.upgrades.master_bedroom
	return slavelimit
