extends "res://src/character/ch_effects.gd"


#stored
var statlist = Statlist_init.template_dynamic.duplicate(true) 
var manacost_mods = Statlist_init.manacost_mods.duplicate(true) 
var resists = Statlist_init.resists.duplicate(true) 
var damage_mods = Statlist_init.damage_mods.duplicate(true) 
var traits_stored = {}
var body_upgrades = {}
var professions = {}
var masteries = {} #{magic = [], combat = [], universal = [], passive = [], enable = true},
var bonuses_stored = {}

#rebuildable
var traits_real = {}
var masteries_real = {}
var skills_real = []
var c_skills_real = []
var e_skills_real = []
var stat_bonuses = {}
var buffs = []


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
	
	generate_data(variables.DYN_STATS_FULL, true)


func fix_serialize():
	for tr in traits_stored.duplicate():
		if Traitdata.traits.has(tr): 
			continue
		traits_stored.erase(tr)
	for prof in professions.keys():
		if classesdata.professions.has(prof): 
			continue
		professions.erase(prof)


#dyn_bonuses
func generate_data(stop_at = variables.DYN_STATS_FULL, forced = false):
	if rebuild >= stop_at and !forced:
		return
	#reset
	clear_nonstored_effs()
	traits_real = traits_stored.duplicate()
	masteries_real = masteries.duplicate(true)
	var skills_old = skills_real.duplicate()
	var c_skills_old = c_skills_real.duplicate()
	skills_real = parent.get_ref().get_learned_skills('social')
	c_skills_real = parent.get_ref().get_learned_skills('combat')
	e_skills_real = parent.get_ref().get_learned_skills('explore')
	stat_bonuses = bonuses_stored.duplicate(true)
	buffs.clear()
	#stored effects_duplicating
	effects_real = effects_stored.duplicate()
	effects_temp_real.clear()
	for stack in effects_temp_stored:
		effects_temp_real[stack] = effects_pool.clone_stack(effects_temp_stored[stack])
	effects_temp_globals_real = effects_temp_globals.duplicate()
	
	var race = parent.get_ref().get_stat('race')
	process_race_data(race)
	for prof in professions:
		process_prof_data(prof, professions[prof])
	for upg in body_upgrades:
		var upg_data = Traitdata.body_upgrades[upg]
		if upg_data.has('traits'):
			for tr in upg_data.traits:
				process_trait_add(tr, body_upgrades[upg])
	rebuild = variables.DYN_STATS_FACTORS
	if rebuild >= stop_at and !forced:
		return
	update_masteries()
	for trait in traits_real:
		process_trait_data(trait, traits_real[trait])
	var tattoos = parent.get_ref().get_tattoos()
	for slot in tattoos:
		if tattoos[slot] == null:
			continue
		var tatdata = Traitdata.tattoodata[tattoos[slot]].effects
		for rec in tatdata:
			if rec.has(slot):
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
		parent.get_ref().fix_skillpanels(input_handler.compare_list(skills_real, skills_old), input_handler.compare_list(c_skills_real, c_skills_old))
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



func process_race_data(id):
	if id == '':
		return
	var data = races.racelist[id]
	for stat in data.race_bonus:
		process_bonus_record(stat, data.race_bonus[stat], 'race', id, 0)
	if data.has('traits'):
		for tr in data.traits:
			process_trait_add(tr, 0)


func process_prof_data(id, timestamp):
	var profdata = classesdata.professions[id]
	for stat in profdata.statchanges:
		process_bonus_record(stat, profdata.statchanges[stat], 'class', id, timestamp)
	for trait in profdata.traits:
		process_trait_add(trait, timestamp)
	for id in profdata.skills:
		if !skills_real.has(id):
			skills_real.push_back(id)
	for id in profdata.combatskills:
		if !c_skills_real.has(id):
			c_skills_real.push_back(id)


func process_trait_data(id, timestamp):
	var traitdata = Traitdata.traits[id]
	for stat in traitdata.bonusstats:
		process_bonus_record(stat, traitdata.bonusstats[stat], 'trait', id, timestamp)
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


func add_stat_bonus(stat, value, operant, src_type, src_value, timestamp):
	var store = stat_bonuses
	if src_type == 'innate':
		store = bonuses_stored
	if !store.has(stat):
		store[stat] = {}
	if !store[stat].has(operant):
		store[stat][operant] = []
	store[stat][operant].push_back({value = value, src_type = src_type, src_value = src_value, timestamp = timestamp})


func gather_innate_bonuses():
	for stat in statdata.statdata:
		var st_data = statdata.statdata[stat]
		if st_data.has('innate_bonuses'):
			for rec in st_data.innate_bonuses:
				add_stat_bonus(stat, st_data.innate_bonuses[rec], rec, 'innate', '', 0)


