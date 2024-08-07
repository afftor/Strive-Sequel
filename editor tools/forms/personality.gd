extends "res://editor tools/classes/record_panel.gd"


func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_NUM,
			stat = 'kind',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'bold',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'shy',
			container = 0,
			groups = [],
		},
		{
			type = editor_core.PANEL_NUM,
			stat = 'serious',
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
	.get_data(tres)

func commit():
	update_res()
	parent.tres = tres
	parent.update_val()
	.commit()

