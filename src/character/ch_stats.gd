extends Reference

var statlist = Statlist_init.template.duplicate(true) setget , default_stats_get
var bonuses = {}
var traits = []
var sex_traits = {}
var negative_sex_traits = {}
var unlocked_sex_traits = []
var body_upgrades = []
var parent: WeakRef = null
var reported_pregnancy = false


func _init():
	for i in variables.resists_list:
		statlist.resists[i] = 0
	for i in variables.resists_damage_list:
		statlist.resist_damage[i] = 0
	for i in variables.status_list:
		statlist.status_resists[i] = 0
	for i in variables.damage_mods_list:
		statlist.damage_mods[i] = 1.0


func deserialize(savedict):
	if savedict.has('bonuses'): bonuses = savedict.bonuses.duplicate()
	if savedict.has('traits'): traits = savedict.traits.duplicate()
	if savedict.has('sex_traits'): sex_traits = savedict.sex_traits.duplicate()
	if savedict.has('negative_sex_traits'): negative_sex_traits = savedict.negative_sex_traits.duplicate()
	if savedict.has('unlocked_sex_traits'): unlocked_sex_traits = savedict.unlocked_sex_traits.duplicate()
	if savedict.has('reported_pregnancy'): reported_pregnancy = savedict.reported_pregnancy
	if savedict.has('tattoo'): tattoo = savedict.tattoo.duplicate()
	if !savedict.has('statlist'): return
	for stat in statlist:
		if savedict.statlist.has(stat):
			statlist[stat] = savedict.statlist[stat]
#			if stat.ends_with("_factor") or stat in ['physics', 'wits', 'charm']:
#				if statlist[stat] > 6: statlist[stat] = 6
#				custom_stats_set(stat, statlist[stat])
	for stat in ['physics_factor', 'magic_factor', 'wits_factor', 'timid_factor', 'tame_factor', 'sexuals_factor', 'charm_factor']:
		custom_stats_set(stat, statlist[stat])
	for stat in  ['physics', 'wits', 'charm']:
		custom_stats_set(stat, statlist[stat])


func fix_import():
	if statlist.unique != null and !ResourceScripts.game_world.easter_egg_characters_acquired.has(statlist.unique):
		ResourceScripts.game_world.easter_egg_characters_acquired.append(statlist.unique)
	statlist.loyalty = 0
	statlist.obedience = 100


func fix_serialize():
	for tr in traits.duplicate():
		if Traitdata.traits.has(tr): continue
		traits.erase(tr)
		var arr = parent.get_ref().find_eff_by_trait(tr)
		for e in arr:
			var eff = effects_pool.get_effect_by_id(e)
			eff.remove()
	for tr in sex_traits.duplicate():
		if Traitdata.sex_traits.has(tr): continue
		sex_traits.erase(tr)
	for tr in unlocked_sex_traits.duplicate():
		if Traitdata.sex_traits.has(tr): continue
		unlocked_sex_traits.erase(tr)


func default_stats_get():
	return statlist.duplicate()


func custom_stats_set(st, value):
#	statlist = value.duplicate(true)
#	if value.has(''):
#		statlist[''] =
#	for st in value:
	if st in ['hair_base_color_1', 'hair_base_color_2' ]:
		statlist[st] = value
		statlist[st.replace('base', 'fringe')] = value
	if st.begins_with('metrics_'):
		var stat = st.trim_prefix('metrics_')
		statlist.metrics[stat] = value
		return
	if st.begins_with("sex_skills_"):
		st = st.trim_prefix("sex_skills_")
		value = min(value, 100.0)
		statlist.sex_skills[st] = value
		return
	if st in ['submission']:
#			if value.has(st):
		var delta = value - statlist[st]
		if delta != 0:
			delta *= get_stat(st+'_gain_mod')
			statlist[st] = clamp(statlist[st] + delta, 0, 100)
	elif st in ['physics', 'wits', 'charm']: #not sure about sexuals since its getter has no reference to original value
#			if value.has(st):
#		statlist[st] = min(value, statlist[st + '_factor'] * 20)
		statlist[st] = min(value, get_stat(st + '_cap'))
	else: statlist[st] = value
#	if st in ['physics', 'magic', 'tame', 'timid', 'growth', 'wits', 'charm', 'sexuals']:
	if st.ends_with('_factor'):
#		if value.has(st+'_factor'):
		statlist[st] = clamp(statlist[st], variables.minimum_factor_value, variables.maximum_factor_value)
	if st == 'lust':
		statlist.lust = clamp(value, 0, get_stat('lustmax'))
#	if st == 'obedience':
#		statlist.obedience = min(statlist.obedience, get_obed_cap())
	if st in ['obedience']:
		statlist[st] = min(statlist[st], statlist[st + '_max'])
	if st == 'name':
		if ResourceScripts.game_party.relativesdata.has(parent.get_ref().id):
			ResourceScripts.game_party.relativesdata[parent.get_ref().id].name = get_full_name()
	if st in ['hair_length','hair_style']: #legacy stub
		statlist[st] = value
		var tdata = get_hairs_data()
		for h_stat in ['hair_base', 'hair_assist', 'hair_back', 'hair_fringe', 'hair_base_lenght', 'hair_fringe_lenght', 'hair_back_lenght', 'hair_assist_lenght',]:
			statlist[h_stat] = tdata[h_stat]
	if st in ['hair_color']: #legacy stub
		statlist[st] = value
		var tdata = get_hairs_data()
		for h_stat in ['hair_base_color_1', 'hair_fringe_color_1', 'hair_back_color_1', 'hair_assist_color_1', 'hair_base_color_2', 'hair_fringe_color_2', 'hair_back_color_2', 'hair_assist_color_2']:
			statlist[h_stat] = tdata[h_stat]


