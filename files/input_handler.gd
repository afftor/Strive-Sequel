extends Node

#This script handles inputs, sounds, closes windows and plays animation
#warning-ignore-all:unused_signal
#warning-ignore-all:return_value_discarded

var CloseableWindowsArray = []
var ShakingNodes = []
var MousePositionScripts = []

var CurrentScreen = 'menu'
var GameStartNode

var BeingAnimated = []
var SystemMessageNode

var text_field_input = false

signal StartingSequenceComplete
signal ScreenChanged
signal BuildingEntered
signal ItemObtained
signal MaterialObtained
signal ExplorationStarted
signal CombatStarted
signal CombatEnded
signal WorkerAssigned
signal SpeedChanged
signal UpgradeUnlocked
signal EventFinished
signal QuestStarted
signal QuestCompleted
signal CharacterCreated
signal EnemyKilled

var last_action_data = {}

var slave_list_node
var exploration_node
var active_character
var scene_characters = []
var scene_loot
var active_area
var active_location
var active_faction = {}

var activated_skill
var target_character

var ghost_items = []


var encounter_win_script = null
var encounter_lose_scripts = []

func _input(event):
	if event.is_echo() == true && !event.is_action_type(): 
		return
	#print(var2str(event))
	if (event.is_action("ESC") || event.is_action_released("RMB")):
		var ignore_rightclick = false
		for i in get_tree().get_nodes_in_group("ignore_rightclicks"):
			if i.visible == true:
				ignore_rightclick = true
				continue
		if ignore_rightclick == false:
			if CloseableWindowsArray.size() != 0:
				CloseTopWindow()
			else:
				if globals.CurrentScene.name == 'mansion' && event.is_action("ESC"):
					globals.CurrentScene.get_node("MenuPanel").open()
	if event.is_action_released("F9"):
		OS.window_fullscreen = !OS.window_fullscreen
		globals.globalsettings.fullscreen = OS.window_fullscreen
		if globals.globalsettings.fullscreen == false:
			OS.window_position = Vector2(0,0)
	if CurrentScreen == 'mansion' && str(event.as_text().replace("Kp ",'')) in str(range(1,9)) && CloseableWindowsArray.size() == 0 && text_field_input == false:
		if str(int(event.as_text())) in str(range(1,4)) && !event.is_pressed():
			if globals.globalsettings.turn_based_time_flow == false:
				globals.CurrentScene.changespeed(globals.CurrentScene.timebuttons[int(event.as_text())-1])
			else:
				globals.CurrentScene.timeflowhotkey(int(event.as_text()))
	elif CurrentScreen == 'scene' && str(event.as_text().replace("Kp ",'')) in str(range(1,9)):
		get_tree().get_root().get_node("dialogue").select_option(int(event.as_text()))
	if event.is_action_pressed('full_screen'):
		OS.window_fullscreen = !OS.window_fullscreen
		globals.globalsettings.fullscren = OS.window_fullscreen

var musicfading = false
var musicraising = false
var musicvalue

func _process(delta):
	if OS.window_position.y < 0:
		OS.window_position.y = 0
	
	for i in CloseableWindowsArray:
		if typeof(i) == TYPE_STRING: continue
		if i.is_visible_in_tree() == false:
			i.hide()
	for i in ShakingNodes:
		if i.time > 0:
			i.time -= delta
			i.node.rect_position = i.originpos + Vector2(rand_range(-1.0,1.0)*i.magnitude, rand_range(-1.0,1.0)*i.magnitude)
		else:
			i.node.rect_position = i.originpos
			ShakingNodes.erase(i)
	soundcooldown -= delta
	
	for i in MousePositionScripts:
		if check_mouse_in_nodes(i.nodes) == false:
			i.targetnode.call(i.script)
			MousePositionScripts.erase(i)
	
	if musicfading:
		AudioServer.set_bus_volume_db(1, AudioServer.get_bus_volume_db(1) - delta*50)
		if AudioServer.get_bus_volume_db(1) <= -80:
			musicfading = false
	if musicraising:
		AudioServer.set_bus_volume_db(1, AudioServer.get_bus_volume_db(1) + delta*100)
		if AudioServer.get_bus_volume_db(1) >= globals.globalsettings.musicvol:
			AudioServer.set_bus_volume_db(1, globals.globalsettings.musicvol)
			musicraising = false

func CloseAllCloseableWindows():
	while CloseableWindowsArray.size() > 0:
		CloseTopWindow()

func CloseTopWindow():
	var node = CloseableWindowsArray.back()
	if typeof(node) == TYPE_STRING:
		return
	elif BeingAnimated.has(node):
		return
	node.hide()
	#CloseableWindowsArray.pop_back(); #i think this is required #It's not, breaks multiple windows order

func LockOpenWindow():
	CloseableWindowsArray.append('lock')
 
func UnlockOpenWindow():
	var node = CloseableWindowsArray.back()
	if typeof(node) == TYPE_STRING:
		CloseableWindowsArray.pop_back();

func OpenClose(node):
	node.show()
	OpenAnimation(node)
	CloseableWindowsArray.append(node)

func Close(node):
	CloseableWindowsArray.erase(node)
	CloseAnimation(node)

func Open(node):
	if CloseableWindowsArray.has(node):
		return
	OpenAnimation(node)
	CloseableWindowsArray.append(node)

func StartCharacterCreation(mode):  #get_spec_node(input_handler.NODE_CHARCREATE, [mode])
	var charnode
	var node = get_tree().get_root()
	if node.has_node('charcreationpanel'):
		charnode = node.get_node('charcreationpanel')
		node.remove_child(charnode)
	else:
		charnode = load("res://src/CharacterCreationPanel.tscn").instance()
		charnode.name = 'charcreationpanel'
	node.add_child(charnode)
	charnode.open(mode)

func GetTextTooltip():  #get_spec_node(input_handler.NODE_TEXTTOOLTIP)
	var tooltipnode
	var node = get_tree().get_root()
	if node.has_node('texttooltip'):
		tooltipnode = node.get_node('texttooltip')
		node.remove_child(tooltipnode)
	else:
		tooltipnode = load("res://src/TextTooltipPanel.tscn").instance()
		tooltipnode.name = 'texttooltip'
	node.add_child(tooltipnode)
	return tooltipnode

func GetItemTooltip():  #get_spec_node(input_handler.NODE_ITEMTOOLTIP)
	var tooltipnode
	var node = get_tree().get_root()
	if node.has_node('itemtooltip'):
		tooltipnode = node.get_node('itemtooltip')
		node.remove_child(tooltipnode)
	else:
		tooltipnode = load("res://files/Simple Tooltip/Imagetooltip.tscn").instance()
		tooltipnode.name = 'itemtooltip'
	node.add_child(tooltipnode)
	return tooltipnode

