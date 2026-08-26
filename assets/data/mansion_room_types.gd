extends Reference
#Room type registry for the mansion floorplan view (gui_modules/mansion_view).
#Plain script, not an autoload - use preload("res://assets/data/mansion_room_types.gd").LIST
#
#A type says what a room IS, never where it sits or how big it is: position and size
#belong to the slot it occupies, which comes from the level map in mansion_floor_plans.gd.
#
#Slots are split by kind because the three behave nothing alike:
#	sleep - a bed. Every character needs one, wherever they are on the world map.
#	work  - a workplace. Puts the character on this room's own task, so the room decides
#	        which craft discipline they practise; the global recipe queues still decide
#	        which recipe. See game_res.process_rooms().
#	build - a builder's place. Never declared here: it exists only while the room is
#	        being built, repaired or upgraded, and comes from the room's build record.
#
#Display text is derived from the code, the same way modding_core.fix_main_data() derives
#it for upgradedata.upgradelist:
#	MANSIONROOM_<CODE>          - name
#	MANSIONROOM_<CODE>DESCRIPT  - description
#
#Upgrades listed here are codes from mansion_room_upgrades.gd and apply to THIS room
#instance, unlike upgradedata.upgradelist which is global per code.

const SLOT_KINDS = ['sleep', 'work', 'build']

#fallback used whenever a code is missing from LIST
const DEFAULT = {
	code = 'empty',
	slots = {},
	work_job = null,
	upkeep = 0,
	build_cost = {},
	build_progress = 0,
	upgrades = [],
	#How many of this type the estate must have, and may have. A room with min_count above
	#zero is one the mansion is not allowed to be without - the staircase and the master's
	#own room - and is put up for free if a save arrives without it. max_count 0 means no
	#limit beyond the plots there are to build on.
	min_count = 0,
	max_count = 0,
	master_only = false,
	#part of the building rather than something put in it: cannot be built, moved or pulled
	#down, and every floor is given one
	fixed = false,
	#kept out of the build menu. The master's room is the standing case: the estate has one
	#from the first day and there is no sense in offering a second, nor in offering the first
	#back after somehow losing it
	hidden = false,
	tags = [],
	icon = '',
	color = '4b4b4b',
}

