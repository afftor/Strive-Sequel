extends Reference
#class_name Slave
# warning-ignore-all:return_value_discarded

var dyn_stats = ResourceScripts.scriptdict.ch_statlist_dynamic.new()
var statlist = ResourceScripts.scriptdict.ch_statlist.new()
var xp_module = ResourceScripts.scriptdict.ch_leveling.new()
var equipment = ResourceScripts.scriptdict.ch_equipment.new()
var skills = ResourceScripts.scriptdict.ch_skills.new()
var travel = ResourceScripts.scriptdict.ch_travel.new()
#var effects = ResourceScripts.scriptdict.ch_effects.new()
var food = ResourceScripts.scriptdict.ch_food.new()
var training = ResourceScripts.scriptdict.ch_training.new()
var displaynode = null
var ai = null

var id
var is_active = true
var is_players_character = false
var is_known_to_player = false #for purpose of private parts
var npc_reference = null
var tags = []
#base combat stats
var hp = 100 setget hp_set, hp_get
var mp = 50 setget mp_set
var shield = 0 setget set_shield
var defeated = false
var combatgroup = ''
var position = 0 # Not sure it's used or not. Make new field just in case
var combat_position = 0 setget, get_combat_positon
var selectedskill = 'attack'

var previous_location
#constant stats

#to delegate!

#debug, 2remove later
var src = ""


func _init(source = null):
	src = source
	rebuild_parents()
	input_handler.connect("fighter_changed", self, 'reset_rebuild')


func get_combat_positon():
	return int(combat_position)

func rebuild_parents():
	statlist.parent = weakref(self)
	dyn_stats.parent = weakref(self)
	xp_module.parent = weakref(self)
	equipment.parent = weakref(self)
	skills.parent = weakref(self)
	travel.parent = weakref(self)
#	effects.parent = weakref(self)
	food.parent = weakref(self)
	training.parent = weakref(self)


#component functions tunneling
func get_timestamp():
	return dyn_stats.get_timestamp()

func reset_rebuild():
#	if (statlist.statlist.unique == 'cali'):
#		print('+')
	dyn_stats.reset_rebuild()
#	dyn_stats.generate_data(variables.DYN_STATS_FULL, true)
	if displaynode != null:
		displaynode.rebuildbuffs()


func setup_etb():
	dyn_stats.setup_etb()


func base_exp_set(value):
	xp_module.base_exp = value


func swap_alternate_exterior():
	statlist.swap_alternate_exterior()


func get_stat_value_data(statname):
	var st_data = statdata.statdata[statname]
	if st_data.direct:
		var res = {
			base_value = statlist.get_stat(statname),
			result = 0,
			bonuses = {},
		}
		res.result = res.base_value
		return res
	else:
		return dyn_stats.get_stat_data(statname)


func get_stat(statname):
	if statname in ['hp', 'mp', 'shield', 'combatgroup']:
		return get(statname)
	if statname.begins_with('mastery_') and !statname.begins_with('mastery_point'):
		return dyn_stats.get_mastery_level(statname.trim_prefix('mastery_'))
	if statname == 'base_exp':
		return xp_module.base_exp
	if statname == 'counters':
		return dyn_stats.counters
	if statname == 'price':
		return calculate_price()
	if statname.begins_with('food_') and statname != 'food_consumption':
		return food.get(statname)
	if statname in ['spirit', 'loyalty']:
		return training.get(statname)
	if statname == 'pregnancy_status':
		if has_status('heavy_pregnant'):
			return 'heavy'
		elif has_status('pregnant'):
			return 'early'
		else:
			return 'no'
	if statname.begins_with('armor_'):
		match statname:
			'armor_base':
#				return ('servant') #temporal, until correct recolor of armor
				var res =  equipment.get_gear_type('chest')
				if res == null and !has_work_rule('nudity'):
					res = 'underwear'
				if !GeneratorData.transforms[statname].has(res):
					res = 'servant'
				return res
			'armor_lower':
#				return ('servant') #temporal, until correct recolor of armor
				var res = equipment.get_gear_type('legs')
				if res == null and !has_work_rule('nudity'):
					res = 'underwear'
				if !GeneratorData.transforms[statname].has(res):
					res = 'servant'
				return res
			'armor_base_underwear', 'armor_lower_underwear':
				var res = equipment.get_gear_type('underwear')
				if res == null and !has_work_rule('nudity'):
					res = 'underwear'
				if res != null and has_work_rule('nudity'):
					res = null
				return res
			'armor_collar':
				var res = equipment.get_gear_type('neck')
				if !GeneratorData.transforms[statname].has(res):
					res = null
				return res
			'armor_weapon':
				var res = equipment.get_gear_type('rhand')
				if !GeneratorData.transforms[statname].has(res):
					res = null
				return res
	var st_data = statdata.statdata[statname]
	if st_data.direct:
		return statlist.get_stat(statname)
	else:
		return dyn_stats.get_stat(statname)


func set_stat(stat, value):
	if stat in ['hp', 'mp', 'shield', 'taunt']:
		set(stat, value)
		return
	if stat == 'base_exp':
		xp_module.base_exp = value
		return
	if stat.begins_with('food_') and stat != 'food_consumption':
		food.set(stat, value)
		return
	var st_data = statdata.statdata[stat]
	if st_data.direct:
		statlist.update_stat(stat, value, 'set')
	else:
#		print ("warning - direct setting of dynamic stat %s" % stat)
		dyn_stats.set_default_value(stat, value)
	dyn_stats.reset_rebuild()


func add_stat_bonuses(ls:Dictionary):
	dyn_stats.add_stat_bonuses(ls)
	dyn_stats.reset_rebuild()


func add_stat(statname, value): #only oneshots
	if statname in ['hp', 'mp', 'shield']:
		set(statname, get(statname) + value)
	elif statname == 'base_exp':
		if value > 0:
			xp_module.base_exp += value * get_stat('exp_gain_mod')
		else: 
			xp_module.base_exp += value
	elif statname == 'base_exp_direct':
		xp_module.base_exp += value
	elif statname in ['spirit', 'loyalty']:
		training.add_stat(statname, value)
	else: 
		var st_data = statdata.statdata[statname]
		if st_data.direct:
			statlist.update_stat(statname, value, 'add')
		else:
#			print ("warning - direct setting of dynamic stat %s" % statname)
			dyn_stats.add_stat_bonuses({statname + '_add': value})
	dyn_stats.reset_rebuild()


func mul_stat(statname, value): #only oneshots
	var st_data = statdata.statdata[statname]
	if st_data.direct:
		statlist.update_stat(statname, value, 'mul')
	else:
#		print ("warning - direct setting of dynamic stat %s" % statname)
		dyn_stats.add_stat_bonuses({statname + '_mul': value})
	dyn_stats.reset_rebuild()


func add_part_stat(statname, value): #only oneshots
	var st_data = statdata.statdata[statname]
	if st_data.direct:
		statlist.update_stat(statname, value, 'mul')
	else:
#		print ("warning - direct setting of dynamic stat %s" % statname)
		dyn_stats.add_stat_bonuses({statname + '_add_part': value})
	dyn_stats.reset_rebuild()


func change_personality_stats(stat, init_value, flag = false):
	return statlist.change_personality_stats(stat, init_value, flag)

func get_weapon_range():
	return equipment.get_weapon_range()

func get_weapon_animation():
	return equipment.get_weapon_animation()

func get_weapon_sound():
	return equipment.get_weapon_sound()

func get_damage_mod(skill):
	return skills.get_damage_mod(skill)

func get_value_damage_mod(skill_v):
	return skills.get_value_damage_mod(skill_v)

func remove_negative_sex_trait(code):
	statlist.remove_negative_sex_trait(code)

func add_sex_trait(code, known = false):
	statlist.add_sex_trait(code, known)

func remove_sex_trait(code, absolute = true):
	statlist.remove_sex_trait(code, absolute)

