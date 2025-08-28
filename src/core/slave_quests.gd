extends Node

var quest_data = load("res://assets/data/slave_quests_data.gd").new()
var states = {
	open = 'open',
	active = 'taken',
	failed = 'failed',
	complete = 'complete',
}

#var quest_pool = {}

var old_quests

func regen_quests():
	#clear pool
	old_quests = {}
	var quest_pool = get_quest_pool()
	for fact_id in quest_data.factions.keys():
		old_quests[fact_id] = []
	for quest_id in quest_pool.keys():
		var quest = quest_pool[quest_id]
		if quest.state == states.active: continue
		
		change_faction_rating(quest.faction, -1)
		#check for quest_pool here is only for savegame compatibility
		if quest_data.factions[quest.faction].quest_pool.has(quest.code):
			old_quests[quest.faction].append(quest.code)
		quest_pool.erase(quest_id)
	
	#gen quests per faction
	for fact_id in quest_data.factions:
		var faction = quest_data.factions[fact_id]
		
		#create pool and determine number of quests
		var quest_num = 0
		var gen_array = faction.gen_chance.keys()
		gen_array.sort()
		for i in range(gen_array.size()-1, -1, -1):
			var num = gen_array[i]
			if randf() <= faction.gen_chance[num]:
				quest_num = num
				break
		var gen_pool = faction.quest_pool.duplicate()
		for quest_code in faction.quest_pool:
			if quest_code in old_quests[fact_id]:
				gen_pool.remove(quest_code)
		
		#gen quests
		while quest_num > 0:
			quest_num -= 1
			
			#select quest id
			if gen_pool.empty():
				if old_quests[fact_id].empty():
					break
				gen_pool = old_quests[fact_id]
				old_quests[fact_id] = {}
			var gen_pool_id = randi() % gen_pool.size()
			var quest_code = gen_pool[gen_pool_id]
			gen_pool.remove(gen_pool_id)
			var data = quest_data.quests[quest_code].duplicate()
			
			#check if quest available
			if !globals.checkreqs(data.gen_req):
				quest_num += 1
				continue
			
			#adjust possible reqs
			if faction.has('req_override'):
				for req_type in faction.req_override:
					var new_req = faction.req_override[req_type]
					var overridden = false
					for req_group in [data.slave_req_primary, data.slave_req]:
						for req in req_group:
							if req is Array:
								for true_req in req:
									var success = try_override_req(true_req, new_req, req_type)
									if success: overridden = true
							else:#req is Dict
								var success = try_override_req(req, new_req, req_type)
								if success: overridden = true
					if new_req.has('add_if_none') and !overridden:
						data.slave_req_primary.append(new_req)
			if faction.has('add_slave_req_primary'):
				data.slave_req_primary.append_array(faction.add_slave_req_primary)
			if faction.has('add_slave_req'):
				data.slave_req.append_array(faction.add_slave_req)
			
			#make quest
			var new_quest = {
				code = quest_code,
				name = input_handler.random_from_array(data.namepool),
				descript = data.description,
				time_limit = floor(rand_range(data.time_limit[0], data.time_limit[1] + 0.99)),
				requirements = [{
						code = 'slave_delivery',
						value = floor(rand_range(data.slave_number[0], data.slave_number[1] + 0.99)),
						delivered_slaves = 0,
						statreqs = []
				}],
				state = states.open,
				difficulty = 'easy',#placeholder
				area = 'none',
				faction = fact_id
			}
			
			#add slave reqs
			var req_num = 0
#			var req_conditions = {}
			var modifier = 0.0
			for req_group in [data.slave_req_primary, data.slave_req]:
				if req_num >= data.req_max:
					break
				for raw_req in req_group:
					if req_num >= data.req_max:
						break
					#req (raw_req in context) can be single (Dict) or list (Array)
					#we put it down to array for standardisation, but there are differences
					#that should be kept in mind
					var req_array = raw_req
					if raw_req is Dictionary:
						req_array = [raw_req]
					var req_to_add = []#list of final quest-applicable reqs per this req-to-gen (single or list)
					for req in req_array:
						var available = true
						
						#conditions
