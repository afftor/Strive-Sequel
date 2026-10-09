extends "res://src/character/ch_effects.gd"


#stored
var statlist = Statlist_init.template_dynamic.duplicate(true) 
var manacost_mods = Statlist_init.manacost_mods.duplicate(true) 
var resists = Statlist_init.resists.duplicate(true) 
var damage_mods = Statlist_init.damage_mods.duplicate(true) 
var task_efficiency = Statlist_init.task_efficiency.duplicate(true)
var task_crit = Statlist_init.task_crit.duplicate(true)
var traits_stored = {}
var traits_revealed = {} #hidden traits the player has found out about
var trait_progress = {} #hours a growing trait has gathered towards its next stage
var body_upgrades = {}
var professions = {}
var masteries = {} #{magic = [], combat = [], universal = [], passive = [], enable = true},
var bonuses_stored = {}
var info_bonus_mastery = {}

#rebuildable
var traits_real = {}
var traits_2_real = {}
var masteries_real = {}
var skills_real = []
var c_skills_real = []
var e_skills_real = []
var stat_bonuses = {}
var buffs = []
var masteries_sources = {}


func _init().():
	for mas in Skilldata.masteries:
		masteries[mas] = {magic = [], combat = [], universal = [], passive = [], enable = true}


func deserialize(savedict):
	.deserialize(savedict)
	
	traits_stored = savedict.traits_stored.duplicate(true)
	bonuses_stored = savedict.bonuses_stored.duplicate(true)
	body_upgrades = savedict.body_upgrades.duplicate(true)
	professions = savedict.professions.duplicate(true)
	masteries = savedict.masteries.duplicate(true)
	if savedict.has('traits_revealed'):
		traits_revealed = savedict.traits_revealed.duplicate()
	if savedict.has('trait_progress'):
		trait_progress = savedict.trait_progress.duplicate()

	for stat in statlist:
		if savedict.statlist.has(stat):
			statlist[stat] = savedict.statlist[stat]
	for stat in manacost_mods:
		if savedict.manacost_mods.has(stat):
			manacost_mods[stat] = savedict.manacost_mods[stat]
	for stat in resists:
		if savedict.resists.has(stat):
			resists[stat] = savedict.resists[stat]
	for stat in damage_mods:
		if savedict.damage_mods.has(stat):
			damage_mods[stat] = savedict.damage_mods[stat]
	
	gather_innate_bonuses()
#	generate_data(variables.DYN_STATS_FULL, true)


func fix_serialize():
	.fix_serialize()
	_repair_core_trait_effects()
	if !(statlist.speed is Array):
		statlist.speed = [statlist.speed]
	for tr in traits_stored.duplicate():
		if Traitdata.traits.has(tr): 
			continue
		traits_stored.erase(tr)
	for prof in professions.keys():
		#commented code below fixed some error in profs data manipulation that caused loss of classes persistent effects. since this error was long ago - there is little value in keeping this fix. and more to it - it causes errors with togglable auras (cause they are classes persistent effects) loading. 
#		remove_all_temp_effects_tag('class_' + prof)
		if classesdata.professions.has(prof): 
			continue
#			var data = classesdata.professions[prof]
#			if data.has('persistent_effects'):
#				for eff in data.persistent_effects:
#					add_stored_effect(eff)
		else:
			professions.erase(prof)
	generate_data(variables.DYN_STATS_FULL, true)


func _repair_core_trait_effects():
	if !traits_stored.has('core_trait'):
		return
	var person = parent.get_ref()
	if person == null:
		return
	var present = {}
	for effect_record in effects_stored:
		if effect_record is Dictionary and effect_record.has('id'):
			present[effect_record.id] = true
	for effect in effects_pool.get_effects_for_char(person.id, true):
		if effect.template_id != null:
			present[effect.template_id] = true
	for effect_id in Traitdata.traits.core_trait.effects:
		if present.has(effect_id):
			continue
		if !Effectdata.effect_table.has(effect_id):
			print("core trait effect %s is missing from effect data" % effect_id)
			continue
		add_stored_effect(effect_id)


#dyn_bonuses
func generate_data(stop_at = variables.DYN_STATS_FULL, forced = false):
	if rebuild >= stop_at and !forced:
		return
	#reset
	clear_nonstored_effs()
	traits_real = traits_stored.duplicate()
	traits_2_real.clear()
	masteries_real = masteries.duplicate(true)
	masteries_sources.clear()
	var process_skills = (stop_at == variables.DYN_STATS_FULL)
	var skills_old = skills_real.duplicate()
	var c_skills_old = c_skills_real.duplicate()
	if process_skills:
		skills_real = parent.get_ref().get_learned_skills('social')
		c_skills_real = parent.get_ref().get_learned_skills('combat')
		e_skills_real = parent.get_ref().get_learned_skills('explore')
	stat_bonuses = bonuses_stored.duplicate(true)
	buffs.clear()
	#stored effects_duplicating
	effects_real = effects_stored.duplicate()
	release_temp_stacks()
	#Where a dangling stack id is finally dropped. Storing the failed clone would have put a null
	#into effects_temp_real, and everything below reads that dictionary unguarded - add_eff_to_stack,
	#process_effects_expand, has_status, clear_nonstored_effs all called straight into it.
	for stack in effects_temp_stored.keys():
		var clone = effects_pool.clone_stack(effects_temp_stored[stack])
		if clone == null:
			print("stack %s of %s is gone from the pool and was dropped" % [effects_temp_stored[stack], stack])
			effects_temp_stored.erase(stack)
			continue
		effects_temp_real[stack] = clone
	effects_temp_globals_real = effects_temp_globals.duplicate()
	
	var race = parent.get_ref().get_stat('race')
	process_race_data(race, process_skills)
	for prof in professions:
		process_prof_data(prof, professions[prof], process_skills)
	for upg in body_upgrades:
		var upg_data = Traitdata.body_upgrades[upg]
		if upg_data.has('traits'):
			for tr in upg_data.traits:
				process_trait_add(tr, body_upgrades[upg])
	rebuild = variables.DYN_STATS_FACTORS
	if rebuild >= stop_at and !forced:
		return
	for trait in traits_real:
		process_trait_data(trait, traits_real[trait])
	update_masteries(process_skills)
	for trait in traits_2_real:
		process_trait_data(trait, traits_2_real[trait])
	var tattoos = parent.get_ref().get_tattoos()
	for slot in tattoos:
		if tattoos[slot] == null:
			continue
		var tatdata = Traitdata.tattoodata[tattoos[slot]].effects
		for rec in tatdata:
			if rec.has(slot.trim_prefix('tattoo_')):
				for eff in tatdata[rec]:
					process_eid_add(eff, 0) #probably not 0
	get_traits_buffs()
	#process equip
	for item in parent.get_ref().get_equiped_items():
		for stat in item.bonusstats:
			process_bonus_record(stat, item.bonusstats[stat], 'item', item.id, item.timestamp)
		for eff in item.effects:
			process_eid_add(eff, item.timestamp)
	rebuild = variables.DYN_STATS_PREAREA
	if !forced:
		var l1 = input_handler.compare_list(skills_real, skills_old)
		var l2 = input_handler.compare_list(c_skills_real, c_skills_old)
		parent.get_ref().fix_skillpanels(l1.add, l2.add, l1.remove, l2.remove)
	if rebuild >= stop_at and !forced:
		return
	#process effects
	process_effects_expand()
	#process real effects
	for rec in effects_real:
		var template = Effectdata.effect_table[rec.id]
		if template.has('conditions'):
			if !parent.get_ref().checkreqs(template.conditions):
				continue
		for stat in template.statchanges:
			process_bonus_record(stat, resolve_value(template.statchanges[stat]), 'effect', template.name, rec.timestamp)
		for b in template.buffs:
			var t_buff = Buff.new(null)
			t_buff.createfromtemplate(b)
			t_buff.calculate_args()
			buffs.push_back(t_buff)
	for rec in effects_temp_globals_real:
		var eff = effects_pool.get_effect_by_id(rec.id)
		var template = eff.template
		for stat in template.statchanges:
			process_bonus_record(stat, eff.resolve_value(template.statchanges[stat]), 'effect', template.name, rec.timestamp)
		eff.rebuild_buffs()
		for b in eff.buffs:
			buffs.push_back(b)
	for stack in effects_temp_real.values():
		var pool = stack.get_active_effects()
		for eid in pool:
			var eff = effects_pool.get_effect_by_id(eid)
			if eff.template.type == 'trigger':
				continue
			var template = eff.template
			for stat in template.statchanges:
				process_bonus_record(stat, eff.resolve_value(template.statchanges[stat]), 'effect', eff.get_src(), pool[eid])
		stack.update_buffs()
		for b in stack.buffs:
			buffs.push_back(b)
	
	rebuild = variables.DYN_STATS_FULL
	parent.get_ref().update_capped_stats()
	



