extends Panel

var ReloadPanel
var SwitchLanguage

#warning-ignore-all:return_value_discarded
# var cheats = ['instant_travel','skip_combat','free_upgrades','instant_upgrades','invincible_player','show_enemy_hp','social_skill_unlimited_charges']
func _ready():
	$TabContainer.set_tab_title(0, tr("OPTNAME1"))
	$TabContainer.set_tab_title(1, tr("OPTNAME2"))
	$TabContainer.set_tab_title(2, tr("OPTNAME3"))
	$TabContainer.set_tab_title(3, tr("OPTNAME4"))
	for i in $TabContainer/Audio/VBoxContainer.get_children():
		i.connect("value_changed", self, 'soundsliderchange',[i.name])
		i.get_node("CheckBox").connect('pressed', self, 'mutepressed', [i.get_node("CheckBox")])
	$TabContainer/Visuals/fullscreen.connect("pressed",self,"togglefullscreen")
	$CloseButton.connect("pressed",self,'close')
	$TabContainer/Visuals/fullscreen.pressed = input_handler.globalsettings.fullscreen
	$TabContainer/Gameplay/VBoxContainer/malerate.connect("value_changed", self, 'male_rate_change')
	$TabContainer/Gameplay/VBoxContainer/futarate.connect("value_changed", self, "futa_rate_change")
	$TabContainer/Gameplay/VBoxContainer2/autosave_amount.min_value = variables.autosave_number_min
	$TabContainer/Gameplay/VBoxContainer2/autosave_amount.max_value = variables.autosave_number_max
	$TabContainer/Gameplay/VBoxContainer2/autosave_frequency.min_value = variables.autosave_frequency_min
	$TabContainer/Gameplay/VBoxContainer2/autosave_frequency.max_value = variables.autosave_frequency_max
	$TabContainer/Gameplay/VBoxContainer2/autosave_amount/.connect("value_changed", self, "autosave_amount_change")
	$TabContainer/Gameplay/VBoxContainer2/autosave_frequency/.connect("value_changed", self, "autosave_frequency_change")
	$TabContainer/Visuals/DisableAnimations.connect("toggled",self,"disable_animations_backgrounds")
	ReloadPanel = $ReloadGameLanguage
	SwitchLanguage = $TabContainer/Visuals/SwitchLanguage
	SwitchLanguage.OkPanel = ReloadPanel

	$TabContainer/Visuals/SwitchLanguage.text = tr("OPTIONSWITCHLANGUAGE") + ": " + input_handler.globalsettings.ActiveLocalization
	$ReloadGameLanguage/Button.connect('pressed', self, 'language_restart')


	for i in ['furry','furry_multiple_nipples', 'futa_balls', 'show_full_consent']:
		get_node("TabContainer/Gameplay/" + i).connect("pressed", self, "gameplay_rule", ['Gameplay', i])
		get_node("TabContainer/Gameplay/" + i).pressed = input_handler.globalsettings[i]
	for i in ['generate_portraits', 'factors_as_words', 'disable_paperdoll']:
		get_node("TabContainer/Visuals/" + i).connect("pressed", self, "gameplay_rule", ['Visuals', i])
		get_node("TabContainer/Visuals/" + i).pressed = input_handler.globalsettings[i]

	$TabContainer/Gameplay/enable_tutorials.connect("toggled", self, "enable_tutorials")


	$TabContainer/Cheats/EnterCodeMenu/GetCode.connect("pressed", self, "get_code")
	$TabContainer/Cheats/EnterCodeMenu/LineEdit.connect("text_changed", self, "text_changed")
	$TabContainer/Cheats/EnterCodeMenu/Activate.connect("pressed", self, "go_for_code")
	$TabContainer/Cheats/OpenCheatsMenu/CheatsMenu.connect("pressed", self, "open_cheats_menu")
	

func enable_tutorials(pressed):
	ResourceScripts.game_progress.show_tutorial = pressed



func open_cheats_menu():
	if gui_controller.cheat_panel == null:
		var c = load("res://gui_modules/Universal/Modules/CheatsModule.tscn")
		var cheats = c.instance()
		gui_controller.cheat_panel = cheats
		get_tree().get_root().add_child(cheats)
	gui_controller.windows_opened.append(gui_controller.cheat_panel)
	gui_controller.cheat_panel.raise()
	gui_controller.cheat_panel.open()


func text_changed(text):
	if ResourceScripts.game_globals.cheat_code == text:
		$TabContainer/Cheats/EnterCodeMenu/Activate.disconnect("pressed", self, "go_for_code")
		$TabContainer/Cheats/EnterCodeMenu/Activate.connect("pressed", self, "activate_cheats")

	# $TabContainer/Cheats/EnterCodeMenu/Activate.disabled = !ResourceScripts.game_progress.cheat_code == text