const LIST = {
	#The way between floors, and the whole of it: clicking the stairs is how a floor is
	#changed, so every floor has a set and none of them can be moved or pulled down. It holds
	#nobody and costs nothing - it is structure, like the walls.
	stairs = {
		code = 'stairs',
		slots = {},
		work_job = null,
		min_count = 1,
		upkeep = 0,
		build_cost = {},
		build_progress = 0,
		upgrades = ['stairs_repair'],
		master_only = false,
		fixed = true,
		tags = ['stairs'],
		icon = 'rooms',
		color = '5a5142',
	},

	#The master's own room. The single bed is always the master's; Bed size opens extra
	#beds beside it, Furnishing widens what the room allows rather than who sleeps in it.
	master_bedroom = {
		code = 'master_bedroom',
		slots = {sleep = 1},
		work_job = null,
		max_count = 1,
		min_count = 1,
		upkeep = 0,
		build_cost = {wood = 120, cloth = 60, stone = 40},
		build_progress = 40,
		upgrades = ['furnishing', 'bed_size'],
		master_only = true,
		hidden = true,
		tags = ['housing', 'master_bed'],
		icon = 'rooms_lux',
		color = '6b6040',
	},
	bedrooms = {
		code = 'bedrooms',
		slots = {sleep = 4},
		work_job = null,
		upkeep = 0,
		build_cost = {wood = 60, cloth = 20},
		build_progress = 15,
		upgrades = ['bedrooms_expansion'],
		master_only = false,
		tags = ['housing'],
		icon = 'bedroom',
		color = '3f6b4a',
	},
	#Residents here get the private-room bonus that used to be the 'luxury' work rule.
	luxury_bedrooms = {
		code = 'luxury_bedrooms',
		slots = {sleep = 1},
		work_job = null,
		upkeep = 1,
		build_cost = {wood = 90, cloth = 60},
		build_progress = 25,
		upgrades = ['luxury_expansion'],
		master_only = false,
		tags = ['housing', 'luxury'],
		icon = 'rooms_lux',
		color = '6b3f5c',
	},
	forge = {
		code = 'forge',
		slots = {work = 1},
		work_job = 'smith',
		upkeep = 2,
		build_cost = {stone = 80, iron = 40},
		build_progress = 30,
		upgrades = ['craft_expansion', 'craft_tools'],
		master_only = false,
		tags = ['craft'],
		icon = 'forge',
		color = '6b3f3f',
	},
	alchemy_room = {
		code = 'alchemy_room',
		slots = {work = 1},
		work_job = 'alchemy',
		upkeep = 2,
		build_cost = {wood = 60, stone = 40, iron = 10},
		build_progress = 30,
		upgrades = ['craft_expansion', 'craft_tools'],
		master_only = false,
		tags = ['craft'],
		icon = 'alchemy',
		color = '5a3f6b',
	},
	tailor_workshop = {
		code = 'tailor_workshop',
		slots = {work = 1},
		work_job = 'tailor',
		upkeep = 1,
		build_cost = {wood = 50, cloth = 40},
		build_progress = 25,
		upgrades = ['craft_expansion', 'craft_tools'],
		master_only = false,
		tags = ['craft'],
		icon = 'tailor',
		color = '46456b',
	},
	kitchen = {
		code = 'kitchen',
		slots = {work = 1},
		work_job = 'cooking',
		upkeep = 1,
		build_cost = {wood = 70, stone = 30},
		build_progress = 25,
		upgrades = ['craft_expansion', 'craft_tools'],
		master_only = false,
		tags = ['craft'],
		icon = 'wheat',
		color = '6b4a3f',
	},
	#Nobody works here and nobody sleeps here. The household eats together, and slaves take
	#a little more from a day that has a proper meal in it - see ch_training.day_tick().
	dining_room = {
		code = 'dining_room',
		slots = {},
		work_job = null,
		max_count = 1,
		upkeep = 1,
		build_cost = {wood = 80, stone = 40},
		build_progress = 25,
		upgrades = [],
		master_only = false,
		tags = ['dining'],
		icon = 'wheat',
		color = '6b5a2e',
	},
	#A workplace that makes nothing: whoever stands here trains the stat the room is set to,
	#or works a negative trait out of themselves once there is somebody to tutor them.
	practice_room = {
		code = 'practice_room',
		slots = {work = 1},
		#not a craft discipline: it names the task rather than a recipe queue, and
		#game_res.process_rooms() sends it down the training branch instead
		work_job = 'practice',
		upkeep = 1,
		build_cost = {wood = 90, stone = 50, iron = 20},
		build_progress = 30,
		upgrades = ['training_space', 'tutoring_area'],
		master_only = false,
		tags = ['practice'],
		icon = 'rooms',
		color = '3f5a6b',
	},
	#Somewhere to keep the books. Having one is the whole of it - everybody on the estate
	#learns a little faster.
	masters_office = {
		code = 'masters_office',
		slots = {},
		work_job = null,
		max_count = 1,
		upkeep = 1,
		build_cost = {wood = 100, cloth = 40, gold = 300},
		build_progress = 35,
		upgrades = ['ledgers'],
		master_only = false,
		tags = ['office'],
		icon = 'rooms_lux',
		color = '4a3f6b',
	},
	#Circles, candles and a great deal of chalk. Nobody works here: having one is what lets
	#the estate put enchantments on gear at all - see MansionCraftModule.craftcategories.
	ritual_room = {
		code = 'ritual_room',
		slots = {},
		work_job = null,
		max_count = 1,
		upkeep = 2,
		build_cost = {wood = 80, stone = 60, mithril = 20, gold = 400},
		build_progress = 40,
		upgrades = [],
		master_only = false,
		tags = ['ritual'],
		icon = 'academy',
		color = '5a3f6b',
	},
	#Where everything the estate gathers is kept. Without one, or past what the shelves hold,
	#a delivery simply spills - see game_res.gain_material(). Equipment and the rest are not
	#stored here and are not counted.
	store_room = {
		code = 'store_room',
		slots = {},
		#not a craft discipline: it names the task rather than a recipe queue, and the clerk's
		#place comes from the Accountant upgrade rather than from the room itself
		work_job = 'storage',
		upkeep = 1,
		build_cost = {wood = 70, stone = 50},
		build_progress = 25,
		upgrades = ['shelves', 'accountant', 'purchase_ledger'],
		max_count = 3,
		master_only = false,
		tags = ['storage'],
		icon = 'rooms',
		color = '5a5040',
	},

	#### the estate grounds ####

	#Everything worked out of doors. Unlike a workshop these hold no room task of their own -
	#'work_job' stays null, so none is made. What each carries instead is a gathering job of
	#its own, raised for the plot it stands on: two mines are two jobs, with their own hands
	#and their own loot, because what a mine yields is what that mine has been dug out to
	#yield. game_res.add_gathering_job_temp() takes the plot code to tell them apart, and
	#game_res.gather_places() counts the places at that one building.
	#
	#They may be built more than once, limited only by the plots the grounds have.
	#Somewhere to keep and work the livestock. Unlike the gathering buildings this holds no
	#job of its own: the estate has one farming task and every farm adds places to it, because
	#what a farm produces is decided by the people standing in it rather than by the ground -
	#see game_res.farm_places().
	farm = {
		code = 'farm',
		slots = {work = 1},
		work_job = 'farming',
		upkeep = 1,
		build_cost = {wood = 70, stone = 40, grain = 20},
		build_progress = 25,
		upgrades = ['farm_hands'],
		master_only = false,
		tags = ['outdoor', 'farm'],
		icon = 'stables',
		color = '4b5f3a',
	},
	fishing_hut = {
		code = 'fishing_hut',
		slots = {work = 1},
		work_job = null,
		upkeep = 1,
		build_cost = {wood = 60},
		build_progress = 20,
		upgrades = ['gather_hands'],
		master_only = false,
		tags = ['outdoor'],
		icon = 'fishing',
		color = '2e5a6b',
	},
	garden = {
		code = 'garden',
		slots = {work = 1},
		work_job = null,
		upkeep = 1,
		build_cost = {wood = 50, stone = 20},
		build_progress = 20,
		upgrades = ['gather_hands', 'rich_soil'],
		master_only = false,
		tags = ['outdoor'],
		icon = 'veges',
		color = '3f6b2e',
	},
	wheat_field = {
		code = 'wheat_field',
		slots = {work = 1},
		work_job = null,
		upkeep = 1,
		build_cost = {wood = 60, stone = 20},
		build_progress = 20,
		upgrades = ['gather_hands'],
		master_only = false,
		tags = ['outdoor'],
		icon = 'wheat',
		color = '6b5f2e',
	},
	mine = {
		code = 'mine',
		slots = {work = 1},
		work_job = null,
		upkeep = 1,
		build_cost = {wood = 80, stone = 60},
		build_progress = 30,
		upgrades = ['extended_shafts', 'deeper_veins'],
		master_only = false,
		tags = ['outdoor'],
		icon = 'mining',
		color = '4a4a4a',
	},
	forestry = {
		code = 'forestry',
		slots = {work = 1},
		work_job = null,
		upkeep = 1,
		build_cost = {wood = 70, stone = 30},
		build_progress = 25,
		upgrades = ['larger_cabin', 'rare_woods'],
		master_only = false,
		tags = ['outdoor'],
		icon = 'woodcutting',
		color = '3f5a3f',
	},
	hunting_cabin = {
		code = 'hunting_cabin',
		slots = {work = 1},
		work_job = null,
		upkeep = 1,
		build_cost = {wood = 70, leather = 20},
		build_progress = 25,
		upgrades = ['larger_cabin', 'butchery'],
		master_only = false,
		tags = ['outdoor'],
		icon = 'hunting',
		color = '5a4030',
	},

	#No slots at all. Simply having one grants the bath bonus.
	bathhouse = {
		code = 'bathhouse',
		slots = {},
		work_job = null,
		max_count = 1,
		upkeep = 1,
		build_cost = {stone = 90, wood = 40},
		build_progress = 30,
		upgrades = [],
		master_only = false,
		tags = ['bath'],
		icon = 'rooms',
		color = '3f6b6b',
	},
}