func custom_stats_get(stat):
	if stat == 'sexuals':
		var array = statlist.sex_skills.values()
		array.sort()
		array.invert()
		return (array[0] + array[1] + array[2])/3
	if stat == 'hpmax':
		var tres = statlist.hpmax
		if statlist.is_person == true:
			tres = variables.basic_max_hp
		if bonuses.has('hpmax_add'): tres += bonuses.hpmax_add
		if statlist.race != '':
			var race = statlist.race
			if variables.new_stat_bonuses_syntax == true:
				if bonuses.has('hpfactor'): tres *= bonuses['hpfactor']
			else:
				if races.racelist[race].race_bonus.has('hpfactor'):tres *= races.racelist[race].race_bonus.hpfactor
		if bonuses.has('hp_flat_bonus'): tres += bonuses.hp_flat_bonus
		tres += min(statlist.growth_factor - 1, parent.get_ref().get_prof_number()) * 5
		if bonuses.has('hpmax_mul'): tres *= bonuses.hpmax_mul
		return tres
	if stat == 'mpmax':
		var tres = variables.basic_max_mp + variables.max_mp_per_magic_factor * statlist.magic_factor
		if bonuses.has('mpmax_add'): tres += bonuses.mpmax_add
		tres += min(statlist.growth_factor - 1, parent.get_ref().get_prof_number()) * 5
		if bonuses.has('mpmax_mul'): tres *= bonuses.mpmax_mul
		return tres
	if stat == 'upgrade_points_total':
		var tres = custom_stats_get('growth_factor') * 25
		if bonuses.has('upgrade_points_total_add'): tres += bonuses.upgrade_points_total_add
		if bonuses.has('upgrade_points_total_mul'): tres *= bonuses.upgrade_points_total_mul
		return tres
	if stat == 'obedience_max':
		var tres = variables.basic_max_obed
		if bonuses.has('obedience_max_add'): tres += bonuses.obedience_max_add
		if bonuses.has('obedience_max_mul'): tres *= bonuses.obedience_max_mul
		return tres
	if stat == 'obedience':
		statlist.obedience =  clamp(statlist.obedience, 0, custom_stats_get('obedience_max'))
		return statlist.obedience
	if stat == 'lusttick':
		var tres = variables.basic_lust_per_tick
		if bonuses.has('lusttick_add'): tres += bonuses.lusttick_add
		if bonuses.has('lusttick_mul'): tres *= bonuses.lusttick_mul
		return tres
	if stat in ['physics', 'wits', 'charm']:
		var tres = min(statlist[stat], custom_stats_get(stat + '_cap'))
		statlist[stat] = tres
		return tres
	if stat.ends_with('_cap') and stat.trim_suffix('_cap') in ['physics', 'wits', 'charm']:
		var tres = variables.basestat_cap
		if bonuses.has(stat + '_add'): tres += bonuses[stat + '_add']
		if bonuses.has(stat + '_mul'): tres *= bonuses[stat + '_mul']
		return tres
	if stat.ends_with('_bonus'):
		var tres = statlist[stat]
		tres += min(statlist.growth_factor - 1, parent.get_ref().get_prof_number()) * 5
		return tres
	if stat in ['matk', 'atk']:
		var tres = statlist[stat]
		if bonuses.has(stat + '_add'): tres += bonuses[stat + '_add']
		tres += min(statlist.growth_factor - 1, parent.get_ref().get_prof_number()) * 3
		if bonuses.has(stat + '_mul'): tres *= bonuses[stat + '_mul']
		return max(5.0, tres)
	if stat in ['armor', 'mdef']:
		var tres = statlist[stat]
		tres += min(statlist.growth_factor - 1, parent.get_ref().get_prof_number()) * 2
		return tres
	if stat in ['speed', 'hitrate', 'evasion']:
		var tres = statlist[stat]
		tres += min(statlist.growth_factor - 1, parent.get_ref().get_prof_number()) * 4
		return tres
	if stat in ['productivity']:
		var tres = statlist[stat]
		tres += min(statlist.growth_factor - 1, parent.get_ref().get_prof_number()) * 5
		return tres
	if stat == 'lustmax':
		var tres = 25 + statlist.sexuals_factor * 25
		if check_trait('frigid'):
			tres /= 2
		return tres
	if stat == 'lust':
		var tres = clamp(statlist.lust, 0, custom_stats_get('lustmax'))
		statlist.lust = tres
		return tres
	if stat == 'obedience_drain':
		var tres = variables.basic_obed_drain - statlist.timid_factor
		if bonuses.has('obedience_drain_add'): tres += bonuses.obedience_drain_add
		if bonuses.has('obedience_drain_mul'): tres *= bonuses.obedience_drain_mul
		if ResourceScripts.game_globals.difficulty == 'easy':
			tres *= 0.75
		if ResourceScripts.game_globals.difficulty == 'hard':
			tres *= 1.25
		tres = max(0.0, tres)
		if parent and (parent.get_ref().has_status('soulbind') or parent.get_ref().get_work() == 'travel'):
			tres = 0.0
		return tres
	if stat == 'loyalty_gain':
		var tres = 0.75 + 0.375 * statlist.tame_factor
		if bonuses.has('loyalty_gain_add'): tres += bonuses.loyalty_gain_add
		if bonuses.has('loyalty_gain_mul'): tres *= bonuses.loyalty_gain_mul
		tres = max(0.0, tres)
		if parent and parent.get_ref().has_status('starvation'):
			tres = 0.0
		return tres
	if stat == 'resists':
		var tres = statlist.resists.duplicate()
		for r in variables.resists_list:
			if !tres.has(r): tres[r] = 0.0
			if bonuses.has('resist_' + r + '_add'): tres[r] += bonuses['resist_' + r + '_add']
			if bonuses.has('resist_' + r + '_mul'): tres[r] *= bonuses['resist_' + r + '_mul']
		return tres
	if stat == 'resist_damage':
		var tres = statlist.resist_damage.duplicate()
		for r in variables.resists_damage_list:
			if !tres.has(r): tres[r] = 0.0
			if bonuses.has('resist_' + r + '_add'): tres[r] += bonuses['resist_' + r + '_add']
			if bonuses.has('resist_' + r + '_mul'): tres[r] *= bonuses['resist_' + r + '_mul']
			if bonuses.has('resist_damage_' + r + '_add'): tres[r] += bonuses['resist_damage_' + r + '_add']
			if bonuses.has('resist_damage_' + r + '_mul'): tres[r] *= bonuses['resist_damage_' + r + '_mul']
		return tres
	if stat == 'status_resists':
		var tres = statlist.status_resists.duplicate()
		for r in variables.status_list:
			if !tres.has(r): tres[r] = 0.0
			if bonuses.has('resist_' + r + '_add'): tres[r] += bonuses['resist_' + r + '_add']
			if bonuses.has('resist_' + r + '_mul'): tres[r] *= bonuses['resist_' + r + '_mul']
			if bonuses.has('resist_status_' + r + '_add'): tres[r] += bonuses['resist_status_' + r + '_add']
			if bonuses.has('resist_status_' + r + '_mul'): tres[r] *= bonuses['resist_status_' + r + '_mul']
		return tres
	if stat == 'damage_mods':
		var tres = statlist.damage_mods.duplicate()
		for r in variables.damage_mods_list:
			if !tres.has(r): tres[r] = 1.0
			if bonuses.has('damage_mod_' + r + '_add'): tres[r] += bonuses['damage_mod_' + r + '_add']
			if bonuses.has('damage_mod_' + r + '_mul'): tres[r] *= bonuses['damage_mod_' + r + '_mul']
		return tres
	return statlist[stat]


func get_obed_percent_value():
	return int(100 * get_stat('obedience') / get_stat('obedience_max'))


func predict_obed_time(): # in hours, not in ticks
	if check_infinite_obedience() == true: return 10000
	return get_stat('obedience') / get_stat('obedience_drain')


func check_infinite_obedience():
	return get_stat('obedience_drain') == 0 or parent.get_ref().is_master() or parent.get_ref().is_spouse()


func predict_preg_time():
	if statlist.pregnancy.duration > 0 && statlist.pregnancy.baby != null:
		return statlist.pregnancy.duration
	else: 
		return null


func get_short_name():
	var text = ''
	if statlist.nickname == '':
		text = tr(statlist.name)
	else:
		text = statlist.nickname
	return text

func get_full_name():
	var text = ''
	if statlist.nickname == '':
		text = tr(statlist.name)
	else:
		text = tr(statlist.name) + ' "' + statlist.nickname + '"'
	if statlist.surname != '':
		text += " " + statlist.surname
	return tr(text)

func set_stat(statname, value): #for direct access only
#	 self.statlist[stat] = value
	custom_stats_set(statname, value)

