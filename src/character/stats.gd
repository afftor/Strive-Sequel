extends Reference

var statlist = Statlist_init.template.duplicate() setget custom_stats_set#, custom_stats_get
var bonuses = {}
var traits = []
var sex_traits = []
var negative_sex_traits = []
var unlocked_sex_traits = []
var parent = null

func _init():
	pass

func custom_stats_set(value):
	statlist = value.duplicate(true)
#	if value.has(''):
#		statlist[''] = 
	for st in ['loyalty', 'submission']:
		if value.has(st):
			statlist[st] = clamp(value[st], 0, 100)
	for st in ['physics', 'wits', 'charm', 'sexuals']: #not sure about sexuals since its getter has no reference to original value
		if value.has(st):
			statlist[st] = min(value[st], statlist[st + '_factor'] * 20)
	for st in ['physics', 'magic', 'tame', 'timid', 'growth', 'wits', 'charm', 'sexuals']:
		if value.has(st+'_factor'):
			statlist[st+'_factor'] = clamp(value[st+'_factor'], variables.minimum_factor_value, variables.maximum_factor_value)
	if value.has('lust'):
		statlist.lustmax = 25 + statlist.sexuals_factor * 25
		statlist.lust = clamp(value.lust, 0, statlist.lustmax)


func custom_stats_get():
	var res = statlist.duplicate(true)
#	if res.has(''):
#		res[''] = 
	if res.has('sexuals'):
		var array = statlist.sex_skills.values()
		array.sort()
		array.invert()
		res['sexuals'] = (array[0] + array[1] + array[2])/3
	if res.has('hpmax'):
		if statlist.is_person == true:
			var tres = variables.basic_max_hp
			if bonuses.has('hpmax_add'): tres += bonuses.hpmax_add
			if statlist.race != '':
				var race = statlist.race
				if variables.new_stat_bonuses_syntax == true:
					if bonuses.has('hpfactor'): tres *= bonuses['hpfactor']
				else:
					if races.racelist[race].race_bonus.has('hpfactor'):tres *= races.racelist[race].race_bonus.hpfactor
			if bonuses.has('hp_flat_bonus'): tres += bonuses.hp_flat_bonus
			if bonuses.has('hpmax_mul'): tres *= bonuses.hpmax_mul
			res['hp_max'] = tres
	if res.has('mpmax'):
		var tres = variables.basic_max_mp + variables.max_mp_per_magic_factor * statlist.magic_factor
		if bonuses.has('mpmax_add'): tres += bonuses.mpmax_add
		if bonuses.has('mpmax_mul'): tres *= bonuses.mpmax_mul
		res['mpmax'] = tres
	if res.has('resists'):
		var tres = res.resists
		for r in variables.resists_list:
			if bonuses.has('resist' + r + '_add'): tres[r] += bonuses['resist' + r + '_add']
			if bonuses.has('resist' + r + '_mul'): tres[r] *= bonuses['resist' + r + '_mul']
		res.resists = tres
	if res.has('status_resists'):
		var tres = res.status_resists
		for r in variables.status_list:
			if bonuses.has('resist' + r + '_add'): tres[r] += bonuses['resist' + r + '_add']
			if bonuses.has('resist' + r + '_mul'): tres[r] *= bonuses['resist' + r + '_mul']
		res.status_resists = tres
	if res.has('damage_mods'):
		var tres = res.damage_mods
		for r in variables.mods_list:
			if bonuses.has('mod' + r + '_add'): tres[r] += bonuses['mod' + r + '_add']
			if bonuses.has('mod' + r + '_mul'): tres[r] *= bonuses['mod' + r + '_mul']
		res.damage_mods = tres
	return res

func get_short_name():
	var text = ''
	if statlist.nickname == '':
		text = statlist.name
	else:
		text = statlist.nickname
	return text

func get_full_name():
	var text = ''
	if statlist.nickname == '':
		text = statlist.name + ' ' + statlist.surname
	else:
		text = statlist.name + ' "' + statlist.nickname + '" ' + statlist.surname
	return text

