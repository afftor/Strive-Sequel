extends "res://files/Close Panel Button/ClosingPanel.gd"

var tabnames = {Audio = "AUDIO", Graphics = "GRAPHICS", Text = "TEXT"}

func _ready():
	for i in $TabContainer/Audio/VBoxContainer.get_children():
		i.connect("value_changed", self, 'soundsliderchange',[i.name])
		i.get_node("CheckBox").connect('pressed', self, 'mutepressed', [i.get_node("CheckBox")])
#warning-ignore:return_value_discarded
	$TabContainer/Text/textspeed.connect("value_changed", self, 'textspeed') 
#warning-ignore:return_value_discarded
	$TabContainer/Text/skipread.connect("pressed", self, 'pressedskipread') 
#warning-ignore:return_value_discarded
	$TabContainer/Graphics/fullscreen.connect("pressed",self,"togglefullscreen")
#warning-ignore:return_value_discarded
	$CloseButton.connect("pressed",self,'close')
	$TabContainer/Graphics/fullscreen.pressed = globals.globalsettings.fullscreen

func open():
	show()
	$TabContainer/Text/skipread.pressed = globals.globalsettings.skipread
	$TabContainer/Text/textspeed.value = globals.globalsettings.textspeed
	for i in $TabContainer/Audio/VBoxContainer.get_children():
		i.value = globals.globalsettings[i.name+'vol']
		i.get_node("CheckBox").pressed = globals.globalsettings[i.name+'mute']
		i.editable = !i.get_node("CheckBox").pressed

func togglefullscreen():
	globals.globalsettings.fullscreen = $TabContainer/Graphics/fullscreen.pressed
	OS.window_fullscreen = globals.globalsettings.fullscreen
	if globals.globalsettings.fullscreen == false:
		OS.window_position = Vector2(0,0)

func soundsliderchange(value,name):
	if value <= -39:
		value = -80
	globals.globalsettings[name+'vol'] = value
	if name == 'sound':
		input_handler.PlaySound("menu_open")
	updatesounds()

func mutepressed(node):
	var name = node.get_parent().name
	globals.globalsettings[name + 'mute'] = node.pressed
	node.get_parent().editable = !node.pressed
	updatesounds()

func updatesounds():
	var counter = 0
	for i in ['master','music','sound']:
		AudioServer.set_bus_mute(counter, globals.globalsettings[i+'mute'])
		AudioServer.set_bus_volume_db(counter, globals.globalsettings[i+'vol'])
		counter += 1

func textspeed(value):
	globals.globalsettings.textspeed = value

func pressedskipread():
	globals.globalsettings.skipread = $TabContainer/Text/skipread.pressed

func close():
	hide()