#compat getter - stub
func get_hairs_data():
	var res = {
		hair_base = 'dopple', 
		hair_fringe = 'dopple', 
		hair_assist = 'bun', 
		hair_back = 'very_long', 
		hair_base_color_1 = 'blue_2', 
		hair_fringe_color_1 = 'blue_2', 
		hair_back_color_1 = 'blue_2', 
		hair_assist_color_1 = 'blue_2', 
		hair_base_color_2 = 'blue_2', 
		hair_fringe_color_2 = 'blue_2', 
		hair_back_color_2 = 'blue_2', 
		hair_assist_color_2 = 'blue_2', 
		hair_base_lenght = 'long', 
		hair_fringe_lenght = 'long', 
		hair_back_lenght = 'long', 
		hair_assist_lenght = 'long',
	}
	match statlist.hair_color:
		'blond':
			res.hair_back_color_1 = 'yellow_2'
			res.hair_back_color_2 = 'yellow_1'
			res.hair_assist_color_1 = 'yellow_2'
			res.hair_assist_color_2 = 'yellow_1'
			res.hair_base_color_1 = 'yellow_2'
			res.hair_base_color_2 = 'yellow_1'
		'green':
			res.hair_back_color_1 = 'green_2'
			res.hair_back_color_2 = 'green_1'
			res.hair_assist_color_1 = 'green_2'
			res.hair_assist_color_2 = 'green_1'
			res.hair_base_color_1 = 'green_2'
			res.hair_base_color_2 = 'green_1'
		'brown':
			res.hair_back_color_1 = 'brown_2'
			res.hair_back_color_2 = 'brown_3'
			res.hair_assist_color_1 = 'brown_2'
			res.hair_assist_color_2 = 'brown_3'
			res.hair_base_color_1 = 'brown_2'
			res.hair_base_color_2 = 'brown_3'
		'white':
			res.hair_back_color_1 = 'white_2'
			res.hair_back_color_2 = 'white_1'
			res.hair_assist_color_1 = 'white_2'
			res.hair_assist_color_2 = 'white_1'
			res.hair_base_color_1 = 'white_2'
			res.hair_base_color_2 = 'white_1'
		'red':
			res.hair_back_color_1 = 'red_3'
			res.hair_back_color_2 = 'red_2'
			res.hair_assist_color_1 = 'red_3'
			res.hair_assist_color_2 = 'red_2'
			res.hair_base_color_1 = 'red_3'
			res.hair_base_color_2 = 'red_2'
		'orange':
			res.hair_back_color_2 = 'orange_1'
			res.hair_back_color_1 = 'orange_2'
			res.hair_assist_color_2 = 'orange_1'
			res.hair_assist_color_1 = 'orange_2'
			res.hair_base_color_2 = 'orange_1'
			res.hair_base_color_1 = 'orange_2'
		'auburn':
			res.hair_back_color_1 = 'orange_3'
			res.hair_back_color_2 = 'brown_2'
			res.hair_assist_color_1 = 'orange_3'
			res.hair_assist_color_2 = 'brown_2'
			res.hair_base_color_1 = 'orange_3'
			res.hair_base_color_2 = 'brown_2'
		'black':
			res.hair_back_color_1 = 'dark_3'
			res.hair_back_color_2 = 'dark_3'
			res.hair_assist_color_1 = 'dark_3'
			res.hair_assist_color_2 = 'dark_3'
			res.hair_base_color_1 = 'dark_3'
			res.hair_base_color_2 = 'dark_3'
		'purple':
			res.hair_back_color_1 = 'purple_2'
			res.hair_back_color_2 = 'purple_3'
			res.hair_assist_color_1 = 'purple_2'
			res.hair_assist_color_2 = 'purple_3'
			res.hair_base_color_1 = 'purple_2'
			res.hair_base_color_2 = 'purple_3'
		'green':
			res.hair_back_color_1 = 'green_3'
			res.hair_back_color_2 = 'green_1'
			res.hair_assist_color_1 = 'green_3'
			res.hair_assist_color_2 = 'green_1'
			res.hair_base_color_1 = 'green_3'
			res.hair_base_color_2 = 'green_1'
		'gradient':
			res.hair_back_color_1 = 'red_1'
			res.hair_back_color_2 = 'green_2'
			res.hair_assist_color_1 = 'red_2'
			res.hair_assist_color_2 = 'blue_3'
			res.hair_base_color_1 = 'red_3'
			res.hair_base_color_2 = 'purple_1'
		_:
			res.hair_back_color_1 = 'blue_1'
			res.hair_back_color_2 = 'blue_1'
			res.hair_assist_color_1 = 'blue_1'
			res.hair_assist_color_2 = 'blue_1'
			res.hair_base_color_1 = 'blue_1'
			res.hair_base_color_2 = 'blue_1'
	if statlist.hair_length == 'bald':
		res.hair_base_lenght = 'bald'
		res.hair_assist = ''
		res.hair_back = ''
	else:
		match statlist.hair_style:
			'straight':
				match statlist.hair_length:
					'ear':
						res.hair_base = 'undercut'
						res.hair_assist = 'no'
						res.hair_back = 'care'
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
					'neck':
						res.hair_base = 'dopple'
						res.hair_assist = 'no'
						res.hair_back = 'straight'
						res.hair_base_lenght = 'middle'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
					'shoulder':
						res.hair_base = 'default'
						res.hair_assist = 'no'
						res.hair_back = 'straight'
						res.hair_base_lenght = 'middle'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
					'waist':
						res.hair_base = 'default'
						res.hair_assist = 'no'
						res.hair_back = 'straight'
						res.hair_base_lenght = 'long'
						res.hair_assist_lenght = 'middle'
						res.hair_back_lenght = 'middle'
					'hips':
						res.hair_base = 'straight'
						res.hair_assist = 'no'
						res.hair_back = 'very_long'
						res.hair_base_lenght = 'long'
						res.hair_assist_lenght = 'long'
						res.hair_back_lenght = 'long'
					_:
						res.hair_base = 'undercut'
						res.hair_assist = 'no'
						res.hair_back = 'no'
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
			'ponytail':
				res.hair_base = 'back'
				match statlist.hair_length:
					'ear':
						res.hair_assist = 'ponytail'
						res.hair_back = 'no'
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
					'neck':
						res.hair_assist = 'ponytail'
						res.hair_back = 'no'
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
					'shoulder':
						res.hair_assist = 'ponytail'
						res.hair_back = 'no'
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
					'waist':
						res.hair_assist = 'ponytail'
						res.hair_back = 'no'
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'middle'
						res.hair_back_lenght = 'middle'
					'hips':
						res.hair_assist = 'ponytail'
						res.hair_back = 'no'
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'long'
						res.hair_back_lenght = 'long'
					_:
						res.hair_assist = 'no'
						res.hair_back = 'no'
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
			'pigtails':
				res.hair_base = 'lamb'
				res.hair_assist = 'pigtails'
				res.hair_back = 'no'
				match statlist.hair_length:
					'ear':
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
					'neck':
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
					'shoulder':
						res.hair_base_lenght = 'middle'
						res.hair_assist_lenght = 'middle'
						res.hair_back_lenght = 'middle'
					'waist':
						res.hair_base_lenght = 'long'
						res.hair_assist_lenght = 'long'
						res.hair_back_lenght = 'long'
					'hips':
						res.hair_base_lenght = 'long'
						res.hair_assist_lenght = 'long'
						res.hair_back_lenght = 'long'
					_:
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
			'braid':
				res.hair_base = 'back'
				res.hair_assist = 'braid'
				res.hair_back = 'no'
				match statlist.hair_length:
					'ear':
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
					'neck':
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
					'shoulder':
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'middle'
						res.hair_back_lenght = 'middle'
					'waist':
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'long'
						res.hair_back_lenght = 'long'
					'hips':
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'long'
						res.hair_back_lenght = 'long'
					_:
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
			'twinbraids':
				res.hair_base = 'braids'
				res.hair_assist = 'no'
				res.hair_back = 'twin_braids'
				match statlist.hair_length:
					'ear':
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
					'neck':
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
					'shoulder':
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'middle'
						res.hair_back_lenght = 'middle'
					'waist':
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'long'
						res.hair_back_lenght = 'long'
					'hips':
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'long'
						res.hair_back_lenght = 'long'
					_:
						res.hair_base_lenght = 'short'
						res.hair_assist_lenght = 'short'
						res.hair_back_lenght = 'short'
			'bun':
				res.hair_base = 'back'
				res.hair_assist = 'bun'
				res.hair_back = 'no'
				res.hair_base_lenght = 'short'
				res.hair_assist_lenght = 'short'
				res.hair_back_lenght = 'short'
	res.hair_fringe = res.hair_base #temp, 2fix
	res.hair_fringe_lenght = res.hair_base_lenght #possibly 2fix
	res.hair_fringe_color_1 = res.hair_base_color_1 #keep this
	res.hair_fringe_color_2 = res.hair_base_color_2 #keep this
	return res


func set_hairs(): #temporal solution
	var data = get_hairs_data()
	for stat in data:
		statlist[stat] = data[stat]


#bonus system
func get_stat(statname, ref = false):
	if statname in ['nose', 'chin']: #possibly temporal
		if statlist.race.begins_with('Beastkin'):
			return 'beastkin'
	if statname == 'hair_facial_color':
		if statlist[statname] != "":
			return statlist[statname]
		else:
			return get_stat('hair_base_color_1')
	if statname.begins_with('hair_'): #compart actions, null values should not be returned
		if statlist[statname] != "":
			return statlist[statname]
		else:
			return get_hairs_data()[statname]
	if statname.begins_with('armor_color_'):
		var partname = statname.trim_prefix('armor_color_')
		statname = 'armor_color'
		var part = parent.get_ref().get_stat('armor_' + partname)
		if part != null:
			part = part.trim_prefix('legs_').trim_prefix('chest_')
		if statlist[statname] is Dictionary and statlist[statname].has(part):
			return statlist[statname][part]
		if statlist[statname] is String and statlist[statname] != "":
			return statlist[statname]
		return 'default'
	if statname.begins_with('body_color'): #compart actions, null values should not be returned
		match statname:
			'body_color_skin':
				if statlist[statname] != "":
					return statlist[statname]
				match statlist.skin: #feel free to change values
					'pale':
						return 'human1'
					'grey':
						return 'grey2'
					'fair':
						return 'human3'
					'olive':
						return 'human4'
					'tan':
						return 'human4'
					'brown':
						return 'human5'
					'dark':
						return 'human5'
					'slime':
						return 'green1'
					'blue':
						return 'blue3'
					'paleblue':
						return 'blue1'
					'green':
						return 'green3'
					'red':
						return 'red3'
					'purple':
						return 'purple3'
					'teal':
						return 'blue2'
					_:
						return 'human2'
			'body_color_horns':
				if statlist[statname] != "":
					return statlist[statname]
				return 'yellow3' #any can go, feel free to add stat matching
			'body_color_wings':
				if statlist[statname] is Dictionary and statlist[statname].has(statlist.wings):
					return statlist[statname][statlist.wings]
				if statlist[statname] is String and statlist[statname] != "":
					return statlist[statname]
				match statlist.wings: #feel free to change values and stat
					'':
						return 'pink1'
					'feathered_black':
						return 'dark2'
					'seraph':
						return 'white1'
					'feathered_brown':
						return 'dark1'
					'fairy':
						return 'blue1'
					'demon':
						return 'red3'
					'dragon':
						return 'yellow3'
					'leather_black':
						return 'dark3'
					'leather_red':
						return 'red1'
					_:
						return 'pink1'
			'body_color_ears':
				match statlist.ears: 
					'cat', 'fox', 'tanuki', 'wolf', 'mouse', 'bunny', 'bunny_standing', 'bunny_dropping':
						var res = get_hairs_data().hair_base_color_1
						if statlist.hair_base_color_1 != "":
							res = statlist.hair_base_color_1
						res = res.replace('_', '')
						if statlist.skin_coverage.begins_with('fur'):
							match statlist.skin_coverage:
								'fur_orange':
									return 'orange3'
								'fur_orange_white':
									return 'orange2'
								'fur_striped':
									return 'orange3'
								'fur_white':
									return 'white2'
								'fur_grey':
									return 'white3'
								'fur_brown':
									return 'brown3'
								'fur_black':
									return 'dark3'
						return res
					'nereid': 
						return 'blue1'
					_: 
						return 'yellow2'
			'body_color_tail':
				if statlist[statname] != "":
					return statlist[statname]
				match statlist.tail: 
					'cat', 'fox', 'tanuki', 'wolf':
						var res = get_hairs_data().hair_base_color_1
						res = res.replace('_', '')
						if statlist.skin_coverage.begins_with('fur'):
							match statlist.skin_coverage:
								'fur_orange':
									return 'orange3'
								'fur_orange_white':
									return 'orange2'
								'fur_striped':
									return 'orange3'
								'fur_white':
									return 'white2'
								'fur_grey':
									return 'white3'
								'fur_brown':
									return 'brown3'
								'fur_black':
									return 'dark3'
						return res
					'demon':
						return 'dark2'
					'dragon':
						return 'red2'
					'mouse':
						return 'white2'
					'kobold':
						return 'green2'
					'nereid':
						return 'blue2'
					_: 
						return 'yellow2'
			'body_color_animal':
				if statlist[statname] != "":
					return statlist[statname]
				match statlist.body_lower: #feel free to change values and stat
					'horse':
						return 'red3'
					'avian':
						return 'blue1'
					'snake':
						return 'green2'
					'spider':
						return 'pink3'
					'tentacle':
						return 'purple3'
					'avian':
						return 'blue3'
					_:
						return 'white2'
	if statname.begins_with('sex_skills_'):
		var tmp = statlist.sex_skills
		var stat = statname.trim_prefix('sex_skills_')
		if tmp.has(stat):
			tmp[stat] = min(tmp[stat], 100.0)
			return tmp[stat]
		else:
			print("no stat - %s" % statname)
			return null
	if statname.begins_with('metrics_'):
		var tmp = statlist.metrics
		var stat = statname.trim_prefix('metrics_')
		if tmp.has(stat):
			return tmp[stat]
		else:
			print("no stat - %s" % statname)
			return null
	if statname == 'personality':
		return get_personality()
	if !statlist.has(statname): 
		print("no stat - %s" % statname)
		return null
	var res
	if ref: res = statlist[statname]
	else:  res = custom_stats_get(statname)
	if statdata.statdata.has(statname) and !statdata.statdata[statname].custom_get: #variables.bonuses_stat_list.has(statname):
		if bonuses.has(statname + '_add'): res += bonuses[statname + '_add']
		if bonuses.has(statname + '_mul'): res *= bonuses[statname + '_mul']
	elif statname in ['physics','wits','charm','sexuals']:
		res += get_stat(statname + '_bonus')
	if statname.ends_with('_factor'):
		res = int(res)
	return res


