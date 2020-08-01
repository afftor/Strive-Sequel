extends "res://editor tools/classes/record_panel.gd"

var stat
var id
var newrec = true

onready var typesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/type
onready var descedit = $MarginContainer/VBoxContainer/HBoxContainer/desc_panel/VBoxContainer/desc

var condtypes = ['sextrait', 'tag', 'stat']
var types_desc = ['sextrait', 'tag', 'stat']
var op1 = ['add']
var op2 = ['remove']
var op3 = ['+', '-']


func _init():
	tres = {description = ""}
	panel_data = [
		{
			type = editor_core.PANEL_OPTION,
			stat = 'code',
			container = 0,
			groups = ['stat'],
			rlist = ['hp', 'mp', 'shield', 'base_exp'] + Statlist_init.template.keys(),
			dlist = ['hp', 'mp', 'shield', 'base_exp'] + Statlist_init.template.keys(),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'operant',
			container = 0,
			groups = ['sextrait'],
			rlist = op1,
			dlist = op1,
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'operant',
			container = 0,
			groups = ['tag'],
			rlist = op2,
			dlist = op2,
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'operant',
			container = 0,
			groups = ['stat'],
			rlist = op3,
			dlist = op3,
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'value',
			container = 0,
			groups = ['sextrait', 'tag', 'stat'],
		},
	]

func change_description(newtext):
	tres.description = newtext
	if newtext == "": tres.erase('description')
	update_res()

func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	prew_node = $MarginContainer/VBoxContainer/Label
	descedit.connect("text_entered", self, 'change_description')
	build_panels()
	key = null
	select_code('sextrait')


func build_panels():
	for type in types_desc:
		typesel.add_item(type)
	.build_panels()

func get_data(dir = null):
	var data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	select_code(data.code)
	if data.has('description'): descedit.text = data.description
	key = null
	.get_data(data)

func commit():
	tres = parse_json(prew_node.text)
	if tres == null: return
	if tres.has('description') and tres.description == "": tres.erase('description')
	if newrec:
		parent.tres.push_back(tres)
	else:
		parent.tres[id] = tres
	parent.update_val()
	.commit()

func select_code(code):
	tres.clear()
	tres.code = code
	for pan in panel_nodes:
		if pan.is_in_group(code): pan.visible = true
		else: pan.visible = false
	update_res()

func select_type(id):
	select_code(condtypes[id])