#						var added = false
#						var condition
#						var check
#						if req.has('if_true'):
#							condition = req.if_true
#							check = true
#						elif req.has('if_false'):
#							condition = req.if_false
#							check = false
#						if condition:
#							if !req_conditions.has(condition):
#								push_error("slave_req order violation! No condition at %s" % req)
#							else:
#								available = (req_conditions[condition] == check)
						
						#has_req conditions
						if req.has('has_req'):
							available = (has_req(new_quest.requirements[0].statreqs, req.has_req)
								or has_req(req_to_add, req.has_req)) and available
						if req.has('has_no_req'):
							available = !(has_req(new_quest.requirements[0].statreqs, req.has_no_req)
								or has_req(req_to_add, req.has_no_req)) and available
						
						#try to add req
						if available and randf() <= req.chance:
							#make real req list
							var true_reqs
							if req.has('generate_func'):
								if req.generate_func == 'getreq_random_sex_skills':
									#need to call it explicitly as the reqs analysis is required
									#MIND that this req must be checked AFTER any race or sex reqs
									var round_to = 1
									if req.generate_args.size() >= 4:
										round_to = req.generate_args[3]
									true_reqs = getreq_random_sex_skills(
										new_quest.requirements[0].statreqs + req_to_add,
										req.generate_args[0], req.generate_args[1],
										req.generate_args[2], round_to)
								elif has_method(req.generate_func):
									if req.has('generate_args'):
										true_reqs = callv(req.generate_func, req.generate_args)
									else:
										true_reqs = call(req.generate_func)
								else:
									push_error("unexpected generate_reqs")
									true_reqs = {}
							else:#req.has('reqs')
								true_reqs = req.reqs
							if true_reqs is Dictionary:
								true_reqs = [true_reqs]
							
							#special restrictions
							var idx_to_remove = []
							for i in range(true_reqs.size()):
								var to_check = true_reqs[i]
								if to_check.code == "sex" and to_check.operant == "eq":
									if (
											(to_check.value == "female"
											and input_handler.globalsettings.malechance >= 100)
											or
											(to_check.value == "male"
											and input_handler.globalsettings.malechance <= 0)
										):
										if req.chance >= 1.0:
											push_error("quest %s shouldn't be generated with such malechance" % quest_code)
										idx_to_remove.append(i)
							for i in idx_to_remove:
								true_reqs.remove(i)
							
							#really add req
							if !true_reqs.empty():
								req_to_add.append_array(true_reqs)
#								added = true
								if req.has('reward_bonus'):
									modifier += req.reward_bonus
								if req.has('reward_func'):
									if has_method(req.reward_func):
										if req.has('reward_func_args'):
											var args = [true_reqs]
											args.append_array(req.reward_func_args)
											modifier += callv(req.reward_func, args)
										else:
											modifier += call(req.reward_func, true_reqs)
									else:
										push_error("unexpected reward_func")
								
								#stop check inside this req-list (if list) if applicable
								if req.has('stop_on_me'):
									print('stop_on_me for %s in %s' % [quest_code, String(req_array)])
									break
#						if req.has('condition'):
#							req_conditions[req.condition] = added
					if !req_to_add.empty():
						new_quest.requirements[0].statreqs.append_array(req_to_add)
						req_num += 1
			
			#calc reward
			var reward = input_handler.random_from_array(data.rewardpool)
			var num_for_mod = req_num - (variables.SQ_req_num_mod_start - 1)
			if num_for_mod > 0:
				modifier += num_for_mod * variables.SQ_req_num_mod
			var random_mod = rand_range(variables.SQ_random_reword[0], variables.SQ_random_reword[1] + 0.0099)
			random_mod = floor(random_mod * 100) * 0.01
#			print("modifier ", modifier, " random_mod ", random_mod)
			modifier += random_mod
			reward += reward * modifier
			reward += reward * get_faction_dynamic_data(fact_id).price_factor
			new_quest.rewards = [{code = 'gold', value = reward}]
			
			#special rules
			if data.has("special_rule"):
				if !has_method(data.special_rule):
					push_error("No special_rule %s" % data.special_rule)
				else:
					call(data.special_rule, new_quest)
			
			#add to pool
			var new_quest_id = make_quest_id()
			new_quest.id = new_quest_id
			quest_pool[new_quest_id] = new_quest
			print(new_quest.code, " ", new_quest.requirements[0].statreqs)

