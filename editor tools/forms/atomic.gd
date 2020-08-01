extends "res://editor tools/classes/record_panel.gd"


onready var codeedit = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/codeedit
onready var typesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/type
onready var descedit = $MarginContainer/VBoxContainer/HBoxContainer/desc_panel/VBoxContainer/desc

var code = null

var id
var newrec = true


func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_STRING,
			stat = 'value',
			container = 0,
			groups = ['remove_effect', 'remove_all_effects', 'sfx', 'add_tag'],
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'stat',
			container = 0,
			groups = ['stat_set','stat_set_revert','stat_add','stat_mul','stat_add_p'],
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'bonusname',
			container = 0,
			groups = ['bonus'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'source',
			container = 0,
			groups = ['damage'],
			rlist = variables.resists_list,
			dlist = variables.resists_list,
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'trait',
			container = 0,
			groups = ['trait'],
			rlist = Traitdata.traits.keys(),
			dlist = editor_core.get_list(Traitdata.traits, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'trait',
			container = 0,
			groups = ['add_sex_trait', 'unlock_sex_trait'],
			rlist = Traitdata.sex_traits.keys(),
			dlist = editor_core.get_list(Traitdata.sex_traits, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'skill',
			container = 0,
			groups = ['use_combat_skill', 'add_combat_skill'],
			rlist = editor_core.get_list_cond(Skilldata.Skilllist, 'code', 'code', 'type', 'combat'),
			dlist = editor_core.get_list_cond(Skilldata.Skilllist, 'name', 'code', 'type', 'combat') 
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'skill',
			container = 0,
			groups = ['use_social_skill', 'add_soc_skill'],
			rlist = editor_core.get_list_cond(Skilldata.Skilllist, 'code', 'code', 'type', 'social'),
			dlist = editor_core.get_list_cond(Skilldata.Skilllist, 'name', 'code', 'type', 'social') 
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "value",
			container = 0,
			groups = ['damage', 'heal', 'mana', 'stat_set','stat_set_revert','stat_add','stat_mul','stat_add_p', 'bonus', 'resurrect'],
			scene = "res://editor tools/forms/atomic_value.tscn",
			init = [0]
		},
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer3)
	prew_node = $MarginContainer/VBoxContainer/Label
	descedit.connect("text_entered", self, 'change_description')
	codeedit.connect('text_entered', self, 'change_code')
	#setup icon panel
#	panel_nodes.push_back(iconedit)
	if !newrec: 
		codeedit.text = "internal"
		codeedit.editable = false
	build_panels()
	select_code('kill')

func change_code(val):
	code = val
	update_res()

func change_description(newtext):
	tres.comment = newtext
	if newtext == "": tres.erase('comment')
	update_res()

func build_panels():
	for type in variables.atomic_types:
		typesel.add_item(type)
	.build_panels()

func get_data(dir = null):
	var data
	if key != null:
		data = Effectdata.atomic[key].duplicate(true)
		code = key
		codeedit.text = code
	else:
		data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	typesel.select(variables.atomic_types.find(data.type))
	select_code(data.type)
	.get_data(data)

func commit():
	tres = parse_json('{%s}' % prew_node.text)
	if tres == null: return
	if newrec:
		editor_core.apply_patch(tres, true)
	else:
		parent.tres[id] = tres
		parent.update_val()
	.commit()

func update_res():
	if tres.has('comment') and tres.has('comment') and tres.comment == "": tres.erase('comment')
	if newrec:
		code = codeedit.text
		key = code
	else:
		key = null
	.update_res()

func select_code(code):
	tres.clear()
	tres.type = code
	for pan in panel_nodes:
		if pan.is_in_group(code): pan.visible = true
		else: pan.visible = false

func select_type(id):
	select_code(variables.atomic_types[id])
	update_res()
