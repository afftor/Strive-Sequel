extends "res://src/character/ch_jobs.gd"

var base_exp = 0 setget base_exp_set
var professions = []
var prof_links = {}
var abil_exp = 0

var sleep = ''
var work = ''
var previous_work = ''
var workproduct = null
var previous_workproduct = null
var previous_location = ResourceScripts.game_world.mansion_location
var work_rules = {ration = false, shifts = false, constrain = false, luxury = false, contraceptive = false, bindings = false, nudity = false, personality_lock = false, masturbation = false}
var brothel_rules = {
		waitress = true,
		hostess = false,
		dancer = false,
		stripper = false,
		
		petting = false,
		oral = false,
		anal = false,
		pussy = false,
		group = false,
		sextoy = false,
		
		males = true,
		females = false,
		futa = false
	}

var farming_rules = {
	
}

var service_boosters = {} 

var messages = []


var is_on_quest = false
var quest_id
var quest_time_remains = 0
var quest_time_init = 0
#var selected_work_quest = null


func _init():
	fix_rules()


func fix_rules():
	for rule in variables.work_rules:
		if !work_rules.has(rule):
			work_rules[rule] = false
	for rule in variables.brothel_rules:
		if !brothel_rules.has(rule):
			brothel_rules[rule] = false
	for rule in variables.farming_rules:
		if !farming_rules.has(rule):
			farming_rules[rule] = false


func check_work_rule(rule):
	if !variables.work_rules.has(rule):
		return false
	if !work_rules.has(rule):
		print("warning - work rule %s removed" % rule)
		return false
	return work_rules[rule]


func set_work_rule(rule, value):
	if variables.work_rules.has(rule):
		work_rules[rule] = value
	#possibly move those effects to dynamic later
	if !Effectdata.effect_table.has("work_rule_" + rule): return
	match value:
		true:
			var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table["work_rule_" + rule])
			parent.get_ref().apply_effect(effects_pool.add_effect(eff))
		false:
			parent.get_ref().remove_static_effect_by_code("work_rule_" + rule)

func check_brothel_rule(rule):
	if !variables.brothel_rules.has(rule):
		return false
	if !brothel_rules.has(rule):
		print("warning - brothel rule %s removed" % rule)
		return false
	return brothel_rules[rule]


func set_brothel_rule(rule, value):
	if variables.brothel_rules.has(rule):
		brothel_rules[rule] = value


func set_farm_res(res, value):
	if variables.farming_rules.has(res):
		farming_rules[res] = value
		if value and work == 'produce':
			assign_to_farm_task(res)


func check_farm_res(res):
	if !variables.farming_rules.has(res):
		return false
	if !farming_rules.has(res):
		return false
	return farming_rules[res]


func set_service_boost(value = null):
	var tvalue
	if value != null:
		tvalue = value.duplicate()
	else:
		tvalue = []
		for tier_res in variables.booster_tiers.values():
			tvalue.push_back(input_handler.random_from_array(tier_res))
	for id in range(1, 4):
		service_boosters['boost%d' % id] = {res = tvalue[id - 1], value = false}


func base_exp_set(value):
	if value >= get_next_class_exp() && base_exp < get_next_class_exp():
		input_handler.add_random_chat_message(parent.get_ref(), 'exp_for_level')
		# input_handler.ActivateTutorial("levelup")
	base_exp = value


func update_exp(value, is_set):
	if is_set:
		self.base_exp = value
		return value
	else:
		var tmp = base_exp
		self.base_exp += value
		tmp = base_exp - tmp
		return tmp


func fix_serialize():
	if parent.get_ref().travel.travel_time <= 0 and work == 'travel':
		work = ''
	var newprofs = []
	for prof in professions.duplicate():
		if classesdata.professions.has(prof): continue
		professions.erase(prof)
		for id in prof_links.keys():
			if prof_links[id].has(prof):
				prof_links[id].erase(prof)
				if prof_links[id].empty():
					prof_links.erase(id)
					if id.begins_with('t_'):
						parent.get_ref().remove_trait(id.trim_prefix('t_'))
					else:
						parent.get_ref().unlearn_c_skill(id.trim_prefix('t_'))
						parent.get_ref().unlearn_skill(id.trim_prefix('t_'))
		if prof == 'healer':
			newprofs.push_back('acolyte') 
	for prof in newprofs:
		unlock_class(prof)


func fix_import():
	is_on_quest = false
	work = ''
	workproduct = null
	previous_work = ''

#professions
func has_status(status):
	for tr in professions:
		var profdata = classesdata.professions[tr]
		if profdata.has('tags') and profdata.tags.has(status):
			return true
	return false


