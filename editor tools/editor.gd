extends Panel

onready var inspector = $MarginContainer/VBoxContainer/HBoxContainer2/TabContainer
onready var prewnode = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/prewnode
onready var tablesel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/tablesel
onready var modname = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/modname
onready var actions = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer
onready var modalert = $AcceptDialog

func _ready():
	rect_size = OS.window_size
	editor_core.connect("editor_save", self, 'editor_save_changes')
	if modding_core.tables.size() == 0:
		actions.visible = false
		modalert.popup()
		return
	for t in modding_core.tables:
		tablesel.add_item(t)

	core_setup()
	select_table(0)

func show_data(args = null):
	var tab = inspector.get_current_tab_control()
	var data = tab.get_selected_data()
	if data == null: prewnode.text = ""
	else:
		prewnode.text = to_json(tab.get_selected_text())
		prewnode.text += ':'
		prewnode.text += editor_core.display_res(data)

func select_table(id):
	editor_core.current_table = tablesel.get_item_text(id)
	editor_core.current_mod = modding_core.mod_tables[editor_core.current_table]
	modname.text = editor_core.current_mod
	for t in inspector.get_children():
		t.setup_tables()
		t.rebuild_list()

func save_changes():
	var patch = parse_json("{%s}" % prewnode.text)
	if patch == null: return
	editor_core.apply_patch(patch)
	var tab = inspector.get_current_tab_control()
	tab.setup_tables()
	tab.rebuild_list()

func core_setup(arg = null):
	var tab = inspector.get_current_tab_control()
	editor_core.current_table_mod = tab.get_subtable_name()
	editor_core.current_base_table = tab.table

func editor_save_changes():
	prewnode.text = ""
	var tab = inspector.get_current_tab_control()
	tab.rebuild_list()

func save_mod():
	modding_core.save_table(editor_core.current_table)


func add_record():
	var tab = inspector.get_current_tab_control()
	var editor = tab.get_editor_scene()
	var tmp = editor.instance()
	tmp.parent = self
	add_child(tmp)
	tmp.popup()

func edit_record():
	var tab = inspector.get_current_tab_control()
	var key = tab.get_selected_text()
	if key == null: return
	var editor = tab.get_editor_scene()
	var tmp = editor.instance()
	tmp.parent = self
	tmp.key = key
	add_child(tmp)
	tmp.get_data()
	tmp.popup()

func create_mod():
	modding_core.create_empty_mod()
	for t in modding_core.tables:
		tablesel.add_item(t)
	actions.visible = true
	core_setup()
	select_table(0)


func exit():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [input_handler, 'quit', "Exit program?"])
#	input_handler.quit()
