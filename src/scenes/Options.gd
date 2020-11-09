extends Panel

#warning-ignore-all:return_value_discarded
# var cheats = ['instant_travel','skip_combat','free_upgrades','instant_upgrades','invincible_player','show_enemy_hp','social_skill_unlimited_charges']
func _ready():
	for i in $TabContainer/Audio/VBoxContainer.get_children():
		i.connect("value_changed", self, 'soundsliderchange',[i.name])
		i.get_node("CheckBox").connect('pressed', self, 'mutepressed', [i.get_node("CheckBox")])
	$TabContainer/Graphics/fullscreen.connect("pressed",self,"togglefullscreen")
	$CloseButton.connect("pressed",self,'close')
	$TabContainer/Graphics/fullscreen.pressed = input_handler.globalsettings.fullscreen
	$TabContainer/Graphics/factors.pressed = input_handler.globalsettings.factors_as_words
	$TabContainer/Gameplay/VBoxContainer/malerate.connect("value_changed", self, 'male_rate_change')
	$TabContainer/Gameplay/VBoxContainer/male_and_futa_rate.connect("value_changed", self, "futa_rate_change")
	
	$TabContainer/Graphics/factors.connect("pressed", self, "toggle_factors")
	
	for i in ['furry','furry_multiple_nipples', 'futa_balls', 'turn_based_time_flow', 'show_full_consent']:
		get_node("TabContainer/Gameplay/" + i).connect("pressed", self, "gameplay_rule", [i])
		get_node("TabContainer/Gameplay/" + i).pressed = input_handler.globalsettings[i]

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
	if ResourceScripts.game_progress.cheat_code == text:
		$TabContainer/Cheats/EnterCodeMenu/Activate.disconnect("pressed", self, "go_for_code")
		$TabContainer/Cheats/EnterCodeMenu/Activate.connect("pressed", self, "activate_cheats")

	# $TabContainer/Cheats/EnterCodeMenu/Activate.disabled = !ResourceScripts.game_progress.cheat_code == text


func activate_cheats():
	ResourceScripts.game_progress.cheats_active = true
	$TabContainer/Cheats/EnterCodeMenu.hide()
	$TabContainer/Cheats/OpenCheatsMenu.show()


func go_for_code():
	OS.shell_open("https://www.patreon.com/posts/new-password-18830450")


func open():
	$TabContainer/Gameplay/enable_tutorials.pressed = ResourceScripts.game_progress.show_tutorial
	# $TabContainer/Cheats/EnterCodeMenu/Activate.disabled = true
	$TabContainer/Cheats/EnterCodeMenu.visible = !ResourceScripts.game_progress.cheats_active
	$TabContainer/Cheats/OpenCheatsMenu.visible = ResourceScripts.game_progress.cheats_active
	$TabContainer/Cheats/OpenCheatsMenu/CheatsMenu.visible = get_parent().name != "Menu_v2"

	var male = input_handler.globalsettings.malechance
	var futa = input_handler.globalsettings.futachance
	if !input_handler.globalsettings.futa:
		futa = 0
	$TabContainer/Gameplay/VBoxContainer/male_and_futa_rate.visible = input_handler.globalsettings.futa

	male_rate_change(male)
	futa_rate_change(male + futa)
	
	for i in $TabContainer/Audio/VBoxContainer.get_children():
		i.value = input_handler.globalsettings[i.name+'vol']
		i.get_node("CheckBox").pressed = input_handler.globalsettings[i.name+'mute']
		i.editable = !i.get_node("CheckBox").pressed

func togglefullscreen():
	input_handler.globalsettings.fullscreen = $TabContainer/Graphics/fullscreen.pressed
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

func update_rate_text() -> void:
	var male : int = input_handler.globalsettings.malechance
	var text : String = "<sex proportions go here>"

	if input_handler.globalsettings.futa:
		var futa : int = input_handler.globalsettings.futachance
		var female : int = 100 - (male + futa)
		text = "Male: %3d%%  -  Futa: %3d%%  -  Female: %3d%%" \
			% [male, futa, female]
	else:
		var female : int = 100 - male
		text = "Male: %3d%%  -  Female: %3d%%" \
			% [male, female]
	$TabContainer/Gameplay/VBoxContainer/SexRates.text = text

func male_rate_change(value):
	$TabContainer/Gameplay/VBoxContainer/malerate.value = value
	var delta : int = value - input_handler.globalsettings.malechance
	input_handler.globalsettings.malechance += delta
	if $TabContainer/Gameplay/VBoxContainer/male_and_futa_rate.value < value:
		$TabContainer/Gameplay/VBoxContainer/male_and_futa_rate.value = value
	else:
                # move the boundary shared with the futa range
		input_handler.globalsettings.futachance -= delta
	update_rate_text()

func futa_rate_change(value):
	$TabContainer/Gameplay/VBoxContainer/male_and_futa_rate.value = value
	if $TabContainer/Gameplay/VBoxContainer/malerate.value > value:
		$TabContainer/Gameplay/VBoxContainer/malerate.value = value
	var male = $TabContainer/Gameplay/VBoxContainer/malerate.value
	input_handler.globalsettings.futachance = value - male
	update_rate_text()

func gameplay_rule(rule):
	input_handler.globalsettings[rule] = get_node("TabContainer/Gameplay/" + rule).pressed
	if rule == "turn_based_time_flow":
		if gui_controller.clock != null:
			gui_controller.clock.set_time_buttons()

func toggle_factors():
	input_handler.globalsettings.factors_as_words = $TabContainer/Graphics/factors.pressed
