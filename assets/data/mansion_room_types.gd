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
#A room's improvements are stated in its own 'upgrades' block - every kind of room states its
#own, so the same code may be priced or tuned differently in two of them (the four craft rooms
#each keep their own craft_tools, and a mine's gather_hands need not match a garden's). They
#apply to THIS room instance, unlike
#upgradedata.upgradelist, which is global per code - that is what lets two forges differ and
#what makes "Better tools works only in this room" mean anything. The questions asked about an
#upgrade are the static functions under "#### upgrades ####" at the foot of this file.
#
#Display text for an upgrade is derived from its code:
#	MANSIONUPG_<CODE>            - name
#	MANSIONUPG_<CODE>DESCRIPT    - description
#	MANSIONUPG_<CODE>BONUS<N>    - what level N gives
#
#An upgrade "effect" is a flat dictionary merged by mansion_layout when it works out a room's
#real numbers. Known keys: sleep_slots, work_slots, build_slots, craft_mod, sex_slots, storage.
#Effects are cumulative up to the room's current level: level 2 states the total rather than
#adding to level 1. "progress" is work units, spent by whoever stands in the builder slot.

const SLOT_KINDS = ['sleep', 'work', 'build']

#fallback used whenever a code is missing from LIST
const DEFAULT = {
	code = 'empty',
	slots = {},
	work_job = null,
	upkeep = 0,
	build_cost = {},
	build_progress = 0,
	upgrades = {},
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
	#Whether the card puts a help mark beside this room's name. Off unless a type asks for it:
	#most rooms are one line to explain and a mark beside every name is a mark nobody reads.
	#Set 'help = true' on a type whose rules are worth stopping for.
	help = false,
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
		upgrades = {
			#The house was inherited with its stairs rotted through, so the upper floor cannot be
			#reached until they are made good. One repair does the whole staircase: there is nothing
			#to unlock afterwards, and no second level to buy.
			stairs_repair = {
				code = 'stairs_repair',
				icon = 'rooms',
				levels = {
					1: {cost = {woodiron = 10, steel = 5}, progress = 15, effect = {}},
				},
			},
		},
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
		help = true,
		slots = {sleep = 1},
		work_job = null,
		max_count = 1,
		min_count = 1,
		upkeep = 0,
		build_cost = {},
		build_progress = 0,
		upgrades = {
			#Widens what the room allows rather than who lives in it: more participants per scene.
			furnishing = {
				code = 'furnishing',
				icon = 'rooms_lux',
				levels = {
					1: {cost = {wood = 100, cloth = 50}, progress = 20, effect = {sex_slots = 1}},
					2: {cost = {wood = 100, clothsilk = 30, gold = 1000}, progress = 35, effect = {sex_slots = 2}},
					3: {cost = {woodmagic = 50, clothethereal = 15, gold = 2000}, progress = 55, effect = {sex_slots = 3}},
				},
			},
			#Extra beds beside the master's own, which is never freed.
			bed_size = {
				code = 'bed_size',
				icon = 'bedroom',
				levels = {
					1: {cost = {leather = 50, cloth = 30}, progress = 15, effect = {sleep_slots = 1}},
					2: {cost = {leatherthick = 50, clothsilk = 50}, progress = 35, effect = {sleep_slots = 2}},
					3: {cost = {leathermythic = 20, clothethereal = 25}, progress = 30, effect = {sleep_slots = 3}},
				},
			},
		},
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
		upgrades = {
			bedrooms_expansion = {
				code = 'bedrooms_expansion',
				icon = 'rooms',
				levels = {
					1: {cost = {wood = 200, stone = 100, woodiron = 25}, progress = 50, effect = {sleep_slots = 4}},
				},
			},
		},
		master_only = false,
		tags = ['housing'],
		icon = 'bedroom',
		color = '3f6b4a',
	},
	#Residents here get the private-room bonus that used to be the 'luxury' work rule.
	luxury_bedrooms = {
		code = 'luxury_bedrooms',
		help = true,
		slots = {sleep = 1},
		work_job = null,
		upkeep = 0,
		build_cost = {wood = 90, cloth = 60},
		build_progress = 25,
		upgrades = {
			luxury_expansion = {
				code = 'luxury_expansion',
				icon = 'rooms_lux',
				levels = {
					1: {cost = {woodiron = 50, cloth = 50}, progress = 25, effect = {sleep_slots = 1}},
					2: {cost = {wood = 100, clothmagic = 75}, progress = 40, effect = {sleep_slots = 2}},
					3: {cost = {woodiron = 100, clothethereal = 15}, progress = 60, effect = {sleep_slots = 3}},
				},
			},
		},
		master_only = false,
		tags = ['housing', 'luxury'],
		icon = 'rooms_lux',
		color = '6b3f5c',
	},
	forge = {
		code = 'forge',
		slots = {work = 1},
		work_job = 'smith',
		upkeep = 0,
		build_cost = {stone = 80, iron = 30},
		build_progress = 30,
		upgrades = {
			#Taking worn gear apart for what it was made of. The bench is built here like any
			#other improvement, but how it is done is learned from the workers' guild first:
			#until that lesson is bought the row is shown greyed rather than hidden, so the
			#player can see the bench exists and where to go for it.
			salvage_bench = {
				code = 'salvage_bench',
				icon = 'forge',
				guild_upgrade = {guild = 'workers', code = 'workers_disassamby_upgrade'},
				levels = {
					1: {cost = {iron = 60, wood = 40, steel = 20}, progress = 40, effect = {}},
				},
			},
			craft_expansion = {
				code = 'craft_expansion',
				icon = 'rooms',
				levels = {
					1: {cost = {stone = 50, steel = 30, leather = 20}, progress = 30, effect = {work_slots = 1}},
					2: {cost = {mithril = 30, boneancient = 25}, progress = 50, effect = {work_slots = 2}},
				},
			},
			#Only this room's workers get it - that is the whole point of it being per-instance.
			craft_tools = {
				code = 'craft_tools',
				icon = 'forge',
				levels = {
					1: {cost = {iron = 100, bone = 100}, progress = 30, effect = {craft_mod = 0.25}},
					2: {cost = {mithril = 20, boneancient = 30}, progress = 55, effect = {craft_mod = 0.50}},
				},
			},
		},
		master_only = false,
		tags = ['craft'],
		icon = 'forge',
		color = '6b3f3f',
	},
	alchemy_room = {
		code = 'alchemy_room',
		slots = {work = 1},
		work_job = 'alchemy',
		upkeep = 0,
		build_cost = {wood = 60, stone = 40, iron = 10},
		build_progress = 30,
		upgrades = {
			craft_expansion = {
				code = 'craft_expansion',
				icon = 'rooms',
				levels = {
					1: {cost = {stone = 50, steel = 30, leather = 20}, progress = 30, effect = {work_slots = 1}},
					2: {cost = {mithril = 30, boneancient = 25}, progress = 50, effect = {work_slots = 2}},
				},
			},
			#Only this room's workers get it - that is the whole point of it being per-instance.
			craft_tools = {
				code = 'craft_tools',
				icon = 'forge',
				levels = {
					1: {cost = {iron = 100, bone = 100}, progress = 30, effect = {craft_mod = 0.25}},
					2: {cost = {mithril = 20, boneancient = 30}, progress = 55, effect = {craft_mod = 0.50}},
				},
			},
		},
		master_only = false,
		tags = ['craft'],
		icon = 'alchemy',
		color = '5a3f6b',
	},
	tailor_workshop = {
		code = 'tailor_workshop',
		slots = {work = 1},
		work_job = 'tailor',
		upkeep = 0,
		build_cost = {wood = 50, cloth = 40},
		build_progress = 25,
		upgrades = {
			craft_expansion = {
				code = 'craft_expansion',
				icon = 'rooms',
				levels = {
					1: {cost = {stone = 50, steel = 30, leather = 20}, progress = 30, effect = {work_slots = 1}},
					2: {cost = {mithril = 30, boneancient = 25}, progress = 50, effect = {work_slots = 2}},
				},
			},
			#Only this room's workers get it - that is the whole point of it being per-instance.
			craft_tools = {
				code = 'craft_tools',
				icon = 'forge',
				levels = {
					1: {cost = {iron = 100, bone = 100}, progress = 30, effect = {craft_mod = 0.25}},
					2: {cost = {mithril = 20, boneancient = 30}, progress = 55, effect = {craft_mod = 0.50}},
				},
			},
		},
		master_only = false,
		tags = ['craft'],
		icon = 'tailor',
		color = '46456b',
	},
	kitchen = {
		code = 'kitchen',
		slots = {work = 1},
		work_job = 'cooking',
		upkeep = 0,
		build_cost = {wood = 70, stone = 30},
		build_progress = 25,
		upgrades = {
			craft_expansion = {
				code = 'craft_expansion',
				icon = 'rooms',
				levels = {
					1: {cost = {stone = 50, steel = 30, leather = 20}, progress = 30, effect = {work_slots = 1}},
					2: {cost = {mithril = 30, boneancient = 25}, progress = 50, effect = {work_slots = 2}},
				},
			},
			#Only this room's workers get it - that is the whole point of it being per-instance.
			craft_tools = {
				code = 'craft_tools',
				icon = 'forge',
				levels = {
					1: {cost = {iron = 100, bone = 100}, progress = 30, effect = {craft_mod = 0.25}},
					2: {cost = {mithril = 20, boneancient = 30}, progress = 55, effect = {craft_mod = 0.50}},
				},
			},
		},
		master_only = false,
		tags = ['craft'],
		icon = 'wheat',
		color = '6b4a3f',
	},
	#Nobody works here and nobody sleeps here. The household eats together, and slaves take
	#a little more from a day that has a proper meal in it - see ch_training.day_tick().
	dining_room = {
		code = 'dining_room',
		help = true,
		slots = {},
		work_job = null,
		max_count = 1,
		upkeep = 0,
		build_cost = {wood = 80, stone = 40},
		build_progress = 25,
		upgrades = {},
		master_only = false,
		tags = ['dining'],
		icon = 'wheat',
		color = '6b5a2e',
	},
	#A workplace that makes nothing: whoever stands here trains the stat the room is set to,
	#or works a negative trait out of themselves once there is somebody to tutor them.
	practice_room = {
		code = 'practice_room',
		help = true,
		slots = {work = 1},
		#not a craft discipline: it names the task rather than a recipe queue, and
		#game_res.process_rooms() sends it down the training branch instead
		work_job = 'practice',
		upkeep = 0,
		build_cost = {wood = 90, stone = 50, iron = 20},
		build_progress = 30,
		upgrades = {
			#Room for more than one pupil at a time. The tutor's place is bought separately - see
			#tutoring_area, which is flagged special_slot and is not one of these.
			training_space = {
				code = 'training_space',
				icon = 'rooms',
				levels = {
					1: {cost = {wood = 70, stone = 40}, progress = 25, effect = {work_slots = 1}},
					2: {cost = {wood = 120, stone = 80, iron = 30}, progress = 40, effect = {work_slots = 2}},
				},
			},
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
					1: {cost = {woodancient = 5, woodiron = 50, gold = 5000}, progress = 45, effect = {work_slots = 1}},
				},
			},
		},
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
		upkeep = 0,
		build_cost = {wood = 100, cloth = 40, gold = 300},
		build_progress = 35,
		upgrades = {
			#Books kept properly. The room's crafters stop taking whatever is at the head of the
			#estate's queue and work the list this room was given instead.
			ledgers = {
				code = 'ledgers',
				icon = 'rooms_lux',
				levels = {
					1: {cost = {clothmagic = 50, gold = 500}, progress = 40, effect = {craft_rules = 1}},
				},
			},
		},
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
		#Nobody works in here, so it has no job of its own - but it is what lets the estate
		#enchant at all (MansionCraftModule's 'enchant' category asks for this room), and the
		#card's bench button opens that, the way a forge's opens smithing.
		craft_menu = 'enchant',
		max_count = 1,
		upkeep = 0,
		build_cost = {wood = 80, stone = 60, mithril = 20, gold = 400},
		build_progress = 40,
		upgrades = {},
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
		help = true,
		slots = {},
		#not a craft discipline: it names the task rather than a recipe queue, and the clerk's
		#place comes from the Accountant upgrade rather than from the room itself
		work_job = 'storage',
		upkeep = 0,
		build_cost = {wood = 100, stone = 80},
		build_progress = 25,
		upgrades = {
			#Each level states the whole figure the room holds, not an addition to it - see
			#MansionLayout.storage_capacity(), which takes the larger of this and the room's base.
			shelves = {
				code = 'shelves',
				icon = 'rooms',
				levels = {
					1: {cost = {wood = 100, stone = 200}, progress = 20, effect = {storage = 500}},
					2: {cost = {woodiron = 20, obsidian = 10}, progress = 35, effect = {storage = 1000}},
					3: {cost = {woodiron = 100, leathermythic = 30}, progress = 55, effect = {storage = 5000}},
					4: {cost = {woodancient = 20, adamantine = 10, gold = 10000}, progress = 80, effect = {storage = 20000}},
				},
			},
			#Somewhere for a clerk to sit. With one at the desk a delivery that will not fit is sold
			#off rather than tipped away - see game_res.gain_material().
			accountant = {
				code = 'accountant',
				icon = 'rooms_lux',
				levels = {
					1: {cost = {mithril = 10, gold = 1000}, progress = 10, effect = {work_slots = 1}},
				},
			},
			#Standing orders with the market: the clerk keeps a list of what the estate must not run
			#short of and buys it in every morning. See game_res.process_autobuy().
			purchase_ledger = {
				code = 'purchase_ledger',
				icon = 'rooms',
				levels = {
					1: {cost = {woodiron = 25, gold = 1500}, progress = 20, effect = {}},
				},
			},
		},
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
		help = true,
		slots = {work = 1},
		work_job = 'farming',
		upkeep = 0,
		build_cost = {wood = 70, stone = 40, grain = 20},
		build_progress = 25,
		upgrades = {
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
		},
		master_only = false,
		tags = ['outdoor', 'farm'],
		icon = 'stables',
		color = '4b5f3a',
	},
	fishing_hut = {
		code = 'fishing_hut',
		slots = {work = 1},
		work_job = null,
		upkeep = 0,
		build_cost = {wood = 60},
		build_progress = 20,
		upgrades = {
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
		},
		master_only = false,
		tags = ['outdoor'],
		icon = 'fishing',
		color = '2e5a6b',
	},
	garden = {
		code = 'garden',
		slots = {work = 1},
		work_job = null,
		upkeep = 0,
		build_cost = {wood = 50, stone = 20},
		build_progress = 20,
		upgrades = {
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
		},
		master_only = false,
		tags = ['outdoor'],
		icon = 'veges',
		color = '3f6b2e',
	},
	wheat_field = {
		code = 'wheat_field',
		slots = {work = 1},
		work_job = null,
		upkeep = 0,
		build_cost = {wood = 60, stone = 20},
		build_progress = 20,
		upgrades = {
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
		},
		master_only = false,
		tags = ['outdoor'],
		icon = 'wheat',
		color = '6b5f2e',
	},
	mine = {
		code = 'mine',
		slots = {work = 1},
		work_job = null,
		upkeep = 0,
		build_cost = {wood = 80, stone = 60},
		build_progress = 30,
		upgrades = {
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
			deeper_veins = {
				code = 'deeper_veins',
				icon = 'mining',
				levels = {
					1: {cost = {wood = 100, iron = 40}, progress = 40, effect = {}},
					2: {cost = {steel = 60, woodiron = 40}, progress = 65, effect = {}},
				},
			},
		},
		master_only = false,
		tags = ['outdoor'],
		icon = 'mining',
		color = '4a4a4a',
	},
	forestry = {
		code = 'forestry',
		slots = {work = 1},
		work_job = null,
		upkeep = 0,
		build_cost = {wood = 70, stone = 30},
		build_progress = 25,
		upgrades = {
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
			rare_woods = {
				code = 'rare_woods',
				icon = 'woodcutting',
				levels = {
					1: {cost = {wood = 120, iron = 30}, progress = 35, effect = {}},
					2: {cost = {woodiron = 60, steel = 30}, progress = 60, effect = {}},
				},
			},
		},
		master_only = false,
		tags = ['outdoor'],
		icon = 'woodcutting',
		color = '3f5a3f',
	},
	hunting_cabin = {
		code = 'hunting_cabin',
		slots = {work = 1},
		work_job = null,
		upkeep = 0,
		build_cost = {wood = 70, leather = 20},
		build_progress = 25,
		upgrades = {
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
			butchery = {
				code = 'butchery',
				icon = 'hunting',
				levels = {
					1: {cost = {wood = 90, iron = 30}, progress = 30, effect = {}},
					2: {cost = {woodiron = 50, leatherthick = 40}, progress = 55, effect = {}},
				},
			},
		},
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
		upkeep = 0,
		build_cost = {stone = 150, woodmagic = 50},
		build_progress = 30,
		upgrades = {},
		master_only = false,
		tags = ['bath'],
		icon = 'rooms',
		color = '3f6b6b',
	},

	#No slots either: the parlor is visited, not worked. Having one puts the Tattoo application
	#button on its card; Body modifications is the improvement that adds the second button.
	beauty_parlor = {
		code = 'beauty_parlor',
		slots = {},
		work_job = null,
		max_count = 1,
		upkeep = 0,
		build_cost = {wood = 80, cloth = 40, gold = 500},
		build_progress = 30,
		upgrades = {
			body_modifications = {
				code = 'body_modifications',
				icon = 'tattoo',
				levels = {
					1: {cost = {clothsilk = 30, woodmagic = 20, gold = 2000}, progress = 40, effect = {}},
				},
			},
		},
		master_only = false,
		tags = ['beauty'],
		icon = 'tattoo',
		color = '6b3f5c',
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


#Whether this room's name is worth a mark that explains it - see 'help' in DEFAULT.
static func shows_help(code):
	return get_type(code).get('help', false) == true


static func has_tag(code, tag):
	return get_type(code).tags.has(tag)


#Which bench on the craft screen this room's button opens. Most rooms answer with the work done
#in them; a room that enables a trade without anybody working at it names it here instead.
static func get_craft_menu(code):
	var data = get_type(code)
	if data == null:
		return null
	if data.has('craft_menu'):
		return data.craft_menu
	return get_work_job(code)


static func get_work_job(code):
	return get_type(code).work_job


#### upgrades ####

#What each upgrade costs and gives is stated above, on the room that offers it - these are the
#questions asked about one. Every room states its own, so the same code may be tuned differently
#in two kinds of room: pass the room's code and the answer comes from that room. Asked by code
#alone the first room holding it answers, which is all the callers that have no room in hand
#(a build queue, a log line) can be given.

static func get_upgrade(code, room_code = null):
	if code == null:
		return null
	if room_code != null:
		var here = get_type(room_code).get('upgrades', {})
		if here is Dictionary and here.get(code, null) is Dictionary:
			return here[code]
	for room in LIST:
		var ups = LIST[room].get('upgrades', {})
		if !(ups is Dictionary):
			continue
		var entry = ups.get(code, null)
		if entry is Dictionary:
			return entry
	return null


static func has_upgrade(code):
	return get_upgrade(code) != null


static func get_upgrade_name_key(code):
	return "MANSIONUPG_" + str(code).to_upper()


static func get_upgrade_descript_key(code):
	return "MANSIONUPG_" + str(code).to_upper() + "DESCRIPT"


static func get_upgrade_bonus_key(code, level):
	return "MANSIONUPG_" + str(code).to_upper() + "BONUS" + str(int(level))


#Does this upgrade's slot stand for something other than more of the same work?
static func is_special_slot(code, room_code = null):
	var data = get_upgrade(code, room_code)
	return data != null and data.get('special_slot', false)


static func max_level(code, room_code = null):
	var data = get_upgrade(code, room_code)
	if data == null:
		return 0
	return data.levels.size()


static func get_level_data(code, level, room_code = null):
	var data = get_upgrade(code, room_code)
	level = int(level)
	if data == null or !data.levels.has(level):
		return null
	return data.levels[level]


#Each level states its total, so the effect of a room is simply its current level's.
static func get_effect(code, level, room_code = null):
	var level_data = get_level_data(code, level, room_code)
	if level_data == null:
		return {}
	return level_data.effect
