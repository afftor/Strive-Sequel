extends Node


#also tried to fix cooking but not sure if all was made
var tasklist = {
	brothel = {
		code = 'brothel',
		production_reqs = [],
		reqs = [],
		name = 'TASKBROTHEL',
		descript = '',
		workstat = 'sex_skills',
		# Legacy progress-based service fields. The current service task bypasses
		# generic production and pays gold in ch_leveling.select_brothel_activity().
		# progress_per_item = 0.17,
		# production_code = 'prostitutegold',
		# production_item = 'gold',
		# progress_function = 'whoring_gold',
		# production_reqs = [],
		production_icon = "res://assets/images/gui/service.png",
		# production_descript = tr("JOBPROSTITUTEGOLDDESCRIPT"),
		#production = {prostitutegold = {code = 'prostitutegold', descript = tr("JOBPROSTITUTEGOLDDESCRIPT"), icon = load("res://assets/images/iconsitems/gold.png"), item = 'gold', progress_per_item = 1, reqs = [], progress_function = 'whoring_gold'}},
		icon = null,
		tags = ['sex'],
		mod = 'mod_pros'
	},
	special = { #don't remove - we need fallback for special tasks
		code = 'special',
		reqs = [],
		base_workers = 1,
		production_icon = "res://assets/Textures_v2/DUNGEON/Icons/exclaim.png",
		production_descript = tr("JOBPROSTITUTEGOLDDESCRIPT"),
		icon = "res://assets/Textures_v2/DUNGEON/Icons/exclaim.png",
		progress_per_item = 10,
		tags = ['hide_progress_ratio', 'special']
	},
	fighters_task = {
		code = 'fighters_task',
		reqs = [],
		base_workers = 1,
		production_icon = "res://assets/images/gui/service.png",
		production_descript = tr("JOBPROSTITUTEGOLDDESCRIPT"),
		icon = "res://assets/images/gui/service.png",
		progress_per_item = 10,
		tags = ['hide_progress_ratio', 'special']
	},
	recruit_easy = {  #2fix
		code = 'recruit_easy',
		reqs = [],
		name = 'TASKRECRUIT_EASY',
		descript = '',
		base_workers = 1,
		progress_per_item = 10,
		production_reqs = [],
		production_icon = "res://assets/images/gui/gui icons/icon_recruit.png",
		production_descript = tr("JOBPROSTITUTEGOLDDESCRIPT"),
		#production = {prostitutegold = {code = 'prostitutegold', descript = tr("JOBPROSTITUTEGOLDDESCRIPT"), icon = load("res://assets/images/iconsitems/gold.png"), item = 'gold', progress_per_item = 1, reqs = [], progress_function = 'whoring_gold'}},
		icon = null,
		tags = ['recruiting'],
		workstat = 'charm',
		function = 'settlement_recruiting_easy',
		mod = '' #keep those
	},
	recruit_hard = {  #2fix
		code = 'recruit_hard',
		reqs = [],
		name = 'TASKRECRUIT_HARD',
		descript = '',
		base_workers = 1,
		progress_per_item = 25,
		production_reqs = [],
		production_icon = "res://assets/images/gui/gui icons/icon_recruit.png",
		production_descript = tr("JOBPROSTITUTEGOLDDESCRIPT"),
		#production = {prostitutegold = {code = 'prostitutegold', descript = tr("JOBPROSTITUTEGOLDDESCRIPT"), icon = load("res://assets/images/iconsitems/gold.png"), item = 'gold', progress_per_item = 1, reqs = [], progress_function = 'whoring_gold'}},
		icon = null,
		tags = ['recruiting'],
		workstat = 'charm',
		function = 'settlement_recruiting_hard',
		mod = '' #keep those
	},
	building = {
		code = 'building',
		reqs = [],
		name = 'TASKBUILDING',
		descript = tr("TASKBUILDINGDESCRIPT"),
		workstat = 'physics',
		worktool = 'hammer',
		base_workers = 4,
		workers_per_upgrade = 0,
		upgrade_code = 'buildertools',
		production_code = 'building',
		production_item = 'building',
		progress_function = 'building_progress',
		production_reqs = [],
		production_icon = "res://assets/Textures_v2/MANSION/icon_upgrade_64.png",
		production_descript = tr("JOBBUILDINGCRAFTDESCRIPT"),
		progress_per_item = 1.0,
		#production = {building = {code = 'building', item = 'building',descript = tr("JOBBUILDINGCRAFTDESCRIPT"), icon = load("res://assets/Textures_v2/MANSION/icon_upgrade_64.png"), progress_per_item = 1, reqs = [], progress_function = 'building_progress'}},
		icon = null,
		tags = ['building', 'hide_progress_ratio', 'crafting'],
		mod = 'mod_build'
	},
	cooking = {
		code = 'cooking',
		reqs = [],
		name = 'TASKCOOKING',
		descript = '',
		workstat = 'wits',
		progress_per_item = 1,
		production_code = 'cooking',
		production_item = 'cooking',
		progress_function = 'cooking_progress',
		production_reqs = [],
		production_icon = "res://assets/Textures_v2/MANSION/icon_cooking_64.png",
		production_descript = tr("JOBCOOKINGCRAFTDESCRIPT"),
		#production = {cooking = {code = 'cooking',item = 'cooking',descript = tr("JOBCOOKINGCRAFTDESCRIPT"), icon = load("res://assets/Textures_v2/MANSION/icon_cooking_64.png"), progress_per_item = 1, reqs = [], progress_function = 'cooking_progress'}},
		icon = null,
		tags = ['cooking', 'hide_progress_ratio', 'crafting'],
		mod = 'mod_cook'
	},
	tailor = {
		code = 'tailor',
		reqs = [{type = "has_craft_room", name = 'tailor_workshop', value = 1}],
		name = 'TASKTAILOR',
		descript = '',
		workstat = 'physics',
		worktool = 'hunt_knife',
		base_workers = 0,
		workers_per_upgrade = 1,
		upgrade_code = 'tailor',
		production_code = 'cooking',#????
		production_item = 'tailor',
		progress_function = 'tailor_progress',
		production_reqs = [],
		production_icon = "res://assets/Textures_v2/MANSION/icon_tailoring_64.png",
		production_descript = tr("JOBTAILORCRAFTDESCRIPT"),
		progress_per_item = 1,
		#production = {tailor = {code = 'tailor',item = 'tailor',descript = tr("JOBTAILORCRAFTDESCRIPT"), icon = load("res://assets/Textures_v2/MANSION/icon_tailoring_64.png"), progress_per_item = 1, reqs = [], progress_function = 'tailor_progress'}},
		icon = null,
		tags = ['tailor','hide_progress_ratio', 'crafting'],
		mod = 'mod_tailor'
	},
	smith = {
		code = 'smith',
		reqs = [{type = "has_craft_room", name = 'forge', value = 1}],
		name = 'TASKSMITH',
		descript = '',
		workstat = 'physics',
		worktool = 'hammer',
		base_workers = 0,
		workers_per_upgrade = 1,
		upgrade_code = 'forge',
		production_code = 'smith',
		production_item = 'smith',
		progress_function = 'forge_progress',
		production_reqs = [],
		production_icon = "res://assets/Textures_v2/MANSION/icon_blacksmith_64.png",
		production_descript = tr("JOBSMITHCRAFTDESCRIPT"),
		progress_per_item = 1,
		#production = {smith = {code = 'smith',item = 'smith',descript = tr("JOBSMITHCRAFTDESCRIPT"), icon = load("res://assets/Textures_v2/MANSION/icon_blacksmith_64.png"), progress_per_item = 1, reqs = [], progress_function = 'forge_progress'}},
		icon = null,
		tags = ['smith', 'hide_progress_ratio', 'crafting'],
		mod = 'mod_smith'
	},
	alchemy = {
		code = 'alchemy',
		reqs = [{type = "has_craft_room", name = 'alchemy_room', value = 1}],
		name = 'TASKALCHEMY',
		descript = tr("TASKALCHEMYDESCRIPT"),
		workstat = 'wits',
		base_workers = 0,
		workers_per_upgrade = 1,
		upgrade_code = 'alchemy',
		production_code = 'alchemy',
		production_item = 'alchemy',
		progress_function = 'alchemy_progress',
		production_reqs = [],
		production_icon = "res://assets/Textures_v2/MANSION/icon_alchemy_64.png",
		production_descript = tr("JOBALCHEMYCRAFTDESCRIPT"),
		progress_per_item = 1,
		#production = {alchemy = {code = 'alchemy',item = 'alchemy',descript = tr("JOBALCHEMYCRAFTDESCRIPT"), icon = load("res://assets/Textures_v2/MANSION/icon_alchemy_64.png"), progress_per_item = 1, reqs = [], progress_function = 'alchemy_progress'}},
		icon = null,
		tags = ['alchemy', 'hide_progress_ratio', 'crafting'],
		mod = 'mod_alchemy'
	},
	fishing = {
		code = 'fishing',
		#the building on the estate grounds whose places this job draws on -
		#see game_res._fix_max_workers()
		room_type = 'fishing_hut',
		reqs = [],
		name = 'TASKFISHING',
		descript = '',
		workstat = 'wits',
		worktool = 'rod',
		base_workers = 1,
		workers_per_upgrade = 1,
		#production = {fishing = {code = 'fishing',item = 'fish', progress_per_item = 1.1, reqs = [], progress_function = 'fishing'}},
		production_code = 'fishing',
		production_item = 'fish',
		production_loot = 'prod_task_fishing',
		progress_per_item = 0.73,
		progress_function = 'fishing',
		production_reqs = [],
		icon = null,
		tags = [],
		mod = 'mod_fish'
	},
	hunting = {
		code = 'hunting',
		#the building on the estate grounds whose places this job draws on -
		#see game_res._fix_max_workers()
		room_type = 'hunting_cabin',
		reqs = [],
		name = 'TASKHUNTING',
		descript = '',
		workstat = 'physics',
		worktool = 'hunt_knife',
		base_workers = 0,
		workers_per_upgrade = 1,
		#production = {hunting = {code = 'hunting',item = 'meat', progress_per_item = 1, reqs = [], progress_function = 'fishing'}},
		production_code = 'hunting',
		production_item = 'meat',
		production_loot = 'prod_task_hunting',
		progress_per_item = 0.67,
		progress_function = 'hunt_meat',
		production_reqs = [],
		icon = null,
		tags = [],
		mod = 'mod_hunt'
	},
	
	farming_veges = {
		code = 'farming_veges',
		reqs = [],
		production_reqs = [],
		#the building on the estate grounds whose places this job draws on -
		#see game_res._fix_max_workers()
		room_type = 'garden',
		name = 'TASKFARMING_VEGES',
		descript = '',
		workstat = 'physics',
		worktool = 'sickle',
		base_workers = 0,
		workers_per_upgrade = 1,
		production_code = 'farming_vege',
		production_item = 'vegetables',
		production_loot = 'prod_task_farming_veges',
		progress_per_item = 0.93,
		progress_function = 'farming_veges',
		icon = null,
		tags = [],
		mod = 'mod_farm'
	},
	farming_grains = {
		code = 'farming_grains',
		reqs = [],
		production_reqs = [],
		#the building on the estate grounds whose places this job draws on -
		#see game_res._fix_max_workers()
		room_type = 'wheat_field',
		name = 'TASKFARMING_GRAINS',
		descript = '',
		workstat = 'physics',
		worktool = 'sickle',
		base_workers = 0,
		workers_per_upgrade = 1,
		production_code = 'farming_grain',
		production_item = 'grain',
		production_loot = 'prod_task_farming_grains',
		progress_per_item = 0.8,
		progress_function = 'farming_wheat',
		icon = null,
		tags = [],
		mod = 'mod_farm'
	},
	farming_cotton = {
		code = 'farming_cotton',
		reqs = [],
		production_reqs = [],
		name = 'TASKFARMING_COTTON',
		descript = '',
		workstat = 'physics',
		worktool = 'sickle',
		base_workers = 0,
		workers_per_upgrade = 2,
		production_code = 'farming_cloth',
		production_item = 'cloth',
		production_loot = 'prod_task_farming_cotton',
		progress_per_item = 0.67,
		progress_function = 'farming_cloth',
		icon = null,
		tags = [],
		mod = 'mod_farm'
	},
	farming_cloth_silk = {
		code = 'farming_cloth_silk',
		reqs = [],
		production_reqs = [],
		name = 'TASKFARMING_CLOTH_SILK',
		descript = '',
		workstat = 'wits',
		worktool = 'sickle',
		base_workers = 0,
		workers_per_upgrade = 1,
		production_code = 'farming_cloth_silk',
		production_item = 'clothsilk',
		production_loot = 'prod_task_farming_cloth_silk',
		progress_per_item = 2.5,
		progress_function = 'farming_cloth',
		icon = null,
		tags = [],
		mod = 'mod_farm'
	},
	gathering_wood = {
		code = 'gathering_wood',
		production_reqs = [],
		#the building on the estate grounds whose places this job draws on -
		#see game_res._fix_max_workers()
		room_type = 'forestry',
		reqs = [],
		name = 'TASKGATHERING_WOOD',
		descript = '',
		workstat = 'physics',
		worktool = 'axe',
		base_workers = 0,
		workers_per_upgrade = 2,
		progress_per_item = 0.75,
		production_code = 'woodgather',
		production_item = 'wood',
		production_loot = 'prod_task_gathering_wood',
		progress_function = 'woodcutting_lumber',
		#production = {woodgather  = {code = 'woodgather', item = 'wood', progress_per_item = 4.5, reqs = [{type = "has_upgrade", name = 'resource_gather_wood', value = 1}], progress_function = 'woodcutting_lumber'}},
		icon = null,
		tags = [],
		mod = 'mod_collect'
	},
	
	gathering_wood_magic = {
		code = 'gathering_wood_magic',
		reqs = [],
		production_reqs = [],
		name = 'TASKGATHERING_WOOD_MAGIC',
		descript = '',
		workstat = 'physics',
		worktool = 'axe',
		base_workers = 0,
		workers_per_upgrade = 1,
		production_code = 'gathering_wood_magic',
		production_item = 'woodmagic',
		production_loot = 'prod_task_gathering_wood_magic',
		progress_per_item = 2.5,
		progress_function = 'woodmagiccutting_lumber',
		icon = null,
		tags = [],
		mod = 'mod_collect'
	},
	
	gathering_wood_iron = {
		code = 'gathering_wood_iron',
		reqs = [],
		production_reqs = [],
		name = 'TASKGATHERING_WOOD_IRON',
		descript = '',
		workstat = 'physics',
		worktool = 'axe',
		base_workers = 0,
		workers_per_upgrade = 1,
		production_code = 'gathering_wood_iron',
		production_item = 'woodiron',
		production_loot = 'prod_task_gathering_wood_iron',
		progress_per_item = 3,
		progress_function = 'woodironcutting_lumber',
		icon = null,
		tags = [],
		mod = 'mod_collect'
	},
	
	mining_stone = {
		code = 'mining_stone',
		#the building on the estate grounds whose places this job draws on -
		#see game_res._fix_max_workers()
		room_type = 'mine',
		reqs = [],
		name = 'TASKMINING_STONE',
		descript = '',
		workstat = 'physics',
		worktool = 'pickaxe',
		base_workers = 0,
		workers_per_upgrade = 2,
		progress_per_item = 0.5,
		production_code = 'gatherstone',
		production_item = 'stone',
		production_loot = 'prod_task_mining_stone',
		progress_function = 'mining_stone',
		production_reqs = [],
		#production = {gatherstone = {code = 'gatherstone', item = 'stone', progress_per_item = 3, reqs = [], progress_function = 'mining_stone'}},
		icon = null,
		tags = [],
		mod = 'mod_collect'
	},
	
	mining_iron = {
		code = 'mining_iron',
		reqs = [],
		production_reqs = [],
		name = 'TASKMINING_IRON',
		descript = '',
		workstat = 'physics',
		worktool = 'pickaxe',
		base_workers = 0,
		workers_per_upgrade = 2,
		production_code = 'mining_iron',
		production_item = 'iron',
		production_loot = 'prod_task_mining_iron',
		progress_per_item = 1,
		progress_function = 'mining_iron',
		icon = null,
		tags = [],
		mod = 'mod_collect'
	},
	
	mining_mithril = {
		code = 'mining_mithril',
		reqs = [],
		production_reqs = [],
		name = 'TASKMINING_MITHRIL',
		descript = '',
		workstat = 'physics',
		worktool = 'pickaxe',
		base_workers = 0,
		workers_per_upgrade = 1,
		production_code = 'mining_mithril',
		production_item = 'mithril',
		production_loot = 'prod_task_mining_mithril',
		progress_per_item = 5.83,
		progress_function = 'mining_mithril',
		icon = null,
		tags = [],
		mod = 'mod_collect'
	},
	mining_obsidian = {
		code = 'mining_obsidian',
		reqs = [],
		production_reqs = [],
		name = 'TASKMINING_OBSIDIAN',
		descript = '',
		workstat = 'physics',
		worktool = 'pickaxe',
		base_workers = 0,
		workers_per_upgrade = 1,
		production_code = 'mining_obsidian',
		production_item = 'obsidian',
		production_loot = 'prod_task_mining_obsidian',
		progress_per_item = 2.5,
		progress_function = 'mining_stone',
		icon = null,
		tags = [],
		mod = 'mod_collect'
	},
	
	

	travel = { #dummy task for travelling assignment
		code = 'travel',
		reqs = [{type = 'disabled'}],
		name = 'TASKTRAVEL',
		descript = tr("TASKTRAVELDESCRIPT"),
		workstat = '',
		production = {},
		icon = null,
		tags = ['hide_progress_ratio'],
	},
	produce = { #dummy task for farming
		code = 'produce',
		reqs = [{type = 'disabled'}],
		name = 'TASKPRODUCE',
		descript = tr("TASKTRAVELDESCRIPT"),
		workstat = '',
		production = {},
		icon = null,
		tags = ['hide_progress_ratio'],
		production_icon = "res://assets/images/gui/gui icons/icon_rest_brothel.png",
	},
}


