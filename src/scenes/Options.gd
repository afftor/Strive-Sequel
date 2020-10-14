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
	$TabContainer/Gameplay/VBoxContainer/futarate.connect("value_changed", self, "futa_rate_change")
	
	$TabContainer/Graphics/factors.connect("pressed", self, "toggle_factors")
	
	for i in ['furry','furry_multiple_nipples', 'futa_balls', 'turn_based_time_flow', 'show_full_consent']:
		get_node("TabContainer/Gameplay/" + i).connect("pressed", self, "gameplay_rule", [i])
		get_node("TabContainer/Gameplay/" + i).pressed = input_handler.globalsettings[i]
	

	$TabContainer/debug/EnterCodeMenu/GetCode.connect("pressed", self, "get_code")
	$TabContainer/debug/EnterCodeMenu/LineEdit.connect("text_changed", self, "text_changed")
	$TabContainer/debug/EnterCodeMenu/Activate.connect("pressed", self, "activate_cheats")
	$TabContainer/debug/OpenCheatsMenu/CheatsMenu.connect("pressed", self, "open_cheats_menu")

# TODO Implement get code method
func get_code():
	pass

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
	$TabContainer/debug/EnterCodeMenu/Activate.disabled = !variables.cheat_codes.has(text)


func activate_cheats():
	variables.cheats_active = true
	$TabContainer/debug/EnterCodeMenu.hide()
	$TabContainer/debug/OpenCheatsMenu.show()


func open():
	show()
	$TabContainer/debug/EnterCodeMenu/Activate.disabled = true
	$TabContainer/debug/EnterCodeMenu.visible = !variables.cheats_active
	$TabContainer/debug/OpenCheatsMenu.visible = variables.cheats_active
	male_rate_change(input_handler.globalsettings.malechance)
	futa_rate_change(input_handler.globalsettings.futachance)
	
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

func male_rate_change(value):
	$TabContainer/Gameplay/VBoxContainer/malerate.value = value
	input_handler.globalsettings.malechance = value
	var text = 'Male generation chance: ' + str(value) + "%"
	$TabContainer/Gameplay/VBoxContainer/malerate/Label.text = text

func futa_rate_change(value):
	$TabContainer/Gameplay/VBoxContainer/futarate.value = value
	input_handler.globalsettings.futachance = value
	var text = 'Futa generation chance: ' + str(value) + "%"
	$TabContainer/Gameplay/VBoxContainer/futarate/Label.text = text

func gameplay_rule(rule):
	input_handler.globalsettings[rule] = get_node("TabContainer/Gameplay/" + rule).pressed

func toggle_factors():
	input_handler.globalsettings.factors_as_words = $TabContainer/Graphics/factors.pressed
