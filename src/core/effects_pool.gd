extends Node
# warning-ignore-all:return_value_discarded

var effects: = {}
var stacks: = {}

const LEGACY_EFFECTS_TO_RETIRE = ['e_food_like', 'e_food_dislike']


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
	var doomed := {}
	for id in effects:
		var eff = effects[id]
		if !eff.is_applied:
			doomed[id] = true
		elif eff.get_applied_obj() == null:
			print("effect %s is removed as applied to no one" % id)
			doomed[id] = true
	if !doomed.empty():
		remove_ids(doomed)
	for id in stacks.keys().duplicate():
		if stacks[id].effects.empty():
			stacks[id].cleanup()
			stacks.erase(id)


func postload():
	for eff in effects.values():
		if eff.template.type != 'trigger':
			eff.fill_sub_effects()


#One pass over the pool for the whole batch. Removing effects one at a time cost a full
#scan of every effect and every stack per removal, so a save paid dead_count x pool_size -
#seconds of main-thread time once the pool grew.
func remove_ids(doomed: Dictionary):
	for eff in effects.values():
		if typeof(eff.parent) == TYPE_STRING and doomed.has(eff.parent):
			eff.parent = null
		for i in range(eff.sub_effects.size() - 1, -1, -1):
			if doomed.has(eff.sub_effects[i]):
				eff.sub_effects.remove(i)
	for stack in stacks.values():
		for sid in stack.effects.keys():
			if doomed.has(sid):
				stack.effects.erase(sid)
	for id in doomed:
		effects.erase(id)


func remove_id(id):
	remove_ids({id: true})


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


func get_effects_for_char(id, stored = false):
	var res = []
	for e in effects.values():
		if !e.is_applied:
			 continue
		if stored and !e.is_stored:
			continue
		if e.owner is String and e.owner == id:
			res.push_back(e)
	return res


func serialize():
	cleanup()
	var tmp = {}
	for e in effects.keys():
		if !effects[e].is_stored:
			continue
		tmp[e] = effects[e].serialize()
	for e in stacks.keys():
		tmp[e] = stacks[e].serialize()
	return tmp


func deserialize_effect(tmp, id, caller = null):
	if !tmp.has('type'):
		print("effect %s is missing its saved type and was not loaded" % id)
		return null
	if tmp.has('template') and tmp.template is String:
		if !Effectdata.effect_table.has(tmp.template):
			print("effect %s uses missing template %s and was not loaded" % [id, tmp.template])
			return null
		if Effectdata.effect_table[tmp.template].type != tmp.type:
			print("effect %s changed type from %s to %s and was not loaded" % [id, tmp.type, Effectdata.effect_table[tmp.template].type])
			return null
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
		_:
			print("effect %s has unsupported saved type %s and was not loaded" % [id, tmp.type])
			return null
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
	tmp.createfromtemplate(buff_t)
	return tmp


func deserialize(tmp):
	effects.clear()
	stacks.clear()
	for k in tmp.keys():
		if k.begins_with('eid'):
			var eff = deserialize_effect(tmp[k], k)
			if eff != null:
				effects[k] = eff
		elif k.begins_with('sid'):
			var eff = deserialize_stack(tmp[k], k)
			stacks[k] = eff
	_retire_legacy_effects()
	_prune_missing_stack_effects()


func _retire_legacy_effects():
	for id in effects.keys().duplicate():
		var effect = effects[id]
		if effect.template_id in LEGACY_EFFECTS_TO_RETIRE:
			remove_id(id)


func _prune_missing_stack_effects():
	for stack in stacks.values():
		for effect_id in stack.effects.keys().duplicate():
			if effects.has(effect_id):
				continue
			print("effect %s is missing from stack %s and was removed" % [effect_id, stack.id])
			stack.effects.erase(effect_id)


func clean_effects_for_char(id):
	for e in effects.values():
		if !e.is_applied:
			 continue
		if e.owner is String and e.owner == id:
			e.remove()
			e.is_applied = false
