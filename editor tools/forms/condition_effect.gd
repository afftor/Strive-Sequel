extends "res://editor tools/classes/record_panel.gd"

var stat
var id
var newrec = true

onready var typesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/type
onready var descedit = $MarginContainer/VBoxContainer/HBoxContainer/desc_panel/VBoxContainer/desc

var condtypes = ['random', 'skill', 'character']
var chartypes = ['caster', 'target', 'owner']


func _init():
	tres = {comment = ""}
	panel_data = [
		{
			type = editor_core.PANEL_OPTION,
			stat = 'stat',
			container = 0,
			groups = ['skill'],
			rlist = variables.skill_condstats,
			dlist = variables.skill_condstats,
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'type',
			container = 0,
			groups = ['character'],
			rlist = chartypes,
			dlist = chartypes,
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'op',
			container = 0,
			groups = ['skill'],
			rlist = variables.real_ops,
			dlist = variables.ops,
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'value',
			container = 0,
			groups = ['random', 'skill'],
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'value',
			container = 0,
			groups = ['character'],
			script = "res://editor tools/panels/char_cond.gd"
		},
		
	]



func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	prew_node = $MarginContainer/VBoxContainer/Label
	build_panels()
	descedit.connect("text_entered", self, 'change_description')
	select_code('has_money')
	key = null

func build_panels():
	for type in condtypes:
		typesel.add_item(type)
	.build_panels()

func get_data(dir = null):
	var data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	select_code(data.code)
	key = null
	if data.code == 'skill':
		data.stat = data.value[0]
		data.op = data.value[1]
		data.value = data.value[2]
	.get_data(data)

func update_res():
	.update_res()
	if tres.type == 'character': tres.erase('type')
	if tres.type == 'skill': 
		tres.value = [tres.stat, tres.op, tres.value]
		tres.erase('stat')
		tres.erase('op')
	prew_node.text = editor_core.display_res(tres, key)

func commit():
	tres = parse_json(prew_node.text)
	if tres == null: return
	if tres.type == 'character': return
	if tres.has('comment') and tres.comment == "": tres.erase('comment')
	if newrec:
		parent.tres.push_back(tres)
	else:
		parent.tres[id] = tres
	parent.update_val()
	.commit()

func select_code(code):
	tres.clear()
	tres.type = code
	for pan in panel_nodes:
		if pan.is_in_group(code): pan.visible = true
		else: pan.visible = false

func select_type(id):
	select_code(condtypes[id])
	update_res()

func change_description(newtext):
	tres.comment = newtext
	if newtext == "": tres.erase('comment')
	update_res()
