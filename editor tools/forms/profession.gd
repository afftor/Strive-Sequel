extends "res://editor tools/classes/record_panel.gd"


onready var codeedit = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/codeedit
onready var iconedit = $MarginContainer/VBoxContainer/HBoxContainer3/PanelContainer
var code

var catlist = ['combat', 'social', 'magic', 'labor', 'sexual']

func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_STRING,
			stat = 'name',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'descript',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'altname',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'altnamereqs',
			container = 0,
			groups = [],
			script = "res://editor tools/panels/char_cond.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'showupreqs',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/char_cond.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'reqs',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/char_cond.gd"
		},
		{
			type = editor_core.PANEL_CUSTOM,
			stat = 'tags',
			container = 0,
			groups = [],
			scene = "res://editor tools/panels/tags_panel.tscn"
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'categories',
			container = 0,
			groups = [],
			rlist = catlist,
			dlist = catlist,
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'traits',
			container = 1,
			groups = [],
			rlist = Traitdata.traits.keys() + Traitdata.sex_traits.keys(),
			dlist = editor_core.get_list(Traitdata.traits, 'name', 'code') + editor_core.get_list(Traitdata.sex_traits, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'skills',
			container = 1,
			groups = [],
			rlist = editor_core.get_list_cond(Skilldata.Skilllist, 'code', 'code', 'type', 'social'),
			dlist = editor_core.get_list_cond(Skilldata.Skilllist, 'name', 'code', 'type', 'social') 
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'combatskills',
			container = 1,
			groups = [],
			rlist = editor_core.get_list_cond(Skilldata.Skilllist, 'code', 'code', 'type', 'combat'),
			dlist = editor_core.get_list_cond(Skilldata.Skilllist, 'name', 'code', 'type', 'combat') 
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'statchanges',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/stat_change_list.gd"
		},
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer3)
	prew_node = $MarginContainer/VBoxContainer/Label
	#setup icon panel
#	panel_nodes.push_back(iconedit)
	iconedit.parent = self
	iconedit.stat = 'icon'
	codeedit.connect('text_entered', self, 'change_code')
	build_panels()

func change_code(val):
	code = val
	update_res()


func get_data(dir = null):
	var data = classesdata.professions[key]
	if dir != null: data = dir.duplicate()
	code = data.code
	codeedit.text = code
	.get_data(data)

func commit():
	tres = parse_json('{%s}' % prew_node.text)
	if tres == null: return
	editor_core.apply_patch(tres, true)
	.commit()

func update_res():
	code = codeedit.text
	tres.code = code
	key = code
	.update_res()
