extends "res://editor tools/classes/stat_panel.gd"

var data_array
var hint_array

func _ready():
	$VBoxContainer/actions.visible = false
	stat_node = $VBoxContainer/ItemList
	fill_list()
	stat_node.select_mode = ItemList.SELECT_MULTI
	stat_node.connect('multi_selected', self, 'commit')
#	._ready()

func fill_list():
	stat_node.clear()
	for line in hint_array: stat_node.add_item(line)
	for i in range(data_array.size()):
		stat_node.set_item_metadata(i, data_array[i])

func get_data():
	if !visible: return
	stat_node.unselect_all()
	if parent.tres.has(stat):
		var tmp = parent.tres[stat]
		for val in tmp:
			var pos = data_array.find(val)
			stat_node.select(pos, false)

