extends "res://editor tools/classes/record_panel.gd"

var id
var newrec = true

var sfxlist = ['casterattack', 'targetattack', 'ranged_attack', 'firebolt', 'water_attack', 'flame', 'earth_spike', 'targetfire', 'decay', 'heal', 'miss', 'resist', 'death_animation']

func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_OPTION,
			stat = 'code',
			container = 0,
			groups = [],
			rlist = sfxlist,
			dlist = sfxlist,
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'target',
			container = 0,
			groups = [],
			rlist = ['caster', 'target'],
			dlist = ['caster', 'target'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'period',
			container = 0,
			groups = [],
			rlist = ['windup', 'predamage', 'postdamage'],
			dlist = ['windup', 'predamage', 'postdamage'],
		},
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	prew_node = $MarginContainer/VBoxContainer/Label
	key = null
	build_panels()


func get_data(dir = null):
	var data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	var tmp = {}
	tmp.weight = data[1]
	tmp.value = data[0]
	key = null
	.get_data(tmp)

func commit():
	update_res()
	if tres == null: return
	if newrec:
		parent.tres.push_back(tres)
	else:
		parent.tres[id] = tres
	parent.update_val()
	.commit()

