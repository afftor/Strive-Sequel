extends "res://editor tools/classes/record_panel.gd"

var id
var newrec = true


func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_SELECT,
			stat = 'value',
			container = 0,
			groups = [],
			rlist = Items.get_loot().loot_tables.keys(),
			dlist = Items.get_loot().loot_tables.keys(),
		},
		{
			type = editor_core.PANEL_NUML,
			stat = 'weight',
			container = 0,
			groups = [],
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
	.get_data(tmp)

func commit():
	update_res()
	if tres == null: return
	var tmp = [tres.value, tres.weight]
	if newrec:
		parent.tres.push_back(tmp)
	else:
		parent.tres[id] = tmp
	parent.update_val()
	.commit()

