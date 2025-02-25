extends Reference
#extends Node


var characters = {}
var babies = {}
var active_tasks = []

var farming_slots = {}

var relativesdata = {}
var relationship_data = {}
var global_skills_used = {}

var combatparty = {1 : null, 2 : null, 3 : null, 4 : null, 5 : null, 6 : null} #setget pos_set

var character_order = []

func _get_key(char1, char2):
	var pair = [char1, char2]
	pair.sort()
	return pair[0] + "_" + pair[1]

func _get_key_from_dict(data):
	for i in relationship_data.keys():
		if relationship_data[i] == data:
			return i

func _get_data(char1, char2):
	return relationship_data[_get_key(char1, char2)]



func add_relationship_value(char1, char2, value):
	var key = _get_key(char1, char2)
	
	if relationship_data.has(key):
		if relationship_data[key].status in ['friends', 'lovers', 'freelovers'] && value < 0:
			value *= 0.5 #makes established relationship reduce slower
	
	
	
	if relationship_data.has(key):
		relationship_data[key].value += value
	else:
		relationship_data[key] = {value = 50, status = 'acquintances'}
		relationship_data[key].value = variables.relationship_base + value
	relationship_data[key].value = clamp(relationship_data[key].value, 0, 100)
	update_relationship_status(relationship_data[key], char1, char2)

func update_relationship_status(data, char1, char2):
	var value = data.value
	var status = data.status
	if value <= 25:
		change_relationship_status(char1, char2, 'rivals')
	elif value >= 75:
		
		if !['friends','lovers','freelovers'].has(status):
			data.status = 'friends'
		else:
			if randf() >= 0.2 && check_lover_possibility(data, char1, char2) && _in_same_location(char1, char2):
				attempt_romance(char1, char2)
	else:
		if status in ['friends','lovers','freelovers'] && value >= 60:
			pass
		else:
			change_relationship_status(char1, char2, 'acquintances')
	#print(data)

func attempt_romance(char1, char2):
	var relationship = _get_data(char1, char2)
	var lovers_chance = 0
	var freelovers_chance = 0
	
	if relationship.value >= 75:
		freelovers_chance += 15
	if relationship.value >= 90:
		lovers_chance += 10
		if relationship.status == 'freelovers':
			lovers_chance += 10
	
	if relationship.status == 'freelovers':
		freelovers_chance = 0
	if relationship.status == 'lovers':
		freelovers_chance = 0
		lovers_chance = 0
	print("attempting romance")
	if randf() * 100 <= freelovers_chance:
		input_handler.interactive_message('character_freelovers','story_event',{char1 = char1, char2 = char2})
	elif randf() * 100 <= lovers_chance:
		input_handler.interactive_message('character_lovers','story_event',{char1 = char1, char2 = char2})


func _in_same_location(char1, char2):
	var person1 = characters_pool.get_char_by_id(char1)
	var person2 = characters_pool.get_char_by_id(char2)
	if person1.is_on_quest() or person2.is_on_quest():
		return false
	if person1.get_location() != person2.get_location():
		return false
	if person1.get_location() == ResourceScripts.game_world.mansion_location:
		if person1.xp_module.work == person2.xp_module.work:
			if person1.xp_module.work == 'brothel' or person1.xp_module.work == '':
				return true
			return person1.xp_module.workproduct == person2.xp_module.workproduct
		else:
			return false
	else:
		return true

func relation_daily_change_same_loc(char1, char2):
	var value = 0
	if relationship_data.has(_get_key(char1,char2)) == false:
		relationship_data[_get_key(char1,char2)] = {value = 50, status = 'acquintances'}
	var base_value = relationship_data[_get_key(char1, char2)].value
	var weights = [['positive', 66], ['negative', 33]]
	
	if base_value >= 50:
		# Reduce negative weight proportionally down to 1 when value is 65
		if base_value > 65:
			weights[1][1] = 1
		else:
			weights[1][1] = 33 - int(32 * (value - 50) / 15)
	
	elif base_value < 50:
		# Reduce positive weight proportionally down to 1 when value is 35
		if base_value < 35:
			weights[0][1] = 1
		else:
			weights[0][1] = 66 - int(65 * (50 - value) / 15)
	
	var outcome = input_handler.weightedrandom(weights)
	if outcome == 'positive':
		value = int(rand_range(30,77))
	else:
		value = int(rand_range(-3,-7))
	
	add_relationship_value(char1, char2, value)