func set_stat(stat, value): #for direct access only
	 self.statlist[stat] = value

#bonus system
func get_stat(statname, ref = false):
	var tmp
	if ref: tmp = statlist
	else:  tmp = custom_stats_get()
	if !tmp.has(statname): return null
	var res = tmp[statname]
	if variables.bonuses_stat_list.has(statname):
		if bonuses.has(statname + '_add'): res += bonuses[statname + '_add']
		if bonuses.has(statname + '_mul'): res *= bonuses[statname + '_mul']
	elif statname in ['physics','wits','charm','sexuals']:
		res = tmp[statname] + tmp[statname + '_bonus']
	return res

func add_stat_bonuses(ls:Dictionary):
	if variables.new_stat_bonuses_syntax:
		for rec in ls:
			add_bonus(rec, ls[rec])
	else:
		for rec in ls:
			if (rec as String).begins_with('resist') or (rec as String).begins_with('mod'):
				add_bonus(rec + '_add', ls[rec])
				continue
			if (rec as String).ends_with('mod') && rec as String != 'critmod' :
				add_bonus(rec.replace('mod','_mul'), ls[rec])
				continue
			if !statlist.has(rec):
			#safe variant
			#add_bonus(rec, ls[rec])
				continue
			add_stat(rec, ls[rec])

func remove_stat_bonuses(ls:Dictionary):
	if variables.new_stat_bonuses_syntax:
		for rec in ls:
			add_bonus(rec, ls[rec], true)
	else:
		for rec in ls:
			if (rec as String).begins_with('resist') or (rec as String).begins_with('mod'):
				add_bonus(rec + '_add', ls[rec], true)
				continue
			if (rec as String).ends_with('mod') && rec as String != 'critmod' :
				add_bonus(rec.replace('mod','_mul'), ls[rec], true)
				continue
			if !statlist.has(rec): continue
			add_stat(rec, ls[rec], true)

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
			print('error bonus not found')
		else:
			#if b_rec.ends_with('_add'): bonuses[b_rec] = value
			if b_rec.ends_with('_mul'): bonuses[b_rec] = 1.0 + value
			else: bonuses[b_rec] = value
	parent.recheck_effect_tag('recheck_stats')

func add_stat(statname, value, revert = false):
	if variables.direct_access_stat_list.has(statname):
		if revert: self.statlist[statname] = statlist[statname] - value
		else: self.statlist[statname] = statlist[statname] + value
	else:
		add_bonus(statname+'_add', value, revert)

func mul_stat(statname, value, revert = false):
	if variables.direct_access_stat_list.has(statname):
		if revert: self.statlist[statname] = statlist[statname] / value
		else: self.statlist[statname] = statlist[statname] * value
	else:
		if bonuses.has(statname + '_mul'):
			if revert:
				bonuses[statname + '_mul'] /= value
				if bonuses[statname + '_mul'] == 1:
					bonuses.erase(statname + '_mul')
			else: bonuses[statname + '_mul'] *= value
		else:
			if revert: print('error bonus not found')
			else: bonuses[statname + '_mul'] = value

func add_part_stat(statname, value, revert = false):
	if variables.direct_access_stat_list.has(statname):
		if revert: self.statlist[statname] = statlist[statname] /(1.0 + value)
		else: self.statlist[statname] = statlist[statname] * (1.0 + value)
	else:
		add_bonus(statname+'_mul', value, revert)


func stat_update(stat, value, is_set = false): #for permanent changes
	var tmp = statlist[stat]
	value = round(value)
	if !is_set: add_stat(stat, value)
	else: set_stat(stat, value)
	if tmp != null: tmp = get_stat(stat) - tmp
	else:  tmp = get_stat(stat)
	return tmp

#traits
func add_trait(tr_code):
	var trait = Traitdata.traits[tr_code]
	if traits.has(tr_code): return
	traits.push_back(tr_code)
	for e in trait.effects:
		var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table[e])
		parent.apply_effect(effects_pool.add_effect(eff))
		eff.set_args('trait', tr_code)
	if tr_code == 'undead':
		parent.food.food_consumption = 0
		statlist.charm -= 100