func process_trait_add(id, timestamp):
	if traits_real.has(id):
		traits_real[id] = min(traits_real[id], timestamp)
	else:
		traits_real[id] = timestamp


func update_masteries():
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
						process_trait_add(trait, mas_full[i])
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
	for tr in traits_real:
		var traitdata = Traitdata.traits[tr]
		if traitdata.has('tags') and traitdata.tags.has(status):
			return true
	return .has_status(status)


#getters
func get_stat_data(stat, stop = variables.DYN_STATS_FULL): #full value
	if rebuild < stop:
		generate_data()
	var res = {
		base_value = 0,
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
						res.result += aggregate_bonus
				'add_part':
					var aggregate_bonus = 1
					if res.bonuses.has(op):
						for rec in res.bonuses[op]:
							aggregate_bonus += rec.value 
						res.result *= aggregate_bonus
				'mul':
					var aggregate_bonus = 1
					if res.bonuses.has(op):
						for rec in res.bonuses[op]:
							aggregate_bonus *= rec.value
						res.result *= aggregate_bonus
				'add2':
					var aggregate_bonus = 0
					if res.bonuses.has(op):
						for rec in res.bonuses[op]:
							aggregate_bonus += rec.value
						res.result += aggregate_bonus
				'add_part2':
					var aggregate_bonus = 1
					if res.bonuses.has(op):
						for rec in res.bonuses[op]:
							aggregate_bonus += rec.value 
						res.result *= aggregate_bonus
				'mul2':
					var aggregate_bonus = 1
					if res.bonuses.has(op):
						for rec in res.bonuses[op]:
							aggregate_bonus *= rec.value
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
						res.result = max(res.result, aggregate_bonus)
	
	return res


func get_stat_timestamps_data(stat, op = 'add'):
	var res = []
	if stat_bonuses.has(stat) and stat_bonuses[stat].has(op):
		for rec in stat_bonuses[stat][op]:
			res.push_back(rec.duplicate())
	res.sort_custom(input_handler, 'timestamp_sort_dict')
	return res


func get_stat(stat): #pure value
	var st_data = statdata.statdata[stat]
	if st_data.tags.has('factor'):
		return get_stat_data(stat, variables.DYN_STATS_FACTORS).result
	else:
		return get_stat_data(stat).result


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
		'speed', 'hitrate':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = min(get_stat('growth_factor') - 1, get_prof_number()) * 4, src_type = 'factor', src_value = 'growth', timestamp = 0})
		'evasion':
			if !data.bonuses.has('add'):
				data.bonuses.add = []
			data.bonuses.add.push_back({value = min(get_stat('growth_factor') - 1, get_prof_number()) * 4, src_type = 'factor', src_value = 'growth', timestamp = 0})
			if has_status('ninja'):
				data.bonuses.add.push_back({value = get_stat('mdef'), src_type = 'class', src_value = 'ninja', timestamp = 0})
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
		'mp_reg':
			if !data.bonuses.has('add2'):
				data.bonuses.add2 = []
			data.bonuses.add2.push_back({value = get_stat('magic_factor') * variables.mp_regen_per_magic, src_type = 'factor', src_value = 'magic', timestamp = 0})
			if ResourceScripts.game_res.upgrades.has('resting') and ResourceScripts.game_res.upgrades.resting > 0:
				if !data.bonuses.has('mul2'):
					data.bonuses.mul2 = []
				data.bonuses.mul2.push_back({value = 1.2, src_type = 'upgrade', src_value = 'resting', timestamp = 0})
		'upgrade_points_total':
			data.base_value = get_stat('growth_factor') * 25
		'lustmax':
			data.base_value = get_stat('sexuals_factor') * 25 + 25
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
		if container.has(stat):
			if value is Array:
				container[stat] = value.duplicate()
			else:
				container[stat] = value

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
	if trait.has('disposition_change'):
		parent.get_ref().process_disposition_data(trait.disposition_change)
	if tr_code == 'undead':
		parent.get_ref().add_stat('charm', -100)
		parent.get_ref().set_work_rule("ration", false)
		parent.get_ref().set_work_rule("contraceptive", false)
	if trait.has('tags') and trait.tags.has('remove_untrained'):
		remove_trait('untrained')
	if tr_code == 'core_trait':
		for eff in trait.effects:
			add_stored_effect(eff)
	if parent.get_ref().is_players_character and trait.visible:
		globals.manifest_and_log('char', "%s: acquired trait %s" %
			[parent.get_ref().get_short_name(), trait.name], parent.get_ref())


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


func remove_trait(tr_code):
	var trait = Traitdata.traits[tr_code]
	if !traits_stored.has(tr_code): 
		return
	traits_stored.erase(tr_code)
	rebuild = variables.DYN_STATS_REBUILD


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
	for tr in traits_real:
		var traitdata = Traitdata.traits[tr]
		if traitdata.has('tags') and traitdata.tags.has(tag):
			res.push_back(tr)
	return res


