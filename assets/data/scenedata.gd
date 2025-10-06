extends Node

var season_events_range = {
	halloween = {start = [15,10], end = [15,11], event = 'halloween_start', event_reqs = []},
	christmas = {start = [15,12], end = [15,13], event = 'christmas_pre_start', event_reqs = []}
}


#wolves_skirmish_start
var scenedict = {
	childbirth = {text = tr("DIALOGUECHILDBIRTHTEXT"), image = 'childbirth', tags = ['active_character_translate'], options = [{code = 'keepbaby', reqs = [], text = tr("DIALOGUEKEEPBABY")}, {code = 'removebaby', reqs = [], text = tr("DIALOGUEREMOVEBABY")}]},
	childbirth_alt = {text = tr("DIALOGUECHILDBIRTHTEXT"), image = 'childbirth', tags = ['active_character_translate'], options = [{code = 'removebaby', reqs = [], text = tr("DIALOGUEREMOVEBABY")}]}, #change text
	select_tutelage = {
		text = tr("DIALOGUETUTELAGETEXT"), image = null, tags = ['active_character_translate'], options = [
			{code = 'close', text = tr('DIALOGUETUTNOTHING'), reqs = [], not_hide = true, bonus_effects = [{code = "real_affect_scene_characters", type = 'set_tutelage', value = 'nothing'}, {code = 'rewrite_save'}]},
			{code = 'close', text = tr('DIALOGUETUTSLAVE'), reqs = [{type = 'has_money', value = 500}], not_hide = true, bonus_effects = [{code = "real_affect_scene_characters", type = 'set_tutelage', value = 'slave_training'}, {code = 'money_change', operant = '-', value = 500}, {code = 'rewrite_save'}]},
			{code = 'close', text = tr('DIALOGUETUTACADEMY'), reqs = [{type = 'has_money', value = 1500}, {type = "has_upgrade", name = 'academy', value = 1}], not_hide = true, bonus_effects = [{code = "real_affect_scene_characters", type = 'set_tutelage', value = 'academy'}, {code = 'money_change', operant = '-', value = 1500}, {code = 'rewrite_save'}]},
			{code = 'close', text = tr('DIALOGUETUTHEIR'), reqs = [{type = 'has_money', value = 5000}, {type = 'scene_character_checks', value = [{code = 'trait', trait = 'heir', check = true}]}], not_hide = true, bonus_effects = [{code = "real_affect_scene_characters", type = 'set_tutelage', value = 'heir'}, {code = 'money_change', operant = '-', value = 5000}, {code = 'rewrite_save'}]},
		]
	},
	slave_escape = {text = tr("DIALOGUEESCAPETEXT"), image = 'slaveescape', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUEESCAPECLOSE"), bonus_effects = [{code = "affect_active_character", type = 'escape'}]}]}, #possibly obsolete

	aliron_exotic_trader = {text = tr("DIALOGUEALIRONEXOTICTRADER"), image = 'avermik', bonus_effects = [{code = 'add_timed_event', value = "aliron_exotic_trader", args = [{type = 'add_to_date', date = [14,14], hour = 1}]}], tags = [], options = [{code = 'close', reqs = [], bonus_effects = [{code = 'rewrite_save'}], text = tr("DIALOGUECLOSE")}]},

	location_event_search = {text = tr("DIALOGUELOCATIONEVENT"), tags = [], image = '', options = [{code = 'good_event', reqs = [], text = tr("DIALOGUELOCATIONEVENTGOOD")},{code = 'evil_event', reqs = [], text = tr("DIALOGUELOCATIONEVENTEVIL")},{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]},

	wolves_skirmish_start = {text = tr("DIALOGUEWOLVES_SKIRMISH_START"), set_enemy = 'wolves_skirmish',tags = [], image = 'wolves_skirmish', options = [{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION")},{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]},
	rebels_skirmish_start = {text = tr("DIALOGUEREBELS_SKIRMISH_START"), set_enemy = 'rebels_skirmish',tags = [], image = '', options = [{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION")},{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]},
	goblins_skirmish_start = {text = tr("DIALOGUEGOBLINS_SKIRMISH_START"), set_enemy = 'goblins_skirmish',tags = [], image = '', options = [{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION")},{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]},
	ogre_skirmish_start = {text = tr("DIALOGUEOGRE_SKIRMISH_START"), set_enemy = 'ogre_skirmish',tags = [], image = '', options = [{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION")},{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]},
	troll_skirmish_start = {text = tr("DIALOGUETROLL_SKIRMISH_START"), set_enemy = 'troll_skirmish',tags = [], image = '', options = [{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION")},{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]},

	skirmish_complete = {
		text = [{text = "DIALOGUEMISSIONCOMPLETE", reqs = []}],
		image = 'dungeonclear',
		tags = [],
		options = [
			{code = 'complete_skirmish', text = 'Leave', reqs = [], bonus_effects = [{code = 'complete_active_location_quests'}]},
		]
		},
	
	
	
	slave_remove = {
		text = [{text = "DIALOGUESLAVEREMOVETEXT", reqs = []}],
		image = 'warn',
		default_event_type = 'scene_character_event',
		tags = ['dialogue_scene','active_character_translate'],
		options = [
			{code = 'slave_remove_confirm', reqs = [], text = tr("DIALOGUECONFIRM"), dialogue_argument = 0},
			{code = 'close', text = tr('DIALOGUECANCEL'), reqs = []},
		]
		},
	slave_remove_confirm = {
		text = [{text = "DIALOGUESLAVEREMOVECONFIRMED", reqs = []}],
		image = 'hire',
		default_event_type = 'scene_character_event',
		tags = ['active_character_translate'],
		options = [
			{code = 'close', text = tr('DIALOGUECANCEL'), reqs = [], bonus_effects = [{code = 'affect_active_character', type = 'remove'}]},
		]
		},

	character_boss_defeat = {text = tr("DIALOGUERANDOMBOSSDEFEAT"),
	image = 'bosscapturefemale',
	tags = ['scene_character_translate'],
	common_effects = [
	{code = 'make_scene_character',
	value = [
		{type = 'function',
		function = 'make_local_recruit',
		args = {
			races = [['local', 3],['random', 1]],
			difficulty = [1,2],
			type = 'slave'
			}
		},
		],
	}
	],
	options = [
	{code = 'capture_from_scene', reqs = [], text = tr("DIALOGUERECRUITBOSSOPTION")},
	{code = 'execute', reqs = [], text = tr("DIALOGUEEXECUTEOPTION")}
	]
	},
	finish_quest_dungeon = {text = tr("DIALOGUEDUNGEONQUESTCOMPLETE"),
	image = 'dungeonclear',
	tags = [],
	options = [
	{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
	]
	},
	finish_quest_location = {text = tr("DIALOGUELOCATIONQUESTCOMPLETE"),
	image = 'dungeonclear',
	tags = [],
	options = [
	{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
	]
	},

	lockpick_chest_free = {
		text = 'DIALOGUECHESTLOCKPICKFREE',
		tags = ['active_character_translate'],
		image = 'chest',
		options = [
		{code = 'open_chest', reqs = [], text = tr("DIALOGUECHESTOPEN")}
		],
	},
	lockpick_chest_success = {
		text = 'DIALOGUECHESTLOCKPICKSUCCESS',
		tags = ['active_character_translate'],
		image = 'chest',
		options = [
		{code = 'open_chest', reqs = [], text = tr("DIALOGUECHESTOPEN")}
		],
	},
	lockpick_alarm_failure = {
		text = 'DIALOGUELOCKPICKALARMFAILURE',
		tags = ['active_character_translate'],
		image = 'chest',
		set_enemy = 'random_local_group',
		options = [
		{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION")}
		],
	},
	lockpick_chest_failure = {
		text = 'DIALOGUECHESTLOCKPICKFAILURE',
		tags = ['active_character_translate'],
		image = 'chest',
		options = [
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}
		],
	},
	lockpick_chest_bomb_failure = {
		text = 'DIALOGUECHESTLOCKPICKBOMBFAILURE',
		tags = ['active_character_translate'],
		image = 'chest',
		bonus_effects = [{code = 'affect_active_party', type = 'damage_percent', value = 35}],
		options = [
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}
		],
	},
	lockpick_chest_gas_failure = {
		text = 'DIALOGUECHESTLOCKPICKGASFAILURE',
		tags = ['active_character_translate'],
		image = 'chest',
		bonus_effects = [{code = "affect_active_character", type = 'damage_percent', value = 25},{code = "affect_active_character", type = 'damage_mana_percent', value = 75}],
		options = [
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}
		],
	},


	chest_is_mimic_discovered = {
		text = 'DIALOGUECHESTMIMICDISCOVERED',
		tags = ['active_character_translate'],
		image = 'chest',
		set_enemy = 'mimic',
		options = [
		{code = 'fight_skirmish', reqs = [], text = "DIALOGUEATTACKMIMIC"},
		{code = 'chest_mimic_force_open', reqs = [], text = "DIALOGUEMIMICOPENANYWAY"},
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE"}
		],
	},


	chest_is_mimic_trapped = {
		text = 'DIALOGUECHESTMIMICTRAPPED',
		tags = ['active_character_translate','linked_event'],
		image = 'chest_mimic',
		set_enemy = 'mimic',
		options = [
		{code = 'fight_skirmish', reqs = [], text = "DIALOGUEATTACKMIMIC"},
		{code = 'chest_is_mimic_leave', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [
			{code = 'affect_active_character', type = 'stat_set', stat = 'hp', value = 0},
			{code = 'update_party'},
			]}
		],
	},

	chest_is_erotic_mimic_trapped = {
		text = 'DIALOGUECHESTEROTICMIMICTRAPPED',
		tags = ['active_character_translate','linked_event'],
		image = 'chest_mimic',
		set_enemy = 'mimic',
		options = [
		{code = 'fight_skirmish', reqs = [], text = "DIALOGUEATTACKMIMIC"},
		{code = 'chest_is_erotic_mimic_leave', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'affect_active_character', type = 'stat_set', stat = 'hp', value = 0}, {code = 'update_party'}]}
		],
	},

	chest_is_mimic_leave = {
		text = 'DIALOGUECHESTMIMICTRAPPEDLEAVE',
		tags = ['active_character_translate'],
		image = 'chest_mimic',
		default_event_type = 'character_event',
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE"}
		],
	},
	chest_is_erotic_mimic_leave = {
		text = 'DIALOGUECHESTMIMICEROTICTRAPPEDLEAVE',
		tags = ['active_character_translate'],
		image = 'chest_mimic',
		default_event_type = 'character_event',
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE"}
		],
	},

	dungeon_find_armory_easy = {
		text = tr("DIALOGUEDUNGEONARMORY"),
		tags = ['locked_chest'],
		image = 'armory',
		common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['easy_armory_weapon', 1],['easy_armory_armor', 1]]}],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE"}
		]
	},
	dungeon_find_armory_medium = {
		text = tr("DIALOGUEDUNGEONARMORY"),
		tags = ['locked_chest'],
		image = 'armory',
		common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['medium_armory_weapon', 1],['medium_armory_armor', 1]]}],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE"}
		]
	},

	grove_find_wood = {
		text = tr("DIALOGUEGROVEWOOD"),
		tags = ['free_loot'],
		image = 'chest',
		common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['grove_wood_reward',1]]}],
		options = []
	},
	grove_find_leather = {
		text = tr("DIALOGUEGROVELEATHER"),
		tags = ['free_loot'],
		image = 'chest',
		common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['grove_leather_reward',1]]}],
		options = []
	},
	crypt_find_bones = {
		text = tr("DIALOGUECRYPTBONES"),
		tags = ['free_loot'],
		image = 'chest',
		common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['crypt_bone_reward',1]]}],
		options = []
	},

	dungeon_find_chest_easy = {
		text = tr("DIALOGUEDUNGEONCHEST"),
		tags = ['locked_chest'],
		image = 'chest',
		common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['easy_chest_usable', 1], ['easy_chest_gear',0.2], ['easy_chest_cosmetics', 0.5],['easy_chest_map', 2000]]}],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE"}
		]
	},
	dungeon_find_chest_medium = {
		text = tr("DIALOGUEDUNGEONCHEST"),
		tags = ['locked_chest'],
		image = 'chest',
		common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['medium_chest_usable', 1], ['medium_chest_gear',0.2], ['medium_chest_cosmetics', 0.5],['medium_chest_map', 0.1]]}],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE"}
		]
	},
	quest_accept = {
		text = tr("DIALOGUEQUESTACCEPT"),
		image = '',
		tags = [],
		options = [
		{code = 'close', reqs = [], text = "DIALOGUECLOSE"},
		],
	},

	purchase_dungeon_location = {
		text = tr("DIALOGUEPURCHASEDUNGEONLOCATION"),
		image = 'locationpurchase',
		tags = [],
		options = [
		{code = 'close', reqs = [], text = "DIALOGUECLOSE"},
		],
	},
	unlock_infinite_dungeon = {
		text = tr("DIALOGUEUNLOCKINFINITEDUNGEON"),
		save_scene_to_gallery = true,
		image = null,
		tags = ['dialogue_scene'],
		options = [
					{
						code = "unlock_infinite_dungeon1",
						text = "DIALOGUECONTINUE",
						reqs = [],
						dialogue_argument = 1,
						type = "next_dialogue",
						change_dialogue_type = 2,
						tags = ["blackscreen_transition_slow"]
					}
		]
	},
	unlock_infinite_dungeon1 = {
		text = tr("DIALOGUEUNLOCKINFINITEDUNGEON1"),
		custom_background = "tower",
		scene_type = "story_scene",
		save_scene_to_gallery = true,
		common_effects = [{code = "hide_dialogue"}],
		image = null,
		tags = ["blackscreen_transition_slow",'dialogue_scene'],
		options = [
		{code = 'unlock_infinite_dungeon2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			] 
		
	},unlock_infinite_dungeon2 = {
		text = tr("DIALOGUEUNLOCKINFINITEDUNGEON2"),
		custom_background = "tower",
		scene_type = "story_scene",
		image = null,
		character = 'keeper',
		tags = [],
		options = [
		{code = 'close', reqs = [], text = "DIALOGUECLOSE", bonus_effects = [
			{code = 'decision', value = 'unlock_infinite'}, 
			{code = 'update_city'},
			] },
		],
	},

	event_good_recruit = {text = "DIALOGUEEVENTGOODRECRUIT",
	args = {},
	tags = ['good','scene_character_translate'],
	default_event_type = "character_event",
	image = 'recruit',
	common_effects = [{code = 'make_scene_character', value = [{type = 'function', function = 'make_local_recruit', args = {}}]}],
	options = [
	{code = 'recruit', reqs = [], text = "DIALOGUERECRUITCHARACTEROPTION"},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}
	]
	},

	event_good_loot_small = {text = tr("DIALOGUEEVENTGOODLOOT"),
	tags = ['good','locked_chest'],
	default_event_type = "custom_event",
	image = 'chest',
	common_effects = [{code = 'make_loot',type = 'tableloot', pool = [['easy_chest_usable', 1], ['easy_chest_gear',0.2], ['easy_chest_cosmetics', 0.5],['easy_chest_map', 0.1]]}],
	options = [
	#{code = 'open_chest', reqs = [], text = tr("DIALOGUEFORCECHESTOPEN")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}
	]
	},

	event_dungeon_unlock_resources = {text = tr("DIALOGUEEVENTDUNGEONRESOURCE"),
	tags = ['location_resource_info'],
	default_event_type = "custom_event",
	image = 'chest',
	common_effects = [],
	options = [
	{code = 'leave', reqs = [], text = tr("DIALOGUECONFIRM")}
	]
	},

	event_dungeon_complete_loot_easy = {text = tr("DIALOGUEEVENTDUNGEONLOOT"),
	tags = ['good','locked_chest'],
	default_event_type = "custom_event",
	image = 'chest',
	common_effects = [{code = 'make_loot',type = 'tableloot', pool = [['easy_boss_chest',1]]}],
	options = [
	#{code = 'open_chest', reqs = [], text = tr("DIALOGUEFORCECHESTOPEN")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}
	]
	},
	event_dungeon_complete_loot_medium = {text = tr("DIALOGUEEVENTDUNGEONLOOT"),
	tags = ['good','locked_chest'],
	default_event_type = "custom_event",
	image = 'chest',
	common_effects = [{code = 'make_loot',type = 'tableloot', pool = [['medium_boss_chest',1]]}],
	options = [
	#{code = 'open_chest', reqs = [], text = tr("DIALOGUEFORCECHESTOPEN")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}
	]
	},
	event_dungeon_complete_loot_hard = {text = tr("DIALOGUEEVENTDUNGEONLOOT"),
	tags = ['good','locked_chest'],
	default_event_type = "custom_event",
	image = 'chest',
	common_effects = [{code = 'make_loot',type = 'tableloot', pool = [['hard_boss_chest',1]]}],
	options = [
	#{code = 'open_chest', reqs = [], text = tr("DIALOGUEFORCECHESTOPEN")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}
	]
	},


	event_dungeon_prisoner = {text = tr("DIALOGUEEVENTDUNGEONPRISONER"),
	tags = ['linked_event','active_character_translate'],
	default_event_type = "character_event",
	image = 'cell',

	common_effects = [
	{code = 'make_scene_character',
	value = [
		{type = 'function',
		function = 'make_local_recruit',
		args = {
			races = [['local', 5],['random', 1]],
			difficulty = [0,2],
			type = 'slave'
			}
		},
		],
	}
	],
	options = [
		{code = 'event_dungeon_prisoner_enslave', select_person = true, challenge = 'strength', reqs = [], text = ("DIALOGUETAKESLAVE")},
		{code = 'event_dungeon_prisoner_free', reqs = [], text = tr("DIALOGUESETFREEPERSON")},
#		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}
	]
	},
	event_dungeon_prisoner_enslave = {text = tr("DIALOGUEEVENTDUNGEONPRISONERSENSLAVE"),
	tags = ['scene_character_translate'],
	image = '',
	common_effects = [],
	options = [
	{code = 'capture_from_scene', reqs = [], text = tr("DIALOGUERECRUITCHARACTEROPTION"), bonus_effects = [{code = 'advance_location'}]},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}
	]
	},
	event_dungeon_prisoner_free = {
		variations = [
			{reqs = [{type = 'random', value = 70}],
			text = tr("DIALOGUEEVENTDUNGEONPRISONERFREE1"),
			image = 'chest',
			default_event_type = "custom_event",
			common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['easy_prisoner_reward_resource',1]] }],
			tags = ['active_character_translate'],
			options = [
				{code = 'open_chest', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'advance_location'}]},
				]
			},
			{reqs = [],
			text = tr("DIALOGUEEVENTDUNGEONPRISONERFREE2"),
			image = 'chest',
			default_event_type = "custom_event",
			common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['easy_prisoner_reward_item',1]] }],
			tags = ['active_character_translate'],
			options = [
				{code = 'open_chest', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'advance_location'}]},
				],

			}
		],
	},


	event_goblin_friendly = {text = tr("DIALOGUEEVENTGOBLINFRIENDLY"),
	tags = ['linked_event','active_character_translate'],
	default_event_type = "character_event",
	image = 'goblin_encounter',

	common_effects = [
	{code = 'make_scene_character',
	value = [
		{type = 'function',
		function = 'make_local_recruit',
		args = {
			races = [['Goblin', 5]],
			difficulty = [0,1],
			type = 'slave'
			}
		},
		],
	}
	],
	options = [
	{code = 'event_goblin_recruit', reqs = [], challenge = 'persuasion', select_person = true, text = ("DIALOGUEEVENTGOBLINRECRUIT")},
	{code = 'event_goblin_skip_dungeon', reqs = [], challenge = 'persuasion', select_person = true, text = tr("DIALOGUEEVENTGOBLINBRINGTOLEADER")},
	{code = 'event_goblin_capture', reqs = [], challenge = 'strength', select_person = true, text = tr("DIALOGUEEVENTGOBLINCAPTURE")},
	#{code = 'event_goblin_kill', reqs = [], text = tr("DIALOGUEEVENTGOBLINKILL")},
	{code = 'event_goblin_leave', reqs = [], text = tr("DIALOGUEEVENTGOBLINLEAVE")}
	]
	},

	event_goblin_recruit = {#2REMAKE
			reqs = [],
			text = 'DIALOGUEEVENTGOBLINRECRUITSUCCESS',
			common_effects = [],
			tags = ['scene_character_translate','active_character_translate'],
			image = 'goblin_encounter',
			options = [
				{code = 'recruit_from_scene', text = tr("DIALOGUECONTINUE"), reqs = [], bonus_effects = [{code = 'advance_location'}]},
				{code = 'leave', reqs = [], text = tr("DIALOGUELEAVERECRUITOPTION")}
				]
			
#			{reqs = [],
#			text = "DIALOGUEEVENTGOBLINRECRUITFAILURE",
#			image = 'goblin_encounter',
#			common_effects = [{code = 'affect_active_character', type = 'stat', stat = 'charm', value = 3}],
#			tags = ['scene_character_translate','active_character_translate'],
#			options = [
#				{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'advance_location'}]},
#				],
#
#			}
#		],
	},

	event_goblin_skip_dungeon = {
		reqs = [],
			text = 'DIALOGUEEVENTGOBLINBRINGTOLEADERSUCCESS',
			common_effects = [],
			tags = ['active_character_translate','scene_character_translate'],
			image = 'goblin_encounter',
			options = [
				{code = 'leave', reqs = [], text = tr("DIALOGUECLOSE")}
				]
			
#			{reqs = [],
#			text = "DIALOGUEEVENTGOBLINBRINGTOLEADERFAILURE",
#			image = 'goblin_encounter',
#			common_effects = [{code = 'affect_active_character', type = 'stat', stat = 'charm', value = 3}],
#			tags = ['active_character_translate','scene_character_translate'],
#			options = [
#				{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'advance_location'}]},
#				],
#
#			}
#		],
	},
	event_goblin_capture = {
	text = "DIALOGUEEVENTGOBLINCAPTUREREPLY",
	image = 'goblin_encounter',
	common_effects = [],
	tags = ['active_character_translate','scene_character_translate'],
	options = [
		{code = 'capture_from_scene', text = tr("DIALOGUECONTINUE"), reqs = [], bonus_effects = [{code = 'advance_location'}]},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVERECRUITOPTION")}
		]
	},
	event_goblin_kill = {
	text = "DIALOGUEEVENTGOBLINKILLREPLY",
	image = 'goblin_encounter',
	tags = ['active_character_translate'],
	options = [
		{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'advance_location'}]},
		],
	},
	event_goblin_leave = {
	text = "DIALOGUEEVENTGOBLINLEAVEREPLY",
	image = 'goblin_encounter',
	tags = ['active_character_translate'],
	options = [
		{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'advance_location'}]},
		],
	},

	event_fairy_friendly = {text = tr("DIALOGUEEVENTFAIRYFRIENDLY"),
	tags = ['linked_event','active_character_translate'],
	default_event_type = "character_event",
	image = 'fairy_encounter',

	common_effects = [
	{code = 'make_scene_character',
	value = [
		{type = 'function',
		function = 'make_local_recruit',
		args = {
			races = [['Fairy', 5]],
			difficulty = [0,1],
			type = 'slave'
			}
		},
		],
	}
	],
	options = [
	{code = 'event_fairy_recruit', reqs = [], challenge = 'persuasion', select_person = true, text = ("DIALOGUEEVENTFAIRYRECRUIT")},
	{code = 'event_fairy_heal', reqs = [], text = tr("DIALOGUEEVENTFAIRYASKHEAL")},
	{code = 'event_fairy_capture', reqs = [], challenge = 'dexterity', select_person = true, text = tr("DIALOGUEEVENTFAIRYCAPTURE")},
	{code = 'event_fairy_leave', reqs = [], text = tr("DIALOGUEEVENTFAIRYLEAVE")}
	]
	},
	event_fairy_recruit = {
			reqs = [],
			text = 'DIALOGUEEVENTFAIRYRECRUITSUCCESS',
			common_effects = [],
			tags = ['active_character_translate','scene_character_translate'],
			image = 'fairy_encounter',
			options = [
				{code = 'recruit_from_scene', text = tr("DIALOGUECONTINUE"), reqs = [],bonus_effects = [{code = 'advance_location'}]},
				{code = 'leave', reqs = [], text = tr("DIALOGUELEAVERECRUITOPTION"),bonus_effects = []}
				]
			
#			{reqs = [],
#			text = "DIALOGUEEVENTFAIRYRECRUITFAILURE",
#			image = 'fairy_encounter',
#			common_effects = [{code = 'affect_active_character', type = 'stat', stat = 'charm', value = 3}],
#			tags = ['active_character_translate','scene_character_translate'],
#			options = [
#				{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = [],bonus_effects = [{code = 'advance_location'}]},
#				],
#
#			}
#		],
	},
	event_fairy_heal = {
	text = "DIALOGUEEVENTFAIRYASKHEALREPLY",
	image = 'fairy_encounter',
	tags = ['active_character_translate'],
	bonus_effects = [{code = 'affect_active_party', type = 'damage_percent', value = -35}],
	options = [
		{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = [],bonus_effects = [{code = 'advance_location'}]},
		],
	},
	event_fairy_capture = {
	text = "DIALOGUEEVENTFAIRYCAPTUREREPLY",
	image = 'fairy_encounter',
	common_effects = [],
	tags = ['active_character_translate','scene_character_translate'],
	options = [
		{code = 'capture_from_scene', text = tr("DIALOGUECONTINUE"), reqs = [], bonus_effects = [{code = 'advance_location'}]},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVERECRUITOPTION"),bonus_effects = []}
		]
	},
	event_fairy_leave = {
	text = "DIALOGUEVENTFAIRYLEAVEREPLY",
	image = 'fairy_encounter',
	tags = ['active_character_translate'],
	options = [
		{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = [],bonus_effects = [{code = 'advance_location'}]},
		],
	},

	exotic_slave_trader = {text = tr("DIALOGUEEVENTEXOTICTRADER"),
	args = {},
	tags = ['good'],
	default_event_type = "character_event",
	image = 'exotic_slaver',
	common_effects = [
	{code = 'make_scene_character',
	value = [
		{type = 'function',
		function = 'make_local_recruit',
		number = [3,3],
		args = {
			races = [['monster', 1],['rare', 4]],
			difficulty = [0,2],
			type = 'slave',
			bonuses = {price_add_part = 0.5},
			is_hirable = true
			}
		},
		],
	},

	],
	options = [
	#{code = 'event_person_acquired', reqs = [{type = "has_money_for_scene_slave", value = 0}], not_hide = true, text = tr("DIALOGUESLAVERSPURCHASE"), bonus_effects = [{code = 'spend_money_for_scene_character', value = 0}]},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")},
	]
	},

	event_good_slavers_woods = {text = tr("DIALOGUEEVENTGOODSLAVERS"),
	args = {},
	tags = ['good','linked_event','scene_character_translate'],
	default_event_type = "character_event",
	image = 'slavers_elf',
	set_enemy = 'slavers_small',
	winscene = 'event_person_acquired',
	common_effects = [
		{code = 'make_scene_character',
			value = [
			{type = 'function', function = 'make_local_recruit', args = {races = [['Elf', 10], ['Fairy', 2], ['Dryad', 1]], difficulty = [0,1], bonuses = {price_add_part = -0.3}, type = 'slave'}}],
		}],
	options = [
	{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION")},
	{code = 'event_person_acquired', reqs = [{type = "has_money_for_scene_slave", value = 0}], not_hide = true, text = tr("DIALOGUESLAVERSPURCHASE"), bonus_effects = [{code = 'spend_money_for_scene_character', value = 0}]},
	{code = 'event_good_slavers_request', select_person = true, reqs = [], text = tr("DIALOGUEREQUESTSLAVE")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")},
	]
	},
	event_good_slavers_request = {
		variations = [
			{reqs = [{type = 'active_character_checks', value = [{code = 'random', value = [['self.charm_factor','*5'],"+", ['self.charm', '/4']]}]},
			],
			text = tr("DIALOGUEEVENTSLAVERSNEGOTIATESUCCESS"),
			common_effects = [{code = 'affect_active_character', type = 'stat', stat = 'charm', value = 3}],
			tags = ['linked_event','active_character_translate'],
			image = 'slavers_elf',
			options = [
				{code = 'event_person_acquired', text = tr("DIALOGUECONTINUE"), reqs = []},
				]
			},
			{reqs = [],
			text = tr("DIALOGUEEVENTSLAVERSNEGOTIATEFAILURE"),
			image = 'slavers_elf',
			common_effects = [{code = 'affect_active_character', type = 'stat', stat = 'charm', value = 2}],
			tags = ['linked_event','active_character_translate'],
			options = [
				{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = []},
				],

			}
		],
	},
	event_person_acquired = {
		text = tr("DIALOGUEEVENTGOODSLAVERSACQUIRED"),
		args = {},
		tags = ['linked_event','scene_character_translate'],
		default_event_type = 'scene_character_event',
		image = 'slave_decision',
		common_effects = [{code = 'bool_scene_characters', type = 'all', stat = 'is_known_to_player', value = true}],
		options = [
		{code = 'recruit_from_scene', reqs = [], text = tr("DIALOGUEKEEPSLAVEPERSON")},
		{code = 'event_person_free', reqs = [], text = tr("DIALOGUESETFREEPERSON")}
		],
	},
	event_person_free = {#2REMAKE
		text = tr("DIALOGUEEVENTPERSONFREE"),
		args = {},
		tags = ['scene_character_translate'],
		default_event_type = 'scene_character_event',
		image = 'slave_decision',
		common_effects = [],
		options = [
		{code = 'event_person_recruit_attempt', challenge = 'persuasion', select_person = true, reqs = [], text = tr("DIALOGUEPERSONASKTOJOIN")},
		{code = 'close', reqs = [], text = tr("DIALOGUELEAVE")}
		],
	},

	event_person_recruit_attempt = {#2REMAKE
		reqs = [],
			text = tr("DIALOGUERECRUITSUCCESS"),
			common_effects = [],
			tags = ['active_character_translate','scene_character_translate'],
			image = 'slave_decision',
			options = [
				{code = 'recruit_from_scene', text = tr("DIALOGUECONTINUE"), reqs = []},
				{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}
				]
			
#			{reqs = [],
#			text = tr("DIALOGUERECRUITFAILURE"),
#			image = 'slave_decision',
#			common_effects = [{code = 'affect_active_character', type = 'stat', stat = 'charm', value = 2}],
#			tags = ['active_character_translate','scene_character_translate'],
#			options = [
#				{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = []},
#				],
#
#			}
#		],
	},

	event_good_rebels_beastkin = {text = tr("DIALOGUEEVENTGOODREBELSBEAST"),#2REMAKE
	args = {},
	tags = ['good','scene_character_translate'],
	default_event_type = "character_event",
	image = 'rebels_furry',
	set_enemy = 'rebels_small',
	winscene = 'event_person_acquired',
	common_effects = [
	{code = 'make_scene_character', value = [{type = 'function', function = 'make_local_recruit', args = {races = [['beast', 1]], difficulty = [0,1], type = 'slave',bonuses = {}}}],},],
	options = [
	{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION")},
	{code = 'event_good_rebels_intimidate', challenge = 'strength', select_person = true, reqs = [], text = tr("DIALOGUEINTIMIDATE")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")},
	]
	},

	event_good_rebels_intimidate = {
			reqs = [],
			text = "DIALOGUEEVENTREBELSBEASTINTIMIDATESUCCES",
			common_effects = [{code = 'affect_active_character', type = 'stat', stat = 'charm', value = 3}],
			tags = ['linked_event','active_character_translate'],
			image = 'rebels_furry',
			options = [
				{code = 'event_person_acquired', text = tr("DIALOGUECONTINUE"), reqs = []},
				]
#			{reqs = [],
#			text = "DIALOGUEEVENTREBELSBEASTINTIMIDATEFAILURE",
#			image = 'rebels_furry',
#			winscene = 'event_person_acquired',
#			common_effects = [{code = 'affect_active_character', type = 'stat', stat = 'charm', value = 2}],
#			tags = ['linked_event','active_character_translate'],
#			options = [
#				{code = 'fight_skirmish', text = tr("DIALOGUEFIGHTOPTION"), reqs = []},
#				],
#
#			}
#		],
	},

	event_nothing_found = {text = "DIALOGUEEVENTNOTHING",
	tags = ['good'],
	default_event_type = "location",
	image = 'noevent',
	options = [
	{code = 'leave', reqs = [], text = "DIALOGUELEAVE"}
	]
	},

	#items with options

	minorus_potion_select = {text = "DIALOGUEEVENTMINORUSSELECT",
	tags = ['custom_effect','active_character_translate'],
	image = 'pot',
	options = [
	{code = 'minorus_tits', reqs = [], text = "DIALOGUETITSSELECT"},
	{code = 'minorus_ass', reqs = [], text = "DIALOGUEASSSELECT"},
	{code = 'minorus_balls', reqs = [{type = 'active_character_checks', value = [{code = 'bodypart', part = 'balls_size', operant = 'neq', value = ''}]}], text = "DIALOGUEBALLSSELECT"},
	{code = 'minorus_penis', reqs = [{type = 'active_character_checks', value = [{code = 'bodypart', part = 'penis_size', operant = 'neq', value = ''}]}], text = "DIALOGUEPENISSELECT"},
	]
	},
	majorus_potion_select = {text = "DIALOGUEEVENTMAJORUSSELECT",
	tags = ['custom_effect','active_character_translate'],
	image = 'pot',
	options = [
	{code = 'majorus_tits', reqs = [], text = "DIALOGUETITSSELECT"},
	{code = 'majorus_ass', reqs = [], text = tr("DIALOGUEASSSELECT")},
	{code = 'majorus_balls', reqs = [{type = 'active_character_checks', value = [{code = 'bodypart', part = 'balls_size', operant = 'neq', value = ''}]}], text = tr("DIALOGUEBALLSSELECT")},
	{code = 'majorus_penis', reqs = [{type = 'active_character_checks', value = [{code = 'bodypart', part = 'penis_size', operant = 'neq', value = ''}]}], text = tr("DIALOGUEPENISSELECT")},
	]
	},

	minorus_potion_tits = {text = tr("DIALOGUEMINORUSPOTTITS"), image = 'potmaj', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	minorus_potion_ass = {text = tr("DIALOGUEMINORUSPOTASS"), image = 'potmaj', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	minorus_potion_penis = {text = tr("DIALOGUEMINORUSPOTPENIS"), image = 'potmaj', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	minorus_potion_balls = {text = tr("DIALOGUEMINORUSPOTBALLS"), image = 'potmaj', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	majorus_potion_tits = {text = tr("DIALOGUEMAJORUSPOTTITS"), image = 'potmaj', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	majorus_potion_ass = {text = tr("DIALOGUEMAJORUSPOTASS"), image = 'potmaj', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	majorus_potion_penis = {text = tr("DIALOGUEMAJORUSPOTPENIS"), image = 'potmaj', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	majorus_potion_balls = {text = tr("DIALOGUEMAJORUSPOTBALLS"), image = 'potmaj', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	potion_no_effect = {text = tr("DIALOGUEPOTIONNOEFFECT"), image = 'potmaj', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},

	writ_of_exemption = {
		text = tr("DIALOGUEWRIT_CONFIRM"),
		image = null,
		tags = ['custom_effect','active_character_translate'],
		options = [
		{code = 'writ_of_exemption_use', reqs = [], text = tr("DIALOGUECONFIRM")},
		{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},

		],
	},
	writ_of_exemption_success = {
		text = tr("DIALOGUEWRIT_SUCCESS"),
		image = null,
		tags = ['active_character_translate'],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
		],
	},
	writ_of_exemption_failure = {
		text = tr("DIALOGUEWRIT_FAILURE"),
		image = null,
		tags = ['active_character_translate'],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
		],
	},

		oblivion_potion_use = {
		text = "DIALOGUEOBLIVIONPOTUSE", image = 'potused', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]
	},
	pheromones_use = {
		text = [
		{text = "DIALOGUEPHEROMONESSELF_SUCCESS", reqs = [{type = 'active_character_checks', value = [{code = 'is_master', check = true}, {code = 'race_is_beast', check = true}]}]},
		{text = "DIALOGUEPHEROMONESSELF_FAIL", reqs = [{type = 'active_character_checks', value = [{code = 'is_master', check = true}, {code = 'race_is_beast', check = false}]}]},
		{text = "DIALOGUEPHEROMONES_SUCCESS", reqs = [{type = 'active_character_checks', value = [{code = 'is_master', check = false}, {code = 'race_is_beast', check = true}]}]},
		{text = "DIALOGUEPHEROMONES_FAIL", reqs = [{type = 'active_character_checks', value = [{code = 'is_master', check = false}, {code = 'race_is_beast', check = false}]}]},
		],
		image = 'potused',
		tags = ['custom_effect','active_character_translate'],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
		],
	},
	
	
	lactation_potion_success = {
		text = [{text = "DIALOGUELACTATION_SUCCESS", reqs = []}],
		image = null,
		tags = ['active_character_translate'],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
		],
	},
	lactation_potion_reverse = {
		text = tr("DIALOGUELACTATION_REVERSE"),
		image = null,
		tags = ['active_character_translate'],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
		],
	},
	sex_swap_potion_female = {
		text = tr("DIALOGUESEXSWAP_FEMALE"),
		image = null,
		tags = ['active_character_translate'],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
		],
	},
	sex_swap_potion_male = {
		text = tr("DIALOGUESEXSWAP_MALE"),
		image = null,
		tags = ['active_character_translate'],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
		],
	},
	
	zephyra_underwear = {
		text = tr("DIALOGUEZEPHYRA_UNDERWEAR"),
		image = null,
		tags = ['custom_effect','active_character_translate'],
		options = [
		{code = 'zephyra_underwear_use', reqs = [], text = tr("DIALOGUEZEPHYRA_UNDERWEAROPTION")},
		{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
		],
	},
	zephyra_underwear_use = {
		text = tr("DIALOGUEZEPHYRA_UNDERWEAR2"),
		character = 'zephyra_mad',
		image = null,
		tags = ['active_character_translate'],
		options = [
		{code = 'close', args = {screen_duration = 5, hold_scene = true}, reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = 'lose_game'}]},
		],
	},
	
	#Action events
	enslave = {text = tr("DIALOGUEENSLAVETEXT"), image = 'warn', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	hire = {text = tr("DIALOGUEHIRETEXT"), image = 'praise', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},

	#Story Events
	daisy_meet = {
		text = tr('SCENEDAISY_MEET_TEXT'),
		tags = ['linked_event'],#linked_event means that all options will trigger other events by name instead of generic options like 'close' or 'inspect'
		image = 'daisystart',
		opp_characters = [{type = 'pregen', value = 'Daisy'}],
		options = [
		{code = 'daisy_purchase', text = tr("SCENEDAISY_MEET_OPTION1"), reqs = [], type = 'next_dialogue'},
		{code = 'daisy_claim_kinship', text =  tr("SCENEDAISY_MEET_OPTION2"), type = 'next_dialogue', reqs = [{type = 'master_is_beast', check = true}]},
		{code = 'daisy_ignore_purchase', text = tr("SCENEDAISY_MEET_OPTION3"), type = 'next_dialogue', reqs = []},
		],
	},
	daisy_claim_kinship = {
		text = tr("SCENEDAISY_CLAIM_KINSHIPTEXT"),
		tags = ['dialogue_scene'],
		image = 'daisystart',
		common_effects = [{code = 'make_story_character', value = 'Daisy'}],#, {code = 'unique_character_changes', value = 'daisy', args = [
#			{code = 'tag', operant = 'add', value = 'no_sex'}]}],
		options = [
		{code = 'daisy_recruitment_1', text = tr('DIALOGUECLOSE'), type = 'next_dialogue', reqs = [], dialogue_argument = 1},
		],
	},
	daisy_purchase = {
		text = tr("SCENEDAISY_PURCHASE_TEXT"),
		tags = ['linked_event'],
		image = 'daisystart',
		options = [{code = 'daisy_purchase_negotiate', text = tr("SCENEDAISY_PURCHASE_OPTION1"), reqs = [], type = 'next_dialogue'},
		{code = 'daisy_purchase_negotiate', text = tr("SCENEDAISY_PURCHASE_WORKER_OPTION1"), type = 'next_dialogue', reqs = [{
			type = 'master_check', value = [{code = 'has_profession', profession = 'worker', check = true}]}]},
		{code = 'daisy_purchase_confirm', text = tr("SCENEDAISY_PURCHASE_OPTION2"), type = 'next_dialogue', reqs = [{type = "has_money", value = 200}]},
		{code = 'daisy_purchase_leave', text = tr("SCENEDAISY_PURCHASE_OPTION3"), type = 'next_dialogue', reqs = []},
		],
	},

	daisy_purchase_negotiate = {
		variations = [
			{reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'worker', check = true}]}],
			text = tr("SCENEDAISY_PURCHASE_WORKER1"),
			common_effects = [],
			tags = ['linked_event'],
			image = 'daisystart',
			options = [
				{code = 'daisy_purchase_confirm_discount', text = tr("SCENEDAISY_PURCHASE_OPTION2_1"), type = 'next_dialogue', reqs = [{type = "has_money", value = 100}]},
				{code = 'daisy_purchase_leave', type = 'next_dialogue', text = tr("SCENEDAISY_PURCHASE_OPTION3"), reqs = []},
				]
			},
			{reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 3}, {code = 'stat', stat = 'charm', operant = 'gte', value = 15, orflag = true}]}],
			text = tr("SCENEDAISY_PURCHASE_NEGOTIATE_TEXT1"),
			common_effects = [],
			tags = ['linked_event'],
			image = 'daisystart',
			options = [
				{code = 'daisy_purchase_confirm_discount', text = tr("SCENEDAISY_PURCHASE_OPTION2_1"), type = 'next_dialogue', reqs = [{type = "has_money", value = 100}]},
				{code = 'daisy_purchase_leave', text = tr("SCENEDAISY_PURCHASE_OPTION3"), type = 'next_dialogue', reqs = []},
				]
			},

			{reqs = [],
			text = tr("SCENEDAISY_PURCHASE_NEGOTIATE_TEXT2"),
			image = 'daisystart',
			common_effects = [],
			tags = ['linked_event'],
			options = [
				{code = 'daisy_purchase_confirm', text = tr("SCENEDAISY_PURCHASE_OPTION2"), type = 'next_dialogue', reqs = [{type = "has_money", value = 200}]},
				{code = 'daisy_purchase_leave', text = tr("SCENEDAISY_PURCHASE_OPTION3"), type = 'next_dialogue', reqs = []},
				],

			}
		],
	},
	daisy_purchase_confirm = {
		text = tr("SCENEDAISY_PURCHASE_CONFIRM_TEXT"),
		tags = ['dialogue_scene'],
		image = 'daisystart',
		common_effects = [{code = 'money_change', operant = '-', value = 200},
		{code = 'make_story_character', value = 'Daisy'}, 
#		{code = 'unique_character_changes', value = 'daisy', args = [
#			{code = 'tag', operant = 'add', value = 'no_sex'}]}
			],
		options = [
		{code = 'daisy_recruitment_1', text = tr('DIALOGUECLOSE'), type = 'next_dialogue', reqs = [], dialogue_argument = 1}],
	},
	daisy_purchase_confirm_discount = {
		text = tr("SCENEDAISY_PURCHASE_CONFIRM_TEXT"),
		tags = ['dialogue_scene'],
		image = 'daisystart',
		common_effects = [{code = 'money_change', operant = '-', value = 100}, {code = 'make_story_character', value = 'Daisy'}, 
#		{code = 'unique_character_changes', value = 'daisy', args = [
#			{code = 'tag', operant = 'add', value = 'no_sex'}]}
			],
		options = [
		{code = 'daisy_recruitment_1', text = tr('DIALOGUECLOSE'), type = 'next_dialogue', reqs = [], dialogue_argument = 1}],
	},
	daisy_purchase_leave = {
		text = tr("SCENEDAISY_PURCHASE_LEAVE_TEXT"),
		tags = [],
		image = 'daisystart',
		common_effects = [],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), type = 'next_dialogue', reqs = []},
		],
	},
	daisy_ignore_purchase = {
		text = tr("SCENEDAISY_IGNORE_TEXT"),
		tags = [],
		image = 'daisystart',
		common_effects = [],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), type = 'next_dialogue', reqs = []},
		],
	},

	daisy_first_event = {
		text = tr("SCENEDAISY_FIRST_EVENT_TEXT"),
		tags = ['linked_event'],
		reqs = [{type = 'unique_character_at_mansion', name = 'daisy', check = true, negative = 'repeat_next_day'}],#this requirement only applies when checking timed_events. 'negative' means what resolution should apply when requirement is not met.
		image = 'daisyevent',
		options = [
		{code = 'daisy_first_event_reassure', text = tr("SCENEDAISY_FIRST_EVENT_OPTION1"), type = 'next_dialogue', reqs = []},
		{code = 'daisy_first_event_discipline', text = tr("SCENEDAISY_FIRST_EVENT_OPTION2"), type = 'next_dialogue', reqs = []},
		],
	},
	daisy_first_event_reassure = {
		text = tr("SCENEDAISY_FIRST_EVENT_REASSURE"),
		tags = [],
		image = 'daisyevent',
		common_effects = [#common_effects are treated in state by applying simple changes to game state and characters.
		{code = 'add_timed_event', value = "daisy_confess_event", args = [{type = 'add_to_date', date = [7,10], hour = 3}]},
		{code = 'unique_character_changes', value = 'daisy', args = [ #unique_character_changes takes an unique character and apply specific values to their values with exceptions of traits and tags which treated separately
			{code = 'tame_factor', value = 1, operant = "+"},
			]},
		],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	daisy_first_event_discipline = {
		text = tr("SCENEDAISY_FIRST_EVENT_DISCIPLINE"),
		custom_background = "daisy_discipline",
		dialogue_type = 2,
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = [],
		image = null,
		common_effects = [{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'sexuals_factor', value = 1, operant = "+"},
			{code = 'sextrait', value = 'submissive', operant = 'add', known = true},#for sextrait/add setting, trait is appended to character's traits
			{code = 'tag', operant = 'remove', value = 'no_sex'},
			]}],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	daisy_confess_event = {
		text = tr("SCENEDAISY_CONFESS_EVENT_TEXT"),
		tags = ['linked_event','master_translate'],
		reqs = [{type = 'unique_character_at_mansion', name = 'daisy', check = true, negative = 'repeat_next_day'}],
		image = 'daisyconfess',
		options = [
		{code = 'daisy_confess_accept', text = tr("SCENEDAISY_CONFESS_EVENT_OPTION1"), reqs = []},
		{code = 'daisy_confess_refuse', text = tr("SCENEDAISY_CONFESS_EVENT_OPTION2"), reqs = []},
		],
	},
	daisy_confess_accept = {
		text = tr("SCENEDAISY_CONFESS_ACCEPT_TEXT"),
		tags = [],
		image = 'daisyconfess',
		common_effects = [
		{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'growth_factor', value = 1, operant = "+"},
			{code = 'wits_factor', value = 1, operant = "+"},
			{code = 'tag', operant = 'remove', value = 'no_sex'},
			]},
		],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	daisy_confess_refuse = {
		text = tr("SCENEDAISY_CONFESS_REFUSE_TEXT"),
		tags = [],
		image = 'daisyconfess',
		common_effects = [
		{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'tag', operant = 'remove', value = 'no_sex'},
			]},
		],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},



	intro = {
		image = null,
		tags = ['dialogue_scene','master_translate'],
		text = "INTRODIALOGUE",
		options = [
		{code = 'starting_dialogue', text = "Continue", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		]
	},

	starting_dialogue = {
		image = null,
		tags = ['dialogue_scene','master_translate'],
		text = "STARTINGDIALOGUE0",
		options = [
		{code = 'starting_dialogue1', text = "STARTINGDIALOGUE0REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'starting_dialogue1', text = "STARTINGDIALOGUE0REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'starting_dialogue1', text = "STARTINGDIALOGUE0REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		]
	},
	starting_dialogue1 = {
		image = null,
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "STARTINGDILOGUE1_1", reqs = [], previous_dialogue_option = 1},
		{text = "STARTINGDILOGUE1_2", reqs = [], previous_dialogue_option = 2},
		{text = "STARTINGDILOGUE1_3", reqs = [], previous_dialogue_option = 3},
		{text = "STARTINGDILOGUE1_4", reqs = []},
		],
		options = [
		{code = 'starting_dialogue2', text = "STARTINGDIALOGUE1REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'starting_dialogue2', text = "STARTINGDIALOGUE1REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'}
		],

	},
	starting_dialogue2 = {
		image = null,
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "STARTINGDIALOGUE2_1", reqs = [], previous_dialogue_option = 1},
		{text = "STARTINGDIALOGUE2_2", reqs = [], previous_dialogue_option = 2},
		{text = "STARTINGDIALOGUE2_3", reqs = []},
		],
		options = [
		{code = 'starting_dialogue3', text = "STARTINGDIALOGUE2REPLY1", reqs = [], dialogue_argument = 1},
		{code = 'starting_dialogue3', text = "STARTINGDIALOGUE2REPLY2", reqs = [], dialogue_argument = 2},
		{code = 'starting_dialogue3', text = "STARTINGDIALOGUE2REPLY3", reqs = [{type = 'dialogue_seen', check = true, value = 'STARTINGDIALOGUE3_1'}], dialogue_argument = 3},
		{code = 'starting_dialogue4', text = "STARTINGDIALOGUE2REPLY4", reqs = [], dialogue_argument = 4, type = 'next_dialogue'},
		],

	},
	starting_dialogue3 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
		{text = "STARTINGDIALOGUE3_1", reqs = [], previous_dialogue_option = 1},
		{text = "STARTINGDIALOGUE3_2", reqs = [], previous_dialogue_option = 2},
		{text = "STARTINGDIALOGUE3_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [
		{code = 'starting_dialogue3', text = "STARTINGDIALOGUE2REPLY1", reqs = [], dialogue_argument = 1},
		{code = 'starting_dialogue3', text = "STARTINGDIALOGUE2REPLY2", reqs = [], dialogue_argument = 2},
		{code = 'starting_dialogue3', text = "STARTINGDIALOGUE2REPLY3", reqs = [{type = 'dialogue_seen', check = true, value = 'STARTINGDIALOGUE3_1'}], dialogue_argument = 3},
		{code = 'starting_dialogue4', text = "STARTINGDIALOGUE2REPLY4", reqs = [], dialogue_argument = 4, type = 'next_dialogue'},
		],

	},
	starting_dialogue4 = {
		image = null,
		tags = ['dialogue_scene'],
		text = "STARTINGDIALOGUE4_1",
		common_effects = [
			{code = 'plan_loan_event', stage = 1},
			{code = 'progress_quest', value = 'main_quest_loan', stage = 'stage0'},
			{code = 'progress_quest', value = 'guilds_introduction', stage = 'start'},
			],
		options = [
		{code = 'close', reqs = [{type = 'difficulty', check = false, value = 'diff_free_upgrade'}], text = tr("DIALOGUECLOSE"), type = 'next_dialogue'},
		{code = 'starting_bonus_upgrade', reqs = [{type = 'difficulty', check = true, value = 'diff_free_upgrade'}], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 1},
		],
	},
	starting_bonus_upgrade = {
		image = null,
		tags = ['dialogue_scene','blackscreen_transition_common'],
		text = "STARTUPGRADEBONUS",
		common_effects = [],
		options = [
		{code = 'close', reqs = [], bonus_effects = [{code ='unlock_upgrade', upgrade = 'forge', level = 1}], text = tr("STARTUPGRADEBONUS1"), type = 'next_dialogue'},
		{code = 'close', reqs = [], bonus_effects = [{code ='unlock_upgrade', upgrade = 'tailor', level = 1}], text = tr("STARTUPGRADEBONUS2"), type = 'next_dialogue'},
		{code = 'close', reqs = [], bonus_effects = [{code ='unlock_upgrade', upgrade = 'alchemy', level = 1}], text = tr("STARTUPGRADEBONUS3"), type = 'next_dialogue'},
		{code = 'close', reqs = [], bonus_effects = [{code = 'make_loot', type = 'tableloot', pool = [['start_corruptive_essence',1]]},{code = 'open_loot'}], text = tr("STARTUPGRADEBONUS4"), type = 'next_dialogue'},
		],
	},
	
	loan_event1 = {
		variations = [{
			reqs = [{type = 'has_loan_money', stage = 1}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "LOAN_EVENT", reqs = []}, {text = "LOAN_SUCCESS1", reqs = []}],
			options = [
			{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue',
			bonus_effects = [
#				{code = 'money_change', operant = '-', value = 1000},
				{code = 'pay_loan', stage = 1},
				{code = 'progress_quest', value = 'main_quest_loan', stage = 'stage1'},
				{code = 'plan_loan_event', stage = 2},
				{code = 'rewrite_save'}
				]
			}],
			},

			{
			reqs = [],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "LOAN_EVENT", reqs = []}, {text = "LOAN_FAILURE", reqs = []}],
			options = [
			{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = 'lose_game'}]},
			],
			},
		]
	},
	loan_event2 = {
		variations = [{
			reqs = [{type = 'has_loan_money', stage = 2}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "LOAN_EVENT", reqs = []}, {text = "LOAN_SUCCESS2", reqs = []}],
			options = [
			{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue',
			bonus_effects = [
#				{code = 'money_change', operant = '-', value = 3000},
				{code = 'pay_loan', stage = 2},
				{code = 'progress_quest', value = 'main_quest_loan', stage = 'stage2'},
				{code = 'plan_loan_event', stage = 3},
#				{code = 'add_timed_event', value = "loan_event3",
#					args = [
#						{type = 'fixed_date',
#						date = 50,
#						hour = 1}
#						]
#					},
				{code = 'rewrite_save'}
				]
			}],
			},
			{
			reqs = [],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "LOAN_EVENT", reqs = []}, {text = "LOAN_FAILURE", reqs = []}],
			options = [
			{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = 'lose_game'}]},
			],
			},
		]
	},
	loan_event3 = {
		variations = [{
			reqs = [{type = 'has_loan_money', stage = 3}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "LOAN_EVENT", reqs = []}, {text = "LOAN_SUCCESS3", reqs = []}],
			options = [
			{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue',
			bonus_effects = [
#				{code = 'money_change', operant = '-', value = 10000},
				{code = 'pay_loan', stage = 3},
				{code = 'progress_quest', value = 'main_quest_loan', stage = 'stage3'},
				{code = 'plan_loan_event', stage = 4},
#				{code = 'add_timed_event', value = "loan_event4",
#					args = [
#						{type = 'fixed_date',
#						date = 99,
#						hour = 1}
#						]
#					},
				{code = 'rewrite_save'}
				]
			}],
			},
			{
			reqs = [],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "LOAN_EVENT", reqs = []}, {text = "LOAN_FAILURE", reqs = []}],
			options = [
			{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = 'lose_game'}]},
			],
			},
		]
	},
	loan_event4 = {
		variations = [{
			reqs = [{type = 'has_loan_money', stage = 4}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "LOAN_EVENT", reqs = []}, {text = "LOAN_SUCCESS4", reqs = []}],
			options = [
			{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue', bonus_effects = [
#				{code = 'money_change', operant = '-', value = 86000},
				{code = 'pay_loan', stage = 4},
				{code = 'complete_quest', value = 'main_quest_loan'}, 
				{code = 'rewrite_save'}]},
			],
			},
			{
			reqs = [],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "LOAN_EVENT", reqs = []}, {text = "LOAN_FAILURE", reqs = []}],
			options = [
			{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = 'lose_game'}]},
			],
			},
		]
	},
	guilds_elections_switch = {
		image = null,
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "DIALOGUEINTRODUCTIONLETTER", reqs = []},
		],
		common_effects = [{code = 'progress_quest', value = 'guilds_introduction', stage = 'stage2'}],
		options = [
		{code = 'close', text = "DIALOGUECLOSE", reqs = [], bonus_effects = [{code = 'rewrite_save'}]},
		],
	},
	
	recruit_captured = {
		text = tr("DIALOGUERECRUIT"),
		tags = ['recruit','scene_character_translate'],
		image = 'slave_decision', 
		options = [
		{code = 'recruit_captured', select_person = true, reqs = [], text = tr("DIALOGUERECRUITCHOOSEPERSON")},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")},]
	},
	recruit_meet = {
		text = tr("DIALOGUEMEET"),
		tags = ['recruit','scene_character_translate'],
		image = 'recruit', 
		options = [
		{code = 'recruit_meet', select_person = true, reqs = [], text = tr("DIALOGUERECRUITCHOOSEPERSON")},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")},]
	},
	recruit_captured_enslave = {text = tr("DIALOGUERECRUITENSLAVE"),
	tags = ['scene_character_translate'],
	image = '',
	common_effects = [],
	options = [
	{code = 'capture_from_scene', reqs = [], text = tr("DIALOGUECLOSE")},
	]
	},
	recruit_captured_success = {text = tr("DIALOGUERECRUITGOOD"),
	tags = ['scene_character_translate'],
	image = '',
	common_effects = [],
	options = [
	{code = 'recruit_from_scene', reqs = [], text = tr("DIALOGUERECRUITGOODSERVANT"), bonus_effects = [{code = 'real_affect_scene_characters', type = 'slavetype', value = 'servant'},]},
	]
	},
	recruit_captured_success_seduce = {text = tr("DIALOGUERECRUITGOODSEDUCE"),
	tags = ['scene_character_translate'],
	image = 'mindcontrol',
	common_effects = [],
	options = [
	{code = 'recruit_from_scene', reqs = [], text = tr("DIALOGUERECRUITGOODSERVANT"), bonus_effects = [{code = 'real_affect_scene_characters', type = 'slavetype', value = 'servant'},]},
	]
	},
	recruit_captured_fail = {text = tr("DIALOGUERECRUITBAD"),
	tags = ['scene_character_translate'],
	image = '',
	common_effects = [],
	options = [
	{code = 'capture_from_scene', reqs = [], text = tr("DIALOGUECLOSE")},
	]
	},
	recruit_meet_success = {text = tr("DIALOGUEMEETGOOD"),
	tags = ['scene_character_translate'],
	image = '',
	common_effects = [],
	options = [
	{code = 'recruit_from_scene', reqs = [], text = tr("DIALOGUEMEETGOODDEFAULT"), bonus_effects = [{code = 'real_affect_scene_characters', type = 'slavetype', value = 'servant'}]},
	]
	},
	recruit_meet_success_seduce = {text = tr("DIALOGUEMEETGOODSEDUCE"),
	tags = ['scene_character_translate'],
	image = 'mindcontrol',
	common_effects = [],
	options = [
	{code = 'recruit_from_scene', reqs = [], text = tr("DIALOGUEMEETGOODDEFAULT"), bonus_effects = [{code = 'real_affect_scene_characters', type = 'slavetype', value = 'servant'}]},
	]
	},
	recruit_meet_fail = {text = tr("DIALOGUEMEETBAD"),
	tags = ['scene_character_translate'],
	image = '',
	common_effects = [],
	options = [
	{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
	]
	},
	
	resource_gather = {
		text = tr(""),
		tags = ['location_resource_info'],
		image = 'chest', 
		options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},]
	},
	
	
	celena_shrine_find = {
		text = tr("DIALOGUESHRINECELENA"),
		tags = [],
		image = 'celena_shrine',
		options = [
		{code = 'celena_shrine_approach', select_person = true, reqs = [], text = tr("DIALOGUEAPPROACHSHRINE")},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]
	},
	celena_shrine_approach = {
		text = tr("DIALOGUESHRINECELENA"),
		tags = ['shrine','active_character_translate'],
		shrine = 'celena',
		image = 'celena_shrine',
		options = [
		{code = 'celena_shrine_approach', select_person = true, reqs = [], text = tr("DIALOGUESHRINECHOOSEPERSON")},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]
	},
	erebus_shrine_find = {
		text = tr("DIALOGUESHRINEEREBUS"),
		tags = [],
		image = 'erebus_shrine',
		options = [
		{code = 'erebus_shrine_approach', select_person = true, reqs = [], text = tr("DIALOGUEAPPROACHSHRINE")},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]
	},
	erebus_shrine_approach = {
		text = tr("DIALOGUESHRINEEREBUS"),
		tags = ['shrine','active_character_translate'],
		shrine = 'erebus',
		image = 'erebus_shrine',
		options = [
		{code = 'erebus_shrine_approach', select_person = true, reqs = [], text = tr("DIALOGUESHRINECHOOSEPERSON")},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]
	},
	freya_shrine_find = {
		text = tr("DIALOGUESHRINEFREYA"),
		tags = [],
		image = 'freya_shrine',
		options = [
		{code = 'freya_shrine_approach', select_person = true, reqs = [], text = tr("DIALOGUEAPPROACHSHRINE")},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]
	},
	freya_shrine_approach = {
		text = tr("DIALOGUESHRINEFREYA"),
		tags = ['shrine','active_character_translate'],
		shrine = 'freya',
		image = 'freya_shrine',
		options = [
		{code = 'freya_shrine_approach', select_person = true, reqs = [], text = tr("DIALOGUESHRINECHOOSEPERSON")},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]
	},
	hybris_shrine_find = {
		text = tr("DIALOGUESHRINEHYBRIS"),
		tags = [],
		image = 'hybris_shrine',
		options = [
		{code = 'hybris_shrine_approach', select_person = true, reqs = [], text = tr("DIALOGUEAPPROACHSHRINE")},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]
	},
	hybris_shrine_approach = {
		text = tr("DIALOGUESHRINEHYBRIS"),
		tags = ['shrine','active_character_translate'],
		shrine = 'hybris',
		image = 'hybris_shrine',
		options = [
		{code = 'hybris_shrine_approach', select_person = true, reqs = [], text = tr("DIALOGUESHRINECHOOSEPERSON")},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]
	},
#	hybris_character_loyalty = {
#		text = tr("HYBRIS_ALTAR_CHAR_RESULT1"),
#		tags = ['active_character_translate'],
#		image = 'mindcontrol',
#		common_effects = [],
#		options = [
#		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]
#	},
	hybris_character_convert = {
		text = tr("HYBRIS_ALTAR_CHAR_RESULT2"),
		tags = ['active_character_translate'],
		image = 'mindcontrol',
		common_effects = [
			{code = 'change_type_scene_characters', type = 'all', value = 'slave'},
			{code = 'clear_subroom'},
			{code = 'try_breakdown_scene_characters', value = 'brk_shrine_enslave'}
			],
		options = [
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")}]
	},
	spring = {variations = [{
		reqs = [{type = 'random', value = 5}],
		text = tr("SPRINGTEXT"),
		tags = ['dialogue_scene'],
		image = 'spring',
		options = [
			{code = 'spring_stamina', reqs = [], text = tr("SPRING_STAMINA_OPTION"), dialogue_argument = 1},
			{code = 'spring_loot', reqs = [], text = tr("SPRING_LOOT_OPTION"), dialogue_argument = 2},
			{code = 'close', reqs = [], text = "DIALOGUECANCEL"}
		]
		},{
		reqs = [],
		text = tr("SPRINGTEXT"),
		tags = ['dialogue_scene'],
		image = 'spring',
		options = [
			{code = 'spring_heal', reqs = [], text = tr("SPRING_HEAL_OPTION"), dialogue_argument = 1},
			{code = 'spring_stamina', reqs = [], text = tr("SPRING_STAMINA_OPTION"), dialogue_argument = 1},
			{code = 'close', reqs = [], text = "DIALOGUECANCEL"}
		]
		}]},
	spring_heal = {
		text = tr("SPRING_HEAL"),
		tags = [],
		image = 'spring',
		bonus_effects = [{code = 'affect_active_party', type = 'damage_percent', value = -33}],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]}
		],
	},
	spring_stamina = {
		text = tr("SPRING_STAMINA"),
		tags = [],
		image = 'spring',
		bonus_effects = [{code = 'add_stamina', value = 50}],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]}
		],
	},
	spring_loot = {
		variations = [
			{reqs = [{type = 'random', value = 100}],
			text = tr("DIALOGUE_SPRING_LOOT"),
			image = 'spring',
			default_event_type = "custom_event",
			common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['easy_prisoner_reward_resource',1]] }],
			tags = [''],
			options = [
				{code = 'open_chest', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'advance_location'}]},
				]
			},
			{reqs = [],
			text = tr("DIALOGUE_SPRING_NO_LOOT"),
			image = 'spring',
			default_event_type = "custom_event",
			common_effects = [],
			tags = [''],
			options = [
				{code = 'leave', text = tr("DIALOGUELEAVE"), reqs = []},
				],

			}
		]},

	event_tribal_elves = {text = tr("TRIBALELVES"),
		args = {},
		tags = [],
		image = 'tribal_elves',
		set_enemy = 'tribal_elves',
		options = [
		{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION"), bonus_effects = [{code = 'clear_subroom'}]},
		]
	},
	tribal_elves_win = {text = tr("TRIBALELVES_WIN"),
	args = {},
	tags = [''],
	common_effects = [
		{code = 'make_scene_character',
			value = [
			{type = 'function', function = 'make_local_recruit',
				args = {
					races = [['TribalElf', 1]],
					}
			}
			],
		}
	],
	image = 'slave_decision',
	options = [
	{code = 'recruit_from_scene', reqs = [], text = tr("DIALOGUEKEEPSLAVEPERSON")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE")},
	]
	},
	
	fountain = {
		text = tr("FOUNTAINTEXT"),
		tags = ['dialogue_scene'],
		image = 'spring',
		options = [
			{code = 'fountain_stamina', reqs = [], text = tr("FOUNTAINSTAMINAOPTION"), dialogue_argument = 1},
			{code = 'fountain_mana', reqs = [], text = tr("FOUNTAINMANAOPTION"), dialogue_argument = 2},
			{code = 'close', reqs = [], text = "DIALOGUECANCEL"}
		]
	},
	
	
	fountain_stamina = {
		text = tr("FOUNTAIN_STAMINA"),
		tags = [],
		image = 'spring',
		bonus_effects = [{code = 'add_stamina', value = 50}],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]}
		],
	},
	fountain_mana = {
		text = tr("FOUNTAIN_MANA"),
		tags = [],
		image = 'spring',
		bonus_effects = [{code = 'affect_active_party', type = 'damage_mana_percent', value = -40}],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]}
		],
	},
	
	event_trap_easy = {text = tr("DIALOGUEEVENTTRAP"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_trap_discount', select_person = true, reqs = [], text = tr("DIALOGUEACTIVATETRAP")},
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 10}], text = tr("DIALOGUEPASSTRAP")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	reveal_map = {
		text = tr("REVEAL_MAP"),
		tags = ['active_character_translate'],
		image = 'dungeon_magic_barrier',
		bonus_effects = [],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE", bonus_effects = []}
		],
	},
	dungeon_intimidate = {
		text = tr("DUNGEON_INTIMIDATE"),
		tags = [],
		image = 'dungeon_magic_barrier',
		bonus_effects = [],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE", bonus_effects = []}
		],
	},
	dungeon_teleporter = {
		text = tr("DUNGEON_TELEPORTER"),
		tags = [],
		image = 'dungeon_magic_barrier',
		bonus_effects = [],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE", bonus_effects = []}
		],
	},
	
	character_lovers = {
		text = tr("CHARLOVERS"),
		tags = ['dialogue_scene', 'active_character_translate', 'scene_character_translate'],
		image = 'praise',
		options = [
			{code = 'character_lovers_allow', reqs = [], text = tr("CHARLOVERSALLOW"), dialogue_argument = 1},
			{code = 'close', reqs = [], text = tr("CHARLOVERSFORBID"), dialogue_argument = 2},
		]
	},
	
	character_lovers_allow = {
		text = tr("FOUNTAIN_STAMINA"),
		tags = ['active_character_translate', 'scene_character_translate'],
		image = 'praise',
		bonus_effects = [],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'change_relationship', value = 'lovers'}]}
		],
	},
	character_freelovers = {
		text = tr("CHARFREELOVERS"),
		tags = ['dialogue_scene', 'active_character_translate', 'scene_character_translate'],
		image = 'praise',
		options = [
			{code = 'character_freelovers_allow', reqs = [], text = tr("CHARFREELOVERSALLOW"), dialogue_argument = 1},
			{code = 'close', reqs = [], text = tr("CHARLOVERSFORBID"), dialogue_argument = 2},
		]
	},
	
	character_freelovers_allow = {
		text = tr("FOUNTAIN_STAMINA"),
		tags = ['active_character_translate', 'scene_character_translate'],
		image = 'praise',
		bonus_effects = [],
		options = [
		{code = 'leave', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'change_relationship', value = 'freelovers'}]}
		],
	},
	breakdown_event = {
		text = '',
		image = 'abuse',
		tags = ["dialogue_scene", "active_character_translate"],
		options = [
			{code = "close", text = "DIALOGUECLOSE", type = "next_dialogue", reqs = []}
		]
	},
	
	
	
