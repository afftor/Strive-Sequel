extends Node

#warning-ignore-all:unused_signal
#warning-ignore-all:return_value_discarded


signal task_added
signal slave_added
signal slave_arrived
signal hour_tick

var date = 1
var hour = 6

var hour_turns_set = 1

var log_node
var log_storage = []

var newgame = false

var votelinksseen = false

#world
var areas = {}
var area_order = []
var starting_area = 'Plains'
var location_links = {}
var completed_locations = {}

#resources
var itemcounter = 0
var slavecounter = 0
var locationcounter = 0
var questcounter = 0
var money = 0
var upgrades = {}
var upgrade_progresses = {}
var selected_upgrade = {code = '', level = 0}
var characters = {} 
var babies = {}
var items = {}
var active_tasks = []
var craftinglists = {alchemy = [], smith = [], cooking = [], tailor = []}
var materials = {} setget materials_set
var oldmaterials = {}
var relativesdata = {}
var global_skills_used = {}

var combatparty = {1 : null, 2 : null, 3 : null, 4 : null, 5 : null, 6 : null} setget pos_set

var character_order = []

var CurrentTextScene
var CurrentScreen
var CurrentLine = 0

var stored_events = {
	timed_events = [],
	
	
}

#Progress
var mainprogress = 0
var decisions = []
var activequests = []
var completedquests = []
var areaprogress = {}
var currentarea
var active_tutorials = []
var seen_tutorials = []
var show_tutorial = true

var daily_interactions_left = 1


func revert():
#to make
	date = 1
	hour = 6
	itemcounter = 0
	slavecounter = 0
	locationcounter = 0
	daily_interactions_left = 1
	area_order.clear()
	mainprogress = 0
	decisions.clear()
	activequests.clear()
	completedquests.clear()
	characters.clear()
	character_order.clear()
	areaprogress.clear()
	currentarea = null
	items.clear()
	materials.clear()
	for i in Items.materiallist:
		materials[i] = 0
	globals._ready()
	global_skills_used.clear()
	active_tasks.clear()
	completed_locations.clear()
	completedquests.clear()
	craftinglists = {alchemy = [], smith = [], cooking = [], tailor = []}
	stored_events = {timed_events = []}
	for i in variables.starting_resources:
		materials[i] = variables.starting_resources[i]
	state.areas.clear()
	state.location_links.clear()
	show_tutorial = true
	active_tutorials.clear()
	seen_tutorials.clear()

func make_world():
	world_gen.build_world()

func _ready():
	connect("hour_tick", self, 'check_timed_events')
	input_handler.connect("EnemyKilled", self, "quest_kill_receiver")
	revert()

func update_global_cooldowns():
	for i in global_skills_used.duplicate():
		global_skills_used[i] -= 1
		if global_skills_used[i] <= 0:
			global_skills_used.erase(i)

func pos_set(value):
	combatparty = value
	for p in combatparty:
		if combatparty[p] == null: continue

func get_pop_cap():
	return variables.base_population_cap + variables.population_cap_per_room_upgrade * upgrades.rooms

func materials_set(value):
	var text = ''
	for i in value:
		if oldmaterials.has(i) == false || oldmaterials[i] != value[i]:
			if oldmaterials.has(i) == false:
				oldmaterials[i] = 0
			else:
				if oldmaterials[i] - value[i] < 0:
					text += 'Gained '
					input_handler.emit_signal("MaterialObtained", i)
				else:
					text += "Lost "
				text += str(value[i] - oldmaterials[i]) + ' {color=yellow|' + Items.materiallist[i].name + '}'
				#logupdate(text)
	materials = value
	oldmaterials = materials.duplicate()

func get_master():
	for i in characters.values():
		if i.professions.has("master"):
			return i

func get_unique_slave(code):
	for i in characters.values():
		if i.unique == code:
			return i

func add_slave(person):
	characters_pool.move_to_state(person.id)
	person.is_players_character = true
	person.is_active = true
	text_log_add("slaves","New character acquired: " + person.get_short_name() + ". ")
	emit_signal("slave_added")

func if_has_money(value):
	return (money >= value)