func unlock_sex_trait(code):
	statlist.unlock_sex_trait(code)

func create_s_trait_select(trait):
	statlist.create_s_trait_select(trait)

func fill_masternoun():
	statlist.fill_masternoun()

#questionable
func is_controllable(): #alias
	return is_combatant()

func is_avaliable():
	if has_status('no_job'):
		return false
	if get_work() == 'disabled':
		return false
	if get_work() == 'Assignment':
		return false
	
	return true

func has_profession(profession):
	if profession in ['pet','petbeast']:
		if dyn_stats.professions.has('pet') || dyn_stats.professions.has('petbeast'):
			return true
	return dyn_stats.professions.has(profession)

func check_trait(trait):
	if is_master() and trait.begins_with('loyalty_'): 
		return true
	return (dyn_stats.traits_real.has(trait) or statlist.sex_traits.has(trait) or statlist.negative_sex_traits.has(trait))

func predict_preg_time():
	return statlist.predict_preg_time()

func get_class_icon():
	if get_stat('slave_class') in ['master', 'heir', 'spouse', 'servant', 'servant_notax']:
		return images.get_icon(ResourceScripts.descriptions.bodypartsdata.slave_class[get_stat('slave_class')].icon)
	elif has_status('training_success'):
		var tmp = get_traits_by_tag('training_success')
		var upgrade_data = Traitdata.traits[tmp[0]]
		if upgrade_data.icon_small is String:
			return load(upgrade_data.icon_small)
		else:
			return upgrade_data.icon_small
	else:
		return images.get_icon(ResourceScripts.descriptions.bodypartsdata.slave_class[get_stat('slave_class')].icon)
#end to add
func process_chardata(chardata, unique = false):
	statlist.process_chardata(chardata)
	dyn_stats.process_chardata(chardata)
	if chardata.has('slave_class'): 
		set_slave_category(chardata.slave_class)
	training.process_chardata(chardata)
	food.process_chardata(chardata)
	skills.setup_skills(chardata)
	tags = chardata.tags.duplicate()


func generate_ea_character(gendata, desired_class):
	var res = desired_class
	var array = []
	for i in worlddata.easter_egg_characters.values():
		var temprace = gendata.race
		if races.race_groups.has(temprace):
			temprace = input_handler.random_from_array(races.race_groups[temprace])
		if ResourceScripts.game_world.easter_egg_characters_acquired.has(i.name) == false && (temprace == 'random' || gendata.race == i.race):
			var char_exists = false
			for k in characters_pool.characters.values():
				if k.get_stat('unique') == i.code:
					char_exists = true
					break
			if char_exists == false:
				array.append(i)
	if !array.empty():
		var chardata = input_handler.random_from_array(array)
		create(chardata.race, chardata.sex, chardata.age)
		process_chardata(chardata, true)
		res = chardata.class_category
	return res


func generate_random_character_from_data(races_l, desired_class = null, adjust_difficulty = 0, trait_blacklist = []):
	statlist.generate_random_character_from_data(races_l, desired_class, adjust_difficulty)
	dyn_stats.get_random_traits(trait_blacklist)
	xp_module.set_service_boost()


func get_class_list(category, person):
	return dyn_stats.get_class_list(category, person)


func generate_simple_fighter(tempname, setup_ai = true):
	var data = Enemydata.enemies[tempname]
	for i in variables.fighter_stats_list:
		if !data.has(i):
			set_stat(i, 0)
		else:
			set_stat(i, data[i])
	npc_reference = data.code
	statlist.generate_simple_fighter(data)
	skills.setup_skills(data)
	if setup_ai:
		ai = ResourceScripts.scriptdict.class_ai_base.new()
		if data.has('full_ai'):
			ai.set_simple_ai(data.ai)
		else:
			#need check for hard difficulty
			fill_ai(data.ai)
		ai.set_obj(self)
	else:
		skills.fix_skillpanels()
	if data.has('tags') and data.tags.has('boss'):
		globals.char_roll_data.uniq = true


func generate_predescribed_character(data):
	create(data.race, data.sex, data.age)
	process_chardata(data, true)
	skills.fix_skillpanels()
	if data.has('service_boosters'):
		xp_module.set_service_boost(data.service_boosters)
	else:
		xp_module.set_service_boost()


func turn_into_unique(code):
	var data = worlddata.pregen_characters[code]
	statlist.update_chardata(data)
	dyn_stats.process_chardata(data)
	food.process_chardata(data)
	tags = data.tags.duplicate() #or not
	skills.setup_skills(data)
	skills.fix_skillpanels()
	if data.has('service_boosters'):
		xp_module.set_service_boost(data.service_boosters)
	else:
		xp_module.set_service_boost()
	if data.has('training_disposition'):
		process_disposition_data(data.training_disposition, true)
	update_prt()
	globals.emit_signal("slave_added")


func create(temp_race, temp_gender, temp_age):
	id = characters_pool.add_char(self)
	learn_c_skill('attack')
	statlist.create(temp_race, temp_gender, temp_age)
	add_trait('core_trait')
	add_trait('untrained')
	
	hp = get_stat('hpmax')
	mp = get_stat('mpmax')
	
	food.create()
	training.build_stored_reqs()


func fill_boosters():
	xp_module.set_service_boost()

func make_random_portrait():
	statlist.make_random_portrait()

func setup_baby(mother, father):
	var temp_race
	var race1 = mother.get_stat('race')
	var race2 = father.get_stat('race')
	if randf() >= 0.5:
		temp_race = race1
	else:
		temp_race = race2
	var furryfix = false
	if race2.find('Beastkin') >= 0 && race1.find("Beastkin") < 0:
		temp_race = race2.replace("Beastkin", "Halfkin")
		furryfix = true
	elif race1.find('Beastkin') >= 0 && race2.find("Beastkin") < 0:
		temp_race = race1.replace("Beastkin", "Halfkin")
		furryfix = true
	create(temp_race, 'random', 'teen')
	
	for i in variables.inheritedstats:
		if furryfix and i == 'skin_coverage':
			continue
		if randf() >= 0.5 || mother.has_profession("breeder"):
			set_stat(i, mother.get_stat(i))
		else:
			set_stat(i, father.get_stat(i))
	
	for tr in mother.get_traits_by_tag('positive') + father.get_traits_by_tag('positive'):
		if randf() <= 0.8 or mother.has_profession("breeder") or father.has_profession("breeder"):
			add_trait(tr)
	for tr in mother.get_traits_by_tag('negative') + father.get_traits_by_tag('negative'):
		if mother.has_profession("breeder") or father.has_profession("breeder"):
			if randf() <= 0.1:
				add_trait(tr)
		elif randf() <= 0.5:
			add_trait(tr)
	
	baby_transform(mother)
	mother.set_stat('pregnancy_baby', id)
	mother.set_stat('pregnancy_duration', variables.pregduration)
	characters_pool.move_to_baby(id)
	ResourceScripts.game_party.connectrelatives(id, mother.id, "mother")
	ResourceScripts.game_party.connectrelatives(id, father.id, "father")
	xp_module.set_service_boost()

func get_baby_or_null():
	var tmp = get_stat('pregnancy_baby')
	return tmp

func get_short_name():
	return statlist.get_short_name()

func get_full_name():
	return statlist.get_full_name()

func get_short_race():
	var race = races.racelist[get_stat('race')].name
	if race.findn('Beastkin '): race = race.replace('Beastkin ','B.')
	if race.findn('Halfkin '): race = race.replace('Halfkin ','H.')
	return race.capitalize()

func equip(item, item_prev_id = null):
	set_stat('portrait_update', true)
	equipment.equip(item, item_prev_id)

func unequip(item, hard = true):
	set_stat('portrait_update', true)
	equipment.unequip(item, hard)

func unequip_all(hard = true):
	set_stat('portrait_update', true)
	equipment.clear_equip(hard)