func relationship_decay():
	for key in relationship_data.keys():
		var chars = key.split("_")
		if _in_same_location(chars[0],chars[1]) == false:
			var value
			if relationship_data[key].value > 51:
				value = -4
			elif relationship_data[key].value < 50:
				value = 4
			add_relationship_value(chars[0],chars[1], value)



func check_lover_possibility(data, char1, char2):
	
	var person1 = characters_pool.get_char_by_id(char1)
	var person2 = characters_pool.get_char_by_id(char2)
	
	var endvalue = false
	
	
	if person1.get_stat('sex') == person2.get_stat('sex') && (!person1.check_trait("bisexual") || !person2.check_trait("bisexual")): 
		endvalue = false
		print('checking lover possibility: false, same sex and no bisexual')
	elif person1.get_stat('sex') == person2.get_stat('sex') && person1.check_trait("bisexual") && person2.check_trait("bisexual"): 
		endvalue = true
	elif person1.get_stat('sex') != person2.get_stat('sex'):
		endvalue = true
	
	if endvalue == true:
		if person1.check_trait("monogamous") && has_love_status(char1) || person2.check_trait("monogamous") && has_love_status(char2) :
			endvalue = false
			print('checking lover possibility: false, is monogamous and in relationship ')
	print(endvalue)
	return endvalue

func has_love_status(char1):
	for key in relationship_data.keys():
		if char1 in key.split("_"):
			var relation = relationship_data[key].status
			if "lovers" in relation or "freelovers" in relation:
				return true
	return false

func change_relationship_status(char1, char2, new_status):
	_get_data(char1, char2).status = new_status

#func pos_set(value):
#	combatparty = value
#	for p in combatparty:
#		if combatparty[p] == null: continue

func advance_day():
	update_global_cooldowns()
	for i in characters.values():
		i.tags.erase("no_date_day")
		i.cooldown_tick()
		i.process_event(variables.TR_DAY)
		i.quest_day_tick()
	relationship_decay()
	var counter = 0
	for i in range(character_order.size() - 1):
		counter += 1
		for j in range(i + 1, character_order.size()):
			counter += 1
			if _in_same_location(character_order[i],character_order[j]): relation_daily_change_same_loc(character_order[i],character_order[j])
	#print(counter)

func serialize():
	var res = inst2dict(self)
	res.characters = {}
	res.babies = {}
	for p in characters:
		res.characters[p] = characters[p].serialize()
	for p in babies:
		res.babies[p] = babies[p].serialize()
	return res

func fix_serialization():
	for p in characters:
		characters[p] = dict2inst(characters[p])
		characters[p].fix_serialization()
	for p in babies:
		babies[p] = dict2inst(babies[p])
		babies[p].fix_serialization()
	for dir in relativesdata.values():
		if typeof(dir.father) != TYPE_STRING: dir.father = null
		if typeof(dir.mother) != TYPE_STRING: dir.mother = null
	for task in active_tasks:
		if task.has('threshhold'):
			task.threshold = task.threshhold
			task.erase('threshhold')
		if task.messages.has('noresources'):
			task.messages.erase('noresources')
	for task in active_tasks.duplicate():
		if task.product == 'rest':
			active_tasks.erase(task)



func fix_serialization_postload():
	for p in characters:
		characters[p].fix_serialization_postload()
	for p in babies:
		babies[p].fix_serialization_postload()
	for p in characters_pool.characters:
		characters_pool.characters[p].fix_serialization_postload()


func fix_import():
	active_tasks.clear()
	for p in characters:
		characters[p].fix_import()

#slaves operations
#func unlock_mentor():
#	for p in characters:
#		if characters[p].is_master(): 
#			continue
#		for tr in variables.mentorship_list:
#			characters[p].add_trait(tr)


func add_slave(person, child = false):
	if child: characters_pool.move_baby_to_state(person.id)
	else: characters_pool.move_to_state(person.id)
	person.is_players_character = true
	person.is_active = true
#	person.statlist.bonuses.erase('price_mul')
#	character_order.push_back(person.id)
	if person.is_unique():
		ResourceScripts.game_world.easter_egg_characters_acquired.append(person.get_stat('unique'))
	person.fill_masternoun()
	person.set_stat('metrics_ownership', ResourceScripts.game_globals.get_date()[0])
	globals.text_log_add("slaves","New character acquired: " + person.get_short_name() + ". ")
	globals.emit_signal("slave_added")


