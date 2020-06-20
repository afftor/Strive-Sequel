extends WindowDialog

onready var valsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/valsel
onready var statsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/statsel

var parent
var stat
var id
var newrec = true


func _ready():
	statsel.clear()
	for line in Statlist_init.template.keys(): statsel.add_item(line)

func commit():
	if stat == null: return
	parent.tres[stat] = valsel.text
	parent.update_val()
	hide()
	queue_free()

func revert():
	hide()
	queue_free()

func select_stat(id):
	stat = statsel.get_item_text(id)

func get_data():
	valsel.text = str(parent.tres[stat])
	statsel.select(Statlist_init.template.keys().find(stat))