func upgrade_mastery(school, force_universal = false):
	dyn_stats.upgrade_mastery(school, force_universal)

func can_upgrade_mastery(school, force_universal = false):
	return dyn_stats.can_upgrade_mastery(school, force_universal)

func upgrade_mastery_cost(school, force_universal = false):
	return dyn_stats.upgrade_mastery_cost(school, force_universal)

func unlock_class(prof, satisfy_progress_reqs = false):
	dyn_stats.unlock_class(prof, satisfy_progress_reqs)

func remove_class(prof):
	dyn_stats.remove_class(prof)

func remove_all_classes():
	dyn_stats.remove_all_classes()

func reset_mastery():
	dyn_stats.reset_mastery()

func add_trait(tr_code):
	dyn_stats.add_trait(tr_code)

func can_add_trait(tr_code):
	return dyn_stats.can_add_trait(tr_code)

func remove_trait(tr_code):
	dyn_stats.remove_trait(tr_code)

func get_traits_by_tag(tag):
	return dyn_stats.get_traits_by_tag(tag)

func get_random_trait_tag(tag):
	return dyn_stats.get_random_trait_tag(tag)

func get_traits_by_arg(arg, value):
	return dyn_stats.get_traits_by_arg(arg, value)

func get_random_traits():
	dyn_stats.get_random_traits()


func get_body_upgrades():
	dyn_stats.get_body_upgrades()


func has_body_upgrade(id):
	return dyn_stats.has_body_upgrade(id)


func can_learn_skill(skill_id):
	var skilldata = Skilldata.Skilllist[skill_id]
	if !skilldata.tags.has('learnable'):
		return false
	if skilldata.has('learn_reqs') and !checkreqs(skilldata.learn_reqs):
		return false
	if skilldata.has('learn_cost') and xp_module.abil_exp < skilldata.learn_cost:
		return false
	return true

func learn_skill(skill):
	skills.learn_skill(skill)

func learn_c_skill(skill):
	skills.learn_c_skill(skill)

func learn_e_skill(skill):
	skills.learn_e_skill(skill)

func unlearn_skill(skill):
	skills.unlearn_skill(skill)

func unlearn_c_skill(skill):
	skills.unlearn_c_skill(skill)
	if selectedskill == skill:
		selectedskill = get_skill_by_tag('default')

func unlearn_e_skill(skill):
	skills.unlearn_e_skill(skill)

func cooldown_tick():
	skills.cooldown_tick()
	training.cooldown_tick()


func check_task(task):
	return xp_module.check_task(task)

func get_task_diff():
	return xp_module.get_task_diff()


func find_current_task():
	var res = xp_module.find_task(get_location())
	if res == null: 
		return res
	if res.workers.has(id): 
		return res
	else:
		print ("warn - %s not included into current task" % id)
		return null

func assign_to_task(taskcode, taskproduct):
	xp_module.assign_to_task(taskcode, taskproduct)

func assign_to_special_task(worktask):
	xp_module.assign_to_special_task(worktask)

func remove_from_task(travel = false):
	xp_module.remove_from_task(travel)

func return_to_task():
	xp_module.return_to_task()

func travel_per_tick():
	return travel.travel_per_tick()

func calculate_estimated_travel_time(t_time):
	return travel.calculate_estimated_travel_time(t_time)

func set_travel_time(value):
	travel.set_travel_time(value)

func return_to_mansion():
	xp_module.remove_from_task()
	travel.return_to_mansion()

func recruit(enslave = false):
	is_active = true
	travel.location = input_handler.active_location.id
	travel.area = input_handler.active_area.code
	if enslave == true:
		set_slave_category('slave')
		set_work_rule('bindings', true)
	ResourceScripts.game_party.add_slave(self)

func recruit_and_return():
	travel.return_recruit()
	ResourceScripts.game_party.add_slave(self)


func set_work(task):
	if xp_module.work == 'disabled' and task != 'disabled':
		print("There is a critical error - attempting to enable character a wrong way. Please try to remember and report chain of actions that can be its cause. All saves after this may (or may not) be broken.")
		return
	xp_module.remove_from_task()
	xp_module.work = task
	if task == 'produce':
		xp_module.setup_farm()

func set_work_rule(rule, value):
	xp_module.set_work_rule(rule, value)

func check_work_rule(rule):
	return xp_module.check_work_rule(rule)

func set_brothel_rule(rule, value):
	xp_module.set_brothel_rule(rule, value)

func check_brothel_rule(rule):
	return xp_module.check_brothel_rule(rule)

func set_farm_res(res, value):
	xp_module.set_farm_res(res, value)

func get_farm_res(res):
	return xp_module.check_farm_res(res)

func find_worktask():
	return xp_module.find_worktask(get_location())


func get_quest_time_init():
	return xp_module.get_quest_time_init()

func get_selected_quest():
	return xp_module.get_selected_quest()

func remove_from_work_quest():
	xp_module.remove_from_work_quest()

func get_skill_by_tag(tg):
	var res = skills.get_skill_by_tag(tg)
	if res == null: print ("ERROR in skill config - no default skill")
	return res

func baby_transform(mother):
	statlist.baby_transform(mother)


func setup_as_heir():
	var reldata = ResourceScripts.game_party.get_relatives_data(id)
	if reldata == null: return #possibly error
	if reldata.father == null or reldata.mother == null: return
	var mreldata = ResourceScripts.game_party.get_relatives_data(reldata.mother)
	var freldata = ResourceScripts.game_party.get_relatives_data(reldata.father)
	if mreldata == null or freldata == null: return
	var mother = characters_pool.get_char_by_id(mreldata.id)
	var father = characters_pool.get_char_by_id(freldata.id)
	if mother == null or father == null: return
	if mother.is_master():
		if father.is_spouse():
			set_slave_category('heir')
		else:
			set_slave_category('slave')
	elif mother.is_spouse():
		if father.is_master():
			set_slave_category('heir')
		else:
			set_slave_category(mother.get_stat('slave_class'))
	else:
		set_slave_category(mother.get_stat('slave_class'))


func get_weapon_element():
	if has_status('e_damage_buff'):
		return get_stat('damagetype')
	var tmp = equipment.get_weapon_element()
	if tmp != 'normal':
		return tmp
	return get_stat('damagetype')

func find_temp_effect_tag(eff_tag):
	if dyn_stats.rebuild < variables.DYN_STATS_PREAREA:
		dyn_stats.generate_data(variables.DYN_STATS_PREAREA)
	return dyn_stats.find_temp_effect_tag(eff_tag)


func apply_effect_code(eff_code, args = {}):
	if npc_reference == 'combat_global': 
		return
	dyn_stats.add_stored_effect(eff_code, args)


func apply_status(args):
	if npc_reference == 'combat_global': 
		return
	if !args.has('chance'):
		args.chance = 1.0
	dyn_stats.apply_status(args)


func remove_effect_stack(id):
	dyn_stats.remove_effect_stack(id)


func remove_effect(eff_id):
	dyn_stats.remove_effect(eff_id)


func remove_temp_effect_tag(eff_tag):#function for non-direct temps removing, like heal or dispel
	dyn_stats.remove_temp_effect_tag(eff_tag)

func remove_all_temp_effects_tag(eff_tag):#function for non-direct temps removing, like heal or dispel
	dyn_stats.remove_all_temp_effects_tag(eff_tag)


func process_event(ev, data = {}):
	dyn_stats.process_event(ev, data)

func get_all_buffs():
	if dyn_stats.rebuild < variables.DYN_STATS_FULL:
		dyn_stats.generate_data()
	return dyn_stats.buffs

func get_combat_buffs():
	var tres = get_all_buffs()
	var res = []
	
	for b in tres:
		if b.tags.has('combat_only'): 
			res.push_front(b)
	return res

func get_mansion_buffs():
	var tres = get_all_buffs()
	var res = []
	for b in tres:
		if b.tags.has('mansion_only'): 
			res.push_front(b)
	return res

