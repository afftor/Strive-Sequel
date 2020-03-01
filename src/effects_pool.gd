extends Node
# warning-ignore-all:return_value_discarded

var effects: = {}

func get_new_id():
	var s := "eid%d"
	var t = randi()
	while effects.has(s % t):
		t += 1
	return s % t

func add_effect(eff):
	var id = get_new_id()
	effects[id] = eff
	eff.id = id
	return id

func add_stored_effect(id, eff):
	effects[id] = eff

func get_effect_by_id(id):
	return effects[id]

func cleanup():
	for id in effects.keys():
		if !effects[id].is_applied:
			remove_id(id)
			continue
		if effects[id].applied_char == null:
			remove_id(id)

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
	return tmp

func deserialize_effect(tmp, id, caller = null):
	var eff
	match tmp.type:
		'base': eff = base_effect.new(caller)
		'static': eff = static_effect.new(caller)
		'trigger': eff = triggered_effect.new(caller)
		'temp_s': eff = temp_e_simple.new(caller)
		'temp_p': eff = temp_e_progress.new(caller)
		'temp_u': eff = temp_e_upgrade.new(caller)
		'area': eff = area_effect.new(caller)
		'c_static': eff = condition_effect.new(caller)
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
		'base': tmp = base_effect.new(caller)
		'static': tmp = static_effect.new(caller)
		'trigger': tmp = triggered_effect.new(caller)
		'temp_s': tmp = temp_e_simple.new(caller)
		'temp_p': tmp = temp_e_progress.new(caller)
		'temp_u': tmp = temp_e_upgrade.new(caller)
		'area': tmp = area_effect.new(caller)
		'oneshot': tmp = oneshot_effect.new(caller)
		'c_static': tmp = condition_effect.new(caller)
	tmp.createfromtemplate(template)
	return tmp

func deserialize(tmp):
	effects.clear()
	for k in tmp.keys():
		var eff = deserialize_effect(tmp[k], k)
		effects[k] = eff
