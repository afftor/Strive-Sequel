extends Reference
var data = {
	final_operation_workers_1 = {
		image = null,
		character = 'sigmund',
		tags = ['master_translate'],
		text = [
			{text = "FINAL_OPERATON_WORKERS_1", reqs = []},
		],
		options = [
			{code = 'leave', text = "DIALOGUELEAVE", reqs = [], bonus_effects = [{code = "update_guild"}]},
		],
	},
	final_operation_servants_1 = {
		image = null,
		character = 'amelia',
		tags = ['master_translate'],
		text = [
			{text = "FINAL_OPERATON_SERVANTS_1", reqs = []},
		],
		options = [
			{code = 'leave', text = "DIALOGUELEAVE", reqs = [], bonus_effects = [{code = "update_guild"}]},
		],
	},
	final_operation_mages_1 = {
		image = null,
		character = 'myr',
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "FINAL_OPERATON_MAGES_1", reqs = []},
		],
		options = [
			{
				code = 'final_operation_mages_2',
				text = "FINAL_OPERATON_MAGES_1_OPTION_1",
				reqs = [],
				dialogue_argument = 1
			},
			{
				code = 'final_operation_mages_5_4',
				text = "FINAL_OPERATON_MAGES_1_OPTION_2",
				reqs = [],
				dialogue_argument = 2
			},
		],
	},
	final_operation_mages_2 = {
		image = null,
		character = 'myr',
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "FINAL_OPERATON_MAGES_2", reqs = []},
		],
		options = [
			{
				code = 'final_operation_mages_3_1',
				text = "FINAL_OPERATON_MAGES_2_OPTION_1",
				reqs = [{type = 'faction_reputation', code = 'mages', operant = 'gte', value = 2000},],
				dialogue_argument = 1
			},
			{
				code = 'final_operation_mages_3_2',
				text = "FINAL_OPERATON_MAGES_2_OPTION_2",
				reqs = [], #if player acquired bonus reward from mages guild during Fred ques
				dialogue_argument = 2
			},
			{
				code = 'final_operation_mages_5_1',
				text = "FINAL_OPERATON_MAGES_2_OPTION_3",
				reqs = [],
				dialogue_argument = 3
			},
		],
	},
	final_operation_mages_5_1 = {
		variations = [
			{  # no help
				image = null,
				character = 'myr',
				tags = ['master_translate'],
				text = "FINAL_OPERATON_MAGES_5_1",
				reqs = [{type = 'decision', value = 'slept_with_xari', check = true}],
				options = [
					{code = 'leave', text = "DIALOGUELEAVE", reqs = [], bonus_effects = [{code = "update_guild"}]},
				]
			},
			{
				image = null,
				character = 'myr',
				tags = ['dialogue_scene'],
				text = "FINAL_OPERATON_MAGES_5_2",
				reqs = [],
				options = [
					{
						code = 'final_operation_mages_5_3',
						text = "FINAL_OPERATON_MAGES_3_OPTION_1",
						reqs = [{type = "has_money", value = 300}],
						type = 'next_dialogue',
						dialogue_argument = 1
					},
					{
						code = 'final_operation_mages_4',
						text = "FINAL_OPERATON_MAGES_3_OPTION_2",
						reqs = [],
						type = 'next_dialogue',
						dialogue_argument = 2
					},
				]
			},
		],
	},
	final_operation_mages_5_4 = { # no help
		image = null,
		character = 'myr',
		tags = ['master_translate'],
		text = [
			{text = "FINAL_OPERATON_MAGES_5_4", reqs = []},
		],
		options = [
			{code = 'leave', text = "DIALOGUELEAVE", reqs = [], bonus_effects = [{code = "update_guild"}]},
		],
	},
	final_operation_mages_3_1 = { # help
		image = null,
		character = 'myr',
		tags = ['master_translate'],
		text = [
			{text = "FINAL_OPERATON_MAGES_3_1", reqs = []},
		],
		common_effects = [{code = 'decision', value = 'MagesHelpDuncan'}],
		options = [
			{code = 'leave', text = "DIALOGUELEAVE", reqs = [], bonus_effects = [{code = "update_guild"}]},
		],
	},
	final_operation_mages_3_2 = {
		image = null,
		character = 'myr',
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "FINAL_OPERATON_MAGES_3_2", reqs = []},
		],
		options = [
			{
				code = 'final_operation_mages_5_3',
				text = "FINAL_OPERATON_MAGES_3_OPTION_1",
				reqs = [{type = "has_money", value = 300}],
				dialogue_argument = 1
			},
			{
				code = 'final_operation_mages_4',
				text = "FINAL_OPERATON_MAGES_3_OPTION_2",
				reqs = [],
				dialogue_argument = 2
			},
		],
	},
	final_operation_mages_4 = { # no help
		image = null,
		character = 'myr',
		tags = ['master_translate'],
		text = [
			{text = "FINAL_OPERATON_MAGES_4", reqs = []},
		],
		options = [
			{code = 'leave', text = "DIALOGUELEAVE", reqs = [], bonus_effects = [{code = "update_guild"}]},
		],
	},
	final_operation_mages_5_3 = { # help
		image = null,
		character = 'myr',
		tags = ['master_translate'],
		text = [
			{text = "FINAL_OPERATON_MAGES_5_3", reqs = []},
		],
		common_effects = [{code = 'money_change', operant = '-', value = 300}, {code = 'decision', value = 'MagesHelpDuncan'}],
		options = [
			{code = 'leave', text = "DIALOGUELEAVE", reqs = [], bonus_effects = [{code = "update_guild"}]},
		],
	},
}
