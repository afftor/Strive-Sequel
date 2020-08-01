extends "res://editor tools/classes/record_panel.gd"

var id
var newrec = true

onready var d_prew = $MarginContainer/VBoxContainer/Label3
var reclist = ['target','caster','all']

func _init():
	tres = {value1 = 0, value2 = 0, value3 = 0}
	panel_data = [
		{
			type = editor_core.PANEL_OPTION,
			stat = 'damagestat',
			container = 0,
			groups = [],
			rlist = variables.damagestat_list,
			dlist = variables.damagestat_list,
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'dmgf',
			container = 0,
			groups = [],
			rlist = [0, 1, 2],
			dlist = ['+', '-', '='],
		},
		{
			type = editor_core.PANEL_CUSTOM,
			stat = 'value1',
			container = 0,
			groups = [],
			scene = "res://editor tools/panels/tags_panel.tscn"
		},
		{
			type = editor_core.PANEL_CUSTOM,
			stat = 'value2',
			container = 0,
			groups = [],
			scene = "res://editor tools/panels/tags_panel.tscn"
		},
		{
			type = editor_core.PANEL_CUSTOM,
			stat = 'value3',
			container = 0,
			groups = [],
			scene = "res://editor tools/panels/tags_panel.tscn"
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'source',
			container = 1,
			groups = [],
			rlist = variables.resists_list,
			dlist = variables.resists_list,
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'receiver',
			container = 1,
			groups = [],
			rlist = reclist,
			dlist = reclist,
		},
		{
			type = editor_core.PANEL_BOOL,
			stat = 'nomod',
			default = false,
			container = 1,
			groups = [],
		},
		{
			type = editor_core.PANEL_BOOL,
			stat = 'nocrit',
			default = false,
			container = 1,
			groups = [],
		},
		{
			type = editor_core.PANEL_BOOL,
			stat = 'nodef',
			default = false,
			container = 1,
			groups = [],
		},
		{
			type = editor_core.PANEL_BOOL,
			stat = 'is_drain',
			default = false,
			container = 1,
			groups = [],
		},
		{
			type = editor_core.PANEL_BOOL,
			stat = 'is_process',
			default = true,
			container = 1,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'random_factor',
			container = 1,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'random_factor_p',
			container = 1,
			groups = [],
		},
	]



func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer3)
	prew_node = $MarginContainer/VBoxContainer/Label
	build_panels()
	key = null


func get_data(dir = null):
	var data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	key = null
	.get_data(data)

func commit():
	tres = parse_json(prew_node.text)
	if tres == null: return
	if newrec:
		parent.tres.push_back(tres)
	else:
		parent.tres[id] = tres
	parent.update_val()
	.commit()

func update_res():
	.update_res()
	d_prew.text = "({value1} * <corresponding attack>  + {value2}) * (1 + <corresponding stat>/100) + {value3}".format(tres)
	pass
