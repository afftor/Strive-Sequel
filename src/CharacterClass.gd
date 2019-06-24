extends Reference
class_name Slave

var id = ''
var is_person = true
var is_active = true
var is_players_character = false

var unique 

var icon_image = "res://assets/images/portraits/GoblinTrader.png" #images.portraits[images.portraits.keys()[randi()%images.portraits.size()]].load_path
var body_image = 'default'
var npc_reference
#####required for combat
var combatgroup 
var displaynode
var defeated = false
var cooldowns = []
#####

var name = ''
var surname = ''
var nickname = ''
var bonus_description = ''
var race = ''
var age = ''
var sex = ''

var professions = []
var social_skills = []
var social_cooldowns = {}
var social_skills_charges = {}
var combat_skills = []
var combat_cooldowns = {}
var social_skill_panel = {}
var combat_skill_panel = {}
var traits = []
var sex_traits = []
var effects = []

var static_effects = []
var temp_effects = []  
var triggered_effects = []
var area_effects = [] 
var own_area_effects = [] 

var obed_mods = []
var fear_mods = []
var lust_mods = []

var obedience = 25.0 setget obed_set, obed_get
var fear = 70.0 setget fear_set, fear_get
var lust = 20.0 setget lust_set, lust_get
var loyal = 0.0
var lustmax = 50
var lusttick = 1.05
var obed_degrade_mod = 1.0
var energy_work_mod = 8.75


var hp = 100 setget hp_set
var hpmax = 100
var mp = 10 setget mp_set
var mpmax = 10
var energy := 100.0 setget energy_set
var energymax = 100
var energybonus = 0
var base_exp = 0

var fatigue = 0 setget fatigue_set
var exhaustion = 0 setget exhaustion_set
var productivity := 100.0

#productivity mods
var mod_collect = 1.0
var mod_hunt = 1.0
var mod_cook = 1.0
var mod_smith = 1.0
var mod_alchemy = 1.0
var mod_farm = 1.0
var mod_pros_gold = 1.0
#to add all other mods to fully cover all tasks
#also adding mods requires to add those mods to discipline effect 
#var mod_pros_energy = 1.0
var mod_default = 1.0

var damage = 0 #maybe needs setget
var hitrate = 0
var evasion = 0
var resists = {}
var armor = 0
var mdef = 0
var armorpenetration = 0
var critchance = 0
var position

var hide = false
var silenced = false
var manacost_mod = 1.0

var speed = 0


#progress stats
var physics := 0.0
var physics_bonus := 0.0
var wits := 0.0
var wits_bonus := 0.0
var sexuals := 0.0
var sexuals_bonus := 0.0
var charm := 0.0
var charm_bonus := 0.0
#constant stats
var dirtiness = 1
var physics_factor = 1 #physics
var magic_factor = 1
var tame_factor = 1
var brave_factor = 1
var growth_factor = 1
var charm_factor = 1 #charm
var wits_factor = 1 #wit
var sexuals_factor = 1 #sexuals
#food
var food_counter = 23
var food_consumption = 1
var food_love = ''
var food_hate = []
var food_filter = {high = [], med = [], low = [], disable = []}
#gear
var gear = {
	helm = null,
	body = null,
	rhand = null,
	lhand = null,
	gloves = null,
	boots = null,
	
	#cosmetics&lewds
	neck = null,
	head = null,
	ass = null,
	crotch = null,
	underwear = null,
}
var piercing = {earlobes = null, eyebrow = null, nose = null, lips = null, tongue = null, navel = null, nipples = null, clit = null, labia = null, penis = null}
var tattoo = {chest = 'none', face = 'none', ass = 'none', arms = 'none', legs = 'none', waist = 'none'}
var tattooshow = {chest = true, face = true, ass = true, arms = true, legs = true, waist = true}
var mods = {}
#appearance
var skin = 'fair'
var height = 'average'
var hair_length = 'ear'
var hair_color = 'black'
var hair_style = 'straight'
var ears = 'normal'
var eye_color = 'brown'
var eye_shape = 'normal'
var horns = ''
var wings = ''
var tail = ''
var arms = 'normal'
var legs = 'normal'
var lower_body = ''
var body_shape = 'humanoid'
var skin_coverage = ''
var fur = ''
var facial_hair = ''
#genitals
var penis_size = ''
var penis_type = 'human'
var balls_size = ''
var tits_size = ''
var vagina = ''
var ass_size = ''
var has_pussy = false
var multiple_tits = 0
var multiple_tits_developed = false
var has_womb = false
var pregnancy = { "fertility": 0, "duration": 0, "baby": null }
var lactation = false

var penis_virgin = true
var vaginal_virgin = true
var anal_virgin = true
var mouth_virgin = true
#tasks
var sleep = ''
var work = ''
var workhours = 12
var resthours = 8
var joyhours = 4
var current_day_spent = {workhours = 0, resthours = 0, joyhours = 0}
var rules = []

var shackles_chance = null

var area = ''
var location = 'mansion'
var travel_target = {area = '', location = ''}
var travel_time = 0

#communications
var relatives = {}
var tags = []

var last_tick_assignement = 'rest'
var messages = []

var sexexp = {partners = {}, watchers = {}, actions = {}, seenactions = {}, orgasms = {}, orgasmpartners = {}}
var relations = {}
var metrics = {ownership = 0, jail = 0, mods = 0, brothel = 0, sex = 0, partners = [], randompartners = 0, item = 0, spell = 0, orgy = 0, threesome = 0, win = 0, capture = 0, goldearn = 0, foodearn = 0, manaearn = 0, birth = 0, preg = 0, vag = 0, anal = 0, oral = 0, roughsex = 0, roughsexlike = 0, orgasm = 0}
var lastsexday


var masternoun = 'Master'