func process_chardata(data):
	if data.has('classes'):
		for prof in data.classes:
			unlock_class(prof)


func get_prof_number():
	var tres = professions.size()
	if professions.has("master") or professions.has('spouse'): tres -= 1
	return tres


func get_next_class_exp():
	var currentclassnumber = professions.size()
	if professions.has("master") or professions.has('spouse'): currentclassnumber -= 1
	var exparray = variables.hard_level_reqs
	var value = 0
	if exparray.size()-1 < currentclassnumber:
		value = exparray[exparray.size()-1]
	else:
		value = exparray[currentclassnumber]
	return value

func get_class_list(category, person):
	var array = []
	for i in classesdata.professions.values():
		if (category != 'any' && i.categories.has(category) == false) || professions.has(i.code) == true:
			continue
		if parent.get_ref().checkreqs(i.reqs, true) == true:
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
	professions.append(prof.code)
	parent.get_ref().add_stat_bonuses(prof.statchanges)
	for i in prof.skills:
		if prof_links.has('s_'+i):
			prof_links['s_'+ i].push_back(prof.code)
		else:
			prof_links['s_'+ i] = [prof.code]
			parent.get_ref().learn_skill(i, true)
	for i in prof.combatskills:
		if prof_links.has('s_'+i):
			prof_links['s_'+ i].push_back(prof.code)
		else:
			prof_links['s_'+ i] = [prof.code]
			parent.get_ref().learn_c_skill(i, true)
	for i in prof.traits:
		if prof_links.has('t_'+i):
			prof_links['t_'+ i].push_back(prof.code)
		else:
			prof_links['t_'+ i] = [prof.code]
			parent.get_ref().add_trait(i)
	parent.get_ref().recheck_effect_tag('recheck_class')

func remove_class(prof):
	prof = classesdata.professions[prof]
	if !professions.has(prof.code):
		return "Nothing to remove"
	professions.erase(prof.code)
	parent.get_ref().remove_stat_bonuses(prof.statchanges)
	for i in prof.skills:
		if prof_links['s_' + i].size() == 1:
			if prof_links['s_' + i][0] == prof.code:
				parent.get_ref().unlearn_skill(i)
				prof_links.erase('s_' + i)
			else:
				print('WARNING! error in prof dependancy')
		else:
			prof_links['s_' + i].erase(prof.code)
	for i in prof.combatskills:
		if prof_links['s_' + i].size() == 1:
			if prof_links['s_' + i][0] == prof.code:
				parent.get_ref().unlearn_c_skill(i)
				prof_links.erase('s_' + i)
			else:
				print('WARNING! error in prof dependancy')
		else:
			prof_links['s_' + i].erase(prof.code)
	for i in prof.traits:
		if prof_links['t_' + i].size() == 1:
			if prof_links['t_' + i][0] == prof.code:
				parent.get_ref().remove_trait(i)
				prof_links.erase('t_' + i)
			else:
				print('WARNING! error in prof dependancy')
		else:
			prof_links['t_' + i].erase(prof.code)
	parent.get_ref().recheck_effect_tag('recheck_class')

func remove_all_classes():
	for i in classesdata.professions:
		if !variables.permanent_classes.has(i):
			remove_class(i)

func check_skill_prof(skill):
	for i in professions:
		var tempprof = classesdata.professions[i]
		if tempprof.skills.has(skill):
			return true
	return false

#tasks
func clean_prev_data():
	previous_work = ''
	previous_workproduct = null
	previous_location = ResourceScripts.game_world.mansion_location


func save_prev_data():
	previous_work = work
	previous_workproduct = workproduct
	previous_location = parent.get_ref().get_location()


func check_prev_data():
	if previous_location != parent.get_ref().get_location():
		return false
	if find_worktask(previous_location, previous_work, previous_workproduct) == null:
		return false
	return true


func find_worktask(loc, task = work, prod = workproduct):
	for i in ResourceScripts.game_party.active_tasks:
		if i.task_location != loc:
			continue
		if i.code != task:
			continue
		if i.product != prod:
			continue
		if i.code == 'special' and !i.workers.has(parent.get_ref().id):
			continue
		return i
	return null


func check_task(task): #not check actual work, only data consistency
	if task.task_location != parent.get_ref().get_location():
		return false
	if task.code != work:
		return false
	if task.product != workproduct:
		return false
	return true