func get_stat_nobonus(statname, ref = false):
	if !statlist.has(statname): return null
	var res
	if ref: res = statlist[statname]
	else:  res = custom_stats_get(statname)
	return res


func add_stat_bonuses(ls:Dictionary):
	if variables.new_stat_bonuses_syntax:
		for rec in ls:
			add_bonus(rec, ls[rec])
	else:
		for rec in ls:
			if (rec as String).ends_with('mod') && !(rec in ['critmod', 'exp_gain_mod']) :
				add_bonus(rec.replace('mod','_mul'), ls[rec])
				continue
			if !statdata.statdata.has(rec):
				print('debug warning - lost stat %s' % rec)
				continue
			if statdata.statdata[rec].skip_process : continue
			match statdata.statdata[rec].default_bonus:
				'add': add_stat(rec, ls[rec])
				'mul':
#					print('debug warning + %s' % parent.get_ref().id)
					mul_stat(rec, ls[rec])
				'add_part':
#					print('debug warning + %s' % parent.get_ref().id)
					add_part_stat(rec, ls[rec])
#			if (rec as String).begins_with('resist') or (rec as String).begins_with('damage_mod'):
#				add_bonus(rec + '_add', ls[rec])
#				continue

#			if !statlist.has(rec):
			#safe variant
			#add_bonus(rec, ls[rec])
#				continue
#			add_stat(rec, ls[rec])

func remove_stat_bonuses(ls:Dictionary):
	if variables.new_stat_bonuses_syntax:
		for rec in ls:
			add_bonus(rec, ls[rec], true)
	else:
		for rec in ls:
			if (rec as String).ends_with('mod') && !(rec in ['critmod', 'exp_gain_mod']) :
				add_bonus(rec.replace('mod','_mul'), ls[rec], true)
				continue
			if !statdata.statdata.has(rec):
				print('debug warning - lost stat %s' % rec)
				continue
			if statdata.statdata[rec].skip_process : continue
			match statdata.statdata[rec].default_bonus:
				'add': add_stat(rec, ls[rec], true)
				'mul':
#					print('debug warning - %s' % parent.get_ref().id)
					mul_stat(rec, ls[rec], true)
				'add_part':
#					print('debug warning - %s' % parent.get_ref().id)
					add_part_stat(rec, ls[rec], true)
#			if (rec as String).begins_with('resist') or (rec as String).begins_with('damage_mod'):
#				add_bonus(rec + '_add', ls[rec], true)
#				continue
#			if (rec as String).ends_with('mod') && rec as String != 'critmod' :
#				add_bonus(rec.replace('mod','_mul'), ls[rec], true)
#				continue
#			if !statlist.has(rec): continue
#			add_stat(rec, ls[rec], true)

func add_bonus(b_rec:String, value, revert = false):
	if value == 0: return
	if bonuses.has(b_rec):
		if revert:
			bonuses[b_rec] -= value
			if b_rec.ends_with('_add') and bonuses[b_rec] == 0.0: bonuses.erase(b_rec)
			if b_rec.ends_with('_mul') and bonuses[b_rec] == 1.0: bonuses.erase(b_rec)
		else: bonuses[b_rec] += value
	else:
		if revert:
			print('warning bonus not found %s' % b_rec)
			if b_rec.ends_with('_mul'): bonuses[b_rec] = 1.0 - value
			else: bonuses[b_rec] = -value
		else:
			#if b_rec.ends_with('_add'): bonuses[b_rec] = value
			if b_rec.ends_with('_mul'): bonuses[b_rec] = 1.0 + value
			else: bonuses[b_rec] = value
#	parent.get_ref().recheck_effect_tag('recheck_stats')


func get_stat_gain_rate(statname):
	var res = 1
	if statlist[statname] >= 90: res = 0.25
	elif statlist[statname] >= 60: res = 0.5
	elif statlist[statname] >= 40: res = 0.75
	
	if statname in ['physics', 'wits', 'charm']:
		res *= variables.basestats_factor_mod[int(statlist[statname + '_factor'])]
	return res


func add_stat(statname, value, revert = false):
	if statname == 'sex_skills': #force custom direct access due to passing into interaction via link
		for ss in statlist.sex_skills:
			if revert: statlist.sex_skills[ss] -= value
			else: statlist.sex_skills[ss] += value
		return
	if statname.begins_with('sex_skills_'):
		statname = statname.trim_prefix('sex_skills_')
		if revert: statlist.sex_skills[statname] -= value
		else: statlist.sex_skills[statname] += value
		statlist.sex_skills[statname] = min(statlist.sex_skills[statname], 100.0)
		return
	if statname.begins_with('metrics_'):
		var tmp = statlist.metrics
		var stat = statname.trim_prefix('metrics_')
		if tmp.has(stat):
			if revert: tmp[stat] -= value
			else: tmp[stat] += value
		else:
			print("no stat - %s" % statname)
		return
	if statname in ['physics', 'wits', 'charm'] and value > 0:
		value *= get_stat_gain_rate(statname)
	if statname.ends_with('_direct'):
		statname = statname.trim_suffix('_direct')
	if !statdata.statdata.has(statname): 
		print("no stat - %s" % statname)
		return
	if statdata.statdata[statname].direct:
		if revert:
			custom_stats_set(statname, statlist[statname] - value)
#			self.statlist[statname] = statlist[statname] - value
		else:
			custom_stats_set(statname, statlist[statname] + value)
#			self.statlist[statname] = statlist[statname] + value
	else:
		add_bonus(statname+'_add', value, revert)

func mul_stat(statname, value, revert = false):
	if !statdata.statdata.has(statname): 
		print("no stat - %s" % statname)
		return
	if statdata.statdata[statname].direct:
		if revert:
			custom_stats_set(statname, statlist[statname] / value)
#			self.statlist[statname] = statlist[statname] / value
		else:
			custom_stats_set(statname, statlist[statname] * value)
#			self.statlist[statname] = statlist[statname] * value
	else:
		if bonuses.has(statname + '_mul'):
			if revert:
				bonuses[statname + '_mul'] /= value
				if bonuses[statname + '_mul'] == 1:
					bonuses.erase(statname + '_mul')
			else: bonuses[statname + '_mul'] *= value
		else:
			if revert: 
				print('warning bonus not found %s' % statname)
				bonuses[statname + '_mul'] = 1.0 / value
			else: bonuses[statname + '_mul'] = value

func add_part_stat(statname, value, revert = false):
	if !statdata.statdata.has(statname): 
		print("no stat - %s" % statname)
		return
	if statdata.statdata[statname].direct:
		if revert:
			custom_stats_set(statname, statlist[statname] /(1.0 + value))
#			self.statlist[statname] = statlist[statname] /(1.0 + value)
		else:
			custom_stats_set(statname, statlist[statname] * (1.0 + value))
#			self.statlist[statname] = statlist[statname] * (1.0 + value)
	else:
		add_bonus(statname+'_mul', value, revert)


func stat_update(stat, value, is_set = false): #for permanent changes
	var tmp
	if stat.ends_with('Obedience') : tmp = statlist['obedience']
	else: tmp = statlist[stat]
	value = round(value)
	if !is_set: add_stat(stat, value)
	else: set_stat(stat, value)
	if tmp != null:
		if stat.ends_with('Obedience'): tmp = get_stat('obedience') - tmp
		else: tmp = get_stat(stat) - tmp
	else:  tmp = get_stat(stat)
	return tmp

#traits
func add_trait(tr_code):
	if tr_code == null: return
	if traits.has(tr_code): return
	var trait = Traitdata.traits[tr_code]
	traits.push_back(tr_code)
	parent.get_ref().add_stat_bonuses(trait.bonusstats)
	for e in trait.effects:
		var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table[e])
		parent.get_ref().apply_effect(effects_pool.add_effect(eff))
		eff.set_args('trait', tr_code)
	if trait.has('traits'):
		for id in trait.traits: #for free basic_sevitude and others
			add_trait(id)
	if tr_code == 'undead':
		statlist.food_consumption = 0
		statlist.charm -= 100
