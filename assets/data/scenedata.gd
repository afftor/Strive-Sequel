extends Node

#wolves_skirmish_start
var scenedict = {
	childbirth = {text = tr("DIALOGUECHILDBIRTHTEXT"), image = 'childbirth', tags = ['active_character_translate'], options = [{code = 'keepbaby', reqs = [], text = tr("DIALOGUEKEEPBABY")}, {code = 'removebaby', reqs = [], text = tr("DIALOGUEREMOVEBABY")}]},
	
	slave_escape = {text = tr("DIALOGUEESCAPETEXT"), image = 'slaveescape', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUEESCAPECLOSE")}]},
	
	
	location_event_search = {text = tr("DIALOGUELOCATIONEVENT"), tags = [], image = '', options = [{code = 'good_event', reqs = [], text = tr("DIALOGUELOCATIONEVENTGOOD")},{code = 'evil_event', reqs = [], text = tr("DIALOGUELOCATIONEVENTEVIL")},{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}]},
	
	wolves_skirmish_start = {text = tr("DIALOGUEWOLVES_SKIRMISH_START"), set_enemy = 'wolves_skirmish',tags = [], image = 'wolves_skirmish', options = [{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION")},{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}]},
	rebels_skirmish_start = {text = tr("DIALOGUEREBELS_SKIRMISH_START"), set_enemy = 'rebels_skirmish',tags = [], image = '', options = [{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION")},{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}]},
	
	
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
	{code = 'recruit', reqs = [], text = tr("DIALOGUERECRUITBOSSOPTION")},
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
	
	lockpick_chest_failure = {
		text = 'DIALOGUECHESTLOCKPICKFAILURE',
		tags = ['active_character_translate'], 
		image = 'chest',
		bonus_effects = [{code = 'affect_active_character', type = 'stat', name = 'wits', value = 2}],
		options = [
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
		],
	},
	lockpick_chest_success = {
		text = 'DIALOGUECHESTLOCKPICKSUCCESS',
		tags = ['active_character_translate'], 
		image = 'chest',
		bonus_effects = [{code = 'affect_active_character', type = 'stat', name = 'wits', value = 2}],
		options = [
		{code = 'open_chest', reqs = [], text = tr("DIALOGUECHESTOPEN")}
		],
	},
	
	dungeon_find_chest_easy = {
		text = tr("DIALOGUEDUNGEONCHEST"), 
		tags = ['locked_chest'],
		image = 'chest', 
		common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['easy_chest_usable', 1], ['easy_chest_gear',0.2], ['easy_chest_cosmetics', 0.5]]}],
		options = [
		#{code = 'open_chest', reqs = [], text = tr("DIALOGUEFORCECHESTOPEN")},
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
		]
	},
	quest_accept = {
		text = tr("DIALOGUEQUESTACCEPT"), 
		image = '',
		tags = [], 
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
		],
	},
	
	purchase_dungeon_location = {
		text = tr("DIALOGUEPURCHASEDUNGEONLOCATION"), 
		image = 'locationpurchase',
		tags = [], 
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
		],
	},
	
	event_good_recruit = {text = tr("DIALOGUEEVENTGOODRECRUIT"), 
	args = {},
	tags = ['good','scene_character_translate'],
	default_event_type = "character_event",
	image = 'recruit', 
	common_effects = [{code = 'make_scene_character', value = [{type = 'function', function = 'make_local_recruit', args = {}}]}],
	options = [
	{code = 'recruit', reqs = [], text = tr("DIALOGUERECRUITCHARACTEROPTION")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
	]
	},
	
	event_good_loot_small = {text = tr("DIALOGUEEVENTGOODLOOT"), 
	tags = ['good','locked_chest'],
	default_event_type = "loot",
	image = 'chest', 
	common_effects = [{code = 'make_loot',type = 'tableloot', pool = [['easy_chest_usable', 1], ['easy_chest_gear',0.2], ['easy_chest_cosmetics', 0.5]]}],
	options = [
	#{code = 'open_chest', reqs = [], text = tr("DIALOGUEFORCECHESTOPEN")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
	]
	},
	
	event_dungeon_complete_loot_easy = {text = tr("DIALOGUEEVENTDUNGEONLOOT"), 
	tags = ['good','locked_chest'],
	default_event_type = "loot",
	image = 'chest', 
	common_effects = [{code = 'make_loot',type = 'tableloot', pool = [['easy_boss_chest',1]]}],
	options = [
	#{code = 'open_chest', reqs = [], text = tr("DIALOGUEFORCECHESTOPEN")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
	]
	},
	
	event_trap_easy = {text = tr("DIALOGUEEVENTTRAP"), 
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap', 
	options = [
	{code = 'activate_trap_easy', select_person = true, reqs = [], text = tr("DIALOGUEACTIVATETRAP")},
	]
	},
	activate_trap_easy = {
		variations = [
			{reqs = [{type = 'active_character_checks', value = [{code = 'trait', value = 'trap_detection'}]},
			],
			text = tr("DIALOGUEEVENTTRAPSUCCESS"),
			common_effects = [{code = 'affect_active_character', type = 'stat', name = 'wits', value = 3}],
			tags = ['active_character_translate'],
			image = '',
			options = [
				{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = []},
				]
			},
			{reqs = [],
			text = tr("DIALOGUEEVENTTRAPFAILURE"),
			image = '',
			common_effects = [{code = "affect_active_character", type = 'damage', value = 25}],
			tags = ['active_character_translate'],
			options = [
				{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = []},
				],
				
			}
		],
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
			type = 'servant'
			}
		},
		],
	}
	],
	options = [
	{code = 'event_dungeon_prisoner_enslave', reqs = [], text = ("DIALOGUETAKESLAVE")},
	{code = 'event_dungeon_prisoner_free', reqs = [], text = tr("DIALOGUESETFREEPERSON")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
	]
	},
	event_dungeon_prisoner_enslave = {text = tr("DIALOGUEEVENTDUNGEONPRISONERSENSLAVE"), 
	tags = ['active_character_translate'],
	image = '', 
	common_effects = [{code = 'change_type_scene_characters', type = 'all', value = 'slave'},{code = 'affect_scene_characters', type = 'all', name = 'obedience', value = 20}],
	options = [
	{code = 'recruit', reqs = [], text = tr("DIALOGUERECRUITCHARACTEROPTION")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
	]
	},
	event_dungeon_prisoner_free = {
		variations = [
			{reqs = [{type = 'random', value = 0}],
			text = tr("DIALOGUEEVENTDUNGEONPRISONERFREE1"),
			image = 'chest',
			default_event_type = "loot",
			common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['easy_prisoner_reward_resource',1]] }],
			tags = ['active_character_translate'],
			options = [
				{code = 'open_chest', text = tr("DIALOGUECLOSE"), reqs = []},
				]
			},
			{reqs = [],
			text = tr("DIALOGUEEVENTDUNGEONPRISONERFREE2"),
			image = 'chest',
			default_event_type = "loot",
			common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['easy_prisoner_reward_item',1]] }],
			tags = ['active_character_translate'],
			options = [
				{code = 'open_chest', text = tr("DIALOGUECLOSE"), reqs = []},
				],
				
			}
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
			bonuses = {pricemod = 0.5, obedience = 48, submission = 10},
			is_hirable = true
			}
		},
		],
	},
	
	],
	options = [
	#{code = 'event_person_acquired', reqs = [{type = "has_money_for_scene_slave", value = 0}], not_hide = true, text = tr("DIALOGUESLAVERSPURCHASE"), bonus_effects = [{code = 'spend_money_for_scene_character', value = 0}]},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")},
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
			{type = 'function', function = 'make_local_recruit', args = {races = [['Elf', 10], ['Fairy', 2], ['Dryad', 1]], difficulty = [0,1], bonuses = {pricemod = -0.3, obedience = 24, submission = 10}, type = 'slave'}}],
		},
		{code = 'affect_scene_characters', type = 'all', name = 'obedience', value = 10},{code = 'affect_scene_characters', type = 'all', name = 'submission', value = 20}],
	options = [
	{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION")},
	{code = 'event_person_acquired', reqs = [{type = "has_money_for_scene_slave", value = 0}], not_hide = true, text = tr("DIALOGUESLAVERSPURCHASE"), bonus_effects = [{code = 'spend_money_for_scene_character', value = 0}]},
	{code = 'event_good_slavers_request', select_person = true, reqs = [], text = tr("DIALOGUEREQUESTSLAVE")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")},
	]
	},
	event_good_slavers_request = {
		variations = [
			{reqs = [{type = 'active_character_checks', value = [{code = 'random', value = [['self.charm_factor','*5'],"+", ['self.charm', '/4']]}]},
			],
			text = tr("DIALOGUEEVENTSLAVERSNEGOTIATESUCCESS"),
			common_effects = [{code = 'affect_active_character', type = 'stat', name = 'charm', value = 3}],
			tags = ['linked_event','active_character_translate'],
			image = 'slavers_elf',
			options = [
				{code = 'event_person_acquired', text = tr("DIALOGUECONTINUE"), reqs = []},
				]
			},
			{reqs = [],
			text = tr("DIALOGUEEVENTSLAVERSNEGOTIATEFAILURE"),
			image = 'slavers_elf',
			common_effects = [{code = 'affect_active_character', type = 'stat', name = 'charm', value = 2}],
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
		tags = ['linked_event'],
		default_event_type = 'scene_character_event',
		image = 'slave_decision',
		common_effects = [{code = 'bool_scene_characters', type = 'all', name = 'is_known_to_player', value = true}],
		options = [
		{code = 'recruit_from_scene', reqs = [], text = tr("DIALOGUEKEEPSLAVEPERSON")},
		{code = 'event_person_free', reqs = [], text = tr("DIALOGUESETFREEPERSON")}
		],
	},
	event_person_free = {
		text = tr("DIALOGUEEVENTPERSONFREE"),
		args = {},
		tags = [],
		default_event_type = 'scene_character_event',
		image = 'slave_decision',
		common_effects = [{code = 'change_type_scene_characters', type = 'all', value = 'servant'},{code = 'affect_scene_characters', type = 'stat', name = 'authority', value = 55}],
		options = [
		{code = 'event_person_recruit_attempt', select_person = true, reqs = [], text = tr("DIALOGUEPERSONASKTOJOIN")},
		{code = 'close', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
		],
	},
	
	event_person_recruit_attempt = {
		variations = [
			{reqs = [{type = 'active_character_checks', value = [{code = 'random', value = [['self.charm_factor','*5'],"+", ['self.charm', '/4']]}]},#type = 'charm_factor', operant = 'gte', value = 3}]}
			],
			text = tr("DIALOGUERECRUITSUCCESS"),
			common_effects = [{code = 'affect_active_character', type = 'stat', name = 'charm', value = 3},{code = 'affect_scene_characters', type = 'all', name = 'obedience', value = 78},{code = 'affect_scene_characters', type = 'all', name = 'authority', value = 65},{code = 'affect_scene_characters', type = 'all', name = 'loyalty', value = 20}],
			tags = ['active_character_translate','scene_character_translate'],
			image = 'slave_decision',
			options = [
				{code = 'recruit_from_scene', text = tr("DIALOGUECONTINUE"), reqs = []},
				{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
				]
			},
			{reqs = [],
			text = tr("DIALOGUERECRUITFAILURE"),
			image = 'slave_decision',
			common_effects = [{code = 'affect_active_character', type = 'stat', name = 'charm', value = 2}],
			tags = ['active_character_translate','scene_character_translate'],
			options = [
				{code = 'leave', text = tr("DIALOGUECLOSE"), reqs = []},
				],
				
			}
		],
	},
	
	event_good_rebels_beastkin = {text = tr("DIALOGUEEVENTGOODREBELSBEAST"), 
	args = {},
	tags = ['good','scene_character_translate'],
	default_event_type = "character_event",
	image = 'rebels_furry',
	set_enemy = 'rebels_small',
	winscene = 'event_person_acquired',
	common_effects = [
	{code = 'make_scene_character', value = [{type = 'function', function = 'make_local_recruit', args = {races = [['beast', 1]], difficulty = [0,1], type = 'servant',bonuses = {authority = 35, submission = 5}}}],},
	{code = 'affect_scene_characters', type = 'all', name = 'obedience', value = 24}],
	options = [
	{code = 'fight_skirmish', reqs = [], text = tr("DIALOGUEFIGHTOPTION")},
	{code = 'event_good_rebels_intimidate', select_person = true, reqs = [], text = tr("DIALOGUEINTIMIDATE")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")},
	]
	},
	
	event_good_rebels_intimidate = {
		variations = [
			{reqs = [{type = 'active_character_checks', value = [{code = 'random', value = [['self.physics_factor','*8'],"+", ['self.physics', '/3']]}]},
			],
			text = tr("DIALOGUEEVENTREBELSBEASTINTIMIDATESUCCES"),
			common_effects = [{code = 'affect_active_character', type = 'stat', name = 'charm', value = 3}],
			tags = ['linked_event','active_character_translate'],
			image = 'rebels_furry',
			options = [
				{code = 'event_person_acquired', text = tr("DIALOGUECONTINUE"), reqs = []},
				]
			},
			{reqs = [],
			text = tr("DIALOGUEEVENTREBELSBEASTINTIMIDATEFAILURE"),
			image = 'rebels_furry',
			winscene = 'event_person_acquired',
			common_effects = [{code = 'affect_active_character', type = 'stat', name = 'charm', value = 2}],
			tags = ['linked_event','active_character_translate'],
			options = [
				{code = 'fight_skirmish', text = tr("DIALOGUEFIGHTOPTION"), reqs = []},
				],
				
			}
		],
	},
	
	event_nothing_found = {text = tr("DIALOGUEEVENTNOTHING"), 
	tags = ['good'],
	default_event_type = "location",
	image = 'noevent', 
	options = [
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
	]
	},
	
	#items with options
	
	minorus_potion_select = {text = tr("DIALOGUEEVENTMINORUSSELECT"), 
	tags = ['custom_effect','active_character_translate'],
	image = 'pot', 
	options = [
	{code = 'minorus_tits', reqs = [], text = tr("DIALOGUETITSSELECT")},
	{code = 'minorus_ass', reqs = [], text = tr("DIALOGUEASSSELECT")},
	{code = 'minorus_balls', reqs = [{type = 'active_character_checks', value = [{code = 'bodypart', name = 'balls_size', operant = 'neq', value = ''}]}], text = tr("DIALOGUEBALLSSELECT")},
	{code = 'minorus_penis', reqs = [{type = 'active_character_checks', value = [{code = 'bodypart', name = 'penis_size', operant = 'neq', value = ''}]}], text = tr("DIALOGUEPENISSELECT")},
	]
	},
	majorus_potion_select = {text = tr("DIALOGUEEVENTMAJORUSSELECT"), 
	tags = ['custom_effect','active_character_translate'],
	image = 'pot', 
	options = [
	{code = 'majorus_tits', reqs = [], text = tr("DIALOGUETITSSELECT")},
	{code = 'majorus_ass', reqs = [], text = tr("DIALOGUEASSSELECT")},
	{code = 'majorus_balls', reqs = [{type = 'active_character_checks', value = [{code = 'bodypart', name = 'balls_size', operant = 'neq', value = ''}]}], text = tr("DIALOGUEBALLSSELECT")},
	{code = 'majorus_penis', reqs = [{type = 'active_character_checks', value = [{code = 'bodypart', name = 'penis_size', operant = 'neq', value = ''}]}], text = tr("DIALOGUEPENISSELECT")},
	]
	},
	
	minorus_potion_tits = {text = tr("DIALOGUEMINORUSPOTTITS"), image = 'potmaj', tags = [], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	minorus_potion_ass = {text = tr("DIALOGUEMINORUSPOTASS"), image = 'potmaj', tags = [], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	minorus_potion_penis = {text = tr("DIALOGUEMINORUSPOTPENIS"), image = 'potmaj', tags = [], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	minorus_potion_balls = {text = tr("DIALOGUEMINORUSPOTBALLS"), image = 'potmaj', tags = [], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	majorus_potion_tits = {text = tr("DIALOGUEMAJORUSPOTTITS"), image = 'potmaj', tags = [], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	majorus_potion_ass = {text = tr("DIALOGUEMAJORUSPOTASS"), image = 'potmaj', tags = [], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	majorus_potion_penis = {text = tr("DIALOGUEMAJORUSPOTPENIS"), image = 'potmaj', tags = [], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	majorus_potion_balls = {text = tr("DIALOGUEMAJORUSPOTBALLS"), image = 'potmaj', tags = [], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	potion_no_effect = {text = tr("DIALOGUEPOTIONNOEFFECT"), image = 'potmaj', tags = [], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	
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
#	writ_confirm = {
#		text = tr("DIALOGUEWRITSELECT"),
#		image = null,
#		options = [
#		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")},
#
#		],
#	},
	
	#Action events
	enslave = {text = tr("DIALOGUEENSLAVETEXT"), image = 'warn', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	hire = {text = tr("DIALOGUEHIRETEXT"), image = 'praise', tags = ['active_character_translate'], options = [{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}]},
	
	#Story Events
	daisy_meet = {
		text = tr('SCENEDAISY_MEET_TEXT'),
		tags = ['linked_event'],#linked_event means that all options will trigger other events by name instead of generic options like 'close' or 'inspect'
		receiver = 'master', #not used yet but supposed to represent a group of characters involved into event
		image = 'daisystart',
		opp_characters = [{type = 'pregen', value = 'Daisy'}],
		options = [
		{code = 'daisy_purchase', text = tr("SCENEDAISY_MEET_OPTION1"), reqs = []},
		{code = 'daisy_claim_kinship', text =  tr("SCENEDAISY_MEET_OPTION2"), reqs = [{type = 'master_is_beast', value = true}]},
		{code = 'daisy_ignore_purchase', text = tr("SCENEDAISY_MEET_OPTION3"), reqs = []},
		],
	},
	daisy_claim_kinship = {
		text = tr("SCENEDAISY_CLAIM_KINSHIPTEXT"),
		tags = [],
		receiver = 'master',
		image = 'daisystart',
		common_effects = [{code = 'make_story_character', value = 'Daisy'},{code = 'add_timed_event', value = "daisy_first_event", args = [{type = 'add_to_date', date = [4,6], hour = 18}]}],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	daisy_purchase = {
		text = tr("SCENEDAISY_PURCHASE_TEXT"),
		tags = ['linked_event'],
		receiver = 'master',
		image = 'daisystart',
		options = [{code = 'daisy_purchase_negotiate', text = tr("SCENEDAISY_PURCHASE_OPTION1"), reqs = []},
		{code = 'daisy_purchase_confirm', text = tr("SCENEDAISY_PURCHASE_OPTION2"), reqs = [{type = "has_money", value = 200}]},
		{code = 'daisy_purchase_leave', text = tr("SCENEDAISY_PURCHASE_OPTION3"), reqs = []},
		],
	},
	daisy_purchase_negotiate = {
		variations = [ #variations are used if previous option can have multiple outcomes. If variation's requirements are passed it triggers and the rest is ignored. Priority is set by order. 
			{reqs = [{type = 'master_check', value = [{code = 'stat', type = 'charm_factor', operant = 'gte', value = 3}, {code = 'stat', type = 'charm', operant = 'gte', value = 15, orflag = true}]}],
			text = tr("SCENEDAISY_PURCHASE_NEGOTIATE_TEXT1"),
			common_effects = [],
			tags = ['linked_event'],
			image = 'daisystart',
			options = [
				{code = 'daisy_purchase_confirm_discount', text = tr("SCENEDAISY_PURCHASE_OPTION2"), reqs = [{type = "has_money", value = 100}]},
				{code = 'daisy_purchase_leave', text = tr("SCENEDAISY_PURCHASE_OPTION3"), reqs = []},
				]
			},
			{reqs = [],
			text = tr("SCENEDAISY_PURCHASE_NEGOTIATE_TEXT2"),
			image = 'daisystart',
			common_effects = [],
			tags = ['linked_event'],
			options = [
				{code = 'daisy_purchase_confirm', text = tr("SCENEDAISY_PURCHASE_OPTION2"), reqs = [{type = "has_money", value = 200}]},
				{code = 'daisy_purchase_leave', text = tr("SCENEDAISY_PURCHASE_OPTION3"), reqs = []},
				],
				
			}
		],
	},
	daisy_purchase_confirm = {
		text = tr("SCENEDAISY_PURCHASE_CONFIRM_TEXT"),
		tags = [],
		receiver = 'master',
		image = 'daisystart',
		common_effects = [{code = 'money_change', operant = '-', value = 200}, 
		{code = 'make_story_character', value = 'Daisy'}, #make_story_character takes character data from worldgen.pregen_characters
		{code = 'add_timed_event', value = "daisy_first_event", args = [{type = 'add_to_date', date = [4,6], hour = 18}]}],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	daisy_purchase_confirm_discount = {
		text = tr("SCENEDAISY_PURCHASE_CONFIRM_TEXT"),
		tags = [],
		receiver = 'master',
		image = 'daisystart',
		common_effects = [{code = 'money_change', operant = '-', value = 100}, {code = 'make_story_character', value = 'Daisy'}, {code = 'add_timed_event', value = "daisy_first_event", args = [{type = 'add_to_date', date = [4,6], hour = 18}]}],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	daisy_purchase_leave = {
		text = tr("SCENEDAISY_PURCHASE_LEAVE_TEXT"),
		tags = [],
		receiver = 'master',
		image = 'daisystart',
		common_effects = [],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	daisy_ignore_purchase = {
		text = tr("SCENEDAISY_IGNORE_TEXT"),
		tags = [],
		receiver = 'master',
		image = 'daisystart',
		common_effects = [],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	
	daisy_first_event = {
		text = tr("SCENEDAISY_FIRST_EVENT_TEXT"),
		tags = ['linked_event'],
		receiver = 'master',
		reqs = [{type = 'unique_character_at_mansion', value = 'daisy', negative = 'repeat_next_day'}],#this requirement only applies when checking timed_events. 'negative' means what resolution should apply when requirement is not met.
		image = 'daisyevent',
		options = [
		{code = 'daisy_first_event_reassure', text = tr("SCENEDAISY_FIRST_EVENT_OPTION1"), reqs = []},
		{code = 'daisy_first_event_discipline', text = tr("SCENEDAISY_FIRST_EVENT_OPTION2"), reqs = []},
		],
	},
	daisy_first_event_reassure = {
		text = tr("SCENEDAISY_FIRST_EVENT_REASSURE"),
		tags = [],
		receiver = 'master',
		image = 'daisyevent',
		common_effects = [#common_effects are treated in state by applying simple changes to game state and characters.
		{code = 'add_timed_event', value = "daisy_confess_event", args = [{type = 'add_to_date', date = [7,10], hour = 20}]},
		{code = 'unique_character_changes', value = 'daisy', args = [ #unique_character_changes takes an unique character and apply specific values to their values with exceptions of traits and tags which treated separately
			{code = 'tame_factor', value = 1, operant = "+"},
			{code = 'obedience', operant = '+', value = 75}
			]},
		],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	daisy_first_event_discipline = {
		text = tr("SCENEDAISY_FIRST_EVENT_DISCIPLINE"),
		tags = [],
		receiver = 'master',
		image = 'daisyevent',
		common_effects = [{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'sexuals_factor', value = 1, operant = "+"},
			{code = 'sextrait', value = 'submissive', operant = 'add'},#for sextrait/add setting, trait is appended to character's traits
			{code = 'submission', operant = '+', value = 50},
			{code = 'obedience', operant = '+', value = 30},
			{code = 'tag', operant = 'remove', value = 'no_sex'},
			]}],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	daisy_confess_event = {
		text = tr("SCENEDAISY_CONFESS_EVENT_TEXT"),
		tags = ['linked_event','master_translate'],
		reqs = [{type = 'unique_character_at_mansion', value = 'daisy', negative = 'repeat_next_day'}],
		receiver = 'master',
		image = 'daisyconfess',
		options = [
		{code = 'daisy_confess_accept', text = tr("SCENEDAISY_CONFESS_EVENT_OPTION1"), reqs = []},
		{code = 'daisy_confess_refuse', text = tr("SCENEDAISY_CONFESS_EVENT_OPTION2"), reqs = []},
		],
	},
	daisy_confess_accept = {
		text = tr("SCENEDAISY_CONFESS_ACCEPT_TEXT"),
		tags = [],
		receiver = 'master',
		image = 'daisyconfess',
		common_effects = [
		{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'growth_factor', value = 1, operant = "+"},
			{code = 'wits_factor', value = 1, operant = "+"},
			{code = 'obedience', operant = '+', value = 75},
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
		receiver = 'master',
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
		tags = ['dialogue_scene'],
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
		tags = ['dialogue_scene'],
		text = [
		{text = "STARTINGDIALOGUE2_1", reqs = [], previous_dialogue_option = 1},
		{text = "STARTINGDIALOGUE2_2", reqs = [], previous_dialogue_option = 2},
		{text = "STARTINGDIALOGUE2_3", reqs = []},
		],
		options = [
		{code = 'starting_dialogue3', text = "STARTINGDIALOGUE2REPLY1", reqs = [], dialogue_argument = 1},
		{code = 'starting_dialogue3', text = "STARTINGDIALOGUE2REPLY2", reqs = [], dialogue_argument = 2},
		{code = 'starting_dialogue3', text = "STARTINGDIALOGUE2REPLY3", reqs = [{type = 'dialogue_seen', operant = 'eq', value = 'STARTINGDIALOGUE3_1'}], dialogue_argument = 3},
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
		{code = 'starting_dialogue3', text = "STARTINGDIALOGUE2REPLY3", reqs = [{type = 'dialogue_seen', operant = 'eq', value = 'STARTINGDIALOGUE3_1'}], dialogue_argument = 3},
		{code = 'starting_dialogue4', text = "STARTINGDIALOGUE2REPLY4", reqs = [], dialogue_argument = 4, type = 'next_dialogue'},
		],
		
	},
	starting_dialogue4 = {
		image = null,
		tags = ['dialogue_scene'],
		text = "STARTINGDIALOGUE4_1",
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue'},
		],
		
	},
	
	
	fighters_introduction1 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene'],
		text = [
		{text = "FIGHTERSINTRODUCTION1", reqs = []},
		],
		options = [
		{code = 'fighters_introduction2', text = "FIGHTERSINTRODUCTION1REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'fighters_introduction2', text = "FIGHTERSINTRODUCTION1REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
		
	},
	fighters_introduction2 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene'],
		text = [
		{text = "FIGHTERSINTRODUCTION2_1", reqs = [], previous_dialogue_option = 1, bonus_effects = [{code = "update_guild"}]},
		{text = "FIGHTERSINTRODUCTION2_2", reqs = [], previous_dialogue_option = 2, bonus_effects = [{code = "update_guild"}]},
		{text = "FIGHTERSINTRODUCTION2_3", reqs = [], previous_dialogue_option = [1,2]},
		{text = "FIGHTERSINTRODUCTION2_3_1", reqs = [{type = 'main_progress', operant = 'eq', value = 0}], previous_dialogue_option = [1,2]},
		{text = "FIGHTERSINTRODUCTION2_4", reqs = [], previous_dialogue_option = 3},
		{text = "FIGHTERSINTRODUCTION2_5", reqs = [], previous_dialogue_option = 4},
		{text = "FIGHTERSINTRODUCTION2_6", reqs = [], previous_dialogue_option = 5},
		],
		options = [
		{code = 'fighters_questions', text = "FIGHTERSASKQUESTIONS", reqs = [], dialogue_argument = 1},
		{code = 'fighters_join', text = "FIGHTERSINTRODUCTION2REPLY1", reqs = [{type = 'main_progress', operant = 'eq', value = 0}], type = 'next_dialogue', dialogue_argument = 3},
		{code = 'fighters_election1', text = "FIGHTERSREQUESTELECTIONSUPPORT", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'stage3'}, {type = 'faction_reputation', code = 'fighters', operant = 'gte', value = 500}, {type = 'decision', name = 'fighters_election_support', value = false},{type = 'dialogue_seen', operant = 'neq', value = 'FIGHTERSELECTIONSTART1'}], type = 'next_dialogue', dialogue_argument = 1},
		{code = 'fighters_leader_close', text = "FIGHTERSINTRODUCTION2REPLY2", reqs = [], dialogue_argument = 4, bonus_effects = [{code = "update_guild"}]},
		],
		
	},
	fighters_join = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene'],
		text = [
		{text = "FIGHTERSJOIN", reqs = []},
		],
		common_effects = [
		{code = 'reputation', name = 'fighters', operant = '+', value = 100}, 
		{code = 'make_loot', pool = [['fighters_join_reward',1]]}, 
		{code = 'open_loot'}],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue',bonus_effects = [{code = 'create_character', type = 'fighters'}, {code = 'main_progress', operant = '+', value = 1},{code = 'progress_quest', value = 'guilds_introduction', stage = 'stage1'},{code = "update_guild"}]},
		]
		
	},
	fighters_leader_close = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene'],
		text = [
		{text = "FIGHTERSCLOSE1", reqs = [{type = 'main_progress', operant = 'eq', value = 0}]},
		{text = "FIGHTERSCLOSE2", reqs = [{type = 'main_progress', operant = 'neq', value = 0}]},
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = "update_guild"}]},
		]
		
	},
	fighters_questions = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene'],
		text = [
		{text = "FIGHTERSQUESTIONS_1", reqs = [], previous_dialogue_option = 1},
		{text = "FIGHTERSQUESTIONS_2", reqs = [], previous_dialogue_option = 2},
		{text = "FIGHTERSQUESTIONS_3", reqs = [], previous_dialogue_option = 3},
		{text = "FIGHTERSQUESTIONS_4", reqs = [], previous_dialogue_option = 4},
		],
		options = [
		{code = 'fighters_questions', text = "FIGHTERSQUESTIONREPLY1", reqs = [], dialogue_argument = 2, remove_after_first_use = true},
		{code = 'fighters_questions', text = "FIGHTERSQUESTIONREPLY2", reqs = [], dialogue_argument = 3, remove_after_first_use = true},
		{code = 'fighters_questions', text = "FIGHTERSQUESTIONREPLY3", reqs = [], dialogue_argument = 4, remove_after_first_use = true},
		{code = 'fighters_introduction2', text = "FIGHTERSASKQUESTIONSRETURN", reqs = [], dialogue_argument = 5},
		],
		
	},
	
	servants_introduction = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "SERVANTSINTRODUCTION1", reqs = [], previous_dialogue_option = 1},
		{text = "SERVANTSINTRODUCTION1_1", reqs = [{type = 'main_progress', operant = 'eq', value = 0}], previous_dialogue_option = 1},
		{text = "SERVANTSINTRODUCTION1_2", reqs = [], previous_dialogue_option = 2},
		{text = "SERVANTSINTRODUCTION1_3", reqs = [], previous_dialogue_option = 3},
		{text = "SERVANTSINTRODUCTION1_4", reqs = [], previous_dialogue_option = 4},
		],
		options = [
		{code = 'servants_questions', text = "SERVANTSASKQUESTIONS", reqs = [], dialogue_argument = 1},
		{code = 'servants_join', text = "SERVANTSINTRODUCTION1REPLY3", reqs = [{type = 'main_progress', operant = 'eq', value = 0}], type = 'next_dialogue', dialogue_argument = 3},
		{code = 'servants_election', text = "SERVANTSREQUESTELECTIONSUPPORT", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'stage3'}, {type = 'faction_reputation', code = 'servants', operant = 'gte', value = 500}, {type = 'decision', name = 'servants_election_support', value = false}], type = 'next_dialogue', dialogue_argument = 1},
		{code = 'servants_leader_close', text = "SERVANTSINTRODUCTION1REPLY4", reqs = [], dialogue_argument = 4, bonus_effects = [{code = "update_guild"}]},
		],
	},
	servants_join = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene'],
		text = [
		{text = "SERVANTSJOIN", reqs = []},
		],
		common_effects = [{code = 'reputation', name = 'servants', operant = '+', value = 100},
		{code = 'make_loot', pool = [['servants_join_reward',1]]}, 
		{code = 'open_loot'}
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue',bonus_effects = [{code = 'create_character', type = 'servants'}, {code = 'main_progress', operant = '+', value = 1},{code = 'progress_quest', value = 'guilds_introduction', stage = 'stage1'},{code = "update_guild"}]},
		]
	},
	servants_leader_close = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene'],
		text = [
		{text = "SERVANTSCLOSE1", reqs = [{type = 'main_progress', operant = 'eq', value = 0}]},
		{text = "SERVANTSCLOSE2", reqs = [{type = 'main_progress', operant = 'neq', value = 0}]},
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = "update_guild"}]},
		]
	},
	servants_questions = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene'],
		text = [
		{text = "SERVANTSQUESTIONS_1", reqs = [], previous_dialogue_option = 1},
		{text = "SERVANTSQUESTIONS_2", reqs = [], previous_dialogue_option = 2},
		{text = "SERVANTSQUESTIONS_3", reqs = [], previous_dialogue_option = 3},
		{text = "SERVANTSQUESTIONS_4", reqs = [], previous_dialogue_option = 4},
		],
		options = [
		{code = 'servants_questions', text = "SERVANTSQUESTIONREPLY1", reqs = [], dialogue_argument = 2, remove_after_first_use = true},
		{code = 'servants_questions', text = "SERVANTSQUESTIONREPLY2", reqs = [], dialogue_argument = 3, remove_after_first_use = true},
		{code = 'servants_questions', text = "SERVANTSQUESTIONREPLY3", reqs = [], dialogue_argument = 4, remove_after_first_use = true},
		{code = 'servants_introduction', text = "SERVANTSASKQUESTIONSRETURN", reqs = [], dialogue_argument = 4},
		],
		
	},
	workers_introduction1 = {
		image = null,
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "WORKERSINTRODUCTION1", reqs = [], previous_dialogue_option = 1},
		],
		options = [
		{code = 'workers_introduction2', text = "WORKERSINTRODUCTIONREPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'workers_introduction2', text = "WORKERSINTRODUCTIONREPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	workers_introduction2 = {
		image = null,
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "WORKERSINTRODUCTION2_1", reqs = [], previous_dialogue_option = 1},
		{text = "WORKERSINTRODUCTION2_2", reqs = [], previous_dialogue_option = 2},
		{text = "WORKERSINTRODUCTION2_3", reqs = [{type = 'main_progress', operant = 'eq', value = 0}], previous_dialogue_option = 1},
		{text = "WORKERSINTRODUCTION2_4", reqs = [], previous_dialogue_option = 3},
		{text = "WORKERSINTRODUCTION2_5", reqs = [], previous_dialogue_option = 4},
		{text = "WORKERSINTRODUCTION2_6", reqs = [], previous_dialogue_option = 5},
		],
		options = [
		{code = 'workers_questions', text = "WORKERSASKQUESTIONS", reqs = [], dialogue_argument = 1},
		{code = 'workers_join', text = "WORKERSINTRODUCTION1REPLY3", reqs = [{type = 'main_progress', operant = 'eq', value = 0}], type = 'next_dialogue', dialogue_argument = 3},
		{code = 'workers_election', text = "WORKERSREQUESTELECTIONSUPPORT", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'stage3'},{type = 'faction_reputation', code = 'workers', operant = 'gte', value = 500}, {type = 'decision', name = 'workers_election_support', value = false}], type = 'next_dialogue', dialogue_argument = 1},
		{code = 'workers_leader_close', text = "WORKERSINTRODUCTION1REPLY4", reqs = [], dialogue_argument = 4, bonus_effects = [{code = "update_guild"}]},
		],
	},
	workers_join = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
		{text = "WORKERSJOIN", reqs = []},
		],
		common_effects = [{code = 'reputation', name = 'workers', operant = '+', value = 100},
		{code = 'make_loot', pool = [['workers_join_reward',1]]}, 
		{code = 'open_loot'}
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue',bonus_effects = [{code = 'create_character', type = 'workers'}, {code = 'main_progress', operant = '+', value = 1},{code = 'progress_quest', value = 'guilds_introduction', stage = 'stage1'},{code = "update_guild"}]},
		]
	},
	workers_leader_close = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
		{text = "WORKERSCLOSE1", reqs = [{type = 'main_progress', operant = 'eq', value = 0}]},
		{text = "WORKERSCLOSE2", reqs = [{type = 'main_progress', operant = 'neq', value = 0}]},
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = "update_guild"}]},
		]
	},
	workers_questions = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
		{text = "WORKERSQUESTIONS_1", reqs = [], previous_dialogue_option = 1, remove_after_first_use = true},
		{text = "WORKERSQUESTIONS_2", reqs = [], previous_dialogue_option = 2, remove_after_first_use = true},
		{text = "WORKERSQUESTIONS_4", reqs = [], previous_dialogue_option = 4, remove_after_first_use = true},
		],
		options = [
		{code = 'workers_questions', text = "WORKERSQUESTIONREPLY1", reqs = [], dialogue_argument = 2, remove_after_first_use = true},
		{code = 'workers_questions', text = "WORKERSQUESTIONREPLY3", reqs = [], dialogue_argument = 4, remove_after_first_use = true},
		{code = 'workers_introduction2', text = "WORKERSASKQUESTIONSRETURN", reqs = [], dialogue_argument = 5},
		],
		
	},
	mages_introduction1 = {
		image = null,
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "MAGESINTRODUCTION1", reqs = [], previous_dialogue_option = 1},
		],
		options = [
		{code = 'mages_introduction2', text = "MAGESINTRODUCTION1REPLY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	mages_introduction2 = {
		image = null,
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "MAGESINTRODUCTION2", reqs = [], previous_dialogue_option = 1},
		],
		options = [
		{code = 'mages_introduction3', text = "MAGESINTRODUCTION2REPLY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	mages_introduction3 = {
		image = null,
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "MAGESINTRODUCTION3_1", reqs = [], previous_dialogue_option = 1, remove_after_first_use = true},
		{text = "MAGESINTRODUCTION3_2", reqs = [], previous_dialogue_option = 2, remove_after_first_use = true},
		{text = "MAGESINTRODUCTION3_3", reqs = [], previous_dialogue_option = 3, remove_after_first_use = true},
		],
		options = [
		{code = 'mages_questions', text = "MAGESASKQUESTIONS", reqs = [], dialogue_argument = 1},
		{code = 'mages_join', text = "MAGESINTRODUCTION3REPLY2", reqs = [{type = 'main_progress', operant = 'eq', value = 0}], type = 'next_dialogue', dialogue_argument = 3},
		{code = 'mages_election', text = "MAGESREQUESTELECTIONSUPPORT", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'stage3'},{type = 'faction_reputation', code = 'mages', operant = 'gte', value = 500}, {type = 'decision', name = 'mages_election_support', value = false}], type = 'next_dialogue', dialogue_argument = 1},
		{code = 'mages_leader_close', text = "MAGESINTRODUCTION3REPLY3", reqs = [], dialogue_argument = 4, bonus_effects = [{code = "update_guild"}]},
		],
	},
	mages_join = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
		{text = "MAGESJOIN", reqs = []},
		],
		common_effects = [{code = 'reputation', name = 'mages', operant = '+', value = 100},
		{code = 'make_loot', pool = [['mages_join_reward',1]]}, 
		{code = 'open_loot'}
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue',bonus_effects = [{code = 'create_character', type = 'mages'}, {code = 'main_progress', operant = '+', value = 1},{code = 'progress_quest', value = 'guilds_introduction', stage = 'stage1'},{code = "update_guild"}]},
		]
	},
	mages_leader_close = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
		{text = "MAGESCLOSE1", reqs = [{type = 'main_progress', operant = 'eq', value = 0}]},
		{text = "MAGESCLOSE2", reqs = [{type = 'main_progress', operant = 'neq', value = 0}]},
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = "update_guild"}]},
		]
	},
	mages_questions = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
		{text = "MAGESQUESTIONS_1", reqs = [], previous_dialogue_option = 1},
		{text = "MAGESQUESTIONS_2", reqs = [], previous_dialogue_option = 2},
		{text = "MAGESQUESTIONS_3", reqs = [], previous_dialogue_option = 3},
		{text = "MAGESQUESTIONS_4", reqs = [], previous_dialogue_option = 4},
		{text = "MAGESQUESTIONS_5", reqs = [], previous_dialogue_option = 5},
		],
		options = [
		{code = 'mages_questions', text = "MAGESQUESTIONREPLY1", reqs = [], dialogue_argument = 2, remove_after_first_use = true},
		{code = 'mages_questions', text = "MAGESQUESTIONREPLY2", reqs = [], dialogue_argument = 3, remove_after_first_use = true},
		{code = 'mages_questions', text = "MAGESQUESTIONREPLY3", reqs = [], dialogue_argument = 4, remove_after_first_use = true},
		{code = 'mages_questions', text = "MAGESQUESTIONREPLY4", reqs = [{type = 'dialogue_seen', operant = 'eq', value = 'MAGESQUESTIONS_4'}], dialogue_argument = 5, remove_after_first_use = true},
		{code = 'mages_introduction3', text = "MAGESASKQUESTIONSRETURN", reqs = [], dialogue_argument = 3},
		],
		
	},
	
	guilds_introduction_stage1 = {
		text = tr("DIALOGUEINTRODUCTIONLETTER"), 
		tags = [],
		image = null, 
		common_effects = [{code = 'progress_quest', value = 'guilds_introduction', stage = 'stage2'}],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE")}
		]
	},
	
	elections_start1 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "ELECTIONSTART1", reqs = [], previous_dialogue_option = 1},
		],
		options = [
		{code = 'elections_start2', text = "ELECTIONSTARTREPLY1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'elections_start2', text = "ELECTIONSTARTREPLY1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	elections_start2 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "ELECTIONSTART2", reqs = []},
		],
		options = [
		{code = 'elections_start3', text = "ELECTIONSTARTREPLY2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'elections_start3', text = "ELECTIONSTARTREPLY2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	elections_start3 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "ELECTIONSTART3", reqs = []},
		],
		options = [
		{code = 'elections_persuade', text = "ELECTIONSTARTREPLY3_1", reqs = [], dialogue_argument = 1},
		{code = 'elections_start4', text = "ELECTIONSTARTREPLY3_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	elections_persuade = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "ELECTIONPERSUADE1", reqs = [], previous_dialogue_option = 1},
		{text = "ELECTIONPERSUADESUCCESS", reqs = [{type = 'master_check', value = [{code = 'stat', type = 'charm_factor', operant = 'gte', value = 3}]}], previous_dialogue_option = 2},
		{text = "ELECTIONPERSUADEFAILURE", reqs = [{type = 'master_check', value = [{code = 'stat', type = 'charm_factor', operant = 'lte', value = 2}]}], previous_dialogue_option = 2},
		],
		options = [
		{code = 'elections_persuade', text = "ELECTIONSTARTREPLY3_2", reqs = [{type = 'dialogue_selected', operant = 'neq', value = 'ELECTIONSTARTREPLY3_2'}], dialogue_argument = 2},
		{code = 'elections_start4', text = "ELECTIONSTARTREPLY3_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	elections_start4 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "ELECTIONSTART4", reqs = []},
		{text = "ELECTIONSTART4_1", reqs = [{type = "faction_reputation", code = 'servants', operant = 'gte', value = 300}], bonus_effects = [{code = 'decision', value = 'servants_election_support'}]},
		{text = "ELECTIONSTART4_2", reqs = []},
		],
		options = [
		{code = 'elections_start5', text = "ELECTIONSTARTREPLY4_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'elections_start5', text = "ELECTIONSTARTREPLY4_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	elections_start5 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "ELECTIONSTART5_1", reqs = [], previous_dialogue_option = 1},
		{text = "ELECTIONSTART5_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [
		{code = 'close', text = "DIALOGUECLOSE", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'guilds_introduction', stage = 'stage3'},{code = "update_guild"}]},
		],
	},
	
	
	
	servants_election = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "SERVANTSELECTIONCONFIRM", reqs = []},
		],
		options = [
		{code = 'close', text = "DIALOGUECLOSE", reqs = [], bonus_effects = [{code = 'decision', value = 'servants_election_support'}]},
		],
	},
	
	fighters_election1 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "FIGHTERSELECTIONSTART1", reqs = []},
		],
		options = [
		{code = 'fighters_election2', text = "FIGHTERSELECTIONSTARTREPLY1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'fighters_election2', text = "FIGHTERSELECTIONSTARTREPLY1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	fighters_election2 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "FIGHTERSELECTIONSTART2", reqs = []},
		],
		options = [
		{code = 'fighters_election3', text = "FIGHTERSELECTIONSTARTREPLY2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'fighters_election3', text = "FIGHTERSELECTIONSTARTREPLY2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	fighters_election3 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "FIGHTERSELECTIONSTART3", reqs = []},
		],
		options = [
		{code = 'fighters_election_details', text = "FIGHTERSELECTIONSTARTREPLY3_1", reqs = [], dialogue_argument = 1},
		{code = 'fighters_election4', text = "FIGHTERSELECTIONSTARTREPLY3_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	fighters_election_details = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "FIGHTERSELECTIONSTART4_1", reqs = []},
		],
		options = [
		{code = 'fighters_election4', text = "FIGHTERSELECTIONSTARTREPLY3_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	fighters_election4 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "FIGHTERSELECTIONSTART4_2", reqs = []},
		],
		options = [
		{code = 'close', text = "DIALOGUECLOSE", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'fighters_election_quest', stage = 'start'}]},
		],
	},
	
	
		lich_enc_initiate = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = tr("LICHENCINITIATE"), reqs = []}
		],
		options = [
			{code = 'lich_enc_fight', text = "LICHENCINITIATEREPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lich_enc_talk1', text = "LICHENCINITIATEREPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
		},

	lich_enc_fight = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "LICHENCFIGHT", reqs = []}
		],
		options = [
			{code = 'lich_start_fight_easy', text = tr("DIALOGUEFIGHTOPTION"), reqs = [], bonus_effects = [{code = 'decision', value = 'aire_is_dead'}], dialogue_argument = 1, type = 'next_dialogue'},
	],
	},

	lich_start_fight_easy = {
		image = null,
		tags = [],
		text = [
			{text = "LICHENCWINAIRENOTDEAD", reqs = []},
		],
		options = [
			{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")},
	],
	},


	lich_enc_talk1 = {
		image = null,
		tags = ['dialogue_scene'],
		text = "LICHENCTALK1",
		options = [
			{code = 'start_lich_fight_normal', text = "LICHENCTALK1REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lich_enc_talk2', text = "LICHENCTALK1REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lich_enc_talk2', text = "LICHENCTALK1REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
	],
	},

	lich_enc_talk2 = {
		image = null,
		tags = ['dialogue_scene'],
		text = "LICHENCTALK2",
		options = [
			{code = 'start_lich_fight_normal', text = "LICHENCTALK2REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lich_enc_talk3', text = "LICHENCTALK2REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'start_lich_fight_normal', text = "LICHENCTALK2REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
	],
	},

	lich_enc_talk3 = {
		image = null,
		tags = ['dialogue_scene'],
		text = "LICHENCTALK3",
		options = [
			{code = 'start_lich_fight_normal', text = "LICHENCTALK3REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lich_enc_talk4', text = "LICHENCTALK3REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lich_enc_conclusion', text = "LICHENCTALK3REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
			{code = 'lich_enc_talk5', text = "LICHENCTALK3REPLY4", reqs = [], dialogue_argument = 4, type = 'next_dialogue'},
	],
	},

	lich_enc_talk4 = {
	image = null,
	tags = ['dialogue_scene'],
	text = "LICHENCTALK4",
	options = [
		{code = 'start_lich_fight_normal', text = "LICHENCTALK4REPLY1", reqs = [], bonus_effects = [{code = 'decision', value = 'lich_extra_reward'}], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_enc_conclusion', text = "LICHENCTALK4REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'lich_enc_talk5', text = "LICHENCTALK4REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
	],
	},

	lich_enc_talk5 = {
	image = null,
	tags = ['dialogue_scene'],
	text = "LICHENCTALK5",
	options = [
		{code = 'start_lich_fight_normal', text = "LICHENCILLKILLYOU", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_enc_conclusion', text = "LICHENCFINE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'lich_enc_talk6', text = "LICHENCTALK5REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
	],
	},

	lich_enc_talk6 ={
		variations = [
			{reqs = [{type = 'master_check', value = [{code = 'stat', type = 'physics_factor', operant = 'gte', value = 4}]}, {type = 'group_size', operant = 'gte', value = 5, orflag = true}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "LICHENCTALK6", reqs = []}],
			options = [
				{code = 'lich_aire_talk1', text = "DIALOGUECONTINUE", reqs = [], bonus_effects = [{code = 'decision', value = 'aire_is_saved'}, {code = 'decision', value = 'deal_with_lich'}], dialogue_argument = 1, type = 'next_dialogue'},
	],
	},
			{reqs = [],
			image = null,
			tags  = ['dialogue_scene'],
			text = [{text = "LICHENCTALK6_1", reqs = []}],
			options = [
				{code = 'start_lich_fight_normal', text = "LICHENCTALK6REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
				{code = 'lich_enc_conclusion', text = "LICHENCTALK6REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			],
		},
	],
	},


	lich_enc_conclusion = {
		image = null,
		tags = [],
		text = [
			{text = 'LICHENCCONLUSION', reqs =[]},
		],
		options = [
			{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION"), bonus_effects = [{code = 'decision', value = 'aire_is_dead'}, {code = 'decision', value = 'deal_with_lich'}]},
	],
	},

	lich_enc_win = {
		variations = [
		{reqs = [{type = 'decision', name = 'aire_is_dead', value = false}],
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "", reqs = []},
		],
		options = [
			{code = 'lich_aire_talk1', reqs = [], text = "LICHENCWINAIRENOTDEAD", dialogue_argument = 1},
		],
		},
		{reqs = [],
		image = null,
		tags  = [],
		text = [
			{text = "LICHENCWINELSE", reqs = []},
		],
		options = [
			{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")},
		],
		},
	],
	},

	start_lich_fight_normal = {
		image = null,
		tags = [],
		text = [
			{text = "LICHFIGHTNORMAL", reqs = []},
		],
		options = [
			{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")},
	],
	},

	lich_aire_talk1 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "LICHAIRETALK1", reqs = []},
		],
		options = [
			{code = 'lich_aire_talk2', text = "LICHAIRETALK1REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lich_aire_leave', text = "LICHAIRETALK1REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lich_aire_talk3', text = "LICHAIRETALK1REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
			{code = 'lich_aire_talk6', text = "LICHAIRETALK1REPLY4", reqs = [], dialogue_argument = 4, type = 'next_dialogue'},
	],
	},


	lich_aire_talk2 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "LICHAIRETALK2", reqs = []},
		],
		options = [
			{code = 'lich_aire_talk5', text = "LICHAIRETALK2REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lich_aire_talk3', text = "LICHAIRETALK2REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lich_aire_leave', text = "LICHAIRETALK2REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
	],
	},

	lich_aire_talk3 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "LICHAIRETALK3", reqs = []},
		],
		options = [
			{code = 'lich_aire_talk4', text = "LICHAIRETALK3REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lich_aire_leave', text = "LICHAIRETALK3REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
	],
	},

	lich_aire_talk4 = {
		variations = [
			{reqs = [
				{type = 'master_check', value = [{code = 'stat', type = 'charm_factor', operant = 'gte', value = 4}]},
		],
		image = null,
		tags = [],
		text = [
			{text = "LICHAIRETALK4", reqs = []},
		],
		options = [
				{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION"), dialogue_argument = 1},
		],
		},
		{reqs = [],
		image = null,
		tags  = ['dialogue_scene'],
		text = [
			{text = "LICHAIRETALK4_1", reqs = []},
		],
		options = [
				{code = 'lich_aire_leave', text = "LICHAIRETALK4_1REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
				{code = 'lich_aire_talk6', text = "LICHAIRETALK4_1REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
		},
	],
	},

	lich_aire_talk5 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "LICHAIRETALK5", reqs = []},
		],
		options = [
			{code = 'lich_aire_talk3', text = "LICHAIRETALK5REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lich_aire_leave', text = "LICHAIRETALK5REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lich_aire_talk6', text = "LICHAIRETALK5REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
	],
	},

	lich_aire_talk6 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "LICHAIRETALK6", reqs = []},
		],
		options = [
			{code = 'lich_aire_talk7', text = "LICHAIRETALK6REPLY1", reqs = [], bonus_effects = [{code = 'decision', value = 'aire_raped'}], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lich_aire_leave', text = "LICHAIRETALK6REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
	],
	},

	lich_aire_talk7 = {
		image = null,
		tags = [],
		text = [
			{text = "LICHAIRETALK7", reqs = []},
		],
		options = [
			{code = 'leave', text = tr("DIALOGUELEAVEOPTION"), reqs = [], bonus_effects = [{code = 'decision', value = 'aire_is_dead'}]},
	],
	},

	lich_aire_leave = {
		image = null,
		tags = [],
		text = [
			{text = "LICHAIRELEAVE", reqs = [], },
		],
		options = [
			{code = 'leave', text = tr("DIALOGUELEAVEOPTION"), reqs = []},
	],
	},
}

var dialogue_inits = {
	fighters_init = [
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [{type = 'dialogue_seen', operant = 'neq', value = 'FIGHTERSINTRODUCTION1'}], 
			target = 'fighters_introduction1',
			target_option = 1,
		},
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [{type = 'main_progress', operant = 'eq', value = 0}], 
			target = 'fighters_introduction2',
			target_option = 3,
		},
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [], 
			target = 'fighters_introduction2',
			target_option = 4,
		},
	],
	servants_init = [
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [{type = 'dialogue_seen', operant = 'neq', value = 'SERVANTSINTRODUCTION1'}], 
			target = 'servants_introduction',
			target_option = 1,
		},
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [{type = 'main_progress', operant = 'eq', value = 0}], 
			target = 'servants_introduction',
			target_option = 2,
		},
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [{type = "active_quest_stage", value = "guilds_introduction", stage = "stage2"}], 
			target = 'elections_start1',
			target_option = 1,
		},
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [], 
			target = 'servants_introduction',
			target_option = 3,
		},
		
	],
	workers_init = [
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [{type = 'dialogue_seen', operant = 'neq', value = 'WORKERSINTRODUCTION1'}], 
			target = 'workers_introduction1',
			target_option = 1,
		},
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [{type = 'main_progress', operant = 'eq', value = 0}], 
			target = 'workers_introduction2',
			target_option = 3,
		},
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [], 
			target = 'workers_introduction2',
			target_option = 4,
		},
	],
	mages_init = [
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [{type = 'dialogue_seen', operant = 'neq', value = 'MAGESINTRODUCTION1'}], 
			target = 'mages_introduction1',
			target_option = 1,
		},
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [{type = 'main_progress', operant = 'eq', value = 0}], 
			target = 'mages_introduction3',
			target_option = 2,
		},
		{
			code = 'default', 
			name = "Meet Leader", 
			reqs = [], 
			target = 'mages_introduction3',
			target_option = 2,
		},
	],
	
	
}