func assign_to_task(taskcode, taskproduct):
	#remove existing work
	
	remove_from_task()
	if taskcode == '':
		work = ''
		return
	var gatherable = Items.materiallist.has(taskcode)
	var task
	if !gatherable:
		task = tasks.tasklist[taskcode]
	else:
		task = Items.materiallist[taskcode]
	#check if task is existing and add slave to it if it does
	var task_location = parent.get_ref().get_location()
	var tmp = find_worktask(task_location, taskcode, taskproduct)
	if tmp != null:
		var max_workers_count = ResourceScripts.game_world.get_worker_count_for_task(tmp)
		if max_workers_count >= 0 and max_workers_count <= tmp.workers.size():
			return
		work = taskcode
		workproduct = taskproduct
		save_prev_data()
		tmp.workers.append(parent.get_ref().id)
		return
	#make new task if it didn't exist
	work = taskcode
	workproduct = taskproduct
	save_prev_data()
	var dict
	if !gatherable:
		dict = {code = taskcode,
		product = taskproduct,
		progress = 0,
		threshold = task.progress_per_item,
		workers = [],
		workers_count = 1,
		task_location = task_location,
		messages = [],
		mod = task.mod}
	else:
		dict = {code = taskcode,
		product = taskproduct,
		progress = 0,
		threshold = task.progress_per_item,
		workers = [],
		workers_count = 1,
		task_location = task_location,
		messages = [],
		mod = ""}
	dict.workers.append(parent.get_ref().id)
	ResourceScripts.game_party.active_tasks.append(dict)
	globals.emit_signal("task_added")


func assign_to_special_task(worktask):
	remove_from_task()
	var max_workers_count = worktask.max_workers
	if max_workers_count >= 0 and max_workers_count <= worktask.workers.size():
		return
	work = 'special'
	workproduct = 'special'
#	save_prev_data() cause it's difficult to find worktask for it
	worktask.workers.append(parent.get_ref().id)


func assign_to_farm_task(res):
	var currenttask = find_worktask(parent.get_ref().get_location(), 'produce', res)
	if currenttask != null:
		if currenttask.workers.has(parent.get_ref().id):
			return
		currenttask.workers.push_back(parent.get_ref().id)
		globals.emit_signal("task_added")
		return
	var dict = {code = 'produce',
	product = res,
	progress = 0,
	threshold = 1,
	workers = [],
	task_location = parent.get_ref().get_location(),
	messages = [],
	mod = ""}
	dict.workers.append(parent.get_ref().id)
	ResourceScripts.game_party.active_tasks.append(dict)
	globals.emit_signal("task_added")


func remove_from_farm(res):
	var currenttask = find_worktask(parent.get_ref().get_location(), 'produce', res)
	if currenttask != null:
		if currenttask.workers.has(parent.get_ref().id):
			currenttask.workers.erase(parent.get_ref().id)
		else:
			print("error - %s is not in it's farmtask's workers at %s" % [parent.get_ref().id, res])
	else:
		print("error - %s is not farming %s" % [parent.get_ref().id, res])


func remove_from_task():
	if work == 'disabled':
		print("There is a critical error - attempting to enable character a wrong way. Please try to remember and report chain of actions that can be its cause. All saves after this may (or may not) be broken.")
		return
	if work == 'produce':
		for res in farming_rules:
			if !farming_rules[res]: continue
			remove_from_farm(res)
		work = ''
		return
	var task = find_worktask(parent.get_ref().get_location())
	if task == null: 
		work = ''
		return
	
	if task.workers.has(parent.get_ref().id):
		task.workers.erase(parent.get_ref().id)
	else:
		print("error - %s is not in it's worktask's workers" % parent.get_ref().id)
	work = ''


func return_to_task():
	if check_prev_data():
		assign_to_task(previous_work, previous_workproduct)
	elif previous_location == parent.get_ref().get_location(): 
		clean_prev_data()

func get_work():
	return work

func is_on_quest():
	return is_on_quest


func get_quest_time_init():
	return int(quest_time_init)


func get_selected_quest():
	return quest_id


func make_unavaliable():
	if  work != "disabled":
		if is_on_quest:
			input_handler.SystemMessage(tr(parent.get_ref().get_short_name() + " removed from quest."))
			var quest_taken = ResourceScripts.game_world.get_quest_by_id(quest_id)
			quest_taken.taken = false
		remove_from_task()

		parent.get_ref().remove_from_travel()
		parent.get_ref().reset_location()
		is_on_quest = true
		work = "disabled"
		quest_time_remains = -1
		quest_time_init = -1
		parent.get_ref().set_combat_position(0)


func make_avaliable():
	if work == "disabled":
		is_on_quest = false
		work = ''
		quest_time_remains = 0


func assign_to_quest_and_make_unavalible(quest, work_time):
	remove_from_task()
	is_on_quest = true
	quest_time_remains = int(work_time)
	quest_id = quest.id
	work = quest.name
	parent.get_ref().set_combat_position(0)
	# var quest_taken = ResourceScripts.game_world.get_quest_by_id(quest_id)
	# for  req in quest_taken.requirements:
	# 	if req.has("work_time"):
	quest_time_init = int(work_time)
	gui_controller.mansion.TaskModule.show()
	gui_controller.mansion.TaskModule.show_resources_info()


