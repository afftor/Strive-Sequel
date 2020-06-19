extends WindowDialog

var parent
var tres

var col_containers = []
var panel_data
var prew_node
var panel_nodes = []
var key

func _ready():
	pass # Replace with function body.

func update_res():
	for node in panel_nodes:
		node.check_value()
	if prew_node == null: return
	prew_node.text = editor_core.display_res(tres, key)

func build_panels():
	panel_nodes.clear()
	for rec in panel_data:
		var tmp
		match rec.type:
			editor_core.PANEL_BOOL:
				tmp = editor_core.panel_scene.instance()
				var scr = load("res://editor tools/classes/stat_panel_bool.gd")
				tmp.set_script(scr)
				tmp.parent = self
				tmp.stat = rec.stat
				panel_nodes.push_back(tmp)
				col_containers[rec.container].add_child(tmp)
			editor_core.PANEL_EDIT:
				tmp = editor_core.panel_scene_list.instance()
				tres[rec.stat] = []
				var scr = load(rec.script)
				tmp.set_script(scr)
				tmp.parent = self
				tmp.stat = rec.stat
				panel_nodes.push_back(tmp)
				col_containers[rec.container].add_child(tmp)
			editor_core.PANEL_FORM:
				tmp = editor_core.panel_scene.instance()
				var scr = load("res://editor tools/classes/stat_panel_form.gd")
				tmp.set_script(scr)
				tmp.parent = self
				tmp.stat = rec.stat
				panel_nodes.push_back(tmp)
				col_containers[rec.container].add_child(tmp)
			editor_core.PANEL_INT:
				tmp = editor_core.panel_scene.instance()
				var scr = load("res://editor tools/classes/stat_panel_int.gd")
				tmp.set_script(scr)
				tmp.parent = self
				tmp.stat = rec.stat
				panel_nodes.push_back(tmp)
				col_containers[rec.container].add_child(tmp)
			editor_core.PANEL_NUM:
				tmp = editor_core.panel_scene.instance()
				var scr = load("res://editor tools/classes/stat_panel_num.gd")
				tmp.set_script(scr)
				tmp.parent = self
				tmp.stat = rec.stat
				panel_nodes.push_back(tmp)
				col_containers[rec.container].add_child(tmp)
			editor_core.PANEL_OPTION:
				tmp = editor_core.panel_scene.instance()
				var scr = load("res://editor tools/classes/stat_panel_option.gd")
				tmp.set_script(scr)
				tmp.parent = self
				tmp.stat = rec.stat
				var list1 = rec.dlist.duplicate()
				list1.push_front("")
				var list2 = rec.rlist.duplicate()
				list2.push_front(null)
				tmp.data_array = list2
				tmp.hint_array = list1
				panel_nodes.push_back(tmp)
				col_containers[rec.container].add_child(tmp)
			editor_core.PANEL_SELECT:
				tmp = editor_core.panel_scene_list.instance()
				tres[rec.stat] = []
				var scr = load("res://editor tools/classes/stat_panel_list_select.gd")
				tmp.set_script(scr)
				tmp.parent = self
				tmp.stat = rec.stat
				var list1 = rec.dlist.duplicate()
				var list2 = rec.rlist.duplicate()
				tmp.data_array = list2
				tmp.hint_array = list1
				panel_nodes.push_back(tmp)
				col_containers[rec.container].add_child(tmp)
			editor_core.PANEL_STRING:
				tmp = editor_core.panel_scene.instance()
				var scr = load("res://editor tools/classes/stat_panel_str.gd")
				tmp.set_script(scr)
				tmp.parent = self
				tmp.stat = rec.stat
				panel_nodes.push_back(tmp)
				col_containers[rec.container].add_child(tmp)
			editor_core.PANEL_CUSTOM:
#				tmp = editor_core.panel_scene_list.instance()
#				tres[rec.stat] = []
				var scn = load(rec.scene)
				tmp = scn.instance()
				tmp.parent = self
				tmp.stat = rec.stat
				panel_nodes.push_back(tmp)
				col_containers[rec.container].add_child(tmp)
			editor_core.PANEL_TUNNEL:
				tmp = editor_core.panel_scene.instance()
				var scr = load("res://editor tools/classes/stat_panel_tunnel.gd")
				tmp.set_script(scr)
				tmp.parent = self
				tmp.stat = rec.stat
				tmp.editor = rec.scene
				tmp.tres = rec.init.duplicate()
				panel_nodes.push_back(tmp)
				col_containers[rec.container].add_child(tmp)
		for gr in rec.groups: tmp.add_to_group(gr)

func get_data(data):
	tres = data
	for node in panel_nodes:
		node.get_data()
	if prew_node == null:return
	prew_node.text = editor_core.display_res(tres, key)

func commit():
	hide()
	queue_free()

func revert():
	hide()
	queue_free()