func activate_cheats():
	ResourceScripts.game_globals.cheats_active = true
	$TabContainer/Cheats/EnterCodeMenu.hide()
	$TabContainer/Cheats/OpenCheatsMenu.show()


func go_for_code():
	OS.shell_open("https://www.patreon.com/posts/new-password-18830450")


func open():
	$TabContainer/Gameplay/enable_tutorials.pressed = ResourceScripts.game_progress.show_tutorial
	# $TabContainer/Cheats/EnterCodeMenu/Activate.disabled = true
	$TabContainer/Cheats/EnterCodeMenu.visible = !ResourceScripts.game_globals.cheats_active
	$TabContainer/Cheats/OpenCheatsMenu.visible = ResourceScripts.game_globals.cheats_active
	$TabContainer/Cheats/OpenCheatsMenu/CheatsMenu.visible = get_parent().name != "Menu_v2"
	male_rate_change(input_handler.globalsettings.malechance)
	futa_rate_change(input_handler.globalsettings.futachance)
	autosave_amount_change(input_handler.globalsettings.autosave_number)
	autosave_frequency_change(input_handler.globalsettings.autosave_frequency)
	$TabContainer/Visuals/DisableAnimations.pressed = input_handler.globalsettings.animatedbackground


	for i in $TabContainer/Audio/VBoxContainer.get_children():
		i.value = input_handler.globalsettings[i.name+'vol']
		i.get_node("CheckBox").pressed = input_handler.globalsettings[i.name+'mute']
		i.editable = !i.get_node("CheckBox").pressed

func togglefullscreen():
	input_handler.globalsettings.fullscreen = $TabContainer/Visuals/fullscreen.pressed
	OS.window_fullscreen = input_handler.globalsettings.fullscreen
	if input_handler.globalsettings.fullscreen == false:
		OS.window_position = Vector2(0,0)

func soundsliderchange(value,name):
	if value <= -39:
		value = -80
	input_handler.globalsettings[name+'vol'] = value
	if name == 'sound':
		input_handler.PlaySound("menu_open")
	updatesounds()

func mutepressed(node):
	var name = node.get_parent().name
	input_handler.globalsettings[name + 'mute'] = node.pressed
	node.get_parent().editable = !node.pressed
	if node.pressed:
		node.get_parent().set("custom_styles/grabber_area", load("res://assets/Themes_v2/UNIVERSAL/GrabberDisabled.tres"))
	else:
		node.get_parent().set("custom_styles/grabber_area", null)
	updatesounds()

func updatesounds():
	var counter = 0
	for i in ['master','music','sound']:
		AudioServer.set_bus_mute(counter, input_handler.globalsettings[i+'mute'])
		AudioServer.set_bus_volume_db(counter, input_handler.globalsettings[i+'vol'])
		counter += 1


func close():
	hide()

# func cheat_toggle(i, button):
# 	variables.set(i,button.pressed)
func disable_animations_backgrounds(value):
	input_handler.globalsettings["animatedbackground"] = value

func male_rate_change(value):
	$TabContainer/Gameplay/VBoxContainer/malerate.value = value
	input_handler.globalsettings.malechance = value
	var text = tr('OPTGAMEPLAYMALERATE') + ": " +  str(value) + "%"
	$TabContainer/Gameplay/VBoxContainer/malerate/Label.text = text

func futa_rate_change(value):
	$TabContainer/Gameplay/VBoxContainer/futarate.value = value
	input_handler.globalsettings.futachance = value
	var text = tr('OPTGAMEPLAYFUTARATE') + ": " + str(value) + "%"
	$TabContainer/Gameplay/VBoxContainer/futarate/Label.text = text


func autosave_amount_change(value):
	$TabContainer/Gameplay/VBoxContainer2/autosave_amount.value = value
	input_handler.globalsettings.autosave_number = int(value)
	var text = tr('OPTFAMEPLAYAUTOSAVEAMOUNT') + ": " + str(value)
	$TabContainer/Gameplay/VBoxContainer2/autosave_amount/Label.text = text
	$TabContainer/Gameplay/VBoxContainer2/autosave_frequency.visible = (int(value) != 0)


func autosave_frequency_change(value):
	$TabContainer/Gameplay/VBoxContainer2/autosave_frequency.value = value
	input_handler.globalsettings.autosave_frequency = int(value)
	var text = tr('OPTGAMEPLAYAUTOSAVETIME') + ": " + str(value)
	$TabContainer/Gameplay/VBoxContainer2/autosave_frequency/Label.text = text


func gameplay_rule(tab, rule):
	input_handler.globalsettings[rule] = get_node("TabContainer/%s/%s" %[tab, rule]).pressed
	if rule == "turn_based_time_flow":
		if gui_controller.clock != null:
			gui_controller.clock.set_time_buttons()



func language_restart():
	get_tree().quit()
