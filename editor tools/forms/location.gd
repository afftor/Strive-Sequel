extends "res://editor tools/classes/record_panel.gd"


onready var codeedit = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/codeedit
var code

var options = ['local_shop','local_events_search']

func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_STRING,
			stat = 'type',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'classname',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'name',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'races',
			container = 0,
			groups = [],
			script = "res://editor tools/panels/race_chance_list.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'event_pool',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/event_glob.gd"
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = "actions",
			container = 1,
			groups = [],
			rlist = options,
			dlist = options
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "material_tiers",
			container = 1,
			groups = [],
			scene = "res://editor tools/forms/material_tiers.tscn",
			init = {easy = 1, medium = 1, hard = 1}
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'area_shop_items',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/shop_items.gd"
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'background_pool',
			container = 2,
			groups = [],
			rlist = images.backgrounds.keys(),
			dlist = images.backgrounds.keys(),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'bgm',
			container = 2,
			groups = [],
			rlist = audio.music.keys(),
			dlist = audio.music.keys(),
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'capital_name',
			container = 2,
			groups = [],
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "travel_time",
			container = 2,
			groups = [],
			scene = "res://editor tools/forms/maxmin.tscn",
			init = [0, 0]
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
