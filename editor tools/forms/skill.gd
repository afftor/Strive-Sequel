extends "res://editor tools/classes/record_panel.gd"


onready var codeedit = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/codeedit
onready var iconedit = $MarginContainer/VBoxContainer/HBoxContainer3/PanelContainer
var code


func _init():
	tres = {new_syntax = true}
	panel_data = [
		{
			type = editor_core.PANEL_STRING,
			stat = 'name',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'descript',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'type',
			container = 0,
			groups = [],
			rlist = ['combat','social'],
			dlist = ['combat','social'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'ability_type',
			container = 0,
			groups = [],
			rlist = ['spell','skill', 'item'],
			dlist = ['spell','skill', 'item'],
		},
		{ #2fix
			type = editor_core.PANEL_NUM,
			stat = 'manacost',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'charges',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'cooldown',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'combatcooldown',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'reqs',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/char_cond.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'targetreqs',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/char_cond.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'effects',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/skill_effects.gd"
		},
		{
			type = editor_core.PANEL_CUSTOM,
			stat = 'tags',
			container = 2,
			groups = [],
			scene = "res://editor tools/panels/tags_panel.tscn"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'value',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/skill_values.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'sfx',
			container = 1,
			groups = [],
			script = "res://editor tools/panels/skill_sfx.gd"
		},
		{
			type = editor_core.PANEL_TUNNEL,
			stat = "sounddata",
			container = 2,
			groups = [],
			scene = "res://editor tools/forms/skill_sounddata.tscn",
			init = {initiate = null, strike = null, hit = null}
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'damage_type',
			container = 2,
			groups = [],
			rlist = variables.resists_list,
			dlist = variables.resists_list,
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'target',
			container = 2,
			groups = [],
			rlist = ['ally', 'enemy', 'self', 'full'],
			dlist = ['ally', 'enemy', 'self', 'full'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'target_range',
			container = 2,
			groups = [],
			rlist = ['melee', 'any', 'dead', 'weapon'],
			dlist = ['melee', 'any', 'dead', 'weapon'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'target_number',
			container = 2,
			groups = [],
			rlist = ['single', 'all', 'line', 'row', 'nontarget', 'single_nontarget'],
			dlist = ['single', 'all', 'line', 'row', 'nontarget', 'single_nontarget'],
		},
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer3)
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer4)
	prew_node = $MarginContainer/VBoxContainer/Label
	#setup icon panel
#	panel_nodes.push_back(iconedit)
	iconedit.parent = self
	iconedit.stat = 'icon'
	codeedit.connect('text_entered', self, 'change_code')
	build_panels()

func change_code(val):
	code = val
	update_res()


func get_data(dir = null):
	var data = Skilldata.Skilllist[key]
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