#	activate_trap_easy = {
#		variations = [
#			{reqs = [{type = 'active_character_checks', value = [{code = 'trait', trait = 'trap_detection', check = true}]},
#			],
#			text = tr("DIALOGUEEVENTTRAPSUCCESS"),
#			common_effects = [{code = 'affect_active_character', type = 'stat', stat = 'wits', value = 3}],
#			tags = ['active_character_translate'],
#			image = '',
#			options = [
#				{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'advance_location'}]},
#				]
#			},
#			{reqs = [],
#			text = tr("DIALOGUEEVENTTRAPFAILURE"),
#			image = '',
#			common_effects = [{code = "affect_active_character", type = 'damage_percent', value = 20}, {code = 'update_party'}],
#			tags = ['active_character_translate'],
#			options = [
#				{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'advance_location'}]},
#				],
#
#			}
#		],
#	},
	
}

var dialogue_inits = {
	fighters_init = [
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'dialogue_seen', check = false, value = 'FIGHTERSINTRODUCTION1'}],
			target = 'fighters_introduction1',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'lead_convoy_quest', stage = 'stage2'}],
			target = 'duncan_not_found',
			target_option = 2,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'princess_search', stage = 'stage4'}],
			target = 'capture_wrapup_start',
			target_option = 0,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'princess_search', stage = 'stage5'}],
			target = 'capture_wrapup_start',
			target_option = 0,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'final_operation', stage = 'stage1'}],
			target = 'final_operation_start',
			target_option = 0,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'princess_search', stage = 'stage1'}],
			target = 'looking_for_princess_1',
			target_option = 3,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}],
			target = 'fighters_introduction2',
			target_option = 4,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [
				{type = 'active_quest_stage', value = 'anastasia_quest_2', stage = 'stage13'}
			],
			target = 'ana_final_1',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [],
			target = 'fighters_introduction2',
			target_option = 5,
		},
	],
	fighters_sap = [
		{
			code = 'default',
			name = tr("DIALOGUE_SACRED_SAP_FIGHTER_GUILD"),
			reqs = [
				{type = 'active_quest_stage', value = 'hara_scales_quest', stage = 'h_scouts'}
			],
			target = 'sacred_sap_fighters_start',
			target_option = 0,
		},
		{
			code = 'default',
			name = tr("DIALOGUE_SACRED_SAP_FIGHTER_GUILD"),
			reqs = [
				{type = 'active_quest_stage', value = 'hara_scales_quest', stage = 'h_price'}
			],
			target = 'sacred_sap_fighters_3',
			target_option = 1,
		},
	],
	servants_init = [
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'princess_search', stage = 'stage2'}, {type = 'dialogue_seen', check = false, value = 'AMELIA_BONUS_QUESTION'}],
			target = 'amelia_bonus_question',
			target_option = 0,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"), #or not
			reqs = [{type = "active_quest_stage", value = "amelia_main_quest", stage = "stage0"}],
			target = 'amelia_main_guild_1',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"), #or not
			reqs = [{type = "any_quest_stage", value = "amelia_main_quest", stages = ["stage1","stage2","stage3","stage4","stage5","stage6","stage7"]}],
			target = 'amelia_main_interlude',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"), #or not
			reqs = [{type = "active_quest_stage", value = "amelia_main_quest", stage = "stage8"}],
			target = 'amelia_interlude2_1',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"), #or not
			reqs = [{type = "active_quest_stage", value = "amelia_main_quest", stage = "stage9"}],
			target = 'amelia_interlude4',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"), #or not
			reqs = [{type = "active_quest_stage", value = "amelia_main_quest", stage = "stage10"}],
			target = 'amelia_interlude3_1',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = "active_quest_stage", value = "amelia_main_quest", stage = "stage11"}],
			target = 'servants_introduction_new_leader',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'quest_completed', check = true, name = 'amelia_main_quest'},
			{type = 'decision', value = 'ReturnAmelia', check = false}],
			target = 'servants_introduction_new_leader',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'dialogue_seen', check = false, value = 'AMELIA_GREETING_AFTER_RETURN'},
			{type = 'decision', value = 'ReturnAmelia', check = true}],
			target = 'servants_introduction',
			target_option = 5,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'dialogue_seen', check = false, value = 'SERVANTSINTRODUCTION1'}],
			target = 'servants_introduction',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'faction_reputation', code = 'servants', operant = 'gte', value = 1000}, {type = 'dialogue_seen', check = false, value = 'AMELIA_SILK_STARTUP'}],
			target = 'amelia_silk_start',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = "active_quest_stage", value = "guilds_introduction", stage = "stage0"}],
			target = 'servants_introduction',
			target_option = 2,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = "active_quest_stage", value = "guilds_introduction", stage = "stage2"}],
			target = 'elections_start1',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [],
			target = 'servants_introduction',
			target_option = 3,
		},

	],
	workers_init = [
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'dialogue_seen', check = false, value = 'WORKERSINTRODUCTION1'}],
			target = 'workers_introduction1',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'lilia_finale_quest', stage = 'stage1'}],
			target = 'lilia_finale_2',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}],
			target = 'workers_introduction2',
			target_option = 3,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [],
			target = 'workers_introduction2',
			target_option = 4,
		},
	],
	workers_limnrov = [
		{
			code = 'default',
			name = tr("LIMNROV_OPTION_GUILD"),
			reqs = [{type = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage2'}],
			target = 'cali_act2_workers_2',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("LIMNROV_OPTION_GUILD"),
			reqs = [{type = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage3'}],
			target = 'cali_act2_limnrov',
			target_option = 1,
		},
	],
	mages_init = [
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'kuro_tome_quest', stage = 'library'}],
			target = 'kuro_lib_start',
			target_option = 9,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'kuro_tome_quest', stage = 'money'}],
			target = 'kuro_lib_return',
			target_option = 9,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'kuro_tome_quest', stage = 'back'}],
			target = 'kuro_lib_whiskey',
			target_option = 9,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'civil_war_start', stage = 'stage1'}],
			target = 'mages_after_election',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage6'}],
			target = 'cali_act3_mages_1',
			target_option = 1,
		},