func assign_to_learning(learning_type):
#	remove_from_task(false)
	is_on_quest = true
	quest_time_remains = int(variables.tutduration)
	quest_id = learning_type
	work = 'learning'
#	parent.get_ref().set_combat_position(0)
	quest_time_init = int(variables.tutduration)

func get_tutelage_type(): #stub, 2add data etc
	return tr(quest_id)


func get_quest_time_remains():
	return int(quest_time_remains)


func quest_day_tick():
	if quest_time_remains > 0:
		if work != 'learning':
			parent.get_ref().add_stat("base_exp", 12)
		quest_time_remains -= 1
		if quest_time_remains <= 0 and work != "disabled" and work != 'learning':
			remove_from_work_quest()
		elif quest_time_remains <= 0 and work == 'learning':
			finish_learning()



func remove_from_work_quest():
	is_on_quest = false
	input_handler.SystemMessage(tr(parent.get_ref().get_short_name() + " returned from quest."))
	globals.text_log_add("char", parent.get_ref().translate("[name] has returned from work"))
	input_handler.PlaySound("ding")
	quest_time_init = 0
	ResourceScripts.game_progress.work_quests_finished.append(quest_id)
	quest_id = ''
	return_to_task()


func finish_learning():
	is_on_quest = false
	globals.text_log_add("char", parent.get_ref().translate("[name] has returned from training"))
	input_handler.PlaySound("ding")
	quest_time_init = 0
	var res_text = "\n\n{color=aqua|" + parent.get_ref().get_short_name() + "} finished training."
	match quest_id:
		'nothing':
			if randf() < 0.5:
				var tr = parent.get_ref().get_random_trait_tag('negative')
				parent.get_ref().add_trait(tr)
				res_text += "\nAcquired %s" % tr(Traitdata.traits[tr].name)
			else:
				res_text += "\nNo traits acquired"
		'slave_training':
			parent.get_ref().add_stat('loyalty', 50) #possibly to remake
			res_text += "\n%s + 50" % statdata.statdata.loyalty.name
			if randf() < 0.5:
				parent.get_ref().add_stat('tame_factor', 1)
				res_text += "\n%s + 1" % statdata.statdata.tame_factor.name
			else:
				parent.get_ref().add_stat('timid_factor', 1)
				res_text += "\n%s + 1" % statdata.statdata.timid_factor.name
			parent.get_ref().add_stat('base_exp_direct', 150)
			res_text += "\n%s + 150" % statdata.statdata.base_exp.name
		'academy':
			for st in ['physics', 'wits']:
				var tmp = globals.rng.randi_range(20, 30)
				parent.get_ref().add_stat(st + '_direct', tmp)
				res_text += "\n%s + %d" % [statdata.statdata[st].name, tmp]
			parent.get_ref().add_stat('base_exp_direct', 500)
			res_text += "\n%s + 500" % statdata.statdata.base_exp.name
		'heir':
			for st in ['physics', 'wits', 'charm']:
				var tmp = globals.rng.randi_range(35, 50)
				parent.get_ref().add_stat(st + '_direct', tmp)
				res_text += "\n%s + %d" % [statdata.statdata[st].name, tmp]
			var st = input_handler.random_from_array(['physics_factor', 'wits_factor', 'charm_factor', 'sexuals_factor'])
			var st1 = input_handler.random_from_array(['physics_factor', 'wits_factor', 'charm_factor', 'sexuals_factor'])
			parent.get_ref().add_stat(st, 1) 
			parent.get_ref().add_stat(st1, 1) 
			if st == st1:
				res_text += "\n%s + %d" % [statdata.statdata[st].name, 2]
			else:
				res_text += "\n%s + %d" % [statdata.statdata[st].name, 1]
				res_text += "\n%s + %d" % [statdata.statdata[st1].name, 1]
			var tr = parent.get_ref().get_random_trait_tag('positive')
			parent.get_ref().add_trait(tr)
			res_text += "\nAcquired %s" % tr(Traitdata.traits[tr].name)
			parent.get_ref().add_stat('base_exp_direct', 1000)
			res_text += "\n%s + 1000" % statdata.statdata.base_exp.name
		_: pass
	var data = {text = '', tags = ['skill_report_event'], options = [], image = null} #not sure if this tag is correct and/or reqiured
	data.text = res_text # there may be more to it, some header maybe
	data.options.append({code = 'close', text = tr("DIALOGUECLOSE"), reqs = []})
	input_handler.interactive_message(data, 'direct')
	quest_id = ''
	work = ''


