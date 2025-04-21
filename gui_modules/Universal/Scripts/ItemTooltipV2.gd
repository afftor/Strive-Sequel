extends Panel

var parentnode
var shutoff = false
var prevnode
onready var iconnode = $IconFrame/Icon
onready var textnode = $InfoText

var currentdata
var currenttype
var mode = 'default'

func _process(delta):
	if weakref(parentnode).get_ref() == null || weakref(parentnode) == null:
		_hide()
		return
	if parentnode != null && (parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
		set_process(false)
		_hide()

func _input(event):
	if event.is_pressed():
		if event.is_action("shift"):
			mode = 'advanced'
			update()
	elif event.is_action_released("shift"):
		mode = 'default'
		update()

func _init():
	set_process(false)

func update():
	showup(parentnode, currentdata, currenttype)

func showup(node, data, type): #types material materialowned gear geartemplate
	if node == null:
		return
	parentnode = node
	currentdata = data
	currenttype = type

	var screen = get_viewport().get_visible_rect()
	if shutoff == true && prevnode == parentnode:
		return

	#$Image/amount.hide()
	iconnode.material = null
	#$type.text = ''
	match type:
		'material':
			material_tooltip(data)
		'materialowned':
			var workers_data = {}
			if node.has_meta("max_workers"):
				workers_data = {
					max = node.get_meta("max_workers"),
					current = node.get_meta("current_workers"),
				}
			if node.has_meta("gather_mod"):
				workers_data = {
					gather_mod = node.get_meta("gather_mod"),
				}
			material_tooltip(data, workers_data)
		'gear':
			if mode == 'default':
				gear_tooltip(data)
			elif mode == 'advanced':
				gear_detailed_tooltip(data)
		'geartemplate':
			geartemplete_tooltip(data)
	prevnode = parentnode

	input_handler.GetTweenNode(self).stop_all()
	self.modulate.a = 1

	show()

	var pos = node.get_global_rect()
	if node.has_meta("exploration"):
		pos = Vector2(pos.end.x + 10, pos.position.y - 30)
	else:
		pos = Vector2(pos.end.x + 10, pos.position.y)
	self.set_global_position(pos)

	$InfoText.rect_size.y = 125
	rect_size.y = 630

	yield(get_tree(), 'idle_frame')

	rect_size.y = max(630, $InfoText2.get_v_scroll().get_max() + 500)
	$InfoText2.rect_size.y = rect_size.y - 100


	if get_rect().end.x > screen.size.x:
		if node.has_meta("exploration") || type == "gear":
			pos = Vector2(pos.x - rect_size.x - node.rect_size.x - 10, pos.y)
			self.set_global_position(pos)
		else:
			rect_global_position.x -= screen.size.x - get_rect().end.x
	if get_rect().end.y > screen.size.y:
		rect_global_position.y -= get_rect().end.y - screen.size.y#node.get_global_rect().position.y - rect_size.y

	set_process(true)

func material_tooltip(data, workers_data = {}):
	var item = data.item
	var text = data.text
	$Title.text = item.name
	if ResourceScripts.game_res.materials.has(data.item) && ResourceScripts.game_res.materials[data.item] > 0:
		text += "\n\n" + tr("CURRENTLYINPOSSESSION") + ": " + str(ResourceScripts.game_res.materials[data.item])
	if workers_data.has("max"):
		text += "\nMax Workers: " + str(workers_data.max)
		text += "\nCurrent Workers: " + str(workers_data.current)
	if workers_data.has("gather_mod"):
		text += "\nGathering Mod: " + str(workers_data.gather_mod) + "%"
	iconnode.texture = item.icon
	$Cost/Label.text = str(item.price)
	$Cost.visible = int(item.price) != 0
	textnode.bbcode_text = globals.TextEncoder(text)
	#input_handler.RTLabel_height_fix(textnode) #for it is working wrong, we need to think some different approach
	$InfoText.show() #some materials have their descriptions longer than can be displayed properly - mb need to remake some part of this scene
	$InfoText2.hide()
	$InfoText3.hide()
#	$type.text = tr('MATERIALCATEGORY' + item.type.to_upper())

func materialowned_tooltip(data):
	material_tooltip(data)
	#$Image/amount.show()
	#$Image/amount.text = str(state.materials[data.item.code])


func gear_tooltip(data, item = null):
	if data.item.type == "usable":
		self.get_stylebox("panel", "" ).set_texture(load("res://assets/Textures_v2/DisassembleNewTooltip/panel_tooltip_shift.png"))
	else:
		self.get_stylebox("panel", "" ).set_texture(load("res://assets/Textures_v2/DisassembleNewTooltip/panel_tooltip.png"))
	$Title.text = data.title
	if item == null:
		item = data.item
	var text1 = item.tooltiptext_1()
	var text2 = item.tooltiptext_2()
	$Cost/Label.text = str(data.price)
	$Cost.visible = item.price != 0

	$HoldShift.visible = item.get('partcolororder') != null
	if item.get('partcolororder') != null:
		input_handler.itemshadeimage(iconnode, item)
	else:
		iconnode.texture = input_handler.loadimage(item.icon, 'icons')

	$InfoText.bbcode_text = text1
	$InfoText2.bbcode_text = text2

	$InfoText.show()
	$InfoText2.show()
	$InfoText3.hide()


func gear_detailed_tooltip(data1, item = null):
	gear_tooltip(data1, item)
	item = data1.item
	if item.parts.size() == 0:
		return
	$Title.text = data1.item.name
	var text = ''
	for i in item.parts:
		var material = Items.materiallist[item.parts[i]]
		text += tr(Items.Parts[i].name) + ": {color=yellow|" + material.name +"}"
		text += globals.build_desc_for_bonusstats(material.parts[i])
		text += '\n\n'
#		for k in material.parts[i]:
#			text += "\n" + Items.stats[k] + " " + str(material.parts[i][k])
	$InfoText3.bbcode_text = globals.TextEncoder(text)
	$InfoText.hide()
	$InfoText2.hide()
	$InfoText3.show()
	get_stylebox("panel", "" ).set_texture(load("res://assets/Textures_v2/DisassembleNewTooltip/panel_tooltip_shift.png"))

func geartemplete_tooltip(data1):
	var item = data1.item
	var text = '[center]' + item.name + '[/center]\n'

	if item.has('geartype'):
		text += tr('TYPE_LABEL') + ': ' + item.geartype + "\n"
		if item.slots.size() > 0:
			text += tr("SLOTS_LABEL") + ": "
			for i in item.slots:
				text += tr("ITEMSLOT"+i.to_upper()) + ", "
			text = text.substr(0, text.length() -2) + ". \n"
	else:
		text += tr("TYPE_USABLE_LABEL") + "\n"

	text += item.descript

	if item.itemtype in ['armor','weapon','tool']:
		text += "\n\n"
		text += globals.build_desc_for_bonusstats(item.basestats)


	for i in item.effects:
		text += "\n" + tr(Effectdata.effect_table[i].descript)
	
	iconnode.texture = item.icon
	$Cost/Label.text = str(data1.price)



#	if data.item.slots.size() == 1:
#		$type.text += tr("ITEMSLOT" + data.item.slots[0].to_upper())
#	elif data.item.slots.size() > 1:
#		$type.text += 'Multislot'
#	else:
#		$type.text = tr("USABLE")
	if item.get('partcolororder') != null:
		input_handler.itemshadeimage(iconnode, item)

		text += "\n\n{color=yellow|" + tr("INFOHOLDSHIFT") + "}"
	textnode.bbcode_text = globals.TextEncoder(text)


func cooldown():
	shutoff = true
	yield(get_tree().create_timer(0.2), 'timeout')
	shutoff = false

func _hide():
	parentnode = null
	set_process(false)
	ResourceScripts.core_animations.FadeAnimation(self, 0.2)
	hide()