func can_act():
	if is_koed(): 
		return false
	return !has_status('disable')

func can_evade():
	var res = can_act()
	if has_status('defend'): 
		res = false
	return res

func can_use_skill(skill):
	if is_players_character and !check_cost(skill.cost): return false
	if skill.type == 'auto': return false
	if is_players_character and skill.has('reqs') and !checkreqs(skill.reqs): return false
	if skills.combat_cooldowns.has(skill.code): return false
	if has_status('disarm') and skill.ability_type == 'skill' and !skill.tags.has('default'):
		 return false
	if has_status('silence') and skill.ability_type == 'spell' and !skill.tags.has('default'):
		 return false
	return true

func has_status(status):
	var res = dyn_stats.has_status(status) or statlist.has_status(status) or tags.has(status)
	return res

func is_combatant():
	if get_stat('slave_class') != 'slave':
		return has_status('combatant')
	else:
		return training.get_trainer() != null

func is_worker():
	if get_stat('slave_class') != 'slave':
		return has_status('worker')
	else:
		return training.get_trainer() != null

func has_work_rule(rule):
	if !variables.work_rules.has(rule): return false
	return xp_module.work_rules[rule]

func is_master():
	return has_profession('master')

func is_spouse():
	return id == ResourceScripts.game_progress.spouse


func is_unique():
	return get_stat('unique') != null


func add_rare_trait():
	if ResourceScripts.game_globals.date < 2: return
	tags.push_back('rare')
	dyn_stats.add_rare_trait()
	#tutorial part here
	#input_handler.ActivateTutorial('rares')

func can_be_damaged(skill):
	if skill.tags.has('damage'):
		if has_status('warded') and !has_status('ward'):
			return false
	match skill.ability_type:
		'skill': 
			return !has_status('banish')
		'spell': 
			return !has_status('void')

func restore_skill_charge(code):
	skills.restore_skill_charge(code)


func set_slave_category(new_class):
	var oldclass = get_stat('slave_class')
	if oldclass == new_class:
		return
	if oldclass != '':
		remove_trait(oldclass)
	add_trait(new_class)
	dyn_stats.generate_data(variables.DYN_STATS_PREAREA)
	statlist.statlist.slave_class = new_class
	if has_status('trained'):
		finish_training(true)
	else:
		reset_training()


func use_social_skill(s_code, target):
	skills.use_social_skill(s_code, target, null)

#func process_skill_cast_event(s_skill, event):
#	effects.process_skill_cast_event(s_skill, event)

func check_location(loc, completed = false):
	if loc == 'mansion': loc = ResourceScripts.game_world.mansion_location
	return travel.check_location(loc, completed)

func remove_from_travel():
	travel.remove_from_travel()

func reset_location():
	travel.set_location_to_default()

func same_location_with(ch):
	return travel.same_location_with(ch.travel)

func get_current_location_desc():
	return travel.make_location_description()

func get_next_class_exp():
	return xp_module.get_next_class_exp()

func get_work():
	return xp_module.get_work()

func get_tutelage_type():
	return xp_module.get_tutelage_type()

func is_on_quest():
	return xp_module.is_on_quest()

func is_free():
	if is_on_quest(): return false
	return check_location('mansion', true)


func assign_to_quest_and_make_unavalible(quest, work_time = -1):
	xp_module.assign_to_quest_and_make_unavalible(quest, work_time)

func get_quest_time_remains():
	return xp_module.get_quest_time_remains()

func quest_day_tick():
	xp_module.quest_day_tick()

func get_prof_number():
	return dyn_stats.get_prof_number()

func get_professions():
	return dyn_stats.get_professions()


func use_mansion_item(item):
	skills.use_mansion_item(item)

func get_icon(path = false):
	if path: 
		return statlist.get_icon_path()
	else: 
		var res = statlist.get_icon()
		if res == null:
			res = races.racelist[get_stat('race')].icon
			if res is String:
				res = load(res)
		return res

func get_icon_small(): #obsolete
	var res = get_icon()
	if res == null:
		res = races.racelist[get_stat('race')].icon
		if res is String:
			res = load(res)
	return res

func get_body_image():
	return statlist.get_body_image()

func get_stored_body_image():
	return statlist.get_stored_body_image()

func get_stat_data():
	var res = {}
	res['skill_stat'] = 'physics'
	res['spell_stat'] = 'wits'
	res['skill_atk'] = 'atk'
	res['spell_atk'] = 'matk'
	#to add trait checks
	return res

func access_sexexp():
	return statlist.access_sexexp()

func get_all_sex_traits():
	return statlist.get_all_sex_traits()

func get_sex_traits():
	return statlist.get_sex_traits()

func get_sex_skills():
	return statlist.get_sex_skills()

func get_negative_sex_traits():
	return statlist.get_negative_sex_traits()

func get_unlocked_sex_traits():
	return statlist.get_unlocked_sex_traits()

func make_trait_known(trait):
	return statlist.make_trait_known(trait)

func get_gear(slot):
	return equipment.get_gear(slot)

func get_equiped_items():
	return equipment.get_equiped_items()

func get_location():
	return travel.location

func get_tattoo(slot):
	return statlist.get_tattoo(slot)

func get_tattoos():
	return statlist.get_tattoos()

func get_filled_tattoos():
	return statlist.get_filled_tattoos()

func can_add_tattoo(slot, code):
	return statlist.can_add_tattoo(slot, code)

func add_tattoo(slot, code):
	return statlist.add_tattoo(slot, code)

func remove_tattoo(slot):
	statlist.remove_tattoo(slot)

func play_sfx(code):
	if displaynode != null:
		displaynode.process_sfx(code)

func get_progress_task(temptask, tempsubtask, count_crit = false):
	return xp_module.get_progress_task(temptask, tempsubtask, count_crit)


func get_progress_farm(res):
	return xp_module.get_progress_farm(res)

func get_farming_limit():
	return xp_module.get_farming_limit()

func can_add_farming():
	return xp_module.can_add_farming()


func act_prepared():
	skills.act_prepared()


func get_upgrade_points():
	return dyn_stats.get_upgrade_points()


func add_upgrade(upg): #unsafe adding
	dyn_stats.add_upgrade(upg)


func can_add_upgrade(upg):
	return dyn_stats.can_add_upgrade(upg)


func remove_upgrade(upg):
	dyn_stats.remove_upgrade(upg)


func recheck_upgrades():
	dyn_stats.recheck_upgrades()


func recheck_equip():
	equipment.recheck_equip()

func process_disposition_data(data, setup = false):
	training.process_disposition_data(data, setup)

func process_traits_availability_data(data):
	training.process_traits_availability_data(data)

func get_trainer():
	return training.get_trainer()

func get_trainees():
	return training.get_trainees()

func get_dispositions_text():
	return training.get_dispositions_text()

func add_trainee(id):
	training.add_trainee(id)

func add_training(id):
	training.add_training(id)

func reset_training():
	training.reset_training()

func clear_training():
	training.clear_training()

func can_be_trained():
	return training.can_be_trained()

func can_be_trainer():
	var res = true
	if get_stat('slave_class') == 'slave':
		res = !training.enable
	return res and has_status('trainer')

func finish_training(internal = false):
	training.finish_training(internal)

func apply_training(tr_code):
	training.apply_training(tr_code)

func get_training_cost():
	return training.get_training_cost()

func get_training_cost_gold():
	return training.get_training_cost_gold()

func process_training_metrics(value):
	training.process_training_metrics(value)

func serialize():
	var res = inst2dict(self)
	res.statlist = inst2dict(statlist)
	res.dyn_stats = inst2dict(dyn_stats)
	res.xp_module = inst2dict(xp_module)
	res.equipment = inst2dict(equipment)
	res.skills = inst2dict(skills)
	res.travel = inst2dict(travel)
	res.food = inst2dict(food)
	res.training = inst2dict(training)
	return res