func generate_random_character_from_data(races, desired_class = null, adjust_difficulty = 0):
	var gendata = {race = '', sex = 'random', age = 'random'}
	
	gendata.race = races[randi()%races.size()]
	#figuring out the race

	create(gendata.race, gendata.sex, gendata.age)
	
	if randf() <= 0.003:
		pass #make check for easter egg character
	
	for i in variables.resists_list:
		resists[i] = 0
	
	var slaveclass = desired_class
	if slaveclass == null:
		slaveclass = input_handler.weightedrandom([['combat', 1],['magic', 1],['social', 1],['sexual',1], ['labor',1]])
	
	if slaveclass == 'magic' && magic_factor == 1: #prevents finding no class as there's no magic base classes which allow magic factor < 2
		magic_factor = 2
	
	var difficulty = adjust_difficulty
	var classcounter = round(rand_range(variables.slave_classes_per_difficulty[difficulty][0], variables.slave_classes_per_difficulty[difficulty][1])) 
	
	
	#Add extra stats for harder characters
	while difficulty > 1:
		var array = []
		if randf() >= 0.7:
			array = ['physics_factor', 'magic_factor', 'wits_factor', 'brave_factor', 'sexuals_factor', 'charm_factor']
		else:
			match slaveclass:
				'combat':
					array = ['physics_factor', 'brave_factor']
				'magic':
					array = ['wits_factor', 'magic_factor']
				'social', 'sexual':
					array = ['tame_factor', 'charm_factor', 'sexuals_factor']
				'labor':
					array = ['physics_factor', 'wits_factor']
		array = array[randi()%array.size()]
		self.set(array, self.get(array) + 1)
		difficulty -= 1
	difficulty = adjust_difficulty
	while difficulty > -1:
		var array = []
		if randf() >= 0.7:
			array = ['physics', 'wits','sexuals', 'charm']
		else:
			match slaveclass:
				'combat':
					array = ['physics']
				'magic':
					array = ['wits']
				'social', 'sexual':
					array = ['charm', 'sexuals']
				'labor':
					array = ['physics', 'wits']
		array = array[randi()%array.size()]
		self.set(array, self.get(array) + rand_range(10,15))
		difficulty -= 1
	
	#assign classes
	while classcounter > 0:
		var classarray = []
		if randf() >= 0.8:
			classarray = get_class_list('any', self)
		else:
			classarray = get_class_list(slaveclass, self)
		if classarray != null:
			unlock_class(classarray[randi()%classarray.size()].code, true)
		classcounter -= 1
	
	var traitarray = []
	#assign traits
	for i in Traitdata.sex_traits.values():
		if i.starting == true && checkreqs(i.acquire_reqs) == true:
			traitarray.append(i)
	var rolls = max(1,ceil(sexuals_factor/3))
	while rolls > 0:
		var newtrait = traitarray[randi()%traitarray.size()]
		sex_traits.append(newtrait.code)
		traitarray.erase(newtrait)
		rolls -= 1

func get_class_list(category, person):
	var array = []
	for i in Skilldata.professions.values():
		if (category != 'any' && i.categories.has(category) == false) || professions.has(i.code) == true:
			continue
		if checkreqs(i.reqs, true) == true:
			array.append(i)
	
	return array

func generate_simple_fighter(tempname):
	var data = Enemydata.enemies[tempname]
	
	for i in variables.fighter_stats_list:
		if data.has(i) == false:
			set(i, 0)
		else:
			set(i, data[i])
	icon_image = data.icon
	body_image = data.body
	combat_skills = data.skills
	npc_reference = data.code
	is_person = false
	for i in variables.resists_list:
		resists[i] = 0
	for i in data.resists:
		resists[i] = data.resists[i]


func create(temp_race, temp_gender, temp_age):
	id = 's' + str(state.slavecounter)
	state.slavecounter += 1
	
	race = temp_race
	sex = temp_gender
	age = temp_age
	
	if temp_race == 'random':
		race = get_random_race()
	elif temp_race == 'Halfbreeds':
		race = ['HalfkinCat','HalfkinWolf','HalfkinFox','HalfkinBunny','HalfkinTanuki']
		race = race[randi()%race.size()]
	if temp_gender == 'random':
		sex = get_random_sex()
	if temp_age == 'random':
		age = get_random_age()
	
	get_sex_features()
	
	if globals.globalsettings.furry == false && race.find("Beastkin") >= 0:
		race = race.replace("Beastkin","Halfkin")
	
	get_racial_features()
	
	get_random_name()
	
	random_icon()
	
	for i in variables.resists_list:
		resists[i] = 0
	#setting food filter
	for i in Items.materiallist.values():
		if i.type == 'food':
			if i.tags.has(food_love):
				food_filter.high.append(i.code)
			else:
				var check = false
				for k in food_hate: 
					if i.tags.has(k):
						food_filter.low.append(i.code)
						check = true
						break
				if check == false:
					food_filter.med.append(i.code)

func get_short_name():
	var text = ''
	
	if nickname == '':
		text = name
	else:
		text = nickname
	
	return text

func get_full_name():
	var text = ''
	
	if nickname == '':
		text = name + ' ' + surname
	else:
		text = name + ' "' + nickname + '" ' + surname
	
	return text

func get_racial_features():
	var race_template = races.racelist[race]
	for i in race_template.basestats:
		self.set(i, round(rand_range(race_template.basestats[i][0], race_template.basestats[i][1]))) #1 - terrible, 2 - bad, 3 - average, 4 - good, 5 - great, 6 - superb
	for i in race_template.racetrait:
		self.set(i, self.get(i) + race_template.racetrait[i])
	for i in race_template.bodyparts:
		self.set(i, race_template.bodyparts[i][randi()%race_template.bodyparts[i].size()])
	
	var array = []
	for i in race_template.diet_love:
		array.append({name = i, weight = race_template.diet_love[i]})
	food_love = input_handler.weightedrandom(array).name
	for i in race_template.diet_hate:
		if race_template.diet_hate[i] >= randf()*100 && i != food_love:
			food_hate.append(i)
	if race_template.tags.has("multibreasts") && globals.globalsettings.furry_multiple_nipples == true:
		multiple_tits = variables.furry_multiple_nipples_number


