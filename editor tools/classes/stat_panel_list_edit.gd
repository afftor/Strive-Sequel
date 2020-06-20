extends "res://editor tools/classes/stat_panel.gd"

var tres

func _ready():
	stat_node = $VBoxContainer/ItemList
#	fill_list()
	stat_node.select_mode = ItemList.SELECT_SINGLE
#	stat_node.connect('item_selected', self, 'commit')
	$VBoxContainer/actions/up.connect('pressed', self, 'move_up')
	$VBoxContainer/actions/down.connect('pressed', self, 'move_down')
	$VBoxContainer/actions/delete.connect('pressed', self, 'delete_rec')
#	._ready()

func fill_list():
#	stat_node.clear()
#	var temp = parent.tres[stat]
#	for rec in temp:
#		if rec.has('description'): stat_node.add_item(rec.description)
#		else: stat_node.add_item(to_json(rec))
	pass

func update_val():
	fill_list()
	parent.update_res()

func get_data():
	if !visible: return
	if parent.tres.has(stat):
		tres = parent.tres[stat].duplicate(true)
	else:
		tres.clear()
	fill_list()

func move_up():
	if stat_node.get_selected_items().size() == 0: return
	var pos = stat_node.get_selected_items()[0]
	input_handler.swap_items(tres, pos, pos - 1)
	fill_list()

func move_down():
	if stat_node.get_selected_items().size() == 0: return
	var pos = stat_node.get_selected_items()[0]
	input_handler.swap_items(tres, pos, pos + 1)
	fill_list()

func check_value():
	return
