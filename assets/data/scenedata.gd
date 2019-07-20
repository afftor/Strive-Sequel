extends Node

var scenedict = {
	childbirth = {text = tr("DIALOGUECHILDBIRTHTEXT"), image = null, options = [{code = 'keepbaby', reqs = [], text = tr("DIALOGUEKEEPBABY")}, {code = 'removebaby', reqs = [], text = tr("DIALOGUEREMOVEBABY")}]},
	
	slave_escape = {text = tr("DIALOGUEESCAPETEXT"), image = null, options = [{code = 'close', reqs = [], text = tr("DIALOGUEESCAPECLOSE")}]},
	
	
	dialogue_praise = {text = tr('DIALOGUEPRAISETEXT'), image = null, options = [{code = 'close', reqs = [], text = tr('DIALOGUEPRAISECLOSE')}]},
	
	
	
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
	
	
}