func GetSkillTooltip(): #get_spec_node(input_handler.NODE_SKILLTOOLTIP)
	var tooltipnode
	var node = get_tree().get_root()
	if node.has_node('skilltooltip'):
		tooltipnode = node.get_node('skilltooltip')
		node.remove_child(tooltipnode)
	else:
		tooltipnode = load("res://src/SkillToolTip.tscn").instance()
		tooltipnode.name = 'skilltooltip'
	node.add_child(tooltipnode)
	return tooltipnode

func GetSlaveTooltip(): #get_spec_node(input_handler.NODE_SLAVETOOLTIP)
	var tooltipnode
	var node = get_tree().get_root()
	if node.has_node('slavetooltip'):
		tooltipnode = node.get_node('slavetooltip')
		node.remove_child(tooltipnode)
	else:
		tooltipnode = load("res://src/SlaveTooltip.tscn").instance()
		tooltipnode.name = 'slavetooltip'
	node.add_child(tooltipnode)
	return tooltipnode

func GetTextEditNode(): #get_spec_node(input_handler.NODE_TEXTEDIT)
	var editnode
	var node = get_tree().get_root()
	if node.has_node('texteditnode'):
		editnode = node.get_node('texteditnode')
		node.remove_child(editnode)
	else:
		editnode = load("res://src/TextEditField.tscn").instance()
		editnode.name = 'texteditnode'
	node.add_child(editnode)
	return editnode

func GetTweenNode(node): #not compartible with get_spec_node due to not linking new node to root
	var tweennode
	if node.has_node('tween'):
		tweennode = node.get_node('tween')
	else:
		tweennode = Tween.new()
		tweennode.name = 'tween'
		node.add_child(tweennode)
	return tweennode

func GetRepeatTweenNode(node): #not compartible with get_spec_node due to not linking new node to root
	var pos = node.rect_position
	var tweennode
	if node.has_node('repeatingtween'):
		tweennode = node.get_node("repeatingtween")
		tweennode.repeat = true
	else:
		tweennode = Tween.new()
		tweennode.repeat = true
		tweennode.name = 'repeatingtween'
		node.add_child(tweennode)
	return tweennode

