extends "res://editor tools/classes/record_panel.gd"


onready var codeedit = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/codeedit
onready var iconedit = $MarginContainer/VBoxContainer/HBoxContainer3/PanelContainer
var code


func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_STRING,
			stat = 't_name',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'description',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_INT,
			stat = 'limit',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_BOOL,
			stat = 'mansion_only',
			default = false,
			container = 1,
			groups = [],
		},
		{
			type = editor_core.PANEL_BOOL,
			stat = 'combat_only',
			default = false,
			container = 1,
			groups = [],
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
	var data = Effectdata.buffs[key]
	if dir != null: data = dir.duplicate()
	code = key
	codeedit.text = code
	.get_data(data)

func commit():
	tres = parse_json('{%s}' % prew_node.text)
	if tres == null: return
	editor_core.apply_patch(tres, true)
	.commit()

func update_res():
	code = codeedit.text
	key = code
	.update_res()
	if !tres.combat_only: tres.erase('combat_only')
	if !tres.mansion_only: tres.erase('mansion_only')
