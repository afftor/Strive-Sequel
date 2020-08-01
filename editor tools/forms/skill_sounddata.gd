extends "res://editor tools/classes/record_panel.gd"

var arr1 = [null]
var arr2 = ['null']

func _init():
	tres = {}
	for s in audio.sounds: 
		arr1.push_back(s)
		arr2.push_back(s)
	
	panel_data = [
		{
			type = editor_core.PANEL_OPTION,
			stat = 'initiate',
			container = 0,
			groups = [],
			rlist = arr1,
			dlist = arr2
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'strike',
			container = 0,
			groups = [],
			rlist = arr1,
			dlist = arr2
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'hit',
			container = 0,
			groups = [],
			rlist = arr1,
			dlist = arr2
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