var quests = {
	main_quest = {
		code = 'main_quest',
		stages = {
		start = {code = 'start', name = 'The Loan', descript = 'You must have over 1000 gold by 14th day.',}
		},
	},
	guilds_introduction = {
		code = 'guilds_introduction',
		stages = {
		start = {code = 'start', name = 'The Four Guilds', descript = 'Visit Four Aliron Guilds: Fighters, Servants, Workers, Mages; and choose one to join.'},
		stage1 = {code = 'stage1', name = 'First Step', descript = "Now, that you got accostumed with Aliron's order, you should start making progress with your standing. Earn at least 300 reputation with one of the main guilds."},
		stage1_5 = {code = 'stage1_5', name = 'First Step', descript = "You've earned enough reputation with one of the factions. Wait for a few days."},

		stage2 = {code = 'stage2', name = 'New Friends', descript = "An unexpected letter came last morning. It suggests you to visit Servants guild and meet their leader. "},
		stage3 = {code = 'stage3', name = 'Community', descript = "According to City's electon process, any land owner is capable of becoming a mayor, as long as they are supported by the Guilds. Earn 500 reputation with at least 3 main Guilds and acquire their support for future election.\n\n{custom_text_function=election_quest_text|} "},
		},
	},
	fighters_election_quest = {
		code = 'fighters_election_quest',
		stages = {
			start = {code = 'start', name = "Rite of Passage", descript = "Obtain and deliver Lich's skull to Fighters Guild to make them support you for Mayor Elections. Duncan gave me a location where I can find one."}
		},
		
	}
	
}

