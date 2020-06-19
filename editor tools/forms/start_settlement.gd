extends WindowDialog

onready var valsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/valsel
onready var valsel2 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer3/VBoxContainer/valsel2
onready var statsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/statsel


var parent
var stat = null

var settlement_list = editor_core.get_list_cond(worlddata.locations, 'code', 'code', 'type', 'settlement')

func _ready():
	statsel.clear()
	for line in settlement_list: statsel.add_item(line)
	select_stat(0)

func commit():
	if stat == null: return
	parent.tres[stat] = [int(valsel.text), int(valsel2.text)]
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
	statsel.select(settlement_list.find(stat))
