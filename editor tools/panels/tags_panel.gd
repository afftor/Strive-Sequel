extends "res://editor tools/classes/stat_panel.gd"

func _ready():
	stat_node = $VBoxContainer/LineEdit
	stat_node.connect('text_entered', self, 'commit')

func get_data():
	if !visible: return
	var tmp
	if parent.tres.has(stat): tmp = parent.tres[stat]
	else: tmp = []
	stat_node.text = ""
	for t in tmp: stat_node.text += "%s " % t

func check_value():
	if !visible: return
	parent.tres[stat] = stat_node.text.split(' ', false)