func get_sex_features():
	match sex:
		'female':
			hair_length = input_handler.weightedrandom([['ear', 0.5],['neck',2],['shoulder',3],['waist',1],['hips',0.5]])
			hair_style = input_handler.weightedrandom([['straight', 2],['ponytail',1],['pigtails',1],['braid',1],['twinbraids',1]])
			tits_size = input_handler.weightedrandom([['flat', 0.5],['small',2],['average',2],['big',1],['huge',0.3]])
			ass_size = input_handler.weightedrandom([['flat', 0.5],['small',2],['average',2],['big',1],['huge',0.3]])
			has_pussy = true
			has_womb = true
			
			if randf()*100 >= variables.female_vagina_virgin_default_chance:
				vaginal_virgin = false
			if randf()*100 >= variables.female_ass_virgin_default_chance:
				anal_virgin = false
		'male':
			hair_style = input_handler.weightedrandom([['straight', 10],['ponytail',1]])
			hair_length = input_handler.weightedrandom([['ear', 2],['neck',0.3],['shoulder',0.1]])
			tits_size = input_handler.weightedrandom([['masculine', 1], ['flat', 1]])
			ass_size = input_handler.weightedrandom([['masculine', 1], ['flat', 1]])
			penis_size = input_handler.weightedrandom([['small',1],['average',5],['big',1]])
			balls_size = input_handler.weightedrandom([['small',1],['average',5],['big',1]])
			
			if randf()*100 >= variables.male_penis_virgin_default_chance:
				penis_virgin = false
			if randf()*100 >= variables.male_ass_virgin_default_chance:
				anal_virgin = false
		'futa':
			hair_style = input_handler.weightedrandom([['straight', 2],['ponytail',1],['pigtails',1],['braid',1],['twinbraids',1]])
			hair_length = input_handler.weightedrandom([['ear', 0.5],['neck',2],['shoulder',3],['waist',1],['hip',0.5]])
			penis_size = input_handler.weightedrandom([['small',1],['average',1],['big',1]])
			if globals.globalsettings.futa_balls == true:
				balls_size = input_handler.weightedrandom([['small',1],['average',1],['big',1]])
			tits_size = input_handler.weightedrandom([['flat', 0.5],['small',2],['average',2],['big',1],['huge',0.3]])
			ass_size = input_handler.weightedrandom([['flat', 0.5],['small',2],['average',2],['big',1],['huge',0.3]])
			has_pussy = true
			has_womb = true
			
			if randf()*100 >= variables.male_penis_virgin_default_chance:
				penis_virgin = false
			if randf()*100 >= variables.female_vagina_virgin_default_chance:
				vaginal_virgin = false
			if randf()*100 >= variables.female_ass_virgin_default_chance:
				anal_virgin = false
	
	if vaginal_virgin == false || anal_virgin == false:
		mouth_virgin = false

func checkreqs(array, ignore_npc_stats_gear = false):
	
	for i in array:
		var check = true
		match i.code:
			'stat':
				if ignore_npc_stats_gear == false || !i.type in ['physics','wits','charm','sexuals']:
					check = input_handler.operate(i.operant, self.get(i.type), i.value)
			'has_profession':
				check = professions.has(i.value)
			'race_is_beast':
				check = races.racelist[race].tags.has('beast') == i.value
			'gear_equiped':
				if ignore_npc_stats_gear == false:
					check = check_gear_equipped(i.value)
			'global_profession_limit':
				check = check_profession_limit(i.name, i.value)
			'race':
				check = input_handler.operate(i.operant, race, i.value)
			'one_of_races':
				check = race in i.value
			'is_free':
				check = travel_time == 0 && location == 'mansion' && tags.has('selected') == false
			'is_at_location':
				check = travel_time == 0 && location == i.type
			'is_id':
				check = input_handler.operate(i.operant, id, i.value)
			'long_tail':
				check = globals.longtails.has(tail)
		if check == false:
			return false
	return true

func check_gear_equipped(gearname):
	for i in gear.values():
		if i == null:
			continue
		var tempgear = state.items[i]
		if tempgear.base_type == gearname:
			return true
	return false

func equip(item):
	if false:#add checks for gear traits
		input_handler.SystemMessage(tr("INVALIDCLASS"))
		return
	for i in item.multislots:
		if gear[i] != null:
			unequip(state.items[gear[i]])
	for i in item.slots:
		if gear[i] != null:
			unequip(state.items[gear[i]])
		gear[i] = item.id
	item.owner = id
	#adding bonuses
#	for i in item.bonusstats:
#		#self[i] += item.bonusstats[i]
#		set(i, get(i) + item.bonusstats[i])
#	for i in item.effects:
#		var tmp = Effectdata.effects[i].effects;
#		for e in tmp:
#			#apply_effect(e);
#			var eff = effects_pool.e_createfromtemplate(e)
#			apply_effect(effects_pool.add_effect(eff))
#			eff.set_args('item', item.id)
		#addpassiveeffect(i)
		#NEED REPLACING
	#checkequipmenteffects()


func unequip(item):#NEEDS REMAKING!!!!
	#removing links
	item.owner = null
	for i in gear:
		if gear[i] == item.id:
			gear[i] = null
	#removing bonuses
#	for i in item.bonusstats:
#		#self[i] -= item.bonusstats[i]
#		set(i, get(i) - item.bonusstats[i])
	
#	for i in item.effects:
#		var tmp = Effectdata.effects[i].effects;
#		for e in find_eff_by_item(item.id):
#			var eff = effects_pool.get_effect_by_id(e)
#			eff.remove()
#		#removepassiveeffect(i) 
#		#NEED REPLACING
	#checkequipmenteffects()

func check_profession_limit(name, value):
	var counter = 0
	for i in state.characters.values():
		if i.professions.has(name):
			counter += 1
	return counter < value

func assign_gender():
	if has_pussy == true:
		if penis_size != '' || balls_size != '':
			sex = 'futa'
		else:
			sex = 'female'
	else:
		sex = 'male'

var descriptions = load("res://assets/data/descriptions.gd").new()

func make_description():
	return translate(descriptions.create_character_description(self))

func show_race_description():
	var temprace = races.racelist[race]
	var text = ''
	if temprace.tags.has('beast'):
		if race.find("Beastkin") >= 0:
			text += tr("RACEBEASTKINDESCRIPT") + "\n\n"
		elif race.find("Halfkin") >= 0:
			text += tr("RACEHALFKINDESCRIPT") + "\n\n"
	text += temprace.descript
	text += "\n\nRace bonuses: "
	for i in temprace.racetrait:
		text += globals.statdata[i].name + ": " + str(temprace.racetrait[i]) + ', '
	text = text.substr(0, text.length() - 2) + "."
	
	return text

var stat_description = {
	1 : "[color=white]Very Low[/color]", 2 : '[color=green]Low[/color]', 3 : "[color=blue]Average[/color]", 4 : "[color=purple]Good[/color]", 5 :"[color=yellow]Great[/color]", 6: "[color=]Superb[/color]"
}


func get_random_race():
	var array = []
	for i in races.racelist.values():
		array.append({name = i.code, weight = i.global_weight})
	return input_handler.weightedrandom(array).name

func get_random_sex():
	if randf() <= variables.male_to_female_ratio:
		return 'male'
	elif randf() <= variables.futa_to_female_ratio && globals.globalsettings.futa == true:
		return 'futa'
	else:
		return 'female'