#		statlist.sexuals -= 50 
		statlist.resists['dark'] += 50
		statlist.resists['light'] -= 50
		parent.food.food_consumption_rations = false
		if parent.get_static_effect_by_code("work_rule_ration") != null:
			parent.emove_static_effect_by_code('work_rule_ration')
	parent.recheck_effect_tag('recheck_trait')

func remove_trait(tr_code):
	var trait = Traitdata.traits[tr_code]
	if !traits.has(tr_code): return
	traits.erase(tr_code)
	var arr = parent.find_eff_by_trait(tr_code)
	for e in arr:
		var eff = effects_pool.get_effect_by_id(e)
		eff.remove()
	parent.recheck_effect_tag('recheck_trait')

func check_trait(trait):
	return (traits.has(trait) or sex_traits.has(trait) or negative_sex_traits.has(trait))

func add_negative_sex_trait(code):
	negative_sex_traits.push_back(code)

func remove_negative_sex_trait(code):
	negative_sex_traits.erase(code)

func add_sex_trait(code):
	if !unlocked_sex_traits.has(code):
		unlocked_sex_traits.push_back(code)
	if !sex_traits.has(code):
		sex_traits.push_back(code)
		var text = get_short_name() + ": " + "New Sexual Trait Acquired - " + Traitdata.sex_traits[code].name
		globals.text_log_add('char', text)

func remove_sex_trait(code, absolute = true):
	if absolute: unlocked_sex_traits.erase(code)
	sex_traits.erase(code)

func unlock_sex_trait(code):
	unlocked_sex_traits.push_back(code)

func create_s_trait_select(trait):
	if sex_traits.has(trait.code):
		sex_traits.erase(trait.code)
		unlocked_sex_traits.erase(trait.code)
	else:
		sex_traits.clear()
		unlocked_sex_traits.clear()
		sex_traits.append(trait.code)

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
	if parent.has_status('banish'): return -1.0
	var rate = statlist.hp * 1.0 / self.statlist.hpmax
	if rate < 0.2: return 1.0
	if rate < 0.4: return 0.5
	if rate < 0.6: return 0.0
	if rate < 0.8: return -0.5
	return -1.0

#generating char stuff
func fill_masternoun():
	if parent.has_profession('master'):
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
		if !(i in ['code','class_category', 'slave_class']):
			statlist[i] = chardata[i]
	if chardata.has('slave_class'): set_slave_category(chardata.slave_class)

