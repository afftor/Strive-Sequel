extends Panel


onready var avmods = $MarginContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/avModsContainer
onready var lmods = $MarginContainer/HBoxContainer/PanelContainer2/MarginContainer/VBoxContainer/ScrollContainer/lModsContainer

var av_mods = []
var l_mods = []

func _ready():
	populate_avail_mods()
	populate_l_mods()
	$Button.connect("pressed", self, 'open_editor')

func open_editor():
	var editor = load("res://editor tools/editor.tscn").instance()
	get_parent().add_child(editor)

func populate_avail_mods():
	av_mods = modding_core.get_avail_mods()
	input_handler.ClearContainerForced(avmods)
	for mod in av_mods:
		var newbutton = input_handler.DuplicateContainerTemplate(avmods)
		newbutton.name = mod.name
		newbutton.set_text(mod.name)
		globals.connecttexttooltip(newbutton, modding_core.make_desc(mod))
		newbutton.connect("pressed", self, "on_ModButton_pressed", [newbutton, avmods])
		newbutton.show()
	l_mods = modding_core.mods_list.duplicate()

func populate_l_mods():
	input_handler.ClearContainerForced(lmods)
	#make buttons
	for mod in l_mods:
		var newbutton = input_handler.DuplicateContainerTemplate(lmods)
		newbutton.name = mod.name
		newbutton.set_text(mod.name)
		globals.connecttexttooltip(newbutton, modding_core.make_desc(mod))
		newbutton.connect("pressed", self, "on_ModButton_pressed", [newbutton, lmods])
		newbutton.show()
		mod.button = newbutton
	#check for conflicts and change button labels if needed
	for mod in l_mods:
		var newtext = ""
		var newdesc = ""
		
		var c = detect_conflicts(mod)
		if not c.empty(): 
			newtext += " [color=red]!Conflict![/color]!"
			var conflict_dump = ""
			for conflict in c:
				conflict_dump += "%s:%s:%s\n" % [conflict.mod, conflict.class]
			newdesc += conflict_dump + "\n"
		
		var dep = detect_missing_dependencies(mod)
		if not dep.empty():
			newtext += " [color=red]!Missing![/color]"
			for d in dep:
				newdesc += "Missing Dependency: %s\n" % d
		
		if newtext != "":
			mod.button.set_text( mod.button.get_text() + newtext )
			globals.connecttexttooltip(mod.button, newdesc)
		

func add_mod():
	if av_mods.size() == 0: return
	var modNode = get_pressed_button(avmods)
	if modNode == null: return
	var tmp = av_mods[modNode.get_index()]
	for m in l_mods: if m.path == tmp.path : return
	l_mods.push_back(tmp)
	populate_l_mods()

func remove_mod():
	var modNode = get_pressed_button(lmods)
	if modNode == null: return
	if l_mods.size() == 0: return
	l_mods.remove(modNode.get_index())
	populate_l_mods()

func m_up():
	if l_mods.size() <= 1: return
	var modNode = get_pressed_button(lmods)
	if modNode == null: return
	var pos = modNode.get_index()
	if pos == 0: return
	var tmp = l_mods[pos].duplicate()
	l_mods[pos] = l_mods[pos - 1]
	l_mods[pos - 1] = tmp
	populate_l_mods()
	lmods.get_child(pos - 1).pressed = true

func m_down():
	if l_mods.size() <= 1: return
	var modNode = get_pressed_button(lmods)
	if modNode == null: return
	var pos = modNode.get_index()
	if pos == l_mods.size() - 1: return
	
	var tmp = l_mods[pos].duplicate()
	l_mods[pos] = l_mods[pos + 1]
	l_mods[pos + 1] = tmp
	populate_l_mods()
	
	lmods.get_child(pos + 1).pressed = true

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

func unpress_buttons(node):
	for button in node.get_children():
		if button.get_class() != "Button":
			continue
		button.pressed = false

func get_pressed_button(listNode):
	for n in listNode.get_children():
		if n.pressed:
			return n
	return null

func on_ModButton_pressed(button, listNode):
	unpress_buttons(listNode)
	button.pressed = true