func select_brothel_activity():
	var non_sex_rules = []
	var sex_rules = []
	
	var no_consent = false
	for i in brothel_rules:
		if !brothel_rules[i] || i in ['males','futa','females']: continue
		if variables.brothel_non_sex_options.has(i):
			non_sex_rules.append(i)
		else:
			sex_rules.append(i)
	
	
	
	if sex_rules.size() > 0 && (brothel_rules.males || brothel_rules.futa || brothel_rules.females):
		parent.get_ref().add_stat('metrics_serviceperformed', 1)
		if parent.get_ref().has_status('harlotry'):
			parent.get_ref().rest_tick()
		#pick chance
		if 50 + max(parent.get_ref().get_stat('sexuals')/2,parent.get_ref().get_stat('charm')/2) > randf()*100:
			var remove_from_sex = []
			
			#every rule toggled only has 50% chance to be picked by default
			for i in sex_rules:
				if randf() >= 0.5:
					remove_from_sex.append(i)
			if remove_from_sex.size() == sex_rules.size(): #make sure at least 1 option is sill available in the end
				remove_from_sex.remove(randi() % remove_from_sex.size())
			for i in remove_from_sex:
				sex_rules.erase(i)
			
			var highest_value = get_highest_value(sex_rules)
			var data = tasks.gold_tasks_data[highest_value.code]
			var bonus_gold = 0
			
			var possible_customer_genders = []
			if brothel_rules.males:
				possible_customer_genders.append('male')
			if brothel_rules.females:
				possible_customer_genders.append('female')
			if brothel_rules.futa:
				possible_customer_genders.append('futa')
			var brothel_customer_gender = possible_customer_genders[randi() % possible_customer_genders.size()]
				
			
			var penis_check = ((brothel_rules.males || brothel_rules.futa) && brothel_customer_gender in ["male", "futa"])
			
			if parent.get_ref().get_stat('vaginal_virgin') && sex_rules.has('pussy') && penis_check:
				parent.get_ref().set_stat('vaginal_virgin', false)
				parent.get_ref().set_stat('vaginal_virgin_lost', {source = 'brothel_customer'})
				bonus_gold += parent.get_ref().calculate_price() * 0.01
			if sex_rules.has('pussy') && penis_check:
				var tmpchar = ResourceScripts.scriptdict.class_slave.new("test_main")
				tmpchar.create('random', 'male', 'random')
				if randf() < variables.brothel_pregnancy_chance:
					globals.impregnate(tmpchar, parent.get_ref())
				tmpchar.is_active = false
			if parent.get_ref().get_stat('anal_virgin') && sex_rules.has('anal') && penis_check:
				parent.get_ref().set_stat('anal_virgin', false)
				parent.get_ref().set_stat('anal_virgin_lost', {source = 'brothel_customer'})
			
			work_tick_values(data.workstats[randi()%data.workstats.size()])
			
			parent.get_ref().add_stat('metrics_randompartners', globals.fastif(sex_rules.has('group'), 2, 1))
			
			var goldearned = highest_value.value * (1 + (0.1 * sex_rules.size())) * min(5, (1 + 0.01 * parent.get_ref().calculate_price())) + bonus_gold# 10% percent for every toggled sex service + 1% of slave's value up to 500%
			if parent.get_ref().get_stat('consent') < data.min_consent == true:
				goldearned = goldearned - goldearned/3
			
			goldearned = apply_boosters(goldearned)
			goldearned = round(goldearned)
			
			
			parent.get_ref().add_stat('metrics_goldearn', goldearned)
			
			ResourceScripts.game_res.money += goldearned
			
			
			#TODO add decriptions and impregnation
			update_brothel_log(parent.get_ref().get_stat('name'), goldearned, data, brothel_customer_gender)
			return
	elif non_sex_rules.size() > 0:
		parent.get_ref().add_stat('metrics_serviceperformed', 1)
		if parent.get_ref().has_status('harlotry'):
			parent.get_ref().rest_tick()
		
		var highest_value = get_highest_value(non_sex_rules)
		
		var data = tasks.gold_tasks_data[highest_value.code]
		work_tick_values(data.workstats[randi()%data.workstats.size()])
		
		var goldearned = highest_value.value * min(4, (1 + 0.001 * parent.get_ref().calculate_price()))
		
		
		goldearned = apply_boosters(goldearned)
		goldearned = round(goldearned)
		
		parent.get_ref().add_stat('metrics_goldearn', goldearned)
		
		ResourceScripts.game_res.money += goldearned
		update_brothel_log(parent.get_ref().get_stat('name'), goldearned, data)
	else:
		remove_from_task()
		parent.get_ref().rest_tick()
	