static func get_type(code):
	if code != null and LIST.has(code):
		return LIST[code]
	return DEFAULT


static func has_type(code):
	return code != null and LIST.has(code)


static func get_name_key(code):
	return "MANSIONROOM_" + str(code).to_upper()


static func get_descript_key(code):
	return "MANSIONROOM_" + str(code).to_upper() + "DESCRIPT"


#What may be put in a slot. "outdoor" says whether the slot is on the estate grounds: a barn
#does not go in a bedroom corridor and a bedroom does not go in a field, so each list offers
#only its own half.
static func get_buildable_codes(outdoor = false):
	var res = []
	for code in LIST:
		#structure is not on the list of things to put in a slot, and neither is anything the
		#estate is simply given
		if is_fixed(code) or is_hidden(code):
			continue
		if has_tag(code, 'outdoor') != outdoor:
			continue
		res.append(code)
	return res


static func is_fixed(code):
	return get_type(code).get('fixed', false)


static func is_hidden(code):
	return get_type(code).get('hidden', false)


#0 means no limit beyond the plots there are to build on.
static func max_count(code):
	return int(get_type(code).get('max_count', 0))


#How many of these the mansion is not allowed to be without.
static func min_count(code):
	return int(get_type(code).get('min_count', 0))


static func is_mandatory(code):
	return min_count(code) > 0


#Slots before any upgrade. mansion_layout adds the upgraded ones on top, because that
#needs the room instance and this file only knows about types.
static func base_slots(code, kind):
	var data = get_type(code)
	if !data.slots.has(kind):
		return 0
	return int(data.slots[kind])


static func has_tag(code, tag):
	return get_type(code).tags.has(tag)


static func get_work_job(code):
	return get_type(code).work_job

