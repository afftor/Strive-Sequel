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
		i.cooldown_tick()
		i.process_event(variables.TR_DAY)

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
	pass

#slaves operations
func add_slave(person, child = false):
	if child: characters_pool.move_baby_to_state(person.id) 
	else: characters_pool.move_to_state(person.id)
	person.is_players_character = true
	person.is_active = true
	if person.get_stat('unique') != null:
		ResourceScripts.game_world.easter_egg_characters_acquired.append(person.get_stat('unique'))
	person.fill_masternoun()
	globals.text_log_add("slaves","New character acquired: " + person.get_short_name() + ". ")
	globals.emit_signal("slave_added")

func remove_slave(tempslave, permanent = false):
	tempslave.process_event(variables.TR_REMOVE)
	characters_pool.move_to_pool(tempslave.id)
	tempslave.is_players_character = false
	if permanent: tempslave.is_active = false
	character_order.erase(tempslave.id)
	input_handler.update_slave_list()


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

func get_unique_slave(code):
	for i in characters.values():
		if i.get_stat('unique') == code:
			return i

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
