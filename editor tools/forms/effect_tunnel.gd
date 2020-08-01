extends "res://editor tools/classes/record_panel.gd"

var id
var newrec = true


func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_OPTION,
			stat = 'effect',
			container = 0,
			groups = [],
			rlist = Effectdata.effect_table.keys(),
			dlist = Effectdata.effect_table.keys()
		},
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	prew_node = $MarginContainer/VBoxContainer/Label
	key = null
	build_panels()


func get_data(dir = null):#not used
#	var data = parent.tres[id].duplicate(true)
#	if dir != null: data = dir.duplicate()
#	var tmp = {}
#	tmp.weight = data[1]
#	tmp.value = data[0]
#	key = null
#	.get_data(tmp)
	pass

func commit():
	update_res()
	if tres == null: return
	var tmp = tres.effect
	if newrec:
		parent.tres.push_back(tmp)
	else:
		parent.tres[id] = tmp
	parent.update_val()
	.commit()

