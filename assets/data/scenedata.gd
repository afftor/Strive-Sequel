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
}