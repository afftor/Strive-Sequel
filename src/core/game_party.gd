extends Reference
#extends Node


var characters = {}
var babies = {}
var active_tasks = []
var relativesdata = {}
var global_skills_used = {}

var combatparty = {1 : null, 2 : null, 3 : null, 4 : null, 5 : null, 6 : null} #setget pos_set

var character_order = []

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
func add_slave(person, child = false):
	if child: characters_pool.move_baby_to_state(person.id)
	else: characters_pool.move_to_state(person.id)
	person.is_players_character = true
	person.is_active = true
	person.statlist.bonuses.erase('price_mul')
#	character_order.push_back(person.id)
	if person.get_stat('unique') != null:
		ResourceScripts.game_world.easter_egg_characters_acquired.append(person.get_stat('unique'))
	person.fill_masternoun()
	globals.text_log_add("slaves","New character acquired: " + person.get_short_name() + ". ")
	globals.emit_signal("slave_added")

func remove_slave(tempslave, permanent = false):
	tempslave.remove_from_task()
	tempslave.process_event(variables.TR_REMOVE)
	characters_pool.move_to_pool(tempslave.id)
	tempslave.is_players_character = false
	if permanent: tempslave.is_active = false
	character_order.erase(tempslave.id)
#	input_handler.update_slave_list()
	input_handler.rebuild_slave_list()


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
		if i.get_stat('unique') != null: continue
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


func get_output_for_task(tsk, loc_id):
	var res = 0
	for task in active_tasks:
		if task.code == tsk and task.task_location == loc_id:
			for worker_id in task.workers:
				var tmp = characters_pool.get_char_by_id(worker_id)
				res += tmp.get_progress_task(task.code, task.product, true)
	return res


func calculate_food_consumption():
	var res = {}
	for i in characters.values():
		var tmp = i.predict_food()
		for food in tmp:
			if res.has(food): res[food] += tmp[food]
			else: res[food] = tmp[food]
	return res

#reworked from globals
func connectrelatives_old(person1, person2, way):
	if person1 == null || person2 == null:
		return
	if ResourceScripts.game_party.relativesdata.has(person1.id) == false:
		createrelativesdata(person1)
	if ResourceScripts.game_party.relativesdata.has(person2.id) == false:
		createrelativesdata(person2)
	if way in ['mother','father']:
		var entry = ResourceScripts.game_party.relativesdata[person1.id]
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