func process_race_data(id, process_skills = true):
	if id == '':
		return
	var data = races.racelist[id]
	for stat in data.race_bonus:
		process_bonus_record(stat, data.race_bonus[stat], 'race', id, 0)
	if data.has('traits'):
		for tr in data.traits:
			process_trait_add(tr, 0)
	if data.has("social_skills") and process_skills:
		for id in data.social_skills:
			if !skills_real.has(id) and !parent.get_ref().is_race_skill_spent(id):
				skills_real.push_back(id)
	if data.has("combat_skills") and process_skills:
		for id in data.combat_skills:
			if !c_skills_real.has(id):
				c_skills_real.push_back(id)


func process_prof_data(id, timestamp, process_skills = true):
	var profdata = classesdata.professions[id]
	for stat in profdata.statchanges:
		process_bonus_record(stat, profdata.statchanges[stat], 'class', id, timestamp)
	for trait in profdata.traits:
		process_trait_add(trait, timestamp)
	if process_skills:
		for id in profdata.skills:
			if !skills_real.has(id):
				skills_real.push_back(id)
		for id in profdata.combatskills:
			if !c_skills_real.has(id):
				c_skills_real.push_back(id)
		if profdata.has('exploreskills'):
			for id in profdata.exploreskills:
				if !e_skills_real.has(id):
					e_skills_real.push_back(id)


func process_trait_data(id, timestamp):
	var traitdata = Traitdata.traits[id]
	for stat in traitdata.bonusstats:
		process_bonus_record(stat, traitdata.bonusstats[stat], 'trait', id, timestamp)
	var daylight = traitdata.get('vows', {}).get('daylight', {})
	if !daylight.empty() and is_daylight():
		for stat in daylight:
			process_bonus_record(stat, daylight[stat], 'trait', id, timestamp)
	var hours = traitdata.get('daylight', {}) if is_daylight() else traitdata.get('night', {})
	for stat in hours:
		process_bonus_record(stat, hours[stat], 'trait', id, timestamp)
	for skill in traitdata.get('combat_skills', []):
		if !c_skills_real.has(skill):
			c_skills_real.push_back(skill)
	if id != 'core_trait':
		for eff in traitdata.effects:
			process_eid_add(eff, timestamp)


func process_bonus_record(stat, value, src_type, src_value, timestamp):
	if statdata.statdata.has(stat):
		var stdata = statdata.statdata[stat]
		if stat == 'disabled_masteries':
			for mastery in value:
				add_stat_bonus('mastery_%s_enable' % mastery, false, 'set', src_type, src_value, timestamp)
		elif stat == 'enabled_masteries':
			for mastery in value:
				add_stat_bonus('mastery_%s_enable' % mastery, true, 'set', src_type, src_value, timestamp)
		elif stat.begins_with('mastery_') and (stat.trim_prefix('mastery_') in masteries):
			stat = stat.trim_prefix('mastery_')
			for i in range(value):
				masteries_real[stat].passive.push_back(timestamp)
			add_masteries_source(stat, src_type, src_value, value)
		else:
			add_stat_bonus(stat, value, statdata.statdata[stat].default_bonus, src_type, src_value, timestamp)
	else:
		var f = false
		for suffix in ['add', 'add_part', 'add2', 'add_part2', 'mul', 'mul2', 'set', 'append', 'maxcap', 'mincap']:
			if stat.ends_with('_' + suffix):
				add_stat_bonus(stat.trim_suffix('_' + suffix), value, suffix, src_type, src_value, timestamp)
				f = true
				break
		if !f:
			print("error: bonus stat %s not known" % stat)

func add_masteries_source(stat, src_type, src_value, value):
	if !masteries_sources.has(stat):
		masteries_sources[stat] = {}
	if !masteries_sources[stat].has(src_type):
		masteries_sources[stat][src_type] = {}
	if !masteries_sources[stat][src_type].has(src_value):
		masteries_sources[stat][src_type][src_value] = value
	else:
		masteries_sources[stat][src_type][src_value] += value


func add_stat_bonus(stat, value, operant, src_type, src_value, timestamp, check = false):
	var store = stat_bonuses
	if src_type == 'innate':
		store = bonuses_stored
	if !store.has(stat):
		store[stat] = {}
	if !store[stat].has(operant):
		store[stat][operant] = []
	if check:
		for rec in store[stat][operant]:
			if rec.src_type != src_type:
				continue
			if rec.src_value != src_value:
				continue
			if rec.timestamp != timestamp:
				continue
			if rec.value != value:
				continue
			return
	store[stat][operant].push_back({value = value, src_type = src_type, src_value = src_value, timestamp = timestamp})


func gather_innate_bonuses():
	for stat in statdata.statdata:
		var st_data = statdata.statdata[stat]
		if st_data.has('innate_bonuses'):
			for rec in st_data.innate_bonuses:
				add_stat_bonus(stat, st_data.innate_bonuses[rec], rec, 'innate', '', 0, true)


func process_trait_add(id, timestamp, second_pass = false):
	if second_pass:
		if traits_2_real.has(id):
			traits_2_real[id] = min(traits_2_real[id], timestamp)
		else:
			traits_2_real[id] = timestamp
	else:
		if traits_real.has(id):
			traits_real[id] = min(traits_real[id], timestamp)
		else:
			traits_real[id] = timestamp


func update_masteries(process_skills = true):
	for mas in masteries_real:
		masteries_real[mas].passive = masteries_real[mas].passive + get_stat_timestamps('mastery_%s' % mas)
		masteries_real[mas].enable = get_stat_data('mastery_%s_enable' % mas, variables.DYN_STATS_REBUILD).result
		if masteries_real[mas].enable:
			var mas_data = Skilldata.masteries[mas]
			var mas_full = masteries_real[mas].passive + masteries_real[mas].universal + masteries_real[mas].combat + masteries_real[mas].magic
			mas_full.sort()
			for i in range(mas_full.size()):
				for stat in mas_data.passive:
					process_bonus_record(stat, mas_data.passive[stat], 'mastery', mas, mas_full[i]) 
				if i < mas_data.maxlevel:
					var lvdata = mas_data['level%d' % (i + 1)]
					for trait in lvdata.traits:
						process_trait_add(trait, mas_full[i], true)
					if process_skills:
						for id in lvdata.explore_skills:
							if !e_skills_real.has(id):
								e_skills_real.push_back(id)
						for id in lvdata.combat_skills:
							if !c_skills_real.has(id):
								c_skills_real.push_back(id)


func has_status(status):
	for tr in professions:
		var profdata = classesdata.professions[tr]
		if profdata.has('tags') and profdata.tags.has(status):
			return true
	for tr in traits_real.keys() + traits_2_real.keys():
		var traitdata = Traitdata.traits[tr]
		if traitdata.has('tags') and traitdata.tags.has(status):
			return true
	return .has_status(status)


