extends PanelContainer

var parent = null
var stat_node
var stat
var stat_desc = null

func _ready():
	if stat_desc != null: $VBoxContainer/name.text = stat_desc
	else: $VBoxContainer/name.text = stat

func check_value():
	if !visible: return
	parent.tres[stat] = input_handler.get_value_node(stat_node)

func commit(id = null, flag = null):
	parent.update_res()

func update_res():
	parent.update_res()

func update_val():
	pass
