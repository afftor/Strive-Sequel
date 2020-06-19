extends WindowDialog

onready var valsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/valsel
onready var valsel2 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer3/VBoxContainer/valsel2
onready var statsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/statsel


var parent
var stat = null


func _ready():
	statsel.clear()
	for line in Statlist_init.template.keys(): statsel.add_item(line)

func commit():
	if stat == null: return
	parent.tres[stat] = [float(valsel.text), float(valsel2.text)]
	parent.update_val()
	hide()
	queue_free()

func revert():
	hide()
	queue_free()

func select_stat(id):
	stat = statsel.get_item_text(id)

func get_data():
	valsel.text = str(parent.tres[stat][0])
	valsel2.text = str(parent.tres[stat][1])
	statsel.select(Statlist_init.template.keys().find(stat))
