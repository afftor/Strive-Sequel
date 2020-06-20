extends WindowDialog

onready var valsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/valsel
onready var statsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/statsel

var parent
var type
var id
var newrec = true


func _ready():
	statsel.clear()
	for line in variables.slave_class_list: statsel.add_item(line)

func commit():
	if type == null: return
	var tres = [type, int(valsel.text)]
	if newrec: parent.tres.push_back(tres)
	else: parent.tres[id] = tres
	parent.update_val()
	hide()
	queue_free()

func revert():
	hide()
	queue_free()

func select_stat(id):
	type = statsel.get_item_text(id)

func get_data():
	valsel.text = str(parent.tres[id][1])
	statsel.select(variables.slave_class_list.find(parent.tres[id][0]))