#		statlist.sexuals -= 50
		statlist.resists['dark'] += 50
		statlist.resists['light'] -= 50
		parent.get_ref().food.food_consumption_rations = false
		if parent.get_ref().get_static_effect_by_code("work_rule_ration") != null:
			parent.get_ref().remove_static_effect_by_code('work_rule_ration')
		if parent.get_ref().get_static_effect_by_code("work_rule_contraceptive") != null:
			parent.get_ref().remove_static_effect_by_code('work_rule_contraceptive')
		parent.get_ref().set_work_rule("ration", false)
		parent.get_ref().set_work_rule("contraceptive", false)
	parent.get_ref().recheck_effect_tag('recheck_trait')


func can_add_trait(tr_code):
	var trait = Traitdata.traits[tr_code]
	if traits.has(tr_code): return false
	if !trait.has('conflicts'): return true
	for tr_conflict in trait.conflicts:
		if traits.has(tr_conflict): return false
	return true


func remove_trait(tr_code):
	var trait = Traitdata.traits[tr_code]
	if !traits.has(tr_code): return
	traits.erase(tr_code)
	parent.get_ref().remove_stat_bonuses(trait.bonusstats)
	var arr = parent.get_ref().find_eff_by_trait(tr_code)
	for e in arr:
		var eff = effects_pool.get_effect_by_id(e)
		eff.remove()
	parent.get_ref().recheck_effect_tag('recheck_trait')


func check_trait(trait):
	return (traits.has(trait) or sex_traits.has(trait) or negative_sex_traits.has(trait))


func remove_negative_sex_trait(code):
	negative_sex_traits.erase(code)


func add_sex_trait(code, known = false):
	if parent.get_ref().has_status("no_sex_traits"): 
		return
	var trait = Traitdata.sex_traits[code]
	if trait.negative == true:
		negative_sex_traits[code] = known
	else:
		if !unlocked_sex_traits.has(code):
			unlocked_sex_traits.push_back(code)
		if !sex_traits.has(code):
			sex_traits[code] = known
			if parent.get_ref().is_players_character:
				var text = get_short_name() + ": " + "New Sexual Trait Acquired - " + Traitdata.sex_traits[code].name
				globals.text_log_add('char', text)


func remove_sex_trait(code, absolute = true):
	if absolute: unlocked_sex_traits.erase(code)
	sex_traits.erase(code)


func unlock_sex_trait(code):
	if parent.get_ref().has_status("no_sex_traits"): 
		return
	unlocked_sex_traits.push_back(code)


func create_s_trait_select(trait_id):
#	if sex_traits.has(trait_id):
#		sex_traits.erase(trait_id)
#		unlocked_sex_traits.erase(trait_id)
#	else:
	sex_traits.clear()
	unlocked_sex_traits.clear()
	sex_traits[trait_id] = true
	unlocked_sex_traits.push_back(trait_id)

func add_rare_trait():
	var n = 1
	if globals.rng.randf() < variables.enemy_doublerarechance:
		n = 2
	var list = variables.rare_enemy_traits.duplicate()
	for i in range(n):
		var trait = list[globals.rng.randi_range(0, list.size() - 1)]
		list.erase(trait)
		add_trait(trait)


func has_status(status):
	for tr in traits:
		var traitdata = Traitdata.traits[tr]
		if traitdata.has('tags') and traitdata.tags.has(status):
			return true
	for tr in sex_traits:
		var traitdata = Traitdata.sex_traits[tr]
		if traitdata.has('tags') and traitdata.tags.has(status):
			return true
	for tr in negative_sex_traits:
		var traitdata = Traitdata.sex_traits[tr]
		if traitdata.has('tags') and traitdata.tags.has(status):
			return true
	return false


func get_traits_by_tag(tag):
	var res = []
	for tr in traits:
		var traitdata = Traitdata.traits[tr]
		if traitdata.has('tags') and traitdata.tags.has(tag):
			res.push_back(tr)
	return res


func get_traits_by_arg(arg, value):
	var res = []
	for tr in traits:
		var traitdata = Traitdata.traits[tr]
		if traitdata.has(arg) and traitdata[arg] == value:
			res.push_back(tr)
	return res


func get_random_trait_tag(tag, trait_blacklist = []):
	var buf = {}
	for tr in Traitdata.traits:
		if !can_add_trait(tr): continue
		if trait_blacklist.has(tr): continue
		var data = Traitdata.traits[tr]
		if !data.has('tags'): continue
		if !data.tags.has(tag): continue
		if !data.has('weight'): continue # or not
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


func get_stat_data():
	var res = {}
	res['skill_stat'] = 'physics'
	res['spell_stat'] = 'wits'
	res['skill_atk'] = 'atk'
	res['spell_atk'] = 'matk'
	#to add trait checks
	return res

#AI-related stuff
func need_heal(): #stub. borderlines are subject to tuning
	if parent.get_ref().has_status('banish'): return -1.0
	var rate = parent.get_ref().hp * 1.0 / self.statlist.hpmax
	if rate < 0.2: return 1.0
	if rate < 0.4: return 0.5
	if rate < 0.6: return 0.0
	if rate < 0.8: return -0.5
	return -1.0

#generating char stuff
func fill_masternoun():
	if parent.get_ref().has_profession('master'):
		if statlist.sex == 'male':
			statlist.masternoun = tr('PROFMASTER').to_lower()
		else:
			statlist.masternoun = tr('PROFMASTERALT').to_lower()
	elif ResourceScripts.game_party.get_master().get_stat('sex') == 'male':
		statlist.masternoun = tr('PROFMASTER').to_lower()
	else:
		statlist.masternoun = tr('PROFMASTERALT').to_lower()

func process_chardata(chardata, unique = false):
	if unique: statlist.unique = chardata.code
	for i in chardata:
		if !(i in ['code','class_category', 'slave_class', 'tags','sex_traits', 'sex_skills', 'personality']):
			if typeof(chardata[i]) == TYPE_ARRAY or typeof(chardata[i]) == TYPE_DICTIONARY:
				statlist[i] = chardata[i].duplicate(true)
			else:
				statlist[i] = chardata[i]
	if chardata.has('slave_class'): set_slave_category(chardata.slave_class)
	if chardata.has("sex_traits"):
		for i in chardata.sex_traits:
			add_sex_trait(i)
	if chardata.has("traits"):
		for i in chardata.traits:
			add_trait(i)
	if chardata.has("sex_skills"):
		for skill in chardata.sex_skills:
			statlist.sex_skills[skill] = chardata.sex_skills[skill]
	if chardata.has('icon_image'):
		statlist.dynamic_portrait = false
	if chardata.has('personality'):
		match chardata.personality:
			'bold':
				statlist.personality_bold = globals.rng.randi_range(30, 60)
				statlist.personality_kind = globals.rng.randi_range(-10, 10)
			'shy':
				statlist.personality_bold = -globals.rng.randi_range(30, 60)
				statlist.personality_kind = globals.rng.randi_range(-10, 10)
			'kind':
				statlist.personality_bold = globals.rng.randi_range(-10, 10)
				statlist.personality_kind = globals.rng.randi_range(30, 60)
			'serious':
				statlist.personality_bold = globals.rng.randi_range(-10, 10)
				statlist.personality_kind = -globals.rng.randi_range(30, 60)
	set_virginity_data()


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
	set_stat('growth_factor', tmp)


func generate_random_character_from_data(races, desired_class = null, adjust_difficulty = 0, trait_blacklist = []):
	adjust_difficulty = min(adjust_difficulty, 15)
	var gendata = {race = '', sex = 'random', age = 'random'}

	if typeof(races) == TYPE_STRING && races == 'random':
		gendata.race = get_random_race()
	elif typeof(races) == TYPE_STRING:
		gendata.race = races
	else:
		gendata.race = races[randi()%races.size()]
	#figuring out the race

	parent.get_ref().create(gendata.race, gendata.sex, gendata.age)
	
#	set_stat('growth_factor', input_handler.weightedrandom_dict(variables.growth_factor))
	roll_growth(adjust_difficulty)
	
