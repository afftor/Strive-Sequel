extends "res://src/character/ch_jobs.gd"

var base_exp = 0 setget base_exp_set
var professions = []
var prof_links = {}

var sleep = ''
var work = ''
var previous_work = ''
var workproduct = null
var work_rules = {ration = false, shifts = false, constrain = false, luxury = false}
var messages = []


var is_on_quest = false
var quest_id
var quest_days_left = 0
var quest_work_time = 0
var selected_work_quest = null


func base_exp_set(value):
	if value >= get_next_class_exp() && base_exp < get_next_class_exp():
		input_handler.add_random_chat_message(parent, 'exp_for_level')
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

#professions
func get_next_class_exp():
#	var professions = parent.get_stat('professions')
	var currentclassnumber = professions.size()
	var growth_factor = parent.get_stat('growth_factor')
	if professions.has("master"): currentclassnumber -= 1
	var exparray
	var value = 0
	if currentclassnumber < growth_factor * variables.class_cap_per_growth + variables.class_cap_basic:
		exparray = variables.soft_level_reqs
		if exparray.size()-1 < abs(growth_factor * variables.class_cap_per_growth + variables.class_cap_basic):
			value = exparray[exparray.size()-1]
		else:
			value = exparray[currentclassnumber]
	else:
		exparray = variables.hard_level_reqs
		if exparray.size()-1 < abs(growth_factor * variables.class_cap_per_growth + variables.class_cap_basic - currentclassnumber):
			value = exparray[exparray.size()-1]
		else:
			value = exparray[abs(growth_factor * variables.class_cap_per_growth + variables.class_cap_basic - currentclassnumber)]
	return value

func get_class_list(category, person):
	var array = []
	for i in classesdata.professions.values():
		if (category != 'any' && i.categories.has(category) == false) || professions.has(i.code) == true:
			continue
		if parent.checkreqs(i.reqs, true) == true:
			array.append(i)
	return array

func unlock_class(prof, satisfy_progress_reqs = false):
	prof = classesdata.professions[prof]
	if satisfy_progress_reqs == true:
		for i in prof.reqs:
			if i.code == 'stat' && i.stat in ['physics','wits','charm','sexuals']:
				parent.set_stat(i.stat, i.value)
	if professions.has(prof.code):
		return "Already has this profession"
	professions.append(prof.code)
	parent.add_stat_bonuses(prof.statchanges)
	for i in prof.skills:
		if prof_links.has('s_'+i):
			prof_links['s_'+ i].push_back(prof.code)
		else: 
			prof_links['s_'+ i] = [prof.code]
			parent.learn_skill(i)
	for i in prof.combatskills:
		if prof_links.has('s_'+i):
			prof_links['s_'+ i].push_back(prof.code)
		else: 
			prof_links['s_'+ i] = [prof.code]
			parent.learn_c_skill(i)
	for i in prof.traits:
		if prof_links.has('t_'+i):
			prof_links['t_'+ i].push_back(prof.code)
		else: 
			prof_links['t_'+ i] = [prof.code]
			parent.add_trait(i)
	parent.recheck_effect_tag('recheck_class')

func remove_class(prof):
	prof = classesdata.professions[prof]
	if !professions.has(prof.code):
		return "Nothing to remove"
	professions.erase(prof.code)
	parent.remove_stat_bonuses(prof.statchanges)
	for i in prof.skills:
		if prof_links['s_' + i].size() == 1:
			if prof_links['s_' + i][0] == prof.code:
				parent.unlearn_skill(i)
				prof_links.erase('s_' + i)
			else:
				print('WARNING! error in prof dependancy')
		else:
			prof_links['s_' + i].erase(prof.code)
	for i in prof.combatskills:
		if prof_links['s_' + i].size() == 1:
			if prof_links['s_' + i][0] == prof.code:
				parent.unlearn_c_skill(i)
				prof_links.erase('s_' + i)
			else:
				print('WARNING! error in prof dependancy')
		else:
			prof_links['s_' + i].erase(prof.code)
	for i in prof.traits:
		if prof_links['t_' + i].size() == 1:
			if prof_links['t_' + i][0] == prof.code:
				parent.remove_trait(i)
				prof_links.erase('t_' + i)
			else:
				print('WARNING! error in prof dependancy')
		else:
			prof_links['t_' + i].erase(prof.code)
	parent.recheck_effect_tag('recheck_class')

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
func assign_to_task(taskcode, taskproduct, iterations = -1):
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
	var task_location = parent.get_location()
	for i in ResourceScripts.game_party.active_tasks:
		if i.code == taskcode && i.product == taskproduct && i.task_location == task_location:
			taskexisted = true
			i.workers.append(parent.id)
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
		threshhold = task.production[taskproduct].progress_per_item,
		workers = [],
		workers_count = 1,
		task_location = task_location,
		iterations = iterations,
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
		iterations = iterations,
		messages = [],
		mod = ""}
	dict.workers.append(parent.id)
	work = taskcode
	ResourceScripts.game_party.active_tasks.append(dict)
	globals.emit_signal("task_added")