func fix_serialization():
	if xp_module is Dictionary:
		xp_module = dict2inst(xp_module)
	if equipment is Dictionary:
		equipment = dict2inst(equipment)
	if skills is Dictionary:
		skills = dict2inst(skills)
	if travel is Dictionary:
		travel = dict2inst(travel)
	if food is Dictionary:
		food = dict2inst(food)
	if training is Dictionary:
		training = dict2inst(training)
	var tmp = statlist.duplicate()
	statlist = ResourceScripts.scriptdict.ch_statlist.new()
	var tmp2 = dyn_stats.duplicate()
	dyn_stats = ResourceScripts.scriptdict.ch_statlist_dynamic.new()
	rebuild_parents()
	statlist.deserialize(tmp)
	dyn_stats.deserialize(tmp2)
	xp_module.fix_rules()
	travel.fix_infinite_travel()



func fix_serialization_postload():
	statlist.fix_serialize()
	dyn_stats.fix_serialize()
	xp_module.fix_serialize()
	
	repair_skill_panels()


func fix_import():
	xp_module.fix_import()
	travel.fix_import()
	statlist.fix_import()


func repair_skill_panels():
	skills.repair_skill_panels()

#AI-related stuff
func need_heal(): #stub. borderlines are subject to tuning
	if has_status('banish'): 
		return -1.0
	var rate = hp * 1.0 / get_stat('hpmax')
	if rate < 0.2: 
		return 1.0
	if rate < 0.4: 
		return 0.5
	if rate < 0.6: 
		return 0.0
	if rate < 0.8: 
		return -0.5
	return -1.0

#core functions
func hp_get():
	if hp > get_stat('hpmax'):
		hp = get_stat('hpmax')
	return hp


func hp_set(value):
	if npc_reference == 'combat_global': 
		return
	if hp <= 0:
		if value <= hp:
			return
		else:
			hp = value
			return
	hp = min(value, get_stat('hpmax'))
	if has_status('last_stand') and hp < 0.1 * get_stat('hpmax'):
		hp = int(ceil(0.1 * get_stat('hpmax')))
	if displaynode != null:
		displaynode.update_hp()
	if hp <= 0:
		if has_status('reincarnate'):
			hp = get_stat('hpmax')
			remove_temp_effect_tag('reincarnate')
#            play_sfx('reborn')
			if displaynode != null:
				displaynode.update_hp()
				displaynode.rebuildbuffs()
		else:
			death()
	else:
		defeated = false


func mp_set(value):
	if npc_reference == 'combat_global': return
	mp = clamp(value, 0, get_stat('mpmax'))
	if displaynode != null:
		displaynode.update_mana()


func death():
	process_event(variables.TR_DEATH)
	effects_pool.process_event(variables.TR_DEATH, self)
#	process_event(variables.TR_COMBAT_F)
	if npc_reference != null:
		input_handler.emit_signal("EnemyKilled", npc_reference)
	if displaynode != null:
		displaynode.defeat()
	if input_handler.combat_node != null:
		if has_status('fastheal'):
			apply_effect_code('e_g_injury_delay', {duration = 8})
		else:
			apply_effect_code('e_g_injury_delay', {duration = 12})
		#in this case check for permadeath is not here but in various finish combat methods
	else:
		if !ResourceScripts.game_globals.diff_permadeath:
			if has_status('fastheal'):
				apply_effect_code('e_grave_injury', {duration = 8})
			else:
				apply_effect_code('e_grave_injury', {duration = 12})
		else:
			killed(false)
		#add permadeath check here
	#clean_effects()
#	if input_handler.combat_node == null && travel.location == ResourceScripts.game_world.mansion_location:
#		is_active = false
#		print('warning! char died outside combat')
#		characters_pool.call_deferred('cleanup')


func killed(direct_call = true):
	if direct_call: 
		process_event(variables.TR_DEATH)
	equipment.clear_equip()
	training.clear_training()
	ResourceScripts.game_party.add_fate(id, tr("DIED"))
	is_active = false
	ResourceScripts.game_party.character_order.erase(id)
	characters_pool.call_deferred('cleanup')
	input_handler.update_slave_list()
	if is_master():
		input_handler.interactive_message('generic_lose_scene', '', {})


func teleport(data):
	var locdata = ResourceScripts.game_world.find_location_by_data(data)
	if locdata.area == null or locdata.location == null:
		print("teleportation to %s failed" % str(data))
		return
	xp_module.remove_from_task()
	travel.location = locdata.location
	travel.area = locdata.area # I think it's wrong @Sphinx 
	#error was in getting locdata 
#	travel.area = locdata.area.code
	travel.travel_time = 0
	globals.emit_signal("slave_arrived", self)
	input_handler.update_slave_list()
	#add logging if reqired


func process_stored_check(check): #compatibility stub
	return training.check_stored_reqs(check)


func process_check(check): #compatibility stub
	return checkreqs(check)


func checkreqs(arg, ignore_npc_stats_gear = false): #additional flag is never used
	if typeof(arg) == TYPE_ARRAY:
		var check = true
		for i in arg:
			if i.has('orflag'):
				check = check or valuecheck(i, ignore_npc_stats_gear)
			else:
				check = check and valuecheck(i, ignore_npc_stats_gear)
		return check
	else:
		return valuecheck(arg, ignore_npc_stats_gear)


func valuecheck(ch, ignore_npc_stats_gear = false): #additional flag is never used
	if ch.has('master_check') and ch.master_check and !is_master():
		return ResourceScripts.game_party.get_master().valuecheck(ch, ignore_npc_stats_gear)
	var i = ch.duplicate()
	var check = true
	match i.code:
		'false':
			return false
		'stat':
			if i.stat in ['tame_factor','authority_factor'] && is_master():
				return true
			if typeof(i.value) == TYPE_ARRAY: i.value = calculate_number_from_string_array(i.value)
			if ignore_npc_stats_gear:
