extends Reference
#Per-room upgrades for the mansion floorplan view (gui_modules/mansion_view).
#Plain script, not an autoload - use preload("res://assets/data/mansion_room_upgrades.gd").LIST
#
#Deliberately separate from upgradedata.upgradelist. Those are global per code - raising
#'forge' raises it for the whole game - while these belong to one room instance, which is
#what lets two forges differ and what makes "Better tools works only in this room" mean
#anything. Which upgrades a room may take is listed on its type in mansion_room_types.gd.
#
#A room may only have one upgrade under construction at a time; that rule lives in
#mansion_layout, not here.
#
#An "effect" is a flat dictionary merged by mansion_layout when it computes a room's real
#numbers. Known keys:
#	sleep_slots - extra beds
#	work_slots  - extra workplaces
#	build_slots - extra builder places, used by this room's own future upgrades
#	craft_mod   - multiplier added to this room's craft output (0.25 = +25%)
#	sex_slots   - extra participants allowed in a scene in this room
#Effects are cumulative up to the room's current level: level 2 replaces level 1's numbers
#rather than adding to them, so each level states the total.
#
#"progress" is work units, the same currency as upgradedata's taskprogress (15-120 there),
#spent by whoever stands in the room's builder slot. Costs and times are first-pass values
#lifted from comparable entries in upgradedata and are expected to be retuned.
#
#Display text is derived from the code:
#	MANSIONUPG_<CODE>            - name
#	MANSIONUPG_<CODE>DESCRIPT    - description
#	MANSIONUPG_<CODE>BONUS<N>    - what level N gives
#"icon" names an entry in images.upgrade_icons and is presentation metadata only.

