extends Reference
var data = {

	final_operation_message = {
		common_effects = [], #adds option to talk to duncan in intoduction
		image = "letter", tags = ['dialogue_scene'],
		text = [{text = "FINAL_OPERATION_MESSAGE", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 2, type = 'next_dialogue', bonus_effects = [{code = 'progress_quest', value = 'final_operation', stage = 'stage1'}, {code = 'rewrite_save'}],
		}],
	},

	final_operation_start = {
		image = null,
		character = "duncan",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "FINAL_OPERATON_START", reqs = []},
		],
		common_effects = [{code = 'make_quest_location', value = 'quest_final_operation_location'}],
		options = [
			{
				code = 'final_operation_1',
				text = "FINAL_OPERATON_START_OPTION_1",
				reqs = [], type = 'next_dialogue',
				dialogue_argument = 1
			},
			{
				code = 'final_operation_2',
				text = "FINAL_OPERATON_START_OPTION_2",
				reqs = [], type = 'next_dialogue',
				dialogue_argument = 2
			},
		],
	},
	final_operation_1 = {
		image = null,
		character = "duncan",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "FINAL_OPERATON_1", reqs = [], previous_dialogue_option = 1},
			{text = "FINAL_OPERATON_3", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = 'final_operation_1',
				text = "FINAL_OPERATON_OPTION_1",
				reqs = [],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = 'final_operation_4',
				text = "FINAL_OPERATON_OPTION_2",
				reqs = [], type = 'next_dialogue',
				dialogue_argument = 3
			},
			{
				code = 'final_operation_4',
				text = "FINAL_OPERATON_OPTION_3",
				reqs = [], type = 'next_dialogue',
				dialogue_argument = 4
			},
		],
	},
	final_operation_2 = {
		image = null,
		character = "duncan",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "FINAL_OPERATON_2", reqs = [], previous_dialogue_option = 2},
			{text = "FINAL_OPERATON_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{
				code = 'final_operation_2',
				text = "FINAL_OPERATON_OPTION_1",
				reqs = [],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = 'final_operation_4',
				text = "FINAL_OPERATON_OPTION_2",
				reqs = [], type = 'next_dialogue',
				dialogue_argument = 4
			},
			{
				code = 'final_operation_4',
				text = "FINAL_OPERATON_OPTION_3",
				reqs = [], type = 'next_dialogue',
				dialogue_argument = 5
			},
		],
	},
	final_operation_4 = {
		image = null,
		character = "duncan",
		tags = ['master_translate'],
		text = [
			{text = "FINAL_OPERATON_4", reqs = []},
		],
		options = [
			{code = 'leave', type = 'next_dialogue', text = "DIALOGUELEAVE", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'final_operation', stage = 'stage2'}, {code = "update_guild"}]},
		],
	},
}
