extends Reference

var parent: WeakRef
var timestamp = 0
var etb_timestamp = 0


func get_timestamp():
	timestamp += 1
	return timestamp

func setup_etb():
	etb_timestamp = get_timestamp()
	rebuild = variables.DYN_STATS_REBUILD


var effects_stored = [] #effect records(?) - static and triggers {effect_id, timestamp}
var effects_temp_stored = {} #effect stacks by id
var effects_temp_globals = [] #effect records (?)

var effects_real = []
var effects_temp_real = {} #effect stacks by ref
var effects_temp_globals_real = [] #effect records 

var rebuild = variables.DYN_STATS_REBUILD

var counters = []


func reset_rebuild():
	rebuild = variables.DYN_STATS_REBUILD


func deserialize(savedict):
	timestamp = savedict.timestamp
	
	effects_stored = savedict.effects_stored.duplicate()
	effects_temp_stored = savedict.effects_temp_stored.duplicate()
	effects_temp_globals = savedict.effects_temp_globals.duplicate()


func add_eff_to_stack(e_id, timestamp = null):
	var eff = effects_pool.get_effect_by_id(e_id)
	var template = eff.template
	var stack_code = 'default'
	if template.has('stack'):
		stack_code = template.stack
	
	var stack
	if eff.is_stored:
		timestamp = get_timestamp()
		if effects_temp_stored.has(stack_code):
			stack = effects_pool.get_stack_by_id(effects_temp_stored[stack_code])
		else:
			stack = effects_pool.make_stack(stack_code)
			effects_temp_stored[stack_code] = stack.id
			stack.owner = parent.get_ref().id
	else:
		if effects_temp_real.has(stack_code):
			stack = effects_temp_real[stack_code]
		else:
			stack = effects_pool.make_stack(stack_code, false)
			effects_temp_real[stack_code] = stack
			stack.owner = parent.get_ref().id
	stack.add_effect(e_id, timestamp)


func add_stored_effect(code, dict = {}):
	var data = Effectdata.effect_table[code]
	var eff
	var id
	match data.type:
		'simple':
			effects_stored.push_back({id = code, timestamp = get_timestamp()})
		'base':
			eff = effects_pool.e_createfromtemplate(code, parent.get_ref().id)
			id = effects_pool.add_effect(eff)
			add_eff_to_stack(id)
		'trigger':
			eff = effects_pool.e_createfromtemplate(code, parent.get_ref().id)
			id = effects_pool.add_effect(eff)
			add_eff_to_stack(id)
		'temp_s':
			eff = effects_pool.e_createfromtemplate(code, parent.get_ref().id)
			id = effects_pool.add_effect(eff)
			add_eff_to_stack(id)
		'temp_global':
			eff = effects_pool.e_createfromtemplate(code, parent.get_ref().id)
			id = effects_pool.add_effect(eff)
			effects_temp_globals.push_back({id = id, timestamp = get_timestamp()})
	
	if data.type != 'simple':
		eff.owner = parent.get_ref().id
		eff.calculate_args(dict)
		eff.apply()
	
	rebuild = variables.DYN_STATS_REBUILD


func process_eid_add(code, timestamp, dict = {}):
	var template = Effectdata.effect_table[code]
	
	var eff
	var id
	match template.type:
		'simple':
			effects_real.push_back({id = code, timestamp = timestamp})
		'base':
			eff = effects_pool.e_createfromtemplate(code, parent.get_ref().id)
			id = effects_pool.add_effect(eff)
			eff.is_stored = false
			add_eff_to_stack(id, timestamp)
		'trigger':
			eff = effects_pool.e_createfromtemplate(code, parent.get_ref().id)
			id = effects_pool.add_effect(eff)
			eff.is_stored = false
			add_eff_to_stack(id, timestamp)
		'temp_s':
			eff = effects_pool.e_createfromtemplate(code, parent.get_ref().id)
			id = effects_pool.add_effect(eff)
			eff.is_stored = false
			add_eff_to_stack(id, timestamp)
		'temp_global':
			eff = effects_pool.e_createfromtemplate(code, parent.get_ref().id)
			id = effects_pool.add_effect(eff)
			eff.is_stored = false
			effects_temp_globals_real.push_back({id = id, timestamp = timestamp})
	
	if template.type != 'simple':
		eff.owner = parent.get_ref().id
		eff.calculate_args(dict)
		eff.apply()