func make_quest_id():
	var used_ids = get_quest_pool().keys()
	var new_id = 0
	while new_id in used_ids:
		if new_id > 100000:#reinsurance, shouldn't happen
			push_error("new id for slave quest is out of save bounds!")
			return -1
		new_id += 1
	return new_id

func try_override_req(old_req, new_req, req_type) -> bool:
	if !old_req.has('fixed_type') or old_req.fixed_type != req_type:
		return false
	old_req.reqs = new_req.reqs
	old_req.chance = new_req.chance
	return true

func change_faction_rating(faction_id, value):
	var faction = get_faction_dynamic_data(faction_id)
	faction.rating = max(0, faction.rating + value)

func get_quest_pool():
#	return quest_pool
	return ResourceScripts.game_progress.slave_quests.quest_pool

func get_quest(quest_id):
	return get_quest_pool()[quest_id]

func get_faction(fact_id):
	return quest_data.factions[fact_id]

func get_faction_dynamic_data(fact_id):
	var progress = ResourceScripts.game_progress.slave_quests.factions
	if !progress.has(fact_id):#reinsurance, should not happen
		if !quest_data.factions.has(fact_id):
			push_error("get_faction_dynamic_data requests nonexisting faction %s" % fact_id)
		else:
			progress[fact_id] = quest_data.faction_dynamic_data_template.duplicate()
	return progress[fact_id]

func activate_quest(quest_id):
	var quest = get_quest(quest_id)
	quest.state = states.active

#func fail_quest(quest_id):
#	quest_pool[quest_id].state = states.failed

func is_quest_active(quest_id) -> bool:
	return get_quest(quest_id).state == states.active
func is_quest_open(quest_id) -> bool:
	return get_quest(quest_id).state == states.open
func is_quest_failed(quest_id) -> bool:
	return get_quest(quest_id).state == states.failed


#-----------getreq---------------------

#it is different from get_random_sex()
func getreq_sex_by_ratio():
	var sex
	if input_handler.globalsettings.futa and randf() <= input_handler.globalsettings.futachance * 0.01:
		sex = 'futa'
	elif randf() <= input_handler.globalsettings.malechance * 0.01:
		sex = 'male'
	else:
		sex = 'female'
	
	return {code = "sex", operant = "eq", value = sex}

func getreq_random_starting_class(num = 1):
	var class_list = variables.master_starting_classes + variables.slave_starting_classes
	if num > class_list.size():
		push_error("get_random_starting_class has too much classes to gen")
		num = class_list.size()
	var res = []
	for i in range(num):
		var prof_num = randi() % class_list.size()
		res.append({code = "has_profession", check = true, profession = class_list[prof_num]})
		class_list.remove(prof_num)
	return res

func getreq_race_by_tags(tags):
	return {code = "race",
		race = races.get_random_race_by_tags_noweight(tags),
		check = true}

func getreq_random_starting_race():
	return {code = "race",
		race = races.get_random_starting_race(),
		check = true}

func getreq_random_sex_skills(other_reqs, num, val, operant, round_to = 1):
	var array = ['sex_skills_petting',
#		'sex_skills_penetration',
#		'sex_skills_pussy',
		'sex_skills_oral',
		'sex_skills_anal',
#		'sex_skills_tail'
	]
	var res = []
	
	if !has_req(other_reqs, {code = "sex", operant = "eq", value = 'male'}):
		array.append('sex_skills_pussy')
	if !has_req(other_reqs, {code = "sex", operant = "eq", value = 'female'}):
		array.append('sex_skills_penetration')
	var long_tail = false
	for req in other_reqs:
		if req.code == 'race' and req.check:
			if _race_has_long_tail(req.race):
				long_tail = true
		elif req.code == 'one_of_races':
			for race in req.value:
				if _race_has_long_tail(race):
					long_tail = true
	if long_tail:
		array.append('sex_skills_tail')
	
	if num > array.size():
		push_error("getreq_random_sex_skills trys to gen more skills than possible")
		num = array.size()
	for i in range(num):
		var idx = randi() % array.size()
		var stat = array[idx]
		if val is Array:
			res.append(getreq_roll_stat(stat, val, operant, round_to))
		else:
			res.append({code = "stat", stat = stat, operant = operant, value = val})
		array.remove(idx)
	return res