func if_has_property(prop, value):
	var tmp = get(prop)
	if tmp == null: 
		print ("ERROR: NO PROPERTY IN GAMESTATE %s\n", prop)
		return false
	return (tmp >= value)

func if_has_hero(name):
	for h in characters.values():
		if h.unique == name: return true
	return false

func if_has_material(mat, operant, val):
	if !materials.has(mat): return false
	return input_handler.operate(operant, materials[mat], val)

func checkreqs(array):
	var check = true
	for i in array:
		if i.has('orflag'):
			check = check or valuecheck(i)
		else:
			check = check and valuecheck(i)
	return check

func valuecheck(dict):
	if !dict.has('type'): return true
	match dict['type']:
		"no_check":
			return true
		"has_money":
			return if_has_money(dict['value'])
		"has_property":
			return if_has_property(dict['prop'], dict['value'])
		"has_hero":
			return if_has_hero(dict['name'])
		"has_material":
			return if_has_material(dict['material'], dict.operant, dict['value'])
		"date":
			if variables.no_event_wait_time: return true
			return input_handler.operate(dict.operant, date, dict.value)
		'hour':
			if variables.no_event_wait_time: return true
			return input_handler.operate(dict.operant, hour, dict.value)
		"gamestart":
			return newgame
		"has_upgrade":
			return if_has_upgrade(dict.name, dict.value)
		"main_progress":
			return if_has_progress(dict.value, dict.operant)
		"area_progress":
			return if_has_area_progress(dict.value, dict.operant, dict.area)
		"decision":
			return decisions.has(dict.name)
		"quest_stage":
			return if_quest_stage(dict.name, dict.value, dict.operant)
		"quest_completed":
			return completedquests.has(dict.name)
		"party_level":
			return if_party_level(dict.operant, dict.value)
		"hero_level":
			if if_has_hero(dict.name) == false:
				return false
			else:
				return if_hero_level(dict.name, dict.operant, dict.value)
		"has_items":
			return if_has_items(dict.name, dict.operant, dict.value)
		"has_free_items":
			return if_has_free_items(dict.name, dict.operant, dict.value)
		'disabled':
			return false
		'master_stat':
			return if_master_has_stat(dict.name, dict.operant, dict.value)
		'master_is_beast':
			return if_master_is_beast(dict.value)
		'unique_character_at_mansion':
			var character = get_unique_slave(dict.value)
			if character == null:return false
			return character.checkreqs([{code = 'is_free'}])
		'active_character_checks':
			var character = input_handler.active_character
			if character == null:return false
			return character.checkreqs(dict.charreqs)
		'has_money_for_scene_slave':
			return money >= input_handler.scene_characters[dict.value].calculate_price()

func if_master_is_beast(boolean):
	var character = get_master()
	if character == null:
		return false
	return character.checkreqs([{code = 'race_is_beast', value = boolean}])

func if_master_has_stat(name, operant, value):
	var character = get_master()
	if character == null:
		return false
	return input_handler.operate(operant, character.get(name), value)

func if_has_items(name, operant, value):
	var counter = 0
	for i in items.values():
		if i.itembase == name:
			counter += 1
	return input_handler.operate(operant, counter, value)

func if_has_free_items(name, operant, value):
	var counter = 0
	for i in items.values():
		if i.itembase == name && i.owner == null:
			counter += i.amount
	return input_handler.operate(operant, counter, value)

func if_quest_stage(name, value, operant):
	var questprogress
	#questprogress = GetQuest(name)
	if questprogress == null:
		questprogress = 0
	
	return input_handler.operate(operant, questprogress, value)

func if_has_area_progress(value, operant, area):
	if !areaprogress.has(area):return false
	return input_handler.operate(operant, areaprogress[area], value)

func if_has_progress(value, operant):
	return input_handler.operate(operant, mainprogress, value)

func if_has_upgrade(upgrade, level):
	if !upgrades.has(upgrade): return false
	else: return upgrades[upgrade] >= level

func get_character_by_pos(pos):
	if combatparty[pos] == null: return null
	return characters[combatparty[pos]]