func process_effect_add(eff_id, timestamp):
	var eff = effects_pool.get_effect_by_id(eff_id)
	if eff is temp_e_global:
		effects_temp_globals_real.push_back({id = eff_id, timestamp = timestamp})
	else:
		add_eff_to_stack(eff_id, timestamp)


func process_effects_expand():
	for rec in effects_temp_globals_real:
		var eff = effects_pool.get_effect_by_id(rec.id)
		for eff_id in eff.sub_effects:
			process_effect_add(eff_id, rec.timestamp)
	for stack in effects_temp_real:
		var pool = effects_temp_real[stack].get_active_effects()
		for eid in pool:
			var eff = effects_pool.get_effect_by_id(eid)
			if eff.template.type == 'trigger':
				continue
			for eff_id in eff.sub_effects:
				process_effect_add(eff_id, pool[eid])
	#areas
	if input_handler.combat_node != null:
		var pool = input_handler.combat_node.get_allied_targets(parent.get_ref())
		for ch in pool:
			if ch == parent.get_ref():
				continue
			for e in ch.find_temp_effect_tag('area_allied') + ch.find_temp_effect_tag('area_full'):
				var eff = effects_pool.get_effect_by_id(e)
				for eff_id in eff.sub_effects:
					process_effect_add(eff_id, etb_timestamp)
		pool = input_handler.combat_node.get_enemy_targets_all(parent.get_ref(), true)
		for ch in pool:
			for e in ch.find_temp_effect_tag('area_enemy') + ch.find_temp_effect_tag('area_full'):
				var eff = effects_pool.get_effect_by_id(e)
				for eff_id in eff.sub_effects:
					process_effect_add(eff_id, etb_timestamp)


func has_status(status):
	var res = false
	for rec in effects_real:
		var data = Effectdata.effect_table[rec.id]
		if data.tags.has(status):
			return true
	for id in effects_temp_globals_real:
		var eff = effects_pool.get_effect_by_id(id)
		if eff.has_status(status):
			return true
	for st in effects_temp_real.values():
		for id in st.get_active_effects().keys():
			var eff = effects_pool.get_effect_by_id(id)
			if eff.has_status(status):
				return true
	return false


func find_temp_effect_tag(eff_tag):
	var res = []
	for e in effects_temp_globals_real:
		var eff = effects_pool.get_effect_by_id(e)
		if eff.has_status(eff_tag):
			res.push_back(effects_temp_globals_real[e])
	for st in effects_temp_real.values():
		for id in st.get_active_effects().keys():
			var eff = effects_pool.get_effect_by_id(id)
			if eff.has_status(eff_tag):
				res.push_back(id)
	return res


func resolve_value(val):
	if val is Array:
		if val[0] is Array:
			val[0] = resolve_value(val[0])
		if val[0] is String:
			match val[0]:
				'random':
					var tmp = globals.rng.randi_range(val[1], val[2])
					val.pop_front()
					val.pop_front()
					val[0] = tmp
				'stat':
					var tmp = parent.get_ref().get_stat(val[1])
					val.pop_front()
					val[0] = tmp
		while val.size() > 1:
			match val[1]:
				'+':
					val[2] = val[0] + resolve_value(val[2])
					pass
				'-':
					val[2] = val[0] - resolve_value(val[2])
					pass
				'*':
					val[2] = val[0] * resolve_value(val[2])
					pass
				'/':
					val[2] = val[0] / resolve_value(val[2])
					pass
			val.pop_front()
			val.pop_front()
		return val[0]
	else:
		return val


func process_event(ev, data = {}):
	for st in effects_temp_real.values():
#		var st = effects_pool.get_stack_by_id(stack)
		st.process_act(ev, data)
	for st in effects_temp_real.values():
