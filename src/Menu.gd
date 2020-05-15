extends Node

#
#Writers: Barrus
#Artists:
#Coders:
#

var lastsave = null

func _ready():
	
	get_tree().set_auto_accept_quit(false)
	
	var buttonlist = ['continueb','newgame','loadwindow','options','mods' ,'quit']
	$version.text = "ver. " + globals.gameversion
	input_handler.CurrentScene = self
	#input_handler.StopMusic()
	check_last_save()
	for i in range(0,6):
		$VBoxContainer.get_child(i).connect("pressed",self,buttonlist[i])
		#input_handler.ConnectSound($VBoxContainer.get_child(i), 'button_click', 'button_up')
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
	input_handler.AddPanelOpenCloseAnimation($NewGamePanel)
	input_handler.AddPanelOpenCloseAnimation($Changelogpanel)
	globals.connecttexttooltip($NewGamePanel/tip, tr('NEWGAMESETTINGINFO'))
	$ChangelogButton.connect("pressed", $Changelogpanel, 'show')
	$NewGamePanel/StartButton.connect("pressed", self, 'start_game')
	
	input_handler.ClearContainer($NewGamePanel/Settings)
	for i in settingarray:
		var newbutton = input_handler.DuplicateContainerTemplate($NewGamePanel/Settings)
		newbutton.text = tr("SETTING"+i.to_upper() + '_NAME')
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

func continueb():
	globals.LoadGame(lastsave.get_file().get_basename());


func newgame():
	$NewGamePanel.show()
	$NewGamePanel/PresetContainer/VBoxContainer.get_child(0).emit_signal('pressed')

func start_game():
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'start_game_confirm', 'Start this Game?'])

func start_game_confirm():
	ResourceScripts.game_world.make_world()
	$VBoxContainer/newgamebutton.disabled = true
	globals.start_new_game = true
	ResourceScripts.game_globals.newgame = true
	get_node("/root").remove_child(self)
	input_handler.ChangeScene('mansion')
	yield(globals, 'scene_changed')
	self.queue_free()


func gameplay_setting(button):
	input_handler.globalsettings[button.name] = button.pressed

func CloseDemoWarn():
	input_handler.globalsettings.warnseen = true
	$DemoPanel.hide()


func loadwindow():
	$saveloadpanel.LoadPanelOpen()

func options():
	$Options.open()

func quit():
	input_handler.globalsettings.window_size = OS.window_size
	input_handler.globalsettings.window_pos = OS.window_position
	get_tree().quit()


func mods():
	$mod_panel.visible = true

var settingarray = ['futa','furry','turn_based_time_flow']


func start_preset_set(button):
	var data = starting_presets.preset_data[button.name]
	var text = data.descript
	for i in $NewGamePanel/PresetContainer/VBoxContainer.get_children():
		i.pressed = i == button
	if data.story == false:
		text += "\n[color=yellow]Disables main story quests and events.[/color]"
	text += "\n\n"
	text += 'Starting Gold: ' + str(data.gold) + "\n"
	text += 'Additional Characters: ' + str(data.free_slave_number) + "\n"
	if data.upgrades.size() > 0:
		text += "Upgrades: " + data.upgrades
	if data.items.size() > 0:
		text += "Items: " + data.items
	if data.materials.size() > 0:
		text += "Materials: "
		for i in data.materials:
			text += Items.materiallist[i].name + ": " + str(data.materials[i]) + ", "
	text = text.substr(0, text.length()-2)
	
	$NewGamePanel/RichTextLabel.bbcode_text = text
	
	ResourceScripts.game_globals.starting_preset = data.code

