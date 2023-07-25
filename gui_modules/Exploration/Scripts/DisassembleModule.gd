extends Control
var itemcontainer
var materials_container
onready var rng = RandomNumberGenerator.new()


func _ready():
	itemcontainer = $Background/ItemList/VBoxContainer
	materials_container = $ItemInfo/ScrollContainer/VBoxContainer
	$NumberSelection/Button.connect('pressed', self, "confirm_number_selection")
	$NumberSelection/HSlider.connect("value_changed", self, "change_number_selection")
	$ItemInfo/InfoClose.connect("pressed", self, "_close", ["info"])
	$Background/DisassambleClose.connect("pressed", self, "_close", ["all"])
	rng.randomize()


func open():
	build_list()




func _close(what):
	if what == "info":
		$ItemInfo.hide()
	elif what == "all":
		self.hide()
	for button in itemcontainer.get_children():
		if !button.has_meta("item"):
			continue
		button.pressed = false
	build_list()



func change_number_selection(value):
	$NumberSelection/ItemAmount.text = "x " + str($NumberSelection/HSlider.value)
	$NumberSelection/Cost.text = str(round(selected_result_item.parts[selected_part] * 0.75 * value), '-', (selected_result_item.parts[selected_part] * value))

var item_to_disassamble
func confirm_number_selection():
	var item = item_to_disassamble
#	for i in ResourceScripts.game_res.items.values():
#		if i.itembase == selected_result_item.code:
#			item = i
#			break
#	item_to_disassamble = item
	var message = str("Disassamble ", selected_result_item.name, '?\n', \
						"You'll get between ", \
						round(selected_result_item.parts[selected_part] * 0.75 * $NumberSelection/HSlider.value), \
						" and ", \
						(selected_result_item.parts[selected_part] * $NumberSelection/HSlider.value), \
						" of ", \
						Items.materiallist[item.parts[selected_part]].name, \
						".")
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'disassamble', tr(message)])


func disassamble():
	_close("info")
	var ratio = rng.randf_range(0.75, 1.0)
	var final_amount = round(selected_result_item.parts[selected_part] * ratio * $NumberSelection/HSlider.value)
	var material = item_to_disassamble.parts[selected_part]
	var loot_window = input_handler.get_spec_node(input_handler.NODE_LOOTTABLE)
	var message = str("You've got ", final_amount, " of ", Items.materiallist[item_to_disassamble.parts[selected_part]].name, " after disassamble.")
	var data = {
		materials = {},
		items = {}
	}
	data.materials[material] = final_amount
	loot_window.open(data, message)
	ResourceScripts.game_res.items[item_to_disassamble.id].amount -= $NumberSelection/HSlider.value
	build_list()



func build_list():
	$NumberSelection.hide()
	input_handler.ClearContainer(itemcontainer)
	for i in ResourceScripts.game_res.items.values():
		if i.materials == []:
			continue
		if i.amount == 0:
			continue
		if i.owner != null:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate(itemcontainer)
		newbutton.get_node("Title").text = i.name
		i.set_icon(newbutton.get_node("Icon"))
		var amount = ResourceScripts.custom_text.transform_number(i.amount)
		newbutton.get_node("Amount").text = amount
		newbutton.get_node("Cost").text = str(i.calculateprice())
		newbutton.set_meta("item", i)
		newbutton.connect("pressed", self, "show_item_info", [i, int(amount)])
		var data = {text = i.tooltiptext(), icon = input_handler.loadimage(i.icon, 'icons'), item = i, price = str(i.calculateprice())}
		newbutton.connect('mouse_entered', self, 'showup', [newbutton, data, "gear"])


func disconnect_tooltips():
	for button in itemcontainer.get_children():
		if button.name == "Button":
			continue
		if button.is_connected("mouse_entered", self, 'showup'):
			button.disconnect("mouse_entered",self, 'showup')