func get_random_age():
	var array = []
	for i in ['teen','adult','mature']:
		array.append({name = i, weight = variables.get(i+"_age_weight")})
	return input_handler.weightedrandom(array).name

var names = load("res://assets/data/names.gd").new()

func get_random_name():
	var text = race.to_lower()+sex.replace("futa",'female')
	if !names.namelist.has(text):
		text = 'human'+ sex.replace("futa",'female')
	name = names.namelist[text][randi()%names.namelist[text].size()]
	if names.namelist.has(race.to_lower() + 'surname'):
		surname = names.namelist[race.to_lower() + "surname"][randi() % names.namelist[race.to_lower() + "surname"].size()]
	elif race.find("Halfkin") >= 0 || race.find("Beastkin") >= 0:
		surname = names.getRandomFurrySurname()
	

func decipher_reqs(reqs, colorcode = false):
	var text = ''
	for i in reqs:
		match i.code:
			'stat':
				text += i.type + ': ' + str(i.value) + " "
				match i.operant:
					'gte':
						text += "or higher"
					'lte':
						text += "or lower"
			'has_profession':
				text += 'Has Profession: ' + Skilldata.professions[i.value].name
			'race':
				if i.operant == 'eq':
					text += 'Race: ' + races.racelist[i.value].name
				else:
					continue
			'race_is_beast':
				if i.value == true:
					text += 'Only for bestial races.'
				else:
					continue
			'gear_equiped':
				text += 'Must have ' + Items.itemlist[i.value].name + "."
			'global_profession_limit':
				text += 'Only ' + str(i.value) + " " + Skilldata.professions[i.name].name + " allowed."
			'one_of_races':
				text += "Only for: "
				for k in i.value:
					text += races.racelist[k].name + ', '
				text = text.substr(0, text.length()-2) + '. '
		if colorcode == true:
			if checkreqs([i]):
				text = '[color=yellow]' + text + '[/color]'
			else:
				text = '[color=aqua]' + text + '[/color]'
		text += '\n'
	return text.substr(0, text.length()-1)

func get_next_class_exp():
	var currentclassnumber = professions.size()
	var exparray
	var value = 0
	if currentclassnumber < growth_factor*variables.class_cap_per_growth+variables.class_cap_basic:
		exparray = variables.soft_level_reqs
		if exparray.size() < abs(growth_factor*variables.class_cap_per_growth + variables.class_cap_basic):
			value = exparray[exparray.size()-1]
		else:
			value = exparray[currentclassnumber]
	else:
		exparray = variables.hard_level_reqs
		if exparray.size() < abs(growth_factor*variables.class_cap_per_growth + variables.class_cap_basic - currentclassnumber):
			value = exparray[exparray.size()-1]
		else:
			value = exparray[abs(growth_factor*variables.class_cap_per_growth + variables.class_cap_basic - currentclassnumber)]
	return value

func unlock_class(prof, satisfy_progress_reqs = false):
	prof = Skilldata.professions[prof]
	if satisfy_progress_reqs == true:
		for i in prof.reqs:
			if i.code == 'stat' && i.type in ['physics','wits','charm','sexuals']:
				self.set(i.type, i.value)
	if professions.has(prof.code):
		return "Already has this profession"
	professions.append(prof.code)
	for i in prof.skills:
		learn_skill(i)

func learn_skill(skill):
	if !social_skills.has(skill):
		social_skills.append(skill)
		if social_skill_panel.size() < 12:
			for i in range(1,13):
				if social_skill_panel.has(i) == false:
					social_skill_panel[i] = skill
					break

func unlearn_skill(skill):
	var check = false
	for i in professions:
		var tempprof = Skilldata.professions[i]
		if tempprof.skills.has(skill):
			check = true
			break
	if check == false:
		social_skills.erase(skill)


func cooldown_tick():
	var cleararray = []
	for i in social_cooldowns:
		social_cooldowns[i] -= 1
		if social_cooldowns[i] <= 0:
			social_skills_charges.erase(i)
			cleararray.append(i)
	
	for i in cleararray:
		social_cooldowns.erase(i)

func skill_tooltip(skillcode):
	var text = ''
	var skill = Skilldata.Skilllist[skillcode]
	text += "[center]" + skill.name + "[/center]\n" + skill.descript
	
	var manacost = skill.manacost
	var energycost = skill.energycost
	
	return text

var stat_connections = {
	physics = 'physics_factor',
	wits = 'wits_factor',
	sexuals = 'sexuals_factor',
	charm = 'charm_factor'
}

func raise_stat(stat, value):
	var cap = self.get(stat_connections[stat])*20
	if self.get(stat) + value <= cap:
		self.set(stat, self.get(stat) + value)
	else:
		return false

func assign_to_task(taskcode, taskproduct, iterations = -1):
	var task = races.tasklist[taskcode]
	#remove existing work
	remove_from_task()
	#check if task is existing and add slave to it if it does
	var taskexisted = false
	for i in state.active_tasks:
		if i.code == taskcode:
			taskexisted = true
			i.workers.append(self.id)
			work = i.code
	
	for i in current_day_spent:
		current_day_spent[i] = 0
	
	if taskexisted == true:
		return
	#make new task if it didn't exist
	var dict = {code = taskcode, product = taskproduct, progress = 0, threshhold = task.production[taskproduct].progress_per_item, workers = [], iterations = iterations, messages = [], mod = task.mod}
	dict.workers.append(self.id)
	work = taskcode
	state.active_tasks.append(dict)
	state.emit_signal("task_added")

func remove_from_task():
	if work != '':
		for i in state.active_tasks:
			if i.code == work:
				i.workers.erase(self.id)
	work = ''

func tick():
	process_event(variables.TR_TICK)
	
	var skip_work = false
	if work == '':
		skip_work = true
	
	food_counter -= 1
	if food_counter <= 0:
		food_counter = 23
		get_food()
	
	self.fatigue += 1
	self.lust += lusttick
	
	self.obedience -= 100.0 * obed_degrade_mod/(24 + 24*tame_factor) #2.43 - 0.35*tame_factor #2 days min, 6 days max
	self.fear -= 100.0/max((168 - 24*brave_factor), 24)#0.35 + 0.35*brave_factor #2 days min, 6 days max
	
	if work == 'travel':
		if travel_time > 0:
			travel_time -= 1
			if travel_time == 0:
				area = travel_target.area
				location = travel_target.location
				state.emit_signal("slave_arrived", self)
				if location == 'mansion':
					work = 'rest'
		
		return
	
	if skip_work == false:
		var totalday = 0
		for i in current_day_spent.values():
			totalday += i
		if totalday >= 24:
			for i in current_day_spent:
				current_day_spent[i] = 0
		
		if current_day_spent.workhours < workhours:
			work_tick()
		elif current_day_spent.joyhours < joyhours:
			joy_tick()
		else:
			rest_tick()
	else:
		if fatigue > 10:
			joy_tick()
		else:
			rest_tick()

