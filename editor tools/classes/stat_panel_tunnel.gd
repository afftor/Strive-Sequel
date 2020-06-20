extends "res://editor tools/classes/stat_panel.gd"

var editor
var tres = {}

func _ready():
	$VBoxContainer/index.visible = false
	$VBoxContainer/number.visible = false
	$VBoxContainer/formula.visible = false
	$VBoxContainer/string.visible = false
	$VBoxContainer/reslist.visible = false
	$VBoxContainer/flag.visible = false
	$VBoxContainer/Button.visible = true

	stat_node = $VBoxContainer/Button
	stat_node.connect('pressed', self, 'open_editor')
#	._ready()

func get_data():
	if !visible: return
	if parent.tres.has(stat):
		tres = parent.tres[stat]

func open_editor():
	var tmp = load(editor).instance()
	tmp.parent = self
	add_child(tmp)
	tmp.get_data()
	tmp.popup()

func update_val():
	parent.update_res()

func check_value():
	if !visible: return
	parent.tres[stat] = tres
