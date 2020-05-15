#extends Control
##not used
#onready var TextField = $Panel/DisplayText
#onready var ImageSprite = $CharImage
#onready var ChoiceContainer = $ChoicePanel/VBoxContainer
#
#var text_log = ''
#
#var CurrentScene
#var CurrentLine = 0
#
#var ShownCharacters = 0.0
#
#var enableskip = false
#
#var EndOfDialogue = false
#var Delay = 0
#var ReceiveInput = false
#
#var debug
## var SceneData = load("res://src/DialoguesData.gd").new()
#
#var ColorsByNames = {
#	narrator = "FFFFFF",
#	ARRON = "C0C0C0",
#	ROSE = "FF8C00",
#	EMBER = "b22156",
#	ERIKA = "228B22",
#
#}
#
#var choicedict = {
#	choiceexample = [{text = 'Choice 1', function = 'Close', reqs = null}]
#}
#
#
#func _process(delta):
#	if TextField.get_total_character_count() > TextField.visible_characters:
#		if input_handler.globalsettings.textspeed >= 200:
#			ShownCharacters = TextField.get_total_character_count()
#		else:
#			ShownCharacters += delta*input_handler.globalsettings.textspeed
#		TextField.visible_characters = ShownCharacters
#	if Delay > 0:
#		Delay -= delta
#		if Delay < 0:
#			Delay = 0
#	if ((ReceiveInput == false && Delay == 0) || (ReceiveInput == true && enableskip == true)):
#		AdvanceScene()
#
#func _input(event):
#
#	if event.is_action("ctrl"):
#		if event.is_pressed():
#			enableskip = true
#		else:
#			enableskip = false
#	if event.is_echo() == true || event.is_pressed() == false || !ReceiveInput || $MenuPanel.visible :
#		return
#
#	if $LogPanel.visible == true:
#		if event.is_action("MouseDown") && ($LogPanel/RichTextLabel.get_v_scroll().value + $LogPanel/RichTextLabel.get_v_scroll().page == $LogPanel/RichTextLabel.get_v_scroll().max_value || !$LogPanel/RichTextLabel.get_v_scroll().visible):
#			$LogPanel.hide()
#		return
#
#
#	if (event.is_action("LMB") || event.is_action("MouseDown")) && event.is_pressed() && $Panel.visible:
#		if $ChoicePanel.visible: return
#		if $Panel/Log.get_global_rect().has_point(get_global_mouse_position()) || $Panel/Options.get_global_rect().has_point(get_global_mouse_position()):
#			return
#		if TextField.get_visible_characters() < TextField.get_total_character_count():
#			TextField.set_visible_characters(TextField.get_total_character_count())
#		else:
#			if EndOfDialogue != true && CurrentScene != null:
#				ReceiveInput = false
#				AdvanceScene()
#	if event.is_action("RMB") && event.is_pressed():
#		$Panel.visible = !$Panel.visible
#	if event.is_action("MouseUp"):
#		OpenLog()
#
#
#func _ready():
#	set_process(false)
#	input_handler.AddPanelOpenCloseAnimation($LogPanel)
##warning-ignore:return_value_discarded
#	$Panel/Log.connect("pressed",self,'OpenLog')
##warning-ignore:return_value_discarded
#	$Panel/Options.connect('pressed', self, 'OpenOptions')
#	#CurrentScene = SceneData.introdesert
#	add_to_group('pauseprocess')
#
#
#func OpenLog():
#	$LogPanel/RichTextLabel.bbcode_text = text_log
#	$LogPanel.show()
#	yield(get_tree().create_timer(0.2), 'timeout')
#	$LogPanel/RichTextLabel.scroll_to_line($LogPanel/RichTextLabel.get_line_count()-1)
#
#func OpenOptions():
#	$MenuPanel.show()
#
#func Start(dict, f = false, line = 0):
#	if dict == null or (variables.NoScenes and !f):  
#		call_deferred('StopEvent')
#		return
#	debug = f
#	input_handler.LockOpenWindow()
#	$Background.texture = null
#	$Background.visible = true
#	$CharImage.texture = null
#	#$CharImage.visible = false
#	$Panel/CharPortrait.texture = null
#	$Panel/DisplayText.bbcode_text = ''
#	$Panel/DisplayName/Label.text = ''
#	$Panel/DisplayName.visible = true
#	$Panel/CharPortrait.visible = false
#	$Panel.visible = false
#	$CharImage.modulate = Color(1, 1, 1, 0)
#	#$bl.modulate = Color(1, 1, 1, 1)
#	$BlackScreen.modulate.a = 0
#	CurrentScene = dict
#	if line > 0:
#		RestoreEnv()
#	CurrentLine = line
#	set_process(true)
#	set_process_input(true)
#	enableskip = false
#	AdvanceScene()
#
#func RestoreEnv():
#	var tlist = state.keyframes.duplicate()
#	tlist.invert()
#	for tmp in tlist:
#		if CurrentScene[tmp].effect == 'gui':
#			GuiDo(CurrentScene[tmp].value)
#			break
#	for tmp in tlist:
#		if CurrentScene[tmp].effect == 'background':
#			#input_handler.SmoothTextureChange($Background, images.backgrounds[CurrentScene[tmp].value])
#			$Background.texture = images.backgrounds[CurrentScene[tmp].value]
#			break
#	for tmp in tlist:
#		if CurrentScene[tmp].effect == 'music':
#			input_handler.SetMusic(CurrentScene[tmp].value)
#			break
#	for tmp in tlist:
#		if CurrentScene[tmp].effect == 'sprite':
#			if CurrentScene[tmp].value == 'set':
#				SpriteDo($CharImage, 'set', CurrentScene[tmp].args)
#				break
#	for tmp in tlist:
#		if CurrentScene[tmp].effect == 'sprite':
#			if CurrentScene[tmp].value == 'hide':
#				$CharImage.modulate = Color(1, 1, 1, 0)
#				break
#			if CurrentScene[tmp].value == 'fade':
#				$CharImage.modulate = Color(1, 1, 1, 0)
#				break
#			if CurrentScene[tmp].value == 'unfade':
#				$CharImage.modulate = Color(1, 1, 1, 1)
#				break
#	for tmp in tlist:
#		if CurrentScene[tmp].effect == 'sfx':
#			if CurrentScene[tmp].value == 'blackscreenturnon' or CurrentScene[tmp].value == 'blackscreenunfade':
#				blackscreenturnon()
#				break
#			if CurrentScene[tmp].value == 'blackscreenfade':
#				blackscreenturnoff()
#				break
#
#
#func skip (n):
#	CurrentLine += int(n)
#
#func AdvanceScene():
#	if CurrentScene.size() > CurrentLine:
#		#print ("next line: %d \n" % OS.get_ticks_msec ())
#		var NewEffect = CurrentScene[CurrentLine]
#		match NewEffect.effect:
#			'gui': #надо пофиксить некорректное скрытие-раскрытие 
#				GuiDo(NewEffect.value)
#				state.keyframes.push_back(CurrentLine)
#				ReceiveInput = false
#			'background':
#				if NewEffect.has('time'):
#					ResourceScripts.core_animations.SmoothTextureChange($Background, images.backgrounds[NewEffect.value], NewEffect.time)
#				else:
#					$Background.texture = images.backgrounds[NewEffect.value]
#				$Background.update()
#				state.keyframes.push_back(CurrentLine)
#				ReceiveInput = false
#			'music':
#				input_handler.SetMusic(NewEffect.value)
#				ReceiveInput = false
#			'music_stop':
#				input_handler.StopMusic(NewEffect.value)
#				ReceiveInput = false
#			'sound':
#				input_handler.PlaySound(NewEffect.value)
#				ReceiveInput = false
#			'sfx':
#				self.call(NewEffect.value, NewEffect.args)
#				state.keyframes.push_back(CurrentLine)
#				ReceiveInput = false
#			'text':
#				ShownCharacters = 0
#				var text =  tr(NewEffect.value)
#				TextField.visible_characters = ShownCharacters
#				$Panel/DisplayName.modulate = Color(1,1,1,1) if NewEffect.source != 'narrator' else Color(1,1,1,0)
#				$Panel/CharPortrait.modulate = Color(1,1,1,1) if NewEffect.source != 'narrator' else Color(1,1,1,0)
#				$Panel/DisplayName/Label.text = tr(NewEffect.source)
#				if $Panel/CharPortrait.visible:
#					if NewEffect.portrait == null || images.portraits.has(NewEffect.portrait) == false:
#						$Panel/CharPortrait.texture = null
#					else:
#						$Panel/CharPortrait.texture = images.portraits[NewEffect.portrait]
#				#$Panel/TextShade.bbcode_text = text
#				if ColorsByNames.has(NewEffect.source) && input_handler.globalsettings.textmonocolor == false:
#					text = "[color=#" + ColorsByNames[NewEffect.source] + ']' + text + '[/color]'
#				if !debug:
#					if NewEffect.source != 'narrator':
#						text_log += '\n\n' + '[' + tr(NewEffect.source) + ']\n' + text
#					else:
#						text_log += '\n\n' + tr(NewEffect.value)
#				TextField.bbcode_text = text
#				ReceiveInput = true
#			'sprite':
#				SpriteDo(ImageSprite, NewEffect.value, NewEffect.args)
#				state.keyframes.push_back(CurrentLine)
#				ReceiveInput = false
##			'nextevent':
##				Start(NewEffect.value)
#			'skip':
#				ReceiveInput = false
#				skip(NewEffect.value)
#				text_log += '\n\n' + tr(NewEffect.log)
#			'choice':
#				ReceiveInput = true
#				Choice(NewEffect.value)
#			'decision':
#				ReceiveInput = false
#				state.decisions.append(NewEffect.value)
#			'party':
#				ReceiveInput = false
#				PartyDo(NewEffect.value)
#			'save':
#				ReceiveInput = false
#				if !debug: globals.QuickSave()
#			'event':
#				ReceiveInput = false
#				if !debug: state.StoreEvent(NewEffect.value)
#			'quest':
#				if !debug:QuestSet(NewEffect.value, NewEffect.args)
#			'game':
#				ReceiveInput = false
#				if !debug: input_handler.CurrentScene.GameOverShow()
#				StopEvent()
#			'stop':
#				StopEvent()
#			'state':
#				if !debug:StateEffect(NewEffect.value, NewEffect.args)
#		if NewEffect.has('delay'):
#			Delay = NewEffect.delay
#
#		CurrentLine += 1
#
#func SpriteDo(node, value, args):
#	match value:
#		'set':
#			node.texture = images.sprites[args]
#		'unfade':
#			ResourceScripts.core_animations.UnfadeAnimation(node, args)
#		'fade':
#			ResourceScripts.core_animations.FadeAnimation(node, args)
#		'hide':
#			node.texture = null
#
#func StateEffect(value, args):
#	match value:
##		'character_add':
##			combatantdata.MakeCharacterFromData(args)
#		'make_quest':
#			state.MakeQuest(args)
#		"advance_quest":
#			state.AdvanceQuest(args)
#		"finish_quest":
#			state.FinishQuest(args)
#
#func QuestSet(value, args):
#	match value:
#		'start':
#			state.MakeQuest(args)
#		'progress':
#			state.ProgressQuest(args)
#		'finish':
#			state.FinishQuest(args)
#
#func Choice(array):
#	set_process_input(false)
#	enableskip = false
#	if !debug: globals.QuickSave()
#
#	for i in ChoiceContainer.get_children():
#		if i.name != 'Button':
#			i.queue_free()
#
#	$ChoicePanel.visible = true
#
#	for dict in array:
#		if dict.has('reqs') and dict.reqs != null:
#			continue #запас на будущее, пока не нужно
#		var newbutton = ChoiceContainer.get_node("Button").duplicate()
#		ChoiceContainer.add_child(newbutton)
#		newbutton.show()
#		newbutton.get_node("Label").text = tr(dict.text)
#		newbutton.index = int(dict.index)
#		#newbutton.connect("pressed", self, dictionary.function)
#		newbutton.connect('i_pressed', self, 'get_choice')
#
#func get_choice(i):
#	CurrentLine += i
#	#print(i)
#	$ChoicePanel.visible = false
#	set_process_input(true)
#	AdvanceScene()
#
#func StopEvent():
#	set_process(false)
#	set_process_input(false)
#	input_handler.emit_signal("EventFinished")
#	hide()
#	input_handler.UnlockOpenWindow()
#	input_handler.SetMusic("towntheme")
#	if !debug:
#		state.FinishEvent()
#		globals.call_deferred('EventCheck')
#
#func blackscreentransition(duration = 0.5):
#	TextField.bbcode_text = ''
#	$Panel/CharPortrait.modulate.a = 0
#	$Panel/DisplayName.modulate.a = 0
#	ResourceScripts.core_animations.UnfadeAnimation($BlackScreen, duration)
#	input_handler.emit_signal("ScreenChanged")
#	ResourceScripts.core_animations.FadeAnimation($BlackScreen, duration, duration)
#
#func blackscreenturnon(args = null):
#	$BlackScreen.visible = true
#	$BlackScreen.modulate.a = 1
#
#func blackscreenturnoff(args = null):
#	$BlackScreen.visible = true
#	$BlackScreen.modulate.a = 0
#
#func blackscreenfade(duration = 0.5):
#	input_handler.emit_signal("ScreenChanged")
#	ResourceScripts.core_animations.FadeAnimation($BlackScreen, duration)
#
#func blackscreenunfade(duration = 0.5):
#	input_handler.emit_signal("ScreenChanged")
#	ResourceScripts.core_animations.UnfadeAnimation($BlackScreen, duration)
#
#func shakeanim(duration = 0.2):
#	input_handler.emit_signal("ScreenChanged")
#	ResourceScripts.core_animations.ShakeAnimation(self, duration)
#
#func shakespr(duration = 0.2):
#	input_handler.emit_signal("ScreenChanged")
#	ResourceScripts.core_animations.ShakeAnimation(ImageSprite, duration)
#
#func GuiDo(value):
#	match value:
#		'gui_normal', 'showgui':
#			$Panel.texture = images.gui['norm_back']
#			$Panel/Panel.modulate.a = 0
#			$Panel.modulate = Color(1,1,1,1)
#			$Panel/DisplayName.self_modulate.a = 1
#			$Panel/DisplayName/Label.set("custom_colors/font_color", Color('ffd204'))
#			$Panel/CharPortrait.visible = true
#			$Panel/CharPortrait.modulate = Color(1,1,1,0)
#			$Panel.visible = true
#			$Panel/Options.visible = true
#			$CharImage.visible = true
#			$Background.visible = true
#		'hidegui':
#			$Panel.visible = false
#		'gui_full':
#			$Panel.texture = null
#			$Panel/Panel.modulate.a = 0.7
#			$Panel/DisplayName.self_modulate.a = 0
#			$Panel/CharPortrait.visible = false
#			$Panel/DisplayName/Label.set("custom_colors/font_color", Color('ffffff'))
#			$Panel.visible = true
#			$Panel/Options.visible = true
#			$CharImage.visible = false
#			$Background.visible = true
#		'gui_inside':
#			$Panel.texture = images.gui['norm_back']
#			$Panel/Panel.modulate.a = 0
#			$Panel.modulate = Color(1,1,1,1)
#			$Panel/DisplayName.self_modulate.a = 1
#			$Panel/DisplayName/Label.set("custom_colors/font_color", Color('ffd204'))
#			$Panel/CharPortrait.visible = true
#			$Panel/CharPortrait.modulate = Color(1,1,1,0)
#			$Panel.visible = true
#			$Panel/Options.visible = false
#			$CharImage.visible = false
#			$Background.visible = false
#
#func WhiteScreenGFX(mode = 'default'):
#	var tween = input_handler.GetTweenNode($WhiteScreenGFX)
#	var node = $WhiteScreenGFX
#	node.visible = true
#	tween.start()
#	tween.interpolate_property(node, 'modulate', Color(1,1,1,0), Color(1,1,1,0.9), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
#	tween.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,1,1,0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.3)
#	yield(get_tree().create_timer(0.3), 'timeout')
#	tween.interpolate_property(node, 'modulate', Color(1,1,1,0), Color(1,1,1,0.9), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
#	tween.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,1,1,0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.3)
#	yield(get_tree().create_timer(0.3), 'timeout')
#	tween.interpolate_property(node, 'modulate', Color(1,1,1,0), Color(1,1,1,0.9), 0.7, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
#	tween.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,1,1,0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.7)
#
#
#	node.visible = true
#
#func TownDo(value):
#	if debug: return
#
#func PartyDo(value):
#	if debug: return
#
#