func remove_slave(tempslave, permanent = false):
	tempslave.remove_from_task()
	tempslave.unequip_all()
	tempslave.clear_training()
	tempslave.process_event(variables.TR_REMOVE)
	characters_pool.move_to_pool(tempslave.id)
	tempslave.is_players_character = false
	if permanent: tempslave.is_active = false
	character_order.erase(tempslave.id)
#	input_handler.update_slave_list()
	input_handler.rebuild_slave_list()
	gui_controller.mansion.set_active_person(ResourceScripts.game_party.get_master())


func clear_heroes():
	for p in characters:
		characters[p].is_active = false
	characters_pool.cleanup()


func subtract_taxes():
	var tax = 0
	for ch in characters.values():
		if !ch.is_active:
			continue
		if !ch.get_stat('slave_class') == 'servant':
			continue
		tax += ch.calculate_price() * (1.0 - 0.05 * ch.get_stat('tame_factor'))
	ResourceScripts.game_res.money -= int (3 * tax / 100)

#arguable here
func update_global_cooldowns():
	for i in global_skills_used.duplicate():
		global_skills_used[i] -= 1
		if global_skills_used[i] <= 0:
			global_skills_used.erase(i)

func get_food_consumption():
	var counter = 0
	for i in characters.values():
		counter += i.get_stat("food_consumption")
	return counter


func predict_char_event():
	var res = 1000
	for i in characters.values():
		var tmp = i.predict_preg_time()
		if tmp != null and tmp < res:
			res = tmp
	return int(ceil(res))

#finders
func get_master():
	for i in characters.values():
		if i.has_profession("master"):
			return i
	return null

func get_spouse():
	var tmp = characters_pool.get_char_by_id(ResourceScripts.game_progress.spouse) 
	if tmp == null: return null
	if !tmp.is_active: return null
	if !tmp.is_players_character: return null
	return tmp


func get_unique_slave(code):
	for i in characters.values():
		if i.get_stat('unique') == code:
			return i
	return null


func has_nonunics():
	for i in characters.values():
		if i.is_master(): continue
		if i.is_unique(): continue
		return true
	return false

func get_character_by_pos(pos):
	if combatparty[pos] == null: return null
	return characters[combatparty[pos]]

#checks
func if_has_hero(name):
	for h in characters.values():
		if h.get_stat('unique') == name: return true
	return false

func if_master_is_beast(boolean):
	var character = get_master()
	if character == null:
		return false
	return character.checkreqs([{code = 'race_is_beast', check = boolean}])

func if_master_has_stat(name, operant, value):
	var character = get_master()
	if character == null:
		return false
	return input_handler.operate(operant, character.get(name), value)

func if_party_level(operant,value):
	var counter = 0
	for i in combatparty.values():
		if i != null:
			counter += characters[i].get_stat('level')
	return input_handler.operate(operant, counter, value)

func if_hero_level(name, operant, value):
	var hero
	for h in characters.values():
		if h.get_stat("name") == name: hero = h
	return input_handler.operate(operant, hero.get_stat("level"), value)

func check_profession_limit(name, value):
	var counter = 0
	for i in characters.values():
		if i.has_profession(name):
			counter += 1
	return counter < value

func heal_full_party():
	for i in characters.values():
		i.heal(i.hp)


func get_output_for_task(tsk, loc_id, predict = false):
	var res = 0
	for task in active_tasks:
		if task.code == tsk and task.task_location == loc_id:
			for worker_id in task.workers:
				var tmp = characters_pool.get_char_by_id(worker_id)
				res += tmp.get_progress_task(task.code, task.product, !predict)
	return res


func get_characters_for_task(tsk):
	var res = 0
	for i in characters.values():
		if i.get_work() == tsk:
			res += 1
	return res

func clean_tasks(loc_id):
	var tarr = []
	for i in active_tasks:
		if i.task_location == loc_id:
			clean_task(i)
			tarr.push_back(i)
	for i in tarr:
		active_tasks.erase(i)


func clean_task(task):
	for id in task.workers.duplicate():
		var tchar = characters_pool.get_char_by_id(id)
		if tchar.check_task(task): #character is not removed from task before
			tchar.remove_from_task() #character should normally be set to ni work and removed from workers list
			if tchar.check_task(task): #character is STILL not removed from task
				print("error - %s not removing from task" % id)
				task.workers.erase(id)
			if task.workers.has(id): #character is STILL not removed from task
				print("error - %s removal from task wasn' correct" % id)
				task.workers.erase(id)