func hp_set(value):
	if value < 0:
		death()
	else:
		hp = min(value, hpmax)

func mp_set(value):
	mp = clamp(0, value, mpmax)

func death():
	is_active = false
	clean_effects()
	pass

func energy_set(value):
	energymax = 100 + energybonus + round(physics + physics_bonus)
	if value < 0:
		self.exhaustion += -value
		energy = 0
	else:
		energy = min(value, energymax)

func fatigue_set(value):
	if traits.has('undead'): return
	fatigue = value

func exhaustion_set(value):
	exhaustion = clamp(value, 0, 1000)
	set_productivity()
	#add exhaustion debuff checks

func set_productivity():
	productivity = 100 - min(25,fatigue*0.25) - min(25,exhaustion*0.1)

func get_food():
	var eaten = false
	for j in ['high','med','low']:
		for i in food_filter[j]:
			var food = Items.materiallist[i]
			if state.materials[i] >= food_consumption:
				state.materials[i] -= food_consumption
				eaten = true
			if eaten == true:
				if food.tags.has(food_love):
					var check = false
					for k in food_hate:
						if food.tags.has(k):
							check = true
					if check == false:
						fatigue -= 10
						obedience += 10
				else:
					var check = false
					for k in food_hate:
						if food.tags.has(k):
							check = true
					if check == true:
						fatigue += 10
						if food.tags.size() <= 1:
							obedience -= 10
				break
		if eaten == true:
			break
	
	if eaten == false:
		exhaustion += 25
		obedience -= 25
		input_handler.SystemMessage(get_short_name() + ": no food.")
		pass#add starvation debuf

func work_tick():
	var currenttask
	last_tick_assignement = 'work'
	for i in state.active_tasks:
		if i.workers.has(self.id):
			currenttask = i
	
	if currenttask == null:
		work = ''
		return

	if ['smith','alchemy','tailor','cook'].has(currenttask.product):
		if state.craftinglists[currenttask.product].size() <= 0:
			if currenttask.messages.has('notask') == false:
				state.text_log_add(get_short_name() + ": No craft task for " + currenttask.product.capitalize() + ". ")
				currenttask.messages.append('notask')
			rest_tick()
			return
		else:
			var craftingitem = state.craftinglists[currenttask.product][0]
			currenttask.messages.erase("notask")
			if craftingitem.resources_taken == false:
				if check_recipe_resources(craftingitem) == false:
					if currenttask.messages.has('noresources') == false:
						state.text_log_add(get_short_name() + ": Not Enough Resources for craft. ")
						currenttask.messages.append("noresources")
					rest_tick()
					return
				else:
					spend_resources(craftingitem)
					currenttask.messages.erase("noresources")
			work_tick_values(currenttask)
			craftingitem.workunits += races.call(races.tasklist[currenttask.code].production[currenttask.product].progress_function, self)*(productivity*get(currenttask.mode)/100)
			make_item_sequence(currenttask, craftingitem)
	elif currenttask.product == 'building':
		if state.selected_upgrade.code == '':
			rest_tick()
			if messages.has("noupgrade") == false:
				state.text_log_add(get_short_name() + ": No task or upgrade selected for building. ")
				messages.append("noupgrade")
			return
		else:
			messages.erase('noupgrade')
			work_tick_values(currenttask)
			state.upgrade_progresses[state.selected_upgrade.code].progress += races.call(races.tasklist[currenttask.code].production[currenttask.product].progress_function, self)*(productivity/100)
			if state.upgrade_progresses[state.selected_upgrade.code].progress >= globals.upgradelist[state.selected_upgrade.code].levels[state.selected_upgrade.level].taskprogress:
				if state.upgrades.has(state.selected_upgrade.code):
					state.upgrades[state.selected_upgrade.code] += 1
				else:
					state.upgrades[state.selected_upgrade.code] = 1
				input_handler.emit_signal("UpgradeUnlocked", globals.upgradelist[state.selected_upgrade.code])
				state.text_log_add("Upgrade finished: " + globals.upgradelist[state.selected_upgrade.code].name)
				state.upgrade_progresses.erase(state.selected_upgrade.code)
				state.selected_upgrade.code = ''
	else:
		#print(races.call(races.tasklist[currenttask.code].production[currenttask.product].progress_function,self)*(productivity/100))
		work_tick_values(currenttask)
		currenttask.progress += races.call(races.tasklist[currenttask.code].production[currenttask.product].progress_function, self)*(productivity*get(currenttask.mode)/100)
		while currenttask.threshhold <= currenttask.progress:
			currenttask.progress -= currenttask.threshhold
			state.materials[races.tasklist[currenttask.code].production[currenttask.product].item] += 1

func work_tick_values(currenttask):
	current_day_spent.workhours += 1
	if traits.has('undead'):
		self.energy -= 0
	elif currenttask.code == 'prostitution' && traits.has('succubus_trait'): 
		self.energy -= energy_work_mod * 0.7
	else: 
		self.energy -= energy_work_mod
	var workstat = races.tasklist[currenttask.code].workstat
	set(workstat, get(workstat) + 0.1)
	base_exp += 2.1

func make_item_sequence(currenttask, craftingitem):
	if craftingitem.workunits >= craftingitem.workunits_needed:
		make_item(craftingitem)
		craftingitem.workunits -= craftingitem.workunits_needed
		if craftingitem.repeats != 0:
			if check_recipe_resources(craftingitem) == true:
				spend_resources(craftingitem)
				if craftingitem.workunits >= craftingitem.workunits_needed:
					make_item_sequence(currenttask, craftingitem)
			else:
				if currenttask.messages.has('noresources') == false:
					state.text_log_add(get_short_name() + ": " + "Not Enough Resources for craft. ")
					currenttask.messages.append("noresources")

