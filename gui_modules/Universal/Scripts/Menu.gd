extends Control


var lastsave = null

onready var newgame_cont = $NewGameCont
onready var newgame_node = $NewGameCont/NewGamePanel
onready var newgame_bonuses_node = $NewGameCont/bonuses
onready var newgame_bonuses_cont = $NewGameCont/bonuses/ScrollContainer/VBoxContainer
var cur_bonus_points = 0
var max_bonus_points = 0
var newgame_bonuses = []

func _ready():
	get_tree().set_auto_accept_quit(false)
	newgame_node.get_node("CloseButton").connect("pressed", gui_controller, 'close_scene', [newgame_cont])
	gui_controller.add_close_button($saveloadpanel)
	gui_controller.add_close_button($Options)
	gui_controller.add_close_button($Credits)
	gui_controller.add_close_button($NewOrTutorial)
	var buttonlist = ['continueb','newgame', 'loadwindow','options', 'credits', 'mods']
	$version.text = "ver. " + globals.gameversion
	input_handler.CurrentScene = self
	#input_handler.StopMusic()
	check_last_save()
	for i in range(0,6):
		$VBoxContainer.get_child(i).connect("toggled",self,buttonlist[i], [$VBoxContainer.get_child(i)])
		#input_handler.ConnectSound($VBoxContainer.get_child(i), 'button_click', 'button_up')
	$VBoxContainer/quitbutton.connect("pressed", self, "quit")
	$VBoxContainer/gallery.connect("pressed", self, "gallery")
	newgame_node.get_node("BackButton").connect("pressed", self, "open_newgame")
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
	_load_changelog()
	for i in $Panel/VBoxContainer.get_children():
		i.connect("pressed", input_handler, 'open_shell', [i.name])
	if input_handler.globalsettings.warnseen == true:
		$DemoPanel.hide()
		$WarnScreen.hide()
		input_handler.SetMusic("opening")
	# input_handler.AddPanelOpenCloseAnimation(newgame_cont)
	input_handler.AddPanelOpenCloseAnimation($Changelogpanel)
	globals.connecttexttooltip(newgame_node.get_node("tip"), tr('NEWGAMESETTINGINFO'))
	$ChangelogButton.connect("pressed", $Changelogpanel, 'show')
	newgame_node.get_node("StartButton").connect("pressed", self, 'start_game')
	$NewOrTutorial/ButtonL.connect("pressed", self, 'close_new_or_tutorial', [1])
	$NewOrTutorial/ButtonR.connect("pressed", self, 'close_new_or_tutorial', [2])
	newgame_node.get_node("NGPButton").connect("pressed", self, 'switch_ng_bonuses')
	
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
var settingarray = ['futa','furry']#,'turn_based_time_flow']
var settingarray2 = ['skip_prologue','diff_gf_only_upg','diff_permadeath', 'diff_bonus_taskmod', 'diff_bonus_loot', 'diff_stop_loan', 'diff_small_loan', 'diff_solo', 'diff_free_upgrade', 'diff_free_gather','easytrain'] 
var settingarray3 = ['diff_money','diff_materials'] #'diff_free_chars'

func newgame(pressed, pressed_button):
	gui_controller.win_btn_connections_handler(pressed, $NewOrTutorial, pressed_button)
	self.current_pressed_btn = pressed_button
	$NewOrTutorial.visible = pressed

func close_new_or_tutorial(result):
	$NewOrTutorial/CloseButton.emit_signal("pressed")
	if result == 1:#ButtonL
		try_open_newgame()
	elif result == 2:#ButtonR
		tutorial()

func try_open_newgame():
	if input_handler.globalsettings.tutorial_prompt_seen:
		open_newgame()
		return
	input_handler.globalsettings.tutorial_prompt_seen = true
	input_handler.get_spec_node(input_handler.NODE_YESORNOPANEL, [self, 'tutorial_confirm', 'open_newgame', tr('PROMPTTUTORIAL')])

func open_newgame():
	gui_controller.windows_opened.append(newgame_cont)
	newgame_cont.show()
	
	newgame_node.get_node("PresetContainer").visible = true
	newgame_node.get_node("RichTextLabel").visible = true
	newgame_node.get_node("SettingsLabel").visible = false
	newgame_node.get_node("ScrollContainer").visible = false
	newgame_node.get_node("Settings3").visible = false
	newgame_node.get_node("BackButton").visible = false
	
	input_handler.ClearContainerForced(newgame_node.get_node("PresetContainer/VBoxContainer"))
	for id in starting_presets.preset_data:
		var newbutton = input_handler.DuplicateContainerTemplate(newgame_node.get_node("PresetContainer/VBoxContainer"))
		newbutton.text = tr(starting_presets.preset_data[id].name)
		newbutton.connect('pressed', self, 'select_preset', [id])
		newbutton.name = id
	var newbutton = input_handler.DuplicateContainerTemplate(newgame_node.get_node("PresetContainer/VBoxContainer"))
	newbutton.text = tr('PRESETDATADEBUGCUSTOMNAME')
	newbutton.connect('pressed', self, 'select_preset', ['custom'])
	newbutton.name = 'custom'
	
	select_preset('easy')
