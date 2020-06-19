extends "res://editor tools/classes/record_panel.gd"

#onready var valsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/valsel
#onready var statsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/statsel
#onready var cont = $MarginContainer/VBoxContainer/HBoxContainer

var id

func _init():
	tres = {}
	panel_data = [
		{
			type = editor_core.PANEL_OPTION,
			stat = 'type',
			container = 0,
			groups = [],
			rlist = Items.Parts.keys(),
			dlist = editor_core.get_list(Items.Parts, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'value',
			container = 0,
			groups = [],
			rlist = Items.materiallist.keys(),
			dlist = editor_core.get_list(Items.materiallist, 'name', 'code'),
		},
	]

func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	key = null
	build_panels()

func commit():
	update_res()
	parent.tres[tres.type] = tres.value
	parent.update_val()
	.commit()

func revert():
	hide()
	queue_free()


func get_data(data = null):
	tres.type = id
	tres.value = parent.tres[id]
	.get_data(tres)
