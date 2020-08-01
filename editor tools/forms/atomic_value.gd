extends "res://editor tools/classes/record_panel.gd"

var id
var newrec = true

onready var d_prew = $MarginContainer/VBoxContainer/Label3
onready var parsel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/parent
onready var modesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/mode
onready var opsel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4/operand
onready var valedit = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer6/const
onready var modsel2 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer7/type
onready var arglist = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer8/arg
onready var attredit = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer9/arg
onready var fromedit = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer10/arg
onready var toedit = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer11/arg

var par_eff = null

var modes1 = ['constant', 'operation with constant', 'operation with sub-value', 'effect argument']
var modes2 = ['parent_args', 'parent_arg_get', 'random']
var ops = ['+', '-', '*', '/']

func _ready():
	prew_node = $MarginContainer/VBoxContainer/Label
	key = null
	tres = []
	tres.resize(3)
	for m in modes1: modesel.add_item(m)
	for m in modes2: modsel2.add_item(m)
	for o in ops: opsel.add_item(o)
	for e in Effectdata.effect_table: parsel.add_item(e)
	mode_select(0)
	attredit.connect("text_entered", self, 'update_res')


func get_data(dir = null):
	var data
	if newrec: data = parent.tres.duplicate(true)
	else: data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	key = null
#	.get_data(data)
	if data == null: return
	if typeof(data[0]) == TYPE_ARRAY:
		opsel.select(ops.find(data[1]))
		if typeof(data[2]) == TYPE_ARRAY: 
			mode_select(2)
		else:
			valedit.text = str(data[2])
			mode_select(1)
	elif  typeof(data[0]) == TYPE_STRING: 
		mode_select(2)
		match data[0]:
			'parent_args':
				mode2_select(0)
				arglist.select(data[1])
			'parent_arg_get':
				mode2_select(1)
				arglist.select(data[1])
				attredit.text = data[2]
			'random':
				mode2_select(2)
				fromedit.text = str(data[1])
				toedit.text = str(data[2])
	else: #0
		mode_select(0)
		valedit.text = str(data[0])

func commit():
	tres = parse_json(prew_node.text)
	if tres == null: return
	if newrec:
		parent.tres.push_back(tres)
	else:
		parent.tres[id] = tres
	parent.update_val()
	.commit()

func update_res(arg = null):
#	.update_res()
	match modesel.selected:
		0:
			tres.resize(1)
			tres[0] = float(valedit.text)
		1:
			tres[1] = opsel.get_item_text(opsel.selected)
			tres[2] = float(valedit.text)
		2:
			tres[1] = opsel.get_item_text(opsel.selected)
		3:
			var sel = modsel2.selected
			tres[0] = modsel2.get_item_text(sel)
			match sel:
				0:
					tres.resize(2)
					tres[1] = arglist.selected
				1:
					tres.resize(3)
					tres[1] = arglist.selected
					tres[2] = attredit.text
				2:
					tres.resize(3)
					tres[1] = float(fromedit.text)
					tres[2] = float(toedit.text)
#	d_prew.text = "({value1} * <corresponding attack>  + {value2}) * (1 + <corresponding stat>/100) + {value3}".format(tres)
	prew_node.text = to_json(tres)
	d_prew.text = prew_res(tres)

func prew_res(arr):
	var res = ""
	var p1 = ""
	var p2 = ""
	var p3 = ""
	if typeof(arr[0]) == TYPE_ARRAY: #1, 2
		p1 = prew_res(arr[0])
		p2 = arr[1]
		if typeof(arr[2]) == TYPE_ARRAY: 
			p3 = prew_res(arr[2])
		else:
			p3 = str(arr[2])
		res = "(%s %s %s)" % [p1, p2, p3]
	elif  typeof(arr[0]) == TYPE_STRING: #3
		match arr[0]:
			'parent_args':
				if par_eff == null: res = "(<argument %d>)" % arr[1]
				else:
					var eff = Effectdata.effect_table[par_eff]
					if !eff.has('args'): res = "(<argument %d>)" % arr[1]
					else:
						var arg_list = eff.args
						var arg = arg_list[arr[1]]
						if arg.has('description'): res = "(%s)" % arg.description
						else: res = "(<argument %d>)" % arr[1]
			'parent_arg_get':
				if par_eff == null: res = "(<argument %d>.%s)" % [arr[1], arr[2]]
				else:
					var eff = Effectdata.effect_table[par_eff]
					if !eff.has('args'): res = "(<argument %d>.%s)" % [arr[1], arr[2]]
					else:
						var arg_list = eff.args
						var arg = arg_list[arr[1]]
						if arg.has('description'): res = "(%s.%s)" % [arg.description, arr[2]]
						else: res = "(<argument %d>.%s)" % [arr[1], arr[2]]
			'random':
				res = "(%f .. %f)" % [arr[1], arr[2]]
	else: #0
		res = "(%f)" % arr[0]
	return res

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

func mode2_select(id):
	modsel2.selected = id
	var modegroup = "mode3%d" % (id + 1)
	for a in get_tree().get_nodes_in_group('arg'):
		a.visible = a.is_in_group(modegroup)
	update_res()


func call_form1():
	var tmp = editor_core.atomic_value_scene.instance()
	add_child(tmp)
	tmp.parent = self
	tmp.id = 0
	tmp.newrec = false
	tmp.par_eff = par_eff
	tmp.fill_arg_list()
	tmp.get_data()
	tmp.popup()

func call_form2():
	var tmp = editor_core.atomic_value_scene.instance()
	add_child(tmp)
	tmp.parent = self
	tmp.id = 2
	tmp.newrec = false
	tmp.par_eff = par_eff
	tmp.fill_arg_list()
	tmp.get_data()
	tmp.popup()