func check_recipe_resources(temprecipe):
	var recipe = Items.recipes[temprecipe.code]
	if recipe.crafttype == 'basic':
		var check = true
		for i in recipe.materials:
			if state.materials[i] < recipe.materials[i]:
				check = false
		for i in recipe.items:
			if state.if_has_free_items(i, 'gte', recipe.items[i]) == false:
				check = false
		if check == false:
			return false
	else:
		var item = Items.itemlist[recipe.resultitem]
		var check = true
		for i in temprecipe.partdict:
			if state.materials[temprecipe.partdict[i]] < item.parts[i]:
				check = false
		if check == false:
			return false
	return true

func spend_resources(temprecipe):
	var recipe = Items.recipes[temprecipe.code]
	if recipe.crafttype == 'basic':
		for i in recipe.materials:
			state.materials[i] -= recipe.materials[i]
		for i in recipe.items:
			state.remove_item(i, recipe.items[i])
	else:
		var item = Items.itemlist[recipe.resultitem]
		for i in temprecipe.partdict:
			state.materials[temprecipe.partdict[i]] -= item.parts[i]
	temprecipe.resources_taken = true

func make_item(temprecipe):
	var recipe = Items.recipes[temprecipe.code]
	temprecipe.resources_taken = false
	if recipe.resultitemtype == 'material':
		state.materials[recipe.resultitem] += recipe.resultamount
	else:
		var item = Items.itemlist[recipe.resultitem]
		if item.type == 'usable':
			globals.AddItemToInventory(globals.CreateUsableItem(item.code))
		elif item.type == 'gear':
			if recipe.crafttype == 'modular':
				globals.AddItemToInventory(globals.CreateGearItem(item.code, temprecipe.partdict))
			else:
				globals.AddItemToInventory(globals.CreateGearItem(item.code, {}))
	if temprecipe.repeats > 0:
		temprecipe.repeats -= 1
		if temprecipe.repeats == 0:
			state.craftinglists[Items.recipes[temprecipe.code].worktype].erase(temprecipe)

func joy_tick():
	last_tick_assignement = 'joy'
	current_day_spent.joyhours += 1
	fatigue -= 4

func rest_tick():
	last_tick_assignement = 'rest'
	current_day_spent.resthours += 1
	if exhaustion > 0:
		if exhaustion - float(energymax)/16 < 0:
			var leftvalue = abs(exhaustion - float(energymax)/16)
			self.exhaustion = 0
			self.energy += leftvalue*1.5
		else:
			self.exhaustion -= float(energymax)/16
			self.energy += float(energymax)/10
	else:
		self.energy += float(energymax)/8
	fatigue -= 1

func obed_set(value):
	obedience = clamp(float(value), 0, 100)

func obed_get():
	return obedience

func fear_set(value):
	fear = clamp(value, 0, 100)

func fear_get():
	return floor(fear)

func lust_set(value):
	lustmax = 25 + sexuals_factor * 25
	
	lust = clamp(value, 0, lustmax)


func lust_get():
	return lust

func check_escape_chance():
	var base_chance = brave_factor * 8
	if obedience + loyal/2 < base_chance:
		return true
	if fear + loyal/2 < base_chance:
		return true
	return false

func check_escape_possibility():
	if check_escape_chance() == false || sleep == 'jail':
		return false
	if shackles_chance != null:
		var tmpchance = max(0, shackles_chance)
		if randf()*100 <= tmpchance:
			process_event(variables.TR_SHACKLES_OFF)
			#shackles_chance = null
			input_handler.emit_signal('shackles_off') #stub
		return
	var minchance = 50-min(obedience + loyal/2, fear + loyal/2)
	if randf()*50 <= minchance:
		escape()

func escape():
	pass


func translate(text):
	var rtext = ''
	text = text.replace("[He]", globals.fastif(sex == 'male', 'He', 'She'))
	text = text.replace("[he]", globals.fastif(sex == 'male', 'he', 'she'))
	text = text.replace("[his]", globals.fastif(sex == 'male', 'his', 'her'))
	text = text.replace("[him]", globals.fastif(sex == 'male', 'him', 'her'))
	text = text.replace("[His]", globals.fastif(sex == 'male', 'His', 'Her'))
	text = text.replace("[raceadj]", races.racelist[race].adjective)
	text = text.replace("[race]", races.racelist[race].name)
	text = text.replace("[name]", get_short_name())
	text = text.replace("[age]", age.capitalize())
	text = text.replace("[male]", sex)
	text = text.replace("[eye_color]", eye_color)
	text = text.replace("[hair_color]", hair_color)
	match sex:
		'male':
			rtext = 'boy'
		'female':
			rtext = 'girl'
		'futa':
			rtext = 'futanari'
	text = text.replace("[boy]", rtext)
	
	return text

func calculate_price():
	var value = 0
	value += (physics + wits + charm + sexuals)*2.5
	value += (physics_factor + wits_factor + charm_factor + sexuals_factor + tame_factor + brave_factor)*8 + growth_factor*25 + magic_factor*15
	value += professions.size()*40
	
	return max(100,round(value))

func get_icon():
	if icon_image == null:
		return null
	if ResourcePreloader.new().has_resource(icon_image) == false:
		return globals.loadimage(icon_image)
	else:
		return load(icon_image)

func get_body_image():
	if ResourcePreloader.new().has_resource(body_image) == null:
		return globals.loadimage(body_image)
	else:
		if body_image == 'default':
			var text = race.to_lower().replace('halfkin','beastkin')
			if sex == 'male':
				text += "_m"
			else:
				text += "_f"
			if images.shades.has(text):
				return images.shades[text]
			else:
				return null
		return load(body_image)


func random_icon():
	var array = []
	var racenames = race.split(" ")
#commented because runtame error, need not fixing here
#	for i in globals.dir_contents(globals.globalsettings.portrait_folder):
#		for k in racenames:
#			if i.findn(k) >= 0:
#				array.append(i)
#				continue
	if array.size() > 0:
		icon_image = array[randi()%array.size()]


#effects related part from displaced
#if you are planning to use more functions from it (trait-related, eqip etc) - keep track of actual code
func apply_atomic(template): 
	match template.type:
		'damage':
			#deal_damage(template.value, template.source)
			pass
		'heal':
			#heal(template.value)
			pass
		'mana':
			#mana_update(template.value)
			pass
		'stat_set', 'stat_set_revert':
			template.buffer = get(template.stat)
			set(template.stat, template.value)
		'stat_add':
			set(template.stat, get(template.stat) + template.value)
		'stat_mul':
			set(template.stat, get(template.stat) * template.value)
		'signal':
			#stub for signal emitting
			globals.emit_signal(template.value)
		'remove_effect': 
			remove_temp_effect_tag(template.value)
		'add_trait':
			#to implement, since this part was not transfered from displaced
			pass
		'event':
			process_event(template.value)