func if_party_level(operant,value):
	var counter = 0
	for i in combatparty.values():
		if i != null:
			counter += characters[i].level
	return input_handler.operate(operant, counter, value)

func if_hero_level(name, operant, value):
	var hero
	for h in characters.values():
		if h.name == name: hero = h
	return input_handler.operate(operant, hero.level, value)

func remove_item(itemcode, number):
	while number > 0:
		var item
		for i in items.values():
			if i.itembase == itemcode:
				item = i
				break
		if item != null:
			item.amount -= 1
		number -= 1

func set_material(material, operant, value):
	match operant:
		'+':
			materials[material] += value
		'-':
			materials[material] -= value
		'*':
			materials[material] *= value
		"/":
			materials[material] /= value
		'=':
			materials[material] = value

func remove_slave(tempslave, permanent = false):
	tempslave.process_event(variables.TR_REMOVE)
	characters_pool.move_to_pool(tempslave.id)
	tempslave.is_players_character = false
	if permanent: tempslave.is_active = false
	character_order.erase(tempslave.id)
	input_handler.update_slave_list()

func text_log_add(label, text):
	log_storage.append({type = label, text = text, time = str(date) + ":" + str(round(hour))})
	if log_node != null && weakref(log_node) != null:
		var newfield = log_node.get_node("ScrollContainer/VBoxContainer/field").duplicate()
		newfield.show()
		newfield.get_node("label").bbcode_text = label
		newfield.get_node("text").bbcode_text = text
		newfield.get_node("date").bbcode_text = '[right]'+ str(date) + " - " + str(round(hour)) + ":00[/right]"
		log_node.get_node("ScrollContainer/VBoxContainer").add_child(newfield)
		yield(get_tree(), 'idle_frame')
		var textfield = newfield.get_node('text')
		textfield.rect_size.y = textfield.get_v_scroll().get_max()
		newfield.rect_min_size.y = textfield.rect_size.y
		

func serialize():
	var tmp = {}
	#to add serializing
	tmp['characters'] = characters_pool.serialize()
	tmp['state'] = inst2dict(self)
	#tmp['state']['items'].clear()
	#tmp['state']['characters'].clear()
	tmp['items'] = {}
	tmp['heroes'] = {}
	for i in items:
		tmp['items'][i] = inst2dict(items[i])
	for h in characters:
		tmp['heroes'][h] = inst2dict(characters[h])
		characters[h].fix_serialize(tmp['heroes'][h])
	tmp['effects'] = effects_pool.serialize()
	return tmp

func deserialize(tmp:Dictionary):
	characters_pool.deserialize(tmp['characters'])
	var tempstate = dict2inst(tmp['state'])
	var prlist = tempstate.get_property_list()
	#set('date', tempstate.get('date'))
	for v in prlist:
		if !(v.usage & PROPERTY_USAGE_SCRIPT_VARIABLE) : continue
		set(v.name, tempstate.get(v.name))
	selected_upgrade.level = int(selected_upgrade.level)
	items.clear()
	for i in tmp['items']:
		items[i] = dict2inst(tmp['items'][i])
		items[i].inventory = items
	characters.clear()
	for h in tmp['heroes']:
		characters[h] = dict2inst(tmp['heroes'][h])
		#fixing saved skill shortcuts
		var ssp = characters[h].social_skill_panel.duplicate()
		characters[h].social_skill_panel.clear()
		for i in ssp:
			if Skilldata.Skilllist.has(ssp[i]):
				characters[h].social_skill_panel[int(i)] = ssp[i]
		ssp = characters[h].combat_skill_panel.duplicate()
		characters[h].combat_skill_panel.clear()
		for i in ssp:
			if Skilldata.Skilllist.has(ssp[i]):
				characters[h].combat_skill_panel[int(i)] = ssp[i]
		
		var cleararray = []
		for i in [characters[h].social_skills, characters[h].combat_skills]:
			for k in i:
				if Skilldata.Skilllist.has(k) == false:
					cleararray.append(k)
		for i in cleararray:
			for k in [characters[h].social_skills, characters[h].combat_skills]:
				k.erase(i)
		
		
	tempstate.free()
	effects_pool.deserialize(tmp['effects'])
	#fastfix for broken saves
	characters_pool.cleanup()
	effects_pool.cleanup()
	
	for i in Items.materiallist:
		if materials.has(i) == false:
			materials[i] = 0
	

