extends Panel

var ReloadPanel
var SwitchLanguage

#warning-ignore-all:return_value_discarded
# var cheats = ['instant_travel','skip_combat','free_upgrades','instant_upgrades','invincible_player','show_enemy_hp','social_skill_unlimited_charges']
func _ready():
	$TabContainer.set_tab_title(0, tr("OPTNAME1"))
	$TabContainer.set_tab_title(1, tr("OPTNAME2"))
	$TabContainer.set_tab_title(2, tr("OPTNAME5"))
	$TabContainer.set_tab_title(3, tr("OPTNAME3"))
	$TabContainer.set_tab_title(4, tr("OPTNAMEHOTKEYS"))
	$TabContainer.set_tab_title(5, tr("OPTNAME4"))
	for i in $TabContainer/Audio/VBoxContainer.get_children():
		i.connect("value_changed", self, 'soundsliderchange',[i.name])
		i.get_node("CheckBox").connect('pressed', self, 'mutepressed', [i.get_node("CheckBox")])
	$TabContainer/Visuals/fullscreen.connect("pressed",self,"togglefullscreen")
	$CloseButton.connect("pressed",self,'close')
	$TabContainer/Visuals/fullscreen.pressed = input_handler.globalsettings.fullscreen
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer/malerate.connect("value_changed", self, 'male_rate_change')
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer/futarate.connect("value_changed", self, "futa_rate_change")
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer2/autosave_amount.min_value = variables.autosave_number_min
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer2/autosave_amount.max_value = variables.autosave_number_max
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer2/autosave_frequency.min_value = variables.autosave_frequency_min
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer2/autosave_frequency.max_value = variables.autosave_frequency_max
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer2/autosave_amount/.connect("value_changed", self, "autosave_amount_change")
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer2/autosave_frequency/.connect("value_changed", self, "autosave_frequency_change")
	$TabContainer/Visuals/DisableAnimations.connect("toggled",self,"disable_animations_backgrounds")
	ReloadPanel = $ReloadGameLanguage
	SwitchLanguage = $TabContainer/Visuals/SwitchLanguage
	SwitchLanguage.OkPanel = ReloadPanel

	$ReloadGameLanguage/Button.connect('pressed', self, 'language_restart')


	for i in ['furry','furry_multiple_nipples', 'futa_balls', 'show_full_consent', 'disable_mods_on_update']:
		get_node("TabContainer/Gameplay/Scroll/Box/" + i).connect("pressed", self, "gameplay_rule", ['Gameplay/Scroll/Box', i])
		get_node("TabContainer/Gameplay/Scroll/Box/" + i).pressed = input_handler.globalsettings[i]
	for i in ['diff_gf_only_upg','diff_permadeath', 'diff_bonus_taskmod', 'diff_bonus_loot', 'diff_stop_loan', 'diff_free_gather','easytrain']:
		get_node("TabContainer/Gameplay2/Scroll/Box/" + i).connect("pressed", self, "gamestate_rule",  [i])
		get_node("TabContainer/Gameplay2/Scroll/Box/" + i).pressed = ResourceScripts.game_globals.get(i)
		globals.connecttexttooltip(get_node("TabContainer/Gameplay2/Scroll/Box/" + i), tr("SETTING"+i.trim_prefix('diff_').to_upper() + '_DESCRIPT'))
	for i in ['generate_portraits', 'factors_as_words', 'no_damage_shake', 'item_flight_animation', 'fps_meter', 'fast_combat']:
		get_node("TabContainer/Visuals/" + i).connect("pressed", self, "gameplay_rule", ['Visuals', i])
		get_node("TabContainer/Visuals/" + i).pressed = input_handler.globalsettings[i]
	# The doll's own section. `disable_paperdoll` moved in here: it decides whether
	# the doll is drawn at all, so the two settings that only mean anything while
	# it is belong beside it rather than three rows away.
	for i in ['disable_paperdoll', 'doll_idle_animation', 'darker_pregnancy_nipples']:
		get_node("TabContainer/Visuals/Doll/" + i).connect("pressed", self, "doll_rule", [i])
		get_node("TabContainer/Visuals/Doll/" + i).pressed = input_handler.globalsettings[i]

	$TabContainer/Gameplay/Scroll/Box/enable_tutorials.connect("toggled", self, "enable_tutorials")


	$TabContainer/Cheats/EnterCodeMenu/GetCode.connect("pressed", self, "go_for_code")
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


