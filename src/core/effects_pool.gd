extends Node
# warning-ignore-all:return_value_discarded

var effects: = {}
var stacks: = {}


func get_new_id():
	var s := "eid%d"
	var t = randi()
	while effects.has(s % t):
		t += 1
	return s % t


func get_new_stack_id():
	var s := "sid%d"
	var t = randi()
	while stacks.has(s % t):
		t += 1
	return s % t


func add_effect(eff):
	var id = get_new_id()
	effects[id] = eff
	eff.id = id
	return id


func add_stored_effect(id, eff):
	effects[id] = eff


func discard_effect(id):
	effects.erase(id)


func get_effect_by_id(id):
	if !effects.has(id): 
		print("effect %s not found" % id)
		return null
	return effects[id]


func get_stack_by_id(id):
	if !stacks.has(id): 
		print("stack %s not found" % id)
		return null
	return stacks[id]


func process_event(ev, obj = null):
	for eff in effects.values():
		if !(eff is temp_e_global):
			continue
		eff.process_event(ev, obj)


func make_stack(code, store = true):
	var res
	var data = Effectdata.stacks[code]
	match data.type:
		'stack':
			res = eff_stack.new()
		'stack_a':
			res = eff_stack_aggregate.new()
		'stack_c':
			res = eff_stack_cumulative.new()
		'stack_l':
			res = eff_stack_limit.new()
		'stack_s':
			res = eff_stack_single.new()
		'stack_t':
			res = eff_stack_toggle.new()
	res.create_from_template(code) 
	if store:
		res.id = get_new_stack_id()
		stacks[res.id] = res
	return res


func clone_stack(id):
	var oldstack = stacks[id]
	var newstack = make_stack(oldstack.code, false)
	newstack.effects = oldstack.effects.duplicate()
	newstack.owner = oldstack.owner
	return newstack


func deserialize_stack(tmp, id):
	var eff
	match tmp.type:
		'stack':
			eff = eff_stack.new()
		'stack_a':
			eff = eff_stack_aggregate.new()
		'stack_c':
			eff = eff_stack_cumulative.new()
		'stack_l':
			eff = eff_stack_limit.new()
		'stack_s':
			eff = eff_stack_single.new()
		'stack_t':
			eff = eff_stack_toggle.new()
	eff.deserialize(tmp)
	return eff


func cleanup():
	for id in effects.keys().duplicate():
		if !effects[id].is_applied:
#			print("effect %s is removed as marked for cleanup" % id)
#			print(effects[id].template)
			remove_id(id)
			continue
		if effects[id].get_applied_obj() == null:
			print("effect %s is removed as applied to no one" % id)
#			print(effects[id].template)
			remove_id(id)
	for id in stacks.keys().duplicate():
		if stacks[id].effects.empty():
			stacks.erase(id)


func remove_id(id):
	for eff in effects.values():
		if typeof(eff.parent) == TYPE_STRING and eff.parent == id:
			eff.parent = null
		if eff.sub_effects.has(id):
			eff.sub_effects.erase(id)
	effects.erase(id)


func get_effects_linked_to(char_id):
	var res = []
	for e in effects.values():
		if !e.is_applied: continue
		if e.args.has(char_id): res.push_back(e)
	return res


func get_n_effects_linked_to(char_id, eff_n):
	var res = []
	for e in get_effects_linked_to(char_id):
		if e.template.has('name') && e.template.name == eff_n:
			res.push_back(e)
	return res


func serialize():
	cleanup()
	var tmp = {}
	for e in effects.keys():
		tmp[e] = effects[e].serialize()
	for e in stacks.keys():
		tmp[e] = stacks[e].serialize()
	return tmp


func deserialize_effect(tmp, id, caller = null):
	var eff
	match tmp.type:
		'base': 
			eff = base_effect.new(caller)
		'trigger': 
			eff = triggered_effect.new(caller)
		'temp_s': 
			eff = temp_e_simple.new(caller)
		'temp_global': 
			eff = temp_e_global.new(caller)
	eff.id = id
	eff.deserialize(tmp)
	return eff


func e_createfromtemplate(buff_t, caller = null):
	var template
	var tmp
	if typeof(buff_t) == TYPE_STRING:
		template = Effectdata.effect_table[buff_t]
	else:
		template = buff_t.duplicate()
	match template.type:
		'base': 
			tmp = base_effect.new(caller)
		'trigger': 
			tmp = triggered_effect.new(caller)
		'temp_s': 
			tmp = temp_e_simple.new(caller)
		'oneshot': 
			tmp = oneshot_effect.new(caller)
		'temp_global': 
			tmp = temp_e_global.new(caller)
		_: 
			print ('wrong eff type - %s' % template.type)
			return null
	tmp.createfromtemplate(template)
	return tmp


func deserialize(tmp):
	effects.clear()
	stacks.clear()
	for k in tmp.keys():
		if k.begins_with('eid'):
			var eff = deserialize_effect(tmp[k], k)
			effects[k] = eff
		elif k.begins_with('sid'):
			var eff = deserialize_stack(tmp[k], k)
			stacks[k] = eff


func clean_effects_for_char(id):
	for e in effects.values():
		if !e.is_applied:
			 continue
		if e.owner is String and e.owner == id:
			e.remove()