func remove_atomic(template):
	match template.type:
		'stat_set_revert':
			set(template.stat, template.buffer)
		'stat_add':
			set(template.stat, get(template.stat) - template.value)
		'stat_mul':
			set(template.stat, get(template.stat) / template.value)

func find_temp_effect(eff_code):
	var res = -1
	var tres = 9999999
	var nm = 0
	for i in range(temp_effects.size()):
		var eff = effects_pool.get_effect_by_id(temp_effects[i])
		if eff.template.name != eff_code:continue
		nm += 1
		if eff.remains < tres: 
			tres = eff.remains
			res = i
	return {num = nm, index = res}

func find_temp_effect_tag(eff_tag):
	var res = []
	for e in temp_effects:
		var eff = effects_pool.get_effect_by_id(e)
		if eff.tags.has(eff_tag):
			res.push_back(e)
		return res

func find_eff_by_trait(trait_code):
	var res = []
	for e in (static_effects + own_area_effects + triggered_effects + temp_effects):
		var eff = effects_pool.get_effect_by_id(e)
		if eff.self_args.has('trait'):
			if eff.self_args.trait == trait_code:
				res.push_back(e)
	return res

func find_eff_by_item(item_id):
	var res = []
	for e in (static_effects + own_area_effects + triggered_effects + temp_effects):
		var eff = effects_pool.get_effect_by_id(e)
		if eff.self_args.has('item'):
			if eff.self_args.item == item_id:
				res.push_back(e)
	return res

func apply_temp_effect(eff_id):
	var eff = effects_pool.get_effect_by_id(eff_id)
	var eff_n = eff.template.name
	var tmp = find_temp_effect(eff_n)
	if (tmp.num < eff.template.stack) or (eff.template.stack == 0):
		temp_effects.push_back(eff_id)
		#eff.applied_pos = position
		eff.applied_char = id
		eff.apply()
	else:
		var eff_a = effects_pool.get_effect_by_id(temp_effects[tmp.index])
		match eff_a.template.type:
			'temp_s':eff_a.reset_duration()
			'temp_p':eff_a.reset_duration() #i'm not sure if this case should exist or if it should be treated like this
			'temp_u':eff_a.upgrade() #i'm also not sure about this collision treatement, but for this i'm sure that upgradeable effects should have stack 1
		eff.remove()


func add_area_effect(eff_id):
	var eff = effects_pool.get_effect_by_id(eff_id)
	own_area_effects.push_back(eff_id)
	eff.apply()

func remove_area_effect(eff_id):
	own_area_effects.erase(eff_id)

func add_ext_area_effect(eff_id):
	if own_area_effects.has(eff_id): return
	area_effects.push_back(eff_id)

func remove_ext_area_effect(eff_id):
	if own_area_effects.has(eff_id): return
	area_effects.erase(eff_id)

func set_position(new_pos):
	if new_pos == position: return
	#remove ext area effects
	for e in area_effects:
		var eff = effects_pool.get_effect_by_id(e)
		eff.remove_pos(position)
	
	position = new_pos
	#reapply own area effects
	for e in own_area_effects:
		var eff = effects_pool.get_effect_by_id(e)
		eff.apply()
	#reapply ext area effects
	for e in area_effects:
		var eff = effects_pool.get_effect_by_id(e)
		eff.apply_pos(position)


func apply_effect(eff_id):
	var obj = effects_pool.get_effect_by_id(eff_id)
	match obj.template.type:
		'static': 
			static_effects.push_back(eff_id)
			#obj.applied_pos = position
			obj.applied_char = id
			obj.apply()
		'trigger': 
			triggered_effects.push_back(eff_id)
			#obj.applied_pos = position
			obj.applied_char = id
			obj.apply()
		'temp_s','temp_p','temp_u': apply_temp_effect(eff_id)
		'area': add_area_effect(eff_id)
		'oneshot': 
			obj.applied_obj = self
			obj.apply()


func remove_effect(eff_id):
	var obj = effects_pool.get_effect_by_id(eff_id)
	match obj.template.type:
		'static': static_effects.erase(eff_id)
		'trigger': triggered_effects.erase(eff_id)
		'temp_s','temp_p','temp_u': temp_effects.erase(eff_id)
		'area': remove_area_effect(eff_id)

func remove_temp_effect(eff_id):#warning!! this mathod can remove effect that is not applied to character
	var eff = effects_pool.get_effect_by_id(eff_id)
	eff.remove()

func remove_all_temp_effects():
	for e in temp_effects:
		var obj = effects_pool.get_effect_by_id(e)
		obj.call_deferred('remove')

func remove_temp_effect_tag(eff_tag):#function for non-direct temps removing, like heal or dispel
	var tmp = find_temp_effect_tag(eff_tag)
	if tmp.size() == 0: return
	var i = globals.rng.randi_range(0, tmp.size()-1)
	remove_temp_effect(tmp[i])

func clean_effects():#clean effects before deleting character
	for e in temp_effects + static_effects + triggered_effects + own_area_effects:
		var eff = effects_pool.get_effect_by_id(e)
		eff.remove()

func process_event(ev):
	for e in temp_effects:
		var eff = effects_pool.get_effect_by_id(e)
		eff.process_event(ev)
	for e in triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill: continue
		var tr = eff.process_event(ev) #stub for more direct controling of temps removal

func can_act():
	var res = true
	for e in static_effects + temp_effects + triggered_effects:
		var obj = effects_pool.get_effect_by_id(e)
		if obj.template.has('disable'):
			res = false

func calculate_number_from_string_array(array):
	var endvalue = 0
	var firstrun = true
	for i in array:
		var modvalue = i
		if i.find('caster') >= 0:
			i = i.split('.')
			if i[0] == 'caster':
				#modvalue = str(self[i[1]])
				modvalue = str(get(i[1]))
			elif i[0] == 'target':
				return ""; #nonexistent yet case of skill value being based completely on target
		if !modvalue[0].is_valid_float():
			if modvalue[0] == '-' && firstrun == true:
				endvalue += float(modvalue)
			else:
				endvalue = input_handler.string_to_math(endvalue, modvalue)
		else:
			endvalue += float(modvalue)
		firstrun = false
	return endvalue