#	if randf() <= 0.003:
#		desired_class = parent.get_ref().generate_ea_character(gendata, desired_class)
	var slaveclass = desired_class
	if slaveclass == null:
		slaveclass = input_handler.weightedrandom([['combat', 1],['magic', 1],['social', 1],['sexual',1], ['labor',1]])

	if slaveclass == 'magic' && statlist.magic_factor == 1: #prevents finding no class as there's no magic base classes which allow magic factor < 2
		statlist.magic_factor = 2

	var difficulty = int(round(adjust_difficulty))
	var classcounter = round(rand_range(variables.slave_classes_per_difficulty[difficulty][0], variables.slave_classes_per_difficulty[difficulty][1]))

	#Add extra stats for harder characters
	var bonus_counter = 0
	while difficulty > 1 && bonus_counter < 10:
		var array = []
		array = ['physics_factor', 'magic_factor', 'wits_factor', 'timid_factor', 'tame_factor', 'sexuals_factor', 'charm_factor']
		array = array[randi()%array.size()]
		if randf() >= 0.3:
			add_stat(array, 1)
		difficulty -= 1
		bonus_counter += 1
	difficulty = adjust_difficulty/3
	while difficulty > -1:
		var array = []
		array = ['physics', 'wits','sexuals', 'charm']
		array = array[randi()%array.size()]
		if randf() >= 0.7:
			if array == 'sexuals':
				add_random_sex_skill()
			else:
				add_stat(array, rand_range(1,15))
		difficulty -= 1

	#assign classes
	while classcounter > 0:
		if randf() > 0.65:
			classcounter -= 1
			continue
		var classarray = []
		if randf() >= 0.85:
			classarray = parent.get_ref().get_class_list('any', parent.get_ref())
		else:
			classarray = parent.get_ref().get_class_list(slaveclass, parent.get_ref())
		if classarray != null && classarray.size() > 0:
			parent.get_ref().unlock_class(classarray[randi()%classarray.size()].code, true)
		classcounter -= 1

	var traitarray = []
	#assign traits
	for i in Traitdata.sex_traits.values():
		if i.negative == true && i.random_generation == true && parent.get_ref().checkreqs(i.acquire_reqs) == true:
			traitarray.append(i)
	var rolls = 2
	while rolls > 0:
		var number = randi()%traitarray.size()
		var newtrait = traitarray[number]
		parent.get_ref().add_sex_trait(newtrait.code)
		traitarray.remove(number)
		rolls -= 1
	traitarray.clear()
	rolls = 1
	for i in Traitdata.sex_traits.values():
		if i.negative == false && i.random_generation == true && parent.get_ref().checkreqs(i.acquire_reqs) == true:
			traitarray.append(i)
	while rolls > 0:
		var number = randi()%traitarray.size()
		var newtrait = traitarray[number]
		parent.get_ref().add_sex_trait(newtrait.code)
		traitarray.remove(number)
		rolls -= 1
	get_random_traits(trait_blacklist)


func generate_simple_fighter(data):
	for i in variables.fighter_stats_list:
		if data.has(i) == false:
			statlist[i] = 0
		else:
			statlist[i] = data[i]
	statlist.icon_image = data.icon
	statlist.body_image = data.body
#	statlist.combat_skills = data.skills
#	if !data.skills.has("ranged_attack"):
#		combat_skills += ['attack']
	parent.get_ref().npc_reference = data.code
	statlist.is_person = false
	statlist.xpreward = data.xpreward
	statlist.loottable = data.loot
	statlist.name = data.name
	statlist.racegroup = data.race
	for i in variables.resists_list:
#		statlist.resists[i] = 0
		if data.resists.has(i):
			statlist.resists[i] = data.resists[i]
	for i in variables.status_list:
#		statlist.status_resists[i] = 0
		if data.has('status_resists') && data.status_resists.has(i):
			statlist.status_resists[i] = data.status_resists[i]
#	for i in variables.mods_list:
#		statlist.damage_mods[i] = 1.0
#	if data.has('effects'):
#		for e in data.effects:
#			var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table[e])
#			apply_effect(effects_pool.add_effect(eff))
	if data.has('traits'):
		for tr in data.traits:
			add_trait(tr)

func setup_baby(mother, father):
	var temp_race
	var race1 = mother.get_stat('race')
	var race2 = father.get_stat('race')
	if randf() >= 0.5:
		temp_race = race1
	else:
		temp_race = race2
	if race2.find('Beastkin') >= 0 && race1.find("Beastkin") < 0:
		temp_race = race2.replace("Beastkin", "Halfkin")
	elif race1.find('Beastkin') >= 0 && race2.find("Beastkin") < 0:
		temp_race = race1.replace("Beastkin", "Halfkin")
	parent.get_ref().create(temp_race, 'random', 'teen')
	for i in variables.inheritedassets:
		if randf() >= 0.5:
			statlist[i] = father.statlist.statlist[i]
		else:
			statlist[i] = mother.statlist.statlist[i]

	for i in variables.inheritedstats:
		if randf() >= 0.5 || mother.has_profession("breeder"):
			statlist[i] = mother.statlist.statlist[i]
		else:
			statlist[i] = father.statlist.statlist[i]
	
	for tr in mother.get_traits_by_tag('positive') + father.get_traits_by_tag('positive'):
		if randf() <= 0.8 or mother.has_profession("breeder") or father.has_profession("breeder"):
			add_trait(tr)
	for tr in mother.get_traits_by_tag('negative') + father.get_traits_by_tag('negative'):
		if mother.has_profession("breeder") or father.has_profession("breeder"):
			if randf() <= 0.1:
				add_trait(tr)
		elif randf() <= 0.5:
			add_trait(tr)
	
	statlist.relatives.mother = mother.id
	statlist.relatives.father = father.id
	baby_transform()
	var pregdata = {}
	pregdata.baby = parent.get_ref().id
	pregdata.duration = variables.pregduration
	mother.set_stat('pregnancy', pregdata.duplicate())
	characters_pool.move_to_baby(parent.get_ref().id)
	ResourceScripts.game_party.connectrelatives(parent.get_ref().id, mother.id, "mother")
	ResourceScripts.game_party.connectrelatives(parent.get_ref().id, father.id, "father")
#	ResourceScripts.game_party.babies[parent.get_ref().id] = parent.get_ref()
#	if mother.get_stat('slave_class') != 'master':
#		statlist.slave_class = mother.get_stat('slave_class')
#	else:
#		statlist.slave_class = 'slave'

func create(temp_race, temp_gender, temp_age):
	if temp_race == 'halfbreeds':
		temp_race = 'halfbeast'
	statlist.race = temp_race
	statlist.sex = temp_gender
	statlist.age = temp_age
	
	if temp_race == 'random':
		statlist.race = get_random_race()
	elif races.race_groups.has(temp_race):
		statlist.race = races.race_groups[temp_race][randi()%races.race_groups[temp_race].size()]
	if temp_gender == 'random':
		statlist.sex = get_random_sex()
	if temp_age == 'random':
		statlist.age = get_random_age()
	
#	for i in variables.resists_list:
#		statlist.resists[i] = 0
#	for i in variables.status_list:
#		statlist.status_resists[i] = 0
#	for i in variables.mods_list:
#		statlist.damage_mods[i] = 1.0
	
	get_sex_features()
	
	if input_handler.globalsettings.furry == false && statlist.race.find("Beastkin") >= 0:
		statlist.race = statlist.race.replace("Beastkin","Halfkin")
	
	get_racial_features()
	get_random_name()
	get_random_colors()
	random_icon()
	
	statlist.personality = input_handler.random_from_array(variables.personality_array)
	match statlist.personality:
		'bold':
			statlist.personality_bold = rand_range(35,95)
			statlist.personality_kind = rand_range(30,-30)
		'shy':
			statlist.personality_bold = rand_range(-35,-95)
			statlist.personality_kind = rand_range(30,-30)
		'kind':
			statlist.personality_bold = rand_range(30,-30)
			statlist.personality_kind = rand_range(35,95)
		'serious':
			statlist.personality_bold = rand_range(-35,-95)
			statlist.personality_kind = rand_range(30,-30)
	
	
	for i in ResourceScripts.descriptions.bodypartsdata:
		if ResourceScripts.descriptions.bodypartsdata[i].has(statlist[i]):
			if ResourceScripts.descriptions.bodypartsdata[i][statlist[i]].bodychanges.size() > 0:
				apply_custom_bodychange(i, statlist[i])
#	add_trait('core_trait')
#	learn_c_skill('attack')
	set_hairs() #temporal, remove this later!!
	
	parent.get_ref().hp = get_stat('hpmax')
	parent.get_ref().mp = get_stat('mpmax')
	
	if input_handler.globalsettings.generate_portraits:
		make_random_portrait()


func get_racial_features():
	var race_template = races.racelist[statlist.race]
	for i in race_template.basestats:
		statlist[i] = round(rand_range(race_template.basestats[i][0], race_template.basestats[i][1])) #1 - terrible, 2 - bad, 3 - average, 4 - good, 5 - great, 6 - superb
	
	add_stat_bonuses(race_template.race_bonus)
	for i in races.racelist.Human.bodyparts:
		if races.racelist.Human.bodyparts[i].empty():
			continue
		if typeof(races.racelist.Human.bodyparts[i][0]) in [TYPE_STRING, TYPE_BOOL, TYPE_INT]:
			statlist[i] = input_handler.random_from_array(races.racelist.Human.bodyparts[i])
		else:
			statlist[i] = input_handler.weightedrandom(races.racelist.Human.bodyparts[i])
	if statlist.race != 'Human':
		for i in race_template.bodyparts:
			if typeof(race_template.bodyparts[i][0]) in [TYPE_STRING, TYPE_BOOL, TYPE_INT]:
				statlist[i] = input_handler.random_from_array(race_template.bodyparts[i])
			else:
				statlist[i] = input_handler.weightedrandom(race_template.bodyparts[i])
	
	if race_template.tags.has("multibreasts") && input_handler.globalsettings.furry_multiple_nipples == true:
		statlist.multiple_tits = variables.furry_multiple_nipples_number
	
	if race_template.has("combat_skills"):
		for i in race_template.combat_skills:
			parent.get_ref().learn_c_skill(i)
	
	parent.get_ref().food.get_racial_features(statlist.race)
	
	var array = []
	if race_template.has('personality'):
		for i in race_template.personality:
			array.append([i, race_template.personality[i]])
		statlist.personality = input_handler.weightedrandom(array)
	
	if race_template.has('tarits'):
		for trait in race_template.traits:
			add_trait(trait)


