extends Reference
var data = {
	lira_quest2_epilogue2 = {
		image = null, character = 'lira_tribal',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_THOUGHT_HAPPY_LIVING_TEMPLE",
		common_effects = [
			{code = 'complete_quest', value = 'lira_quest_2'}, 
#			{code = 'progress_quest', value = 'lira_quest_3', stage = 'start'}, 
			{code = 'add_timed_event', value = "lira_quest3_intro_1", args = [{type = 'add_to_date', date = [1,1], hour = 1}]},
			{code = 'update_city'}
		],
		options = [
			{code = 'lira_bonus2_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,},
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,},
		],
	},
}
