extends Control


var lastsave = null

func _ready():
	get_tree().set_auto_accept_quit(false)
	gui_controller.add_close_button($NewGamePanel)
	gui_controller.add_close_button($saveloadpanel)
	gui_controller.add_close_button($Options)
	gui_controller.add_close_button($Credits)
	var buttonlist = ['continueb','newgame','loadwindow','options', 'credits', 'mods']
	$version.text = "ver. " + globals.gameversion
	input_handler.CurrentScene = self
	#input_handler.StopMusic()
	check_last_save()
	for i in range(0,6):
		$VBoxContainer.get_child(i).connect("toggled",self,buttonlist[i], [$VBoxContainer.get_child(i)])
		#input_handler.ConnectSound($VBoxContainer.get_child(i), 'button_click', 'button_up')
	$VBoxContainer/quitbutton.connect("pressed", self, "quit")
	$VBoxContainer/gallery.connect("pressed", self, "gallery")
	$NewGamePanel/BackButton.connect("pressed", self, "open_newgame")
	#$char_sprite.texture = images.sprites[images.sprites.keys()[randi() %images.sprites.keys().size()]]
	#$char_sprite.texture = images.sprites[input_handler.progress_data.characters[randi()%input_handler.progress_data.characters.size()]]
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
	
	cycle_backgrounds()

