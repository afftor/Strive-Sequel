extends "res://editor tools/classes/record_panel.gd"


func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_NUM,
			stat = 'easy',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'medium',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'hard',
			container = 0,
			groups = [],
		},
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	key = null
	build_panels()


func get_data(dir = null):
	var temp = parent.tres.duplicate(true)
	tres = {}
	for i in temp:
		tres[i[0]] = i[1]

	.get_data(tres)

func commit():
	update_res()
	for i in tres.keys():
		if tres[i] == null or tres[i] == 0: tres.erase(i)
	var temp = []
	for i in tres: temp.push_back([i, tres[i]])
	parent.tres = temp.duplicate()
	parent.update_val()
	.commit()