#				check = input_handler.operate(i.operant, get_stat_nobonus(i.stat), i.value)
				check = input_handler.operate(i.operant, get_stat(i.stat), i.value) #idk if alt mode was really needed
			else:
				check = input_handler.operate(i.operant, get_stat(i.stat), i.value)
		'stat_in_set':
			check = i.value.has(get_stat(i.stat))
		'stat_index':
			if typeof(i.value) == TYPE_ARRAY: i.value = calculate_number_from_string_array(i.value)
			check = input_handler.operate(i.operant, get_stat(i.stat)[i.index], i.value)
		'has_profession':
			if i.has("profession"):
				check = has_profession(i.profession) == i.check
			if i.has("value"):
				check = has_profession(i.value) == i.check
		'has_any_profession':
			check = false
			for k in i.value:
				if has_profession(k):
					check = true
		'has_skill':
			return dyn_stats.has_skill(i.value) == i.check
		'race_is_beast':
			check = races.racelist[get_stat('race')].tags.has('beast') == i.check
		'is_shortstack':
			check = (get_stat('height') in ['tiny','petite']) == i.check
		'gear_equiped':
			if i.has('param'): check = equipment.check_gear_equipped(i.value, i.param) == i.check
			else: check = equipment.check_gear_equipped(i.value) == i.check
		'global_profession_limit':
			check = ResourceScripts.game_party.check_profession_limit(i.profession, i.value)
		'race':
			check = (get_stat('race') == i.race) == i.check
		'one_of_races':
			check = get_stat('race') in i.value
		'is_free':
			check = (is_free() == i.check)
		'is_at_location':
			if variables.allow_remote_intereaction == true and i.check: check = true
			else: check = check_location(i.value, true) == i.check
		'is_id':
			check = input_handler.operate(i.operant, id, i.value)
		'long_tail':
			check = variables.longtails.has(get_stat('tail')) == i.check
		'long_ears':
			check = variables.longears.has(get_stat('ears')) == i.check
		'hair_length':
			check = (get_stat('hair_length') in i.value) == i.check
		'is_humanoid':
			check = (get_stat('racegroup') == 'humanoid') == i.check
		'is_dead':
			check = (is_active != i.check)
		'cant_spawn_naturally':
			check = !ignore_npc_stats_gear
		'sex':
			check = input_handler.operate(i.operant, get_stat('sex'), i.value)
		'is_master':
			check = has_profession('master') == i.check
		'rules':
			check = input_handler.globalsettings[i.type] == i.check
		'bodypart':
			check = input_handler.operate(i.operant, get_stat(i.part), i.value)
		'trait':
			check = check_trait(i.trait) == i.check
		'disabled':
			check = !i.check
		'has_status':
			check = has_status(i.status) == i.check
		'slave_type':
			check = input_handler.operate(i.operant, get_stat('slave_class'), i.value)
		'population':
			check = input_handler.operate(i.operant, ResourceScripts.game_party.characters.size(), i.value)
		'random':
			if typeof(i.value) == TYPE_ARRAY: i.value = calculate_number_from_string_array(i.value)
			check = globals.rng.randf()*100 <= i.value
		'virgin':
			check = (get_stat('vaginal_virgin_lost') == null) == i.check
		'class_unlocked':
			return ResourceScripts.game_progress.if_class_unlocked(i.class, i.check, i.operant)
		'has_wooden_gear':
			return equipment.check_wooden_gear_equipped()
		'unique':
			return get_stat('unique') == i.value
		'is_unique':
			check = is_unique() == i.value
		'body_image':
			return input_handler.operate(i.operant, get_stat('body_image'), i.value)
		'in_combat_party':
			if variables.allow_remote_intereaction == true and i.value: check = true
			else: check = (combat_position in range(1, 7)) == i.value
		'setting':
			return input_handler.globalsettings[i.type] == i.value
		'has_coverage':
			var coverage = get_stat('skin_coverage')
			return (coverage.find(i.coverage) != -1) == i.check
		'lone_wolf':
			if input_handler.combat_node == null:
				return !i.check
			return (input_handler.combat_node.playergroupcounter == 1) == i.check
		'workrule':
			return check_work_rule(i.value) == i.check
		'check_stored':
			return training.check_stored_reqs(i.value)
		'is_immune':
			return dyn_stats.check_status_immunity(i.status) == i.check
		'has_relationship':
			var tmp = ResourceScripts.game_party.find_all_relationship(id)
			var tres = false
			for rec in tmp:
				if rec.relationship == i.value:
					tres = true
					break
			return tres == i.check
	return check


func decipher_reqs(reqs, colorcode = false, purestat = false):
	var text = ''
	for i in reqs:
		var text2 = ''
#		if i.has('orflag'):
#			check = check or valuecheck(i)
#		else:
#			check = check and valuecheck(i)
#		if i.has('orflag'):
#			continue
		text2 = decipher_single(i)
		if colorcode == true:
			if checkreqs([i], purestat):
				text2 = '{color=green|' + text2 + '}'
			else:
				text2 = '{color=red|' + text2 + '}'
		text += text2 + '\n'
	return globals.TextEncoder(text.substr(0, text.length()-1))


func decipher_single(ch):
	var i = ch.duplicate()
	var text2 = ''
	match i.code:
		'stat':
			var skip_highlow = false
			if typeof(i.value) == TYPE_ARRAY: i.value = calculate_number_from_string_array(i.value)
			if i.stat.find("factor") > 0:
				text2 += statdata.statdata[i.stat].name + ': ' + tr(ResourceScripts.descriptions.factor_descripts[i.value]) + " "
			elif i.stat.find("metrics") >= 0:
				text2 += tr(i.stat.to_upper() + "_NAME") % [get_stat(i.stat),i.value]
				skip_highlow = true
			else:
				text2 += statdata.statdata[i.stat].name + ': ' + str(i.value) + " "
			if skip_highlow == true:
				continue
			match i.operant:
				'gte':
					text2 += tr("REQORHIGHER")
				'lte':
					text2 += tr("REQORLOWER")
		
		'stat_in_set':
			if i.stat == 'personality':
				text2 += tr("SLAVEPARTPERSONALITY") + ": "
				for k in i.value:
					text2 += tr("PERSONALITYNAME" + k.to_upper()) + ", "
				text2 = text2.substr(0, text2.length()-2)
		
		'has_profession':
			if i.check == true:
				text2 += tr("REQHASCLASS")+': ' + classesdata.professions[i.profession].name
			else:
				text2 += tr("REQCONFLICTCLASS")+': ' + classesdata.professions[i.profession].name
		'has_any_profession':
			text2 += tr('REQHASANYCLASS')+": "
			for k in i.value:
				text2 += classesdata.professions[k].name + ", "
			text2 = text2.substr(0, text2.length()-2)
		'race':
			if i.check:
				text2 += tr("REQRACE") + ': ' + races.racelist[i.race].name
			else:
				continue
		'race_is_beast':
			if i.check == true:
				text2 += tr("REQRACEISBEAST")+''
			else:
				continue
		'gear_equiped': #to fix non-default param
			text2 += tr("REQMUSTHAVEGEAR")+' ' + Items.itemlist[i.value].name + "."
		'global_profession_limit':
			text2 += tr("REQPROFLIMIT")+' ' + str(i.value) + " " + classesdata.professions[i.profession].name + " "+tr("REQPROFLIMIT2")+"."
		'one_of_races':
			text2 += tr("REQONEOFRACES")+": "
			for k in i.value:
				text2 += races.racelist[k.replace(" ","")].name + ', '
			text2 = text2.substr(0, text2.length()-2) + '. '
		'trait':
			text2 += tr("REQTRAIT")+": " + Traitdata.traits[i.trait].name
		'population':
			text2 += tr("REQPOPULATION")+": " + str(i.value)
		'sex':
			match i.operant:
				'neq':
					text2 += tr("REQSEX")+": " + i.value.capitalize() + "."
		'virgin':
			match i.check:
				false:
					text2 += tr("REQVIRGINFALSE")
	return text2


func make_description():
	input_handler.text_characters.clear()
	input_handler.text_characters.append(self)
	return globals.TextEncoder(translate(ResourceScripts.descriptions.create_character_description(self)))


func show_race_description():
	var race = get_stat('race')
	var temprace = races.racelist[race]
	var text = ''
	if temprace.tags.has('beast'):
		if race.find("Beastkin") >= 0:
			text += tr("RACEBEASTKINDESCRIPT") + "\n\n"
		elif race.find("Halfkin") >= 0:
			text += tr("RACEHALFKINDESCRIPT") + "\n\n"
	text += temprace.descript
	text += "\n\n" + tr("RACE_BONUSES") + ": " + globals.build_desc_for_bonusstats(temprace.race_bonus)
	if temprace.has("combat_skills"):
		text += "\n" + tr("COMBAT_ABILS_LABEL") + ": "
		for i in temprace.combat_skills:
			text += Skilldata.Skilllist[i].name + "; "
		text = text.substr(0, text.length() - 2) + "."
	return text


func escape_actions():
	remove_from_work_quest()
	remove_from_task()
	remove_from_travel()
	ResourceScripts.game_party.add_fate(id, tr("ESCAPED"))
	is_active = false #for now, to replace with corresponding mechanic
	characters_pool.cleanup()

func predict_food():
	return food.predict_food()


func pretick():
	process_event(variables.TR_TICK)


func tick():
	if is_on_quest():
		return
	
	var skip_work = false
	if get_work() == '':
		skip_work = true
	
	self.hp += get_stat('hp_reg')
	self.mp += get_stat('mp_reg')
	#loyalty and obedience changes are in sats
	if ResourceScripts.game_globals.hour == 2:
		food.get_food()
	
	statlist.tick()
	if get_work() == 'travel':
		#fatigue -= 1
		travel.tick()
		return
	
	xp_module.work_tick()