#	start_preset_update()
#	newgame_node.get_node("PresetContainer/VBoxContainer").get_child(0).emit_signal('pressed')
#	ResourceScripts.game_globals.skip_prologue = newgame_node.get_node("SkipP").pressed
	
	#new game +
	var bonuses = input_handler.achievements.get_unlocked_bonuses()
	max_bonus_points = input_handler.achievements.get_all_points()
	newgame_bonuses.clear()
	var NGPButton = newgame_node.get_node("NGPButton")
	NGPButton.visible = (!bonuses.empty()
		and max_bonus_points > 0
		and input_handler.achievements.has_achimnt("act1"))
	if NGPButton.visible:
		cur_bonus_points = 0
		update_bonus_points_text()
		input_handler.ClearContainer(newgame_bonuses_cont, ["bonus", "locked"])
		for bonus_name in bonuses:
			var data = bonuses[bonus_name]
			var new_btn = input_handler.DuplicateContainerTemplate(newgame_bonuses_cont, "bonus")
			new_btn.get_node("name").text = tr(data.name)
			new_btn.get_node("desc").text = tr(data.description)
			new_btn.get_node("cost").text = String(data.cost)
			new_btn.get_node("icon").texture = data.icon
			new_btn.set_meta("cost", data.cost)
			new_btn.set_meta("id", bonus_name)
			new_btn.get_node("btn").connect("toggled", self, "bonus_toggled", [bonus_name])
		var locked = input_handler.achievements.get_locked_bonuses()
		for bonus_name in locked:
			var new_btn = input_handler.DuplicateContainerTemplate(newgame_bonuses_cont, "locked")
			new_btn.set_locked(locked[bonus_name])
		update_bonus_btns()
	else:
		newgame_bonuses_node.hide()
	NGPButton.pressed = newgame_bonuses_node.visible

func switch_ng_bonuses():
	newgame_bonuses_node.visible = !newgame_bonuses_node.visible

func bonus_toggled(pressed, bonus):
	if pressed:
		if newgame_bonuses.has(bonus):
			push_error("bonus_toggled: newgame_bonuses already has %s" % bonus)
		else:
			newgame_bonuses.append(bonus)
	else:
		newgame_bonuses.erase(bonus)
	#recalc points
	cur_bonus_points = 0
	for node in newgame_bonuses_cont.get_children():
		if node.visible and node.has_meta("id") and node.get_node("btn").pressed:
			cur_bonus_points += node.get_meta("cost")
	update_bonus_points_text()
	update_bonus_btns()

func update_bonus_btns():
	var points_left = max_bonus_points - cur_bonus_points
	for node in newgame_bonuses_cont.get_children():
		if node.visible and node.has_meta("id") and !node.get_node("btn").pressed:
			node.set_disable(node.get_meta("cost") > points_left)
			if !node.is_disabled():
				var data = input_handler.achievements.get_bonus(node.get_meta("id"))
				if data.has("restricted_by"):
					for restricter in data.restricted_by:
						if restricter in newgame_bonuses:
							node.set_disable(true)
							break
			

func update_bonus_points_text():
	newgame_bonuses_node.get_node("points_cont/points").text = "%s/%s" % [
		cur_bonus_points, max_bonus_points]

func select_preset(val):
	if val == 'custom':
		newgame_node.get_node("PresetContainer").visible = false
		newgame_node.get_node("RichTextLabel").visible = false
		newgame_node.get_node("SettingsLabel").visible = true
		newgame_node.get_node("ScrollContainer").visible = true
		newgame_node.get_node("Settings3").visible = true
		newgame_node.get_node("BackButton").visible = true
		return
	
	for nd in newgame_node.get_node("PresetContainer/VBoxContainer").get_children():
		nd.pressed = (nd.name == val)
	
	var data = starting_presets.preset_data[val]
	
	newgame_node.get_node("RichTextLabel").bbcode_text = tr(data.descript)
	for arg in data.args:
		ResourceScripts.game_globals.set(arg, data.args[arg])
	
	start_preset_update()


