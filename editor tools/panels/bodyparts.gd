extends "res://editor tools/classes/stat_panel_list_edit.gd"

func _init():
	tres = {}

func _ready():
	$VBoxContainer/actions/up.visible = false
	$VBoxContainer/actions/down.visible = false
	$VBoxContainer/actions/new.visible = false
#	$VBoxContainer/actions/new.connect('pressed', self, 'add_rec')
	$VBoxContainer/actions/edit.text = "new/edit"
	$VBoxContainer/actions/edit.connect('pressed', self, 'edit_rec')

func check_value():
	if !visible: return
	parent.tres[stat] = tres.duplicate()

#func add_rec():
#	var tmp = editor_core.bodypart_scene.instance()
#	tmp.parent = self
##	tmp.newrec = true
#	add_child(tmp)
#	tmp.popup()

func edit_rec():
	var pos
	if stat_node.get_selected_items().size() == 0: pos = -1
	else: pos = stat_node.get_selected_items()[0]
	var tmp = editor_core.bodypart_scene.instance()
	tmp.parent = self
	if pos >= 0: tmp.stat = stat_node.get_item_metadata(pos)
	else: tmp.stat = "height"
	add_child(tmp)
	if tres.has(tmp.stat): tmp.get_data()
	tmp.popup()

func delete_rec():
	if stat_node.get_selected_items().size() == 0: return
	var pos = stat_node.get_selected_items()[0]
	tres.erase(stat_node.get_item_metadata(pos))
	update_val()

func fill_list():
	stat_node.unselect_all()
	stat_node.clear()
	for c in tres:
		stat_node.add_item("%s" % c)
		stat_node.set_item_metadata(stat_node.get_item_count() -1, c)

