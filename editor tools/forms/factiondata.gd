extends "res://editor tools/classes/record_panel.gd"

var code
var actions = ['hire','sellslaves','services', 'upgrade']
var preference = ['combat', 'magic', 'labor', 'sexual', 'social']

onready var codeedit = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/codeedit

func _init():
	tres = {}
	panel_data = [
#		{
#			type = editor_core.PANEL_OPTION,
#			stat = 'code',
#			container = 0,
#			groups = [],
#			rlist = variables.guild_order,
#			dlist = variables.guild_order,
#		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'name',
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
			type = editor_core.PANEL_SELECT,
			stat = "actions",
			container = 0,
			groups = [],
			rlist = actions,
			dlist = actions
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = "preferences",
			container = 0,
			groups = [],
			rlist = preference,
			dlist = preference
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'character_types',
			container = 0,
			groups = [],
			script = "res://editor tools/panels/char_types.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'character_bonuses',
			container = 0,
			groups = [],
			script = "res://editor tools/panels/stat_base_list.gd"
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = "events",
			container = 1,
			groups = [],
			rlist = scenedata.dialogue_inits.keys(),
			dlist = scenedata.dialogue_inits.keys()
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = "quests_easy",
			container = 1,
			groups = [],
			rlist = worlddata.questdata.keys(),
			dlist = worlddata.questdata.keys()
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = "quests_medium",
			container = 1,
			groups = [],
			rlist = worlddata.questdata.keys(),
			dlist = worlddata.questdata.keys()
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = "quests_hard",
			container = 1,
			groups = [],
			rlist = worlddata.questdata.keys(),
			dlist = worlddata.questdata.keys()
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "slavenumber",
			container = 2,
			groups = [],
			scene = "res://editor tools/forms/maxmin.tscn",
			init = [1, 1]
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "questnumber",
			container = 2,
			groups = [],
			scene = "res://editor tools/forms/maxmin.tscn",
			init = [1, 1]
		},
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer3)
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer4)
	prew_node = $MarginContainer/VBoxContainer/Label
	#setup icon panel
#	panel_nodes.push_back(iconedit)
	codeedit.connect('text_entered', self, 'change_code')
	build_panels()

func change_code(val):
	code = val
	update_res()

#func build_panels():
#	for type in types_desc:
#		typesel.add_item(type)
#	.build_panels()

func get_data(dir = null):
	var data = races.racelist[key]
	if dir != null: data = dir.duplicate()
	code = data.code
	codeedit.text = code
	tres.code = code
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
