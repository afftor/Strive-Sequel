extends "res://editor tools/classes/record_panel.gd"


onready var codeedit = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/codeedit
onready var typesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/type
onready var descedit = $MarginContainer/VBoxContainer/HBoxContainer/desc_panel/VBoxContainer/desc

var code = null

var id
var newrec = true


func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_OPTION,
			stat = 'target',
			container = 0,
			groups = variables.effecttypes,
			rlist = variables.targetlist,
			dlist = variables.targetlist
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'trigger',
			container = 0,
			groups = ['trigger'],
			rlist = variables.eventhelp,
			dlist = variables.eventdesc
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'reset',
			container = 0,
			groups = ['trigger'],
			rlist = variables.eventhelp,
			dlist = variables.eventdesc
		},
		{
			type = editor_core.PANEL_CUSTOM,
			stat = 'tags',
			container = 1,
			groups = variables.effecttypes,
			scene = "res://editor tools/panels/tags_panel.tscn"
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'name',
			container = 0,
			groups = ['temp_s','temp_p','temp_u'],
		},
		{
			type = editor_core.PANEL_INT,
			stat = 'duration',
			container = 0,
			groups = ['temp_s','temp_p','temp_u'],
		},
		{
			type = editor_core.PANEL_INT,
			stat = 'stack',
			container = 0,
			groups = ['temp_s','temp_p','temp_u'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'next_level',
			container = 0,
			groups = ['temp_p','temp_u'],
			rlist = Effectdata.effect_table.keys(),
			dlist = Effectdata.effect_table.keys(),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'prev_level',
			container = 0,
			groups = ['temp_u'],
			rlist = Effectdata.effect_table.keys(),
			dlist = Effectdata.effect_table.keys(),
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'condition',
			container = 1,
			groups = ['c_static'],
			script = "res://editor tools/panels/char_cond.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'condition',
			container = 1,
			groups = ['trigger'],
			script = "res://editor tools/panels/eff_cond.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'atomic',
			container = 1,
			groups = variables.effecttypes,
			script = "res://editor tools/panels/atomic_list.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'sub_effects',
			container = 1,
			groups = variables.effecttypes,
			script = "res://editor tools/panels/subeffect_list.gd"
		},
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer3)
	prew_node = $MarginContainer/VBoxContainer/Label
	descedit.connect("text_entered", self, 'change_description')
	codeedit.connect('text_entered', self, 'change_code')
	#setup icon panel
#	panel_nodes.push_back(iconedit)
	if !newrec: 
		codeedit.text = "internal"
		codeedit.editable = false
	build_panels()
	select_code('oneshot')

func change_code(val):
	code = val
	update_res()

func change_description(newtext):
	tres.comment = newtext
	update_res()

func build_panels():
	for type in variables.effecttypes:
		typesel.add_item(type)
	.build_panels()

func get_data(dir = null):
	var data
	if key != null:
		data = Effectdata.effect_table[key].duplicate(true)
		code = key
		codeedit.text = code
	else:
		data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	typesel.select(variables.effecttypes.find(data.type))
	select_code(data.type)
	.get_data(data)

func commit():
	tres = parse_json('{%s}' % prew_node.text)
	if tres == null: return
	if newrec:
		editor_core.apply_patch(tres, true)
	else:
		parent.tres[id] = tres
		parent.update_val()
	.commit()

func update_res():
	if newrec:
		code = codeedit.text
		key = code
	else:
		key = null
	.update_res()
	if tres.has('comment') and tres.comment == "": tres.erase('comment')
	if tres.has('reset') and tres.reset.size() == 0: tres.erase('reset')
	if tres.has('target') and tres.target == "": tres.erase('target')
	prew_node.text = editor_core.display_res(tres, key)


func select_code(code):
	tres.clear()
	tres.type = code
	for pan in panel_nodes:
		if pan.is_in_group(code): pan.visible = true
		else: pan.visible = false

func select_type(id):
	select_code(variables.effecttypes[id])
	update_res()
