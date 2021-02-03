var data = {
	final_operation_start = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_START"), reqs = []},
		],
		options = [
			{
				code = 'final_operation_1',
				text = tr("FINAL_OPERATON_START_OPTION_1"),
				reqs = [],
				dialogue_argument = 1
			},
			{
				code = 'final_operation_2',
				text = tr("FINAL_OPERATON_START_OPTION_2"),
				reqs = [],
				dialogue_argument = 2
			},
		],
	},
	final_operation_1 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_1"), reqs = [], previous_dialogue_option = 1},
			{text = tr("FINAL_OPERATON_3"), reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = 'final_operation_1',
				text = tr("FINAL_OPERATON_OPTION_1"),
				reqs = [],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = 'final_operation_4',
				text = tr("FINAL_OPERATON_OPTION_2"),
				reqs = [],
				dialogue_argument = 3
			},
			{
				code = 'final_operation_4',
				text = tr("FINAL_OPERATON_OPTION_3"),
				reqs = [],
				dialogue_argument = 4
			},
		],
	},
	final_operation_2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_2"), reqs = [], previous_dialogue_option = 2},
			{text = tr("FINAL_OPERATON_3"), reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{
				code = 'final_operation_2',
				text = tr("FINAL_OPERATON_OPTION_1"),
				reqs = [],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = 'final_operation_4',
				text = tr("FINAL_OPERATON_OPTION_2"),
				reqs = [],
				dialogue_argument = 4
			},
			{
				code = 'final_operation_4',
				text = tr("FINAL_OPERATON_OPTION_3"),
				reqs = [],
				dialogue_argument = 5
			},
		],
	},
	final_operation_4 = {
		image = null,
		tags = ['master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_4"), reqs = []},
		],
		options = [
			{code = 'leave', text = tr("DIALOGUELEAVE"), reqs = []},
		],
	},
}