func update_brothel_log(ch_name, gold, data, customer_gender = ""):
	if globals.log_node != null && weakref(globals.log_node).get_ref():
		if ResourceScripts.game_globals.hour == 4:
			globals.log_node.clean_service_log()
		var text = ""
		if customer_gender != "":
			text = tr("BROTHELLOGSEX")  % [tr(ch_name), str(gold), tr("BROTHEL" + data.code.to_upper()), customer_gender.capitalize()]
			#text = tr(ch_name) + " earned " + str(gold) + " gold doing " + tr("BROTHEL" + data.code.to_upper()) + " with a " + customer_gender
		else:
			text = tr("BROTHELLOGNO_SEX")  % [tr(ch_name), str(gold), tr("BROTHEL" + data.code.to_upper())]
			#text = tr(ch_name) + " earned " + str(gold) + " gold working as " + tr("BROTHEL" + data.code.to_upper())
		var ServiceLog = globals.log_node.get_node("ServiceLog")
		var newfield = ServiceLog.get_node("VBoxContainer/field").duplicate()
		newfield.show()
		newfield.get_node("text").bbcode_text = text
		ServiceLog.get_node("VBoxContainer").add_child(newfield)
		var textfield = newfield.get_node('text')
		textfield.rect_size.y = textfield.get_content_height()
		newfield.rect_min_size.y = textfield.rect_size.y
		yield(globals.get_tree(), 'idle_frame')
		ServiceLog.scroll_vertical = ServiceLog.get_v_scrollbar().max_value

func apply_boosters(value):
	var mul = 1.0
	for i in range(3):
		var id = 'boost%d' % (i + 1)
		var res = service_boosters[id].res
		if !service_boosters[id].value:
			break
		if ResourceScripts.game_res.materials.has(res) and ResourceScripts.game_res.materials[res] > 1:
			ResourceScripts.game_res.materials[res] -= 1
			mul = variables.booster_value[i]
		else:
			break
	return value * mul


func get_highest_value(array):#find highest profit option
	var values = {}
	var highest_value = {code = '', value = 0}
	for i in array:
		values[i] = max(1,round(get_gold_value(i) * (0.8 + randf() * 0.4))) #20% randomness to value
		if highest_value.value < values[i]:
			highest_value.code = i
			highest_value.value = values[i]
	
	return highest_value


func get_gold_value(task):
	var value = call(tasks.gold_tasks_data[task].formula)
	value = value * (parent.get_ref().get_stat('productivity') * parent.get_ref().get_stat(tasks.gold_tasks_data[task].workmod)/100.0)
	
	return value


func recruit_tick(task): #maybe incomplete
	var taskdata = tasks.tasklist[task.code]
	var val = 1
	if taskdata.has('function'):
		val = call(taskdata.function)
	task.progress += val
	work_tick_values(taskdata.workstat)
	while task.progress >= task.threshold:
		task.progress -= task.threshold
		globals.roll_hirelings(task.task_location)
		globals.text_log_add('work', tr("HIRELINGFOUND"))
		input_handler.PlaySound("ding")


func special_tick(task): #maybe incomplete
	parent.get_ref().add_stat("base_exp", 3) #fix
	var val = 1
	if task.has('function'):
		val = call(task.function)
	task.progress += val
	if task.has('workstat'):
		work_tick_values(task.workstat)
	if task.progress >= task.threshold:
		globals.common_effects(task.args)
		ResourceScripts.game_party.clean_task(task)
		ResourceScripts.game_party.active_tasks.erase(task)
		globals.text_log_add('work', tr("SPECTASKCOMPLETED") + " - " + tr(task.name))
		input_handler.PlaySound("ding")


func setup_farm():
	for res in farming_rules:
		if !farming_rules[res]:
			continue
		var task = tasks.farm_tasks[res]
		if !parent.get_ref().checkreqs(task.reqs):
			farming_rules[res] = false
			remove_from_farm(res)
		else:
			assign_to_farm_task(res)


func farm_tick():
	for res in farming_rules:
		if !farming_rules[res]:
			continue
		var task = tasks.farm_tasks[res]
		var currenttask = find_worktask(parent.get_ref().get_location(), 'produce', res)
		if !parent.get_ref().checkreqs(task.reqs):
			farming_rules[res] = false
			remove_from_farm(res)
		else:
			var val = call(task.formula)
			currenttask.progress += val
			while currenttask.progress >= currenttask.threshold: 
				currenttask.progress -= currenttask.threshold
				ResourceScripts.game_res.materials[res] += 1