#		{
#			code = 'default',
#			name = tr("DIALOGUEMEETLEADER"),
#			reqs = [{type = 'dialogue_seen', check = false, value = 'JEAN_INTRO'}, {type = 'decision', value = 'mayor_election_finished', check = true}],
#			target = 'jean_intro',
#			target_option = 1,
#		},
		{
			code = 'default',
			name = "Talk To Apprentice",
			reqs = [{type = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage8'}],
			target = 'cali_act3_mages_2',
			target_option = 3,
		},
		#fred_return_to_myr_1
#		{
#			code = 'default',
#			name = "Ask for Help",
#			reqs = [{type = 'dialogue_seen', check = true, value = 'FINAL_OPERATON_START'}, {type = 'dialogue_seen', check = false, value = 'INITIATE_HIDEOUT_ATTACK_1'}],
#			target = 'final_operation_mages_1',
#			target_option = 1,
#		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'dialogue_seen', check = false, value = 'MAGESINTRODUCTION1'}],
			target = 'mages_introduction1',
			target_option = 1,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}],
			target = 'mages_introduction3',
			target_option = 2,
		},
		{
			code = 'default',
			name = tr("DIALOGUEMEETLEADER"),
			reqs = [],
			target = 'mages_introduction3',
			target_option = 2,
		},
	],
	
	savra_init = [
		{
			code = 'default',
			name = "Talk To Savra",
			reqs = [],
			target = 'mages_after_election',
			target_option = 1,
		},
	],
}

