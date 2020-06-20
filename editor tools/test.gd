extends Control

func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	var panel = editor_core.pregen_c_scene
	var tmp = panel.instance()
	tmp.parent = self
	add_child(tmp)
	tmp.popup()

func update_res():
	pass
