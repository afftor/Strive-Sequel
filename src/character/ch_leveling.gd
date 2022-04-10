extends "res://src/character/ch_jobs.gd"

var base_exp = 0 setget base_exp_set
var professions = []
var prof_links = {}
var abil_exp = 0

var sleep = ''
var work = ''
var previous_work = ''
var workproduct = null
var work_rules = {ration = false, shifts = false, constrain = false, luxury = false, contraceptive = false}
var messages = []


var is_on_quest = false
var quest_id
var quest_time_remains = 0
var quest_time_init = 0
var selected_work_quest = null


func _init():
	fix_rules()


func fix_rules():
	for rule in variables.work_rules:
		if !work_rules.has(rule):
			work_rules[rule] = false


func set_work_rule(rule, value):
	if variables.work_rules.has(rule):
		work_rules[rule] = value

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
func process_chardata(data):
	if data.has('classes'):
		for prof in data.classes:
			unlock_class(prof)


func get_next_class_exp():
#	var professions = parent.get_ref().get_stat('professions')
	var currentclassnumber = professions.size()
	var growth_factor = parent.get_ref().get_stat('growth_factor')
	if professions.has("master") or professions.has('spouse'): currentclassnumber -= 1
	var exparray
	var value = 0
	var easy_cap = growth_factor * variables.class_cap_per_growth + variables.class_cap_basic
	if currentclassnumber < easy_cap:
		exparray = variables.soft_level_reqs
		if exparray.size()-1 < currentclassnumber:
			value = exparray[exparray.size()-1]
		else:
			value = exparray[currentclassnumber]
	else:
		exparray = variables.hard_level_reqs
		if exparray.size()-1 < currentclassnumber - easy_cap:
			value = exparray[exparray.size()-1]
		else:
			value = exparray[currentclassnumber - easy_cap]
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
		if i != 'master':
			remove_class(i)

func check_skill_prof(skill):
	for i in professions:
		var tempprof = classesdata.professions[i]
		if tempprof.skills.has(skill):
			return true
	return false

#tasks
func assign_to_task(taskcode, taskproduct):
	#remove existing work
	remove_from_task()
	if taskcode == '':
		work = ''
		return
	var gatherable = Items.materiallist.has(taskcode)
	var task
	if !gatherable:
		task = races.tasklist[taskcode]
	else:
		task = Items.materiallist[taskcode]
	#check if task is existing and add slave to it if it does
	var taskexisted = false
	var task_location = parent.get_ref().get_location()
	for i in ResourceScripts.game_party.active_tasks:
		if i.code == taskcode && i.product == taskproduct && i.task_location == task_location:
			taskexisted = true
			i.workers.append(parent.get_ref().id)
			i.workers_count += 1
			work = i.code

	workproduct = taskproduct
	if taskexisted:
		return
	#make new task if it didn't exist
	var dict
	if !gatherable:
		dict = {code = taskcode,
		product = taskproduct,
		progress = 0,
		threshhold = task.progress_per_item,
		workers = [],
		workers_count = 1,
		task_location = task_location,
		messages = [],
		mod = task.mod}
	else:
		dict = {code = taskcode,
		product = taskproduct,
		progress = 0,
		threshhold = task.progress_per_item,
		workers = [],
		workers_count = 1,
		task_location = task_location,
		messages = [],
		mod = ""}
	dict.workers.append(parent.get_ref().id)
	work = taskcode
	ResourceScripts.game_party.active_tasks.append(dict)
	globals.emit_signal("task_added")


func remove_from_task(remember = false):
	if work != '':
		for i in ResourceScripts.game_party.active_tasks:
			if i.code == work && i.task_location == parent.get_ref().get_location() && i.product == workproduct:
				i.workers.erase(parent.get_ref().id)
				i.workers_count = max(0, i.workers_count - 1)
	# if remember && work != 'travel':
	# 	previous_work = work
	work = ''

func return_to_task():
	assign_to_task(previous_work, workproduct)
	previous_work = ''

func get_work():
	return work

func is_on_quest():
	return is_on_quest


func get_quest_time_init():
	return int(quest_time_init)


func get_selected_work_quest():
	return selected_work_quest


func make_unavaliable():
	if  work != "disabled":
		if is_on_quest:
			input_handler.SystemMessage(tr(parent.get_ref().get_short_name() + " removed from quest."))
			var quest_taken = ResourceScripts.game_world.get_quest_by_id(quest_id)
			quest_taken.taken = false
		remove_from_task(false)

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
	remove_from_task(false)
	is_on_quest = true
	quest_time_remains = int(work_time)
	quest_id = quest.id
	selected_work_quest = quest
	work = quest.name
	parent.get_ref().set_combat_position(0)
	# var quest_taken = ResourceScripts.game_world.get_quest_by_id(quest_id)
	# for  req in quest_taken.requirements:
	# 	if req.has("work_time"):
	quest_time_init = int(work_time)
	gui_controller.mansion.TaskModule.show()
	gui_controller.mansion.TaskModule.show_resources_info()


func get_quest_time_remains():
	return int(quest_time_remains)


func quest_day_tick():
	if quest_time_remains > 0:
		quest_time_remains -= 1
		if quest_time_remains <= 0 and work != "disabled":
			remove_from_work_quest()



func remove_from_work_quest():
	is_on_quest = false
	input_handler.SystemMessage(tr(parent.get_ref().get_short_name() + " returned from quest."))
	globals.text_log_add("char", parent.get_ref().translate("[name] has returned from work"))
	input_handler.PlaySound("ding")
	quest_time_init = 0
	ResourceScripts.game_progress.work_quests_finished.append(quest_id)
	quest_id = ''