var dict = {
MAIN_QUEST_LOAN_SUMMARY = "Your mansion comes with a loan. You must find a money to pay to the bank or you'll be thrown out of your newly acquired home. ",
MAIN_QUEST_LOAN_STAGE0 = 'You must have over {custom_text_function=GetLoanSum#0|} gold by {custom_text_function=GetLoanDay#0|}th day.',
MAIN_QUEST_LOAN_STAGE1 = 'By {custom_text_function=GetLoanDay#1|}th day have at least {custom_text_function=GetLoanSum#1|} gold.',
MAIN_QUEST_LOAN_STAGE2 = 'By {custom_text_function=GetLoanDay#2|}th day have at least {custom_text_function=GetLoanSum#2|} gold.',
MAIN_QUEST_LOAN_STAGE3 = 'By {custom_text_function=GetLoanDay#3|}th day have at least {custom_text_function=GetLoanSum#3|} gold.',
MAIN_QUEST_LOAN_NAME = 'The Loan',


}
var quests = {
	main_quest_loan = {
		code = 'main_quest_loan',
		summary = "MAIN_QUEST_LOAN_SUMMARY",
		stages = {
		stage0 = {code = 'start', name = 'MAIN_QUEST_LOAN_NAME', descript = 'MAIN_QUEST_LOAN_STAGE0'},
		stage1 = {code = 'stage1', name = 'MAIN_QUEST_LOAN_NAME', descript = 'MAIN_QUEST_LOAN_STAGE1'},
		stage2 = {code = 'stage2', name = 'MAIN_QUEST_LOAN_NAME', descript = 'MAIN_QUEST_LOAN_STAGE2'},
		stage3 = {code = 'stage3', name = 'MAIN_QUEST_LOAN_NAME', descript = 'MAIN_QUEST_LOAN_STAGE3'},
		},
	},

	guilds_introduction = {
		code = 'guilds_introduction',
		summary = "GUILDS_INTRODUCTION_SUMMARY",
		stages = {
		start = {code = 'start', name = 'GUILDS_INTRODUCTION_NAME1', descript = 'GUILDS_INTRODUCTION_STAGE0'},
		stage1 = {code = 'stage1', name = 'GUILDS_INTRODUCTION_NAME2', descript = "GUILDS_INTRODUCTION_STAGE1"},
		stage1_5 = {code = 'stage1_5', name = 'GUILDS_INTRODUCTION_NAME2', descript = "GUILDS_INTRODUCTION_STAGE1_5"},
		stage2 = {code = 'stage2', name = 'GUILDS_INTRODUCTION_NAME3', descript = "GUILDS_INTRODUCTION_STAGE2"},
		},
	},

	fighters_election_quest = {
		code = 'fighters_election_quest',
		summary = "FIGHTERS_ELECTION_SUMMARY",
		stages = {
			start = {code = 'start', name = "FIGHTERS_ELECTION_NAME", descript = "FIGHTERS_ELECTION_STAGE_1"},
			stage2 = {code = 'stage2', name = "FIGHTERS_ELECTION_NAME", descript = "FIGHTERS_ELECTION_STAGE_2"}
		},
	},

	mages_election_quest = {
		code = 'mages_election_quest',
		summary = "MAGES_ELECTION_SUMMARY",
		stages = {
			start = {code = 'start', name = "MAGES_ELECTION_NAME", descript = "MAGES_ELECTION_STAGE_1"},
			stage1 = {code = 'stage1', name = "MAGES_ELECTION_NAME", descript = "MAGES_ELECTION_STAGE_2"},
			stage2 = {code = 'stage2', name = "MAGES_ELECTION_NAME", descript = "MAGES_ELECTION_STAGE_3"},
		},
	},

	workers_election_quest = {
		code = 'workers_election_quest',
		summary = "WORKERS_ELECTION_SUMMARY",
		stages = {
			start = {code = 'start', name = "WORKERS_ELECTION_NAME", descript = "WORKERS_ELECTION_STAGE_1"},
			stage1 = {code = 'stage1', name = "WORKERS_ELECTION_NAME", descript = "WORKERS_ELECTION_STAGE_2"},
			stage2 = {code = 'stage2', name = "WORKERS_ELECTION_NAME", descript = "WORKERS_ELECTION_STAGE_3"},
			stage3 = {code = 'stage3', name = "WORKERS_ELECTION_NAME", descript = "WORKERS_ELECTION_STAGE_4"},
		},
	},

	election_global_quest = {
		code = 'election_global_quest',
		summary = "ELECTION_GLOBAL_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = 'ELECTION_GLOBAL_NAME', descript = "ELECTION_GLOBAL_STAGE_1"},
		},
	},

	aliron_church_quest = {
		code = 'aliron_church_quest',
		summary = "ALIRON_CHURCH_SUMMARY",
		stages = {
			#start = {code ='start', name = 'Church Quest Name1', descript = "Church Quest Descript1"},
			stage1 = {code ='stage1', name = 'ALIRON_CHURCH_NAME', descript = "ALIRON_CHURCH_STAGE_1"},
			#stage2 = {code ='stage2', name = 'Church Quest Name3', descript = "Church Quest Descript3"},
		},
	},


	civil_war_start = {
		code = 'civil_war_start',
		summary = "CIVIL_WAR_START_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = 'CIVIL_WAR_START_NAME', descript = "CIVIL_WAR_START_STAGE_1"},
			stage2 = {code = 'stage2', name = 'CIVIL_WAR_START_NAME', descript = "CIVIL_WAR_START_STAGE_2"},
			stage3 = {code = 'stage3', name = 'CIVIL_WAR_START_NAME', descript = "CIVIL_WAR_START_STAGE_3"},
			stage4 = {code = 'stage4', name = 'CIVIL_WAR_START_NAME', descript = "CIVIL_WAR_START_STAGE_4"},
			stage5 = {code = 'stage5', name = 'CIVIL_WAR_START_NAME', descript = "CIVIL_WAR_START_STAGE_5"},
		}
	},

	civil_war_mines = {
		code = "civil_war_mines",
		summary = "CIVIL_WAR_MINES_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = 'CIVIL_WAR_MINES_NAME', descript = "CIVIL_WAR_MINES_STAGE_1"},
			stage2 = {code = 'stage2', name = 'CIVIL_WAR_MINES_NAME', descript = "CIVIL_WAR_MINES_STAGE_2"},
			stage3 = {code = 'stage3', name = 'CIVIL_WAR_MINES_NAME', descript = "CIVIL_WAR_MINES_STAGE_3"},
			stage4 = {code = 'stage4', name = 'CIVIL_WAR_MINES_NAME', descript = "CIVIL_WAR_MINES_STAGE_4"},
		},
	},

	lead_convoy_quest = {
		code = 'lead_convoy_quest',
		summary = "LEAD_CONVOY_SUMMARY",
		stages = {
			stage1 = {code ='stage1', name = 'LEAD_CONVOY_NAME', descript = """LEAD_CONVOY_STAGE_1"""},#in case player did not pick the mission instantly
			stage2 = {code = 'stage2', name = 'LEAD_CONVOY_NAME', descript = """LEAD_CONVOY_STAGE_2"""},
			stage3 = {code = 'stage3', name = 'LEAD_CONVOY_NAME', descript = """LEAD_CONVOY_STAGE_3"""},
		},
	},

	divine_symbol_quest = {
		code = 'divine_symbol_quest',
		summary = "DIVINE_SYMBOL_SUMMARY",
		stages = {
			stage1 = {code ='stage1', name = 'DIVINE_SYMBOL_NAME', descript = """DIVINE_SYMBOL_STAGE_1"""},
			stage2 = {code ='stage2', name = 'DIVINE_SYMBOL_NAME', descript = """DIVINE_SYMBOL_STAGE_2"""},
			stage3 = {code ='stage3', name = 'DIVINE_SYMBOL_NAME', descript = """DIVINE_SYMBOL_STAGE_3"""},
			stage4 = {code ='stage4', name = 'DIVINE_SYMBOL_NAME', descript = """DIVINE_SYMBOL_STAGE_4"""},
		},
	},

	final_operation = {
		code = 'final_operation',
		summary = "FINAL_OPERATION_SUMMARY",
		stages = {
			stage0 = {code = 'stage0', name = 'FINAL_OPERATION_NAME', descript = """FINAL_OPERATION_STAGE_0"""},
			stage1 = {code ='stage1', name = 'FINAL_OPERATION_NAME', descript = """FINAL_OPERATION_STAGE_1"""},
			stage2 = {code = 'stage2', name = 'FINAL_OPERATION_NAME', descript = """FINAL_OPERATION_STAGE_2"""},
		},
	},

	princess_search = {
		code = 'princess_search',
		summary = "PRINCESS_SEARCH_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = 'PRINCESS_SEARCH_NAME', descript = """PRINCESS_SEARCH_STAGE_1"""},
			stage2 = {code = 'stage2', name = 'PRINCESS_SEARCH_NAME', descript = """PRINCESS_SEARCH_STAGE_2"""},
			stage3 = {code = 'stage3', name = 'PRINCESS_SEARCH_NAME', descript = """PRINCESS_SEARCH_STAGE_3"""},
			stage4 = {code = 'stage4', name = 'PRINCESS_SEARCH_NAME', descript = """PRINCESS_SEARCH_STAGE_4"""},#if princess was killed
			stage5 = {code = 'stage5', name = 'PRINCESS_SEARCH_NAME', descript = """PRINCESS_SEARCH_STAGE_5"""},
		},
	},

	princess_persuasion = {
		code = 'princess_persuasion',
		summary = "PRINCESS_PERSUASION_SUMMARY",
		stages = {
			stage1 = {code ='stage1', name = 'PRINCESS_PERSUASION_NAME', descript = """PRINCESS_PERSUASION_STAGE_1"""},
		},
	},

	final_words = {
		code = 'final_words',
		summary = "FINAL_WORDS_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "FINAL_WORDS_NAME", descript = ""}
		},
	},

	daisy_clothes = {
		code = 'daisy_clothes',
		summary = "DAISY_CLOTHES_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "DAISY_CLOTHES_NAME", descript = "DAISY_CLOTHES_STAGE_1"},
			stage2 = {code = 'stage2', name = "DAISY_CLOTHES_NAME", descript = "DAISY_CLOTHES_STAGE_2"},
			stage3 = {code = 'stage3', name = "DAISY_CLOTHES_NAME", descript = "DAISY_CLOTHES_STAGE_3"}
		},
	},

	daisy_training = {
		code = 'daisy_training',
		summary = "DAISY_TRAINING_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "DAISY_TRAINING_NAME", descript = "DAISY_TRAINING_STAGE_1"}, # send her to training
			stage2 = {code = 'stage2', name = "DAISY_TRAINING_NAME", descript = "DAISY_TRAINING_STAGE_2"} # wait until training finished
		},
	},

	daisy_lost = {
		code = 'daisy_lost',
		summary = "DAISY_LOST_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "DAISY_LOST_NAME", descript = "DAISY_LOST_STAGE_1"}, # you should visit Amelia
			stage2 = {code = 'stage2', name = "DAISY_LOST_NAME", descript = "DAISY_LOST_STAGE_2"}, # travel to this guys location
		},
	},

	amelia_silk_quest = {
		code = 'amelia_silk_quest',
		summary = "AMELIA_SILK_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "AMELIA_SILK_NAME", descript = "AMELIA_SILK_STAGE_1"}, # bring 50 silk
		},
	},

	amelia_herbs_quest = {
		code = 'amelia_herbs_quest',
		summary = "AMELIA_HERBS_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "AMELIA_HERBS_NAME", descript = "AMELIA_HERBS_STAGE_1"}, # go to Amelia
			stage2 = {code = 'stage2', name = "AMELIA_HERBS_NAME", descript = "AMELIA_HERBS_STAGE_2"}, # get herbs
			stage3 = {code = 'stage3', name = "AMELIA_HERBS_NAME", descript = "AMELIA_HERBS_STAGE_3"}, # return to Amelia
		},
	},
	
	marriage_quest_main = {
		code = 'marriage_quest_main',
		summary = "MARRIAGE_MAIN_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "MARRIAGE_MAIN_NAME", descript = "MARRIAGE_MAIN_STAGE_1"},
			stage2 = {code = 'stage2', name = "MARRIAGE_MAIN_NAME", descript = "MARRIAGE_MAIN_STAGE_2"},
		},
	},
	
	marriage_quest_servants = {
		code = 'marriage_quest_servants',
		summary = "MARRIAGE_SERVANTS_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "MARRIAGE_SERVANTS_NAME", descript = "MARRIAGE_SERVANTS_STAGE_1"},
		},
	},
	
	marriage_quest_workers = {
		code = 'marriage_quest_workers',
		summary = "MARRIAGE_WORKERS_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "MARRIAGE_WORKERS_NAME", descript = "MARRIAGE_WORKERS_STAGE_1"},
		},
	},
	
	gryphon_quest = {
		code = 'gryphon_quest',
		summary = "GRYPHON_QUEST_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "GRYPHON_QUEST_NAME", descript = "GRYPHON_QUEST_STAGE_1"}, # talk to sigmund
			stage2 = {code = 'stage2', name = "GRYPHON_QUEST_NAME", descript = "GRYPHON_QUEST_STAGE_2"}, # talk to derek
			stage3 = {code = 'stage3', name = "GRYPHON_QUEST_NAME", descript = "GRYPHON_QUEST_STAGE_3"}, # go in forest
			stage4 = {code = 'stage4', name = "GRYPHON_QUEST_NAME", descript = "GRYPHON_QUEST_STAGE_4"}, # go in cave
		},
	},
	
	pre_sword_artifact_quest = {
		code = 'pre_sword_artifact_quest',
		summary = "PRE_SWORD_ARTIFACT_QUEST_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "PRE_SWORD_ARTIFACT_QUEST_NAME", descript = "PRE_SWORD_ARTIFACT_QUEST_STAGE_1"}, # visit ginny and recruit zephyra
		},
	},

	sword_artifact_quest = {
		code = 'sword_artifact_quest',
		summary = "SWORD_ARTIFACT_QUEST_SUMMARY",
		stages = { # don't mind stages not corresponding it's all good
			stage2 = {code = 'stage2', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_2"}, # go to elven capital and talk to High Priestess
			stage3 = {code = 'stage3', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_3"}, # go to beastkin tribe location (first Eleron talk)
			stage4 = {code = 'stage4', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_4"}, # visit Lodge 
			stage5 = {code = 'stage5', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_5"}, # bring supplys to Savra
			stage6 = {code = 'stage6', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_6"}, # wait a day and go to Savra
			stage7 = {code = 'stage7', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_7"}, # go to a new location
			stage77 = {code = 'stage77', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_77"}, # go to a new location
			stage8 = {code = 'stage8', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_8"}, # visit leon
			stage9 = {code = 'stage9', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_8"}, # ask around
			stage10 = {code = 'stage10', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_9"}, # look for leon at a new location
			stage11 = {code = 'stage11', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_10"}, # talk to savra
			stage12 = {code = 'stage12', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_11"}, # bring materials to savra
			stage13 = {code = 'stage13', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_12"}, # bring someone magical to savra
			stage14 = {code = 'stage14', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_13"}, # go find leon
			stage15 = {code = 'stage15', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_14"}, # go to white stag location
			stage16 = {code = 'stage16', name = "SWORD_ARTIFACT_QUEST_NAME", descript = "SWORD_ARTIFACT_QUEST_STAGE_15"}, # return to erlen after you're done with temple quest
		},
	},
	
	temple_quest = {
		code = 'temple_quest',
		summary = "TEMPLE_QUEST_SUMMARY",
		stages = {
#			stage1 = {code = 'stage1', name = "TEMPLE_QUEST_NAME", descript = "TEMPLE_QUEST_STAGE_1"}, # visit erlen
			stage1 = {code = 'stage1', name = "TEMPLE_QUEST_NAME", descript = "TEMPLE_QUEST_STAGE_1"}, # get water
#			stage3 = {code = 'stage3', name = "TEMPLE_QUEST_NAME", descript = "TEMPLE_QUEST_STAGE_3"}, # finish temple
			stage2 = {code = 'stage2', name = "TEMPLE_QUEST_NAME", descript = "TEMPLE_QUEST_STAGE_2"}, # return to priestess
			
#			stage5 = {code = 'stage5', name = "TEMPLE_QUEST_NAME", descript = "TEMPLE_QUEST_STAGE_5"}, # find Erlen
#			stage6 = {code = 'stage6', name = "TEMPLE_QUEST_NAME", descript = "TEMPLE_QUEST_STAGE_6"}, # talk to Lira
#			stage7 = {code = 'stage7', name = "TEMPLE_QUEST_NAME", descript = "TEMPLE_QUEST_STAGE_7"}, # get elf to Lira
#			stage8 = {code = 'stage8', name = "TEMPLE_QUEST_NAME", descript = "TEMPLE_QUEST_STAGE_8"}, # get whiskey to Lira
#			stage9 = {code = 'stage9', name = "TEMPLE_QUEST_NAME", descript = "TEMPLE_QUEST_STAGE_9"}, # meet erlen on his location
		}
	},
	
	getting_lira_quest = { # arc2 act2 final quest
		code = 'getting_lira_quest',
		summary = "GETTING_LIRA_QUEST_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "GETTING_LIRA_QUEST_NAME", descript = "GETTING_LIRA_QUEST_STAGE_1"}, # find Erlen
			stage2 = {code = 'stage2', name = "GETTING_LIRA_QUEST_NAME", descript = "GETTING_LIRA_QUEST_STAGE_2"}, # find Lira
			stage3 = {code = 'stage3', name = "GETTING_LIRA_QUEST_NAME", descript = "GETTING_LIRA_QUEST_STAGE_3"}, # get whiskey to Lira optional
			stage4 = {code = 'stage4', name = "GETTING_LIRA_QUEST_NAME", descript = "GETTING_LIRA_QUEST_STAGE_4"}, # go back to erlen
			stage5 = {code = 'stage5', name = "GETTING_LIRA_QUEST_NAME", descript = "GETTING_LIRA_QUEST_STAGE_5"}, # return to Elf Capital
		},
	},
	
	cali_fighters_quest = {
		code = 'cali_fighters_quest',
		summary = "CALI_FIGHTERS_QUEST_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "CALI_FIGHTERS_QUEST_NAME", descript = "CALI_FIGHTERS_QUEST_STAGE_1"}, # go to fighters
			stage2 = {code = 'stage2', name = "CALI_FIGHTERS_QUEST_NAME", descript = "CALI_FIGHTERS_QUEST_STAGE_2"}, # searh surroundings
			stage3 = {code = 'stage3', name = "CALI_FIGHTERS_QUEST_NAME", descript = "CALI_FIGHTERS_QUEST_STAGE_3"}, # report 
		},
	},
	
	cali_servants_quest = {
		code = 'cali_servants_quest',
		summary = "CALI_SERVANTS_QUEST_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "CALI_SERVANTS_QUEST_NAME", descript = "CALI_SERVANTS_QUEST_STAGE_1"}, # go to servants

		},
	},
	
	cali_heirloom_quest = {
		code = 'cali_heirloom_quest',
		summary = "CALI_HEIRLOOM_QUEST_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "CALI_HEIRLOOM_QUEST_NAME", descript = "CALI_HEIRLOOM_QUEST_STAGE_1"}, # go to village
			stage2 = {code = 'stage2', name = "CALI_HEIRLOOM_QUEST_NAME", descript = "CALI_HEIRLOOM_QUEST_STAGE_2"}, # get enough wood
			stage2_1 = {code = 'stage2_1', name = "CALI_HEIRLOOM_QUEST_NAME", descript = "CALI_HEIRLOOM_QUEST_STAGE_2_1"}, # get enough wood discount # if needed
			stage3 = {code = 'stage3', name = "CALI_HEIRLOOM_QUEST_NAME", descript = "CALI_HEIRLOOM_QUEST_STAGE_3"}, # bandits
			stage4 = {code = 'stage4', name = "CALI_HEIRLOOM_QUEST_NAME", descript = "CALI_HEIRLOOM_QUEST_STAGE_4"}, # find collector
			stage5 = {code = 'stage5', name = "CALI_HEIRLOOM_QUEST_NAME", descript = "CALI_HEIRLOOM_QUEST_STAGE_5"}, # rise position
			stage5_1 = {code = 'stage5_1', name = "CALI_HEIRLOOM_QUEST_NAME", descript = "CALI_HEIRLOOM_QUEST_STAGE_5_1"}, # william met
			stage6 = {code = 'stage6', name = "CALI_HEIRLOOM_QUEST_NAME", descript = "CALI_HEIRLOOM_QUEST_STAGE_6"}, # get sword from william
			stage7 = {code = 'stage7', name = "CALI_HEIRLOOM_QUEST_NAME", descript = "CALI_HEIRLOOM_QUEST_STAGE_7"}, # wait for cali to return
			stage8 = {code = 'stage8', name = "CALI_HEIRLOOM_QUEST_NAME", descript = "CALI_HEIRLOOM_QUEST_STAGE_8"}, # sword get
			stage9 = {code = 'stage9', name = "CALI_HEIRLOOM_QUEST_NAME", descript = "CALI_HEIRLOOM_QUEST_STAGE_9"}, # speek with cali
			stage10 = {code = 'stage10', name = "CALI_HEIRLOOM_QUEST_NAME", descript = "CALI_HEIRLOOM_QUEST_STAGE_10"}, # go to village
		},
	},
	
	lilia_meet_quest = {
		code = "lilia_meet_quest",
		summary = "LILIA_MEET_QUEST_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "LILIA_MEET_QUEST_NAME", descript = "LILIA_MEET_QUEST_STAGE_1"}, # talk to Myr
			stage2 = {code = 'stage2', name = "LILIA_MEET_QUEST_NAME", descript = "LILIA_MEET_QUEST_STAGE_2"}, # go to Xari
		},
		
	},
	
	sick_lilia_quest = {
		code = 'sick_lilia_quest',
		summary = "SICK_LILIA_QUEST_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "SICK_LILIA_QUEST_NAME", descript = "SICK_LILIA_QUEST_STAGE_1"}, # talk to Myr
			stage2 = {code = 'stage2', name = "SICK_LILIA_QUEST_NAME", descript = "SICK_LILIA_QUEST_STAGE_2"}, # go to Xari
			stage3 = {code = 'stage3', name = "SICK_LILIA_QUEST_NAME", descript = "SICK_LILIA_QUEST_STAGE_3"}, # find troll
			stage35 = {code = 'stage35', name = "SICK_LILIA_QUEST_NAME", descript = "SICK_LILIA_QUEST_STAGE_35"}, # get clothes from troll
			stage4 = {code = 'stage4', name = "SICK_LILIA_QUEST_NAME", descript = "SICK_LILIA_QUEST_STAGE_4"}, # return to Xari
			stage5 = {code = 'stage5', name = "SICK_LILIA_QUEST_NAME", descript = "SICK_LILIA_QUEST_STAGE_5"}, # bring potion to Lilia
		},
	},
	
	cali_taming_quest = {
		code = 'cali_taming_quest',
		summary = "CALI_TAMING_QUEST_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_1"}, # ask at workers guild about custom collar
			stage2 = {code = 'stage2', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_2"}, # ask Limnrov about collar
			stage3 = {code = 'stage3', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_3"}, # talk to Limnrov about collar
			stage4 = {code = 'stage4', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_4"}, # wait for courier with collar
			stage5 = {code = 'stage5', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_5"}, # wait for act 2
			stage6 = {code = 'stage6', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_6"}, # ask Mages about Cali or talk to Jean (go to dungeon)
			stage7 = {code = 'stage7', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_7"}, # Talk to Jean
			stage8 = {code = 'stage8', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_8"}, # return to apprentince
			stage9 = {code = 'stage9', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_9"}, # Wait 2 days
			stage10 = {code = 'stage10', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_10"}, # Talk to Cali
			stage11 = {code = 'stage11', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_11"}, # wait for act 3
			stage12 = {code = 'stage12', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_12"}, # visit merchant
			stage13 = {code = 'stage13', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_13"}, # return to merchant
			stage14 = {code = 'stage14', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_14"},  # wait for act 4
			stage15 = {code = 'stage15', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_15"},  # visit pet shop
			stage16 = {code = 'stage16', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_16"},  # talk to Сali
			stage17 = {code = 'stage17', name = "CALI_TAMING_QUEST_NAME", descript = "CALI_TAMING_QUEST_STAGE_17"},  # talk to Сali tomorrow (kinda bad)
		},
	},
	
	zephyra_bath_quest = {
		code = "zephyra_bath_quest",
		summary = "ZEPHYRA_BATH_QUEST_SUMMARY",
		stages = {
			stage0 = {code = 'stage0', name = "ZEPHYRA_BATH_QUEST_NAME", descript = "ZEPHYRA_BATH_QUEST_STAGE_0"}, # stand in for ginny while she's away
			stage1 = {code = 'stage1', name = "ZEPHYRA_BATH_QUEST_NAME", descript = "ZEPHYRA_BATH_QUEST_STAGE_1"}, # build and visit bath
			stage2 = {code = 'stage2', name = "ZEPHYRA_BATH_QUEST_NAME", descript = "ZEPHYRA_BATH_QUEST_STAGE_2"}, # visit bath
		},
	},
	
	goblin_quest = {
		code = "goblin_quest",
		summary = "GOBLIN_QUEST_SUMMARY",
		stages = {
			stage0 = {code = 'stage0', name = "GOBLIN_QUEST_NAME", descript = "GOBLIN_QUEST_STAGE_0"}, # talk to savra
			stage1 = {code = 'stage1', name = "GOBLIN_QUEST_NAME", descript = "GOBLIN_QUEST_STAGE_1"}, # go to location
			stage2 = {code = 'stage2', name = "GOBLIN_QUEST_NAME", descript = "GOBLIN_QUEST_STAGE_2"}, # search for tracks
			stage3 = {code = 'stage3', name = "GOBLIN_QUEST_NAME", descript = "GOBLIN_QUEST_STAGE_3"}, # go to sigmund
			stage4 = {code = 'stage4', name = "GOBLIN_QUEST_NAME", descript = "GOBLIN_QUEST_STAGE_4"}, # return to find goblins
			stage5 = {code = 'stage5', name = "GOBLIN_QUEST_NAME", descript = "GOBLIN_QUEST_STAGE_5"}, # go to white stag
		},
	},
	
	zephyra_disappearance_quest = {
		code = "zephyra_disappearance_quest",
		summary = "ZEPHYRA_DISAPPEARANCE_QUEST_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = "ZEPHYRA_DISAPPEARANCE_QUEST_NAME", descript = "ZEPHYRA_DISAPPEARANCE_QUEST_STAGE_1"}, # search for Zephyra
			stage2 = {code = 'stage2', name = "ZEPHYRA_DISAPPEARANCE_QUEST_NAME", descript = "ZEPHYRA_DISAPPEARANCE_QUEST_STAGE_2"}, # wait for a letter (or do sacred bowl)
			stage3 = {code = 'stage3', name = "ZEPHYRA_DISAPPEARANCE_QUEST_NAME", descript = "ZEPHYRA_DISAPPEARANCE_QUEST_STAGE_3"}, # meet ketch
#			stage1 = {code = 'stage1', name = "ZEPHYRA_DISAPPEARANCE_QUEST_NAME", descript = "ZEPHYRA_DISAPPEARANCE_QUEST_STAGE_1"}, # search for Zephyra
		},
	},
	
	amelia_main_quest = {
		code = 'amelia_main_quest',
		summary = "AMELIA_MAIN_QUEST_SUMMARY",
		stages = {
			stage0 = {code = 'stage0', name = 'AMELIA_MAIN_QUEST_NAME', descript = 'AMELIA_MAIN_STAGE_0'}, 
			stage1 = {code = 'stage1', name = 'AMELIA_MAIN_QUEST_NAME', descript = 'AMELIA_MAIN_STAGE_1'}, 
			stage2 = {code = 'stage2', name = 'AMELIA_MAIN_QUEST_NAME', descript = 'AMELIA_MAIN_STAGE_2'}, 
			stage3 = {code = 'stage3', name = 'AMELIA_MAIN_QUEST_NAME', descript = 'AMELIA_MAIN_STAGE_3'}, 
			stage4 = {code = 'stage4', name = 'AMELIA_MAIN_QUEST_NAME', descript = 'AMELIA_MAIN_STAGE_4'}, 
			stage5 = {code = 'stage5', name = 'AMELIA_MAIN_QUEST_NAME', descript = 'AMELIA_MAIN_STAGE_5'},
			stage6 = {code = 'stage6', name = 'AMELIA_MAIN_QUEST_NAME', descript = 'AMELIA_MAIN_STAGE_6'}, 
			stage7 = {code = 'stage7', name = 'AMELIA_MAIN_QUEST_NAME', descript = 'AMELIA_MAIN_STAGE_7'}, 
			stage8 = {code = 'stage8', name = 'AMELIA_MAIN_QUEST_NAME', descript = 'AMELIA_MAIN_STAGE_8'}, 
			stage9 = {code = 'stage9', name = 'AMELIA_MAIN_QUEST_NAME', descript = 'AMELIA_MAIN_STAGE_9'}, 
			stage10 = {code = 'stage10', name = 'AMELIA_MAIN_QUEST_NAME', descript = 'AMELIA_MAIN_STAGE_10'}, 
			stage11 = {code = 'stage11', name = 'AMELIA_MAIN_QUEST_NAME', descript = 'AMELIA_MAIN_STAGE_11'}, 
		}
	},
	lilia_finale_quest = {
		code = 'lilia_finale_quest',
		summary = "LILIA_FINALE_QUEST_SUMMARY",
		stages = {
			stage1 = {code = 'stage1', name = 'LILIA_FINALE_QUEST_NAME', descript = 'LILIA_FINALE_QUEST_STAGE_1'}, # go to workers
			stage2 = {code = 'stage2', name = 'LILIA_FINALE_QUEST_NAME', descript = 'LILIA_FINALE_QUEST_STAGE_2'}, # complete dungeon
			stage3 = {code = 'stage3', name = 'LILIA_FINALE_QUEST_NAME', descript = 'LILIA_FINALE_QUEST_STAGE_3'}, # Report back to sigmund
			stage4 = {code = 'stage4', name = 'LILIA_FINALE_QUEST_NAME', descript = 'LILIA_FINALE_QUEST_STAGE_4'}, # wait for flirting
			stage5 = {code = 'stage5', name = 'LILIA_FINALE_QUEST_NAME', descript = 'LILIA_FINALE_QUEST_STAGE_5'}, # complete grove dungeon
			stage7 = {code = 'stage7', name = 'LILIA_FINALE_QUEST_NAME', descript = 'LILIA_FINALE_QUEST_STAGE_7'}, # wait for good route scene
			stage8 = {code = 'stage8', name = 'LILIA_FINALE_QUEST_NAME', descript = 'LILIA_FINALE_QUEST_STAGE_8'}, # go to lilia village
		},
	},
	
	lilith_patron_quest = {
		code = 'lilith_patron_quest',
		summary = "LILITH_PATRON_QUEST_SUMMARY",
		stages = {
			stage10 = {code = 'stage10', name = 'LILITH_PATRON_QUEST_NAME', descript = 'LILITH_PATRON_QUEST_STAGE_10'}, # go to lilith village
			stage11 = {code = 'stage11', name = 'LILITH_PATRON_QUEST_NAME', descript = 'LILITH_PATRON_QUEST_STAGE_11'}, # wait for sex scene
			stage12 = {code = 'stage12', name = 'LILITH_PATRON_QUEST_NAME', descript = 'LILITH_PATRON_QUEST_STAGE_12'}, # go to mages
			stage13 = {code = 'stage13', name = 'LILITH_PATRON_QUEST_NAME', descript = 'LILITH_PATRON_QUEST_STAGE_13'}, # go to xari
			stage14 = {code = 'stage14', name = 'LILITH_PATRON_QUEST_NAME', descript = 'LILITH_PATRON_QUEST_STAGE_14'}, # ask lilith about patron
			stage15 = {code = 'stage15', name = 'LILITH_PATRON_QUEST_NAME', descript = 'LILITH_PATRON_QUEST_STAGE_15'}, # clear new patron dungeon
		},
	},
	
	visit_dwarfs_quest = {
		code = 'visit_dwarfs_quest',
		summary = "VISIT_DWARFS_QUEST_SUMMARY",
		stages = {
			audience = {code = 'audience', name = 'VISIT_DWARFS_QUEST_NAME', descript = 'VISIT_DWARFS_QUEST_AUDIENCE'},
			tavern = {code = 'tavern', name = 'VISIT_DWARFS_QUEST_NAME', descript = 'VISIT_DWARFS_QUEST_TAVERN'},
			jean = {code = 'jean', name = 'VISIT_DWARFS_QUEST_NAME', descript = 'VISIT_DWARFS_QUEST_JEAN'},
		},
	},
	dking_hara_quest = {
		code = 'dking_hara_quest',
		summary = "DKING_HARA_QUEST_SUMMARY",
		stages = {
			info = {code = 'info', name = 'DKING_HARA_QUEST_NAME', descript = 'DKING_HARA_QUEST_INFO'},
			tracks = {code = 'tracks', name = 'DKING_HARA_QUEST_NAME', descript = 'DKING_HARA_QUEST_TRACKS'},
			temple = {code = 'temple', name = 'DKING_HARA_QUEST_NAME', descript = 'DKING_HARA_QUEST_TEMPLE'},
			wait = {code = 'wait', name = 'DKING_HARA_QUEST_NAME', descript = 'DKING_HARA_QUEST_WAIT'},
			rebeltavern = {code = 'rebeltavern', name = 'DKING_HARA_QUEST_NAME', descript = 'DKING_HARA_QUEST_REBELTAVERN'},
			nextday = {code = 'nextday', name = 'DKING_HARA_QUEST_NAME', descript = 'DKING_HARA_QUEST_NEXTDAY'},
			visit = {code = 'visit', name = 'DKING_HARA_QUEST_NAME', descript = 'DKING_HARA_QUEST_VISIT'},
		},
	},
	hara_scales_quest = {
		code = 'hara_scales_quest',
		summary = "HARA_SCALES_QUEST_SUMMARY",
		stages = {
			see_hara = {code = 'see_hara', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_SEE_HARA'},
			get_ore = {code = 'get_ore', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_GET_ORE'},
			get_gold = {code = 'get_gold', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_GET_GOLD'},
			bring_ore = {code = 'bring_ore', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_BRING_ORE'},
			get_sap = {code = 'get_sap', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_GET_SAP'},
			h_scouts = {code = 'h_scouts', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_H_SCOUTS'},
			h_price = {code = 'h_price', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_H_PRICE'},
			l_price = {code = 'l_price', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_L_PRICE'},
			bring_sap = {code = 'bring_sap', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_BRING_SAP'},
			get_cap = {code = 'get_cap', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_GET_CAP'},
			bring_cap = {code = 'bring_cap', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_BRING_CAP'},
			next_day = {code = 'next_day', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_NEXT_DAY'},
			visit = {code = 'visit', name = 'HARA_SCALES_QUEST_NAME', descript = 'HARA_SCALES_QUEST_VISIT'},
		},
	},
	jean_free_quest = {
		code = 'jean_free_quest',
		summary = "JEAN_FREE_QUEST_SUMMARY",
		stages = {
			price = {code = 'price', name = 'JEAN_FREE_QUEST_NAME', descript = 'JEAN_FREE_QUEST_PRICE'},
		},
	},
	kuro_tome_quest = {
		code = 'kuro_tome_quest',
		summary = "KURO_TOME_QUEST_SUMMARY",
		stages = {
			library = {code = 'library', name = 'KURO_TOME_QUEST_NAME', descript = 'KURO_TOME_QUEST_LIBRARY'},
			money = {code = 'money', name = 'KURO_TOME_QUEST_NAME', descript = 'KURO_TOME_QUEST_MONEY'},
			capital = {code = 'capital', name = 'KURO_TOME_QUEST_NAME', descript = 'KURO_TOME_QUEST_CAPITAL'},
			carriage = {code = 'carriage', name = 'KURO_TOME_QUEST_NAME', descript = 'KURO_TOME_QUEST_CARRIAGE'},
			bottle = {code = 'bottle', name = 'KURO_TOME_QUEST_NAME', descript = 'KURO_TOME_QUEST_BOTTLE'},
			back = {code = 'back', name = 'KURO_TOME_QUEST_NAME', descript = 'KURO_TOME_QUEST_BACK'},
			talk = {code = 'talk', name = 'KURO_TOME_QUEST_NAME', descript = 'KURO_TOME_QUEST_TALK'},
		},
	},
	lira_lost_quest = {
		code = 'lira_lost_quest',
		summary = "LIRA_LOST_QUEST_SUMMARY",
		stages = {
			capital = {code = 'capital', name = 'LIRA_LOST_QUEST_NAME', descript = 'LIRA_LOST_QUEST_CAPITAL'},
		},
	},
	kuro_errand_quest = {
		code = 'kuro_errand_quest',
		summary = "KURO_ERRAND_QUEST_SUMMARY",
		stages = {
			church = {code = 'church', name = 'KURO_ERRAND_QUEST_NAME', descript = 'KURO_ERRAND_QUEST_CHURCH'},
			invite = {code = 'invite', name = 'KURO_ERRAND_QUEST_NAME', descript = 'KURO_ERRAND_QUEST_INVITE'},
			search = {code = 'search', name = 'KURO_ERRAND_QUEST_NAME', descript = 'KURO_ERRAND_QUEST_SEARCH'},
			base = {code = 'base', name = 'KURO_ERRAND_QUEST_NAME', descript = 'KURO_ERRAND_QUEST_BASE'},
		},
	},
	
	anastasia_quest = {
		code = 'anastasia_quest',
		summary = "ANASTASIA_QUEST_SUMMARY",
		stages = {
			stage2 = {code = 'stage2', name = 'ANASTASIA_QUEST_NAME', descript = 'ANASTASIA_QUEST_STAGE2'},#meet with liora
			stage3 = {code = 'stage3', name = 'ANASTASIA_QUEST_NAME', descript = 'ANASTASIA_QUEST_STAGE3'},# go to ashen ridge
			stage4 = {code = 'stage4', name = 'ANASTASIA_QUEST_NAME', descript = 'ANASTASIA_QUEST_STAGE4'},#search cave
			stage5 = {code = 'stage5', name = 'ANASTASIA_QUEST_NAME', descript = 'ANASTASIA_QUEST_STAGE5'},#return to liora
			stage6 = {code = 'stage6', name = 'ANASTASIA_QUEST_NAME', descript = 'ANASTASIA_QUEST_STAGE6'},#speak with ana
		},
	},
	anastasia_quest_2 = {
		code = 'anastasia_quest_2',
		summary = "ANASTASIA_QUEST2_SUMMARY",
		stages = {
			stage8 = {code = 'stage8', name = 'ANASTASIA_QUEST2_NAME', descript = 'ANASTASIA_QUEST_STAGE8'}, #meet with dunkan
			stage9 = {code = 'stage9', name = 'ANASTASIA_QUEST2_NAME', descript = 'ANASTASIA_QUEST_STAGE9'}, #speak with ana
			stage10 = {code = 'stage10', name = 'ANASTASIA_QUEST2_NAME', descript = 'ANASTASIA_QUEST_STAGE10'}, #go to fort
			stage11 = {code = 'stage11', name = 'ANASTASIA_QUEST2_NAME', descript = 'ANASTASIA_QUEST_STAGE11'}, #force defenders
			stage12 = {code = 'stage12', name = 'ANASTASIA_QUEST2_NAME', descript = 'ANASTASIA_QUEST_STAGE12'}, #continue
			stage13 = {code = 'stage13', name = 'ANASTASIA_QUEST2_NAME', descript = 'ANASTASIA_QUEST_STAGE13'}, #return to dunkan
		},
	},
	meteorite_quest = {
		code = 'meteorite_quest',
		summary = "METEORITE_QUEST_SUMMARY",
		stages = {
			check_out = {code = 'check_out', name = 'METEORITE_QUEST_NAME', descript = 'METEORITE_QUEST_CHECK_OUT'},
			return_meteor = {code = 'return_meteor', name = 'METEORITE_QUEST_NAME', descript = 'METEORITE_QUEST_RETURN_METEOR'},
			find_use = {code = 'find_use', name = 'METEORITE_QUEST_NAME', descript = 'METEORITE_QUEST_FIND_USE'},
			get_inside = {code = 'get_inside', name = 'METEORITE_QUEST_NAME', descript = 'METEORITE_QUEST_GET_INSIDE'},
			search_durim = {code = 'search_durim', name = 'METEORITE_QUEST_NAME', descript = 'METEORITE_QUEST_SEARCH_DURIM'},
		},
	},
	act_4_capital = {
		code = 'act_4_capital',
		summary = 'ACT_4_CAPITAL_SUMMARY',
		stages = {
			enter_capital = {code = 'enter_capital', name = 'ACT_4_CAPITAL_NAME', descript = 'ACT_4_CAPITAL_ENTER'},
			wait1 = {code = 'wait1', name = 'ACT_4_CAPITAL_NAME', descript = 'ACT_4_CAPITAL_WAIT1'},
			ceremony = {code = 'ceremony', name = 'ACT_4_CAPITAL_NAME', descript = 'ACT_4_CAPITAL_CEREMONY'},
			wait2 = {code = 'wait2', name = 'ACT_4_CAPITAL_NAME', descript = 'ACT_4_CAPITAL_WAIT2'},
			arena = {code = 'arena', name = 'ACT_4_CAPITAL_NAME', descript = 'ACT_4_CAPITAL_ARENA'},
			act4_continue = {code = 'act4_continue', name = 'ACT_4_CAPITAL_NAME', descript = 'ACT_4_CONTINUE'}
		}
	}
}

var old_quest_stages = {
	visit_dwarfs_quest = {
		search = 'audience'
	}
}

var error_stage = {
	code = 'error_stage',
	name = 'Error',
	descript = 'There is error with quest %s on stage %s. The quest is incompleteable. Please, report this to developers.'
}