#		else: #data for character is inconsistent
#			task.workers.erase(id)


func find_task_for_quest(q_id):
	for task in active_tasks:
		if !task.has('args'): 
			continue
		for dir in task.args:
			if dir.code != 'finish_worktask':
				continue
			if dir.value == q_id:
				return task
	return null


func remove_quest_task(q_id):
	var task = find_task_for_quest(q_id)
	if task != null:
		clean_task(task)
		active_tasks.erase(task)
		globals.emit_signal("task_removed")


func calculate_food_consumption():
	var res = {}
	for i in characters.values():
		var tmp = i.predict_food()
		for food in tmp:
			if res.has(food): res[food] += tmp[food]
			else: res[food] = tmp[food]
	return res


func get_farm():
	for i in range(ResourceScripts.game_res.get_farm_slots()):
		var slot = 'slot%d' % i
		if !farming_slots.has(slot):
			farming_slots[slot] = null
		if farming_slots[slot] == null:
			continue
		if !characters.has(farming_slots[slot]):
			farming_slots[slot] = null
			continue
		var person = characters[farming_slots[slot]]
		if !person.is_active:
			farming_slots[slot] = null
			continue
		if person.get_work() != 'produce':
			farming_slots[slot] = null
			continue
	return farming_slots


func remove_char_from_farm(ch_id):
	for slot in farming_slots:
		if farming_slots[slot] == ch_id:
			farming_slots[slot] = null


#reworked from globals
func get_relatives_data(id):
	if !relativesdata.has(id):
		return null
	return relativesdata[id]


func connectrelatives_old(person1, person2, way):
	if person1 == null || person2 == null:
		return
	if relativesdata.has(person1.id) == false:
		createrelativesdata(person1)
	if relativesdata.has(person2.id) == false:
		createrelativesdata(person2)
	if way in ['mother','father']:
		var entry = relativesdata[person1.id]
		entry.children.append(person2.id)
		for i in entry.children:
			if i != person2.id:
				var entry2 = ResourceScripts.game_party.relativesdata[i]
				connectrelatives_old(person2, entry2, 'sibling')
		entry = ResourceScripts.game_party.relativesdata[person2.id]
		entry[way] = person1.id
		if typeof(person1) != TYPE_DICTIONARY && typeof(person2) != TYPE_DICTIONARY:
			globals.addrelations(person1, person2, 200)
	elif way == 'sibling':
		var entry = ResourceScripts.game_party.relativesdata[person1.id]
		var entry2 = ResourceScripts.game_party.relativesdata[person2.id]
		if entry.siblings.has(entry2.id) == false: entry.siblings.append(entry2.id)
		if entry2.siblings.has(entry.id) == false: entry2.siblings.append(entry.id)
		for i in entry.siblings + entry2.siblings:
			if !ResourceScripts.game_party.relativesdata[i].siblings.has(entry.id) && i != entry.id:
				ResourceScripts.game_party.relativesdata[i].siblings.append(entry.id)
			if !ResourceScripts.game_party.relativesdata[i].siblings.has(entry2.id) && i != entry2.id:
				ResourceScripts.game_party.relativesdata[i].siblings.append(entry2.id)
			if !entry.siblings.has(i) && i != entry.id:
				entry.siblings.append(i)
			if !entry2.siblings.has(i) && i != entry2.id:
				entry2.siblings.append(i)

		if typeof(person1) != TYPE_DICTIONARY && typeof(person2) != TYPE_DICTIONARY:
			globals.addrelations(person1, person2, 0)


func connectrelatives(id1, id2, way): #id1 - child, 'main' char in this construction
	if !relativesdata.has(id1):
		var person = characters_pool.get_char_by_id(id1)
		if person == null: 
			print('error - try to connect nonexisting character %s with no relatives record at the correct data state' % id1)
			return
		createrelativesdata(person)
	var data1 = relativesdata[id1]
	if !relativesdata.has(id2):
		var person = characters_pool.get_char_by_id(id2)
		if person == null: 
			print('error - try to connect nonexisting character %s with no relatives record at the correct data state' % id2)
			return
		createrelativesdata(person)
	var data2 = relativesdata[id2]
	match way:
		'mother', 'father':
			data1[way] = id2
			connect_parent(id1, id2)
			globals.addrelations(characters_pool.get_char_by_id(id1), characters_pool.get_char_by_id(id2), 200)
		'sibling':
			data1.siblings.push_back(id2)
			connect_siblings(id1, id2)
			globals.addrelations(characters_pool.get_char_by_id(id1), characters_pool.get_char_by_id(id2), 0)

