extends Node

var lastsave = null

func _ready():
	
	get_tree().set_auto_accept_quit(false)
	
	var buttonlist = ['continueb','newgame','loadwindow','options','quit']
	$version.text = "ver. " + globals.gameversion
	globals.CurrentScene = self
	input_handler.StopMusic()
	check_last_save()
	for i in range(0,5):
#warning-ignore:return_value_discarded
		$VBoxContainer.get_child(i).connect("pressed",self,buttonlist[i])
		#input_handler.ConnectSound($VBoxContainer.get_child(i), 'button_click', 'button_up')
	
#warning-ignore:return_value_discarded
	$DemoPanel/Button.connect("pressed", self, "CloseDemoWarn")
	
	if globals.globalsettings.warnseen == true:
		$DemoPanel.hide()
	
	OS.window_fullscreen = globals.globalsettings.fullscreen
	if OS.window_fullscreen == false:
		OS.window_size = globals.globalsettings.window_size
		OS.window_position = globals.globalsettings.window_pos
	
	for i in $Panel/VBoxContainer.get_children():
		i.connect("pressed", input_handler, 'open_shell', [i.name])

func check_last_save():
	lastsave = globals.get_last_save();
	if lastsave == null: 
		$VBoxContainer/continuebutton.visible = false
	else:
		$VBoxContainer/continuebutton.visible = true

func continueb():
	globals.LoadGame(lastsave.get_file().get_basename());

func newgame():
	#state = load("res://src/gamestate.gd").new()
	
	state.newgame = true
	state._ready()
	get_node("/root").remove_child(self)
	globals.ChangeScene('town')
	yield(globals, 'scene_changed')
	input_handler.ActivateTutorial()
	#globals.StartEventScene("Intro")
	self.queue_free()

func CloseDemoWarn():
	globals.globalsettings.warnseen = true
	$DemoPanel.hide()

func loadwindow():
	$saveloadpanel.LoadPanelOpen()

func options():
	$Options.open()

func quit():
	globals.globalsettings.window_size = OS.window_size
	globals.globalsettings.window_pos = OS.window_position
	get_tree().quit()