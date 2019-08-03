extends Node

var scenedict = {
	childbirth = {text = tr("DIALOGUECHILDBIRTHTEXT"), image = null, options = [{code = 'keepbaby', reqs = [], text = tr("DIALOGUEKEEPBABY")}, {code = 'removebaby', reqs = [], text = tr("DIALOGUEREMOVEBABY")}]},
	
	slave_escape = {text = tr("DIALOGUEESCAPETEXT"), image = null, options = [{code = 'close', reqs = [], text = tr("DIALOGUEESCAPECLOSE")}]},
	
	
	dialogue_praise = {text = tr('DIALOGUEPRAISETEXT'), image = null, options = [{code = 'close', reqs = [], text = tr('DIALOGUEPRAISECLOSE')}]},
	
	location_event_search = {text = tr("DIALOGUELOCATIONEVENT"), image = null, options = [{code = 'good_event', reqs = [], text = tr("DIALOGUELOCATIONEVENTGOOD")},{code = 'evil_event', reqs = [], text = tr("DIALOGUELOCATIONEVENTEVIL")},{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")}]},
	
	character_boss_defeat = {text = tr("DIALOGUERANDOMBOSSDEFEAT"), 
	image = null, 
	options = [
	{code = 'recruit', reqs = [], text = tr("DIALOGUERECRUITBOSSOPTION")},
	{code = 'execute', reqs = [], text = tr("DIALOGUEEXECUTEOPTION")}
	]
	},
	finish_quest_dungeon = {text = tr("DIALOGUEDUNGEONQUESTCOMPLETE"), 
	image = null, 
	options = [
	{code = 'close', reqs = [], text = tr("DIALOGUEPRAISECLOSE")},
	]
	},
	
	dungeon_find_chest_easy = {
		text = tr("DIALOGUEDUNGEONFINDCHEST"), 
		image = null,
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
		tags = ['linked_event'],
		receiver = 'master',
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
		common_effects = [{code = 'make_story_character', value = 'Daisy'}],
		options = [
		{code = 'close', text = 'Close', reqs = []},
		],
	},
	daisy_purchase = {
		text = "You offer the man to purchase poor girl from him.\n\nAfter some negotiations he offers you the price of 300 gold for her. ",
		tags = ['linked_event'],
		receiver = 'master',
		image = null,
		options = [{code = 'daisy_purchase_negotiate', text = "Ask for a discount", reqs = []},
		{code = 'daisy_purchase_confirm', text = "Purchase", reqs = [{type = "has_money", value = 300}]},
		{code = 'daisy_purchase_leave', text = 'Refuse', reqs = []},
		],
	},
	daisy_purchase_negotiate = {
		variations = [
			{reqs = [{type = 'master_stat', name = 'charm_factor', operant = 'gte', value = 3}, 
			{type = 'master_stat', name = 'charm', operant = 'gte', value = 15, orflag = true}],
			text = "With some additional points you manage to make the man drop his demand to 200 gold. But this is his last word.",
			sceneeffects = [],
			tags = ['linked_event'],
			image = null,
			options = [
				{code = 'daisy_purchase_confirm_discount', text = "Purchase", reqs = [{type = "has_money", value = 200}]},
				{code = 'daisy_purchase_leave', text = 'Refuse', reqs = []},
				]
			},
			{reqs = [],
			text = "Your futher attempts to bring girl's price down have failed and the man asks for 300 gold or tells you to beg off.",
			image = null,
			sceneeffects = [],
			tags = ['linked_event'],
			options = [
				{code = 'daisy_purchase_confirm', text = "Purchase", reqs = [{type = "has_money", value = 300}]},
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
		common_effects = [{code = 'money_change', operant = '-', value = 300}, {code = 'make_story_character', value = 'Daisy'}],
		options = [
		{code = 'close', text = 'Close', reqs = []},
		],
	},
	daisy_purchase_confirm_discount = {
		text = "You pay the price and bunny girl move warily to your side. You learn that her name is Daisy.\n\nShe promises to do her best, but you can see her clearly forcing herself to look up at you. ",
		tags = [],
		receiver = 'master',
		image = null,
		common_effects = [{code = 'money_change', operant = '-', value = 200}, {code = 'make_story_character', value = 'Daisy'}],
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
	
}