#getters
func get_stat_data(stat, stop = variables.DYN_STATS_FULL): #full value
	if rebuild < stop:
		generate_data(stop)
	var res = {
		base_value = null,
		result = 0,
		bonuses = {},
	}
	var st_data = statdata.statdata[stat]
	if stat_bonuses.has(stat):
		res.bonuses = stat_bonuses[stat].duplicate(true)
	if st_data.tags.has('custom_bonuses'):
		fix_stat_data(stat, res)
	if st_data.tags.has('custom_getter'):
		call('get_' + stat, res)
	else:
		if res.base_value == null:
			res.base_value = 0
			if st_data.tags.has('bool'):
				res.base_value = true
			if st_data.tags.has('array'):
				res.base_value = []
			var container = statlist
			if st_data.has('container'):
				match st_data.container:
					'manacost_mods':
						container = manacost_mods
					'resists':
						container = resists
					'damage_mods':
						container = damage_mods
					'task_efficiency':
						container = task_efficiency
					'task_crit':
						container = task_crit
					
			if container.has(stat):
				if container[stat] is Array:
					res.base_value = container[stat].duplicate()
				else:
					res.base_value = container[stat]
		if res.base_value is Array:
			res.result = res.base_value.duplicate(true)
		else:
			res.result = res.base_value
		
		var order = ['add', 'add_part', 'mul', 'set', 'maxcap', 'mincap']
		if st_data.has('custom_order'):
			order = st_data.custom_order
		
		for op in order:
			match op:
				'add':
					var aggregate_bonus = 0
					if res.bonuses.has(op):
						for rec in res.bonuses[op]:
							aggregate_bonus += rec.value
						if res.result is Array:
							for i in range(res.result.size()):
								res.result[i] += aggregate_bonus
						else:
							res.result += aggregate_bonus
				'add_part':
					var aggregate_bonus = 1
					if res.bonuses.has(op):
						for rec in res.bonuses[op]:
							aggregate_bonus += rec.value 
						if res.result is Array:
							for i in range(res.result.size()):
								res.result[i] *= aggregate_bonus
						else:
							res.result *= aggregate_bonus
				'mul':
					var aggregate_bonus = 1
					if res.bonuses.has(op):
						for rec in res.bonuses[op]:
							aggregate_bonus *= rec.value
						if res.result is Array:
							for i in range(res.result.size()):
								res.result[i] *= aggregate_bonus
						else:
							res.result *= aggregate_bonus
				'add2':
					var aggregate_bonus = 0
					if res.bonuses.has(op):
						for rec in res.bonuses[op]:
							aggregate_bonus += rec.value
						if res.result is Array:
							for i in range(res.result.size()):
								res.result[i] += aggregate_bonus
						else:
							res.result += aggregate_bonus
				'add_part2':
					var aggregate_bonus = 1
					if res.bonuses.has(op):
						for rec in res.bonuses[op]:
							aggregate_bonus += rec.value 
						if res.result is Array:
							for i in range(res.result.size()):
								res.result[i] *= aggregate_bonus
						else:
							res.result *= aggregate_bonus
				'mul2':
					var aggregate_bonus = 1
					if res.bonuses.has(op):
						for rec in res.bonuses[op]:
							aggregate_bonus *= rec.value
						if res.result is Array:
							for i in range(res.result.size()):
								res.result[i] *= aggregate_bonus
						else:
							res.result *= aggregate_bonus
				'set':
					if res.bonuses.has(op):
						var last_t = -1
						var aggregate_bonus = null
						for rec in res.bonuses[op]:
							if aggregate_bonus != null:
								if rec.timestamp > last_t:
									aggregate_bonus = rec.value
									last_t = rec.timestamp
							else:
								aggregate_bonus = rec.value
								last_t = rec.timestamp
						res.result = aggregate_bonus
				'append':
					if res.bonuses.has(op):
						var aggregate_bonus = []
						for rec in res.bonuses[op]:
							aggregate_bonus.append_array(rec.value)
						res.result.append_array(aggregate_bonus)
				'maxcap':
					if res.bonuses.has(op):
						var aggregate_bonus = null
						for rec in res.bonuses[op]:
							if aggregate_bonus != null:
								if rec.value < aggregate_bonus:
									aggregate_bonus = rec.value
							else:
								aggregate_bonus = rec.value
						if res.result is Array:
							for i in range(res.result.size()):
								res.result[i] = min(res.result[i], aggregate_bonus)
						else:
							res.result = min(res.result, aggregate_bonus)
				'mincap':
					if res.bonuses.has(op):
						var aggregate_bonus = null
						for rec in res.bonuses[op]:
							if aggregate_bonus != null:
								if rec.value > aggregate_bonus:
									aggregate_bonus = rec.value
							else:
								aggregate_bonus = rec.value
						if res.result is Array:
							for i in range(res.result.size()):
								res.result[i] = max(res.result[i], aggregate_bonus)
						else:
							res.result = max(res.result, aggregate_bonus)
	if stat == 'sex_stamina':
		res.result = clamp(res.result, 0, variables.sex_actions_stamina_cap)
	if st_data.tags.has('integer_floor'):
		res.result = int(floor(res.result + 0.0001))
	elif st_data.tags.has('integer'):
		res.result = int(res.result)
	return res


func get_stat_timestamps_data(stat, op = 'add'):
	var res = []
	if stat_bonuses.has(stat) and stat_bonuses[stat].has(op):
		for rec in stat_bonuses[stat][op]:
			res.push_back(rec.duplicate())
	res.sort_custom(input_handler, 'timestamp_sort_dict')
	return res


func get_stat(stat): #pure value
	return get_stat_full(stat).result

func get_stat_full(stat): #dict value
	var st_data = statdata.statdata[stat]
	if st_data.tags.has('factor'):
		return get_stat_data(stat, variables.DYN_STATS_FACTORS)
	else:
		return get_stat_data(stat)

func get_stat_timestamps(stat): #positive integer _add bonuses only
	var tres = get_stat_timestamps_data(stat)
	var res = []
	for rec in tres:
		if res.operant != 'add':
			continue
		for i in range(int(rec.value)):
			res.push_back(rec.timestamp)
	return res


func fix_stat_data(stat, data):
	match stat:
		'hpmax', 'physics_bonus', 'wits_bonus', 'sexuals_bonus', 'charm_bonus', 'productivity':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = min(get_stat('growth_factor') - 1, get_prof_number()) * 5, src_type = 'factor', src_value = 'growth', timestamp = 0})
			#A household that eats together works better, wherever on the estate the work is
			#done. A part added rather than points: points were worth less to somebody who had
			#already earned bonuses of their own, and a tenth more work should be a tenth for
			#everybody. 'add_part' is this stat's own channel (statdata.productivity) and one of
			#the few the combiner applies by default - 'mul2' is not, and did nothing at all.
			#Counted from the room the way the bath and the master bed are: it is a fact
			#about the estate, not about the person.
			if stat == 'productivity' and ResourceScripts.game_res.has_room_with_tag('dining'):
				if !data.bonuses.has('add_part'):
					data.bonuses.add_part = []
				data.bonuses.add_part.push_back({value = 0.1, src_type = 'room', src_value = 'dining_room', timestamp = 0})
			#read here rather than cached: the master comes and goes without a stat rebuild
			if stat == 'productivity':
				var field = 'productivity_with_master' if master_nearby() else 'productivity_without_master'
				for code in traits_stored:
					var part = Traitdata.traits[code].get(field, 0.0)
					if part != 0:
						if !data.bonuses.has('add_part'):
							data.bonuses.add_part = []
						data.bonuses.add_part.push_back({value = part, src_type = 'trait', src_value = code, timestamp = 0})
		'speed':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = min(get_stat('growth_factor') - 1, get_prof_number()) * 4, src_type = 'factor', src_value = 'growth', timestamp = 0})
			#a second turn slot, the way two-turn bosses have one
			if has_status('lone_wolf_turn'):
				data.base_value = statlist.speed.duplicate()
				data.base_value.push_back(statlist.speed[0])
		'hitrate':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = min(get_stat('growth_factor') - 1, get_prof_number()) * 4, src_type = 'factor', src_value = 'growth', timestamp = 0})
			if has_status('arcane_blade'):
				data.bonuses.add.push_back({value = get_stat('matk') * 0.35, src_type = 'class', src_value = 'arcane_blade', timestamp = 0})
		'evasion':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = min(get_stat('growth_factor') - 1, get_prof_number()) * 4, src_type = 'factor', src_value = 'growth', timestamp = 0})
			if has_status('ninja'):
				data.bonuses.add.push_back({value = get_stat('mdef')/4, src_type = 'class', src_value = 'ninja', timestamp = 0})
		'atk', 'matk':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = min(get_stat('growth_factor') - 1, get_prof_number()) * 3, src_type = 'factor', src_value = 'growth', timestamp = 0})
		'armor', 'mdef':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = min(get_stat('growth_factor') - 1, get_prof_number()) * 2, src_type = 'factor', src_value = 'growth', timestamp = 0})
		'mpmax':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.base_value = variables.basic_max_mp + variables.max_mp_per_magic_factor * get_stat('magic_factor')
			data.bonuses.add.push_back({value = min(get_stat('growth_factor') - 1, get_prof_number()) * 5, src_type = 'factor', src_value = 'growth', timestamp = 0})
		'hp_reg':
			#company in the master's own bed, one step of health per bedmate
			if parent.get_ref().is_master():
				if !data.bonuses.has('add'):
					data.bonuses.add = []
				data.bonuses.add.push_back({value = ResourceScripts.game_res.master_bed_partners(), src_type = 'room', src_value = 'master_bedroom', timestamp = 0})
		'mp_reg':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = get_stat('magic_factor') * variables.mp_regen_per_magic, src_type = 'factor', src_value = 'magic', timestamp = 0})
			#company in the master's own bed. Counted here rather than through an effect
			#because it is a fact about the room, not about him - see master_bed_partners().
			if parent.get_ref().is_master():
				data.bonuses.add.push_back({value = ResourceScripts.game_res.master_bed_partners() * 0.5, src_type = 'room', src_value = 'master_bedroom', timestamp = 0})
			#The master's bath, a fifth faster. On 'mul', which this stat's combiner applies: it was
			#pushed onto 'mul2', which mp_reg's order does not include (its custom_order is commented
			#out in statdata), so the bath's mana bonus never reached anybody.
			if ResourceScripts.game_res.has_bath():
				if !data.bonuses.has('mul'):
					data.bonuses.mul = []
				data.bonuses.mul.push_back({value = 1.2, src_type = 'upgrade', src_value = 'private_bath', timestamp = 0})
		'upgrade_points_total':
			data.base_value = get_stat('growth_factor') * variables.body_upgrade_points_per_growth_factor
