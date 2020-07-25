extends "res://editor tools/classes/record_panel.gd"

var stat
var id
var newrec = true

onready var typesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/type
onready var descedit = $MarginContainer/VBoxContainer/HBoxContainer/desc_panel/VBoxContainer/desc

var condtypes = [
	'stat','stat_index','has_profession','has_any_profession','race_is_beast','gear_equiped','global_profession_limit','race','one_of_races','is_free','long_tail','long_ears','is_humanoid','is_dead','is_master','trait','has_status','population','random']
var types_desc = [
	'stat','index of stat','has profession','has any profession','race is beast','gear equiped','global profession limit','race','one of races','is free','long tail','long ears','is humanoid','is dead','is master','trait','has status','population','random'] 
var itemparams = ['name', 'itembase', 'code', 'itemtype', 'toolcategory', 'geartype', 'subtype', 'weaponrange', 'interaction_use']


func _init():
	tres = {description = ""}
	panel_data = [
		{
			type = editor_core.PANEL_OPTION,
			stat = 'stat',
			container = 0,
			groups = ['stat','stat_index',],
			rlist = ['hp', 'mp', 'shield', 'base_exp'] + Statlist_init.template.keys(),
			dlist = ['hp', 'mp', 'shield', 'base_exp'] + Statlist_init.template.keys(),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'operant',
			container = 0,
			groups = ['stat','stat_index', 'population'],
			rlist = variables.real_ops,
			dlist = variables.ops,
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'value',
			container = 0,
			groups = ['stat', 'stat_index', 'gear_equiped'],
		},
		{
			type = editor_core.PANEL_INT,
			stat = 'index',
			container = 0,
			groups = ['stat_index'],
		},
		{
			type = editor_core.PANEL_BOOL,
			stat = 'check',
			container = 0,
			groups = ['has_profession', 'has_any_profession', 'race', 'race_is_beast', 'is_free', 'long_tail', 'long_ears', 'is_humanoid', 'is_master', 'is_dead', 'trait', 'has_status', 'gear_equiped'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'profession',
			container = 0,
			groups = ['has_profession', 'global_profession_limit'],
			rlist = classesdata.professions.keys(),
			dlist = editor_core.get_list(classesdata.professions, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'value',
			container = 0,
			groups = ['has_any_profession'],
			rlist = classesdata.professions.keys(),
			dlist = editor_core.get_list(classesdata.professions, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'race',
			container = 0,
			groups = ['race'],
			rlist = races.racelist.keys(),
			dlist = editor_core.get_list( races.racelist, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'value',
			container = 0,
			groups = ['one_of_races'],
			rlist = races.racelist.keys(),
			dlist = editor_core.get_list( races.racelist, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'param',
			container = 0,
			groups = ['gear_equiped'],
			rlist = itemparams,
			dlist = itemparams,
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'value',
			container = 0,
			groups = ['global_profession_limit', 'population', 'random'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'trait',
			container = 0,
			groups = ['trait'],
			rlist = Traitdata.traits.keys() + Traitdata.sex_traits.keys(),
			dlist = editor_core.get_list(Traitdata.traits, 'name', 'code') + editor_core.get_list(Traitdata.sex_traits, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'status',
			container = 0,
			groups = ['has_status'],
		},
	]

func change_description(newtext):
	tres.description = newtext
	update_res()

func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	prew_node = $MarginContainer/VBoxContainer/Label
	descedit.connect("text_entered", self, 'change_description')
	build_panels()
	key = null
	select_code('stat')


func build_panels():
	for type in types_desc:
		typesel.add_item(type)
	.build_panels()

func get_data(dir = null):
	var data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	select_code(data.code)
	if data.has('description'): descedit.text = data.description
	key = null
	.get_data(data)

func commit():
	tres = parse_json(prew_node.text)
	if tres == null: return
	if tres.has('description') and tres.description == "": tres.erase('description')
	if newrec:
		parent.tres.push_back(tres)
	else:
		parent.tres[id] = tres
	parent.update_val()
	.commit()

func select_code(code):
	tres.clear()
	tres.code = code
	for pan in panel_nodes:
		if pan.is_in_group(code): pan.visible = true
		else: pan.visible = false
	update_res()

func select_type(id):
	select_code(condtypes[id])
