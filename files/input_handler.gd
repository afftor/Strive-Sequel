extends Node

#This script handles inputs, sounds, closes windows and plays animation
#warning-ignore-all:unused_signal

var CloseableWindowsArray = []
var ShakingNodes = []
var MousePositionScripts = []

var CurrentScreen = 'Town'

var BeingAnimated = []
var SystemMessageNode

var text_field_input = false

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

var last_action_data = {}

var slave_panel_node = preload("res://src/scenes/SlavePanel.tscn")
var slave_list_node
var scene_character
var scene_loot
var active_area
var active_location

var activated_skill
var target_character

func _input(event):
	if event.is_echo() == true || event.is_pressed() == false :
		return
	if event.is_action("ESC") && event.is_pressed():
		if CloseableWindowsArray.size() != 0:
			CloseTopWindow()
		else:
			if globals.CurrentScene.name == 'MainScreen':
				globals.CurrentScene.openmenu()
	if event.is_action("F9") && event.is_pressed():
		OS.window_fullscreen = !OS.window_fullscreen
		globals.globalsettings.fullscreen = OS.window_fullscreen
		if globals.globalsettings.fullscreen == false:
			OS.window_position = Vector2(0,0)
	
	
	if CurrentScreen == 'Town' && str(event.as_text().replace("Kp ",'')) in str(range(1,9)) && CloseableWindowsArray.size() == 0 && text_field_input == false:
		if str(int(event.as_text())) in str(range(1,4)):
			globals.CurrentScene.changespeed(globals.CurrentScene.timebuttons[int(event.as_text())-1])

var musicfading = false
var musicraising = false
var musicvalue

func _process(delta):
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


func CloseTopWindow():
	var node = CloseableWindowsArray.back()
	if typeof(node) == TYPE_STRING:
		return;
	node.hide()
	CloseableWindowsArray.pop_back(); #i think this is required

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

func StartCharacterCreation(mode):
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

func GetTextTooltip():
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

func GetItemTooltip():
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

func GetSkillTooltip():
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

func GetSlaveTooltip():
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

func GetTextEditNode():
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

func GetTweenNode(node):
	var tweennode
	if node.has_node('tween'):
		tweennode = node.get_node('tween')
	else:
		tweennode = Tween.new()
		tweennode.name = 'tween'
		node.add_child(tweennode)
	return tweennode

func GetRepeatTweenNode(node):
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


func FloatText(node, text, type = '', color = Color(1,1,1), time = 3, fadetime = 0.5, positionoffset = Vector2(0,0)):
	var textnode = Label.new()
	get_tree().get_root().add_child(textnode)
	textnode.text = text
	textnode.rect_global_position = node.rect_global_position+positionoffset
	textnode.set("custom_colors/font_color", color)
	textnode.set("custom_colors/font_color_shadow", Color(0,0,0))
	floatfont.size = 50
	textnode.set("custom_fonts/font", floatfont)
	match type:
		'damageenemy':
			DamageTextFly(textnode, false)
		'damageally':
			DamageTextFly(textnode, true)
		'miss':
			FadeAnimation(textnode, fadetime, time)
		"heal":
			HealTextFly(textnode)
	#FadeAnimation(textnode, fadetime, time)
	var wr = weakref(textnode)
	yield(get_tree().create_timer(time+1), 'timeout')
	if wr.get_ref(): textnode.queue_free()