func cycle_backgrounds():
	var arr = [images.get_background("forest1_menu"),
		images.get_background("mountain1_menu"),
		images.get_background("mountain2_menu"),
		images.get_background("town1_menu"),
		images.get_background("town2_menu"),
	]
	randomize()
	arr.shuffle()
	var tw = Tween.new()
	add_child(tw)
	var last_bg
	var first_cycle = true
	var scrolling_speed = 8.0
	$background.texture = arr[0]
	while true:
		for bg in arr.size():
			if first_cycle:
				first_cycle = false
				continue
			if $background.rect_position.x > -50:
				tw.interpolate_property($background, "rect_position", $background.rect_position, Vector2(-200, 0), scrolling_speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			else:
				tw.interpolate_property($background, "rect_position", $background.rect_position, Vector2(0, 0), scrolling_speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tw.start()
			yield(tw, "tween_all_completed")
			ResourceScripts.core_animations.SmoothTextureChange($background, arr[bg], 0.5)
			last_bg = arr[bg]
		arr.shuffle()
		while arr[0] == last_bg: # this ensures that after shuffle we don't get the same background right away
			arr.shuffle()


func check_last_save():
	lastsave = globals.get_last_save();
	if lastsave == null:
		$VBoxContainer/continuebutton.visible = false
	else:
		$VBoxContainer/continuebutton.visible = true

func continueb(pressed, some_node):
	globals.LoadGame(lastsave.get_file().get_basename());


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


func gallery():
	$Gallery.close_state = false
	$Gallery.set_state("story")
	$Gallery.open_gallery()


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


var current_pressed_btn setget set_btn_pressed

func set_btn_pressed(value):
	if current_pressed_btn == null:
		current_pressed_btn = value
		return
	if value != current_pressed_btn:
		current_pressed_btn.pressed = false
		current_pressed_btn = value


#newgame
var settingarray = ['futa','furry','easytrain']#,'turn_based_time_flow']
var settingarray2 = ['skip_prologue','diff_gf_only_upg','diff_permadeath', 'diff_bonus_taskmod', 'diff_bonus_loot', 'diff_stop_loan', 'diff_small_loan', 'diff_solo', 'diff_free_upgrade'] 
var settingarray3 = ['diff_money','diff_materials'] #'diff_free_chars'

func newgame(pressed, pressed_button):
	gui_controller.win_btn_connections_handler(pressed, $NewGamePanel, pressed_button)
	self.current_pressed_btn = pressed_button
	$NewGamePanel.visible = pressed
	open_newgame()

func open_newgame():
	$NewGamePanel/PresetContainer.visible = true
	$NewGamePanel/RichTextLabel.visible = true
	$NewGamePanel/SettingsLabel.visible = false
	$NewGamePanel/ScrollContainer.visible = false
	$NewGamePanel/Settings3.visible = false
	$NewGamePanel/BackButton.visible = false
	
	input_handler.ClearContainerForced($NewGamePanel/PresetContainer/VBoxContainer)
	for id in starting_presets.preset_data:
		var newbutton = input_handler.DuplicateContainerTemplate($NewGamePanel/PresetContainer/VBoxContainer)
		newbutton.text = tr(starting_presets.preset_data[id].name)
		newbutton.connect('pressed', self, 'select_preset', [id])
		newbutton.name = id
	var newbutton = input_handler.DuplicateContainerTemplate($NewGamePanel/PresetContainer/VBoxContainer)
	newbutton.text = tr('PRESETDATADEBUGCUSTOMNAME')
	newbutton.connect('pressed', self, 'select_preset', ['custom'])
	newbutton.name = 'custom'
	
	select_preset('easy')
#	start_preset_update()
#	$NewGamePanel/PresetContainer/VBoxContainer.get_child(0).emit_signal('pressed')
#	ResourceScripts.game_globals.skip_prologue = $NewGamePanel/SkipP.pressed

func select_preset(val):
	if val == 'custom':
		$NewGamePanel/PresetContainer.visible = false
		$NewGamePanel/RichTextLabel.visible = false
		$NewGamePanel/SettingsLabel.visible = true
		$NewGamePanel/ScrollContainer.visible = true
		$NewGamePanel/Settings3.visible = true
		$NewGamePanel/BackButton.visible = true
		return
	
	for nd in $NewGamePanel/PresetContainer/VBoxContainer.get_children():
		nd.pressed = (nd.name == val)
	
	var data = starting_presets.preset_data[val]
	
	$NewGamePanel/RichTextLabel.bbcode_text = tr(data.descript)
	for arg in data.args:
		ResourceScripts.game_globals.set(arg, data.args[arg])
	
	start_preset_update()


func start_preset_update():
	input_handler.ClearContainer($NewGamePanel/Settings)
	for i in settingarray:
		var newbutton = input_handler.DuplicateContainerTemplate($NewGamePanel/Settings)
		newbutton.get_node("Label").text = tr("NEWGAMESETTING"+i.to_upper())
		newbutton.pressed = input_handler.globalsettings[i]
		globals.connecttexttooltip(newbutton, tr("SETTING"+i.to_upper() + '_DESCRIPT'))
#		globals.connecttexttooltip(newbutton.get_node("Label"), tr("SETTING"+i.to_upper() + '_DESCRIPT'))
		newbutton.connect('pressed', self, 'session_setting', [i])
	input_handler.ClearContainer($NewGamePanel/ScrollContainer/Settings2)
	for i in settingarray2:
		var newbutton = input_handler.DuplicateContainerTemplate($NewGamePanel/ScrollContainer/Settings2)
		newbutton.get_node("Label").text = tr("NEWGAMESETTING"+i.trim_prefix('diff_').to_upper())
		newbutton.pressed = ResourceScripts.game_globals.get(i)
		globals.connecttexttooltip(newbutton, tr("SETTING"+i.trim_prefix('diff_').to_upper() + '_DESCRIPT'))
#		globals.connecttexttooltip(newbutton.get_node("Label"), tr("SETTING"+i.trim_prefix('diff_').to_upper() + '_DESCRIPT'))
		newbutton.connect('pressed', self, 'gameplay_setting', [i])
	input_handler.ClearContainer($NewGamePanel/Settings3, ['label', 'button'])
	for i in settingarray3:
		var newbutton = input_handler.DuplicateContainerTemplate($NewGamePanel/Settings3, 'label')
		newbutton.text = tr("NEWGAMESETTING" + i.trim_prefix('diff_').to_upper())
		globals.connecttexttooltip(newbutton, tr("SETTING"+i.trim_prefix('diff_').to_upper() + '_DESCRIPT'))
		
		newbutton = input_handler.DuplicateContainerTemplate($NewGamePanel/Settings3, 'button')
		newbutton.get_node('Label').text = tr(('diff_' + ResourceScripts.game_globals.get(i)).to_upper())
		newbutton.get_node('LArr').connect('pressed', self, 'change_preset_value', [i, -1] )
		newbutton.get_node('RArr').connect('pressed', self, 'change_preset_value', [i, 1] )
	
	var data_materials = starting_presets.preset_data[ResourceScripts.game_globals.diff_materials].materials
	if ResourceScripts.game_globals.skip_prologue:
		data_materials = starting_presets.advanced_preset.materials
	if data_materials.size() > 0:
		input_handler.ClearContainer($NewGamePanel/Materials)
		for i in data_materials:
			var item = Items.materiallist[i]
			var newbutton = input_handler.DuplicateContainerTemplate($NewGamePanel/Materials)
			newbutton.get_node("TextureRect").texture = Items.materiallist[i].icon
			newbutton.get_node("Label").text = str(data_materials[i])
			globals.connectmaterialtooltip(newbutton, item)
	# text = text.substr(0, text.length()-2)
	var data_gold = starting_presets.preset_data[ResourceScripts.game_globals.diff_money].gold
	if ResourceScripts.game_globals.skip_prologue:
		data_gold = starting_presets.advanced_preset.gold
	$NewGamePanel/Gold/Label.text = str(data_gold)



func start_game():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'start_game_confirm', tr('STARTTHISGAME')])


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


func session_setting(arg):
	input_handler.globalsettings[arg] = !input_handler.globalsettings[arg]
	start_preset_update()
	#print(button.name, input_handler.globalsettings[button.name])


func gameplay_setting(arg):
	ResourceScripts.game_globals.set(arg,  !ResourceScripts.game_globals.get(arg))
	start_preset_update()


func change_preset_value(arg, val):
	var tmp = starting_presets.preset_data.keys().find(ResourceScripts.game_globals.get(arg))
	
	tmp += val
	if tmp < 0:
		tmp = starting_presets.preset_data.size() - 1
	if tmp >= starting_presets.preset_data.size():
		tmp = 0
	
	ResourceScripts.game_globals.set(arg, starting_presets.preset_data.keys()[tmp])
	
	start_preset_update()
