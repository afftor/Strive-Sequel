extends "res://editor tools/classes/stat_panel_list_edit.gd"

func _init():
	tres = []

func _ready():
	$VBoxContainer/actions/up.visible = false
	$VBoxContainer/actions/down.visible = false
	$VBoxContainer/actions/new.text = "new named"
	$VBoxContainer/actions/edit.text = "edit inline"
	$VBoxContainer/actions/new.connect('pressed', self, 'add_rec')
	$VBoxContainer/actions/edit.connect('pressed', self, 'edit_rec')

func check_value():
	if !visible: return
	parent.tres[stat] = tres.duplicate()

func add_rec():
	var tmp = editor_core.buff_scene.instance()
	tmp.parent = self
	tmp.newrec = true
	add_child(tmp)
	tmp.popup()

func edit_rec():
	if stat_node.get_selected_items().size() == 0: return
	var pos = stat_node.get_selected_items()[0]
	if typeof(tres[pos]) == TYPE_STRING:
		return
	var tmp = editor_core.buff_scene.instance()
	add_child(tmp)
	tmp.get_data(tres[pos])
	tmp.popup()

func delete_rec():
	if stat_node.get_selected_items().size() == 0: return
	var pos = stat_node.get_selected_items()[0]
	tres.remove(pos)
	update_val()
#	fill_list()

func fill_list():
	stat_node.unselect_all()
	stat_node.clear()
	for c in tres:
		var text
		if typeof(c) == TYPE_STRING:
			text = c
		else: text = c.t_name
		stat_node.add_item(text)