func _race_has_long_tail(race):
	if !races.racelist[race].bodyparts.has('tail'):
		return false
	for tail in races.racelist[race].bodyparts.tail:
		if tail in variables.longtails:
			return true
	return false

func getreq_random_from_array(array_raw, num):
	var array = array_raw.duplicate()
	var res = []
	if num > array.size():
		push_error('getreq_random_from_array num > array size')
		num = array.size()
	for i in range(num):
		var id = randi() % array.size()
		res.append(array[id])
		array.remove(id)
	return res

func getreq_roll_stat(stat, val_range, operant, round_to = 1):
	var value = int(rand_range(val_range[0], val_range[1] + (round_to - 0.01)))
	if round_to > 1:
		value -= value % round_to
	
	return {code = "stat", stat = stat, operant = operant, value = value}

func getreq_roll_random_stats(stats, num, val_range, operant, round_to = 1):
	var array = stats.duplicate()
	var res = []
	if num > array.size():
		push_error('getreq_roll_random_stats num > array size')
		num = array.size()
	for i in range(num):
		var idx = randi() % array.size()
		res.append(getreq_roll_stat(array[idx], val_range, operant, round_to))
		array.remove(idx)
	return res

#modifies input dict!
func getreq_fill_param_random_from_array(dict, param, array, num):
	dict[param].append_array(getreq_random_from_array(array, num))
	return dict

#-----------reward rules--------

func getrwd_race_tag(reqs_raw, tag, bonus):
	var reqs = reqs_raw
	if reqs_raw is Dictionary:
		reqs = [reqs_raw]
	for req in reqs:
		if req.code == 'race' and req.check:
			if tag in races.racelist[req.race].race_tags:
				return bonus
		elif req.code == 'one_of_races':
			for race in req.value:
				if tag in races.racelist[race].race_tags:
					return bonus
	return 0.0

#-----------special rules--------
func spec_rename_maid(quest_dict):
	if has_req(quest_dict.requirements[0].statreqs, {code = "sex", value = "male"}):
		quest_dict.name = "SQ_LACKEY_NAME1"
		quest_dict.descript = "SQ_LACKEY_DESC"
		#!!!!!!!!check if this will work!!!!!!!!!
		for req in quest_dict.requirements[0].statreqs:
			if req.code == 'has_profession' and req.profession == 'maid':
				req.description = "is_male"

#--------------------------

func has_req(reqs, to_check_raw):
	var to_check = to_check_raw
	if to_check_raw is Dictionary:
		to_check = [to_check_raw]
	var res
	for check in to_check:
		var check_res = false
		for req in reqs:
			var key_res = true
			for key in check:
				if (!req.has(key)
						or typeof(req[key]) != typeof(check[key])
						or req[key] != check[key]):
					key_res = false
			if key_res:
				check_res = true
				break
		if res == null:
			res = check_res
		elif check.has('orflag'):
			res = res or check_res
		else:
			res = res and check_res
	if res == null:
		return false
	return res


func fix_serialization():
	var progress = ResourceScripts.game_progress.slave_quests
	for str_id in progress.quest_pool.keys():
		progress.quest_pool[int(str_id)] = progress.quest_pool[str_id]
		progress.quest_pool.erase(str_id)
	var existing_factions = quest_data.factions.keys()
	var dynamic_data_template = quest_data.faction_dynamic_data_template
	for fact_id in progress.factions.keys():
		if existing_factions.has(fact_id):
			existing_factions.erase(fact_id)
			var existing_params = dynamic_data_template.keys()
			for param in progress.factions[fact_id].keys():
				if existing_params.has(param):
					existing_params.erase(param)
				else:
					progress.factions[fact_id].erase(param)
			for param in existing_params:
				progress.factions[fact_id][param] = dynamic_data_template[param]
		else:
			progress.factions.erase(fact_id)
	for fact_id in existing_factions:
		progress.factions[fact_id] = dynamic_data_template.duplicate()