func connect_parent(id1, id2): #id1 - child, 'main' char in this construction, so data1 should be configured partially properly at the point of callback
	var data1 = relativesdata[id1]
	var data2 = relativesdata[id2]
	if data2.children.has(id1):
		print('possibly duplicating relatives connection %s to %s' % [id1, id2])
		return
	data2.children.push_back(id1)
	for id in data2.children:
		if id == id1: continue
		if data1.siblings.has(id): continue
		data1.siblings.push_back(id)
	for id in data1.siblings:
		connect_siblings(id1, id)

func connect_siblings(id1, id2): #id1 - child, 'main' char in this construction, so data1 should be configured properly at the point of callback
	var data1 = relativesdata[id1]
	var data2 = relativesdata[id2]
	if data2.siblings.has(id1):
		return #possibly incorrect in case of inconsistent data
	else:
		data2.siblings.push_back(id1)
	#consistensy check
	for id in data2.siblings:
		if id == id1: continue
		if data1.siblings.has(id): continue
		if check_common_parents(id1, id) > 0:
			print("warning - %d was lost from its parent's relations" % id) 
			data1.siblings.push_back(id)
			connect_siblings(id1, id)

func check_common_parents(id1, id2): #derived relation - for partially correct data state
	var res = 0
	if !relativesdata.has(id1):
		print('warning - relatives data references character %s with no data in unstable state by undirect request' % id1)
		var person = characters_pool.get_char_by_id(id1)
		if person == null: 
			print('warning - relatives data references unexisting character %s with no relatives record ' % id1)
			return 0
		createrelativesdata(person)
	var data1 = relativesdata[id1]
	if !relativesdata.has(id2):
		print('warning - relatives data references character %s with no data in unstable state by undirect request' % id2)
		var person = characters_pool.get_char_by_id(id2)
		if person == null: 
			print('warning - relatives data references unexisting character %s with no relatives record ' % id2)
			return 0
		createrelativesdata(person)
	var data2 = relativesdata[id2]
	for i in ['mother','father']:
		if data1[i] == null: continue
		for j in ['mother','father']:
			if data2[j] == null: continue
			if data1[i] == data2[j]:
				res += 1
	return res


func createrelativesdata(person):
	var newdata = {
		name = person.get_full_name(), 
		id = person.id, 
		race = person.get_stat('race'), 
		sex = person.get_stat('sex'),
		mother = null, 
		father = null, 
		siblings = [], 
#		halfsiblings = [], not used 
		children = []
	}
	relativesdata[person.id] = newdata

func clearrelativesdata(id): #not used but mb useful later 
	var entry
	if relativesdata.has(id):
		entry = relativesdata[id]
		
		for i in ['mother','father']:
			if relativesdata.has(entry[i]):
				var entry2 = relativesdata[entry[i]]
				entry2.children.erase(id)
		for i in entry.siblings:
			if relativesdata.has(i):
				var entry2 = relativesdata[i]
				entry2.siblings.erase(id)
		
		relativesdata.erase(id)

func checkifrelatives(id1, id2):
	var data1
	var data2
	if !relativesdata.has(id1):
		var person = characters_pool.get_char_by_id(id1)
		if person == null: return false
		createrelativesdata(person)
	data1 = relativesdata[id1]
	if !relativesdata.has(id2):
		var person = characters_pool.get_char_by_id(id2)
		if person == null: return false
		createrelativesdata(person)
	data2 = relativesdata[id2]
	for i in ['mother','father']:
		if str(data1[i]) == id2 or str(data2[i]) == id1:
			return true
	if data2.siblings.has(id1) or data1.siblings.has(id2): #double-check
		return true
	return false


func add_fate(ch_id, value):
	if !relativesdata.has(ch_id):
		var person = characters_pool.get_char_by_id(ch_id)
		if person == null: return
		createrelativesdata(person)
	var data = relativesdata[ch_id]
	data.fate = value

func force_update_portraits():
	for id in characters:
		var person = characters_pool.get_char_by_id(id)
		if person == null: 
			return
		person.update_prt()