func generate_random_character_from_data(races, desired_class = null, adjust_difficulty = 0):
	var gendata = {race = '', sex = 'random', age = 'random'}
	
	if typeof(races) == TYPE_STRING && races == 'random':
		gendata.race = statlist.get_random_race()
	elif typeof(races) == TYPE_STRING:
		gendata.race = races
	else:
		gendata.race = races[randi()%races.size()]
	#figuring out the race
	
	parent.create(gendata.race, gendata.sex, gendata.age)
	
	if randf() <= 0.003:
		desired_class = parent.generate_ea_character(gendata, desired_class)
	
	var slaveclass = desired_class
	if slaveclass == null:
		slaveclass = input_handler.weightedrandom([['combat', 1],['magic', 1],['social', 1],['sexual',1], ['labor',1]])
	
	if slaveclass == 'magic' && statlist.magic_factor == 1: #prevents finding no class as there's no magic base classes which allow magic factor < 2
		statlist.magic_factor = 2
	
	var difficulty = int(round(adjust_difficulty))
	var classcounter = round(rand_range(variables.slave_classes_per_difficulty[difficulty][0], variables.slave_classes_per_difficulty[difficulty][1]))
	
	#Add extra stats for harder characters
	while difficulty > 1:
		var array = []
		if randf() >= 0.75:
			array = ['physics_factor', 'magic_factor', 'wits_factor', 'timid_factor', 'sexuals_factor', 'charm_factor']
		else:
			match slaveclass:
				'combat':
					array = ['physics_factor']
				'magic':
					array = ['wits_factor', 'magic_factor']
				'social', 'sexual':
					array = ['tame_factor', 'charm_factor', 'sexuals_factor']
				'labor':
					array = ['physics_factor', 'wits_factor']
		array = array[randi()%array.size()]
		statlist.statlist[array] += 1#initial setup direct access
		difficulty -= 1
	difficulty = adjust_difficulty
	while difficulty > -1:
		var array = []
		if randf() >= 0.75:
			array = ['physics', 'wits','sexuals', 'charm']
		else:
			match slaveclass:
				'combat':
					array = ['physics']
				'magic':
					array = ['wits']
				'social', 'sexual':
					array = ['charm', 'sexuals']#can't get it since sexuals cant be increased directly
				'labor':
					array = ['physics', 'wits']
		array = array[randi()%array.size()]
		statlist[array] += rand_range(1,15)#initial setup direct access
		difficulty -= 1
	
	#assign classes
	while classcounter > 0:
		if randf() > 0.65:
			classcounter -= 1
			continue
		var classarray = []
		if randf() >= 0.85:
			classarray = parent.get_class_list('any', parent)
		else:
			classarray = parent.get_class_list(slaveclass, parent)
		if classarray != null && classarray.size() > 0:
			parent.unlock_class(classarray[randi()%classarray.size()].code, true)
		classcounter -= 1
	
	var traitarray = []
	#assign traits
	for i in Traitdata.sex_traits.values():
		if i.negative == true && i.random_generation == true && parent.checkreqs(i.acquire_reqs) == true:
			traitarray.append(i)
	var rolls = 2
	while rolls > 0:
		var number = randi()%traitarray.size()
		var newtrait = traitarray[number]
		parent.add_negative_sex_trait(newtrait.code)
		traitarray.remove(number)
		rolls -= 1
	traitarray.clear()
	rolls = 1
	for i in Traitdata.sex_traits.values():
		if i.negative == false && i.random_generation == true && parent.checkreqs(i.acquire_reqs) == true:
			traitarray.append(i)
	while rolls > 0:
		var number = randi()%traitarray.size()
		var newtrait = traitarray[number]
		parent.add_sex_trait(newtrait.code)
		traitarray.remove(number)
		rolls -= 1


func generate_simple_fighter(data):
	for i in variables.fighter_stats_list:
		if data.has(i) == false:
			set(i, 0)
		else:
			set(i, data[i])
	statlist.icon_image = data.icon
	statlist.body_image = data.body
#	statlist.combat_skills = data.skills 
#	if !data.skills.has("ranged_attack"):
#		combat_skills += ['attack']
	parent.npc_reference = data.code
	statlist.is_person = false
	statlist.xpreward = data.xpreward
	statlist.loottable = data.loot
	statlist.name = data.name
	statlist.racegroup = data.race
	for i in variables.resists_list:
		statlist.resists[i] = 0
		if data.resists.has(i):
			statlist.resists[i] = data.resists[i]
	for i in variables.status_list:
		statlist.status_resists[i] = 0
		if data.has('status_resists') && data.status_resists.has(i):
			statlist.status_resists[i] = data.status_resists[i]
	for i in variables.mods_list:
		statlist.damage_mods[i] = 1.0
#	if data.has('effects'):
#		for e in data.effects:
#			var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table[e])
#			apply_effect(effects_pool.add_effect(eff))

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
	parent.create(temp_race, 'random', 'teen')
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
	statlist.relatives.mother = mother.id
	statlist.relatives.father = father.id
	baby_transform()
	var pregdata = {}
	pregdata.baby = parent.id
	pregdata.duration = variables.pregduration
	mother.set_stat('', pregdata.duplicate())
	ResourceScripts.game_party.babies[parent.id] = parent

