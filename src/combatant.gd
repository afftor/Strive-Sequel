extends Reference
class_name Slave

var id = ''
var is_person = true

var unique 

var icon = "res://assets/images/portraits/GoblinTrader.png" #images.portraits[images.portraits.keys()[randi()%images.portraits.size()]].load_path
var body = null

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
var effects = []

var obed_mods = []
var fear_mods = []
var lust_mods = []

var obedience = 100.0 setget obed_set, obed_get
var fear = 70.0 setget fear_set, fear_get
var lust = 20.0 setget lust_set, lust_get
var loyal = 0.0
var resist = 0
var lustmax = 50

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

var hitrate = 0
var evasion = 0
var resists = 0
var armor = 0
var mdef = 0

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

var area = ''
var location = 'mansion'
var travel_target = {area = '', location = ''}
var travel_time = 0

#communications
var relatives = {}
var tags = []


#temps
#var profs = load("res://assets/data/Skills.gd").new().professions

func generate_random_character_from_data(races, desired_class = null, adjust_difficulty = 0):
	var gendata = {race = '', sex = 'random', age = 'random'}
	
	gendata.race = races[randi()%races.size()]
	#figuring out the race

	create(gendata.race, gendata.sex, gendata.age)
	
	if randf() <= 0.003:
		pass #make check for easter egg character
	
	
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

func get_class_list(category, person):
	var array = []
	for i in Skilldata.professions.values():
		if (category != 'any' && i.categories.has(category) == false) || professions.has(i.code) == true:
			continue
		if checkreqs(i.reqs, true) == true:
			array.append(i)
	
	return array



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
	
	#setting food filter
	for i in Items.materiallist.values():
		if i.type == 'food':
			if food_love == i.code:
				food_filter.high.append(i.code)
			elif food_hate.has(i.code):
				food_filter.low.append(i.code)
			else:
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

func use_skill(skillcode, target):
	var skill = Skilldata.Skilllist[skillcode]
	if mp < skill.manacost:
		input_handler.SystemMessage(get_short_name() + ": Not enough mana.")
		return
	if energy < skill.energycost:
		input_handler.SystemMessage(get_short_name() + ": Not enough energy.")
		return
	if social_skills_charges.has(skillcode) && social_skills_charges[skillcode] >= skill.charges:
		input_handler.SystemMessage(get_short_name() + ": " + skill.name + " - No charges left.")
		#No charges left
		return
	
	
	self.mp -= skill.manacost
	self.energy -= skill.energycost
	
	if social_skills_charges.has(skillcode):
		social_skills_charges[skillcode] += 1
	else:
		social_skills_charges[skillcode] = 1
	social_cooldowns[skillcode] = skill.cooldown
	
	#add skill effect

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
	var dict = {code = taskcode, product = taskproduct, progress = 0, threshhold = task.production[taskproduct].progress_per_item, workers = [], iterations = iterations}
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
	var skip_work = false
	if work == '':
		skip_work = true
	
	
	
	food_counter -= 1
	if food_counter <= 0:
		food_counter = 23
		get_food()
	
	
	self.fatigue += 1
	self.lust += 1.05
	
	self.obedience -= 100.0/(24 + 24*tame_factor) #2.43 - 0.35*tame_factor #2 days min, 6 days max
	self.fear -= 100.0/max((168 - 24*brave_factor), 24)#0.35 + 0.35*brave_factor #2 days min, 6 days max
	
	if work == 'travel':
		if travel_time > 0:
			travel_time -= 1
			if travel_time == 0:
				area = travel_target.area
				location = travel_target.location
				state.emit_signal("slave_arrived", self)
		
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
	pass

func energy_set(value):
	energymax = 100 + energybonus + round(physics + physics_bonus)
	if value < 0:
		self.exhaustion += -value
		energy = 0
	else:
		energy = min(value, energymax)

func fatigue_set(value):
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
			if state.materials[i] >= food_consumption:
				state.materials[i] -= food_consumption
				eaten = true
			if eaten == true:
				if food_love == i:
					pass#add food bonus
				elif food_hate.has(i):
					pass#add food debuf
				break
		if eaten == true:
			break
	
	if eaten == false:
		pass#add starvation debuf

func work_tick():
	var currenttask
	for i in state.active_tasks:
		if i.workers.has(self.id):
			currenttask = i
	
	if currenttask == null:
		work = ''
		return
	
	if currenttask.product in ['smith','alchemy','tailor','cook']:
		if state.craftinglists[currenttask.product].size() <= 0:
			state.text_log_add(get_short_name() + ": No craft task for " + currenttask.product.capitalize() + ". ")
			rest_tick()
			return
		else:
			var craftingitem = state.craftinglists[currenttask.product][0]
			if craftingitem.resources_taken == false:
				if check_recipe_resources(craftingitem) == false:
					state.text_log_add(get_short_name() + ": Not Enough Resources for craft. ")
					rest_tick()
					return
				else:
					spend_resources(craftingitem)
			current_day_spent.workhours += 1
			self.energy -= 8.75
			base_exp += 2.1
			var workstat = races.tasklist[currenttask.code].workstat
			set(workstat, get(workstat) + 0.1)
			craftingitem.workunits += races.call(races.tasklist[currenttask.code].production[currenttask.product].progress_function, self)*(productivity/100)
			if craftingitem.workunits >= craftingitem.workunits_needed:
				make_item(craftingitem)
				craftingitem.workunits -= craftingitem.workunits_needed
				while craftingitem.repeats != 0:
					if check_recipe_resources(craftingitem) == true:
						spend_resources(craftingitem)
						if craftingitem.workunits >= craftingitem.workunits_needed:
							make_item(craftingitem)
							craftingitem.workunits -= craftingitem.workunits_needed
					else:
						state.text_log_add(get_short_name() + ": " + "Not Enough Resources for craft. ")
						break
	else:
		current_day_spent.workhours += 1
		self.energy -= 8.75
		#print(races.call(races.tasklist[currenttask.code].production[currenttask.product].progress_function,self)*(productivity/100))
		var workstat = races.tasklist[currenttask.code].workstat
		set(workstat, get(workstat) + 0.1)
		base_exp += 2.1
		currenttask.progress += races.call(races.tasklist[currenttask.code].production[currenttask.product].progress_function, self)*(productivity/100)
		while currenttask.threshhold <= currenttask.progress:
			currenttask.progress -= currenttask.threshhold
			state.materials[races.tasklist[currenttask.code].production[currenttask.product].item] += 1

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
			globals.AddItemToInventory(globals.CreateGearItem(item.code, temprecipe.partdict))
	if temprecipe.repeats > 0:
		temprecipe.repeats -= 1
		if temprecipe.repeats == 0:
			state.craftinglists[Items.recipes[temprecipe.code].worktype].erase(temprecipe)

func joy_tick():
	current_day_spent.joyhours += 1
	fatigue -= 4

func rest_tick():
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