func remove_from_task(remember = false):
	if work != '':
		for i in ResourceScripts.game_party.active_tasks:
			if i.code == work && i.task_location == parent.get_location():
				i.workers.erase(parent.id)
				i.workers_count -= 1
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


func get_quest_work_time():
	return quest_work_time


func get_selected_work_quest():
	return selected_work_quest


func assign_to_quest_and_make_unavalible(quest, work_time):
	is_on_quest = true
	quest_days_left = int(work_time)
	quest_id = quest.id
	selected_work_quest = quest
	work = quest.name
	parent.set_combat_position(0)
	# var quest_taken = ResourceScripts.game_world.get_quest_by_id(quest_id)
	# for  req in quest_taken.requirements:
	# 	if req.has("work_time"):
	quest_work_time = work_time
	gui_controller.mansion.TaskModule.show()
	gui_controller.mansion.TaskModule.show_resources_info()


func get_quest_days_left():
	return quest_days_left


func quest_day_tick():
	if quest_days_left > 0:
		quest_days_left -= 1
		if quest_days_left <= 0:
			remove_from_work_quest()



func remove_from_work_quest():
	is_on_quest = false
	input_handler.SystemMessage(tr(parent.get_short_name() + " returned from quest."))
	globals.text_log_add("char", parent.translate("[name] has returned from work"))
	input_handler.PlaySound("ding")
	quest_work_time = 0
	ResourceScripts.game_progress.work_quests_finished.append(quest_id)
	quest_id = ''


func get_obed_drain(value):
	var rule_bonus = 0.0
	if work_rules.luxury: rule_bonus = 0.25
	value *= parent.get_stat('obDrainReduction') * (1 + parent.get_stat('obDrainIncrease')) * (1 - rule_bonus - 0.0075 * parent.get_stat('loyalty'))
	return value

func predict_obed_time():
	if check_infinite_obedience() == true: return 10000
	return parent.get_stat('obedience') / get_obed_drain(1)

func check_infinite_obedience():
	return get_obed_drain(1) == 0 || parent.has_profession('master')