var gold_tasks_data = {
	waitress = {
		code = 'waitress',
		formula = 'gold_waitress',
		text_events = [],
		workstats = ['charm'],
		workmod = 'mod_service',
		tags = ['has_alt_name'],
	},
	hostess = {
		code = 'hostess',
		formula = 'gold_hostess',
		text_events = [],
		workstats = ['wits'],
		workmod = 'mod_service',
		tags = ['has_alt_name'],
	},
	dancer = {
		code = 'dancer',
		formula = 'gold_dancer',
		text_events = [],
		workstats = ['physics'],
		workmod = 'mod_service',
		tags = [],
	},
	stripper = {
		code = 'stripper',
		formula = 'gold_stripper',
		text_events = [],
		workstats = ['charm'],
#		req_training = 'loyalty_dress_lewd',
		workmod = 'mod_service',
		tags = [],
	},
	
	
	petting = {
		code = 'petting',
		formula = 'gold_petting',
		text_events = [],
		workmod = 'mod_pros',
		workstats = [],
		req_training = 'sexservice',
		min_consent = 1,
		tags = [],
	},
	oral = {
		code = 'oral',
		formula = 'gold_oral',
		text_events = [],
		workmod = 'mod_pros',
		workstats = [],
		req_training = 'sexservice',
		min_consent = 2,
		tags = [],
	},
	pussy = {
		code = 'pussy',
		formula = 'gold_pussy',
		text_events = [],
		workmod = 'mod_pros',
		workstats = [],
		req_training = 'sexservice_adv',
		tags = ['virginity','impregnation'],
		min_consent = 3,
	},
	anal = {
		code = 'anal',
		formula = 'gold_anal',
		text_events = [],
		req_training = 'sexservice_adv',
		workmod = 'mod_pros',
		workstats = [],
		min_consent = 4,
		tags = [],
	},
	penetration = {
		code = 'penetration',
		formula = 'gold_penetration',
		text_events = [],
		req_training = 'sexservice_adv',
		workmod = 'mod_pros',
		workstats = [],
		min_consent = 3,
		tags = [],
	},
	group = {
		code = 'group',
		formula = 'gold_group',
		text_events = [],
		workmod = 'mod_pros',
		workstats = [],
		req_training = 'sexservice_adv',
		tags = ['virginity','impregnation'],
		min_consent = 5,
	},
	sextoy = {
		code = 'sextoy',
		formula = 'gold_sextoy',
		text_events = [],
		workmod = 'mod_pros',
		workstats = [],
		req_training = 'sexservice_adv',
		tags = ['virginity','impregnation'],
		min_consent = 0,
	},
}