func show_item_info(item, amount):
	for button in itemcontainer.get_children():
		if !button.has_meta("item"):
			continue
		button.pressed = button.get_meta("item") == item
	hide_tooltip()
	disconnect_tooltips()
	$ItemTooltipV2.hide()
	$ItemInfo.show()
	$NumberSelection.hide()
	selected_result_item = null
	selected_part = null
	input_handler.ClearContainer(materials_container)
	item.set_icon($ItemInfo/IconFrame/Icon)
	globals.connectitemtooltip_v2($ItemInfo/IconFrame/Icon, item)
	$ItemInfo/Title.text = item.name
	item_to_disassamble = item
	for p in item.parts:
		var part = item.parts[p]
		var newbutton = input_handler.DuplicateContainerTemplate(materials_container)
		newbutton.get_node("Icon").texture = Items.materiallist[part].icon
		newbutton.get_node("Title").text = Items.materiallist[part].name
		newbutton.get_node("Cost").text = str(get_part_cost(item, p))
		newbutton.connect("pressed", self, "select_material", [Items.materiallist[part].icon, amount, p])

var selected_part
var selected_result_item

func select_material(icon, maxvalue, part):
	selected_part = part
	$NumberSelection.show()
	$NumberSelection/MaterialIcon.texture = icon
	$NumberSelection/HSlider.value = 1
	$NumberSelection/HSlider.min_value = 0
	$NumberSelection/HSlider.max_value = maxvalue
	change_number_selection($NumberSelection/HSlider.value)





func get_part_cost(item, part):
	var result_item = Items.itemlist[item.itembase]
	selected_result_item = result_item
	return str(round(result_item.parts[part] * 0.75), '-', result_item.parts[part])


#Tooltip

var parentnode
var shutoff = false
var prevnode
onready var iconnode = $ItemTooltipV2/IconFrame/Icon
onready var textnode = $ItemTooltipV2/InfoText
onready var textnode2 = $ItemTooltipV2/InfoText2
onready var textnode3 = $ItemTooltipV2/InfoText3

var currentdata
var currenttype
var mode = 'default'