func create(temp_race, temp_gender, temp_age):
	
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
	
	for i in variables.resists_list:
		statlist.resists[i] = 0
	for i in variables.status_list:
		statlist.status_resists[i] = 0
	for i in variables.mods_list:
		statlist.damage_mods[i] = 1.0
	
	get_sex_features()
	
	if input_handler.globalsettings.furry == false && statlist.race.find("Beastkin") >= 0:
		statlist.race = statlist.race.replace("Beastkin","Halfkin")
	
	get_racial_features()
	get_random_name()
	random_icon()
	
	statlist.personality = variables.personality_array[randi()%variables.personality_array.size()]
	
	for i in ResourceScripts.descriptions.bodypartsdata:
		if ResourceScripts.descriptions.bodypartsdata[i].has(statlist[i]):
			if ResourceScripts.descriptions.bodypartsdata[i][statlist[i]].bodychanges.size() > 0:
				apply_custom_bodychange(i, statlist[i])
#	add_trait('core_trait')
#	learn_c_skill('attack')
	parent.hp = get_stat('hpmax')
	parent.mp = get_stat('mpmax')

func get_racial_features():
	var race_template = races.racelist[statlist.race]
	for i in race_template.basestats:
		self.set(i, round(rand_range(race_template.basestats[i][0], race_template.basestats[i][1]))) #1 - terrible, 2 - bad, 3 - average, 4 - good, 5 - great, 6 - superb
	
	add_stat_bonuses(race_template.race_bonus)
	for i in races.racelist.Human.bodyparts:
		if typeof(races.racelist.Human.bodyparts[i][0]) == TYPE_STRING:
			self.set(i, races.racelist.Human.bodyparts[i][randi()%races.racelist.Human.bodyparts[i].size()])
		else:
			self.set(i, input_handler.weightedrandom(races.racelist.Human.bodyparts[i]))
	for i in race_template.bodyparts:
		if typeof(race_template.bodyparts[i][0]) == TYPE_STRING:
			self.set(i, race_template.bodyparts[i][randi()%race_template.bodyparts[i].size()])
		else:
			self.set(i, input_handler.weightedrandom(race_template.bodyparts[i]))
	
	if race_template.tags.has("multibreasts") && input_handler.globalsettings.furry_multiple_nipples == true:
		statlist.multiple_tits = variables.furry_multiple_nipples_number
	
	parent.food.get_racial_features(statlist.race)
	
	var array = []
	if race_template.has('personality'):
		for i in race_template.personality:
			array.append([i, race_template.personality[i]])
		statlist.personality = input_handler.weightedrandom(array)

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

func apply_custom_bodychange(target, part):
	statlist[target] = part
	for i in ResourceScripts.descriptions.bodypartsdata[target][part].bodychanges:
		if parent.checkreqs(i.reqs) == true:
			var newvalue = i.value
			if typeof(newvalue) == TYPE_ARRAY:
				if typeof(newvalue[0]) == TYPE_ARRAY:
					newvalue = input_handler.weightedrandom(newvalue)
				else:
					newvalue = newvalue[randi()%newvalue.size()]
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

func get_random_name():
	var text = statlist.race.to_lower() + statlist.sex.replace("futa",'female')
	if !Namedata.namelist.has(text):
		text = 'human'+ statlist.sex.replace("futa",'female')
	statlist.name = Namedata.namelist[text][randi() % Namedata.namelist[text].size()]
	if Namedata.namelist.has(statlist.race.to_lower() + 'surname'):
		statlist.surname = Namedata.namelist[statlist.race.to_lower() + "surname"][randi() % Namedata.namelist[statlist.race.to_lower() + "surname"].size()]
	elif statlist.race.find("Halfkin") >= 0 || statlist.race.find("Beastkin") >= 0:
		statlist.surname = Namedata.getRandomFurrySurname()

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

func get_icon():
	if statlist.icon_image in ['', null]:
		return null
	return input_handler.loadimage(statlist.icon_image, 'portraits')

func get_icon_path():
	if typeof(statlist.icon_image) != TYPE_STRING:
		return null
	if statlist.icon_image in ['', null]:
		return ""
	return statlist.icon_image

func get_body_image():
	var tmp = input_handler.loadimage(statlist.body_image, 'shades')
	if tmp != null: return tmp
	if statlist.body_image == 'default' or statlist.body_image == '' or statlist.body_image == null:
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
	return sex_traits + negative_sex_traits

