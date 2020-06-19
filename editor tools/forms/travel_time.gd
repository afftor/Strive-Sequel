extends WindowDialog
#effectively minmax.gd
onready var valsel = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/valsel
onready var valsel2 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer3/VBoxContainer/valsel2


var parent


func commit():
	parent.tres = [float(valsel.text), float(valsel2.text)]
	parent.update_val()
	hide()
	queue_free()

func revert():
	hide()
	queue_free()


func get_data():
	valsel.text = str(parent.tres[0])
	valsel2.text = str(parent.tres[1])