#		'lustmax':
#			data.base_value = get_stat('sexuals_factor') * 25 + 25
		'trainee_amount':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = get_stat('authority_factor') / 2, src_type = 'factor', src_value = 'authority', timestamp = 0})
		'mastery_point_universal':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = -get_used_mastery_points('universal'), src_type = 'used', src_value = '', timestamp = 0})
			if !has_status('slave'):
				data.bonuses.add.push_back({value = min(get_stat('growth_factor') - 1, get_prof_number()), src_type = 'factor', src_value = 'growth', timestamp = 0})
		'mastery_point_combat':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = -get_used_mastery_points('combat'), src_type = 'used', src_value = '', timestamp = 0})
		'mastery_point_magic':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = -get_used_mastery_points('magic'), src_type = 'used', src_value = '', timestamp = 0})
		#fame tier bonuses
		'manhunt', 'trainer_loyalty_bonus':
			var fame_key = 'manhunt_bonus'
			if stat == 'trainer_loyalty_bonus':
				fame_key = 'loyalty_bonus'
			var fame_value = parent.get_ref().get_fame_bonus(fame_key)
			if fame_value != 0:
				if !data.bonuses.has('add'):
					data.bonuses.add = []
				data.bonuses.add.push_back({value = fame_value, src_type = 'fame', src_value = parent.get_ref().get_stat('fame'), timestamp = 0})


#setters
func set_default_value(stat, value):
	var data = statdata.statdata[stat]
	if data.direct:
		print ("error: wrong stat data - %s is direct" % stat)
		return
	if data.tags.has('custom_setter'):
		call('set_' + stat, value)
	else:
		var container = statlist
		if data.has('container'):
			match data.container:
				'manacost_mods':
					container = manacost_mods
				'resists':
					container = resists
				'damage_mods':
					container = damage_mods
				'task_efficiency':
					container = task_efficiency
				'task_crit':
					container = task_crit
		if container.has(stat):
			if !(value is Array) and data.tags.has('array_numeric'):
				value = [value]
			if value is Array:
				container[stat] = value.duplicate()
			else:
				container[stat] = value


func add_stat_stored(stat, value):
	var data = statdata.statdata[stat]
	if data.direct:
		print ("error: wrong stat data - %s is direct" % stat)
		return
	if data.tags.has('custom_setter'):
		call('set_' + stat, get_stat(stat) + value)
	else:
		var container = statlist
		if data.has('container'):
			match data.container:
				'manacost_mods':
					container = manacost_mods
				'resists':
					container = resists
				'damage_mods':
					container = damage_mods
				'task_efficiency':
					container = task_efficiency
				'task_crit':
					container = task_crit
		if container.has(stat):
			if value is Array:
				container[stat] = container[stat] + value.duplicate()
			else:
				container[stat] += value


#data processing
func add_stat_bonuses(ls):
	for stat in ls:
		process_bonus_record(stat, ls[stat], 'innate', '', 0)


func remove_stat_bonus(stat, op):
	if bonuses_stored.has(stat):
		if bonuses_stored[stat].has(op):
			bonuses_stored[stat].erase(op)


func generate_simple_fighter(data):
	gather_innate_bonuses()
	for i in resists:
		if data.has('resists') and data.resists.has(i.trim_prefix('resist_')):
			resists[i] = data.resists[i.trim_prefix('resist_')]
		if data.has('status_resists') and data.status_resists.has(i.trim_prefix('resist_')):
			resists[i] = data.status_resists[i.trim_prefix('resist_')]
	if data.has('traits'):
		for tr in data.traits:
			add_trait(tr)
	if data.has('preset_masteries'):
		for mas in data.preset_masteries:
			_add_mastery_as_bonuses(mas, data.preset_masteries[mas])


#traits
func add_trait(tr_code):
	if tr_code == null: 
		return
	if tr_code == 'untrained' and has_status('trained'): 
		return
	if traits_stored.has(tr_code): 
		return
	if !Traitdata.traits.has(tr_code): 
		return #temp
	var trait = Traitdata.traits[tr_code]
	rebuild = variables.DYN_STATS_REBUILD
	traits_stored[tr_code] = get_timestamp()
	var placeholder = Traitdata.catalogue.defaults.get(trait.get('category', ''), '')
	if placeholder != '' and placeholder != tr_code:
		remove_trait(placeholder, true)
	if trait.has('disposition_change'):
		parent.get_ref().process_disposition_data(trait.disposition_change)
	if trait.tags.has('clears_category'):
		for code in traits_stored.keys():
			if code != tr_code and get_trait_category(code) == get_trait_category(tr_code):
				remove_trait(code, true)
	if tr_code == 'undead':
		parent.get_ref().set_work_rule("contraceptive", false)
	#a vow arriving takes the character off work it now forbids (Transcendent at a mine)
	if trait.has('vows'):
		var person = parent.get_ref()
		var work = person.get_work()
		if work != '' and person.get_vow_ban('task', work) != '':
			person.remove_from_task()
	if tr_code == 'master_communicative' and parent.get_ref().is_master():
		ResourceScripts.game_globals.weekly_dates_left += 2
		ResourceScripts.game_globals.update_weekly_dates()
	if trait.has('tags') and trait.tags.has('remove_untrained'):
		remove_trait('untrained')
	if tr_code == 'core_trait':
		for eff in trait.effects:
			add_stored_effect(eff)
	if parent.get_ref().is_in_game_party() and trait.visible:
		globals.text_log_add('char', "%s: acquired trait %s" %
			[parent.get_ref().get_short_name(), trait.name])


func can_add_trait(tr_code):
	var trait = Traitdata.traits[tr_code]
	if traits_stored.has(tr_code): 
		return false
	if !trait.has('conflicts'): 
		return true
	for tr_conflict in trait.conflicts:
		if traits_stored.has(tr_conflict): 
			return false
	return true


func remove_trait(tr_code, forced = false):
	var trait = Traitdata.traits[tr_code]
	if !traits_stored.has(tr_code):
		return
	if !forced and trait.tags.has('permanent'):
		return
	traits_stored.erase(tr_code)
	rebuild = variables.DYN_STATS_REBUILD
	#a trait that brought a slot takes whatever sat in it along (Unnatural Constitution)
	for key in trait.get('bonusstats', {}):
		if key.begins_with('trait_slots_'):
			trim_trait_category(key.trim_prefix('trait_slots_'))


#An overfull category loses its newest traits until it fits; locked ones stay put.
func trim_trait_category(category):
	while get_free_trait_slots(category) < 0:
		var newest = ''
		for code in traits_stored:
			if get_trait_category(code) != category or is_trait_locked(code):
				continue
			if newest == '' or traits_stored[code] > traits_stored[newest]:
				newest = code
		if newest == '':
			return
		remove_trait(newest)


#A trait with a category takes one of that category's slots, trait_slots_<category> of them.
#Traits brought by a class, race or upgrade fill a slot too, but can no more be given up than permanent ones.
func get_trait_category(tr_code):
	if !Traitdata.traits.has(tr_code):
		return ''
	return Traitdata.traits[tr_code].get('category', '')


func get_category_traits(category):
	if rebuild < variables.DYN_STATS_PREAREA:
		generate_data(variables.DYN_STATS_PREAREA)
	var res = []
	for tr in traits_real.keys() + traits_2_real.keys():
		if get_trait_category(tr) == category and !res.has(tr):
			res.push_back(tr)
	return res


#check_trait reads the cached list, which still holds a trait removed a moment ago
func owns_trait(tr_code):
	if rebuild < variables.DYN_STATS_PREAREA:
		generate_data(variables.DYN_STATS_PREAREA)
	return traits_real.has(tr_code) or traits_2_real.has(tr_code)


func get_free_trait_slots(category):
	var slots = get_stat_data('trait_slots_' + category, variables.DYN_STATS_PREAREA).result
	var taken = get_category_traits(category)
	taken.erase(Traitdata.catalogue.defaults.get(category, ''))
	return slots - taken.size()


#Generation leaves no slot category with a stand-in empty: no faith means Worldly.
func add_default_traits():
	for category in Traitdata.catalogue.defaults:
		if get_category_traits(category).empty():
			add_trait(Traitdata.catalogue.defaults[category])


#A class can bring a trait into a category the stand-in holds; add_trait never sees those.
func drop_displaced_defaults():
	for category in Traitdata.catalogue.defaults:
		var placeholder = Traitdata.catalogue.defaults[category]
		if traits_stored.has(placeholder) and get_category_traits(category).size() > 1:
			remove_trait(placeholder, true)


