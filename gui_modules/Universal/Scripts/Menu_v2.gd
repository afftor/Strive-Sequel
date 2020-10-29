extends Control

#
#Writers: Barrus
#Artists:
#Coders:
#

var lastsave = null

func _ready():
	get_tree().set_auto_accept_quit(false)
	gui_controller.add_close_button($NewGamePanel)
	gui_controller.add_close_button($saveloadpanel)
	gui_controller.add_close_button($Options)
	var buttonlist = ['continueb','newgame','loadwindow','options', 'credits', 'mods']
	$version.text = "ver. " + globals.gameversion
	input_handler.CurrentScene = self
	#input_handler.StopMusic()
	check_last_save()
	for i in range(0,6):
		$VBoxContainer.get_child(i).connect("toggled",self,buttonlist[i], [$VBoxContainer.get_child(i)])
		#input_handler.ConnectSound($VBoxContainer.get_child(i), 'button_click', 'button_up')
	$VBoxContainer/quitbutton.connect("pressed", self, "quit")
	$char_sprite.texture = images.sprites[images.sprites.keys()[randi()%images.sprites.keys().size()]]
	$DemoPanel/Button.connect("pressed", self, "CloseDemoWarn")
	yield(get_tree().create_timer(0.1), "timeout")
	OS.window_fullscreen = input_handler.globalsettings.fullscreen
	if OS.window_fullscreen == false:
		OS.window_size = input_handler.globalsettings.window_size
		OS.window_position = input_handler.globalsettings.window_pos
	
	if OS.window_position.y < 0:
		OS.window_position.y = 50
	
	
	for i in $Panel/VBoxContainer.get_children():
		i.connect("pressed", input_handler, 'open_shell', [i.name])
	if input_handler.globalsettings.warnseen == true:
		$DemoPanel.hide()
		$WarnScreen.hide()
		input_handler.SetMusic("intro")
	# input_handler.AddPanelOpenCloseAnimation($NewGamePanel)
	input_handler.AddPanelOpenCloseAnimation($Changelogpanel)
	globals.connecttexttooltip($NewGamePanel/tip, tr('NEWGAMESETTINGINFO'))
	$ChangelogButton.connect("pressed", $Changelogpanel, 'show')
	$NewGamePanel/StartButton.connect("pressed", self, 'start_game')
	
	input_handler.ClearContainer($NewGamePanel/Settings)
	for i in settingarray:
		var newbutton = input_handler.DuplicateContainerTemplate($NewGamePanel/Settings)
		newbutton.get_node("Label").text = tr("SETTING"+i.to_upper() + '_NAME')
		newbutton.name = i
		newbutton.pressed = input_handler.globalsettings[i]
		globals.connecttexttooltip(newbutton, tr("SETTING"+i.to_upper() + '_DESCRIPT'))
		newbutton.connect('pressed', self, 'gameplay_setting', [newbutton])
	input_handler.ClearContainer($NewGamePanel/PresetContainer/VBoxContainer)
	for i in starting_presets.preset_data.values():
		if !i.has("code"):
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($NewGamePanel/PresetContainer/VBoxContainer)
		newbutton.text = i.name
		newbutton.name = i.code
		newbutton.connect('pressed', self, 'start_preset_set', [newbutton])

func check_last_save():
	lastsave = globals.get_last_save();
	if lastsave == null: 
		$VBoxContainer/continuebutton.visible = false
	else:
		$VBoxContainer/continuebutton.visible = true

func continueb(pressed, some_node):
	globals.LoadGame(lastsave.get_file().get_basename());


func newgame(pressed, pressed_button):
	gui_controller.win_btn_connections_handler(pressed, $NewGamePanel, pressed_button)
	self.current_pressed_btn = pressed_button
	$NewGamePanel.visible = pressed
	$NewGamePanel/PresetContainer/VBoxContainer.get_child(0).emit_signal('pressed')

func start_game():
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'start_game_confirm', 'Start this Game?'])