func work_tick():
	if is_on_quest():
		return
	var currenttask
	for i in ResourceScripts.game_party.active_tasks:
		if i.workers.has(parent.id):
			currenttask = i
	
	if currenttask == null:
		work = ''
		parent.rest_tick()
		return
	
	if parent.statlist.is_uncontrollable() && !parent.has_profession('master'):
		if !messages.has("refusedwork"):
			globals.text_log_add('work', parent.get_short_name() + ": Refused to work")
			messages.append("refusedwork")
		return
	if parent.get_stat('obedience') > 0: #new work stat. If <= 0 and loyal/sub < 100, refuse to work
		parent.add_stat('obedience', - get_obed_drain(1))
		messages.erase("refusedwork")
	
	if parent.get_static_effect_by_code("work_rule_ration") != null:
		parent.food.food_consumption_rations = true

	if ['smith','alchemy','tailor','cooking'].has(currenttask.product) && currenttask.code != 'building':
		if ResourceScripts.game_res.craftinglists[currenttask.product].size() <= 0:
			if currenttask.messages.has('notask') == false:
				globals.text_log_add('crafting', parent.get_short_name() + ": No craft task for " + currenttask.product.capitalize() + ". ")
				currenttask.messages.append('notask')
			parent.rest_tick()
			return
		else:	
			var craftingitem = ResourceScripts.game_res.craftinglists[currenttask.product][0]
			currenttask.messages.erase("notask")
			if craftingitem.resources_taken == false:
				if globals.check_recipe_resources(craftingitem) == false:
					if currenttask.messages.has('noresources') == false:
						globals.text_log_add('crafting', parent.get_short_name() + ": Not Enough Resources for craft. ")
						currenttask.messages.append("noresources")
					parent.rest_tick()
					return
				else:
					globals.spend_resources(craftingitem)
					currenttask.messages.erase("noresources")
			work_tick_values(currenttask)
			craftingitem.workunits += get_progress_task(currenttask.code, currenttask.product, true)#
			make_item_sequence(currenttask, craftingitem)
	
	elif currenttask.code == 'building':
		var upgrades_queue = ResourceScripts.game_res.upgrades_queue
		if upgrades_queue.size() == 0:
			self.assign_to_task('', '')
			parent.rest_tick()
			if messages.has("noupgrade") == false:
				globals.text_log_add('upgrades',parent.get_short_name() + ": No task or upgrade selected for building. ")
				messages.append("noupgrade")
			return
		else:
			messages.erase('noupgrade')
			work_tick_values(currenttask)
			if !ResourceScripts.game_res.upgrade_progresses.has(upgrades_queue[0]):
				var currentupgradelevel
				if ResourceScripts.game_res.upgrades.has(upgrades_queue[0]):
					currentupgradelevel = ResourceScripts.game_res.upgrades[upgrades_queue[0]] + 1
					ResourceScripts.game_res.upgrade_progresses[upgrades_queue[0]] = {level = currentupgradelevel, progress = 0}
			ResourceScripts.game_res.upgrade_progresses[ResourceScripts.game_res.upgrades_queue[0]].progress += get_progress_task(currenttask.code, currenttask.product, true)#*(productivity/100)
			if ResourceScripts.game_res.upgrade_progresses[ResourceScripts.game_res.upgrades_queue[0]].progress >= upgradedata.upgradelist[ResourceScripts.game_res.upgrades_queue[0]].levels[int(ResourceScripts.game_res.upgrade_progresses[ResourceScripts.game_res.upgrades_queue[0]].level)].taskprogress:
				if ResourceScripts.game_res.upgrades.has(ResourceScripts.game_res.upgrades_queue[0]):
					ResourceScripts.game_res.upgrades[ResourceScripts.game_res.upgrades_queue[0]] += 1
				else:
					ResourceScripts.game_res.upgrades[ResourceScripts.game_res.upgrades_queue[0]] = 1
				input_handler.emit_signal("UpgradeUnlocked", upgradedata.upgradelist[ResourceScripts.game_res.upgrades_queue[0]])
				globals.text_log_add('upgrades',"Upgrade finished: " + upgradedata.upgradelist[ResourceScripts.game_res.upgrades_queue[0]].name)
				if ResourceScripts.game_res.upgrades_queue[0] == "tattoo_set":
					input_handler.ActivateTutorial("tattoo")
				ResourceScripts.game_res.upgrade_progresses.erase(ResourceScripts.game_res.upgrades_queue[0])
				ResourceScripts.game_res.upgrades_queue.erase(ResourceScripts.game_res.upgrades_queue[0])
	else:
		var person_location = parent.get_location()
		var location = ResourceScripts.world_gen.get_location_from_code(person_location)
		var gatherable = Items.materiallist.has(currenttask.code)
		work_tick_values(currenttask, gatherable)
		if !gatherable:
			currenttask.progress += get_progress_task(currenttask.code, currenttask.product, true)
		else:
			currenttask.progress += get_progress_resource(currenttask.code, true)
		while currenttask.threshhold <= currenttask.progress:
			currenttask.progress -= currenttask.threshhold
			if !gatherable:
				if races.tasklist[currenttask.code].production[currenttask.product].item == 'gold':
					ResourceScripts.game_res.money += 1
				else:
					ResourceScripts.game_res.materials[races.tasklist[currenttask.code].production[currenttask.product].item] += 1
			else:
				ResourceScripts.game_res.materials[currenttask.code] += 1
				if person_location != "aliron" && location.type == "dungeon":
					if ResourceScripts.world_gen.get_location_from_code(person_location).gather_limit_resources[currenttask.code] == 0:
						globals.text_log_add('work', parent.get_short_name() + ": " + "No more resources to gather.")
						remove_from_task()
						if !ResourceScripts.game_party.active_tasks.empty():
							for task in ResourceScripts.game_party.active_tasks:
								if task.code == currenttask.code && task.task_location == location.id:
									ResourceScripts.game_party.active_tasks.erase(task)
					else:
						ResourceScripts.world_gen.get_location_from_code(person_location).gather_limit_resources[currenttask.code] -= 1