#Every vow the character's traits hold, each mapped to the trait that holds it.
func get_vows():
	if rebuild < variables.DYN_STATS_PREAREA:
		generate_data(variables.DYN_STATS_PREAREA)
	var res = {}
	for tr in traits_real.keys() + traits_2_real.keys():
		for vow in Traitdata.traits[tr].get('vows', {}):
			res[vow] = tr
	return res


#Mae, Kuro and Heleviel believe what their story makes them believe (pregen tag faith_locked): no prayer,
#meditation or offer changes it, only set_faith() from the story itself.
func is_category_locked(category):
	return category == 'religious' and parent.get_ref().tags.has('faith_locked')


#Whether prayer, meditation or a companion can still change what this character believes: not when
#the story holds it, nor over a permanent trait (Airhead, Transcendent).
func can_change_faith():
	if is_category_locked('religious'):
		return false
	for tr in get_category_traits('religious'):
		if Traitdata.traits[tr].tags.has('permanent'):
			return false
	return true


#The story sets what the character believes, past any lock: the religious slot holds tr_code alone.
func set_faith(tr_code):
	for code in traits_stored.keys():
		if code != tr_code and get_trait_category(code) == 'religious':
			remove_trait(code, true)
	add_trait(tr_code)


#The religious trait that names a god, or '' for no faith (Worldly, Airhead, Mortal Pride, Transcendent).
func get_faith():
	for tr in get_category_traits('religious'):
		if Traitdata.traits[tr].has('faith'):
			return tr
	return ''


#Every faith held - two with Split Mind.
func get_faiths():
	var res = []
	for tr in get_category_traits('religious'):
		if Traitdata.traits[tr].has('faith'):
			res.push_back(tr)
	return res


#The faith held in this god's name, '' for none.
func get_god_faith(god):
	for tr in get_faiths():
		if Traitdata.traits[tr].faith == god:
			return tr
	return ''


#The tier a held faith rises to next, '' at Adept or when the story holds it.
func next_faith_tier(tr_code):
	if tr_code == '' or !traits_stored.has(tr_code) or is_trait_locked(tr_code):
		return ''
	var data = Traitdata.traits[tr_code]
	var next = 'faith_%s_%d' % [data.faith, data.tier + 1]
	return next if Traitdata.traits.has(next) else ''


#Prayer or meditation raises this faith, not whichever religious trait is oldest.
func deepen_faith(tr_code):
	var next = next_faith_tier(tr_code)
	if next == '':
		return false
	swap_in_place(tr_code, next, true)
	return true


#Morning and day: the hours a Nixx vow or a trait's 'daylight' weighs on; the rest is 'night'.
func is_daylight():
	return ResourceScripts.game_globals != null and ResourceScripts.game_globals.hour <= 2


func refresh_daylight_vows():
	for tr in traits_real.keys() + traits_2_real.keys():
		var data = Traitdata.traits[tr]
		if data.get('vows', {}).has('daylight') or data.has('daylight') or data.has('night'):
			rebuild = variables.DYN_STATS_REBUILD
			return


#The tier a held faith falls to, '' at Follower or when the story holds it.
func prev_faith_tier(tr_code):
	if tr_code == '' or !traits_stored.has(tr_code) or is_category_locked('religious'):
		return ''
	var data = Traitdata.traits[tr_code]
	if data.get('tier', 1) <= 1:
		return ''
	return 'faith_%s_%d' % [data.faith, data.tier - 1]


#Breaking a vow costs a tier; the first tier holds no vows, so it is as low as this goes.
#A faith the story holds does not drop.
func demote_faith(tr_code):
	var prev = prev_faith_tier(tr_code)
	if prev == '':
		return false
	swap_in_place(tr_code, prev, true)
	return true


#The tier this character holds in the god's faith, 0 for none.
func faith_tier(god):
	var code = get_god_faith(god)
	return Traitdata.traits[code].tier if code != '' else 0


#A growing trait moves on to its next stage in the slot it already holds - or, with grow.to, turns into that trait.
func grow_trait(tr_code, log_type = 'work'):
	var data = Traitdata.traits.get(tr_code, {})
	if !traits_stored.has(tr_code) or !data.has('grow'):
		return false
	var next = data.grow.get('to', '')
	if next == '':
		next = '%s_%d' % [data.line, data.stage + 1]
	trait_progress.erase(tr_code)
	swap_in_place(tr_code, next, true)
	var person = parent.get_ref()
	if person.is_in_game_party():
		input_handler.update_progress_data('seen_trait_stages', next)
		globals.mansion_activity_log_add(log_type, person.translate(tr("TRAITGROWN")).replace("{old}", tr(data.name)).replace("{new}", tr(Traitdata.traits[next].name)))
	return true


func traits_growing_by(kind):
	var res = []
	for tr in traits_stored:
		if Traitdata.traits[tr].get('grow', {}).get('by', '') == kind:
			res.push_back(tr)
	return res


#Growth that waits on the character's own state - a mastery level, a base stat, a faith tier -
#and the hours put into the job a trait asks for. Run every hour.
func tick_trait_growth():
	var task = ResourceScripts.game_res.tasks_progresses.get(parent.get_ref().get_work())
	for tr in traits_stored.keys():
		var grow = Traitdata.traits[tr].get('grow', {})
		match grow.get('by', ''):
			'work':
				if task != null and task_mod(task) == grow.mod:
					trait_progress[tr] = trait_progress.get(tr, 0) + 1
					if trait_progress[tr] >= grow.days * variables.HoursPerDay:
						grow_trait(tr)
	check_trait_growth()


#the job modifier a task is worked by; a gathering task saved before it carried one finds it on its template
func task_mod(task):
	if task.has('mod'):
		return task.mod
	var template = tasks.find_task_for_res(task.get('job', ''))
	if template == null:
		return ''
	return tasks.tasklist[template].get('mod', '')


func check_trait_growth():
	for tr in traits_stored.keys():
		var grow = Traitdata.traits[tr].get('grow', {})
		match grow.get('by', ''):
			'mastery':
				if get_mastery_level(grow.school) >= grow.level:
					grow_trait(tr)
			'stat':
				if parent.get_ref().get_stat(grow.stat) >= grow.value:
					grow_trait(tr)
			'faith':
				if faith_tier(grow.god) >= grow.tier:
					grow_trait(tr)


#a killing blow in combat: a trait may be waiting on this kind of enemy
func grow_by_kill(victim):
	if !(victim is Object) or victim.get('npc_reference') == null:
		return
	for tr in traits_growing_by('kill'):
		if Traitdata.traits[tr].grow.enemies.has(victim.npc_reference):
			grow_trait(tr)


#a grown trait passes on to children as the stage it started from
func first_stage(tr_code):
	var data = Traitdata.traits[tr_code]
	return '%s_1' % data.line if data.has('line') else tr_code


func is_trait_locked(tr_code):
	var tags = Traitdata.traits[tr_code].tags
	if tags.has('bondage') and parent.get_ref().get_stat('slave_class') in ['slave', 'slave_trained']:
		return true
	if is_category_locked(get_trait_category(tr_code)):
		return true
	return tags.has('permanent') or !traits_stored.has(tr_code)


func is_trait_hidden(tr_code):
	return Traitdata.traits[tr_code].tags.has('hidden') and !traits_revealed.has(tr_code)


func reveal_trait(tr_code):
	traits_revealed[tr_code] = true


func get_replaceable_traits(category):
	var res = []
	for tr in get_category_traits(category):
		if !is_trait_locked(tr):
			res.push_back(tr)
	return res


#What offer_trait would do, without doing it: 'add', 'replace', 'ask' or 'skip'.
#Modes: 'ask' puts a full slot to the player, 'force' replaces the oldest trait in the way,
#'free_only' takes an empty slot or nothing.
func preview_trait_offer(tr_code, mode = 'ask'):
	if !Traitdata.traits.has(tr_code) or owns_trait(tr_code):
		return 'skip'
	var category = get_trait_category(tr_code)
	if is_category_locked(category):
		return 'skip'
	#a god is followed at one tier only, and Airhead takes up no faith however many slots there are
	var faith = Traitdata.traits[tr_code].get('faith', '')
	if faith != '' and (get_god_faith(faith) != '' or has_status('no_faith')):
		return 'skip'
	#Undead takes its whole category: it always comes in, and add_trait clears the rest
	if category == '' or get_free_trait_slots(category) > 0 or Traitdata.traits[tr_code].tags.has('clears_category'):
		return 'add'
	if mode == 'free_only' or get_replaceable_traits(category).empty():
		return 'skip'
	if mode == 'force':
		return 'replace'
	return 'ask'


