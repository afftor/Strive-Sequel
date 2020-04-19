extends Node

#warning-ignore-all:unused_signal
#warning-ignore-all:return_value_discarded


signal task_added
signal slave_added
signal slave_arrived
signal hour_tick

var starting_preset = ''

var date = 1
var hour = 6

var hour_turns_set = 1

var log_node
var log_storage = []

var newgame = false

var votelinksseen = false

#world
var areas = {}
var capitals = []
var area_order = []
var starting_area = 'Plains'
var location_links = {}
var factions = {}
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
var active_quests = []
var completed_quests = []
var areaprogress = {}
var currentarea
var active_tutorials = []
var seen_tutorials = []
var show_tutorial = true

var seen_dialogues = []
var selected_dialogues = []

var daily_interactions_left = 1

var easter_egg_characters_generated = []
var easter_egg_characters_acquired = []


func revert():
	starting_preset = ''
	date = 1
	hour = 6
	itemcounter = 0
	slavecounter = 0
	locationcounter = 0
	daily_interactions_left = 1
	area_order.clear()
	mainprogress = 0
	decisions.clear()
	active_quests.clear()
	completed_quests.clear()
	characters.clear()
	character_order.clear()
	areaprogress.clear()
	currentarea = null
	items.clear()
	materials.clear()
	upgrade_progresses.clear()
	for i in globals.upgradelist.keys():
		upgrades[i] = 0
	for i in Items.materiallist:
		materials[i] = 0
	globals._ready()
	global_skills_used.clear()
	active_tasks.clear()
	completed_locations.clear()
	completed_quests.clear()
	babies.clear()
	craftinglists = {alchemy = [], smith = [], cooking = [], tailor = []}
	stored_events = {timed_events = []}
	state.areas.clear()
	state.location_links.clear()
	show_tutorial = true
	active_tutorials.clear()
	seen_tutorials.clear()
	seen_dialogues.clear()
	selected_dialogues.clear()
	input_handler.encounter_win_script = null
	input_handler.encounter_lose_scripts.clear()
	

func make_world():
	world_gen.build_world()
	state.areas.plains.unlocked = true
	state.areas.forests.unlocked = true

func _ready():
	for i in globals.upgradelist.keys():
		upgrades[i] = 0
	for i in Items.materiallist:
		materials[i] = 0
	connect("hour_tick", self, 'check_timed_events')
	input_handler.connect("EnemyKilled", self, "quest_kill_receiver")
	#call_deferred('revert')

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

func add_slave(person, child = false):
	if child: characters_pool.move_baby_to_state(person.id) 
	else: characters_pool.move_to_state(person.id)
	person.is_players_character = true
	person.is_active = true
	if person.unique != null:
		state.easter_egg_characters_acquired.append(person.unique)
	if person.professions.has('master'):
		if person.sex == 'male':
			person.masternoun = tr('PROFMASTER').to_lower()
		else:
			person.masternoun = tr('PROFMASTERALT').to_lower()
	elif state.get_master().sex == 'male':
		person.masternoun = tr('PROFMASTER').to_lower()
	else:
		person.masternoun = tr('PROFMASTERALT').to_lower()
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
			return decisions.has(dict.name) == dict.value
		"has_multiple_decisions": 
			var counter = 0
			for i in dict.decisions:
				if decisions.has(i):
					counter += 1
			return input_handler.operate(dict.operant, counter, dict.value)
		"quest_stage":
			return if_quest_stage(dict.name, dict.value, dict.operant)
		"quest_completed":
			return completed_quests.has(dict.name)
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
		'master_check':
			var master_char = get_master()
			if master_char == null:
				return false
			else:
				return master_char.checkreqs(dict.value)
		'active_character_checks':
			var character = input_handler.active_character
			if character == null:return false
			return character.checkreqs(dict.value)
		'master_is_beast':
			return if_master_is_beast(dict.value)
		'unique_character_at_mansion':
			var character = get_unique_slave(dict.value)
			if character == null:return false
			return character.checkreqs([{code = 'is_free'}])
		'has_money_for_scene_slave':
			return money >= input_handler.scene_characters[dict.value].calculate_price()
		'random':
			return globals.rng.randf()*100 <= dict.value
		'dialogue_seen':
			return input_handler.operate(dict.operant, seen_dialogues.has(dict.value), true)
		'dialogue_selected':
			return input_handler.operate(dict.operant, selected_dialogues.has(dict.value), true)
		'date':
			return input_handler.operate(dict.operant, date, dict.value)
		'active_quest_stage':
			if get_active_quest(dict.value) == null:
				if dict.has('state') && dict.state == false:
					return true
				else:
					return false
			if dict.has('state') && dict.state == false:
				return get_active_quest(dict.value).stage != dict.stage
			else:
				return get_active_quest(dict.value).stage == dict.stage
		'faction_reputation':
			var data = world_gen.get_faction_from_code(dict.code)
			var guild = areas[data.area].factions[data.code]
			return input_handler.operate(dict.operant, guild.totalreputation, dict.value)
		'group_size':
			var counter = 0
			for i in characters.values():
				if i.location == input_handler.active_location.id:
					counter += 1
			return input_handler.operate(dict.operant, counter, dict.value)
		'location_has_specific_slaves': 
			var counter = 0
			for i in characters.values():
				if i.location == dict.location && i.checkreqs(dict.reqs) == true && get_master() != i:
					counter += 1
			return counter >= dict.value

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