func rest_tick():
	self.hp += get_stat('hp_reg') * 2
	self.mp += get_stat('mp_reg') * 2
	for e in find_temp_effect_tag('addition_rest_tick'):
		var eff = effects_pool.get_effect_by_id(e)
		eff.process_event(variables.TR_TICK)


func translate(text):
	text = statlist.translate(text)
	text = text.replace("[price]", str(calculate_price(true))) #need another placeholder for a non-shop value. for now it is not used, but may be handy 
	if text.find('[spouse') != -1:
		if !has_profession('master'):
			print ("active char is not master")
			return text
		if ResourceScripts.game_progress.spouse == null:
			print ("spouse not set")
			return text
		var spouse = characters_pool.get_char_by_id(ResourceScripts.game_progress.spouse)
		if spouse == null or !spouse.is_active or !spouse.is_players_character:
			print ("no spouse alive")
			return text
		text = text.replace("[spouse", "[")
		return spouse.translate(text)
	return text


func calculate_price(shopflag = false):
	var value = 0
	var tr_mul1 = 0
	var tr_mul2 = 0
	var mod_mul = 1.0
	var mod_mul2 = 0.0
	tr_mul1 = get_traits_by_tag('positive').size() 
	tr_mul2 = get_traits_by_tag('negative').size()
	mod_mul += min (tr_mul1 * 0.2, 0.6)
	mod_mul -= tr_mul2 * 0.2 
	if shopflag:
		if has_status('virgin'):
			mod_mul2 += 0.25
		value *= mod_mul + mod_mul2
	else:
		if has_status('soulbind'):
			mod_mul -= 0.9
		value *= mod_mul
	value = value * variables.growth_factor_cost_mod[get_stat('growth_factor')]
	return max(50,round(value))


func apply_atomic(template):
	if input_handler.combat_node != null and input_handler.combat_node.ActionQueue != null and template.type != 'remove_all_effects':
		input_handler.combat_node.ActionQueue.add_atomic(template, id)
	else:
		affect_char(template)


func affect_char(template):
	match template.type:
		'damage':
			var tval = deal_damage(template.value, template.source)
			if input_handler.combat_node != null:
				input_handler.combat_node.combatlogadd("\n%s loses %d hp." % [get_short_name(), int(tval)])
		'damage_percent':
			deal_damage((template.value / 100.0) * get_stat('hpmax'))
		'heal':
			heal(template.value)
		'mana':
			mana_update(template.value)
		'damage_mana_percent':
			mana_update(-template.value * get_stat('mpmax'))
		'stat', 'stat_add':
			add_stat(template.stat, template.value)
		'stat_set':
			set_stat(template.stat, template.value)
		'stat_add_p':
			add_part_stat(template.stat, template.value)
		'stat_mul':#do not mix add_p and mul for the sake of logic
			mul_stat(template.stat, template.value)
		'signal':
			#stub for signal emitting
			globals.emit_signal(template.value)
		'event':
			process_event(template.value)
		'resurrect':
			resurrect(template.value)
#			if !defeated: return
#			self.hp = template.value
#			defeated = false
#			process_event(variables.TR_RES)
		'kill':
			killed()
		'use_combat_skill':
			if input_handler.combat_node == null: 
				return
			if skills.combat_cooldowns.has(template.skill): 
				return
#			input_handler.combat_node.use_skill(template.skill, self, template.target)
			var s_id = template.skill
			if s_id is Array:
				s_id = input_handler.random_from_array(s_id)
			var skill = Skilldata.get_template_combat(s_id, self)
			var tmp_handler = input_handler.combat_node.ActionQueue.add_skill_callback()
			tmp_handler.mode = variables.SKILL_EFFECT
			tmp_handler.setup_caster(self)
			tmp_handler.createfromskill(skill)
			if template.has('target'):
				tmp_handler.setup_target(template.target)
			else:
				tmp_handler.setup_target(self)
		'use_social_skill':
			if !check_location('mansion'): return
			#use_social_skill(template.value, null)
			skills.prepared_act.push_back(template.skill)
		'end_turn':
			if input_handler.combat_node == null: 
				return
			input_handler.combat_node.ActionQueue.add_end_turn()
		'transform_into':
			if input_handler.combat_node == null: 
				return
			input_handler.combat_node.transform_unit(position, template.unit)
		'sfx':
			play_sfx(template.value)
		'effect':
			var args = {}
			if template.has('override'):
				args = template.override.duplicate()
			apply_effect_code(template.value, args)
		'remove_effect':
			remove_temp_effect_tag(template.value)
		'remove_all_effects':
			remove_all_temp_effects_tag(template.value)
		'teleport':
			teleport(template.value)
		'set_availability':
			if template.value:
				xp_module.make_avaliable()
			else:
				xp_module.make_unavaliable()
		'set_as_spouse':
			ResourceScripts.game_progress.spouse = id
		'escape':
			escape_actions()
		'remove_trait':
			remove_trait(template.trait)
		'add_trait':
			add_trait(template.trait)
		'unlock_trait':
			training.unlock_trait(template.trait)
		'add_sex_trait':
			add_sex_trait(template.trait, true)
		'unlock_sex_trait':
			unlock_sex_trait(template.trait)
		'set_tutelage':
			xp_module.assign_to_learning(template.value)
			input_handler.rebuild_slave_list()
		'add_counter':
			if dyn_stats.counters.size() <= template.index + 1:
				dyn_stats.counters.resize(template.index + 1)
			if dyn_stats.counters[template.index] == null: 
				dyn_stats.counters[template.index] = template.value
			else:
				dyn_stats.counters[template.index] += template.value
		'add_soc_skill':
			learn_skill(template.skill)
		'add_combat_skill':
			learn_c_skill(template.skill)
		'quest':
			assign_to_quest_and_make_unavalible({id = template.id, name = template.name}, template.duration)
		'slavetype':
			set_slave_category(template.value)
		'remove':
			ResourceScripts.game_party.add_fate(id, tr("REMOVED"))
			ResourceScripts.game_party.remove_slave(self)
			input_handler.slave_list_node.rebuild()
		'turn_into_unique':
			turn_into_unique(template.value)
		'reset_cooldowns':
			skills.reset_cooldowns()
		'dungeon_effect':
			if gui_controller.exploration_dungeon != null:
				match template.value:
					'reveal_map':
						gui_controller.exploration_dungeon.reveal_map(self)
					
					'set_intimidate':
						gui_controller.exploration_dungeon.set_intimidate()
		'location_effect':
			match template.value:
				'set_teleport':
					ResourceScripts.game_world.setup_teleporter(get_location())
				'gather_res':
					ResourceScripts.game_world.gather_res(get_location(), get_stat('matk') * 10)


func is_koed():
	return (hp <= 0) or defeated or !is_active


func calculate_number_from_string_array(arr):
	var array = arr.duplicate()
	var endvalue = 0
	var firstrun = true
	var singleop = ''
	for i in array:
		if typeof(i) == TYPE_ARRAY:
			i = str(calculate_number_from_string_array(i))
		if i in ['+','-','*','/']:
			singleop = i
			continue
		var modvalue = i
		if i.find('caster') >= 0 or i.find('self') >= 0:
			i = i.split('.')
			if i[0] == 'caster' or i[0] == 'self':
				#modvalue = str(self[i[1]])
				modvalue = str(get_stat(i[1]))
			elif i[0] == 'target':
				return ""; #nonexistent yet case of skill value being based completely on target
		elif (i.find('random') >= 0):
			i = i.split(' ')
			modvalue = str(globals.rng.randi_range(0, int(i[1])))
		if singleop != '':
			endvalue = input_handler.string_to_math(endvalue, singleop+modvalue)
			singleop = ''
			continue
		if !modvalue[0].is_valid_float():
			if modvalue[0] == '-' && firstrun == true:
				endvalue += float(modvalue)
			else:
				endvalue = input_handler.string_to_math(endvalue, modvalue)
		else:
			endvalue += float(modvalue)
		firstrun = false
	return endvalue