func work_tick_values(currenttask, gatherable = false):
	var workstat
	if !gatherable:
		workstat = races.tasklist[currenttask.code].workstat
	else:
		workstat = Items.materiallist[currenttask.code].workstat
	if !parent.has_status('no_working_bonuses'): 
		parent.add_stat(workstat, 0.06)
		self.base_exp += 1

func make_item_sequence(currenttask, craftingitem):
	if craftingitem.workunits >= craftingitem.workunits_needed:
		globals.make_item(craftingitem)
		if Items.recipes[craftingitem.code].resultitemtype != 'material' && randf() < 0.25:
			input_handler.get_person_for_chat(currenttask.workers, 'item_created')
		craftingitem.workunits -= craftingitem.workunits_needed
		if craftingitem.repeats != 0:
			if globals.check_recipe_resources(craftingitem) == true:
				globals.spend_resources(craftingitem)
				if craftingitem.workunits >= craftingitem.workunits_needed:
					make_item_sequence(currenttask, craftingitem)
			else:
				if currenttask.messages.has('noresources') == false:
					print("make_item_sequence")
					globals.text_log_add('crafting', parent.get_short_name() + ": " + "Not Enough Resources for craft. ")
					currenttask.messages.append("noresources")

func get_progress_task(temptask, tempsubtask, count_crit = false):
	var location = ResourceScripts.world_gen.get_location_from_code(parent.get_location())
	var task = races.tasklist[temptask]
	var subtask = task.production[tempsubtask]
	var value = call(subtask.progress_function)
	var item
	if parent.equipment.gear.tool != null:
		item = ResourceScripts.game_res.items[parent.equipment.gear.tool]
	if item != null && task.has('worktool') && task.worktool in item.toolcategory:
		if item.bonusstats.has("task_efficiency_tool"):
			value = value + value*item.bonusstats.task_efficiency_tool
	value = value * (parent.get_stat('productivity') * parent.get_stat(task.mod)/100.0)#*(productivity*get(currenttask.mod)/100)
	if item != null && task.has('worktool') && task.worktool in item.toolcategory:
		if count_crit == true && item.bonusstats.has("task_crit_chance") && randf() <= item.bonusstats.task_crit_chance:
			value = value*2
	if location.has('gather_mod'):
		value *= location.gather_mod
	return value

func get_progress_resource(tempresource, count_crit = false):
	var resource = Items.materiallist[tempresource]
	var location = ResourceScripts.world_gen.get_location_from_code(parent.get_location())
	# var subtask = task.production[tempsubtask]
	var value = call(resource.progress_formula)
	var item
	if parent.equipment.gear.tool != null:
		item = ResourceScripts.game_res.items[parent.equipment.gear.tool]
	if item != null && resource.has('tool_type') && resource.tool_type in item.toolcategory:
		if item.bonusstats.has("task_efficiency_tool"):
			value = value + value*item.bonusstats.task_efficiency_tool
	value = value * (parent.get_stat('productivity') * parent.get_stat(resource.workmod)/100.0)#*(productivity*get(currenttask.mod)/100)
	if item != null && resource.has('tool_type') && resource.tool_type in item.toolcategory:
		if count_crit == true && item.bonusstats.has("task_crit_chance") && randf() <= item.bonusstats.task_crit_chance:
			value = value*2
	if location.has('gather_mod'):
		value *= location.gather_mod
	return value
