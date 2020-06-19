extends "res://editor tools/classes/record_panel.gd"

#var stat
var id

onready var typesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/type

var condtypes = ['single', 'itemlist']
var types_desc = ['single', 'itemlist']

var itemlist1 = Items.materiallist.keys() + Items.itemlist.keys()
var itemlist2 = editor_core.get_list(Items.materiallist, 'name', 'code') + editor_core.get_list(Items.itemlist, 'name', 'code')

func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_OPTION,
			stat = 'id',
			container = 0,
			groups = ['single'],
			rlist = itemlist1,
			dlist = itemlist2,
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'id',
			container = 0,
			groups = ['itemlist'],
		},
		{
			type = editor_core.PANEL_INT,
			stat = 'min',
			container = 0,
			groups = ['single', 'itemlist'],
		},
		{
			type = editor_core.PANEL_INT,
			stat = 'max',
			container = 0,
			groups = ['single', 'itemlist'],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'chance',
			container = 0,
			groups = ['single', 'itemlist'],
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'items',
			container = 0,
			groups = ['itemlist'],
			rlist = itemlist1,
			dlist = itemlist2,
		}
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	prew_node = $MarginContainer/VBoxContainer/Label
#	descedit.connect("text_entered", self, 'change_description')
	build_panels()
	key = null
	select_code('single')


func build_panels():
	for type in types_desc:
		typesel.add_item(type)
	.build_panels()

func get_data(dir = null):
	var data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	if data.has('items'): select_code('itemlist')
	else: select_code('single')
	.get_data(data)

func commit():
	update_res()
#	tres = parse_json(prew_node.text)
	if tres == null: return
#	if tres.has('description') and tres.description == "": tres.erase('description')
	id = tres.id
	tres.erase('id')
	parent.tres[id] = tres
	parent.update_val()
	.commit()

func select_code(code):
	tres.clear()
	for pan in panel_nodes:
		if pan.is_in_group(code): pan.visible = true
		else: pan.visible = false
	update_res()

func select_type(id):
	select_code(condtypes[id])