var farm_tasks = {
	milk = {
		code = 'milk',
		production_loot = 'prod_farm_milk',
		formula = 'farm_milk',
		reqs = [{code = 'stat', stat = 'lactation', operant = 'eq', value = true}],
	},
	pheromones = {
		code = 'pheromones',
		production_loot = 'prod_farm_pheromones',
		formula = 'farm_pheromones',
		reqs = [{code = 'race_is_beast', check = true}],
	},
	seed = {
		code = 'seed',
		production_loot = 'prod_farm_seed',
		formula = 'farm_seed',
		#TODO: recheck reqs here, orflag in first req makes it irrelevant
		reqs = [{code = 'stat', stat = 'balls_size', operant = 'neq', value = '', orflag = true}, {code = 'stat', stat = 'penis_size', operant = 'neq', value = ''}],
	},
	eggs = {
		code = 'eggs',
		production_loot = 'prod_farm_eggs',
		formula = 'farm_eggs',
		reqs = [{code = 'has_status', status = 'oviposition', check = true}, {code = 'stat', stat = 'has_womb', operant = 'eq', value = true}],
	},
	magic_dust = {
		code = 'magic_dust',
		production_loot = 'prod_farm_magic_dust',
		formula = 'farm_dust',
		reqs = [{code = 'race', race = 'Fairy', check = true}, {orflag = true, code= 'race', race = 'Elf', check = true}, {orflag = true, code = 'race', race = 'DarkElf', check = true}, {orflag = true, code= 'race', race = 'TribalElf', check = true}, {orflag = true, code = 'stat', stat = 'magic_factor', operant = 'gte', value = 5}],
	},
	reptile_blood = {
		code = 'reptile_blood',
		production_loot = 'prod_farm_reptile_blood',
		formula = 'farm_blood',
		reqs = [{code = 'race', race = 'Kobold', check = true}, {orflag = true, code= 'race', race = 'Dragonkin', check = true}, {orflag = true, code= 'race', race = 'Lamia', check = true}],
	},
	
	lizard_skin = {
		code = 'lizard_skin',
		production_loot = 'prod_farm_lizard_skin',
		formula = 'farm_lizard_skin',
		reqs = [{code = 'race', race = 'Kobold', check = true}, {orflag = true, code= 'race', race = 'Dragonkin', check = true}, {orflag = true, code= 'race', race = 'Lamia', check = true}],
	},
	spider_silk = {
		code = 'spider_silk',
		production_loot = 'prod_farm_spider_silk',
		formula = 'farm_silk',
		reqs = [{code = 'has_status', status = 'silksecretion', check = true}],
	},
	light_essence = {
		code = 'light_essence',
		production_loot = 'prod_farm_light_essence',
		formula = 'farm_light',
		reqs = [{code = 'race', race = 'Seraph', check = true}],
	},
	draconic_scales = {
		code = 'draconic_scales',
		production_loot = 'prod_farm_draconic_scales',
		formula = 'farm_scales',
		reqs = [{code = 'race', race = 'Dragonkin', check = true}],
	},
	
	leatherdragon = {
		code = 'leatherdragon',
		production_loot = 'prod_farm_leatherdragon',
		formula = 'farm_leatherdragon',
		reqs = [{code = 'race', race = 'Dragonkin', check = true}],
	},
	dark_essence = {
		code = 'dark_essence',
		production_loot = 'prod_farm_dark_essence',
		formula = 'farm_dark',
		reqs = [{code = 'race', race = 'Demon', check = true}],
	},
	
}


func find_task_for_res(res):
	for i in tasklist:
		if tasklist[i].has("production_item") and tasklist[i].production_item == res:
			return i
	return null


#The loot table a piece of work produces from. Estate jobs and farm products name theirs on
#their own template; raw gathering at a settlement has no template behind it at all, only the
#material being dug up, so it looks up the table named after that material.
#An answer naming no existing table is not an error - loot.get_production_record() then falls
#back to a single-material record, which is the fixed output every one of these used to have.
func find_production_loot(task_code, material = ''):
	if task_code != null and tasklist.has(task_code) and tasklist[task_code].has('production_loot'):
		return tasklist[task_code].production_loot
	if material is String and !material.empty():
		return 'prod_res_' + material
	return ''


func find_farm_production_loot(res):
	if farm_tasks.has(res) and farm_tasks[res].has('production_loot'):
		return farm_tasks[res].production_loot
	return ''
