extends "res://editor tools/classes/record_panel.gd"

var id
var newrec = true


func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_STRING,
			stat = 'text',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'reqs',
			container = 0,
			groups = [],
			script = "res://editor tools/panels/glob_cond.gd"
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'args',
			container = 0,
			groups = [],
			script = "res://editor tools/panels/common_effects.gd"
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
	.get_data(data)

func commit():
	tres = parse_json(prew_node.text)
	if tres == null: return
	if newrec:
		parent.tres.push_back(tres)
	else:
		parent.tres[id] = tres
	parent.update_val()
	.commit()


