extends WindowDialog

onready var valsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/valsel
onready var statsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/statsel

var parent
var id
var newrec = true
var race

func _ready():
	statsel.clear()
	for line in races.racelist.keys(): statsel.add_item(line)
	select_stat(0)

func commit():
	var tres = [race, int(valsel.text)]
	if newrec: parent.tres.push_back(tres)
	else:
		parent.tres[id] = tres
	parent.update_val()
	hide()
	queue_free()

func revert():
	hide()
	queue_free()

func select_stat(id):
	race = statsel.get_item_text(id)

func get_data():
	valsel.text = str(parent.tres[id][1])
	statsel.select(races.racelist.keys().find(parent.tres[id][0]))
