extends "res://editor tools/classes/stat_panel.gd"

var data_array
var hint_array

func _ready():
	$VBoxContainer/index.visible = false
	$VBoxContainer/number.visible = false
	$VBoxContainer/formula.visible = false
	$VBoxContainer/string.visible = false
	$VBoxContainer/reslist.visible = true
	$VBoxContainer/flag.visible = false
	$VBoxContainer/Button.visible = false
	stat_node = $VBoxContainer/reslist
	fill_list()
	stat_node.connect('item_selected', self, 'commit')
#	._ready()

func fill_list():
	stat_node.clear()
	for line in hint_array: stat_node.add_item(line)
	for i in range(data_array.size()):
		stat_node.set_item_metadata(i, data_array[i])

func get_data():
	if !visible: return
	if parent.tres.has(stat):
		var tmp = parent.tres[stat]
		var pos = data_array.find(tmp)
		stat_node.select(pos)
	else:
		stat_node.select(0)
