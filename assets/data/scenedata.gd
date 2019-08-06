extends Node

var scenedict = {
	childbirth = {text = tr("DIALOGUECHILDBIRTHTEXT"), image = null, tags = [], options = [{code = 'keepbaby', reqs = [], text = tr("DIALOGUEKEEPBABY")}, {code = 'removebaby', reqs = [], text = tr("DIALOGUEREMOVEBABY")}]},
	
	slave_escape = {text = tr("DIALOGUEESCAPETEXT"), image = null, tags = [], options = [{code = 'close', reqs = [], text = tr("DIALOGUEESCAPECLOSE")}]},
	
	
	dialogue_praise = {text = tr('DIALOGUEPRAISETEXT'),tags = [], image = null, options = [{code = 'close', reqs = [], text = tr('DIALOGUEPRAISECLOSE')}]},
	
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
		text = "As you walk around the town, you notice a commotion. A large man yells at crying young halfkin bunny girl sitting near the pottery shards.\n\n- You clumsy dumbass! This was the third time. I'm selling you to the brothel now, this way at least you will be useful at something.\n\nThe girl does seem to be not suited for manual labor, but is fairly appealing. ",
		tags = ['linked_event'],#linked_event means that all options will trigger other events by name instead of generic options like 'close' or 'inspect'
		receiver = 'master', #not used yet but supposed to represent a group of characters involved into event
		image = null, 
		options = [
		{code = 'daisy_purchase', text = "Offer to purchase the girl", reqs = []},
		{code = 'daisy_claim_kinship', text = "Demand the girl as your kinsman", reqs = [{type = 'master_is_beast', value = true}]},
		{code = 'daisy_ignore_purchase', text = 'Ignore', reqs = []},
		],
	},
	daisy_claim_kinship = {
		text = "You tell the man that the girl is your kinsman and his behavior is unnacceptable.\n\nTaken aback by your interruption, he quickly falls back and passes her to you.\n\nThe girl seemingly relieved, even though she saw through your lie. \n\nShe tells that her name is Daisy and she will try her best for you. ",
		tags = [],
		receiver = 'master',
		image = null,
		common_effects = [{code = 'make_story_character', value = 'Daisy'},{code = 'add_timed_event', value = "daisy_first_event", args = [{type = 'add_to_date', date = [4,6], hour = 18}]}],
		options = [
		{code = 'close', text = 'Close', reqs = []},
		],
	},
	daisy_purchase = {
		text = "You offer the man to purchase poor girl from him.\n\nAfter some negotiations he offers you the price of 200 gold for her. ",
		tags = ['linked_event'],
		receiver = 'master',
		image = null,
		options = [{code = 'daisy_purchase_negotiate', text = "Ask for a discount", reqs = []},
		{code = 'daisy_purchase_confirm', text = "Purchase", reqs = [{type = "has_money", value = 200}]},
		{code = 'daisy_purchase_leave', text = 'Refuse', reqs = []},
		],
	},
	daisy_purchase_negotiate = {
		variations = [ #variations are used if previous option can have multiple outcomes. If variation's requirements are passed it triggers and the rest is ignored. Priority is set by order. 
			{reqs = [{type = 'master_stat', name = 'charm_factor', operant = 'gte', value = 3}, 
			{type = 'master_stat', name = 'charm', operant = 'gte', value = 15, orflag = true}],
			text = "With some additional points you manage to make the man drop his demand to 100 gold. But this is his last word.",
			sceneeffects = [],
			tags = ['linked_event'],
			image = null,
			options = [
				{code = 'daisy_purchase_confirm_discount', text = "Purchase", reqs = [{type = "has_money", value = 100}]},
				{code = 'daisy_purchase_leave', text = 'Refuse', reqs = []},
				]
			},
			{reqs = [],
			text = "Your futher attempts to bring girl's price down have failed and the man asks for 200 gold or tells you to beg off.",
			image = null,
			sceneeffects = [],
			tags = ['linked_event'],
			options = [
				{code = 'daisy_purchase_confirm', text = "Purchase", reqs = [{type = "has_money", value = 200}]},
				{code = 'daisy_purchase_leave', text = 'Refuse', reqs = []},
				],
				
			}
		],
	},
	daisy_purchase_confirm = {
		text = "You pay the price and bunny girl move warily to your side. You learn that her name is Daisy.\n\nShe promises to do her best, but you can see her clearly forcing herself to look up at you. ",
		tags = [],
		receiver = 'master',
		image = null,
		common_effects = [{code = 'money_change', operant = '-', value = 200}, 
		{code = 'make_story_character', value = 'Daisy'}, #make_story_character takes character data from worldgen.pregen_characters
		{code = 'add_timed_event', value = "daisy_first_event", args = [{type = 'add_to_date', date = [4,6], hour = 18}]}],
		options = [
		{code = 'close', text = 'Close', reqs = []},
		],
	},
	daisy_purchase_confirm_discount = {
		text = "You pay the price and bunny girl move warily to your side. You learn that her name is Daisy.\n\nShe promises to do her best, but you can see her clearly forcing herself to look up at you. ",
		tags = [],
		receiver = 'master',
		image = null,
		common_effects = [{code = 'money_change', operant = '-', value = 100}, {code = 'make_story_character', value = 'Daisy'}, {code = 'add_timed_event', value = "daisy_first_event", args = [{type = 'add_to_date', date = [4,6], hour = 18}]}],
		options = [
		{code = 'close', text = 'Close', reqs = []},
		],
	},
	daisy_purchase_leave = {
		text = "You refuse the man's price and walk away from the scene.",
		tags = [],
		receiver = 'master',
		image = null,
		common_effects = [],
		options = [
		{code = 'close', text = 'Close', reqs = []},
		],
	},
	daisy_ignore_purchase = {
		text = "You continue your way without paying any further attention to them.",
		tags = [],
		receiver = 'master',
		image = null,
		common_effects = [],
		options = [
		{code = 'close', text = 'Close', reqs = []},
		],
	},
	
	daisy_first_event = {
		text = "You hear the crash and soon find Daisy, who seem to have destroyed a piece of tableware.\n\nTeary eyed she looks up at you waiting for your punishment. ",
		tags = ['linked_event'],
		receiver = 'master',
		reqs = [{type = 'unique_character_at_mansion', value = 'daisy', negative = 'repeat_next_day'}],#this requirement only applies when checking timed_events. 'negative' means what resolution should apply when requirement is not met.
		image = null,
		options = [
		{code = 'daisy_first_event_reassure', text = "Reassure her", reqs = []},
		{code = 'daisy_first_event_discipline', text = 'Discipline her', reqs = []},
		],
	},
	daisy_first_event_reassure = {
		text = "You help and encourage her to do better next time.\n\nTaken back by your kindness, Daisy's expression badly hides her inner happiness.",
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
		{code = 'close', text = 'Close', reqs = []},
		],
	},
	daisy_first_event_discipline = {
		text = "You take shiverring Daisy into a private room.\n\nStarting with some pain and humiliation you gradually provide her body with new sensations.\n\nHer cries of pain slowly obtain a new notes.\n\nAnd her teared eyes reflect not only a fear, but a drunk bliss.\n\nAfterwards you make sure she learned her lesson and she responds with respectful eagerness.",
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
		{code = 'close', text = 'Close', reqs = []},
		],
	},
	daisy_confess_event = {
		text = "As you walk around the mansion, you notice Daisy looking depressed.\n\nYou approach her and ask what happened, but she worryingly dodges the question.\n\nAfter ordering her to tell what's wrong she finally cracks up. \n\n- I... I love [master], but there's no way [he] will ever love someone useless like me. ",
		tags = ['linked_event','master_translate'],
		reqs = [{type = 'unique_character_at_mansion', value = 'daisy', negative = 'repeat_next_day'}],
		receiver = 'master',
		image = null,
		options = [
		{code = 'daisy_confess_accept', text = "Accept her feelings", reqs = []},
		{code = 'daisy_confess_refuse', text = 'Refuse her', reqs = []},
		],
	},
	daisy_confess_accept = {
		text = "- N..No way! You feel the same?! I can't believe it...\n\nYou seal your lips with Daisy and she gives in into your embrace.\n\nThis night she's hoping to spend with you.",
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
		{code = 'close', text = 'Close', reqs = []},
		],
	},
	daisy_confess_refuse = {
		text = "You politely refuse Daisy's proposal.\n\n- I see... But if that's too much for you, I could be your... night servant.\n\nIt seems Daisy still has some leftover hope to eventually win you over. ",
		tags = [],
		receiver = 'master',
		image = null,
		common_effects = [
		{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'tag', operant = 'remove', value = 'no_sex'},
			]},
		],
		options = [
		{code = 'close', text = 'Close', reqs = []},
		],
	},
}