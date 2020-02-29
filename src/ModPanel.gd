extends Panel


onready var avmods = $MarginContainer/HBoxContainer/PanelContainer/MarginContainer/ScrollContainer2
onready var lmods = $MarginContainer/HBoxContainer/PanelContainer2/MarginContainer/ScrollContainer2

var av_mods = []
var l_mods = []

func _ready():
	populate_avail_mods()
	populate_l_mods()

func populate_avail_mods():
	av_mods = modding_core.get_avail_mods()
	for mod in av_mods:
		avmods.add_item("%s - %s" % [mod.name, mod.desc])
	l_mods = modding_core.mods_list.duplicate()

func populate_l_mods():
	lmods.clear()
	for mod in l_mods:
		lmods.add_item(mod.name)

func add_mod():
	if av_mods.size() == 0: return
	var tmp = av_mods[avmods.get_selected_items()[0]]
	for m in l_mods: if m.path == tmp.path : return
	l_mods.push_back({name = tmp.name, path = tmp.path})
	populate_l_mods()

func remove_mod():
	if l_mods.size() == 0: return
	l_mods.remove(lmods.get_selected_items()[0])
	populate_l_mods()

func m_up():
	if l_mods.size() <= 1: return
	var pos = lmods.get_selected_items()[0]
	if pos == 0: return
	var tmp = l_mods[pos].duplicate()
	l_mods[pos] = l_mods[pos - 1]
	l_mods[pos - 1] = tmp
	populate_l_mods()
	lmods.select(pos - 1)

func m_down():
	if l_mods.size() <= 1: return
	var pos = lmods.get_selected_items()[0]
	if pos == l_mods.size() - 1: return
	var tmp = l_mods[pos].duplicate()
	l_mods[pos] = l_mods[pos + 1]
	l_mods[pos + 1] = tmp
	populate_l_mods()
	lmods.select(pos + 1)

func on_cancel():
	visible = false
	l_mods = modding_core.mods_list.duplicate()
	populate_l_mods()

func on_ok():
	modding_core.mods_list = l_mods
	modding_core.save_mod_list()
	$AcceptDialog.popup()


func _on_AcceptDialog_confirmed():
	$AcceptDialog.hide()
