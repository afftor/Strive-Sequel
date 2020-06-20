extends "res://editor tools/classes/record_panel.gd"


func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_NUM,
			stat = 'vege',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'meat',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'fish',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'grain',
			container = 0,
			groups = [],
		},
	]


func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	key = null
	build_panels()


func get_data(dir = null):
	tres = parent.tres.duplicate(true)
	key = null
	.get_data(tres)

func commit():
	update_res()
	parent.tres = tres
	parent.update_val()
	.commit()