func get_negative_sex_traits():
	return negative_sex_traits

func get_unlocked_sex_traits():
	return unlocked_sex_traits

func baby_transform():
	var mother = ResourceScripts.game_party.characters[statlist.relatives.mother]
	statlist.name = 'Child of ' + mother.get_stat('name')
	if mother.get_stat('surname') != '':
		statlist.name += " " + mother.get_stat('surname')
	if mother.get_stat('slave_class') != 'master':
		statlist.slave_class = mother.get_stat('slave_class')
	else:
		statlist.slave_class = 'slave'
	statlist.surname = ''
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
	statlist.lust += get_stat('lusttick')
#	if !parent.has_status('no_obed_reduce'):
#		statlist.obedience -= get_stat('obed_reduce')
#	if !parent.has_status('no_fear_reduce'):
#		statlist.fear -= get_stat('fear_reduce')
	if statlist.loyalty < 100.0 && !parent.has_status('no_loyal_reduction'):
		statlist.loyalty -= (12.0-1*get_stat('tame_factor')/24) * get_stat('loyalty_degrade_mod')
	if statlist.submission < 100.0:
		statlist.submission -= (12.0-1*get_stat('timid_factor')/24) * get_stat('submission_degrade_mod')
	if statlist.pregnancy.duration > 0 && statlist.pregnancy.baby != null:
		statlist.pregnancy.duration -= 1
		if statlist.pregnancy.duration == 0:
			input_handler.interactive_message('childbirth', 'childbirth', {pregchar = parent})
	

func is_uncontrollable():
	return statlist.obedience <= 0 && statlist.loyalty < 100 && statlist.submission < 100

func is_controllable():#not sure - either this or previous is wrong cause of obedience check
	return statlist.loyalty >= 100 || statlist.submission >= 100

func translate(text):
	var rtext = ''
	text = text.replace("[He]", globals.fastif(statlist.sex == 'male', 'He', 'She'))
	text = text.replace("[he]", globals.fastif(statlist.sex == 'male', 'he', 'she'))
	text = text.replace("[his]", globals.fastif(statlist.sex == 'male', 'his', 'her'))
	text = text.replace("[him]", globals.fastif(statlist.sex == 'male', 'him', 'her'))
	text = text.replace("[His]", globals.fastif(statlist.sex == 'male', 'His', 'Her'))
	text = text.replace("[Sir]", globals.fastif(statlist.sex == 'male', 'Sir', 'Miss'))
	text = text.replace("[raceadj]", races.racelist[statlist.race].adjective)
	text = text.replace("[race]", races.racelist[statlist.race].name)
	text = text.replace("[name]", get_short_name())
	text = text.replace("[surname]",globals.fastif(statlist.surname != '', statlist.surname, get_short_name()))
	text = text.replace("[age]", statlist.age.capitalize())
	text = text.replace("[male]", statlist.sex)
	text = text.replace("[eye_color]", statlist.eye_color)
	text = text.replace("[hair_color]", statlist.hair_color)
	text = text.replace("[man]", globals.fastif(statlist.sex == 'male', 'man', 'woman'))
	
#	var masternoun = 'master'
	var tempmasternoun = statlist.masternoun
	if tempmasternoun in ['master','mistress']:
		if input_handler.meowingcondition(parent) == true:tempmasternoun = 'myaster'
		if ResourceScripts.game_party.get_master() != null && ResourceScripts.game_party.get_master().get_stat('sex') != 'male':
			if input_handler.meowingcondition(parent) == true:tempmasternoun = 'mewstress'
	
	text = text.replace("[master]", tempmasternoun)
	text = text.replace("[Master]", tempmasternoun.capitalize())
	
	match statlist.sex:
		'male':
			rtext = 'boy'
		'female':
			rtext = 'girl'
		'futa':
			rtext = 'futanari'
	text = text.replace("[boy_]", rtext)
	text = text.replace("[boy]", globals.fastif(statlist.sex == 'male', 'boy', 'girl'))
	return text