#		var st = effects_pool.get_stack_by_id(stack)
		st.process_tick(ev)


func remove_effect(eff_id):
	rebuild = variables.DYN_STATS_REBUILD
	var obj = effects_pool.get_effect_by_id(eff_id)
	if obj is temp_e_global:
		effects_temp_globals.erase(eff_id)
	else:
		var stid = 'default'
		if obj.template.has('stack'): 
			stid = obj.template.stack
		if !effects_temp_stored.has(stid):
			print('try to remove eff %s from nonexisted stack %s' % [eff_id, stid])
			return
		var stack = effects_temp_stored[stid]
		effects_pool.get_stack_by_id(stack).remove_effect(eff_id)
	
	#move to another place
#	var nd = parent.get_ref().displaynode
#	if nd != null:
#		nd.rebuildbuffs()
#		'area': remove_area_effect(eff_id)


func remove_temp_effect_tag(eff_tag):#function for non-direct temps removing, like heal or dispel, probably not used. removes random effect.
	var tmp = find_temp_effect_tag(eff_tag)
	if tmp.empty():
		return
	var e = input_handler.random_from_array(tmp)
	var obj = effects_pool.get_effect_by_id(e)
	obj.call_deferred('remove')


func remove_all_temp_effects_tag(eff_tag): #function for non-direct temps removing, like heal or dispel
	var tmp = find_temp_effect_tag(eff_tag)
	if tmp.empty():
		return
	for e in tmp:
		var obj = effects_pool.get_effect_by_id(e)
		obj.call_deferred('remove')


func check_status_immunity(eff_n):
	var tres = parent.get_ref().get_stat('resist_' + eff_n)
	return tres >= 100


func check_status_resist(eff_n):
	var tres = parent.get_ref().get_stat('resist_' + eff_n)
	var roll = globals.rng.randi_range(0, 99)
	if roll < tres: 
		return true
	return false


func apply_status(data):
	var eff_id = data.effect
	match eff_id:
		'wet':
			remove_all_temp_effects_tag('burn')
		'freeze':
			if has_status('wet'):
				data.chance = 1.0
			if parent.get_ref().has_status('boss_resists'):
				data.duration = 1
			remove_all_temp_effects_tag('burn')
			remove_all_temp_effects_tag('wet')
		'shock':
			if has_status('shock') and globals.rng.randf() < 0.2:
				eff_id = 'stun'
				data.duration = 1
			else:
				remove_all_temp_effects_tag('fear')
		'stun':
			remove_all_temp_effects_tag('shock')
			if parent.get_ref().has_status('boss_resists'):
				data.duration = 1
#		_:
#			var effect = Effectdata.effect_table[Effectdata.get_effect_for_status(eff_id)]
	
	if check_status_immunity(eff_id):
		if input_handler.combat_node != null and !Effectdata.effect_nolog.has(eff_id):
			input_handler.combat_node.combatlogadd("\n%s is immune to %s." % [parent.get_ref().get_short_name(), eff_id])
			parent.get_ref().play_sfx('resist')
		return
	if data.chance > 1.0:
		add_stored_effect(Effectdata.get_effect_for_status(eff_id), data)
		if input_handler.combat_node != null and !Effectdata.effect_nolog.has(eff_id):
			input_handler.combat_node.combatlogadd("\n%s is affected by %s." % [parent.get_ref().get_short_name(), eff_id])
	elif globals.rng.randf() <= data.chance:
		if check_status_resist(eff_id):
			if input_handler.combat_node != null and !Effectdata.effect_nolog.has(eff_id):
				input_handler.combat_node.combatlogadd("\n%s resists %s." % [parent.get_ref().get_short_name(), eff_id])
				parent.get_ref().play_sfx('resist')
			return
		else:
			add_stored_effect(Effectdata.get_effect_for_status(eff_id), data)
			if input_handler.combat_node != null and !Effectdata.effect_nolog.has(eff_id):
				input_handler.combat_node.combatlogadd("\n%s is affected by %s." % [parent.get_ref().get_short_name(), eff_id])