func check_lower_extensions(mod, checked):
	var found = []
	for Class in mod.replacedMethods:
		if not checked.extendedMethods.has(Class): continue
		var conflict = { mod = mod.name, class = Class, type = 'lower_extension' }
		
		#conflict mod is load first
		if mod.replacedMethods[Class][0] == "*":
			found.push_back(conflict)
			continue
		
		#conflict checked is load last
		if checked.extendedMethods[Class][0] == "*":
			found.push_back(conflict)
			continue
		
		#conflict if mod replaces anything that checked extends
		for ReplacedMethod in mod.replacedMethods[Class]:
			if checked.extendedMethods[Class].has(ReplacedMethod):
				found.push_back(conflict)
	return found

func check_lower_replacements(mod, checked):
	var found = []
	for Class in mod.replacedMethods:
		if not checked.replacedMethods.has(Class): continue
		var conflict = { mod = mod.name, class = Class, type = 'lower_replacement' }
		
		#conflict if checked and mod replace the same thing
		for ReplacedMethod in mod.replacedMethods[Class]:
			if checked.replacedMethods[Class].has(ReplacedMethod):
				found.push_back(conflict)
	return found

func check_higher_replacements(mod, checked):
	var found = []
	for Class in mod.extendedMethods:
		if not checked.replacedMethods.has(Class): continue
		var conflict = { mod = mod.name, class = Class, type = 'higher_replacement' }
		
		#conflict mod is load last
		if mod.extendedMethods[Class][0] == "*":
			found.push_back(conflict)
			continue
		
		#conflict checked is load first
		if checked.replacedMethods[Class][0] == "*":
			found.push_back(conflict)
			continue
		
		#conflict checked replaces something that mod extends
		for ExtendedMethod in mod.extendedMethods[Class]:
			if checked.replacedMethods[Class].has(ExtendedMethod):
				found.push_back(conflict)
	return found

func detect_conflicts(mod):
	var mbutton
	var conflicts = []
	for n in lmods.get_children():
		if n.name == mod.name:
			mbutton = n
	var pos = mbutton.get_index()
	
	var counter = 0
	for m in l_mods:
		if counter < pos:
			conflicts += check_lower_extensions(mod, m)
			conflicts += check_lower_replacements(mod, m)
		if counter > pos:
			conflicts += check_higher_replacements(mod, m)
		counter += 1
	return conflicts

func detect_missing_dependencies(mod):
	var ret_arr = []
	for Required in mod.required:
		var fFound = false
		for m in l_mods.slice(0, l_mods.find(mod)):
			if m.name == Required: 
				fFound = true
				break
		if !fFound:
			ret_arr.append(Required)
	return ret_arr

func mod_sorter(a,b):
	if a.name in b.required + b.optional: return true
	for Class in a.replacedMethods:
		if b.extendedMethods.has(Class):
			if a.replacedMethods[Class][0] == "*": return true
			if b.extendedMethods[Class][0] == "*": return true
			for Method in a.replacedMethods[Class]:
				if b.extendedMethods[Class].has(Method): return true
	return false

func make_before_list(mod):
	mod.before = []
	for m in l_mods:
		if m.name == mod.name: continue
		if mod_sorter(mod,m): mod.before += [m.name]

func name_sort_mods(a,b):
	a = a.name
	b = b.name
	var d = 0
	for c in a:
		if c < b[d]: return true
		elif c > b[d]: return false
		d += 1
	return false
		

func sort_mods():
	#generic sort first
	l_mods.sort_custom(self, 'name_sort_mods')
	for m in l_mods:
		make_before_list(m)
	var sorted_mods = []
	for m in l_mods:
		#empty case
		if sorted_mods.empty():
			sorted_mods.push_back(m)
			continue
		#insert earliest possible
		var inserted = false
		var last = sorted_mods.size()-1
		for sm in sorted_mods.size():
			if m.name in sorted_mods[last-sm].before:
				sorted_mods.insert(last-sm+1, m)
				inserted = true
				break
		#insert at the start
		if not inserted:
			sorted_mods.push_front(m)
	l_mods = sorted_mods
	populate_l_mods()

func on_loadall_pressed():
	l_mods = modding_core.get_avail_mods()
	sort_mods()
	populate_l_mods()

func on_unloadall_pressed():
	l_mods.clear()
	populate_l_mods()

func on_sort_pressed():
	sort_mods()
