extends Panel


func _ready():
	$SexButton.connect("pressed", self, "start_scene")
	$DateButton.connect("pressed", self, "start_date")


func start_scene():
	var choosen_chars = get_parent().sex_participants
	for i in choosen_chars:
		i.add_stat('metrics_sex', 1)
	if !ResourceScripts.game_progress.unlimited_date_sex:
		ResourceScripts.game_globals.weekly_sex_left -= 1
	ResourceScripts.core_animations.BlackScreenTransition()
	yield(get_tree().create_timer(0.5), "timeout")
	gui_controller.sex_panel = input_handler.get_spec_node(input_handler.NODE_SEX)
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.sex_panel
	gui_controller.sex_panel.raise()
	gui_controller.sex_panel.startsequence(choosen_chars)
	gui_controller.sex_panel.show()



func start_date():
	var person
	if get_parent().sex_participants[0] == ResourceScripts.game_party.get_master():
		person = get_parent().sex_participants[1]
	else:
		person = get_parent().sex_participants[0]
	person.add_stat('metrics_dates', 1)
	if !ResourceScripts.game_progress.unlimited_date_sex:
		ResourceScripts.game_globals.weekly_dates_left -= 1
	person.tags.push_back("no_date_day")
	ResourceScripts.core_animations.BlackScreenTransition()
	yield(get_tree().create_timer(0.5), "timeout")
	gui_controller.date_panel = input_handler.get_spec_node(input_handler.NODE_DATE)
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.date_panel
	gui_controller.date_panel.raise()
	gui_controller.date_panel.initiate(person)
	gui_controller.date_panel.show()