func offer_trait(tr_code, mode = 'ask'):
	var result = preview_trait_offer(tr_code, mode)
	match result:
		'add':
			add_trait(tr_code)
		'replace':
			replace_trait(get_forced_replacement(tr_code), tr_code)
		'ask':
			parent.get_ref().ask_trait_replacement(tr_code)
	return result


#The trait a forced offer writes over when its category is full.
func get_forced_replacement(tr_code):
	return get_oldest_trait(get_replaceable_traits(get_trait_category(tr_code)))


func get_oldest_trait(codes):
	var res = codes[0]
	for tr in codes:
		if traits_stored[tr] < traits_stored[res]:
			res = tr
	return res


func replace_trait(old_code, new_code):
	if is_trait_locked(old_code) or owns_trait(new_code):
		return
	swap_in_place(old_code, new_code)


#The new trait takes the old one's slot age, so trimming an extra slot still finds the trait that came last.
func swap_in_place(old_code, new_code, forced = false):
	var stamp = traits_stored.get(old_code)
	remove_trait(old_code, forced)
	add_trait(new_code)
	if stamp != null and traits_stored.has(new_code):
		traits_stored[new_code] = stamp


#Soul stone: the magic traits it can draw out of this character - their own, not locked, not hidden.
func get_transferable_traits():
	var res = []
	for code in get_category_traits('magic'):
		if traits_stored.has(code) and !is_trait_locked(code) and !is_trait_hidden(code):
			res.push_back(code)
	return res


#Soul stone: what binding tr_code to this character costs - {lose = [...], free = bool, blocked = ''}.
#An opposite element is simply written over; otherwise a free slot takes it, or the chosen trait gives
#way (by default a negative one, else the oldest).
func preview_trait_binding(tr_code, replace_code = ''):
	var res = {lose = [], free = false, blocked = ''}
	if owns_trait(tr_code):
		res.blocked = 'owned'
		return res
	var data = Traitdata.traits[tr_code]
	for code in traits_stored:
		if data.get('conflicts', []).has(code) or Traitdata.traits[code].get('conflicts', []).has(tr_code):
			if is_trait_locked(code):
				res.blocked = 'locked'
				return res
			res.lose.push_back(code)
	if !res.lose.empty():
		return res
	var category = get_trait_category(tr_code)
	if get_free_trait_slots(category) > 0:
		res.free = true
		return res
	var open = get_replaceable_traits(category)
	if open.empty():
		res.blocked = 'locked'
	elif open.has(replace_code):
		res.lose = [replace_code]
	else:
		var negative = []
		for code in open:
			if Traitdata.traits[code].tags.has('negative'):
				negative.push_back(code)
		res.lose = [negative[0] if !negative.empty() else get_oldest_trait(open)]
	return res


#every owned trait with a rule for the event ('freed', 'enslaved') turns into the trait it names;
#a bondage status set free turns by its release rule
func transform_traits(event):
	for tr in traits_stored.keys():
		var data = Traitdata.traits.get(tr)
		if data == null:
			continue
		var next = ''
		if data.has('transforms') and data.transforms.has(event):
			next = data.transforms[event]
		elif event == 'freed' and data.has('release'):
			next = release_target(data.release)
		if next == '':
			continue
		remove_trait(tr, true)
		add_trait(next)


func release_target(rule):
	var cond = rule.get('becomes_if', {})
	if !cond.empty() and parent.get_ref().get_stat(cond.stat) >= cond.at_least:
		return cond.code
	return rule.get('becomes', '')


func get_bondage_status():
	for code in traits_stored:
		if Traitdata.traits[code].tags.has('bondage'):
			return code
	return ''


func set_bondage_status(tr_code):
	var old = get_bondage_status()
	if old == tr_code:
		return false
	if old != '':
		remove_trait(old, true)
	return offer_trait(tr_code, 'force') in ['add', 'replace']


func enslave_status():
	var person = parent.get_ref()
	if person.is_unique():
		return
	var options = Traitdata.catalogue.bondage.enslaved.get(person.get_stat('personality'), [])
	if !options.empty():
		set_bondage_status(input_handler.random_from_array(options))


func market_status(faction):
	var rules = Traitdata.catalogue.bondage.market
	var stock = rules.get(faction, rules.default)
	if faction == 'exotic_slave_trader' and !parent.get_ref().tags.has('exotic_stock'):
		parent.get_ref().tags.append('exotic_stock')
	if randf() < stock.chance:
		set_bondage_status(input_handler.weightedrandom_dict(stock.weights))


#the Writ lets a slave go; some statuses take the chance and leave
func leaves_when_freed():
	var code = get_bondage_status()
	if code == '':
		return false
	var rule = Traitdata.traits[code].get('release', {}).get('leave_if', {})
	return !rule.empty() and parent.get_ref().get_stat(rule.stat) < rule.below


func grow_ready(grow):
	var person = parent.get_ref()
	if grow.get('slaves_only', false) and !(person.get_stat('slave_class') in ['slave', 'slave_trained']):
		return false
	for stat in grow.get('at_least', {}):
		if person.get_stat(stat) < grow.at_least[stat]:
			return false
	for stat in grow.get('above', {}):
		if person.get_stat(stat) <= grow.above[stat]:
			return false
	return true


#affection or respect changed: a status may have earned its next form
func check_bond_shift():
	var code = get_bondage_status()
	if code == '':
		return
	var grow = Traitdata.traits[code].get('grow', {})
	if grow.get('by', '') == 'bond' and grow_ready(grow):
		grow_trait(code, 'relationship')


#too many failed training sessions break a slave
func bondage_after_training(failed_sessions):
	if failed_sessions > Traitdata.catalogue.bondage.broken_after_fails and get_bondage_status() != 'broken' and set_bondage_status('broken'):
		var person = parent.get_ref()
		globals.mansion_activity_log_add('training', person.translate(tr("TRAINING_STATUS_CHANGED")).replace("{new}", tr(Traitdata.traits.broken.name)))


#the slave has just become a trained one: a status waiting on that moves on (Defiant with respect enough)
func bondage_on_training_finished():
	var code = get_bondage_status()
	if code == '':
		return
	var grow = Traitdata.traits[code].get('grow', {})
	if grow.get('by', '') == 'training' and grow_ready(grow):
		grow_trait(code, 'training')


#A won fight as one of its standing fighters saw it: alone (summons aside) and with the master or not.
func grow_by_victory(alone, with_master):
	for code in traits_stored.keys():
		var grow = Traitdata.traits[code].get('grow', {})
		match grow.get('by', ''):
			'win':
				trait_progress[code] = trait_progress.get(code, 0) + 1
				if trait_progress[code] >= grow.count:
					grow_trait(code)
			'solo_win':
				if alone and randf() < grow.chance:
					grow_trait(code)
			'master_win':
				if with_master and grow_ready(grow) and randf() < grow.chance:
					grow_trait(code)


func get_trait_sum(field):
	var res = 0.0
	for code in traits_stored:
		res += Traitdata.traits[code].get(field, 0.0)
	return res


func master_nearby():
	var master = ResourceScripts.game_party.get_master()
	var person = parent.get_ref()
	return master != null and (master == person or person.same_location_with(master))


func add_rare_trait():
	var n = 1
	if globals.rng.randf() < variables.enemy_doublerarechance:
		n = 2
	var list = variables.rare_enemy_traits.duplicate()
	for i in range(n):
		var trait = list[globals.rng.randi_range(0, list.size() - 1)]
		list.erase(trait)
		add_trait(trait)


func get_traits_by_tag(tag):
	if rebuild < variables.DYN_STATS_PREAREA:
		generate_data(variables.DYN_STATS_PREAREA)
	var res = []
	for tr in traits_real.keys() + traits_2_real.keys():
		var traitdata = Traitdata.traits[tr]
		if traitdata.has('tags') and traitdata.tags.has(tag):
			res.push_back(tr)
	return res


func get_traits_by_arg(arg, value):
	var res = []
	for tr in traits_real.keys() + traits_2_real.keys():
		var traitdata = Traitdata.traits[tr]
		if traitdata.has(arg) and traitdata[arg] == value:
			res.push_back(tr)
	return res


func get_random_trait_tag(tag, trait_blacklist = []):
	var buf = {}
	var free_slots = {}
	var race_mult = Traitdata.catalogue.race_weights.get(parent.get_ref().get_stat('race'), {})
	for tr in Traitdata.traits:
		if !can_add_trait(tr):
			 continue
		if trait_blacklist.has(tr): 
			continue
		var data = Traitdata.traits[tr]
		if !data.has('tags'):
			 continue
		if !data.tags.has(tag): 
			continue
		if !data.has('weight'):
			continue # or not
		var weight = data.weight * race_mult.get(tr, 1)
		if weight <= 0:
			continue
		var category = data.get('category', '')
		if category != '':
			if !free_slots.has(category):
				free_slots[category] = get_free_trait_slots(category)
			if free_slots[category] <= 0:
				continue
		buf[tr] = weight
	return input_handler.weightedrandom_dict(buf)


