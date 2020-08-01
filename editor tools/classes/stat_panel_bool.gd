extends "res://editor tools/classes/stat_panel.gd"


func _ready():
	$VBoxContainer/index.visible = false
	$VBoxContainer/number.visible = false
	$VBoxContainer/formula.visible = false
	$VBoxContainer/string.visible = false
	$VBoxContainer/reslist.visible = false
	$VBoxContainer/flag.visible = true
	$VBoxContainer/Button.visible = false
	stat_node = $VBoxContainer/flag
	stat_node.connect('pressed', self, 'commit')
#	._ready()

func get_data():
	if !visible: return
	if parent.tres.has(stat):
		var tmp = parent.tres[stat]
		stat_node.pressed = tmp

func set_value(res:bool):
	stat_node.pressed = res