func get_traits_by_arg(arg, value):
	var res = []
	for tr in traits_real:
		var traitdata = Traitdata.traits[tr]
		if traitdata.has(arg) and traitdata[arg] == value:
			res.push_back(tr)
	return res


func get_random_trait_tag(tag, trait_blacklist = []):
	var buf = {}
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
		buf[tr] = data.weight
	return input_handler.weightedrandom_dict(buf)


func get_random_traits(trait_blacklist = []):
	add_trait(get_random_trait_tag('positive', trait_blacklist))
	if randf() < 0.15:
		add_trait(get_random_trait_tag('positive', trait_blacklist))
	if randf() < 0.5:
		add_trait(get_random_trait_tag('negative', trait_blacklist))
	if randf() < 0.5:
		add_trait(get_random_trait_tag('negative', trait_blacklist))


func get_traits_buffs():
	for tr in traits_real:
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
	return professions.keys()


func get_class_list(category, person):
	var array = []
	for i in classesdata.professions.values():
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
	rebuild = variables.DYN_STATS_REBUILD
	if parent.get_ref().is_players_character:
		globals.manifest_and_log('char', "%s: acquired profession %s" %
			[parent.get_ref().get_short_name(), prof.name], parent.get_ref())


func remove_class(prof):
	prof = classesdata.professions[prof]
	if !professions.has(prof.code):
		return "Nothing to remove"
	professions.erase(prof.code)
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


func generate_random_character_from_data(desired_class = null, adjust_difficulty = 0):
	roll_growth(adjust_difficulty)
	
	var slaveclass = desired_class
	if slaveclass == null:
		slaveclass = input_handler.weightedrandom([['combat', 1],['magic', 1],['social', 1],['sexual',1], ['labor',1]])
	
	if slaveclass == 'magic' && statlist.magic_factor == 1: #prevents finding no class as there's no magic base classes which allow magic factor < 2
		statlist.magic_factor = 2
	
	var difficulty = int(round(adjust_difficulty))
	var classcounter = round(rand_range(variables.slave_classes_per_difficulty[difficulty][0], variables.slave_classes_per_difficulty[difficulty][1]))
	
	#Add extra stats for harder characters
	var bonus_counter = 0
	while difficulty > 0 && bonus_counter < 10:
		var array = []
		array = ['physics_factor', 'magic_factor', 'wits_factor','sexuals_factor', 'charm_factor']
		array = input_handler.random_from_array(array)
		if randf() >= 0.2:
			statlist[array] += globals.rng.randi_range(0, 2)
		if randf() >= 0.5:
			statlist[array] += globals.rng.randi_range(-1, 1)
		difficulty -= 1
		bonus_counter += 1
	
	#assign classes
	while classcounter > 0:
		if randf() > 0.65:
			classcounter -= 1
			continue
		var classarray = []
		if randf() >= 0.85:
			classarray = get_class_list('any', parent.get_ref())
		else:
			classarray = get_class_list(slaveclass, parent.get_ref())
		if classarray != null && classarray.size() > 0:
			unlock_class(input_handler.random_from_array(classarray).code, true)
		classcounter -= 1


func get_racial_features(race):
	var race_template = races.racelist[race]
	for i in race_template.basestats:
		set_default_value(i, globals.rng.randi_range(race_template.basestats[i][0], race_template.basestats[i][1]))


func process_chardata(chardata):
	for i in chardata:
		if !(i in ['code', 'slave_class', 'tags','sex_traits', 'sex_skills', 'personality', 'training_disposition', 'blocked_training_traits','traits', 'food_like', 'food_hate', 'classes', 'skills']):
			var st_data = statdata.statdata[i]
			if !st_data.direct:
				set_default_value(i, chardata[i])
	if chardata.has('classes'):
		for prof in chardata.classes:
			unlock_class(prof)
	if chardata.has("traits"):
		for i in chardata.traits:
			add_trait(i)

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


func add_mastery_point_passive(school, value):
	rebuild = variables.DYN_STATS_REBUILD
	var ts = get_timestamp()
	for i in range(value):
		masteries[school].passive.push_back(ts)


func remove_mastery_point_passive(school, value):
	rebuild = variables.DYN_STATS_REBUILD
	for i in range(value):
		masteries[school].passive.pop_back()


func get_mastery_level(school): #external check, for the sake of condition sanity
	if rebuild < variables.DYN_STATS_PREAREA:
		generate_data(variables.DYN_STATS_PREAREA)
	if masteries_real[school].enable:
		return masteries_real[school].universal.size() + masteries_real[school].combat.size() + masteries_real[school].magic.size() + masteries_real[school].passive.size()
	else:
		return 0 


func get_used_mastery_points(category):
	var res = 0
	for rec in masteries.values():
		res += rec[category].size()
	return res

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