func common_effects(effects):
	for i in effects:
		match i.code:
			'money_change':
				money = input_handler.math(i.operant, money, i.value)
				text_log_add('money',"Gold used: " + str(i.value))
			'make_story_character':
				var newslave = Slave.new()
				newslave.generate_predescribed_character(world_gen.pregen_characters[i.value])
				newslave.set_slave_category(newslave.slave_class)
				state.add_slave(newslave)
			'add_timed_event':
				var newevent = {reqs = [], code = i.value}
				for k in i.args:
					match k.type:
						'add_to_date':
							var newreq = [{type = 'date', operant = 'eq', value = state.date + round(rand_range(k.date[0], k.date[1]))}, {type = 'hour', operant = 'eq', value = k.hour}]
							newevent.reqs += newreq
				stored_events.timed_events.append(newevent)
			'unique_character_changes':
				var character = get_unique_slave(i.value)
				for k in i.args:
					if k.code == 'sextrait':
						match k.operant:
							'add':
								character.sex_traits.append(k.value)
								var text = character.get_short_name() + ": " + "New Sexual Trait Acquired - " + Traitdata.sex_traits[k.value].name
								text_log_add('char', text)
					elif k.code == 'tag':
						match k.operant:
							'remove':
								if k.value == 'no_sex':
									var text = character.get_short_name() + ": " + "Sex unlocked"
									text_log_add('char', text)
								character.tags.erase(k.value)
					else:
						character_stat_change(character, k)
#						var text = character.get_short_name() + ": " + globals.statdata[k.code].name 
#						if k.value > 0:
#							text += " + "
#						else:
#							text += " - "
#						text += str(k.value)
#						text_log_add('char', text)
#						character.set(k.code, input_handler.math(k.operant, character.get(k.code), k.value))
			'start_event':
				input_handler.interactive_message(i.data, 'start_event', i.args)
			'spend_money_for_scene_character':
				money -= input_handler.scene_characters[i.value].calculate_price()
				text_log_add('money',"Gold used: " + str(i.value))
			'mod_scene_characters':
				if i.type == 'all':
					for k in input_handler.scene_characters:
						k.add_stat_bonuses(i.value)

func character_stat_change(character, data):
	var text = character.get_short_name() + ": " + globals.statdata[data.code].name 
	if data.operant == '+':
		text += " + "
	else:
		text += " - "
	text += str(data.value)
	text_log_add('char', text)
	character.set(data.code, input_handler.math(data.operant, character.get(data.code), data.value))

func check_timed_events():
	for i in stored_events.timed_events:
		if checkreqs(i.reqs):
			var event = scenedata.scenedict[i.code]
			if event.has('reqs'):
				for k in event.reqs:
					if valuecheck(k) == false:
						match k.negative:
							'repeat_next_day':
								for j in i.reqs:
									if j.type in ['date']:
										j.value += 1
						return
			input_handler.interactive_message(i.code, 'story_event', {})
			stored_events.timed_events.erase(i)
			break

func get_food():
	var counter = 0
	for i in materials:
		if Items.materiallist[i].type == 'food' && i != 'grain':
			counter += materials[i]
	return counter

func get_food_consumption():
	var counter = 0
	
	for i in characters.values():
		counter += i.food_consumption
	return counter

func quest_kill_receiver(monstercode):
	for i in areas.values():
		for guild in i.quests.factions:
			for quest in i.quests.factions[guild].values():
				if quest.state == 'taken':
					for cond in quest.requirements:
						if cond.code == 'kill_monsters' && cond.type == monstercode && cond.value > cond.curvalue:
							cond.curvalue += 1
		for quest in i.quests.global.values():
			if quest.state == 'taken':
				for cond in quest.requirements:
					if cond.code == 'kill_monsters' && cond.type == monstercode && cond.value > cond.curvalue:
						cond.curvalue += 1