const LIST = {
	#### master bedroom ####

	#Widens what the room allows rather than who lives in it: more participants per scene.
	furnishing = {
		code = 'furnishing',
		icon = 'rooms_lux',
		levels = {
			1: {cost = {wood = 60, cloth = 40}, progress = 20, effect = {sex_slots = 1}},
			2: {cost = {wood = 100, cloth = 80, gold = 500}, progress = 35, effect = {sex_slots = 2}},
			3: {cost = {wood = 160, clothsilk = 40, gold = 1200}, progress = 55, effect = {sex_slots = 3}},
		},
	},
	#Extra beds beside the master's own, which is never freed.
	bed_size = {
		code = 'bed_size',
		icon = 'bedroom',
		levels = {
			1: {cost = {wood = 80, cloth = 30}, progress = 25, effect = {sleep_slots = 1}},
			2: {cost = {wood = 140, cloth = 60}, progress = 40, effect = {sleep_slots = 2}},
			3: {cost = {wood = 200, clothsilk = 30}, progress = 60, effect = {sleep_slots = 3}},
		},
	},

	#### bedrooms ####

	bedrooms_expansion = {
		code = 'bedrooms_expansion',
		icon = 'rooms',
		levels = {
			1: {cost = {wood = 120, stone = 60}, progress = 35, effect = {sleep_slots = 4}},
		},
	},
	luxury_expansion = {
		code = 'luxury_expansion',
		icon = 'rooms_lux',
		levels = {
			1: {cost = {wood = 80, cloth = 50}, progress = 25, effect = {sleep_slots = 1}},
			2: {cost = {wood = 140, cloth = 90}, progress = 40, effect = {sleep_slots = 2}},
			3: {cost = {wood = 220, clothsilk = 40}, progress = 60, effect = {sleep_slots = 3}},
		},
	},

	#### craft rooms - shared by forge, alchemy room, tailor workshop and kitchen ####

	craft_expansion = {
		code = 'craft_expansion',
		icon = 'rooms',
		levels = {
			1: {cost = {wood = 80, stone = 50}, progress = 30, effect = {work_slots = 1}},
			2: {cost = {wood = 140, stone = 100, iron = 30}, progress = 50, effect = {work_slots = 2}},
		},
	},
	#Only this room's workers get it - that is the whole point of it being per-instance.
	craft_tools = {
		code = 'craft_tools',
		icon = 'forge',
		levels = {
			1: {cost = {iron = 50, wood = 40}, progress = 30, effect = {craft_mod = 0.25}},
			2: {cost = {iron = 100, mithril = 10}, progress = 55, effect = {craft_mod = 0.50}},
		},
	},

	#### practice room ####

	#Somewhere for a tutor to stand - which is a second place in the room, since the tutor
	#occupies one. Having it is also the only way to work a negative trait out of somebody:
	#see game_res.practice_trainer().
	tutoring_area = {
		code = 'tutoring_area',
		icon = 'rooms',
		#The slot this adds is not another pair of hands at the same work - it is the one place
		#in the room for somebody teaching rather than practising. The screen draws it in its
		#own colour so it does not read as a fifth workbench.
		special_slot = true,
		levels = {
			1: {cost = {wood = 120, cloth = 60, gold = 500}, progress = 45, effect = {work_slots = 1}},
		},
	},

	#### master's office ####

	#Books kept properly. The room's crafters stop taking whatever is at the head of the
	#estate's queue and work the list this room was given instead.
	ledgers = {
		code = 'ledgers',
		icon = 'rooms_lux',
		levels = {
			1: {cost = {wood = 80, cloth = 50, gold = 800}, progress = 40, effect = {craft_rules = 1}},
		},
	},

	#### store room ####

	#Each level states the whole figure the room holds, not an addition to it - see
	#MansionLayout.storage_capacity(), which takes the larger of this and the room's base.
	shelves = {
		code = 'shelves',
		icon = 'rooms',
		levels = {
			1: {cost = {wood = 80, stone = 30}, progress = 20, effect = {storage = 500}},
			2: {cost = {wood = 150, stone = 80}, progress = 35, effect = {storage = 1000}},
			3: {cost = {wood = 260, stone = 160, iron = 40}, progress = 55, effect = {storage = 5000}},
			4: {cost = {woodiron = 120, steel = 60, gold = 1500}, progress = 80, effect = {storage = 20000}},
		},
	},
	#Somewhere for a clerk to sit. With one at the desk a delivery that will not fit is sold
	#off rather than tipped away - see game_res.gain_material().
	accountant = {
		code = 'accountant',
		icon = 'rooms_lux',
		levels = {
			1: {cost = {wood = 90, cloth = 40, gold = 400}, progress = 30, effect = {work_slots = 1}},
		},
	},

	#### the estate grounds ####

	#More hands at the same work. Four levels, each a place: one worker becomes five.
	#A farm works three hands at most: the buildings are small and the animals are the limit,
	#not the acreage.
	farm_hands = {
		code = 'farm_hands',
		icon = 'stables',
		levels = {
			1: {cost = {wood = 80, grain = 30}, progress = 25, effect = {work_slots = 1}},
			2: {cost = {wood = 140, stone = 60, grain = 50}, progress = 40, effect = {work_slots = 2}},
		},
	},
	gather_hands = {
		code = 'gather_hands',
		icon = 'rooms',
		levels = {
			1: {cost = {wood = 60, stone = 20}, progress = 20, effect = {work_slots = 1}},
			2: {cost = {wood = 110, stone = 50}, progress = 35, effect = {work_slots = 2}},
			3: {cost = {wood = 180, stone = 90, iron = 20}, progress = 50, effect = {work_slots = 3}},
			4: {cost = {wood = 260, stone = 140, steel = 20}, progress = 70, effect = {work_slots = 4}},
		},
	},
	extended_shafts = {
		code = 'extended_shafts',
		icon = 'mining',
		levels = {
			1: {cost = {wood = 60, stone = 20}, progress = 20, effect = {work_slots = 1}},
			2: {cost = {wood = 110, stone = 50}, progress = 35, effect = {work_slots = 2}},
			3: {cost = {wood = 180, stone = 90, iron = 20}, progress = 50, effect = {work_slots = 3}},
			4: {cost = {wood = 260, stone = 140, steel = 20}, progress = 70, effect = {work_slots = 4}},
		},
	},
	larger_cabin = {
		code = 'larger_cabin',
		icon = 'woodcutting',
		levels = {
			1: {cost = {wood = 60, stone = 20}, progress = 20, effect = {work_slots = 1}},
			2: {cost = {wood = 110, stone = 50}, progress = 35, effect = {work_slots = 2}},
			3: {cost = {wood = 180, stone = 90, iron = 20}, progress = 50, effect = {work_slots = 3}},
			4: {cost = {wood = 260, stone = 140, steel = 20}, progress = 70, effect = {work_slots = 4}},
		},
	},

	#What the ground gives up. These widen the loot table the job draws from rather than
	#touching its output - see the prod_task_* tables in loot_data.gd, whose branches ask
	#'has_room_upgrade' for exactly these codes.
	rich_soil = {
		code = 'rich_soil',
		icon = 'cotton',
		levels = {
			1: {cost = {wood = 80, grain = 60}, progress = 30, effect = {}},
		},
	},
	deeper_veins = {
		code = 'deeper_veins',
		icon = 'mining',
		levels = {
			1: {cost = {wood = 100, iron = 40}, progress = 40, effect = {}},
			2: {cost = {steel = 60, woodiron = 40}, progress = 65, effect = {}},
		},
	},
	rare_woods = {
		code = 'rare_woods',
		icon = 'woodcutting',
		levels = {
			1: {cost = {wood = 120, iron = 30}, progress = 35, effect = {}},
			2: {cost = {woodiron = 60, steel = 30}, progress = 60, effect = {}},
		},
	},
	butchery = {
		code = 'butchery',
		icon = 'hunting',
		levels = {
			1: {cost = {wood = 90, iron = 30}, progress = 30, effect = {}},
			2: {cost = {woodiron = 50, leatherthick = 40}, progress = 55, effect = {}},
		},
	},

	#### any room ####

	#'builders' used to live here: a second place on THIS room's scaffolding, bought room by
	#room. How many hands a scaffold holds is a thing about the household's builders, not
	#about the room they happen to be raising - so it is the global 'builders' upgrade in
	#upgradedata.gd now, and MansionLayout.build_capacity() takes its level as an argument.
}


static func get_upgrade(code):
	if code != null and LIST.has(code):
		return LIST[code]
	return null


static func has_upgrade(code):
	return code != null and LIST.has(code)


static func get_name_key(code):
	return "MANSIONUPG_" + str(code).to_upper()


static func get_descript_key(code):
	return "MANSIONUPG_" + str(code).to_upper() + "DESCRIPT"


static func get_bonus_key(code, level):
	return "MANSIONUPG_" + str(code).to_upper() + "BONUS" + str(int(level))


#Does this upgrade's slot stand for something other than more of the same work?
static func is_special_slot(code):
	var data = get_upgrade(code)
	return data != null and data.get('special_slot', false)


static func max_level(code):
	var data = get_upgrade(code)
	if data == null:
		return 0
	return data.levels.size()


static func get_level_data(code, level):
	var data = get_upgrade(code)
	level = int(level)
	if data == null or !data.levels.has(level):
		return null
	return data.levels[level]


#Each level states its total, so the effect of a room is simply its current level's.
static func get_effect(code, level):
	var level_data = get_level_data(code, level)
	if level_data == null:
		return {}
	return level_data.effect