func if_has_items(name, operant, value):
	var counter = 0
	for i in items.values():
		if i.itembase == name:
			counter += i.amount
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
			if i.itembase == itemcode && i.owner == null:
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
	tmp['babies'] = {}
	for i in items:
		tmp['items'][i] = inst2dict(items[i])
	for h in characters:
		tmp['heroes'][h] = inst2dict(characters[h])
		characters[h].fix_serialize(tmp['heroes'][h])
	for h in babies:
		tmp['babies'][h] = inst2dict(babies[h])
		babies[h].fix_serialize(tmp['babies'][h])
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
	
	if tmp.has('babies'):
		for h in tmp['babies']:
			babies[h] = dict2inst(tmp['babies'][h])
			#fixing saved skill shortcuts
			var ssp = babies[h].social_skill_panel.duplicate()
			babies[h].social_skill_panel.clear()
			for i in ssp:
				if Skilldata.Skilllist.has(ssp[i]):
					babies[h].social_skill_panel[int(i)] = ssp[i]
			ssp = babies[h].combat_skill_panel.duplicate()
			babies[h].combat_skill_panel.clear()
			for i in ssp:
				if Skilldata.Skilllist.has(ssp[i]):
					babies[h].combat_skill_panel[int(i)] = ssp[i]
			var cleararray = []
			for i in [babies[h].social_skills, babies[h].combat_skills]:
				for k in i:
					if Skilldata.Skilllist.has(k) == false:
						cleararray.append(k)
			for i in cleararray:
				for k in [babies[h].social_skills, babies[h].combat_skills]:
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
			'material_change':
				materials[i.name] = input_handler.math(i.operant, materials[i.name], i.value)
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
						'fixed_date':
							var newreq = [{type = 'date', operant = 'eq', value = k.date}, {type = 'hour', operant = 'eq', value = k.hour}]
							newevent.reqs += newreq
				stored_events.timed_events.append(newevent)
			'remove_timed_events':
				var array = []
				for k in stored_events.timed_events:
					if k.code in i.value:
						array.append(k)
				for k in array:
					stored_events.timed_events.erase(k)
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
			'start_event':
				input_handler.interactive_message(i.data, 'start_event', i.args)
			'spend_money_for_scene_character':
				money -= input_handler.scene_characters[i.value].calculate_price()
				text_log_add('money',"Gold used: " + str(input_handler.scene_characters[i.value].calculate_price()))
			'mod_scene_characters':
				if i.type == 'all':
					for k in input_handler.scene_characters:
						k.add_stat_bonuses(i.value)
			'bool_scene_characters':
				if i.type == 'all':
					for k in input_handler.scene_characters:
						k.set(i.name, i.value)
			'affect_scene_characters':
				if i.type == 'all':
					for k in input_handler.scene_characters:
						k.set(i.name, i.value)
			'change_type_scene_characters':
				if i.type == 'all':
					for k in input_handler.scene_characters:
						k.set_slave_category(i.value)
			'active_character_switch':
				input_handler.active_character = input_handler.scene_characters[i.value]
			'affect_active_character':
				match i.type:
					'damage':
						input_handler.active_character.hp -= i.value
					'stat':
						input_handler.active_character.set(i.name, input_handler.active_character.get(i.name) + i.value)
			'make_loot':
				input_handler.scene_loot = world_gen.make_chest_loot(input_handler.weightedrandom(i.pool))
			'open_loot':
				input_handler.get_spec_node(input_handler.NODE_LOOTTABLE).open(input_handler.scene_loot, '[center]Acquired Items:[/center]')
			'make_scene_character':
				for k in i.value:
					var newcharacter
					var number = 1
					if k.has("number"):
						number = round(rand_range(k.number[0], k.number[1]))
					while number > 0:
						match k.type:
							'raw':
								newcharacter = Slave.new()
								newcharacter.is_active = false
								newcharacter.generate_random_character_from_data(k.race, k.class, k.difficulty)
								newcharacter.set_slave_category(k.slave_type)
							'function':
								newcharacter = call(k.function, k.args)
						input_handler.active_character = newcharacter
						input_handler.scene_characters.append(newcharacter)
						
						number -= 1
			'update_guild':
				input_handler.exploration_node.enter_guild(input_handler.active_faction)
			'create_character':
				input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['slave', i.type])
			'main_progress':
				mainprogress = input_handler.math(i.operant, mainprogress, i.value)
			'progress_quest':
				var quest_exists = false
				for k in active_quests:
					if k.code == i.value:
						quest_exists = true
						k.stage = i.stage
						text_log_add("quests", "Quest Updated: " + tr(scenedata.quests[k.code].stages[k.stage].name) + ". ")
				if quest_exists == false:
					active_quests.append({code = i.value, stage = i.stage})
					text_log_add("quests", "Quest Received: " + tr(scenedata.quests[i.value].stages[i.stage].name) + ". ")
			'complete_quest':
				for k in active_quests:
					if k.code == i.value:
						active_quests.erase(k)
						text_log_add("quests","Quest Completed: " + tr(scenedata.quests[k.code].stages[k.stage].name) + ". ")
						break
				completed_quests.append(i.value)
			'complete_active_location':
				input_handler.remove_location(input_handler.active_location.id)
			'complete_event':
				pass
			'reputation':
				var data = world_gen.get_faction_from_code(i.name)
				var guild = areas[data.area].factions[data.code]
				guild.reputation = input_handler.math(i.operant, guild.reputation, i.value)
				guild.totalreputation = input_handler.math(i.operant, guild.totalreputation, i.value)
			'decision':
				if !decisions.has(i.value):
					decisions.append(i.value)
			'screen_black_transition':
				input_handler.BlackScreenTransition(i.value)
			'start_combat':
				input_handler.current_enemy_group = i.value
				input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)
			'start_quest_combat':
				input_handler.StartQuestCombat(i.value)
			'make_quest_location':
				world_gen.make_quest_location(i.value)
			'remove_quest_location':
				input_handler.remove_location(i.value)
			'set_music':
				input_handler.SetMusic(i.value)
			'lose_game':
				input_handler.PlaySound('transition_sound')
				globals.return_to_main_menu()

func get_active_quest(code):
	for i in active_quests:
		if i.code == code:
			return i
	return 

func make_local_recruit(args):
	var newchar = Slave.new()
	if args == null:
		newchar.generate_random_character_from_data(input_handler.weightedrandom(input_handler.active_location.races))
	else:
		var race = 'random'
		var des_class = null
		var difficulty = 0
		if args.has('races'):
			race = input_handler.weightedrandom(args.races)
			if race == 'local':
				race = input_handler.weightedrandom(input_handler.active_area.races)
			elif race == 'beast':
				var racearray = []
				for i in races.racelist.values():
					if i.tags.has('beast') == true:
						racearray.append(i.code)
				race = racearray[randi()%racearray.size()]
		if args.has('difficulty'):
			difficulty = round(rand_range(args.difficulty[0], args.difficulty[1]))
		newchar.generate_random_character_from_data(race, des_class, difficulty)
		if args.has("bonuses"):
			newchar.add_stat_bonuses(args.bonuses)
		if args.has("type"):
			newchar.set_slave_category(args.type)
	if newchar.slave_class == '': newchar.set_slave_category('servant')
	if args.has("is_hirable"): newchar.is_hirable = args.is_hirable
	return newchar

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
