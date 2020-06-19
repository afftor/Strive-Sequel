extends "res://editor tools/classes/record_panel.gd"


onready var codeedit = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/codeedit
onready var iconedit = $MarginContainer/VBoxContainer/HBoxContainer3/PanelContainer
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
			type = editor_core.PANEL_STRING,
			stat = 'adjective',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'global_weight',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'basestats',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/stat_base_list.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'race_bonus',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/stat_change_list.gd"
		},
		{
			type = editor_core.PANEL_CUSTOM,
			stat = 'tags',
			container = 0,
			groups = [],
			scene = "res://editor tools/panels/tags_panel.tscn"
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "personality",
			container = 1,
			groups = [],
			scene = "res://editor tools/forms/personality.tscn",
			init = {kind = 1, bold = 1, shy = 1, serious = 1}
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "food_love",
			container = 1,
			groups = [],
			scene = "res://editor tools/forms/food_pref_panel.tscn",
			init = {vege = 1, meat = 1, fish = 1, grain = 1}
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "food_hate",
			container = 1,
			groups = [],
			scene = "res://editor tools/forms/food_pref_panel.tscn",
			init = {vege = 0, meat = 0, fish = 0, grain = 0}
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'bodyparts',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/bodyparts.gd"
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
