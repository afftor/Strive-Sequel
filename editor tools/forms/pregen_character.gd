extends WindowDialog

onready var codeedit = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/codeedit
var code
onready var prew_node = $MarginContainer/VBoxContainer/Label
var tres = {}
onready var stat_node = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer3/VBoxContainer/ItemList

var parent 

func _ready():
	$MarginContainer/VBoxContainer/HBoxContainer/PanelContainer3/VBoxContainer/actions/new.connect('pressed', self, 'add_rec')
	$MarginContainer/VBoxContainer/HBoxContainer/PanelContainer3/VBoxContainer/actions/edit.connect('pressed', self, 'edit_rec')
	$MarginContainer/VBoxContainer/HBoxContainer/PanelContainer3/VBoxContainer/actions/delete.connect('pressed', self, 'delete_rec')


func add_rec():
	var tmp = editor_core.stat_change_scene.instance()
	tmp.parent = self
	add_child(tmp)
	tmp.popup()

func edit_rec():
	if stat_node.get_selected_items().size() == 0: return
	var pos = stat_node.get_selected_items()[0]
	var tmp = editor_core.stat_change_scene.instance()
	tmp.parent = self
	tmp.stat = stat_node.get_item_metadata(pos)
	add_child(tmp)
	tmp.get_data()
	tmp.popup()

func delete_rec():
	if stat_node.get_selected_items().size() == 0: return
	var pos = stat_node.get_selected_items()[0]
	tres.erase(stat_node.get_item_metadata(pos))
	update_val()
#	fill_list()

func update_val():
	fill_list()
	prew_node.text = editor_core.display_res(tres, code)

func fill_list():
	stat_node.unselect_all()
	stat_node.clear()
	for c in tres:
		if c == 'code': continue
		var text = editor_core.display_res(tres[c], c)
		stat_node.add_item(text)
		stat_node.set_item_metadata(stat_node.get_item_count() -1, c)

func get_data(data = null):
	var tmp = worlddata.pregen_characters[code]
	if data != null: tmp = data
	tres = tmp.duplicate()
	codeedit.text = tres.code
	update_val()

func code_set(text):
	code = text
	tres.code = code
	prew_node.text = editor_core.display_res(tres)

func commit():
	var tmp = parse_json(prew_node.text)
	if typeof(tmp) != TYPE_DICTIONARY: return
	if !tmp.has('code') or tmp.code == null or tmp.code == "": return
	var tt = {}
	tt[tmp.code] = tmp
	editor_core.apply_patch(tt, true)
	hide()
	queue_free()

func revert():
	hide()
	queue_free()
