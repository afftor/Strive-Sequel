extends "res://editor tools/classes/record_panel.gd"

var id
var newrec = true

onready var typesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/type

var condtypes = ['gold', 'material', 'gear',]

func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_BOOL,
			stat = 'item_based',
			container = 0,
			groups = ['gold'],
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'name',
			container = 0,
			groups = ['gear'],
			rlist = Items.itemlist.keys(),
			dlist = editor_core.get_list(Items.itemlist, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'name',
			container = 0,
			groups = ['material'],
			rlist = Items.materiallist.keys(),
			dlist = editor_core.get_list(Items.materiallist, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "material_grade",
			container = 0,
			groups = ['gear'],
			scene = "res://editor tools/forms/material_tiers_alter.tscn",
			init = [['easy', 1], ['medium', 1],['hard', 1]]
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "range",
			container = 0,
			groups = ['gold',],
			scene = "res://editor tools/forms/maxmin.tscn",
			init = [1, 1]
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "value",
			container = 0,
			groups = ['material',],
			scene = "res://editor tools/forms/maxmin.tscn",
			init = [1, 1]
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'weight',
			container = 0,
			groups = ['material', 'gear', 'gold'],
		},
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	prew_node = $MarginContainer/VBoxContainer/Label
	key = null
	build_panels()
	select_code('gold')


func build_panels():
	for type in condtypes:
		typesel.add_item(type)
	.build_panels()

func get_data(dir = null):
	var data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	var tmp = data[0]
	data = data[1]
	data.weiht = tmp
	select_code(data.code)
	.get_data(data)

func commit():
	update_res()
	if tres == null: return
	var ch = tres.weight
	tres.erase('weight')
	if newrec:
		parent.tres.push_back([ch, tres])
	else:
		parent.tres[id] = [ch, tres]
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