func DamageTextFly(node, reverse = false):
	var tween = GetTweenNode(node)
	var firstvector = Vector2(100, -100)
	var secondvector = Vector2(200, 200)
	if reverse == true:
		firstvector = Vector2(-100, -100)
		secondvector = Vector2(-200, 200)
	yield(get_tree().create_timer(0.5), 'timeout')
	tween.interpolate_property(node, 'rect_position', node.rect_position, node.rect_position+firstvector, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(node, 'rect_position', node.rect_position+firstvector, node.rect_position+secondvector, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.3)
	FadeAnimation(node, 0.2 , 0.7)
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

func SetMusic(name, delay = 0):
	yield(get_tree().create_timer(delay), 'timeout')
	musicraising = true
	var musicnode = GetMusicNode()
	if musicnode.stream == audio.music[name]:
		return
	musicnode.stream = audio.music[name]
	musicnode.play(0)

func StopMusic(instant = false):
	musicfading = true

func GetMusicNode():
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
	var soundnode = GetSoundNode()
	soundnode.stream = audio.sounds[name]
	soundnode.seek(0)
	soundnode.play(0)
	yield(soundnode, 'finished')
	soundnode.queue_free()

var soundcooldown = 0

func PlaySoundIsolated(sound, cooldown):
	if soundcooldown > 0:
		return
	PlaySound(sound)
	soundcooldown = cooldown

func GetSoundNode():
	var node = get_tree().get_root()
	var soudnnode = AudioStreamPlayer.new()
	soudnnode.bus = 'Sound'
	node.add_child(soudnnode)
	return soudnnode

func GetEventNode():
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

func GetSkillSelectNode():
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

func ShowSkillSelectPanel(person, type, TargetNode, TargetFunction):
	var node = GetSkillSelectNode()
	node.open(person, type, TargetNode, TargetFunction)

func GetSlaveSelectNode():
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

func ShowSlaveSelectPanel(TargetNode, TargetFunction, reqs):
	var node = GetSlaveSelectNode()
	node.open(TargetNode, TargetFunction, reqs)

func ShowConfirmPanel(TargetNode, TargetFunction, Text):
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


func CloseAnimation(node):
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
	#globals.hidetooltip()
	#globals.call_deferred('EventCheck');

func OpenAnimation(node):
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
	#globals.call_deferred('EventCheck');

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


func gfx(node, effect, fadeduration = 0.5, delayuntilfade = 0.3, rotate = false):
	var x = TextureRect.new()
	x.texture = images.GFX[effect]
	x.expand = true
	x.stretch_mode = 6
	node.add_child(x)
	
	x.rect_size = node.rect_size
	
	if rotate == true:
		x.rect_pivot_offset = images.GFX[effect].get_size()/2
		x.rect_rotation = rand_range(0,360)
	
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
	
func weightedrandom(array): #array must be made out of dictionaries with {value = name, weight = number} Number is relative to other elements which may appear
#alternative option is to use array of arrays of format [value, weight]
	var total = 0
	var counter = 0
	for i in array:
		if typeof(i) == TYPE_DICTIONARY:
			total += i.weight
		else:
			total += i[1]
	var random = rand_range(0,total)
	for i in array:
		if typeof(i) == TYPE_DICTIONARY:
			if counter + i.weight >= random:
				return i #!!
			counter += i.weight
		else:
			if counter + i[1] >= random:
				return i[0] # strangely, array version returns value directly, while dict version returnt full dictionary
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
#warning-ignore:return_value_discarded
	OS.shell_open(path)

func SystemMessage(text, time = 4):
	var basetime = time
	if SystemMessageNode == null:
		return
	text = '[center]' + tr(text) + '[/center]'
	SystemMessageNode.modulate.a = 1
	SystemMessageNode.bbcode_text = text
	FadeAnimation(SystemMessageNode, 1, basetime)

func GetTutorialNode():
	var node = get_tree().get_root()
	if node.has_node("MainScreen"):
		node = node.get_node("MainScreen")
	var tutnode
	if node.has_node('TutorialNode'):
		tutnode = node.get_node('TutorialNode')
		node.remove_child(tutnode)
	else:
		tutnode = load("res://src/Tutorial.tscn").instance()
		tutnode.name = 'TutorialNode'
	node.add_child(tutnode)
	return tutnode

func ActivateTutorial(stage = 'tutorial1'):
	var node = GetTutorialNode()
	node.activatetutorial(stage)

func ShowGameTip(tip):
	if globals.globalsettings.disabletips == true || state.viewed_tips.has(tip):
		return
	var node = get_tree().get_root()
	var tipnode
	if node.has_node("GameTips"):
		tipnode = node.get_node("GameTips")
		node.remove_child(tipnode)
	else:
		tipnode = load("res://src/GameplayTips.tscn").instance()
		tipnode.name = "GameTips"
	node.add_child(tipnode)
	tipnode.showtip(tip)

func ShowOutline(node):
	node.material = load('res://files/portret_shader.tres').duplicate()
	node.material.set_shader_param('opacity', 1)

func HideOutline(node):
	node.material.set_shader_param('opacity', 0)

func ConnectSound(node, sound, action):
	node.connect(action, input_handler, 'PlaySound', [sound])

#Slave Panel

func ShowSlavePanel(person):
	var node = get_tree().get_root()
	slave_panel_node.get_parent().remove_child(slave_panel_node)
	node.add_child(slave_panel_node)
	slave_panel_node.open(person)

#Inventory

func ShowInentory(args):
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

func calculate_number_from_string_array(array, caster, target):
	var endvalue = 0
	var firstrun = true
	for i in array:
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
		if !modvalue[0].is_valid_float():
			if modvalue[0] == '-' && firstrun == true:
				endvalue += float(modvalue)
			else:
				endvalue = input_handler.string_to_math(endvalue, modvalue)
		else:
			endvalue += float(modvalue)
		firstrun = false
	return endvalue

func get_dialogue_node():
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

func interactive_message(code, type, args):
	var data = scenedata.scenedict[code].duplicate(true)
	var scene = get_dialogue_node()
	match type:
		'social_skill':
			for i in variables.dynamic_text_vars:
				data.text = data.text.replace("[" + i + '1' + ']', "[" + i + "]")
			data.text = args.name1.translate(data.text)
			for i in variables.dynamic_text_vars:
				data.text = data.text.replace("[" + i + '2' + ']', "[" + i + "]")
			data.text = args.name2.translate(data.text)
			if args.has("bonustext"):
				data.text += args.bonustext
			if args.has('repeat'):
				data.options.append({code ='repeat', text = tr('DIALOGUEREPEATACTION'), disabled = !args.repeat})
		'char_translate':
			data.text = args.translate(data.text)
		'character_event':
			var newcharacter
			match args.characterdata.type:
				'raw':
					newcharacter = Slave.new()
					newcharacter.generate_random_character_from_data(args.characterdata.race, args.characterdata.class, args.characterdata.difficulty)
				'function':
					newcharacter = call(args.characterdata.function, args.characterdata.args)
			scene_character = newcharacter
			data.text = newcharacter.translate(data.text)
			data.options.push_front({code = 'inspect_scene_character', text = tr("DIALOGUECHARINSPECT")})
		'quest_finish_event':
			data.text = data.text.replace("[dungeonname]", args.locationname)
		'childbirth':
			scene_character = args.pregchar
			var baby = state.babies[scene_character.pregnancy.baby]
			data.options.append({code = 'inspect_character_child', text = tr("DIALOGUEINSPECTBABY")})
		'event_selection':
			data.location = active_location
		'loot':
			var loot
			match args.loot_data.type:
				'function':
					loot = call(args.loot_data.function, args.loot_data.args)
			scene_loot = world_gen.make_chest_loot(loot)
		'area_oneshot_event':
			for i in active_area.events:
				if i.code == code:
					active_area.events.erase(i)
					break
	scene.open(data)

func interactive_message_custom(data):
	var scene = get_dialogue_node()
	scene.open(data)


func make_location_chest_loot(args):
	var lootdict = {}
	
	return lootdict

func repeat_social_skill():
	if last_action_data.code == 'social_skill':
		last_action_data.caster.use_social_skill(last_action_data.skill,last_action_data.target)

func make_local_recruit(args):
	var newchar = Slave.new()
	newchar.generate_random_character_from_data(active_location.races)
	return newchar

func update_slave_list():
	slave_list_node.update()

func update_slave_panel():
	if slave_panel_node.visible == true:
		slave_panel_node.open(null)

func check_mouse_in_nodes(nodes):
	var check = false
	for i in nodes:
		if i.get_global_rect().has_point(globals.CurrentScene.get_global_mouse_position()):
			check = true
	return check

func text_cut_excessive_lines(text:String):
	while text.ends_with(" ") || text.ends_with("\n"):
		text.erase(text.length()-1, text.length())
	return text