func text_changed(_text):
	pass

	# $TabContainer/Cheats/EnterCodeMenu/Activate.disabled = text.sha256_text() != variables.cheat_code_hash


func activate_cheats():
	$TabContainer/Cheats/EnterCodeMenu.hide()
	$TabContainer/Cheats/OpenCheatsMenu.show()


func go_for_code():
	if OS.has_feature('editor'): #editor builds skip the code, the password itself is not in the build
		input_handler.unlock_cheats()
		activate_cheats()
		return
	if input_handler.try_cheat_password($TabContainer/Cheats/EnterCodeMenu/LineEdit.text):
		activate_cheats()
		return
	$SupporterLinks.open()


func open():
	$TabContainer/Hotkeys.update_labels()
	#the old tutorial is retired, so its switch is not offered any more
	$TabContainer/Gameplay/Scroll/Box/enable_tutorials.hide()
	# $TabContainer/Cheats/EnterCodeMenu/Activate.disabled = true
	$TabContainer/Cheats/EnterCodeMenu.visible = !input_handler.cheats_unlocked()
	$TabContainer/Cheats/OpenCheatsMenu.visible = input_handler.cheats_unlocked()
	#the cheat menu operates on the running game (party, resources), so it is only
	#reachable in-game - the main menu shows the "cheats unlocked" line without the button
	$TabContainer/Cheats/OpenCheatsMenu/CheatsMenu.visible = is_instance_valid(gui_controller.mansion)
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
	input_handler.emit_signal("animatedbackground_changed")

func male_rate_change(value):
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer/malerate.value = value
	input_handler.globalsettings.malechance = value
	var text = tr('OPTGAMEPLAYMALERATE') + ": " +  str(value) + "%"
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer/Label.text = text

func futa_rate_change(value):
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer/futarate.value = value
	input_handler.globalsettings.futachance = value
	var text = tr('OPTGAMEPLAYFUTARATE') + ": " + str(value) + "%"
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer/Label2.text = text


func autosave_amount_change(value):
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer2/autosave_amount.value = value
	input_handler.globalsettings.autosave_number = int(value)
	var text = tr('OPTFAMEPLAYAUTOSAVEAMOUNT') + ": " + str(value)
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer2/Label.text = text
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer2/autosave_frequency.visible = (int(value) != 0)


func autosave_frequency_change(value):
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer2/autosave_frequency.value = value
	input_handler.globalsettings.autosave_frequency = int(value)
	var text = tr('OPTGAMEPLAYAUTOSAVETIME') + ": " + str(value)
	$TabContainer/Gameplay/Scroll/Box/VBoxContainer2/Label2.text = text


func gameplay_rule(tab, rule):
	input_handler.globalsettings[rule] = get_node("TabContainer/%s/%s" %[tab, rule]).pressed
	if rule == "turn_based_time_flow":
		if gui_controller.clock != null:
			gui_controller.clock.set_time_buttons()


# A doll on screen reads these live, so the change is announced instead of waited
# for: this panel opens over the character it repaints.
func doll_rule(rule):
	input_handler.globalsettings[rule] = get_node("TabContainer/Visuals/Doll/%s" % rule).pressed
	input_handler.emit_signal("doll_settings_changed")


func gamestate_rule(rule):
	ResourceScripts.game_globals.set(rule, get_node("TabContainer/Gameplay2/Scroll/Box/%s" % rule).pressed)


func language_restart():
	get_tree().quit()