func get_random_traits(trait_blacklist = []):
	add_trait(get_random_trait_tag('positive', trait_blacklist))
	if randf() < 0.15:
		add_trait(get_random_trait_tag('positive', trait_blacklist))
	if randf() < 0.5:
		add_trait(get_random_trait_tag('negative', trait_blacklist))
	if randf() < 0.5:
		add_trait(get_random_trait_tag('negative', trait_blacklist))
	roll_race_faith()
	add_default_traits()


func roll_race_faith():
	var roll = randf()
	var chances = Traitdata.catalogue.race_faith.get(parent.get_ref().get_stat('race'), {})
	for code in chances:
		roll -= chances[code]
		if roll < 0:
			add_trait(code)
			return


func get_traits_buffs():
	for tr in traits_real.keys() + traits_2_real.keys():
		var tbuff = Traitdata.make_buff_for_trait(tr)
		if tbuff != null: 
			buffs.push_back(tbuff)

#professions
func get_prof_number():
	var tres = professions.size()
	if professions.has("master") or professions.has('spouse'): 
		tres -= 1
	return tres


func get_professions():
	var tmp = []
	for prof in professions:
		tmp.push_back([prof, professions[prof]])
	tmp.sort_custom(input_handler, 'timestamp_sort')
	var res = []
	for rec in tmp:
		res.push_back(rec[0])
	return res
#	return professions.keys()


func get_class_list(category, person):
	var array = []
	for i in classesdata.professions.values():
		if i.tags.has('cant_spawn'):
			continue
		if (category != 'any' && i.categories.has(category) == false) || professions.has(i.code):
			continue
		if parent.get_ref().checkreqs(i.reqs, true):
			array.append(i)
	return array


func unlock_class(prof, satisfy_progress_reqs = false):
	prof = classesdata.professions[prof]
	if satisfy_progress_reqs == true:
		for i in prof.reqs:
			if i.code == 'stat' && i.stat in ['physics','wits','charm','sexuals']:
				parent.get_ref().set_stat(i.stat, i.value)
	if professions.has(prof.code):
		return "Already has this profession"
	professions[prof.code] = get_timestamp()
	if prof.has('persistent_effects'):
		for eff in prof.persistent_effects:
			add_stored_effect(eff)
	rebuild = variables.DYN_STATS_REBUILD
	drop_displaced_defaults()
	if parent.get_ref().is_in_game_party():
		globals.text_log_add('char', "%s: acquired profession %s" %
			[parent.get_ref().get_short_name(), prof.name])
		input_handler.achievements.try_add_prof_achimnt(prof.code)


func remove_class(prof_id):
	if !professions.has(prof_id):
		return "Nothing to remove"
	remove_all_temp_effects_tag('class_' + prof_id)
	professions.erase(prof_id)
	rebuild = variables.DYN_STATS_REBUILD


func remove_all_classes():
	for i in classesdata.professions:
		if !classesdata.professions[i].tags.has('permanent'):
			remove_class(i)

#create
func roll_growth(diff):
	var weight = {}
	weight[1] = 100 - (diff - 1) * 100.0/14.0
	weight[4] = 5 + (diff - 1) * 10.0/14.0
	weight[5] = 2 + (diff - 1) * 7.0/14.0
	weight[6] = 0.7 + (diff - 1) * 4.0/14.0
	if diff <= 3:
		weight[2] = 40 + (diff - 1) * 10.0/2.0
	else:
		weight[2] = 50 - (diff - 3) * 45.0/12.0
	if diff <= 5:
		weight[3] = 25 + (diff - 1) * 35.0/4.0
	else:
		weight[3] = 60 - (diff - 5) * 25.0/10.0
	var tmp = input_handler.weightedrandom_dict(weight)
	set_default_value('growth_factor', tmp)


#factor_cap is the ceiling this character's factors are cut to once every random step is done -
#the dungeon tiers in variables.dungeon_factor_caps pass one in. It lands before the classes are
#handed out on purpose: a captive capped at 4 physics cannot then roll paladin, which asks for 5.
func generate_random_character_from_data(desired_class = null, adjust_difficulty = 0, guaranteed_classes = [], factor_cap = variables.maximum_factor_value):
	roll_growth(adjust_difficulty)
	
	var slaveclass = desired_class
	if slaveclass == null:
		slaveclass = input_handler.weightedrandom([['combat', 1],['magic', 1],['social', 1],['sexual',1], ['labor',1]])
	
	if slaveclass == 'magic' && statlist.magic_factor == 1: #prevents finding no class as there's no magic base classes which allow magic factor < 2
		statlist.magic_factor = 2
	
	var difficulty = int(round(adjust_difficulty))
	var classcounter = round(rand_range(variables.slave_classes_per_difficulty[difficulty][0], variables.slave_classes_per_difficulty[difficulty][1]))
	var guaranteed_class = get_guaranteed_class(guaranteed_classes)
	if guaranteed_class != null and classcounter < 1:
		classcounter = 1
	
	#Add extra stats for harder characters
	var bonus_counter = 0
	while difficulty > 0 && bonus_counter < 10:
		var array = []
		array = ['physics_factor', 'magic_factor', 'wits_factor','sexuals_factor', 'charm_factor', 'tame_factor', 'authority_factor']
		array = input_handler.random_from_array(array)
		if randf() >= 0.2:
			statlist[array] += globals.rng.randi_range(0, 2)
		if randf() >= 0.5:
			statlist[array] += globals.rng.randi_range(-1, 1)
		difficulty -= 1
		bonus_counter += 1
	#int(), because min() hands back a float and these stats are stored as whole numbers
	var factor_ceiling = int(min(factor_cap, variables.maximum_factor_value))
	#growth_factor rides along although no bonus touched it: roll_growth() can hand out a 6 on its
	#own, and a capped dungeon that still yields 6 growth reads as a broken cap to the player.
	for st in ['physics_factor', 'magic_factor', 'wits_factor','sexuals_factor', 'charm_factor', 'tame_factor', 'authority_factor', 'growth_factor']:
		if statlist[st] < variables.minimum_factor_value:
			statlist[st] = variables.minimum_factor_value
		if statlist[st] > factor_ceiling:
			statlist[st] = factor_ceiling
	
	#assign classes
	while classcounter > 0:
		if guaranteed_class == null and randf() > 0.65:
			classcounter -= 1
			continue
		if guaranteed_class != null:
			unlock_class(guaranteed_class, false)
			guaranteed_class = null
		else:
			var classarray = []
			if randf() >= 0.85:
				classarray = get_class_list('any', parent.get_ref())
			else:
				classarray = get_class_list(slaveclass, parent.get_ref())
			if classarray != null && classarray.size() > 0:
				unlock_class(input_handler.random_from_array(classarray).code, true)
		classcounter -= 1


func get_guaranteed_class(class_array):
	if class_array.empty():
		return null
	var valid_classes = []
	for prof in class_array:
		if !classesdata.professions.has(prof):
			continue
		if professions.has(prof):
			continue
		valid_classes.push_back(prof)
	if valid_classes.empty():
		return null
	return input_handler.random_from_array(valid_classes)


func get_racial_features(race):
	var race_template = races.racelist[race]
	for i in race_template.basestats:
		set_default_value(i, globals.rng.randi_range(race_template.basestats[i][0], race_template.basestats[i][1]))


func process_chardata(chardata):
	for i in chardata:
		if !(i in ['code', 'slave_class', 'tags','sex_traits', 'sex_skills', 'sex_training', 'personality', 'training_disposition', 'blocked_training_traits', 'training_points', 'affection', 'respect', 'traits', 'food_like', 'food_hate', 'classes', 'skills', 'mastery', 'achievement', 'achi_bonus', 'achi_wedding']):
			var st_data = statdata.statdata[i]
			if !st_data.direct:
				set_default_value(i, chardata[i])
	if chardata.has('classes'):
		for prof in chardata.classes:
			unlock_class(prof)
	if chardata.has("traits"):
		for i in chardata.traits:
			add_trait(i)
	if chardata.has("mastery"):
		for school in chardata.mastery:
			for i in range(chardata.mastery[school]):
				upgrade_mastery(school, true)

#masteries
func reset_mastery():
	rebuild = variables.DYN_STATS_REBUILD
	for school in masteries:
		for i in ['combat', 'universal', 'magic']:
			masteries[school][i].clear()