func process_check(check):
	if typeof(check) == TYPE_ARRAY:
		var res = true
		for ch in check:
			res = res and simple_check(ch)
		return res
	else: return simple_check(check)

func simple_check(req):#Gear, Race, Types, Resists, stats
	var result
	match req.type:
		'chance':
			result = (randf()*100 < req.value);
		'stats':
			result = input_handler.operate(req.operant, self.get(req.name), req.value)
		'gear':
			match req.slot:
				'any':
					var tempresult = false
					for i in gear.values():
						if i != null:
							tempresult = input_handler.operate(req.operant, state.items[i][req.name], state.items[i][req.value])
							if tempresult == true:
								result = true
								break
				'all':
					result = true
					for i in gear.values():
						if i != null:
							if input_handler.operate(req.operant, state.items[i][req.name], state.items[i][req.value]) == false:
								result = false
								break
		'race': 
			result = (req.value == race);
		'race_group':
			#stub to implement humanoid and non-humanoid checks
			pass
	return result

func stat_update(stat, value):
	var tmp = get(stat)
	value = round(value)
	if variables.dmg_rel_list.has(stat): set(stat, tmp + value)
	else: set(stat, value)
	if tmp != null: tmp = get(stat) - tmp
	else:  tmp = get(stat)
	return tmp

func get_all_buffs():
	var res = {}
	for e in temp_effects + static_effects + triggered_effects:
		var eff = effects_pool.get_effect_by_id(e)
		#eff.calculate_args()
		for b in eff.buffs:
			b.calculate_args()
			if !res.has(b.template_name):
				if !(b.template.has('limit') and b.template.limit == 0):
					res[b.template_name] = []
					res[b.template_name].push_back(b)
			elif (!b.template.has('limit')) or (res[b.template_name].size() < b.template.limit):
				res[b.template_name].push_back(b)
	for e in area_effects:
		var eff:area_effect = effects_pool.get_effect_by_id(e)
		if !eff.is_applied_to_pos(position) :
			continue
		#eff.calculate_args()
		for b in eff.buffs:
			b.calculate_args()
			if !res.has(b.template_name):
				if !(b.template.has('limit') and b.template.limit == 0):
					res[b.template_name] = []
					res[b.template_name].push_back(b)
			elif (!b.template.has('limit')) or (res[b.template_name].size() < b.template.limit):
				res[b.template_name].push_back(b)
	var tmp = []
	for b_a in res.values():
		for b in b_a: tmp.push_back(b)
	return tmp

func check_skill_availability(s_code, target):
	var check = true
	
	var template = Skilldata.Skilllist[s_code]
	var descript = ''
	
	if mp < template.manacost:
		descript = get_short_name() + ": Not enough mana."
		check = false
	if energy < template.energycost:
		descript = get_short_name() + ": Not enough energy."
		check = false
	if social_skills_charges.has(s_code) && social_skills_charges[s_code] >= template.charges:
		descript = get_short_name() + ": " + template.name + " - No charges left."
		check = false
	
	return {check = check, descript = descript}

func use_social_skill(s_code, target):#add logging if needed
	var template = Skilldata.Skilllist[s_code]
	
	var check = check_skill_availability(s_code, target)
	if check.check == false:
		input_handler.SystemMessage(check.descript)
		return
	input_handler.last_action_data = {code = 'social_skill', skill = s_code, caster = self, target = target}
	
	
	#paying costs
	if template.has('goldcost'):
		state.money -= template.goldcost
	self.mp -= template.manacost
	self.energy -= template.energycost
	
	if social_skills_charges.has(s_code):
		social_skills_charges[s_code] += 1
	else:
		social_skills_charges[s_code] = 1
	social_cooldowns[s_code] = template.cooldown
	
	#calcuate 'all' receviers
	var targ_targ = [target]
	var targ_cast = [self]
	var targ_all = []
	for h_id in state.characters:
		if id == h_id || target.id == h_id: continue
		if state.characters[h_id].work == 'travel':continue
		targ_all.push_back(state.characters[h_id])
	
	#create s_skill and process triggers
	var s_skill = S_Skill.new()
	s_skill.createfromskill(s_code)
	s_skill.setup_caster(self)
	s_skill.setup_target(target)
	s_skill.process_event(variables.TR_CAST)
	for e in triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill)
			eff.process_event(variables.TR_S_CAST)
			eff.set_args('skill', null)
		else:
			eff.process_event(variables.TR_S_CAST)
	for e in target.triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill)
			eff.process_event(variables.TR_S_TARGET) 
			eff.set_args('skill', null)
		else:
			eff.process_event(variables.TR_S_TARGET)
	#assumption that no social skill will have more than 1 repeat or target_number 
	s_skill.setup_final()
	s_skill.hit_roll()
	s_skill.resolve_value(true)
	#s_skill.calculate_dmg() not really needed
	
	#to implement not fully described social chance-to-success system 
	
	var effect_text = '\n'
	
	#applying values
	for i in range(s_skill.value.size()):
		var targ_fin
		match s_skill.receiver[i]:
			'caster': targ_fin = targ_cast
			'target': targ_fin = targ_targ
			'all': targ_fin = targ_all
		for h in targ_fin:
			var tmp = h.stat_update(s_skill.damagestat[i], s_skill.value[i])
			if s_skill.is_drain: self.stat_update(s_skill.damagestat[i], -tmp)
			effect_text += "\n" + h.name + ", " + globals.statdata[s_skill.damagestat[i]].name + ": "  + str(round(tmp)) 
	
	if template.has("dialogue"):
		var args = {name1 = self, name2 = target, bonustext = effect_text}
		if check_skill_availability(s_code, target).check == true:
			args.repeat = true
		input_handler.interactive_message(template.dialogue, 'social_skill', args)
	#postdamage triggers
	s_skill.process_event(variables.TR_POSTDAMAGE)
	for e in triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill)
			eff.process_event(variables.TR_POSTDAMAGE)
			eff.set_args('skill', null)
		else:
			eff.process_event(variables.TR_POSTDAMAGE)
	for e in target.triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill)
			eff.process_event(variables.TR_POSTDAMAGE) 
			eff.set_args('skill', null)
		else:
			eff.process_event(variables.TR_POSTDAMAGE)
	
	input_handler.update_slave_list()
	input_handler.update_slave_panel()