func get_obed_drain():
	if parent.get_ref().has_profession('master') or parent.get_ref().has_profession('spouse'): return 0.0
	var rule_bonus = 0.0
	if work_rules.luxury: rule_bonus = 0.25
	var value = variables.base_obed_drain * (parent.get_ref().get_stat('obDrainReduction') * (1 + parent.get_ref().get_stat('obDrainIncrease')) * (1 - rule_bonus - 0.0075 * parent.get_ref().get_stat('loyalty')))
	return value

func predict_obed_time(): # in hours, not in ticks
	if check_infinite_obedience() == true: return 10000
	return parent.get_ref().get_stat('obedience') / get_obed_drain()

func check_infinite_obedience():
	return get_obed_drain() == 0 or parent.get_ref().has_profession('master') or parent.get_ref().has_profession('spouse')

func work_tick():
	if is_on_quest():
		return
	var currenttask
	for i in ResourceScripts.game_party.active_tasks:
		if i.workers.has(parent.get_ref().id):
			currenttask = i
	
	if currenttask == null:
		work = ''
		parent.get_ref().rest_tick()
		return
	
	if parent.get_ref().statlist.is_uncontrollable() && !parent.get_ref().has_profession('master'):
		if !messages.has("refusedwork"):
			globals.text_log_add('work', parent.get_ref().get_short_name() + ": Refused to work")
			messages.append("refusedwork")
		return
	if parent.get_ref().get_stat('obedience') > 0: #new work stat. If <= 0 and loyal/sub < 100, refuse to work
		parent.get_ref().add_stat('obedience', - get_obed_drain())
		messages.erase("refusedwork")
	
	if parent.get_ref().get_static_effect_by_code("work_rule_ration") != null:
		parent.get_ref().food.food_consumption_rations = true
	
	var prodvalue = get_progress_task(currenttask.code, currenttask.product, true)
	
	if ['smith','alchemy','tailor','cooking'].has(currenttask.product) && currenttask.code != 'building':
		if ResourceScripts.game_res.add_craft_value(currenttask, prodvalue, parent.get_ref()):
			work_tick_values(currenttask)
		else:
			parent.get_ref().rest_tick()
	elif currenttask.code == 'building':
		if ResourceScripts.game_res.add_build_value(currenttask, prodvalue, parent.get_ref()):
			work_tick_values(currenttask)
		else:
			parent.get_ref().rest_tick()
	else:
		var person_location = parent.get_ref().get_location()
		var location = ResourceScripts.world_gen.get_location_from_code(person_location)
		var gatherable = Items.materiallist.has(currenttask.code)
		work_tick_values(currenttask, gatherable)
		if !gatherable:
			currenttask.progress += prodvalue
		else:
			currenttask.progress += get_progress_resource(currenttask.code, true)
		while currenttask.threshhold <= currenttask.progress:
			currenttask.progress -= currenttask.threshhold
			if !gatherable:
				if races.tasklist[currenttask.code].production_item == 'gold':
					ResourceScripts.game_res.money += 1
				else:
					ResourceScripts.game_res.materials[races.tasklist[currenttask.code].production_item] += 1
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


func work_tick_values(currenttask, gatherable = false):
	var workstat
	if !gatherable:
		workstat = races.tasklist[currenttask.code].workstat
	else:
		workstat = Items.materiallist[currenttask.code].workstat
	if !parent.get_ref().has_status('no_working_bonuses'):
		parent.get_ref().add_stat(workstat, 0.36)
		parent.get_ref().add_stat('base_exp', 5)



func get_progress_task(temptask, tempsubtask, count_crit = false):
	if !races.tasklist.has(temptask): return null
	var location = ResourceScripts.world_gen.get_location_from_code(parent.get_ref().get_location())
	var task = races.tasklist[temptask]
	#var subtask = task.production_code
	var value = call(task.progress_function)
	var item
	if parent.get_ref().equipment.gear.tool != null:
		item = ResourceScripts.game_res.items[parent.get_ref().equipment.gear.tool]
	if item != null && task.has('worktool') && task.worktool in item.toolcategory:
		if item.bonusstats.has("task_efficiency_tool"):
			value = value + value*item.bonusstats.task_efficiency_tool
	value = value * (parent.get_ref().get_stat('productivity') * parent.get_ref().get_stat(task.mod)/100.0)#*(productivity*get(currenttask.mod)/100)
	if item != null && task.has('worktool') && task.worktool in item.toolcategory:
		if count_crit == true && item.bonusstats.has("task_crit_chance") && randf() <= item.bonusstats.task_crit_chance:
			value = value*2
	if location.has('gather_mod'):
		value *= location.gather_mod
	return value

func get_progress_resource(tempresource, count_crit = false):
	var resource = Items.materiallist[tempresource]
	var location = ResourceScripts.world_gen.get_location_from_code(parent.get_ref().get_location())
	# var subtask = task.production[tempsubtask]
	var value = call(resource.progress_formula)
	var item
	if parent.get_ref().equipment.gear.tool != null:
		item = ResourceScripts.game_res.items[parent.get_ref().equipment.gear.tool]
	if item != null && resource.has('tool_type') && resource.tool_type in item.toolcategory:
		if item.bonusstats.has("task_efficiency_tool"):
			value = value + value*item.bonusstats.task_efficiency_tool
	value = value * (parent.get_ref().get_stat('productivity') * parent.get_ref().get_stat(resource.workmod)/100.0) #*(productivity*get(currenttask.mod)/100)
	if item != null && resource.has('tool_type') && resource.tool_type in item.toolcategory:
		if count_crit == true && item.bonusstats.has("task_crit_chance") && randf() <= item.bonusstats.task_crit_chance:
			value = value*2
	if location.has('gather_mod'):
		value *= location.gather_mod
	return value

func get_ability_experience():
	return abil_exp
