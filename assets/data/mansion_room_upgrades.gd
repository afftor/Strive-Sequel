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

const LIST = {
	#### master bedroom ####

	#Widens what the room allows rather than who lives in it: more participants per scene.
	furnishing = {
		code = 'furnishing',
		levels = {
			1: {cost = {wood = 60, cloth = 40}, progress = 20, effect = {sex_slots = 1}},
			2: {cost = {wood = 100, cloth = 80, gold = 500}, progress = 35, effect = {sex_slots = 2}},
			3: {cost = {wood = 160, clothsilk = 40, gold = 1200}, progress = 55, effect = {sex_slots = 3}},
		},
	},
	#Extra beds beside the master's own, which is never freed.
	bed_size = {
		code = 'bed_size',
		levels = {
			1: {cost = {wood = 80, cloth = 30}, progress = 25, effect = {sleep_slots = 1}},
			2: {cost = {wood = 140, cloth = 60}, progress = 40, effect = {sleep_slots = 2}},
			3: {cost = {wood = 200, clothsilk = 30}, progress = 60, effect = {sleep_slots = 3}},
		},
	},

	#### bedrooms ####

	bedrooms_expansion = {
		code = 'bedrooms_expansion',
		levels = {
			1: {cost = {wood = 120, stone = 60}, progress = 35, effect = {sleep_slots = 4}},
		},
	},
	luxury_expansion = {
		code = 'luxury_expansion',
		levels = {
			1: {cost = {wood = 80, cloth = 50}, progress = 25, effect = {sleep_slots = 1}},
			2: {cost = {wood = 140, cloth = 90}, progress = 40, effect = {sleep_slots = 2}},
			3: {cost = {wood = 220, clothsilk = 40}, progress = 60, effect = {sleep_slots = 3}},
		},
	},

	#### craft rooms - shared by forge, alchemy room, tailor workshop and kitchen ####

	craft_expansion = {
		code = 'craft_expansion',
		levels = {
			1: {cost = {wood = 80, stone = 50}, progress = 30, effect = {work_slots = 1}},
			2: {cost = {wood = 140, stone = 100, iron = 30}, progress = 50, effect = {work_slots = 2}},
		},
	},
	#Only this room's workers get it - that is the whole point of it being per-instance.
	craft_tools = {
		code = 'craft_tools',
		levels = {
			1: {cost = {iron = 50, wood = 40}, progress = 30, effect = {craft_mod = 0.25}},
			2: {cost = {iron = 100, mithril = 10}, progress = 55, effect = {craft_mod = 0.50}},
		},
	},

	#### any room ####

	#A second builder's place, which only ever speeds up this room's LATER upgrades:
	#building the room itself happens before the room exists to hold the upgrade.
	builders = {
		code = 'builders',
		levels = {
			1: {cost = {wood = 60, iron = 20}, progress = 20, effect = {build_slots = 1}},
		},
	},
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