func set_shield(value):
	if shield == value: return
	if value <= 0: process_event(variables.TR_SHIELD_DOWN)
	shield = max(0, value)


func deal_damage(value, source = 'normal'):
#	print(source)
	if npc_reference == 'combat_global': return null
	if has_status('warded') and !has_status('ward'):
		return 0
	var tmp = hp
	if ResourceScripts.game_party.characters.has(self.id) && ResourceScripts.game_globals.invincible_player:
		return 0
	value *= (1.0 - get_stat('damage_reduction')/100.0)
	if source != 'true':
		value *= (1.0 - get_stat('resist_' + source)/100.0)
	value = int(value);
	if value > 0:
		if shield > value:
			self.shield -= value
			return 0
		else:
			value -= shield
			self.shield = 0
		process_event(variables.TR_DMG)
		self.hp -= value
		tmp = tmp - hp
		if displaynode != null:
			displaynode.setup_overlay(source)
		return tmp
	else:
		return heal(-value)


func heal(value):
	var tmp = hp
	value = round(value)
	if value < 0: return deal_damage(-value, 'true')
	self.hp += value
	tmp = hp - tmp
	process_event(variables.TR_HEAL)
	return tmp


func mana_update(value):
	var tmp = mp
	value = round(value)
	self.mp += value
	tmp = mp - tmp
	#maybe better to rigger heal triggers on this
	#process_event(variables.TR_HEAL)
	return tmp


func stat_update(stat, value, is_set = false): #for permanent changes
	if stat == 'hp':
		return heal(value)
	elif stat == 'mp':
		return mana_update(value)
	elif stat == 'base_exp':
		return xp_module.update_exp(value, is_set)
	elif is_set:
		return set_stat(stat, value)
	else: 
		return add_stat(stat, value)


func resurrect(hp_per):
	if !defeated: 
		return
	defeated = false
	hp = int(get_stat('hpmax') * hp_per /100)
	if displaynode != null:
		displaynode.update_hp()
	process_event(variables.TR_RES)
	input_handler.emit_signal('fighter_changed')


func get_manacost_for_skill(skill):
	return skills.get_manacost_for_skill(skill)


func pay_cost(cost):
	for st in cost:
		if st == 'money':
			 ResourceScripts.game_party.money -= cost.money
		elif st == 'mp':
			mp -= int(cost.mp)
			if displaynode != null:
				displaynode.update_mana()
		else: 
			add_stat(st, -cost[st])


func check_cost(cost):
	for st in cost:
		if st == 'money' and ResourceScripts.game_party.money < cost[st]:
			return false
		elif st == 'mp' and mp < int(cost[st]): 
			return false
		elif get_stat(st) < cost[st]: 
			return false
	return true


func check_skill_availability(s_code, target):
	var check = true
	
	var template = Skilldata.get_template(s_code, self)
	var descript = ''
	
	if !check_cost(template.cost):
		descript = get_short_name() + ": " + tr("CANT_PAY_COSTS_LABEL") + "'"
		check = false
	if skills.social_skills_charges.has(s_code) && skills.social_skills_charges[s_code] >= template.charges:
		descript = get_short_name() + ": " + template.name + " - " + tr("NO_CHARGES_LEFT_LABEL") + "."
		check = false
	if template.has('globallimit') && ResourceScripts.game_party.global_skills_used.has(s_code) && ResourceScripts.game_party.global_skills_used[s_code] >= template.globallimit:
		descript = get_short_name() + ": " + tr("CANT_USE_TODAY_LABEL") + "."
		check = false
	
	if !checkreqs(template.reqs):
		check = false
		descript = get_short_name() + ": " + tr("REQS_NOT_MET_LABEL") + "."
	
	if !target.checkreqs(template.targetreqs):
		check = false
		descript = target.get_short_name() + ": " + tr("TARGET_REQS_NOT_MET_LABEL") + "."
	
	return {check = check, descript = descript}


func calculate_linked_chars_by_effect(e_name):
	return effects_pool.get_n_effects_linked_to(id, e_name).size()


func lockpick_chance(): #used for chest opening
	var base_chance = randf()*5+5 #5-10
	var secondary_chance = get_stat('wits')/5 #0-24
	if check_trait('lockpicking'):
		secondary_chance = secondary_chance*4 + (randf()*5+5) #max 101-106
	
	return base_chance + secondary_chance


func fill_ai(data):
	match variables.ai_setup:
		'off':
			ai.set_single_state({})
		'new':
			ai.set_single_state(data)
		'old':
			var newdata = {}
			for arr in data:
				newdata[arr[0]] = arr[1]
			ai.set_single_state(newdata)


func take_virginity(type, partner):
	if get_stat(type + '_virgin_lost') == null:
		set_stat(type + "_virgin_lost", partner)
		if get_stat('metrics_partners').has(partner) == false && partner.begins_with("hid"):
			statlist.update_stat('metrics_partners', partner, 'append')


func add_partner(partner):
	if partner == 'master' && get_stat('metrics_partners').has(ResourceScripts.game_party.get_master().id) == false:
		partner = ResourceScripts.game_party.get_master().id
	if get_stat('metrics_partners').has(partner) == false && partner.begins_with("hid"):
		statlist.update_stat('metrics_partners', partner, 'append')


func get_learned_skills(cat):
	return skills.get_learned_skills(cat)

func get_combat_skills():
	return dyn_stats.get_combat_skills()


func get_social_skills():
	return dyn_stats.get_social_skills()


func get_explore_skills():
	return dyn_stats.get_explore_skills()


func fix_skillpanels():
	skills.fix_skillpanels()

func update_portrait(ragdoll): # for ragdolls
	if !get_stat('dynamic_portrait'):
		return
	if !get_stat('portrait_update'):
		return
	
	var path = 'portrait_' + id
	set_stat('portrait_update', false)
	set_stat('icon_image', variables.portraits_folder + path + '.png')
	ragdoll.save_portrait(path)


func check_portrait():
	var path = get_stat('icon_image')
	if !(path.is_abs_path() or path.is_rel_path()): #portrait is not path - so it must exist
		return true 
	if File.new().file_exists(path): 
		return true
	return false


func update_prt():
	if get_stat("unique") == null or get_stat("player_selected_icon"):
		return
	if get_stat("player_selected_body"):
		return
	var prt_name: String
	var variation = "default"
	if has_work_rule('nudity'):
		variation = "nude"
	if get_stat("unique_variation") != null:
		variation = get_stat("unique_variation")
	
	# check for unique nude portrait for example cali_nude_collar_prt
	if has_work_rule('nudity') and variation != "default":
		if images.portraits.keys().has("%s_%s_%s_prt" % [get_stat("unique"), "nude", variation]):
			variation = "nude_%s" % get_stat("unique_variation")
	
	# check for unique wedding portrait
	if ResourceScripts.game_progress.spouse != null && globals.valuecheck({type = 'has_spouse', check = true}) && !ResourceScripts.game_progress.marriage_completed:
		var spouse_person = characters_pool.get_char_by_id(ResourceScripts.game_progress.spouse)
		if spouse_person.get_stat('unique') == get_stat('unique'):
			variation = "wed"
	
	if get_stat("personality") != "neutral":
		prt_name = "%s_%s_prt_%s" % [get_stat("unique"), variation, get_stat("personality")]
	elif variation == "default":
		prt_name = "%s_prt" % [get_stat("unique")]
	else: # example daisy_maid_prt
		prt_name = "%s_%s_prt" % [get_stat("unique"), variation]
	
	if images.portraits.keys().has(prt_name):
		set_stat('icon_image', images.portraits[prt_name])
#	else:
#		print_debug("Failed to find a %s portrait" % prt_name)