func start_preset_update():
	input_handler.ClearContainer(newgame_node.get_node("Settings"))
	for i in settingarray:
		var newbutton = input_handler.DuplicateContainerTemplate(newgame_node.get_node("Settings"))
		newbutton.get_node("Label").text = tr("NEWGAMESETTING"+i.to_upper())
		newbutton.pressed = input_handler.globalsettings[i]
		globals.connecttexttooltip(newbutton, tr("SETTING"+i.to_upper() + '_DESCRIPT'))
#		globals.connecttexttooltip(newbutton.get_node("Label"), tr("SETTING"+i.to_upper() + '_DESCRIPT'))
		newbutton.connect('pressed', self, 'session_setting', [i])
	input_handler.ClearContainer(newgame_node.get_node("ScrollContainer/Settings2"))
	for i in settingarray2:
		var newbutton = input_handler.DuplicateContainerTemplate(newgame_node.get_node("ScrollContainer/Settings2"))
		newbutton.get_node("Label").text = tr("NEWGAMESETTING"+i.trim_prefix('diff_').to_upper())
		newbutton.pressed = ResourceScripts.game_globals.get(i)
		globals.connecttexttooltip(newbutton, tr("SETTING"+i.trim_prefix('diff_').to_upper() + '_DESCRIPT'))
#		globals.connecttexttooltip(newbutton.get_node("Label"), tr("SETTING"+i.trim_prefix('diff_').to_upper() + '_DESCRIPT'))
		newbutton.connect('pressed', self, 'gameplay_setting', [i])
	input_handler.ClearContainer(newgame_node.get_node("Settings3"), ['label', 'button'])
	for i in settingarray3:
		var newbutton = input_handler.DuplicateContainerTemplate(newgame_node.get_node("Settings3"), 'label')
		newbutton.text = tr("NEWGAMESETTING" + i.trim_prefix('diff_').to_upper())
		globals.connecttexttooltip(newbutton, tr("SETTING"+i.trim_prefix('diff_').to_upper() + '_DESCRIPT'))
		
		newbutton = input_handler.DuplicateContainerTemplate(newgame_node.get_node("Settings3"), 'button')
		newbutton.get_node('Label').text = tr(('diff_' + ResourceScripts.game_globals.get(i)).to_upper())
		newbutton.get_node('LArr').connect('pressed', self, 'change_preset_value', [i, -1] )
		newbutton.get_node('RArr').connect('pressed', self, 'change_preset_value', [i, 1] )
	
	var data_materials = starting_presets.preset_data[ResourceScripts.game_globals.diff_materials].materials
	if ResourceScripts.game_globals.skip_prologue:
		data_materials = starting_presets.advanced_preset.materials
	if data_materials.size() > 0:
		input_handler.ClearContainer(newgame_node.get_node("Materials"))
		for i in data_materials:
			var item = Items.materiallist[i]
			var newbutton = input_handler.DuplicateContainerTemplate(newgame_node.get_node("Materials"))
			newbutton.get_node("TextureRect").texture = Items.materiallist[i].icon
			newbutton.get_node("Label").text = str(data_materials[i])
			globals.connectmaterialtooltip(newbutton, item)
	# text = text.substr(0, text.length()-2)
	var data_gold = starting_presets.preset_data[ResourceScripts.game_globals.diff_money].gold
	if ResourceScripts.game_globals.skip_prologue:
		data_gold = starting_presets.advanced_preset.gold
	newgame_node.get_node("Gold/Label").text = str(data_gold)



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
	if !newgame_bonuses.empty():
		yield(globals, 'scene_change_start')
		input_handler.CurrentScene.newgame_bonuses = newgame_bonuses
	yield(globals, 'scene_changed')
	gui_controller.windows_opened.clear()
	self.queue_free()

func tutorial():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'tutorial_confirm', tr('STARTTUTORIAL')])
#	input_handler.get_spec_node(input_handler.NODE_HARD_TUTORIAL_LIST).show()

func tutorial_confirm():
	input_handler.activate_hard_tutorial()
	input_handler.hard_tutorial.prepare_tutorial('training')

func session_setting(arg):
	input_handler.globalsettings[arg] = !input_handler.globalsettings[arg]
	start_preset_update()


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

const CHANGELOG_PATH = "res://changelog"

func _load_changelog():
	var changelog_file = File.new()
	if not changelog_file.file_exists(CHANGELOG_PATH):
		$Changelogpanel/changelogtext.bbcode_text = ""
		return
	var open_result = changelog_file.open(CHANGELOG_PATH, File.READ)
	if open_result != OK:
		return
	$Changelogpanel/changelogtext.bbcode_text = changelog_file.get_as_text()
	changelog_file.close()