func _process(delta):
	if weakref(parentnode).get_ref() == null || weakref(parentnode) == null:
		hide_tooltip()
		return
	if parentnode != null && (parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
		set_process(false)
		hide_tooltip()




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
		'gear':
			if mode == 'default':
				gear_tooltip(data)
			elif mode == 'advanced':
				gear_detailed_tooltip(data)
		'geartemplate':
			geartemplete_tooltip(data)
	prevnode = parentnode

	input_handler.GetTweenNode($ItemTooltipV2).stop_all()
	$ItemTooltipV2.modulate.a = 1

	$ItemTooltipV2.show()
	yield(get_tree(), 'idle_frame')
	set_process(true)





func gear_tooltip(data, item = null):
	$ItemTooltipV2.get_stylebox("panel", "" ).set_texture(load("res://assets/Textures_v2/DisassembleNewTooltip/panel_tooltip.png"))
	textnode.show()
	textnode2.show()
	textnode3.hide()
#	$ItemTooltipV2.texture = load("res://assets/Textures_v2/DisassembleNewTooltip/panel_tooltip.png")
	if item == null:
		item = data.item
	$ItemTooltipV2/Title.text = item.name
	var font = input_handler.font_size_calculator($ItemTooltipV2/Title)
	$ItemTooltipV2/Title.set("custom_fonts/font", font)
	var text = item.tooltiptext_light()
	$ItemTooltipV2/Cost/Label.text = str(data.price)
	$ItemTooltipV2/Cost.visible = item.price != 0

	if item.get('partcolororder') != null:
		input_handler.itemshadeimage(iconnode, item)
		# text += "\n\n[color=yellow]Hold shift for details[/color]"
	else:
		iconnode.texture = input_handler.loadimage(item.icon, 'icons')

	textnode.bbcode_text = item.description
	textnode2.bbcode_text = text
	textnode2.bbcode_text += '\n\n\n'
	yield(get_tree(), 'idle_frame')
	if textnode2.get_v_scroll().get_max() > 296:
		$ItemTooltipV2.rect_size.y = 630 + textnode2.get_v_scroll().get_max() - 280
	else:
		$ItemTooltipV2.rect_size.y = 630

func gear_detailed_tooltip(data, item = null):
	gear_tooltip(data, item)
	$ItemTooltipV2.get_stylebox("panel", "" ).set_texture(load("res://assets/Textures_v2/DisassembleNewTooltip/panel_tooltip_shift.png"))
	textnode.hide()
	textnode2.hide()
	textnode3.show()
	item = data.item
	if item.parts.size() == 0:
		return
	var text = ''

	if item.geartype != null:
		text += tr('TYPE_LABEL' + ': ') + item.geartype + "\n"
	else:
		text += tr("TYPE_USABLE_LABEL" + "\n")

	if item.slots.size() > 0:
		text += tr("SLOTS_LABEL" + ": ")
		for i in item.slots:
			text += tr("ITEMSLOT"+i.to_upper()) + ", "
		text = text.substr(0, text.length() -2)

	if item.toolcategory != null:
		text += tr("TOOLWORKCATEGORY") + ": "
		for i in item.toolcategory:
			text += statdata.worktoolnames[i] +", "
		text = text.substr(0, text.length()-2)
	if item.description != null:
		text += item.description
	if !item.reqs.empty():
		var tempslave = ResourceScripts.scriptdict.class_slave.new("temp_tooltip_disassemble")
		text += "\n" + tempslave.decipher_reqs(item.reqs)
	if item.itemtype == 'usable':
		text += '\n' + tr("INPOSESSION") + ': ' + str(item.amount)
	for i in item.parts:
		var material = Items.materiallist[item.parts[i]]
		text += '\n' + tr(Items.Parts[i].name) + ": {color=yellow|" + material.name +"}"
		for k in material.parts[i]:
			if material.parts[i][k] != 0:
				var value = material.parts[i][k]
				var change = ''
				if k in ['hpmod', 'manamod','task_energy_tool', 'task_efficiency_tool']:
					value = value*100
				text += '\n' + statdata.statdata[k].name + ': {color='
				if value > 0:
					change = '+'
					text += 'green|' + change
				else:
					text += 'red|'
				value = str(value)
				if k in ['hpmod', 'manamod','task_energy_tool', 'task_efficiency_tool']:
					value = value + '%'
				text += value + '}'
	textnode3.bbcode_text = globals.TextEncoder(text)

func geartemplete_tooltip(data):
	var item = data.item
	var text = '[center]' + item.name + '[/center]\n'

	if item.has('geartype'):
		text += tr('TYPE_LABEL' + ': ') + item.geartype + "\n"
		if item.slots.size() > 0:
			text += tr("SLOTS_LABEL" + ": ")
			for i in item.slots:
				text += tr("ITEMSLOT"+i.to_upper()) + ", "
			text = text.substr(0, text.length() -2) + ". \n"
	else:
		text += tr("TYPE_USABLE_LABEL" + "\n")

	text += item.descript

	if item.itemtype in ['armor','weapon','tool']:
		text += "\n\n"
		for i in item.basestats:
			if item.basestats[i] != 0:
				var value = item.basestats[i]
				var change = ''
				if statdata.statdata[i].percent:
					value = value*100
				text += statdata.statdata[i].name + ': {color='#" " +Items.stats[i] +
				if value > 0:
					change = '+'
					text += 'green|' + change
				else:
					text += 'red|'
				value = str(value)
				if statdata.statdata[i].percent:
					value = value + '%'
				text += value + '}\n'


	for i in item.effects:
		text += Effectdata.effect_table[i].descript + "\n"

	iconnode.texture = item.icon
	$Cost/Label.text = str(data.price)
	if item.get('partcolororder') != null:
		input_handler.itemshadeimage(iconnode, item)

		text += tr("\n\n{color=yellow|" + "INFOHOLDSHIFT" + "}")
	textnode.bbcode_text = globals.TextEncoder(text)


func cooldown():
	shutoff = true
	yield(get_tree().create_timer(0.2), 'timeout')
	shutoff = false

func hide_tooltip():
	parentnode = null
	set_process(false)
	ResourceScripts.core_animations.FadeAnimation($ItemTooltipV2, 0.2)
