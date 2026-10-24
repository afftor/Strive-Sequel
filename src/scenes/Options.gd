extends Panel

var ReloadPanel
var SwitchLanguage
var NGPlusButton
var NGPlusButtonY #its place in the scene, kept so the button can be moved back to it
#In game this panel sits in the game menu's CanvasLayer, which is drawn over the shared tooltip
#at the tree root - so the panel's tooltips go through a tooltip of its own instead.
onready var Tooltip = $TextTooltip

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
	for i in [-1, 1]:
		var arrow = 'LArr' if i < 0 else 'RArr'
		get_node("TabContainer/Visuals/window_mode/" + arrow).connect("pressed", self, "change_window_mode", [i])
		get_node("TabContainer/Visuals/resolution/" + arrow).connect("pressed", self, "change_resolution", [i])
	globals.connecttexttooltip($TabContainer/Visuals/window_mode, tr("OPTWINDOWMODE_DESCRIPT"), false, Tooltip)
	globals.connecttexttooltip($TabContainer/Visuals/resolution, tr("OPTRESOLUTION_DESCRIPT"), false, Tooltip)
	input_handler.connect("window_mode_changed", self, "update_display_options")
	$CloseButton.connect("pressed",self,'close')
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
	#the flags were hooked to the shared tooltip in their own _ready, before this one ran
	for flag in SwitchLanguage.get_children():
		globals.connecttexttooltip(flag, SwitchLanguage.locale_names[flag.name], false, Tooltip)

	$ReloadGameLanguage/Button.connect('pressed', self, 'language_restart')


	for i in ['furry','furry_multiple_nipples', 'futa_balls', 'show_full_consent', 'disable_mods_on_update']:
		get_node("TabContainer/Gameplay/Scroll/Box/" + i).connect("pressed", self, "gameplay_rule", ['Gameplay/Scroll/Box', i])
		get_node("TabContainer/Gameplay/Scroll/Box/" + i).pressed = input_handler.globalsettings[i]
	for i in ['diff_permadeath', 'diff_bonus_taskmod', 'diff_bonus_loot', 'diff_stop_loan', 'diff_free_gather','easytrain']:
		get_node("TabContainer/Gameplay2/Scroll/Box/" + i).connect("pressed", self, "gamestate_rule",  [i])
		get_node("TabContainer/Gameplay2/Scroll/Box/" + i).pressed = ResourceScripts.game_globals.get(i)
		globals.connecttexttooltip(get_node("TabContainer/Gameplay2/Scroll/Box/" + i), tr("SETTING"+i.trim_prefix('diff_').to_upper() + '_DESCRIPT'), false, Tooltip)
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
	NGPlusButton = $TabContainer/Cheats/OpenCheatsMenu/UnlockNGP
	NGPlusButtonY = NGPlusButton.rect_position.y
	NGPlusButton.connect("pressed", self, "unlock_ngplus")
	globals.connecttexttooltip(NGPlusButton, tr("OPTCHEATUNLOCKNGPTOOLTIP"), false, Tooltip)


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
	update_ngplus_button()


#Lifts the achievement gate on the New Game+ panel. It is a one-way switch, so the button
#reports the state it left behind rather than offering to do the same thing twice.
func unlock_ngplus():
	input_handler.unlock_ngplus()
	update_ngplus_button()


func update_ngplus_button():
	#the cheat menu button above this one is only there while a game is running - with no game
	#the NG+ switch takes its slot instead of leaving a hole under the label
	var cheats_button = $TabContainer/Cheats/OpenCheatsMenu/CheatsMenu
	NGPlusButton.rect_position.y = NGPlusButtonY if cheats_button.visible else cheats_button.rect_position.y
	var unlocked = input_handler.ngplus_cheat_active()
	NGPlusButton.disabled = unlocked
	NGPlusButton.get_node("Label").text = tr("OPTCHEATNGPUNLOCKED") if unlocked else tr("OPTCHEATUNLOCKNGP")


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
	update_ngplus_button()
	male_rate_change(input_handler.globalsettings.malechance)
	futa_rate_change(input_handler.globalsettings.futachance)
	autosave_amount_change(input_handler.globalsettings.autosave_number)
	autosave_frequency_change(input_handler.globalsettings.autosave_frequency)
	$TabContainer/Visuals/DisableAnimations.pressed = input_handler.globalsettings.animatedbackground
	#a window the player dragged to another size keeps it: the selector starts from there
	if window_mode() == 'windowed' and !OS.window_maximized and !OS.window_minimized:
		input_handler.globalsettings.window_size = OS.window_size
	update_display_options()

	for i in $TabContainer/Audio/VBoxContainer.get_children():
		i.value = input_handler.globalsettings[i.name+'vol']
		i.get_node("CheckBox").pressed = input_handler.globalsettings[i.name+'mute']
		i.editable = !i.get_node("CheckBox").pressed


#the order the window mode selector steps through
const WINDOW_MODES = ['windowed', 'fullscreen', 'borderless']

func window_mode():
	if !input_handler.globalsettings.fullscreen:
		return 'windowed'
	return 'borderless' if input_handler.globalsettings.borderless_fullscreen else 'fullscreen'


func change_window_mode(step):
	var mode = WINDOW_MODES[posmod(WINDOW_MODES.find(window_mode()) + step, WINDOW_MODES.size())]
	input_handler.globalsettings.fullscreen = (mode != 'windowed')
	#windowed keeps the kind of fullscreen it came from, so the fullscreen hotkey returns to that one
	if mode != 'windowed':
		input_handler.globalsettings.borderless_fullscreen = (mode == 'borderless')
	input_handler.apply_window_mode(true)


#The resolution selector picks the window's size in a window, and in fullscreen what the game
#draws at before it is stretched over the screen - (0, 0) there being the screen's own.
func resolution_options():
	if window_mode() == 'windowed':
		return input_handler.get_window_resolutions()
	return input_handler.get_fullscreen_resolutions()


func current_resolution():
	if window_mode() == 'windowed':
		return input_handler.globalsettings.window_size
	return input_handler.render_resolution()


func change_resolution(step):
	var options = resolution_options()
	var picked = options[posmod(options.find(current_resolution()) + step, options.size())]
	if window_mode() == 'windowed':
		input_handler.globalsettings.window_size = picked
	else:
		input_handler.globalsettings.fullscreen_resolution = picked
	input_handler.apply_window_mode(true)


func update_display_options():
	$TabContainer/Visuals/window_mode/Label.text = tr("OPTWINDOWMODE" + window_mode().to_upper())
	var node = $TabContainer/Visuals/resolution
	var size = current_resolution()
	if size == Vector2():
		size = OS.get_screen_size(OS.current_screen)
	node.get_node("Label").text = "%d × %d" % [size.x, size.y]
	var arrows_shown = resolution_options().size() > 1
	node.get_node("LArr").visible = arrows_shown
	node.get_node("RArr").visible = arrows_shown

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
	for i in ['master','music','sound','ambient']:
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
