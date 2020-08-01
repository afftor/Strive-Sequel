extends WindowDialog

onready var effsel = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/effselect
onready var template = $MarginContainer/VBoxContainer/PanelContainer2/VBoxContainer/HBoxContainer2/CheckBox
onready var chance = $MarginContainer/VBoxContainer/PanelContainer2/VBoxContainer/HBoxContainer3/CheckBox
onready var duration = $MarginContainer/VBoxContainer/PanelContainer2/VBoxContainer/HBoxContainer4/CheckBox
onready var process = $MarginContainer/VBoxContainer/PanelContainer2/VBoxContainer/HBoxContainer5/CheckBox
onready var descedit = $MarginContainer/VBoxContainer/PanelContainer3/VBoxContainer/commedit

var parent
var id
var newrec = true
var tres

func _ready():
	effsel.clear()
	for e in Effectdata.effect_table: effsel.add_item(e)

func construct_res():
	var args = {}
	args.effect = effsel.get_item_text(effsel.selected)
	if chance.pressed: args.duration = float(chance.get_parent().get_node("chance").text)
	if duration.pressed: args.duration = int(duration.get_parent().get_node("duration").text)
	if process.pressed: args.push_value = true
	return Effectdata.rebuild_template(args)

func commit():
	if template.pressed: 
		tres = construct_res()
		if descedit.text != "": tres.description = descedit.text
	else: tres = effsel.get_item_text(effsel.selected)
	
	if newrec: parent.tres.push_back(tres)
	else: parent.tres[id] = tres
	parent.update_val()
	hide()
	queue_free()

func revert():
	hide()
	queue_free()


func get_data():
	pass


func _on_CheckBox_toggled(button_pressed):
	if button_pressed:
		chance.disabled = false
		duration.disabled = false
		process.disabled = false
	else:
		chance.disabled = true
		duration.disabled = true
		process.disabled = true
