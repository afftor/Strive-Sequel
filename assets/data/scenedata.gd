extends Node

var scenedict = {
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
	
	
}
