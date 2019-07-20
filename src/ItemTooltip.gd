extends Panel

var parentnode
var shutoff = false
var prevnode
onready var iconnode = $Image
onready var textnode = $RichTextLabel

var currentdata
var currenttype
var mode = 'default'

func _process(delta):
	if parentnode != null && ( parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
		set_process(false)
		hide()

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
	
	$Image/amount.hide()
	iconnode.material = null
	$type.text = ''
	
	match type:
		'material':
			material_tooltip(data)
		'materialowned':
			materialowned_tooltip(data)
		'gear':
			if mode == 'default':
				gear_tooltip(data)
			elif mode == 'advanced':
				geat_detailed_tooltip(data)
		'geartemplate':
			geartemplete_tooltip(data)
	prevnode = parentnode
	
	input_handler.GetTweenNode(self).stop_all()
	self.modulate.a = 1
	
	show()
	
	var pos = node.get_global_rect()
	pos = Vector2(pos.position.x, pos.end.y + 10)
	self.set_global_position(pos)
	
	
	if get_rect().end.x > screen.size.x:
		rect_global_position.x -= get_rect().end.x - screen.size.x
	if get_rect().end.y > screen.size.y:
		rect_global_position.y -= get_rect().end.y - screen.size.y
	
	set_process(true)

func material_tooltip(data):
	var item = data.item
	var text = '[center]' + item.name + '[/center]\n' + item.descript
	if state.materials.has(data.item) && state.materials[data.item] > 0:
		text += "\n\n" + tr("CURRENTLYINPOSSESSION") + ": " + str(state.materials[data.item])
	iconnode.texture = item.icon
	$Cost/Label.text = str(item.price)
	$Cost.visible = int(item.price) != 0
	textnode.bbcode_text = text
	$type.text = tr('MATERIALCATEGORY' + item.type.to_upper())

func materialowned_tooltip(data):
	material_tooltip(data)
	$Image/amount.show()
	$Image/amount.text = str(state.materials[data.item.code])


func gear_tooltip(data, item = null):
	if item == null:
		item = data.item
	var text = item.tooltiptext()
	$Cost/Label.text = str(data.price)
	$Cost.visible = item.price != 0
	if item.geartype == null:
		$type.text = tr("USABLE")
	else:
		$type.text = item.geartype + ":"
	if data.item.slots.size() == 1:
		$type.text += tr("ITEMSLOT" + data.item.slots[0].to_upper())
	elif data.item.slots.size() > 1:
		$type.text += 'Multislot'
	if item.get('partcolororder') != null:
		input_handler.itemshadeimage(iconnode, item)
	else:
		iconnode.texture = load(item.icon)
	textnode.bbcode_text = text

func geat_detailed_tooltip(data, item = null):
	gear_tooltip(data, item)
	item = data.item
	if item.parts.size() == 0:
		return
	var text = '[center]'+data.item.name+'[/center]'
	for i in item.parts:
		var material = Items.materiallist[item.parts[i]]
		text += "\n" + Items.Parts[i].name + ": " + material.name 
		for k in material.parts[i]:
			if material.parts[i][k] != 0:
				var value = material.parts[i][k]
				var change = ''
				if k in ['hpmod', 'manamod','task_energy_tool', 'task_efficiency_tool']:
					value = value*100
				text += '\n' + Items.stats[k] + ': {color='
				if value > 0:
					change = '+'
					text += 'green|'
				else:
					text += 'red|'
				value = str(value)
				if k in ['hpmod', 'manamod','task_energy_tool', 'task_efficiency_tool']:
					value = change + value + '%'
				text += value + '}\n'
#		for k in material.parts[i]:
#			text += "\n" + Items.stats[k] + " " + str(material.parts[i][k])
	textnode.bbcode_text = globals.TextEncoder(text)

func geartemplete_tooltip(data):
	var item = data.item
	var text = '[center]' + item.name + '[/center]\n' + item.descript
	
	iconnode.texture = item.icon
	if data.item.slots.size() == 1:
		$type.text += tr("ITEMSLOT" + data.item.slots[0].to_upper())
	elif data.item.slots.size() > 1:
		$type.text += 'Multislot'
	else:
		$type.text = tr("USABLE")
	if item.get('partcolororder') != null:
		input_handler.itemshadeimage(iconnode, item)
	textnode.bbcode_text = text
	

func cooldown():
	shutoff = true
	yield(get_tree().create_timer(0.2), 'timeout')
	shutoff = false

func hide():
	parentnode = null
	set_process(false)
	input_handler.FadeAnimation(self, 0.2)