func get_sex_features():
	match statlist.sex:
		'female':
			if randf()*100 >= variables.female_vagina_virgin_default_chance:
				statlist.vaginal_virgin = false
			if randf()*100 >= variables.female_ass_virgin_default_chance:
				statlist.anal_virgin = false
		'male':
			if randf()*100 >= variables.male_penis_virgin_default_chance:
				statlist.penis_virgin = false
			if randf()*100 >= variables.male_ass_virgin_default_chance:
				statlist.anal_virgin = false
		'futa':

			if randf()*100 >= variables.male_penis_virgin_default_chance:
				statlist.penis_virgin = false
			if randf()*100 >= variables.female_vagina_virgin_default_chance:
				statlist.vaginal_virgin = false
			if randf()*100 >= variables.female_ass_virgin_default_chance:
				statlist.anal_virgin = false

	if statlist.vaginal_virgin == false || statlist.anal_virgin == false:
		statlist.mouth_virgin = false
	
	for i in ['vaginal_virgin', 'anal_virgin', 'mouth_virgin','penis_virgin']:
		if statlist[i] == false:
			statlist.sex_skills[skill_shortcuts[i]] = rand_range(1,10)
	set_virginity_data()


func set_virginity_data():
	for i in ['vaginal_virgin', 'anal_virgin', 'mouth_virgin','penis_virgin']:
		if statlist[i+'_lost'].source == 'master':
			statlist[i+'_lost'].source = ResourceScripts.game_party.get_master().id
			statlist.metrics.partners.append(ResourceScripts.game_party.get_master().id)

func add_random_sex_skill():
	var array = ['petting']
	for i in ['vaginal_virgin', 'anal_virgin', 'mouth_virgin','penis_virgin']:
		if statlist[i] == false:
			array.append(skill_shortcuts[i])

	if get_stat('penis_size') != '':
		array.append('penetration')
	if get_stat('tail') in variables.longtails:
		array.append('tail')

	array = array[randi()%array.size()]
	statlist.sex_skills[array] += rand_range(3,8)

var skill_shortcuts = {
	vaginal_virgin = 'pussy',
	anal_virgin = "anal",
	mouth_virgin = 'oral',
	penis_virgin = 'penetration',
}

func apply_custom_bodychange(target, part):
	statlist[target] = part
	for i in ResourceScripts.descriptions.bodypartsdata[target][part].bodychanges:
		if parent.get_ref().checkreqs(i.reqs) == true:
			var newvalue = i.value
			if typeof(newvalue) == TYPE_ARRAY:
				if typeof(newvalue[0]) == TYPE_ARRAY:
					newvalue = input_handler.weightedrandom(newvalue)
				else:
					newvalue = input_handler.random_from_array(newvalue)
			statlist[i.code] = newvalue

func get_random_race():
	var array = []
	for i in races.racelist.values():
		array.append([i.code, i.global_weight])
	return input_handler.weightedrandom(array)

func get_random_sex():
	if randf()*100 <= input_handler.globalsettings.malechance:
		return 'male'
	elif randf()*100 <= input_handler.globalsettings.futachance && input_handler.globalsettings.futa == true:
		return 'futa'
	else:
		return 'female'

func get_random_age():
	var array = []
	for i in ['teen','adult','mature']:
		array.append([i, variables.get(i+"_age_weight")])
	return input_handler.weightedrandom(array)

func get_random_name(keep_surname = false):
	var text = statlist.race.to_lower() + statlist.sex.replace("futa",'female')
	if !Namedata.namelist.has(text):
		text = 'human'+ statlist.sex.replace("futa",'female')
	statlist.name = Namedata.namelist[text][randi() % Namedata.namelist[text].size()]
	if keep_surname and statlist.surname != '': 
		return
	if Namedata.namelist.has(statlist.race.to_lower() + 'surname'):
		statlist.surname = Namedata.namelist[statlist.race.to_lower() + "surname"][randi() % Namedata.namelist[statlist.race.to_lower() + "surname"].size()]
	elif statlist.race.find("Halfkin") >= 0 || statlist.race.find("Beastkin") >= 0:
		statlist.surname = Namedata.getRandomFurrySurname()

func get_random_colors():
	statlist.armor_color = {}
	for base in Items.armor_colors:
		statlist.armor_color[base] = input_handler.random_from_array(Items.armor_colors[base])

func random_icon():
	var array = []
	var racenames = statlist.race.split(" ")
#commented because runtame error, need not fixing here
#	for i in globals.dir_contents(globals.globalsettings.portrait_folder):
#		for k in racenames:
#			if i.findn(k) >= 0:
#				array.append(i)
#				continue
	if array.size() > 0:
		statlist.icon_image = array[randi()%array.size()]
		statlist.dynamic_portrait = false

func get_icon():
	if statlist.icon_image in ['', null]:
		return null
	if statlist.icon_image is String:
		return input_handler.loadimage(statlist.icon_image, 'portraits')
	else:
		return statlist.icon_image

func get_icon_path():
	if typeof(statlist.icon_image) != TYPE_STRING:
		return null
	if statlist.icon_image in ['', null]:
		return ""
	return statlist.icon_image

func get_stored_body_image(): 
	var tmp 
	if images.sprites.has(statlist.body_image):
		tmp = input_handler.loadimage(images.sprites[statlist.body_image], 'shades')
	else:
		tmp = input_handler.loadimage(statlist.body_image, 'shades')
	return tmp

func get_body_image(): 
	var tmp = get_stored_body_image()
	if tmp != null:
		return tmp
	else:
		var text = statlist.race.to_lower().replace('halfkin','beastkin')
		if statlist.sex == 'male':
			text += "_m"
		else:
			text += "_f"
		if images.shades.has(text):
			return images.shades[text]
		else:
			return null
	return load(statlist.body_image)

func get_all_sex_traits():
	var return_traits = {}
	for i in sex_traits:
		return_traits[i] = sex_traits[i]
	for i in negative_sex_traits:
		return_traits[i] = negative_sex_traits[i]
	return return_traits

func get_negative_sex_traits():
	return negative_sex_traits

func get_unlocked_sex_traits():
	return unlocked_sex_traits

func make_trait_known(trait):
	if sex_traits.has(trait):
		sex_traits[trait] = true
	if negative_sex_traits.has(trait):
		negative_sex_traits[trait] = true


func get_traits_buffs():
	var res = []
	for tr in traits:
		var tbuff = Traitdata.make_buff_for_trait(tr)
		if tbuff != null: res.push_back(tbuff)
	return res


func get_price_for_trait(tr_id):
	var data = Traitdata.traits[tr_id]
	if !data.tags.has('loyalty'): return 0
	var res = 0
	if data.has('l_cost'):
		res = data.l_cost
	res += get_stat('loyalty_traits_unlocked') * 5
	if data.has('bind_trait'):
		for tr in data.bind_trait:
			if check_trait(tr):
				res *= 0.5
				break
	return res

func baby_transform():
	var mother = characters_pool.get_char_by_id(statlist.relatives.mother) #ResourceScripts.game_party.characters[statlist.relatives.mother]
	statlist.name = 'Child of ' + mother.get_short_name()
	statlist.surname = mother.get_stat('surname')
	if statlist.surname != '':
		statlist.name += " " + statlist.surname
	statlist.anal_virgin = true
	statlist.mouth_virgin = true
	statlist.penis_virgin = true
	statlist.vaginal_virgin = true


func set_slave_category(new_class):
	if statlist.slave_class != '':
		remove_trait(statlist.slave_class.to_lower())
	add_trait(new_class)
	statlist.slave_class = new_class


func tick():
	if !parent.get_ref().is_master():
		add_stat('loyalty', get_stat('loyalty_gain'))
		add_stat('loyalty_total', get_stat('loyalty_gain'))
		if !parent.get_ref().is_spouse() && variables.no_obedience_drain == false :
			add_stat('obedience', - get_stat('obedience_drain'))
	add_stat('lust', get_stat('lusttick'))
	if statlist.pregnancy.duration > 0 && statlist.pregnancy.baby != null:
		statlist.pregnancy.duration -= 1
		if statlist.pregnancy.duration * 3 <= variables.pregduration * 2 and !parent.get_ref().has_status('pregnant'):
			if reported_pregnancy == false:
				var text = tr("LOGREPORTPREGNANCY")
				if parent.get_ref().has_profession('master'): text = tr('LOGREPORTPREGNANCYMASTER')
				reported_pregnancy = true
				globals.text_log_add('char', translate(text))
			if !check_trait('breeder'):
				var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table.e_pregnancy)
				parent.get_ref().apply_effect(effects_pool.add_effect(eff))
		if statlist.pregnancy.duration * 3 <= variables.pregduration:
			if check_trait('breeder') and !parent.get_ref().has_status('pregnant') or !check_trait('breeder') and !parent.get_ref().has_status('heavy_pregnant'):
				var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table.e_pregnancy)
				parent.get_ref().apply_effect(effects_pool.add_effect(eff))
			if parent.get_ref().get_stat('lactation') == false && parent.get_ref().get_stat('tits_size') != 'masculine':
				parent.get_ref().set_stat('lactation', true)
		if statlist.pregnancy.duration == 0:
			reported_pregnancy = false
			parent.get_ref().remove_all_temp_effects_tag('pregnant')
			if has_status('keep_baby'):
				input_handler.interactive_message('childbirth', 'childbirth', {pregchar = parent.get_ref()})
			else:
				input_handler.interactive_message('childbirth_alt', 'childbirth', {pregchar = parent.get_ref()})