func start_game_confirm():
	ResourceScripts.game_world.make_world()
	$VBoxContainer/newgamebutton.disabled = true
	globals.start_new_game = true
	ResourceScripts.game_globals.newgame = true
	ResourceScripts.game_globals.original_version = globals.gameversion
	get_node("/root").remove_child(self)
	input_handler.ChangeScene('mansion')
	yield(globals, 'scene_changed')
	gui_controller.windows_opened.clear()
	self.queue_free()


func gameplay_setting(button):
	input_handler.globalsettings[button.name] = button.pressed

func CloseDemoWarn():
	input_handler.globalsettings.warnseen = true
	$DemoPanel.hide()


func loadwindow(pressed, pressed_button):
	gui_controller.win_btn_connections_handler(pressed, $saveloadpanel, pressed_button)
	self.current_pressed_btn = pressed_button
	$saveloadpanel.visible = pressed
	$saveloadpanel.LoadPanelOpen()

func options(pressed, pressed_button):
	gui_controller.win_btn_connections_handler(pressed, $Options, pressed_button)
	self.current_pressed_btn = pressed_button
	$Options.visible = pressed
	$Options.open()


func credits(pressed, pressed_button):
	gui_controller.win_btn_connections_handler(pressed, $Options, pressed_button)
	self.current_pressed_btn = pressed_button
	$Credits.visible = pressed



func quit():
#	input_handler.globalsettings.window_size = OS.window_size
#	input_handler.globalsettings.window_pos = OS.window_position
#	get_tree().quit()
	input_handler.quit()


func mods(pressed, pressed_button):
	gui_controller.win_btn_connections_handler(pressed, $mod_panel, pressed_button)
	self.current_pressed_btn = pressed_button
	$mod_panel.visible = pressed

var settingarray = ['futa','furry','turn_based_time_flow']


func start_preset_set(button):
	var data = starting_presets.preset_data[button.name]
	var text = data.descript
	for i in $NewGamePanel/PresetContainer/VBoxContainer.get_children():
		i.pressed = i == button
	if data.story == false:
		text += "\n[color=yellow]Disables main story quests and events.[/color]"
	text += "\n\n"
	text += 'Additional Characters: ' + str(data.free_slave_number) + "\n"
	if data.upgrades.size() > 0:
		text += "Upgrades: " + data.upgrades
	if data.items.size() > 0:
		text += "Items: " + data.items
	# if data.materials.size() > 0:
	# 	text += "Materials: "
	# 	for i in data.materials:
	# 		text += Items.materiallist[i].name + ": " + str(data.materials[i]) + ", "
	if data.materials.size() > 0:
		input_handler.ClearContainer($NewGamePanel/Materials)
		for i in data.materials:
			var item = Items.materiallist[i]
			var newbutton = input_handler.DuplicateContainerTemplate($NewGamePanel/Materials)
			newbutton.get_node("TextureRect").texture = Items.materiallist[i].icon
			newbutton.get_node("Label").text = str(data.materials[i])
			globals.connectmaterialtooltip(newbutton, item)
	# text = text.substr(0, text.length()-2)
	
	$NewGamePanel/RichTextLabel.bbcode_text = text
	$NewGamePanel/Gold/Label.text = str(data.gold)
	ResourceScripts.game_globals.starting_preset = data.code



# func add_close_button(scene):
# 	var pos_in_tree = scene.get_child_count()
# 	scene.rect_pivot_offset = Vector2(rect_size.x/2, rect_size.y/2)
# 	var closebutton = load(ResourceScripts.scenedict.close).instance()
# 	scene.add_child(closebutton)
# 	scene.move_child(closebutton, pos_in_tree)
# 	closebutton.connect("pressed", self, 'close_scene', [scene])
# 	var rect = scene.get_global_rect()
# 	var pos = Vector2(rect.end.x - closebutton.rect_size.x, rect.position.y)
# 	closebutton.rect_global_position = pos



# func update():
# 	var panels = [$DemoPanel, $mod_panel, $NewGamePanel, $Changelogpanel, $saveloadpanel, $Options]
# 	for i in panels:
# 		i.hide()


var current_pressed_btn setget set_btn_pressed


func set_btn_pressed(value):
	if current_pressed_btn == null:
		current_pressed_btn = value
		return
	if value != current_pressed_btn:
		current_pressed_btn.pressed = false
		current_pressed_btn = value
