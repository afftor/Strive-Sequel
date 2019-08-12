extends Node

var scenedict = {
	childbirth = {text = tr("DIALOGUECHILDBIRTHTEXT"), image = null, tags = [], options = [{code = 'keepbaby', reqs = [], text = tr("DIALOGUEKEEPBABY")}, {code = 'removebaby', reqs = [], text = tr("DIALOGUEREMOVEBABY")}]},
	
	slave_escape = {text = tr("DIALOGUEESCAPETEXT"), image = null, tags = [], options = [{code = 'close', reqs = [], text = tr("DIALOGUEESCAPECLOSE")}]},
	
	
	#dialogue_praise = {text = tr('DIALOGUEPRAISETEXT'),tags = [], image = null, options = [{code = 'close', reqs = [], text = tr('DIALOGUECLOSE')}]},
	
	location_event_search = {text = tr("DIALOGUELOCATIONEVENT"), tags = [], image = null, options = [{code = 'good_event', reqs = [], text = tr("DIALOGUELOCATIONEVENTGOOD")},{code = 'evil_event', reqs = [], text = tr("DIALOGUELOCATIONEVENTEVIL")},{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}]},
	
	character_boss_defeat = {text = tr("DIALOGUERANDOMBOSSDEFEAT"), 
	image = null, 
	tags = [],
	options = [
	{code = 'recruit', reqs = [], text = tr("DIALOGUERECRUITBOSSOPTION")},
	{code = 'execute', reqs = [], text = tr("DIALOGUEEXECUTEOPTION")}
	]
	},
	finish_quest_dungeon = {text = tr("DIALOGUEDUNGEONQUESTCOMPLETE"), 
	image = null,
	tags = [], 
	options = [
	{code = 'close', reqs = [], text = tr("DIALOGUEPRAISECLOSE")},
	]
	},
	
	dungeon_find_chest_easy = {
		text = tr("DIALOGUEDUNGEONFINDCHEST"), 
		image = null,
		tags = [],
		options = [
		{code = 'open_chest_easy', reqs = [], text = tr("DIALOGUECHESTOPEN")},
		{code = 'leave', reqs = [], text = tr("DIALOGUECHESTLEAVE")},
		],
	},
	
	event_good_recruit = {text = tr("DIALOGUEEVENTGOODRECRUIT"), 
	args = {characterdata = {}},
	tags = ['good'],
	default_event_type = "character_event",
	image = null, 
	bonus_args = {characterdata = {type = 'function', function = 'make_local_recruit', args = {}}},
	options = [
	{code = 'recruit', reqs = [], text = tr("DIALOGUERECRUITCHARACTEROPTION")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
	]
	},
	
	event_good_loot_small = {text = tr("DIALOGUEEVENTGOODRECRUIT"), 
	tags = ['good'],
	default_event_type = "loot",
	image = null, 
	bonus_args = {loot_data = {type = 'function', function = 'make_location_chest_loot', args = {subtype = 'small'}}},
	options = [
	{code = 'get_loot', reqs = [], text = tr("DIALOGUEFORCECHESTOPEN")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
	]
	},
	
	event_nothing_found = {text = tr("DIALOGUEEVENTGOODRECRUIT"), 
	tags = ['good'],
	default_event_type = "loot",
	image = null, 
	bonus_args = {loot_data = {type = 'function', function = 'make_location_chest_loot', args = {subtype = 'small'}}},
	options = [
	{code = 'get_loot', reqs = [], text = tr("DIALOGUEFORCECHESTOPEN")},
	{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}
	]
	},
	
	
	#Story Events
	daisy_meet = {
		text = tr('SCENEDAISY_MEET_TEXT'),
		tags = ['linked_event'],#linked_event means that all options will trigger other events by name instead of generic options like 'close' or 'inspect'
		receiver = 'master', #not used yet but supposed to represent a group of characters involved into event
		image = null, 
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
		image = null,
		common_effects = [{code = 'make_story_character', value = 'Daisy'},{code = 'add_timed_event', value = "daisy_first_event", args = [{type = 'add_to_date', date = [4,6], hour = 18}]}],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	daisy_purchase = {
		text = tr("SCENEDAISY_PURCHASE_TEXT"),
		tags = ['linked_event'],
		receiver = 'master',
		image = null,
		options = [{code = 'daisy_purchase_negotiate', text = tr("SCENEDAISY_PURCHASE_OPTION1"), reqs = []},
		{code = 'daisy_purchase_confirm', text = tr("SCENEDAISY_PURCHASE_OPTION2"), reqs = [{type = "has_money", value = 200}]},
		{code = 'daisy_purchase_leave', text = tr("SCENEDAISY_PURCHASE_OPTION3"), reqs = []},
		],
	},
	daisy_purchase_negotiate = {
		variations = [ #variations are used if previous option can have multiple outcomes. If variation's requirements are passed it triggers and the rest is ignored. Priority is set by order. 
			{reqs = [{type = 'master_stat', name = 'charm_factor', operant = 'gte', value = 3}, 
			{type = 'master_stat', name = 'charm', operant = 'gte', value = 15, orflag = true}],
			text = tr("SCENEDAISY_PURCHASE_NEGOTIATE_TEXT1"),
			sceneeffects = [],
			tags = ['linked_event'],
			image = null,
			options = [
				{code = 'daisy_purchase_confirm_discount', text = tr("SCENEDAISY_PURCHASE_OPTION2"), reqs = [{type = "has_money", value = 100}]},
				{code = 'daisy_purchase_leave', text = tr("SCENEDAISY_PURCHASE_OPTION3"), reqs = []},
				]
			},
			{reqs = [],
			text = tr("SCENEDAISY_PURCHASE_NEGOTIATE_TEXT2"),
			image = null,
			sceneeffects = [],
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
		image = null,
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
		image = null,
		common_effects = [{code = 'money_change', operant = '-', value = 100}, {code = 'make_story_character', value = 'Daisy'}, {code = 'add_timed_event', value = "daisy_first_event", args = [{type = 'add_to_date', date = [4,6], hour = 18}]}],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	daisy_purchase_leave = {
		text = tr("SCENEDAISY_PURCHASE_LEAVE_TEXT"),
		tags = [],
		receiver = 'master',
		image = null,
		common_effects = [],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
	daisy_ignore_purchase = {
		text = tr("SCENEDAISY_IGNORE_TEXT"),
		tags = [],
		receiver = 'master',
		image = null,
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
		image = null,
		options = [
		{code = 'daisy_first_event_reassure', text = tr("SCENEDAISY_FIRST_EVENT_OPTION1"), reqs = []},
		{code = 'daisy_first_event_discipline', text = tr("SCENEDAISY_FIRST_EVENT_OPTION2"), reqs = []},
		],
	},
	daisy_first_event_reassure = {
		text = tr("SCENEDAISY_FIRST_EVENT_REASSURE"),
		tags = [],
		receiver = 'master',
		image = null,
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
		image = null,
		common_effects = [{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'sexuals_factor', value = 1, operant = "+"},
			{code = 'sextrait', value = 'submissive', operant = 'add'},#for sextrait/add setting, trait is appended to character's traits
			{code = 'fear', operant = '+', value = 75},
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
		image = null,
		options = [
		{code = 'daisy_confess_accept', text = tr("SCENEDAISY_CONFESS_EVENT_OPTION1"), reqs = []},
		{code = 'daisy_confess_refuse', text = tr("SCENEDAISY_CONFESS_EVENT_OPTION2"), reqs = []},
		],
	},
	daisy_confess_accept = {
		text = tr("SCENEDAISY_CONFESS_ACCEPT_TEXT"),
		tags = [],
		receiver = 'master',
		image = null,
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
		image = null,
		common_effects = [
		{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'tag', operant = 'remove', value = 'no_sex'},
			]},
		],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
}