func is_uncontrollable():
	return statlist.obedience <= 0 && statlist.loyalty < 100


func is_controllable():#not sure - either this or previous is wrong cause of obedience check, nvn, rework both!
	return statlist.loyalty >= 100

var sex_nouns = {male = tr("PRONOUNSEX"), female = tr("PRONOUNSEXF"), futa = tr("PRONOUNSEXH")}

func translate(text):
	var rtext = ''
	text = text.replace("[He]", globals.fastif(statlist.sex == 'male', tr('PRONOUNHE'), tr("PRONOUNHEF"))) # PRONOUNHE = "He", 
	text = text.replace("[he]", globals.fastif(statlist.sex == 'male',  tr('PRONOUNHEL'), tr("PRONOUNHELF")))
	text = text.replace("[his]", globals.fastif(statlist.sex == 'male', tr('PRONOUNHISL'), tr("PRONOUNHISLF")))
	text = text.replace("[him]", globals.fastif(statlist.sex == 'male', tr('PRONOUNHIML'), tr("PRONOUNHIMLF")))
	text = text.replace("[His]", globals.fastif(statlist.sex == 'male', tr('PRONOUNHIS'), tr("PRONOUNHISF")))
	text = text.replace("[Sir]", globals.fastif(statlist.sex == 'male', tr('PRONOUNSIR'), tr("PRONOUNSIRF")))
	text = text.replace("[sir]", globals.fastif(statlist.sex == 'male', tr('PRONOUNSIR'), tr("PRONOUNSIRF")))
	text = text.replace("[mister]", globals.fastif(statlist.sex == 'male', tr('PRONOUNMISTER'), tr("PRONOUNMISTERF")))
	text = text.replace("[son]", globals.fastif(statlist.sex == 'male', tr('PRONOUNSON'), tr("PRONOUNSONF")))
	text = text.replace("[father]", globals.fastif(statlist.sex == 'male', tr('PRONOUNFATHER'), tr("PRONOUNFATHERF")))
	text = text.replace("[brother]", globals.fastif(statlist.sex == 'male', tr('PRONOUNBROTHER'), tr("PRONOUNBROTHERF")))
	text = text.replace("[gentleman]", globals.fastif(statlist.sex == 'male', tr('PRONOUNGENTLEMAN'), tr("PRONOUNGENTLEMANF")))
	text = text.replace("[raceadj]", races.racelist[statlist.race].adjective if statlist.race != "" else "")
	text = text.replace("[race]", races.racelist[statlist.race].name if statlist.race != "" else "")
	text = text.replace("[race_short]",input_handler.random_from_array(races.short_race_names[races.racelist[statlist.race].code]) if statlist.race != "" else "")
	text = text.replace("[name]", get_short_name())
	text = text.replace("[surname]",globals.fastif(statlist.surname != '', statlist.surname, get_short_name()))
	text = text.replace("[age]", statlist.age.capitalize())
	text = text.replace("[male]", sex_nouns[statlist.sex])
	text = text.replace("[eye_color]", statlist.eye_color)
	text = text.replace("[hair_color]", statlist.hair_color)
	text = text.replace("[man]", globals.fastif(statlist.sex == 'male', tr('PRONOUNMAN'), tr("PRONOUNMANF")))
	text = text.replace("[guy]", globals.fastif(statlist.sex == 'male', tr('PRONOUNGUY'), tr("PRONOUNGUYF")))
	text = text.replace("[husband]", globals.fastif(statlist.sex == 'male', tr('PRONOUNHUSBAND'), tr("PRONOUNHUSBANDF")))
	text = text.replace("[groom]", globals.fastif(statlist.sex == 'male', tr('PRONOUNGROOM'), tr("PRONOUNGROOMF")))

#	var masternoun = 'master'
	var tempmasternoun = statlist.masternoun
	if parent.get_ref() != null:
		if tempmasternoun in ['master','mistress']:
			if input_handler.meowingcondition(parent.get_ref()) == true:tempmasternoun = 'myaster'
			if ResourceScripts.game_party.get_master() != null && ResourceScripts.game_party.get_master().get_stat('sex') != 'male':
				if input_handler.meowingcondition(parent.get_ref()) == true:tempmasternoun = 'mewstress'
	else:
		print('error in character %s - no root object' % statlist.name)

	text = text.replace("[master]", tempmasternoun)
	text = text.replace("[Master]", tempmasternoun.capitalize())

	match statlist.sex:
		'male':
			rtext = 'boy'
		'female':
			rtext = 'girl'
		'futa':
			rtext = 'futanari'
	text = text.replace("[boygirlfuta]", rtext)
	text = text.replace("[boy]", globals.fastif(statlist.sex == 'male', 'boy', 'girl'))
	return text

#tatoo functional is here, though it can be moved to separate component
var tattoo = {face = null, neck = null, arms = null, legs = null, chest = null, crotch = null, waist = null, ass = null}


func can_add_tattoo(slot, code):
	if !Traitdata.get_slot_list_for_tat(code).has(slot): return false
	var template = Traitdata.tattoodata[code]
	if tattoo[slot] == code : return false
	if template.has('conditions'):
		if !parent.get_ref().checkreqs(template.conditions): return false
	if ResourceScripts.game_res.if_has_material(template.item, 'lt', 1): return false
	if !template.can_repeat:
		for s in tattoo:
			if tattoo[s] == code: return false
	return true


func add_tattoo(slot, code) -> bool:
	if !can_add_tattoo(slot, code): return false
	var template = Traitdata.tattoodata[code]
	if tattoo[slot] != null: remove_tattoo(slot)
	for slots in template.effects:
		if !slots.has(slot): continue
		for e in template.effects[slots]:
			var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table[e])
			parent.get_ref().apply_effect(effects_pool.add_effect(eff))
			eff.set_args('tattoo', "%s_%s" % [slot, code])
	tattoo[slot] = code
	return true


func remove_tattoo(slot):
	if tattoo[slot] == null: return
	var arr = parent.get_ref().find_eff_by_tattoo(slot, tattoo[slot])
	for e in arr:
		var eff = effects_pool.get_effect_by_id(e)
		eff.remove()
	tattoo[slot] = null


func make_random_portrait():
	statlist.icon_image = ResourceScripts.rnd_main.setrandom(statlist) 
	if statlist != null && statlist.icon_image != null && !statlist.icon_image.empty(): # this if sets the matching body image
		statlist.dynamic_portrait = false
		var fullImagePath = statlist.icon_image.replacen(input_handler.globalsettings.portrait_folder, input_handler.globalsettings.body_folder)
		if File.new().file_exists(fullImagePath):
			statlist.body_image = fullImagePath 


#body upgrades
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
	
	body_upgrades.push_back(upg)
	var upgrade_data = Traitdata.body_upgrades[upg]
	if upgrade_data.has('traits'):
		for tr in upgrade_data.traits:
			add_trait(tr) #hope that there be no concurrent traits in upgrades


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
	if upgrade_data.has('traits'):
		for tr in upgrade_data.traits:
			remove_trait(tr)
	parent.get_ref().recheck_equip()


func recheck_upgrades():
	for upg in body_upgrades.duplicate():
		if !Traitdata.body_upgrades.has(upg):
			body_upgrades.erase(upg)
		else:
			var upgrade_data = Traitdata.body_upgrades[upg]
			if !parent.get_ref().checkreqs(upgrade_data.reqs):
				remove_upgrade(upg) #hope that there would be no removal chaining


func change_personality_stats(stat, init_value):
	var prim_stat
	var primaxis = ''
	var altaxis = ''
	var value = init_value
	
	if stat == 'bold':
		primaxis = 'personality_bold'
		altaxis = 'personality_kind'
		prim_stat = get_stat("timid_factor")
	else:
		primaxis = 'personality_kind'
		altaxis = 'personality_bold'
		prim_stat = get_stat("tame_factor")
	
	var rebel = false
	
#	value = value*1+rand_range(0.2,-0.2)
	value *= 1 + rand_range(0.2,-0.2)
	
	if variables.factor_personality_changes[prim_stat][0] <= randf() * 100: #if character's factor chance is lower than check, then character goes opposite direction on personality grid
		value = -value
		rebel = true
	
	var secondary_axis_change = 0
	if variables.factor_personality_changes[prim_stat][1] >= randf() * 100: #if character's factor chance is lower than check, thne character's secondary axist fluctate
		secondary_axis_change = value / 2.0
		if randf() >= 0.5:
			 secondary_axis_change = -secondary_axis_change
	
	var newvalue = [int(value), int(secondary_axis_change)]
	
	statlist[primaxis] += newvalue[0]
	statlist[altaxis] += newvalue[1]
	parent.get_ref().recheck_effect_tag('recheck_stats')
	return [newvalue, rebel]


func get_personality():
	if abs(statlist.personality_bold) > abs(statlist.personality_kind):
		if statlist.personality_bold > 0:
			return 'bold'
		else:
			return 'shy'
	else:
		if statlist.personality_kind > 0:
			return 'kind'
		else:
			return 'serious'