func SelectionGlow(node):
	var tween = GetRepeatTweenNode(node)
	tween.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,0.5,1,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(node, 'modulate', Color(1,0.5,1,1), Color(1,1,1,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,1)
	tween.start()

func TargetGlow(node):
	var tween = GetRepeatTweenNode(node)
	tween.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,0.8,0.3,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(node, 'modulate', Color(1,0.8,0.3,1), Color(1,1,1,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,1)
	tween.start()

func TargetSupport(node):
	var tween = GetRepeatTweenNode(node)
	tween.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(0.5,1,0.5,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(node, 'modulate', Color(0.5,1,0.5,1), Color(1,1,1,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,1)
	tween.start()

func TargetEnemyTurn(node):
	var tween = GetRepeatTweenNode(node)
	tween.interpolate_property(node, 'rect_scale', Vector2(1,1), Vector2(1.05,1.05), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(node, 'rect_scale', Vector2(1.05,1.05), Vector2(1,1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,0.5)
	tween.start()

var floatfont = preload("res://FloatFont.tres")

func FloatTextArgs(args):
	#print('ftchecked')
	FloatText(args.node, args.text, args.type, args.size, args.color, args.time, args.fadetime, args.offset)

func FloatText(node, text, type = '', size = 80, color = Color(1,1,1), time = 3, fadetime = 0.5, positionoffset = Vector2(0,0)):
	var textnode = Label.new()
	node.add_child(textnode)
	var newfont = floatfont.duplicate()
	newfont.size = size
	textnode.set("custom_fonts/font", newfont)
	textnode.text = text
	textnode.set_anchors_and_margins_preset(Control.PRESET_CENTER)
	textnode.rect_position += positionoffset
	
	textnode.set("custom_colors/font_color", color)
	textnode.set("custom_colors/font_color_shadow", Color(0,0,0))
	
	match type:
		'damageenemy':
			DamageTextFly(textnode, false)
		'damageally':
			DamageTextFly(textnode, true)
		'miss':
			FadeAnimation(textnode, fadetime, time)
		"heal":
			DamageTextFly(textnode, false)
#			HealTextFly(textnode)
	#FadeAnimation(textnode, fadetime, time)
#	node.remove_child(textnode)
#	get_tree().get_current_scene().add_child(textnode)
	var wr = weakref(textnode)
	yield(get_tree().create_timer(time+1), 'timeout')
	if wr.get_ref(): textnode.queue_free()

func DamageTextFly(node, reverse = false):
	var tween = GetTweenNode(node)
#	var firstvector = Vector2(100, -100)
#	var secondvector = Vector2(200, 200)
#	if reverse == true:
#		firstvector = Vector2(-100, -100)
#		secondvector = Vector2(-200, 200)
#	yield(get_tree().create_timer(0.5), 'timeout')
#	tween.interpolate_property(node, 'rect_position', node.rect_position, node.rect_position+firstvector, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	tween.interpolate_property(node, 'rect_position', node.rect_position+firstvector, node.rect_position+secondvector, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.3)
#	FadeAnimation(node, 0.2 , 0.7)
	var firstvector = Vector2(0, 0)
	tween.interpolate_property(node, 'rect_position', node.rect_position, node.rect_position+firstvector, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,0.5)
	FadeAnimation(node, 0.2, 1)
	tween.start()

func HealTextFly(node):
	var tween = GetTweenNode(node)
	var firstvector = Vector2(0, -150)
	tween.interpolate_property(node, 'rect_position', node.rect_position, node.rect_position+firstvector, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,0.5)
	FadeAnimation(node, 0.2, 1)
	tween.start()

func StopTweenRepeat(node):
	var tween = GetRepeatTweenNode(node)
	tween.seek(0)
	tween.set_active(false)
	tween.remove_all()

#Music
func SetMusicRandom(category):
	var track = audio.music_categories[category]
	track = track[randi()%track.size()]
	SetMusic(track)

func SetMusic(name, delay = 0):
	if audio.music.has(name) == false: return
	yield(get_tree().create_timer(delay), 'timeout')
	musicraising = true
	var musicnode = get_spec_node(input_handler.NODE_MUSIC) #GetMusicNode()
	if musicnode.stream == audio.music[name]:
		return
	musicnode.stream = audio.music[name]
	musicnode.play(0)

func StopMusic(instant = false):
	musicfading = true

func GetMusicNode(): #get_spec_node(input_handler.NODE_MUSIC)
	var node = get_tree().get_root()
	var musicnode
	if node.has_node('music'):
		musicnode = node.get_node('music')
	else:
		musicnode = AudioStreamPlayer.new()
		musicnode.name = 'music'
		musicnode.bus = 'Music'
		node.call_deferred('add_child', musicnode)
	return musicnode

#Sounds

func PlaySound(name, delay = 0):
	yield(get_tree().create_timer(delay), 'timeout')
	var soundnode = get_spec_node(input_handler.NODE_SOUND) #GetSoundNode()
	soundnode.stream = audio.sounds[name]
	soundnode.seek(0)
	soundnode.play(0)
	yield(soundnode, 'finished')
	soundnode.queue_free()

func PlayBackgroundSound(name):
	var soundnode = get_spec_node(input_handler.NODE_BACKGROUND_SOUND) #GetSoundNode()
	soundnode.stream = audio.background_noise[name]
	soundnode.seek(0)
	soundnode.play(0)

func StopBackgroundSound():
	var soundnode = get_spec_node(input_handler.NODE_BACKGROUND_SOUND) #GetSoundNode()
	soundnode.stop()

var soundcooldown = 0

func PlaySoundIsolated(sound, cooldown):
	if soundcooldown > 0:
		return
	PlaySound(sound)
	soundcooldown = cooldown

func GetSoundNode(): #get_spec_node(input_handler.NODE_SOUND)
	var node = get_tree().get_root()
	var soudnnode = AudioStreamPlayer.new()
	soudnnode.bus = 'Sound'
	node.add_child(soudnnode)
	return soudnnode

func GetEventNode(): #get_spec_node(input_handler.NODE_EVENT)
	var node
	if get_tree().get_root().has_node('EventNode') == false:
		node = load("res://files/TextScene/TextSystem.tscn").instance()
		get_tree().get_root().add_child(node)
		#node.set_as_toplevel(true)
		node.name = 'EventNode'
	else:
		node = get_tree().get_root().get_node("EventNode")
		get_tree().get_root().remove_child(node)
		get_tree().get_root().add_child(node)
	return node

func GetSkillSelectNode(): #get_spec_node(input_handler.NODE_SKILLSELECT)
	var node
	if get_tree().get_root().has_node('SelectSkillMenu') == false:
		node = load("res://src/SkillSelectMenu.tscn").instance()
		get_tree().get_root().add_child(node)
		node.name = 'SelectSkillMenu'
	else:
		node = get_tree().get_root().get_node("SelectSkillMenu")
		get_tree().get_root().remove_child(node)
		get_tree().get_root().add_child(node)
	return node

func ShowSkillSelectPanel(person, type, TargetNode, TargetFunction): #very strange container method
	var node = get_spec_node(input_handler.NODE_SKILLSELECT) #GetSkillSelectNode()
	node.open(person, type, TargetNode, TargetFunction)

func GetSlaveSelectNode():#get_spec_node(input_handler.NODE_SLAVESELECT)
	var node
	if get_tree().get_root().has_node('SelectSlaveMenu') == false:
		node = load("res://src/SlaveSelectMenu.tscn").instance()
		get_tree().get_root().add_child(node)
		#node.set_as_toplevel(true)
		node.name = 'SelectSlaveMenu'
	else:
		node = get_tree().get_root().get_node("SelectSlaveMenu")
		get_tree().get_root().remove_child(node)
		get_tree().get_root().add_child(node)
	return node

func ShowSlaveSelectPanel(TargetNode, TargetFunction, reqs = [], allowcancel = false): #just a strange container method
	var node = get_spec_node(input_handler.NODE_SLAVESELECT) #GetSlaveSelectNode()
	node.open(TargetNode, TargetFunction, reqs, allowcancel)

func ShowConfirmPanel(TargetNode, TargetFunction, Text): #get_spec_node(input_handler.NODE_CONFIRMPANEL, [TargetNode, TargetFunction, Text])
	var node
	if get_tree().get_root().has_node('ConfirmPanel') == false:
		node = load("res://src/ConfirmPanel.tscn").instance()
		get_tree().get_root().add_child(node)
		node.name = 'ConfirmPanel'
	else:
		node = get_tree().get_root().get_node("ConfirmPanel")
		get_tree().get_root().remove_child(node)
		get_tree().get_root().add_child(node)
	node.Show(TargetNode, TargetFunction, Text)

func ShowPopupPanel(Text, ButtonText = 'Confirm'): #get_spec_node(input_handler.NODE_POPUP, [Text, ButtonText])
	var node
	if get_tree().get_root().has_node('PopupPanel') == false:
		node = load("res://src/scenes/PopupPanel.tscn").instance()
		get_tree().get_root().add_child(node)
		node.name = 'PopupPanel'
	else:
		node = get_tree().get_root().get_node("PopupPanel")
		get_tree().get_root().remove_child(node)
		get_tree().get_root().add_child(node)
	node.open(Text, ButtonText)

#Item shading function

func itemshadeimage(node, item):
	var shader = load("res://files/ItemShader.tres").duplicate()
	var icon
	var is_template = false
	if typeof(item.icon) == TYPE_STRING:
		icon = load(item.icon)
	else:
		icon = item.icon
		is_template = true
	if node.get_class() == "TextureButton":
		node.texture_normal = icon
	else:
		node.texture = icon
	if node.material != shader:
		node.material = shader
	else:
		shader = node.material
	if is_template == false:
		for i in item.parts:
			var part = 'part' +  str(item.partcolororder[i]) + 'color'
			var color = Items.materiallist[item.parts[i]].color
			node.material.set_shader_param(part, color)


#Enlarge/fade out animation
func OpenAnimation(node):
	if BeingAnimated.has(node) == true:
		return
	BeingAnimated.append(node)
	node.visible = true
	var tweennode = GetTweenNode(node)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,0), Color(1,1,1,1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweennode.start()
	yield(get_tree().create_timer(0.15), 'timeout')
	BeingAnimated.erase(node)
	node.raise()

func CloseAnimation(node):
	if BeingAnimated.has(node) == true:
		return
	BeingAnimated.append(node)
	var tweennode = GetTweenNode(node)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,1,1,0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweennode.start()
	yield(get_tree().create_timer(0.15), 'timeout')
	node.visible = false
	BeingAnimated.erase(node)

func OldOpenAnimation(node):
	if BeingAnimated.has(node) == true:
		return
	BeingAnimated.append(node)
	node.visible = true
	var tweennode = GetTweenNode(node)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,0), Color(1,1,1,1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweennode.interpolate_property(node, 'rect_scale', Vector2(0.7,0.6), Vector2(1,1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweennode.start()
	yield(get_tree().create_timer(0.3), 'timeout')
	BeingAnimated.erase(node)

func OldCloseAnimation(node):
	if BeingAnimated.has(node) == true:
		return
	BeingAnimated.append(node)
	var tweennode = GetTweenNode(node)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,1,1,0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweennode.interpolate_property(node, 'rect_scale', Vector2(1,1), Vector2(0.7,0.6), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweennode.start()
	yield(get_tree().create_timer(0.3), 'timeout')
	node.visible = false
	BeingAnimated.erase(node)


func FadeAnimation(node, time = 0.3, delay = 0):
	var tweennode = GetTweenNode(node)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,1,1,0), time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tweennode.start()

func UnfadeAnimation(node, time = 0.3, delay = 0):
	var tweennode = GetTweenNode(node)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,0), Color(1,1,1,1), time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tweennode.start()

func ShakeAnimation(node, time = 0.5, magnitude = 5):
	var newdict = {node = node, time = time, magnitude = magnitude, originpos = node.rect_position}
	for i in ShakingNodes:
		if i.node == node:
			newdict.originpos = i.originpos
			ShakingNodes.erase(i)
	ShakingNodes.append(newdict)

func SmoothValueAnimation(node, time, value1, value2):
	var tween = GetTweenNode(node)
	tween.interpolate_property(node, 'value', value1, value2, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func gfx(node, effect, fadeduration = 0.5, delayuntilfade = 0.3, flip = false,  rotate = false):
	var x = TextureRect.new()
	x.texture = images.GFX[effect]
	x.expand = true
	x.stretch_mode = 6
	x.mouse_filter = 2
	node.add_child(x)
	
	x.rect_size = node.rect_size
	
	if flip: x.set_flip_h(true)
	
	if rotate == true: 
		x.rect_pivot_offset = images.GFX[effect].get_size()/2
		x.rect_rotation = rand_range(0,360)
	
	input_handler.FadeAnimation(x, fadeduration, delayuntilfade)
	var wr = weakref(x)
	yield(get_tree().create_timer(fadeduration*2), 'timeout')
	
	if wr.get_ref(): x.queue_free()

var sprites = {
	strike = 'res://assets/sfx/hit_animation/strike.tscn',
	arrow = 'res://assets/sfx/arrow.tscn',
	water_attack = 'res://assets/sfx/water_attack.tscn',
	firebolt = 'res://assets/sfx/hit_animation/firebolt.tscn',
	flame = 'res://assets/sfx/hit_animation/flame.tscn',
	earth_spike = "res://assets/sfx/hit_animation/earth_spike.tscn",
	decay = "res://assets/sfx/hit_animation/DecayEffect.tscn",
	}
var particles = {
	heal = "res://assets/sfx/HealEffect.tscn",
}

func gfx_sprite(node, effect, fadeduration = 0.5, delayuntilfade = 0.3, flip = false):
	var x = load(sprites[effect]).instance()
	node.add_child(x)
	x.position = node.rect_size/2
	if flip == true: x.set_flip_h(true)
	#x.set_anchors_and_margins_preset(Control.PRESET_CENTER)
	x.play()
	
	input_handler.FadeAnimation(x, fadeduration, delayuntilfade)
	var wr = weakref(x)
	yield(get_tree().create_timer(delayuntilfade+fadeduration), 'timeout')

	if wr.get_ref(): x.queue_free()

func gfx_particles(node, effect, fadeduration = 0.5, delayuntilfade = 0.3):
	var x = load(particles[effect]).instance()
	node.add_child(x)
	x.position = node.rect_size/2
	#x.set_anchors_and_margins_preset(Control.PRESET_CENTER)
	x.emitting = true
	
	input_handler.FadeAnimation(x, fadeduration, delayuntilfade)
	var wr = weakref(x)
	yield(get_tree().create_timer(fadeduration*2), 'timeout')

	if wr.get_ref(): x.queue_free()

func ResourceGetAnimation(node, startpoint, endpoint, time = 0.5, delay = 0.2):
	var tweennode = GetTweenNode(node)
	tweennode.interpolate_property(node, 'rect_position', startpoint, endpoint, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,1,1,0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay + (time/1.2))
	tweennode.start()

func SmoothTextureChange(node, newtexture, time = 0.5):
	var NodeCopy = node.duplicate()
	node.get_parent().add_child_below_node(node, NodeCopy)
	node.texture = newtexture
	FadeAnimation(NodeCopy, time)
	yield(get_tree().create_timer(time+0.1), 'timeout')
	NodeCopy.queue_free()

func BlackScreenTransition(duration = 0.5):
	var blackscreen = load("res://files/SFX/BlackScreen.tscn").instance()
	get_tree().get_root().add_child(blackscreen)
	UnfadeAnimation(blackscreen, duration)
	FadeAnimation(blackscreen, duration, duration)
	yield(get_tree().create_timer(duration*2+0.1), 'timeout')
	blackscreen.queue_free()

func DelayedText(node, text):
	node.text = text

func requirementcombatantcheck(req, combatant):#Gear, Race, Types, Resists, stats
	var result
	match req.type:
		'chance':
			result = (randf()*100 < req.value);
		'stats':
			result = input_handler.operate(req.operant, combatant.get(req.name), req.value)
		'gear':
			match req.slot:
				'any':
					var tempresult = false
					for i in combatant.gear.values():
						if i != null:
							tempresult = input_handler.operate(req.operant, state.items[i][req.name], state.items[i][req.value])
							if tempresult == true:
								result = true
								break
				'all':
					result = true
					for i in combatant.gear.values():
						if i != null:
							if input_handler.operate(req.operant, state.items[i][req.name], state.items[i][req.value]) == false:
								result = false
								break
		'race':
			result = (req.value == combatant.race);
	return result



func operate(operation, value1, value2):
	var result
	
	match operation:
		'eq':
			result = value1 == value2
		'neq':
			result = value1 != value2
		'gte':
			result = value1 >= value2
		'gt':
			result = value1 > value2
		'lte':
			result = value1 <= value2
		'lt':
			result = value1 < value2
		'has':
			result = value1.has(value2)
		'hasno':
			result = !value1.has(value2)
		'mask':
			result = (int(value1) & int(value2)) != 0
	return result

func operant_translation(operant):
	var text = ''
	match operant:
		'gte':
			text = 'At least'
		'lte':
			text = 'At most'
	return text

func math(operation, value1, value2):
	match operation:
		'+':
			value1 += value2
		'-':
			value1 -= value2
		'*':
			value1 *= value2
		'/':
			value1 /= value2
		'=':
			value1 = value2
	return value1

func string_to_math(value = 0, string = ''):
	var modvalue = float(string.substr(1, string.length()))
	var operator = string[0]
	
	match operator:
		'+':value += modvalue
		'-':value -= modvalue
		'*':value *= modvalue
		'/':value /= modvalue
	return value
	
func weightedrandom(array): #uses an array of [value, weight] with value being returned according to weight change
	var total = 0
	var counter = 0
	for i in array:
		total += i[1]
	var random = rand_range(0,total)
	for i in array:
		if counter + i[1] >= random:
			return i[0] 
		counter += i[1]

func open_shell(string):
	var path = string
	match string:
		'Itch':
			path = 'https://strive4power.itch.io/strive-for-power'
		'Patreon':
			path = 'https://www.patreon.com/maverik'
		'Discord':
			path = "https://discord.gg/VXSx9Zk"
	OS.shell_open(path)

func SystemMessage(text, time = 4):
	var basetime = time
	#yield(get_tree(), 'idle_frame')
#	if weakref(SystemMessageNode).get_ref():
#		text = '[center]' + tr(text) + '[/center]'
#		SystemMessageNode.show()
#		SystemMessageNode.modulate.a = 1
#		SystemMessageNode.get_node('Text').bbcode_text = text
#		SystemMessageNode.get_parent().remove_child(SystemMessageNode)
#		get_tree().get_root().add_child(SystemMessageNode)
#		FadeAnimation(SystemMessageNode, 1, basetime)
	SystemMessageNode = get_spec_node(self.NODE_SYSMESSAGE)
	text = '[center]' + tr(text) + '[/center]'
	SystemMessageNode.get_node('Text').bbcode_text = text
	SystemMessageNode.show()
	SystemMessageNode.modulate.a = 1
	FadeAnimation(SystemMessageNode, 1, basetime)

func ShowOutline(node):
	node.material = load('res://files/portret_shader.tres').duplicate()
	node.material.set_shader_param('opacity', 1)

func HideOutline(node):
	node.material.set_shader_param('opacity', 0)

func ConnectSound(node, sound, action):
	node.connect(action, input_handler, 'PlaySound', [sound])

#Slave Panel

func ShowSlavePanel(person): #not fully node getter
	var node = get_spec_node(input_handler.NODE_SLAVEPANEL)
	node.raise()
	node.open(person)

#Inventory

func ShowInentory(args): #get_spec_node(input_handler.NODE_INVENTORY, [args])
	var inventory
	var node = get_tree().get_root()
	if node.has_node('inventory'):
		inventory = node.get_node('inventory')
		node.remove_child(inventory)
	else:
		inventory = load("res://files/Inventory.tscn").instance()
		inventory.name = 'inventory'
	node.add_child(inventory)
	inventory.open(args)
	
	return inventory

func calculate_number_from_string_array(arr, caster, target):
	if typeof(arr) != TYPE_ARRAY:
		return float(arr)
	var array = arr.duplicate()
	var endvalue = 0
	var singleop = ''
	var firstrun = true
	for i in array:
		if typeof(i) == TYPE_ARRAY:
			i = str(calculate_number_from_string_array(i, caster, target))
		if i in ['+','-','*','/']:
			singleop = i
			continue
		var modvalue = i
		if (i.find('caster') >= 0) or (i.find('target') >= 0):
			i = i.split('.')
			if i[0] == 'caster':
				modvalue = str(caster.get_stat(i[1]))
			elif i[0] == 'target':
				modvalue = str(target.get_stat(i[1]))
		elif (i.find('random') >= 0):
			i = i.split(' ')
			modvalue = str(globals.rng.randi_range(0, int(i[1])))
		if singleop != '':
			endvalue = string_to_math(endvalue, singleop+modvalue)
			singleop = ''
			continue
		if !modvalue[0].is_valid_float():
			if modvalue[0] == '-' && firstrun == true:
				endvalue += float(modvalue)
			else:
				endvalue = input_handler.string_to_math(endvalue, modvalue)
		else:
			endvalue += float(modvalue)
		firstrun = false
	return endvalue

func get_dialogue_node():#get_spec_node(input_handler.NODE_DIALOGUE)
	var dialogue
	var node = get_tree().get_root()
	if node.has_node('dialogue'):
		dialogue = node.get_node('dialogue')
		node.remove_child(dialogue)
	else:
		dialogue = load("res://src/InteractiveMessage.tscn").instance()
		dialogue.name = 'dialogue'
	node.add_child(dialogue)
	return dialogue


func dialogue_option_selected(option):
	get_spec_node(input_handler.NODE_DIALOGUE).previous_text = tr(option)
	if !state.selected_dialogues.has(option):
		state.selected_dialogues.append(option)

func interactive_message(code, type, args):
	var data = scenedata.scenedict[code].duplicate(true)
	var scene = get_spec_node(input_handler.NODE_DIALOGUE) #get_dialogue_node()
	if data.has('opp_characters'):
		for i in data.opp_characters:
			match i.type:
				'pregen':
					scene_characters.append(input_handler.make_story_character(i.value))
	match type:
		'social_skill':
			for i in variables.dynamic_text_vars:
				data.text = data.text.replace("[" + i + '1' + ']', "[" + i + "]")
			data.text = args.name1.translate(data.text)
			for i in variables.dynamic_text_vars:
				data.text = data.text.replace("[" + i + '2' + ']', "[" + i + "]")
			data.text = args.name2.translate(data.text)
			scene_characters.append(args.name1)
			if args.has("bonustext"):
				data.text += args.bonustext
			if args.has('repeat'):
				data.options.append({code ='repeat', text = tr('DIALOGUEREPEATACTION'), disabled = !args.repeat})
		'scene_character_event':
			for i in range(0, scene_characters.size()):
				data.text = scene_characters[i].translate(data.text)
		'quest_finish_event':
			data.text = data.text.replace("[dungeonname]", args.locationname)
		'childbirth':
			active_character = args.pregchar
			var baby = state.babies[active_character.pregnancy.baby]
			scene_characters.append(baby)
		'event_selection':
			data.location = active_location
		'loot':
			match args.loot_data.type:
				'tableloot':
					scene_loot = world_gen.make_chest_loot(weightedrandom(args.loot_data.pool))
		'area_oneshot_event':
			for i in active_area.events:
				if i.code == code:
					active_area.events.erase(i)
					break
		'location_purchase_event':
			data.text = data.text.replace("[areaname]", active_area.name).replace('[locationname]', active_location.name).replace('[locationdescript]',active_location.descript).replace("[locationtypename]", active_location.classname)
	
	scene.open(data)

func interactive_message_custom(data):
	var scene = get_spec_node(input_handler.NODE_DIALOGUE) #get_dialogue_node()
	scene.open(data, true)

func interactive_dialogue_start(code, stage):
	var scene = get_spec_node(input_handler.NODE_DIALOGUE) #get_dialogue_node()
	scene.dialogue_next(code, stage)

func get_loot_node(): #get_spec_node(input_handler.NODE_LOOTTABLE)
	var window
	var node = get_tree().get_root()
	if node.has_node('lootwindow'):
		window = node.get_node('lootwindow')
		node.remove_child(window)
	else:
		window = load("res://src/scenes/LootWindow.tscn").instance()
		window.name = 'lootwindow'
	node.add_child(window)
	return window

func ActivateTutorial(code):
	if state.show_tutorial == true && state.active_tutorials.has(code) == false && state.seen_tutorials.has(code) == false:
		state.active_tutorials.append(code)
		get_spec_node(input_handler.NODE_TUTORIAL).rebuild()
		#get_tutorial_node().rebuild()

func get_tutorial_node(): #get_spec_node(input_handler.NODE_TUTORIAL)
	var window
	var node = get_tree().get_root()
	if node.has_node('tutorial_node'):
		window = node.get_node('tutorial_node')
		node.remove_child(window)
	else:
		window = load("res://src/scenes/TutorialNode.tscn").instance()
		window.name = 'tutorial_node'
	node.add_child(window)
	return window

func get_chat_node(): #get_spec_node(input_handler.NODE_CHAT)
	var window
	var node = get_tree().get_root()
	if node.has_node('chatwindow'):
		window = node.get_node('chatwindow')
		node.remove_child(window)
	else:
		window = load("res://src/scenes/ChatNode.tscn").instance()
		window.name = 'chatwindow'
	node.add_child(window)
	return window

func show_class_info(classcode, person = null):
	if person == null:
		person = active_character
	var node = get_spec_node(input_handler.NODE_CLASSINFO) #get_class_info_panel()
	node.open(classcode, person)

func get_class_info_panel(): #get_spec_node(input_handler.NODE_CLASSINFO)
	var window
	var node = get_tree().get_root()
	if node.has_node('classinfo'):
		window = node.get_node('classinfo')
		#node.remove_child(window)
	else:
		window = load("res://src/scenes/ClassInformationPanel.tscn").instance()
		window.name = 'classinfo'
		node.add_child(window)
	#node.add_child(window)
	window.raise()
	return window

func get_combat_node():
	var window
	var node = get_tree().get_root()
	if node.has_node('combat'):
		window = node.get_node('combat')
	else:
		window = load("res://files/combat.tscn").instance()
		window.name = 'combat'
		node.add_child(window)
		#node.call_deferred('add_child',window)
	window.raise()
	return window

func get_person_for_chat(array, event, bonus_args = []):
	var allowed_array = []
	var weight = 0
	for i in array:
		var person = characters_pool.get_char_by_id(i)
		if state.get_master() == person:
			continue
		weight = 1
		allowed_array.append([person, weight])
	
	var person = weightedrandom(allowed_array)
	if person != null:
		add_random_chat_message(person, event, bonus_args)

func add_random_chat_message(person, event, bonus_args = []):
	if person == state.get_master(): return
	var node = get_spec_node(input_handler.NODE_CHAT) #get_chat_node()
	node.select_chat_line(person, event, bonus_args)

func get_random_chat_line(person, event):
	var node = get_spec_node(input_handler.NODE_CHAT) #get_chat_node()
	return node.return_chat_line(person, event)

func repeat_social_skill():
	if last_action_data.code == 'social_skill':
		last_action_data.caster.use_social_skill(last_action_data.skill,last_action_data.target)

func remove_location(locationid):
	var location = world_gen.get_location_from_code(locationid)
	var area = world_gen.get_area_from_location_code(locationid)
	return_characters_from_location(locationid)
	area.locations.erase(location.id)
	area.questlocations.erase(location.id)
	state.completed_locations[location.id] = {name = location.name, id = location.id, area = area.code}
	update_slave_list()
	if active_location == location && globals.CurrentScene.get_node("Exploration").is_visible_in_tree():
		globals.CurrentScene.get_node("Exploration").select_location('Aliron')
		globals.CurrentScene.get_node("Exploration").build_accessible_locations()

func return_characters_from_location(locationid):
	var location = world_gen.get_location_from_code(locationid)
	var area = world_gen.get_area_from_location_code(locationid)
	for id in state.character_order:
		var person = state.characters[id]
		if (person.location == location.id && person.travel_time == 0) || person.travel_target.location == location.id:
			if variables.instant_travel == false:
				person.location = 'travel'
				person.travel_target = {area = '', location = 'mansion'}
				person.travel_time = area.travel_time + location.travel_time
			else:
				person.location = 'mansion'
				person.return_to_task()

func make_story_character(args):
	var newchar = Slave.new()
	newchar.generate_predescribed_character(world_gen.pregen_characters[args])
	return newchar

func update_slave_list():
	slave_list_node.update()
func rebuild_slave_list():
	slave_list_node.rebuild()

func update_slave_panel():
	var node = get_spec_node(input_handler.NODE_SLAVEPANEL, null, false)#, false)
	if node.visible == true:
		node.update()


func check_mouse_in_nodes(nodes):
	var check = false
	for i in nodes:
		if weakref(i) != null:
			if i.get_global_rect().has_point(globals.CurrentScene.get_global_mouse_position()):
				check = true
	return check

func text_cut_excessive_lines(text:String):
	while text.ends_with(" ") || text.ends_with("\n"):
		text.erase(text.length()-1, text.length())
	return text


enum {NODE_CLASSINFO, NODE_CHAT, NODE_TUTORIAL, NODE_LOOTTABLE, NODE_DIALOGUE, NODE_INVENTORY, NODE_POPUP, NODE_CONFIRMPANEL, NODE_SLAVESELECT, NODE_SKILLSELECT, NODE_EVENT, NODE_MUSIC, NODE_SOUND, NODE_BACKGROUND_SOUND, NODE_TEXTEDIT, NODE_SLAVETOOLTIP, NODE_SKILLTOOLTIP, NODE_ITEMTOOLTIP, NODE_TEXTTOOLTIP, NODE_CHARCREATE, NODE_SLAVEPANEL, NODE_COMBATPOSITIONS, NODE_SYSMESSAGE} #, NODE_TWEEN, NODE_REPEATTWEEN}

var node_data = {
	NODE_CLASSINFO : {name = 'classinfo', mode = 'scene', scene = preload("res://src/scenes/ClassInformationPanel.tscn")},
	NODE_CHAT : {name = 'chatwindow', mode = 'scene', scene = preload("res://src/scenes/ChatNode.tscn")},
	NODE_TUTORIAL : {name = 'tutorial_node', mode = 'scene', scene = preload("res://src/scenes/TutorialNode.tscn")},
	NODE_LOOTTABLE : {name = 'lootwindow', mode = 'scene', scene = preload("res://src/scenes/LootWindow.tscn")},
	NODE_DIALOGUE : {name = 'dialogue', mode = 'scene', scene = preload("res://src/InteractiveMessage.tscn")},
	NODE_INVENTORY : {name = 'inventory', mode = 'scene', scene = preload("res://files/Inventory.tscn"), calls = 'open'},
	NODE_POPUP : {name = 'PopupPanel', mode = 'scene', scene = preload("res://src/scenes/PopupPanel.tscn"), calls = 'open'},
	NODE_CONFIRMPANEL : {name = 'ConfirmPanel', mode = 'scene', scene = preload("res://src/ConfirmPanel.tscn"), calls = 'Show'},
	NODE_SLAVESELECT : {name = 'SlaveSelectMenu', mode = 'scene', scene = preload("res://src/SlaveSelectMenu.tscn")},
	NODE_SKILLSELECT : {name = 'SelectSkillMenu', mode = 'scene', scene = preload("res://src/SkillSelectMenu.tscn")},
	NODE_EVENT : {name = 'EventNode', mode = 'scene', scene = preload("res://files/TextScene/TextSystem.tscn")},
	NODE_MUSIC : {name = 'music', mode = 'node', node = AudioStreamPlayer, args = {'bus':"Music"}},
	NODE_SOUND : {name = 'sound', mode = 'node', no_return = true, node = AudioStreamPlayer, args = {'bus':"Sound"}},
	NODE_BACKGROUND_SOUND : {name = 'BGSound', mode = 'node', node = AudioStreamPlayer, args = {'bus':"Sound"}},
	#NODE_REPEATTWEEN : {name = 'repeatingtween', mode = 'node', node = Tween, args = {'repeat':true}},
	#NODE_TWEEN : {name = 'tween', mode = 'node', node = Tween},
	NODE_TEXTEDIT : {name = 'texteditnode', mode = 'scene', scene = preload("res://src/TextEditField.tscn")},
	NODE_SLAVETOOLTIP : {name = 'slavetooltip', mode = 'scene', scene = preload("res://src/SlaveTooltip.tscn")},
	NODE_SKILLTOOLTIP : {name = 'skilltooltip', mode = 'scene', scene = preload("res://src/SkillToolTip.tscn")},
	NODE_ITEMTOOLTIP : {name = 'itemtooltip', mode = 'scene', scene = preload("res://files/Simple Tooltip/Imagetooltip.tscn")},
	NODE_TEXTTOOLTIP : {name = 'texttooltip', mode = 'scene', scene = preload("res://src/TextTooltipPanel.tscn")},
	NODE_CHARCREATE : {name = 'charcreationpanel', mode = 'scene', scene = preload("res://src/CharacterCreationPanel.tscn"), calls = 'open'},
	NODE_SLAVEPANEL : {name = 'slavepanel', mode = 'scene', scene = preload("res://src/scenes/SlavePanel.tscn")},
	NODE_COMBATPOSITIONS : {name = 'combatpositions', mode = 'scene', scene = preload("res://src/PositionSelectMenu.tscn"), calls = 'open'},
	NODE_SYSMESSAGE : {name = 'SysMessage', mode = 'scene', scene = preload("res://src/SysMessage.tscn") }, #add path here
}

func get_spec_node(type, args = null, raise = true, unhide = true):
	var window
	var node = get_tree().get_root()
	if node.has_node(node_data[type].name) and !node_data[type].has('no_return'):
		window = node.get_node(node_data[type].name)
		#node.remove_child(window)
	else:
		match node_data[type].mode:
			'scene':
				window = node_data[type].scene.instance()
			'node':
				window = node_data[type].node.new()
		window.name = node_data[type].name
		node.add_child(window)
	if raise: window.raise()
	if node_data[type].has('args'): 
		for param in node_data[type].args:
			window.set(param, node_data[type].args[param])
	if node_data[type].has('calls'): 
		if args == null: args = []
		window.callv(node_data[type].calls, args)
	elif args != null: 
		for param in args:
			window.set(param, args[param])
	return window

var current_level
var current_stage
var current_enemy_group

func check_events(action):
	var eventarray = active_location.scriptedevents
	var erasearray = []
	var eventtriggered = false
	for i in eventarray:
		if i.trigger == action && check_event_reqs(i.reqs) == true:
			if i.event == 'custom_event':
				interactive_message_custom(scenedata.scenedict[i.args])
			elif i.has('args'):
				call(i.event, i.args)
			else:
				call(i.event)
			eventtriggered = true
			if i.has('oneshot') && i.oneshot == true:
				erasearray.append(i)
			break
	for i in erasearray:
		eventarray.erase(i)
	return eventtriggered

func check_random_event():
	if randf() > variables.dungeon_encounter_chance:
		return false
	var eventarray = active_location.randomevents
	var eventtriggered = false
	var active_array = []
	for i in eventarray:
		var event = scenedata.scenedict[i[0]]
		if event.has('reqs'):
			if state.checkreqs(event.reqs):
				active_array.append(i)
		else:
			active_array.append(i)
	if active_array.size() > 0:
		active_array = input_handler.weightedrandom(active_array)
		var eventtype = "event_selection"
		var dict = {}
		if scenedata.scenedict[active_array].has("default_event_type"):
			eventtype = scenedata.scenedict[active_array].default_event_type
		if scenedata.scenedict[active_array].has('bonus_args'):
			dict = scenedata.scenedict[active_array].bonus_args
		input_handler.interactive_message(active_array, eventtype, dict)
		eventtriggered = true
	return eventtriggered

func check_event_reqs(reqs):
	var check = true
	for i in reqs:
		match i.code:
			'level':
				check = input_handler.operate(i.operant, current_level, i.value)
			'stage':
				check = input_handler.operate(i.operant, current_stage, i.value)
		if check == false:
			break
	
	
	return check

func check_location_group():
	var counter = 0
	var cleararray = []
	for i in active_location.group:
		if state.characters.has(active_location.group[i]): 
			counter += 1
		else:
			cleararray.append(i)
	
	for i in cleararray:
		active_location.erase(i)
	
	if counter == 0:
		return false
	else:
		return true


func StartCombat(encounter = null):
	var data
	if encounter != null:
		data = Enemydata.encounters[encounter]
		encounter_win_script = Enemydata.encounters[encounter].win_effects
	
	
	if variables.skip_combat == true:
		finish_combat()
		return
	
	if encounter == null:
		StartAreaCombat()
		return
	
	var enemies
	var enemy_stats_mod = 1
	match data.unittype:
		'randomgroup':
			enemies = make_enemies(data.unitcode)
	
	
	var combat = get_combat_node()
	combat.encountercode = data.unitcode
	
	combat.start_combat(active_location.group, enemies, data.bg, data.bgm, enemy_stats_mod)

func StartQuestCombat(encounter):
	pass

func StartAreaCombat():
	
	var enemydata
	var enemygroup = {}
	var enemies = []
	var music = 'combattheme'
	
	
	
	
	
	for i in active_location.stagedenemies:
		if i.stage == current_stage && i.level == current_level:
			enemydata = i.enemy#[i.enemy,1]
	if enemydata == null:
		enemydata = active_location.enemies
	
	enemies = make_enemies(enemydata)
	
	var enemy_stats_mod = (1 - variables.difficulty_per_level) + variables.difficulty_per_level * current_level
	
	var combat = get_combat_node()
	combat.encountercode = enemydata
	combat.start_combat(active_location.group, enemies, 'background', music, enemy_stats_mod)

func make_enemies(enemydata):
	var enemies
	if typeof(enemydata) == TYPE_ARRAY:
		enemies = input_handler.weightedrandom(enemydata)
		enemies = makerandomgroup(Enemydata.enemygroups[enemies])
	elif Enemydata.enemygroups.has(enemydata):
		enemies = makerandomgroup(Enemydata.enemygroups[enemydata])
	else:
		enemies = makespecificgroup(enemydata)
	return enemies

func makespecificgroup(group):
	var enemies = Enemydata.predeterminatedgroups[group]
	var combatparty = {1 : null, 2 : null, 3 : null, 4 : null, 5 : null, 6 : null}
	for i in enemies.group:
		combatparty[i] = enemies.group[i]
	
	return combatparty

func makerandomgroup(enemygroup):
	var array = []
	for i in enemygroup.units:
		var size = round(rand_range(enemygroup.units[i][0],enemygroup.units[i][1]))
		if size != 0:
			array.append({units = i, number = size})
	var countunits = 0
	for i in array:
		countunits += i.number
	if countunits > 6:
		array[randi()%array.size()].number -= (countunits-6)
	
	#Assign units to rows
	var combatparty = {1 : null, 2 : null, 3 : null, 4 : null, 5 : null, 6 : null}
	for i in array:
		var unit = Enemydata.enemies[i.units]
		while i.number > 0:
			var temparray = []
			
			
			if true:
				#smart way
				for i in combatparty:
					if combatparty[i] != null:
						continue
					var aiposition = unit.ai_position[randi()%unit.ai_position.size()]
					if aiposition == 'melee' && i in [1,2,3]:
						temparray.append(i)
					if aiposition == 'ranged' && i in [4,5,6]:
						temparray.append(i)
				
				if temparray.size() <= 0:
					for i in combatparty:
						if combatparty[i] == null:
							temparray.append(i)
			else:
				#stupid way
				for i in combatparty:
					if combatparty[i] != null:
						temparray.append(i)
			
			
			if temparray.size() > 0:
				combatparty[temparray[randi()%temparray.size()]] = i.units
			i.number -= 1
	
	
	return combatparty

func finish_combat():
	input_handler.emit_signal("CombatEnded", get_combat_node().encountercode)
	input_handler.SetMusic("exploration")
	
	encounter_lose_scripts.clear()
	
	if encounter_win_script != null:
		state.common_effects(encounter_win_script)
#		var data = scenedata.scenedict[encounter_win_script]
#		interactive_message(encounter_win_script, data.default_event_type, {})
		encounter_win_script = null
		return
	if active_location.has('scriptedevents') && check_events("finish_combat") == true:
		yield(input_handler, 'EventFinished')
	if active_location.has('randomevents') && check_random_event() == true:
		yield(input_handler, 'EventFinished')
	
	exploration_node.finish_combat()


func combat_defeat():
	for i in active_location.group:
		if state.characters.has(active_location.group[i]) && state.characters[active_location.group[i]].hp <= 0:
			state.characters[active_location.group[i]].hp = 1
			state.characters[active_location.group[i]].defeated = false
			state.characters[active_location.group[i]].is_active = true
	
	get_dialogue_node().close()
	if exploration_node != null && active_location.has('progress'):
		exploration_node.enter_level(current_level)

func character_boss_defeat():
	var character_race = []
	var character_class = []
	var difficulty
	if active_location.affiliation == 'local':
		character_race.append([input_handler.weightedrandom(active_area.races), 1])
	if active_location.has("final_enemy_class"):
		for i in active_location.final_enemy_class:
			character_class.append([i, 1])
	
	character_race = input_handler.weightedrandom(character_race)
	character_class = input_handler.weightedrandom(character_class)
	difficulty = variables.power_adjustments_per_difficulty[active_location.difficulty]
	difficulty = rand_range(difficulty[0], difficulty[1])
	input_handler.interactive_message('character_boss_defeat', 'character_event', {characterdata = {type = 'raw',race = character_race, class = character_class, difficulty = difficulty, slave_type = 'slave'}})


func finish_quest_dungeon(args):
	interactive_message('finish_quest_dungeon', 'quest_finish_event', {locationname = active_location.name})

func finish_quest_location(args):
	interactive_message('finish_quest_location', 'quest_finish_event', {locationname = active_location.name})
	exploration_node.clear_dungeon_confirm()

func start_scene(scene):
	interactive_message(scene.code, 'event_selection', scene.args)

func load_image_from_path(path:String):
	if !(path.is_abs_path() or path.is_rel_path()): return null
#	if path.is_rel_path() and path.begins_with("res"):
#		return load(path)
	if !File.new().file_exists(path): return null
	var temp = Image.new()
	temp.load(path)
	var prew = ImageTexture.new()
	prew.create_from_image(temp)
	return prew

func load_sound_from_path(path:String): #not sure if works, needs testing
	if !(path.is_abs_path() or path.is_rel_path()): return null
#	if path.is_rel_path() and path.begins_with("res"):
#		return load(path)
	if !File.new().file_exists(path): return null
	
	if path.to_lower().ends_with(".ogg"):
		var temp = AudioStreamOGGVorbis.new()
		temp.load(path)
		return temp
	elif path.to_lower().ends_with(".wav"):
		var temp = AudioStreamSample.new()
		temp.load(path)
		return temp
	else: return null


func copy_dict(from:Dictionary, to:Dictionary):
	to.clear()
	for key in from: to[key] = from[key]

func select_value_in_OB(node, value):
	if !(node is OptionButton): return
	for i in range(node.get_item_count()):
		if node.get_item_text(i) == value:
			node.select(i)
			return
	node.select(0)

func get_value_node(node):
	if node is OptionButton:
		return node.get_item_text(node.selected)
	if node is ItemList:
		var tmp = node.get_selected_items()
		if node.select_mode == ItemList.SELECT_SINGLE:
			if tmp.size() == 0: return null
			return node.get_item_text(tmp[0])
		else:
			var res = []
			for i in tmp:
				res.push_back(node.get_item_text(i))
			return res
	if node is CheckBox: return node.pressed
	#node has text field
	if node.name == 'number': return float(node.text)
	if node.name == 'index': return int(node.text)
	if node.name == 'formula': return parse_json(node.text)
	return node.text

func meowingcondition(character):
	var allow = false
	if globals.globalsettings.meowing == true && character.checkreqs([{code = 'one_of_races', value = ['BeastkinCat','HalfkinCat']}]):
		allow = true
	return allow

func get_custom_text(data):
	return call(data)

var elect_support_dict = {
	servants_election_support = "You have support of Servants Guild",
	fighters_election_support = "You have support of Fighters Guild",
	workers_election_support = "You have support of Workers Guild",
	mages_election_support = "You have support of Mages Guild",
	
}

func election_quest_text():
	var text = ''
	var counter = 0
	for i in ['servants_election_support','fighters_election_support','workers_election_support','mages_election_support']:
		if state.decisions.has(i):
			counter += 1
			text += elect_support_dict[i] + "\n"
	
	text += "\nTotal support: " + str(counter) + "/3"
	
	return text

func lock_difficulty(value):
	var text = ''
	if value < 25:
		text = 'Very Easy'
	elif value < 45:
		text = 'Easy'
	elif value < 65:
		text = 'Medium'
	elif value < 85:
		text = "Hard"
	else:
		text = "Very Hard"
		
	return text
