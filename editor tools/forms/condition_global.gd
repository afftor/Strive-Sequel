extends "res://editor tools/classes/record_panel.gd"

var stat
var id
var newrec = true

onready var typesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/type
onready var descedit = $MarginContainer/VBoxContainer/HBoxContainer/desc_panel/VBoxContainer/desc

var condtypes = [
		'has_money',
		'has_hero',
		'has_material',
		'date',
		'hour',
		'has_upgrade',
		'main_progress',
		'party_level',
		'hero_level',
		'active_character_checks',
		'master_is_beast',
		'unique_character_at_mansion',
		'random',
		'faction_reputation',
		'group_size',]
var types_desc = [
		'has_money',
		'has_hero',
		'has_material',
		'date',
		'hour',
		'has_upgrade',
		'main_progress',
		'party_level',
		'hero_level',
		'active_character_checks',
		'master_is_beast',
		'unique_character_at_mansion',
		'random',
		'faction_reputation',
		'group_size',]
#var itemparams = ['name', 'itembase', 'code', 'itemtype', 'toolcategory', 'geartype', 'subtype', 'weaponrange', 'interaction_use']


func _init():
	tres = {description = ""}
	panel_data = [
		{
			type = editor_core.PANEL_NUM,
			stat = 'value',
			container = 0,
			groups = ['has_money', 'has_material', 'date', 'hour', 'has_upgrade', 'main_progress', 'party_level', 'hero_level', 'random', 'faction_reputation', 'group_size'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'operant',
			container = 0,
			groups = ['has_material', 'date', 'hour', 'main_progress', 'party_level', 'hero_level', 'faction_reputation', 'group_size'],
			rlist = variables.real_ops,
			dlist = variables.ops,
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'material',
			container = 0,
			groups = ['has_material'],
			rlist = Items.materiallist.keys(),
			dlist = editor_core.get_list( Items.materiallist, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'value',
			container = 0,
			groups = ['has_upgrade'],
			rlist = upgradedata.upgradelist.keys(),
			dlist = editor_core.get_list( upgradedata.upgradelist, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'name',
			container = 0,
			groups = ['hero_level', 'unique_character_at_mansion', 'has_hero'],
			rlist = worlddata.pregen_characters.keys() + worlddata.easter_egg_characters.keys(),
			dlist = editor_core.get_list(worlddata.pregen_characters, 'name', 'code') + editor_core.get_list(worlddata.easter_egg_characters, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_BOOL,
			stat = 'check',
			container = 0,
			groups = ['master_is_beast', 'unique_character_at_mansion'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'code',
			container = 0,
			groups = ['faction_reputation'],
			rlist = variables.guild_order,
			dlist = variables.guild_order,
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'value',
			container = 0,
			groups = ['active_character_checks'],
			script = "res://editor tools/panels/char_cond.gd"
		},
		
	]



func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	prew_node = $MarginContainer/VBoxContainer/Label
	build_panels()
	descedit.connect("text_entered", self, 'change_description')
	select_code('has_money')
	key = null

func build_panels():
	for type in types_desc:
		typesel.add_item(type)
	.build_panels()

func get_data(dir = null):
	var data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	select_code(data.code)
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

func select_type(id):
	select_code(condtypes[id])
	update_res()

func change_description(newtext):
	tres.description = newtext
	update_res()
