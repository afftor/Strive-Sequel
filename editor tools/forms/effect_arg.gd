extends "res://editor tools/classes/record_panel.gd"

var id
var newrec = true

onready var descedit = $MarginContainer/VBoxContainer/HBoxContainer/desc_panel/VBoxContainer/desc
onready var d_prew = $MarginContainer/VBoxContainer/Label3
onready var parsel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/parent
onready var modesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/mode
onready var arglist = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer8/arg
onready var attredit = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer9/attr
onready var attrlist = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer10/attr
onready var skillatr = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer12/attr
onready var dyncheck = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer11/dyn

var par_eff = null

var modes = ['self', 'template', 'parent_args', 'parent_arg_get', 'app_obj', 'parent']
var modes_d = ['outer-specified argument of self', 'attribue from template', 'arg of parent effect', 'attribute of arg of parent effect', 'applied object if character', 'parent if skill']

func change_description(newtext):
	tres.description = newtext
	update_res()

func _ready():
	prew_node = $MarginContainer/VBoxContainer/Label
	descedit.connect("text_entered", self, 'change_description')
	key = null
	tres = {}
	for m in range(modes.size()): 
		modesel.add_item(modes_d[m])
	mode_select(0)
	for attr in ['hp', 'mp', 'shield', 'base_exp'] + Statlist_init.template.keys():
		attrlist.add_item(attr)
	for attr in ['process_value', 'caster', 'target']:
		skillatr.add_item(attr)


func get_data(dir = null):
	var data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	key = null
#	.get_data(data)
	if data == null: return
	tres = data
	mode_select(modes.find(tres.obj))
	update_res()

func commit():
	tres = parse_json(prew_node.text)
	if tres == null: return
	if newrec:
		parent.tres.push_back(tres)
	else:
		parent.tres[id] = tres
	parent.update_val()
	.commit()

func prew_res():
	var res = ""
	match tres.obj:
		'self','template','app_obj': res = "%s.%s" % [tres.obj, tres.param]
		'parent_args': 
			res = arglist.get_item_text(tres.param)
		'parent_arg_get':
			res = "%s.%s" % [arglist.get_item_text(tres.index), tres.param]
		'parent':
			res = "skill.%s" % [tres.param]
	return res

func update_res():
#	.update_res()
	tres.clear()
	tres.obj = modes[modesel.selected]
	if descedit.text == "": tres.erase('comment')
	if arglist.is_visible_in_tree(): 
		if tres.obj == 'parent_args':
			tres.param = arglist.selected
		else:
			tres.index = arglist.selected
	if attredit.is_visible_in_tree(): tres.param = attredit.text
	if attrlist.is_visible_in_tree(): tres.param = attrlist.get_item_text(attrlist.selected)
	if skillatr.is_visible_in_tree(): tres.param = skillatr.get_item_text(skillatr.selected)
	if dyncheck.pressed: tres.dynamic = true
#	d_prew.text = "({value1} * <corresponding attack>  + {value2}) * (1 + <corresponding stat>/100) + {value3}".format(tres)
	prew_node.text = to_json(tres)
	d_prew.text = prew_res()



func fill_arg_list():
	arglist.clear()
	if par_eff == null: return
	var eff = Effectdata.effect_table[par_eff]
	if !eff.has('args'): return
	var arg_list = eff.args
	for arg in arg_list:
		if arg.has('comment'): arglist.add_item(arg.comment)
		else: arglist.add_item("argument %d" % arglist.get_item_count())


func select_parent(id):
	par_eff = parsel.get_item_text(id)
	fill_arg_list()
	update_res()

func mode_select(id):
	modesel.selected = id
	var modegroup = "mode%d" % id
	for a in get_tree().get_nodes_in_group('arg'):
		a.visible = a.is_in_group(modegroup)
	update_res()