func upgrade_mastery_cost(school, force_universal = false):
	var res = {
		combat = 0,
		magic = 0,
		universal = 0,
	}
	var data = Skilldata.masteries[school]
	match data.type:
		'combat':
			if !force_universal:
				res.combat = 1
			else:
				res.universal = 1
		'spell':
			if !force_universal:
				res.magic = 1
			else:
				res.universal = 1
	return res


func can_upgrade_mastery(school, force_universal = false):
	if rebuild < variables.DYN_STATS_PREAREA:
		generate_data(variables.DYN_STATS_PREAREA)
	var data = Skilldata.masteries[school]
	if !masteries_real[school].enable:
		return false
	if masteries_real[school].magic.size() + masteries_real[school].combat.size() + masteries_real[school].universal.size() >= variables.mastery_train_limit:
		return false
	var cost = upgrade_mastery_cost(school, force_universal)
	for c in cost:
		if cost[c] > parent.get_ref().get_stat('mastery_point_' + c):
			return false
	return true


func upgrade_mastery(school, force_universal = false):
	rebuild = variables.DYN_STATS_REBUILD
	var data = Skilldata.masteries[school]
	var cost = upgrade_mastery_cost(school, force_universal)
	var ts = get_timestamp()
	for c in cost:
		for i in range(cost[c]):
			masteries[school][c].push_back(ts)
	check_trait_growth()


func add_mastery_point_passive(school, value):
	rebuild = variables.DYN_STATS_REBUILD
	var ts = get_timestamp()
	for i in range(value):
		masteries[school].passive.push_back(ts)


func remove_mastery_point_passive(school, value):
	rebuild = variables.DYN_STATS_REBUILD
	for i in range(value):
		masteries[school].passive.pop_back()


func get_mastery_level(school, desc_ready = false): #external check, for the sake of condition sanity
	if desc_ready:
		parent.get_ref().reset_stat_compo_dict()
		parent.get_ref().stat_compo_dict.bonuses.add = []
	if rebuild < variables.DYN_STATS_PREAREA:
		generate_data(variables.DYN_STATS_PREAREA)
	var res = 0
	if masteries_real[school].enable:
		for real_type in ['universal', 'combat', 'magic', 'passive']:
			res += masteries_real[school][real_type].size()
			if desc_ready:
				if real_type == 'passive':
					if masteries_sources.has(school):
						for src_type in masteries_sources[school]:
							for src_value in masteries_sources[school][src_type]:
								parent.get_ref().stat_compo_dict.bonuses.add.append({
									src_type = src_type,
									src_value = src_value,
									value = masteries_sources[school][src_type][src_value]
								})
				else:
					parent.get_ref().stat_compo_dict.bonuses.add.append({
						src_type = 'masteries_points',
						src_value = real_type,
						value = masteries_real[school][real_type].size()
					})
	if desc_ready:
		parent.get_ref().stat_compo_dict.result = res
	return res


func get_used_mastery_points(category):
	var res = 0
	for rec in masteries.values():
		res += rec[category].size()
	return res


#Stats that decide a contest between two fighters rather than add to one of them.
#The hit roll is accuracy minus evasion and the turn order is speed against speed,
#so the monster rate does not make these bigger, it makes the contest one-sided:
#the difference outruns anything a character can reach, the hit roll pins to its
#5% floor and the enemy simply moves first every round. Speed is not in the depth
#multiplier's lists at all, so nothing bounds it from the other side.
#Granted at the player rate; every other passive keeps the monster one.
const MASTERY_STATS_AT_PLAYER_RATE = ['hitrate', 'evasion', 'speed']


func _add_mastery_as_bonuses(category, lv, mul = 2.5):
	if lv <= 0:
		return
	info_bonus_mastery['monster_mastery_' + category] = {category = category, lvl = lv, mul = mul}
	add_trait('monster_mastery_' + category)
	var mas_data = Skilldata.masteries[category]
	for i in range(lv):
		for stat in mas_data.passive:
			var stat_mul = mul
			if stat in MASTERY_STATS_AT_PLAYER_RATE:
				stat_mul = 1.0
			process_bonus_record(stat, mas_data.passive[stat] * stat_mul, 'innate', category, 0)
		if i < mas_data.maxlevel:
			var lvdata = mas_data['level%d' % (i + 1)]
			for trait in lvdata.traits:
				add_trait(trait)
			for id in lvdata.combat_skills:
				parent.get_ref().learn_c_skill(id)


#bodmodes
func get_upgrade_points():
	var res = get_stat('upgrade_points_total')
	for upg in body_upgrades:
		if !Traitdata.body_upgrades.has(upg):
			print ('unknown body upgrade - %s' % upg)
			continue
		var upgrade_data = Traitdata.body_upgrades[upg]
		res -= upgrade_data.cost 
	return res


func add_upgrade(upg): #unsafe adding
	if body_upgrades.has(upg):
		return
	if !Traitdata.body_upgrades.has(upg):
		return
	rebuild = variables.DYN_STATS_REBUILD
	body_upgrades[upg] = get_timestamp()



func can_add_upgrade(upg):
	if body_upgrades.has(upg):
		return false
	if !Traitdata.body_upgrades.has(upg):
		return false
	
	var upgrade_data = Traitdata.body_upgrades[upg]
	
	if !parent.get_ref().checkreqs(upgrade_data.reqs):
		return false
	
	if get_upgrade_points() < upgrade_data.cost:
		return false
	
	return true


func remove_upgrade(upg):
	if !body_upgrades.has(upg):
		return
	body_upgrades.erase(upg)
	if !Traitdata.body_upgrades.has(upg):
		return
	var upgrade_data = Traitdata.body_upgrades[upg]
	rebuild = variables.DYN_STATS_REBUILD
	parent.get_ref().recheck_equip()


func recheck_upgrades():
	for upg in body_upgrades.duplicate():
		if !Traitdata.body_upgrades.has(upg):
			body_upgrades.erase(upg)
		else:
			var upgrade_data = Traitdata.body_upgrades[upg]
			if !parent.get_ref().checkreqs(upgrade_data.reqs):
				remove_upgrade(upg) #hope that there would be no removal chaining


func get_body_upgrades():
	return body_upgrades.keys().duplicate()


func has_body_upgrade(id):
	return body_upgrades.has(id)

#real skills
func rebuild_skills():
	if rebuild < variables.DYN_STATS_FULL:
		generate_data()


func get_combat_skills():
	if rebuild < variables.DYN_STATS_FULL:
		generate_data()
	return c_skills_real


func get_social_skills():
	if rebuild < variables.DYN_STATS_FULL:
		generate_data()
	return skills_real


func get_explore_skills():
	if rebuild < variables.DYN_STATS_FULL:
		generate_data()
	return e_skills_real


func has_skill(id):
	if rebuild < variables.DYN_STATS_FULL:
		generate_data()
	return c_skills_real.has(id) or skills_real.has(id) or e_skills_real.has(id)

func get_buff_number(status):
	var result = 0
	for buff in effects_temp_real:
		var ef_stack = effects_temp_real[buff]
		if ef_stack.code != status:
			continue
		if ef_stack.template['type'] == 'stack_a':
			if ef_stack.buffs.empty():
				continue
			if ef_stack.buffs[0].tags.has('show_amount'):
				result += ef_stack.buffs[0].get_stacks()
			else:
				result += ef_stack.get_duration().count
		else:
			result += ef_stack.get_duration().count
	return result

func has_info_bonus_mastery(mastery):
	return info_bonus_mastery.has(mastery)

func get_info_bonus_mastery(mastery):
	return info_bonus_mastery[mastery]

func try_get_bonus_mastery_desc(mastery):
	var desc = ""
	if !has_info_bonus_mastery(mastery):
		return desc
	var entry = get_info_bonus_mastery(mastery)
	var mas_data = Skilldata.masteries[entry.category]
	desc = "%s. %s" % [tr("MASTERYLEVEL") % entry.lvl, tr("MASTERYGRANTS")]
#	for stat in mas_data.passive:
#		var data = statdata.statdata[stat]
#		var val = mas_data.passive[stat] * entry.mul
#		desc += " %s" % (globals.get_bonus_name_string(data.default_bonus, data, val)
#			+ globals.make_bonus_value_string(data.default_bonus, data, val))
#	desc += ". %s" % tr("MASTERYGRANTS")
	var text_list = []
	for i in range(entry.lvl):
		if i < mas_data.maxlevel:
			var lvdata = mas_data['level%d' % (i + 1)]
			for id in lvdata.traits:
				var trait = Traitdata.traits[id]
				text_list.append(tr(trait.name))
			for id in lvdata.combat_skills:
				var skill = Skilldata.get_template_combat(id, parent.get_ref())
				text_list.append(tr(skill.name))
	for j in range(text_list.size()):
		if j > 0:
			desc += ","
		desc += " %s" % text_list[j]
	desc += "."
	return desc
