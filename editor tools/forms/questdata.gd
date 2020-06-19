extends "res://editor tools/classes/record_panel.gd"


onready var codeedit = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/codeedit
var code


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
			type = editor_core.PANEL_EDIT,
			stat = 'randomconditions',
			container = 0,
			groups = [],
			script = "res://editor tools/panels/random_conditions.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'unlockreqs',
			container = 0,
			groups = [],
			script = "res://editor tools/panels/glob_cond.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'rewards',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/rewards.gd"
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "reputation",
			container = 1,
			groups = [],
			scene = "res://editor tools/forms/maxmin.tscn",
			init = [100, 100]
		},
				{
			type = editor_core.PANEL_TUNNEL,
			stat = "time_limit",
			container = 1,
			groups = [],
			scene = "res://editor tools/forms/maxmin.tscn",
			init = [1, 1]
		},
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer3)
	prew_node = $MarginContainer/VBoxContainer/Label
	#setup icon panel
#	panel_nodes.push_back(iconedit)
	codeedit.connect('text_entered', self, 'change_code')
	build_panels()

func change_code(val):
	code = val
	update_res()


func get_data(dir = null):
	var data = races.racelist[key]
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