func work_tick():
	if is_on_quest:
		return
	
	if work == 'produce':
		farm_tick()
		return
	
	var currenttask = find_worktask(parent.get_ref().get_location())
	
	if currenttask == null:
		work = ''
		parent.get_ref().rest_tick()
		return
	
	if parent.get_ref().is_uncontrollable() && !parent.get_ref().has_profession('master'):
		if !messages.has("refusedwork"):
			globals.text_log_add('work', parent.get_ref().get_short_name() + ": Refused to work")
			messages.append("refusedwork")
		return
	
	if parent.get_ref().get_static_effect_by_code("work_rule_ration") != null:
		parent.get_ref().food.food_consumption_rations = true
	
	if currenttask.code == 'brothel':
		select_brothel_activity()
		return
	
	if currenttask.product == 'recruiting':
		recruit_tick(currenttask)
		return
	
	if currenttask.code == 'special':
		special_tick(currenttask)
		return
	
	var prodvalue = get_progress_task(currenttask.code, currenttask.product, true)
	
	if ['smith','alchemy','tailor','cooking'].has(currenttask.product) && currenttask.code != 'building':
		if ResourceScripts.game_res.add_craft_value(currenttask, prodvalue, parent.get_ref()):
			work_tick_values(tasks.tasklist[currenttask.code].workstat)
		else:
			parent.get_ref().rest_tick()
	elif currenttask.code == 'building':
		if ResourceScripts.game_res.add_build_value(currenttask, prodvalue, parent.get_ref()):
			work_tick_values(tasks.tasklist[currenttask.code].workstat)
		else:
			parent.get_ref().rest_tick()
	else:
		var person_location = parent.get_ref().get_location()
		var location = ResourceScripts.world_gen.get_location_from_code(person_location)
		var gatherable = Items.materiallist.has(currenttask.code)
		if !gatherable:
			work_tick_values(tasks.tasklist[currenttask.code].workstat)
			currenttask.progress += prodvalue
		else:
			currenttask.progress += get_progress_resource(currenttask.code, true)
			work_tick_values(Items.materiallist[currenttask.code].workstat)
		while currenttask.threshold <= currenttask.progress:
			currenttask.progress -= currenttask.threshold
			if !gatherable:
				if tasks.tasklist[currenttask.code].production_item == 'gold':
					ResourceScripts.game_res.money += 1
					parent.get_ref().add_stat('metrics_goldearn', 1)
				else:
					ResourceScripts.game_res.materials[tasks.tasklist[currenttask.code].production_item] += 1
					add_metric_for_outcome(tasks.tasklist[currenttask.code].production_item)
			else:
				if person_location != "aliron" && location.type == "dungeon":
					if ResourceScripts.world_gen.get_location_from_code(person_location).gather_limit_resources[currenttask.code] > 0:
						ResourceScripts.game_res.materials[currenttask.code] += 1
						ResourceScripts.world_gen.get_location_from_code(person_location).gather_limit_resources[currenttask.code] -= 1
					if ResourceScripts.world_gen.get_location_from_code(person_location).gather_limit_resources[currenttask.code] <= 0:
						globals.text_log_add('work', parent.get_ref().get_short_name() + ": " + "No more resources to gather.")
						remove_from_task()
						if !ResourceScripts.game_party.active_tasks.empty():
							for task in ResourceScripts.game_party.active_tasks:
								if task.code == currenttask.code && task.task_location == location.id:
									ResourceScripts.game_party.active_tasks.erase(task)
				else:
					ResourceScripts.game_res.materials[currenttask.code] += 1
				add_metric_for_outcome(currenttask.code)


func add_metric_for_outcome(res_id):
	var matdata = Items.materiallist[res_id]
	if matdata.type == 'food':
		parent.get_ref().add_stat('metrics_foodearn', 1)
	#2add correct material check
	else:
		parent.get_ref().add_stat('metrics_materialearn', 1)
#	parent.get_ref().add_stat('metrics_goldearn', 1)


func work_tick_values(workstat):
	if !parent.get_ref().has_status('no_working_bonuses'):
		if workstat.findn("sex_skills") >= 0:
			parent.get_ref().add_stat(workstat, rand_range(1.2,1.8))
		else:
			parent.get_ref().add_stat(workstat, 0.36)
		parent.get_ref().add_stat('base_exp', 5)


func get_task_crit_chance():
	return task_mods.crit


func get_task_efficiency_tool():
	return task_mods.eff


func get_task_diff():
	return task_mods.diff


var task_mods = {
	eff = 0.0,
	crit = 0.0,
	diff = 0,
}

func _get_base_crafting_diff(): #2add
	return 0 

