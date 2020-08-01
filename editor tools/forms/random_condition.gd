extends "res://editor tools/classes/record_panel.gd"

var id
var newrec = true

onready var typesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/type
onready var descedit = $MarginContainer/VBoxContainer/HBoxContainer/desc_panel/VBoxContainer/desc

var condtypes = ['random_material', 'random_item', 'complete_location', 'complete_dungeon', 'kill_monsters', 'slave_delivery']
var difficulties = ['easy', 'medium', 'hard']

func _init():
	tres = {description = ""}
	panel_data = [
		{
			type = editor_core.PANEL_SELECT,
			stat = 'type',
			container = 0,
			groups = ['random_material'],
			rlist = Items.materiallist.keys(),
			dlist = editor_core.get_list(Items.materiallist, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'type',
			container = 0,
			groups = ['random_item'],
			rlist = Items.itemlist.keys(),
			dlist = editor_core.get_list(Items.itemlist, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'type',
			container = 0,
			groups = ['complete_location', 'complete_dungeon'],
			rlist = worlddata.dungeons.keys(),
			dlist = editor_core.get_list(worlddata.dungeons, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'type',
			container = 0,
			groups = ['kill_monsters'],
			rlist = Enemydata.enemies.keys(),
			dlist = editor_core.get_list(Enemydata.enemies, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'difficulty',
			container = 0,
			groups = ['complete_location'],
			rlist = difficulties,
			dlist = difficulties,
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'parts',
			container = 0,
			groups = ['random_item'],
			script = "res://editor tools/panels/part_cond_list.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'mandatory_conditions',
			container = 0,
			groups = ['slave_delivery'],
			script = "res://editor tools/panels/random_cond_char_m.gd"
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "condition_number",
			container = 0,
			groups = ['slave_delivery'],
			scene = "res://editor tools/forms/maxmin.tscn",
			init = [1, 1]
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'conditions',
			container = 0,
			groups = ['slave_delivery'],
			script = "res://editor tools/panels/random_cond_char.gd"
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "range",
			container = 0,
			groups = ['random_material', 'random_item', 'kill_monsters'],
			scene = "res://editor tools/forms/maxmin.tscn",
			init = [1, 1]
		},
		
	]

func change_description(newtext):
	tres.description = newtext
	if newtext == "": tres.erase('description')
	key = null
	update_res()

func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	prew_node = $MarginContainer/VBoxContainer/Label
	descedit.connect("text_entered", self, 'change_description')
	build_panels()
	key = null
	select_code('random_material')


func build_panels():
	for type in condtypes:
		typesel.add_item(type)
	.build_panels()

func get_data(dir = null):
	var data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	select_code(data.code)
	if data.has('description'): descedit.text = data.description
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
