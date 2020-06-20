extends "res://editor tools/classes/record_panel.gd"


onready var codeedit = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/codeedit
onready var typesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/type
var code

var condtypes = ['dungeon', 'encounter']
var difficulties = ['easy', 'medium', 'hard']
var catlist = ['combat', 'social', 'magic', 'labor', 'sexual']

func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_STRING,
			stat = 'name',
			container = 0,
			groups = ['dungeon', 'encounter'],
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'descript',
			container = 0,
			groups = ['dungeon', 'encounter'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'difficulty',
			container = 0,
			groups = ['dungeon', 'encounter'],
			rlist = difficulties,
			dlist = difficulties,
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'background',
			container = 0,
			groups = ['encounter'],
			rlist = images.backgrounds.keys(),
			dlist = images.backgrounds.keys(),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'backgrounds_pool',
			container = 0,
			groups = ['dungeon'],
			rlist = images.backgrounds.keys(),
			dlist = images.backgrounds.keys(),
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'enemyarray',
			container = 1,
			groups = ['dungeon', 'encounter'],
			script = "res://editor tools/panels/enemies.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'final_enemy',
			container = 1,
			groups = ['dungeon'],
			script = "res://editor tools/panels/enemies.gd"
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'final_enemy_type',
			container = 1,
			groups = ['dungeon'],
			rlist = ['character'],
			dlist = ['character'],
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'difficulty',
			container = 1,
			groups = ['dungeon'],
			rlist = catlist,
			dlist = catlist,
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'eventarray',
			container = 2,
			groups = ['dungeon', 'encounter'],
			script = "res://editor tools/panels/events.gd"
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "levels",
			container = 2,
			groups = ['dungeon', 'encounter'],
			scene = "res://editor tools/forms/maxmin.tscn",
			init = [1, 1]
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "stages_per_level",
			container = 2,
			groups = ['dungeon', 'encounter'],
			scene = "res://editor tools/forms/maxmin.tscn",
			init = [1, 1]
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'resources',
			container = 2,
			groups = ['dungeon', 'encounter'],
			rlist = Items.materiallist.keys(),
			dlist = editor_core.get_list(Items.materiallist, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'events',
			container = 2,
			groups = ['dungeon', 'encounter'],
			rlist = [],
			dlist = [],
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'options',
			container = 2,
			groups = ['encounter'],
			script = "res://editor tools/panels/dungeon_options.gd"
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'bgm',
			container = 2,
			groups = ['dungeon'],
			rlist = audio.music.keys(),
			dlist = audio.music.keys(),
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'puchase_price',
			container = 2,
			groups = ['dungeon'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'affiliation',
			container = 2,
			groups = ['dungeon'],
			rlist = ['local'],
			dlist = ['local'],
		},
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer3)
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer4)
	prew_node = $MarginContainer/VBoxContainer/Label
	codeedit.connect('text_entered', self, 'change_code')
	#setup icon panel
#	panel_nodes.push_back(iconedit)
	build_panels()
	select_code('dungeon')

func change_code(val):
	code = val
	update_res()

func build_panels():
	for type in condtypes:
		typesel.add_item(type)
	.build_panels()

func get_data(dir = null):
	var data = worlddata.dungeons[key]
	if dir != null: data = dir.duplicate()
	code = data.code
	codeedit.text = code
	typesel.select(condtypes.find(data.type))
	select_code(data.type)
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

func select_code(code):
	tres.clear()
	tres.type = code
	for pan in panel_nodes:
		if pan.is_in_group(code): pan.visible = true
		else: pan.visible = false

func select_type(id):
	select_code(condtypes[id])
	update_res()
