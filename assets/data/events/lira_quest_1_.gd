extends Reference
var data = {
	lira_quest_1_head_back = {
		image = null, character = '$lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST_1_HEAD_BACK", 
		common_effects = [
			{code = 'complete_quest', value = 'lira_quest_1'},
			{code = 'remove_quest_location', value = 'quest_lira_grove_location'},
			{code = "plan_loc_event", loc = "aliron", event = "lira_quest2_day_usual_step_outside_mansion"},
			{code = "add_timed_event", value = "canVisitFair", args = [{type = "action_to_date", date = [1, 1], hour = 1, action = "decision"}]},
#					{code = 'progress_quest', value = 'lira_quest_2', stage = 'start'}, #need adding a timed planned event instead
			{code = 'update_location'}
		],
		options = [
			{code = 'lira_bonus1_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,},
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,},
		],
	},
}
