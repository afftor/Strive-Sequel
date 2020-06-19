extends "res://editor tools/classes/record_panel.gd"

var stat

onready var typesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/type
var typelist = ['skin', 'hair_length', 'hair_color', 'eye_color', 'eye_shape', 'ears', 'horns', 'tail', 'wings', 'height'] + ['penis_size', 'penis_type', 'balls_size','tits_size', 'ass_size'] + ['skin_coverage', 'arms', 'legs', 'body_shape', 'body_lower']

func _init():
	tres = {description = ""}
	panel_data = [
		{
			type = editor_core.PANEL_SELECT,
			stat = 'skin',
			container = 0,
			groups = ['skin'],
			rlist = ResourceScripts.descriptions.bodypartsdata.skin.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.skin.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'hair_length',
			container = 0,
			groups = ['hair_length'],
			rlist = ResourceScripts.descriptions.bodypartsdata.hair_length.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.hair_length.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'hair_color',
			container = 0,
			groups = ['hair_color'],
			rlist = ['blond','green','brown','white','blond','red','auburn','black','purple','green', 'gradient'],
			dlist = ['blond','green','brown','white','blond','red','auburn','black','purple','green', 'gradient'],
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'eye_color',
			container = 0,
			groups = ['eye_color'],
			rlist = ['red','amber', 'blue', 'green', 'purple','yellow','black','grey','brown'],
			dlist = ['red','amber', 'blue', 'green', 'purple','yellow','black','grey','brown'],
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'eye_shape',
			container = 0,
			groups = ['eye_shape'],
			rlist = ResourceScripts.descriptions.bodypartsdata.eye_shape.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.eye_shape.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'ears',
			container = 0,
			groups = ['ears'],
			rlist = ResourceScripts.descriptions.bodypartsdata.ears.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.ears.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'horns',
			container = 0,
			groups = ['horns'],
			rlist = ResourceScripts.descriptions.bodypartsdata.horns.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.horns.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'tail',
			container = 0,
			groups = ['tail'],
			rlist = ResourceScripts.descriptions.bodypartsdata.tail.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.tail.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'wings',
			container = 0,
			groups = ['wings'],
			rlist = ResourceScripts.descriptions.bodypartsdata.wings.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.wings.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'height',
			container = 0,
			groups = ['height'],
			rlist = ResourceScripts.descriptions.bodypartsdata.height.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.height.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'penis_size',
			container = 0,
			groups = ['penis_size'],
			rlist = ResourceScripts.descriptions.bodypartsdata.penis_size.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.penis_size.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'penis_type',
			container = 0,
			groups = ['penis_type'],
			rlist = ResourceScripts.descriptions.bodypartsdata.penis_type.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.penis_type.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'balls_size',
			container = 0,
			groups = ['balls_size'],
			rlist = ResourceScripts.descriptions.bodypartsdata.balls_size.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.balls_size.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'tits_size',
			container = 0,
			groups = ['tits_size'],
			rlist = ResourceScripts.descriptions.bodypartsdata.tits_size.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.tits_size.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'ass_size',
			container = 0,
			groups = ['ass_size'],
			rlist = ResourceScripts.descriptions.bodypartsdata.ass_size.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.ass_size.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'skin_coverage',
			container = 0,
			groups = ['skin_coverage'],
			rlist = ResourceScripts.descriptions.bodypartsdata.skin_coverage.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.skin_coverage.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'arms',
			container = 0,
			groups = ['arms'],
			rlist = ['wings', 'webbed', 'fur'],
			dlist = ResourceScripts.descriptions.bodypartsdata.hair_length.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'legs',
			container = 0,
			groups = ['legs'],
			rlist = ['fur'],
			dlist = ['fur'],
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'body_shape',
			container = 0,
			groups = ['body_shape'],
			rlist = ResourceScripts.descriptions.bodypartsdata.body_shape.keys(),
			dlist = ResourceScripts.descriptions.bodypartsdata.body_shape.keys(),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'body_lower',
			container = 0,
			groups = ['body_lower'],
			rlist = ['horse', 'avian', 'snake', 'spider', 'tentacle'],
			dlist = ResourceScripts.descriptions.bodypartsdata.hair_length.keys(),
		},
		
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	prew_node = $MarginContainer/VBoxContainer/Label
	build_panels()
	key = null
	select_code(stat, true)


func build_panels():
	for type in typelist:
		typesel.add_item(type)
	.build_panels()

func get_data(dir = null):
	var data = parent.tres[stat].duplicate(true)
	if dir != null: data = dir.duplicate()
	select_code(data.code)
	key = null
	.get_data(data)

func commit():
	tres = parse_json(prew_node.text)
	if tres == null: return
	parent.tres[stat] = tres
	parent.update_val()
	.commit()

func select_code(code, mod = false):
	if mod:
		typesel.select(typelist.find(code))
	else: tres.clear()
#	tres.code = code
	for pan in panel_nodes:
		if pan.is_in_group(code): pan.visible = true
		else: pan.visible = false
	update_res()

func select_type(id):
	select_code(typelist[id])