func fill_task_mods(task):
	task_mods.crit = parent.get_ref().get_stat('base_task_crit_chance')
	task_mods.diff = _get_base_crafting_diff()
	task_mods.eff = 0
	var item
	if parent.get_ref().equipment.gear.tool != null:
		item = ResourceScripts.game_res.items[parent.get_ref().equipment.gear.tool]
	if item != null && task.has('worktool') && (task.worktool in item.toolcategory or ResourceScripts.game_res.upgrades.has('tool_swapper') and ResourceScripts.game_res.upgrades.tool_swapper > 0):
		if item.bonusstats.has("task_efficiency_tool"):
			task_mods.eff = item.bonusstats.task_efficiency_tool
			task_mods.diff += 0.1 * item.bonusstats.task_efficiency_tool
		if item.bonusstats.has("task_crit_chance"):
			task_mods.crit += item.bonusstats.task_crit_chance
			task_mods.diff += 0.4 * item.bonusstats.task_crit_chance
	
	if parent.get_ref().has_status('no_task_crit'):
		task_mods.crit = 0
	
	if ResourceScripts.game_globals.difficulty == 'easy':
		task_mods.diff *= 1.5
	task_mods.diff = int(task_mods.diff)


func fill_task_mods_res(task):
	task_mods.crit = parent.get_ref().get_stat('base_task_crit_chance')
	task_mods.diff = 0
	task_mods.eff = 0
	var item
	if parent.get_ref().equipment.gear.tool != null:
		item = ResourceScripts.game_res.items[parent.get_ref().equipment.gear.tool]
	if item != null && task.has('tool_type') && (task.tool_type in item.toolcategory or ResourceScripts.game_res.upgrades.has('tool_swapper') and ResourceScripts.game_res.upgrades.tool_swapper > 0):
		if item.bonusstats.has("task_efficiency_tool"):
			task_mods.eff = item.bonusstats.task_efficiency_tool
		if item.bonusstats.has("task_crit_chance"):
			task_mods.crit += item.bonusstats.task_crit_chance
	
	if parent.get_ref().has_status('no_task_crit'):
		task_mods.crit = 0


func get_progress_task(temptask, tempsubtask, count_crit = false):
	if !tasks.tasklist.has(temptask): return null
	var location = ResourceScripts.world_gen.get_location_from_code(parent.get_ref().get_location())
	var task = tasks.tasklist[temptask]
	#var subtask = task.production_code
	var value = call(task.progress_function)
#	var item
#	if parent.get_ref().equipment.gear.tool != null:
#		item = ResourceScripts.game_res.items[parent.get_ref().equipment.gear.tool]
#	if item != null && task.has('worktool') && (task.worktool in item.toolcategory || ResourceScripts.game_res.upgrades.has('tool_swapper')):
#		if item.bonusstats.has("task_efficiency_tool"):
#			value = value + value*item.bonusstats.task_efficiency_tool
	fill_task_mods(task)
	value *= 1.0 + get_task_efficiency_tool()
	value = value * (parent.get_ref().get_stat('productivity') * parent.get_ref().get_stat(task.mod)/100.0)#*(productivity*get(currenttask.mod)/100)
	
	if count_crit == true && randf() <= get_task_crit_chance():
		value = value * 2
	if location.has('gather_mod'): #maybe 2fix, idk if non-dungeons still has their gather mods intact
		value *= location.gather_mod
#	print(task_mods)
#	print(value)
	return value


func get_progress_resource(tempresource, count_crit = false):
	var resource = Items.materiallist[tempresource]
	var location = ResourceScripts.world_gen.get_location_from_code(parent.get_ref().get_location())
	# var subtask = task.production[tempsubtask]
	
	var value = call(resource.progress_formula)
	fill_task_mods_res(resource)
	
	value *= 1.0 + get_task_efficiency_tool()
	value = value * (parent.get_ref().get_stat('productivity') * parent.get_ref().get_stat(resource.workmod)/100.0) #*(productivity*get(currenttask.mod)/100)
	
	if count_crit == true && randf() <= get_task_crit_chance():
		value = value * 2
	if location.type == 'dungeon':
		value *= location.gatherable_resources[tempresource].gather_mod
	elif location.has('gather_mod'): #2fix
		value *= location.gather_mod
#	print(task_mods)
#	print(value)
	return value


func get_progress_farm(res):
	var task = tasks.farm_tasks[res]
	return call(task.formula)

func get_farming_limit():
	return max(parent.get_ref().get_stat('growth_factor') - 2, 1)

func can_add_farming():
	var n = get_farming_limit()
	for res in variables.farming_rules:
		if farming_rules[res]:
			n -= 1
	return (n > 0)


func get_ability_experience():
	return abil_exp
