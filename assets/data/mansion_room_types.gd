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
	unique = false,
	master_only = false,
	tags = [],
	icon = '',
	color = '4b4b4b',
}

const LIST = {
	#The master's own room. The single bed is always the master's; Bed size opens extra
	#beds beside it, Furnishing widens what the room allows rather than who sleeps in it.
	master_bedroom = {
		code = 'master_bedroom',
		slots = {sleep = 1},
		work_job = null,
		upkeep = 0,
		build_cost = {wood = 120, cloth = 60, stone = 40},
		build_progress = 40,
		upgrades = ['furnishing', 'bed_size'],
		unique = true,
		master_only = true,
		tags = ['housing'],
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
		upgrades = ['bedrooms_expansion', 'builders'],
		unique = false,
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
		upgrades = ['luxury_expansion', 'builders'],
		unique = false,
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
		upgrades = ['craft_expansion', 'craft_tools', 'builders'],
		unique = false,
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
		upgrades = ['craft_expansion', 'craft_tools', 'builders'],
		unique = false,
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
		upgrades = ['craft_expansion', 'craft_tools', 'builders'],
		unique = false,
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
		upgrades = ['craft_expansion', 'craft_tools', 'builders'],
		unique = false,
		master_only = false,
		tags = ['craft'],
		icon = 'wheat',
		color = '6b4a3f',
	},
	#No slots at all. Simply having one grants the bath bonus.
	bathhouse = {
		code = 'bathhouse',
		slots = {},
		work_job = null,
		upkeep = 1,
		build_cost = {stone = 90, wood = 40},
		build_progress = 30,
		upgrades = ['builders'],
		unique = true,
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


static func get_buildable_codes():
	return LIST.keys()


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
