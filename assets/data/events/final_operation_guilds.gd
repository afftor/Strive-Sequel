var data = {
	final_operation_workers_1 = {
		image = null,
		tags = ['master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_WORKERS_1"), reqs = []},
		],
		options = [
			{code = 'leave', text = tr("DIALOGUELEAVE"), reqs = []},
		],
	},
	final_operation_servants_1 = {
		image = null,
		tags = ['master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_SERVANTS_1"), reqs = []},
		],
		options = [
			{code = 'leave', text = tr("DIALOGUELEAVE"), reqs = []},
		],
	},
	final_operation_mages_1 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_MAGES_1"), reqs = []},
		],
		options = [
			{
				code = 'final_operation_mages_2',
				text = tr("FINAL_OPERATON_MAGES_1_OPTION_1"),
				reqs = [],
				dialogue_argument = 1
			},
			{
				code = 'final_operation_mages_5_4',
				text = tr("FINAL_OPERATON_MAGES_1_OPTION_2"),
				reqs = [],
				dialogue_argument = 2
			},
		],
	},
	final_operation_mages_2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_MAGES_2"), reqs = []},
		],
		options = [
			{
				code = 'final_operation_mages_3_1',
				text = tr("FINAL_OPERATON_MAGES_2_OPTION_1"),
				reqs = [],
				dialogue_argument = 1
			},
			{
				code = 'final_operation_mages_3_2',
				text = tr("FINAL_OPERATON_MAGES_2_OPTION_2"),
				reqs = [],
				dialogue_argument = 2
			},
			{
				code = 'final_operation_mages_5_1',
				text = tr("FINAL_OPERATON_MAGES_2_OPTION_3"),
				reqs = [],
				dialogue_argument = 3
			},
		],
	},
	final_operation_mages_5_1 = {
		variations = [
			{
				image = null,
				# character = 'xari',
				tags = ['master_translate'],
				text = "FINAL_OPERATON_MAGES_5_1",
				reqs = [],
				options = [
					{code = 'leave', text = tr("DIALOGUELEAVE"), reqs = []},
				]
			},
			{
				image = null,
				# character = 'xari',
				tags = ['dialogue_scene'],
				text = "FINAL_OPERATON_MAGES_5_2",
				reqs = [],
				options = [
					{
						code = 'final_operation_mages_5_3',
						text = tr("FINAL_OPERATON_MAGES_3_OPTION_1"),
						reqs = [],
						type = 'next_dialogue',
						dialogue_argument = 1
					},
					{
						code = 'final_operation_mages_4',
						text = tr("FINAL_OPERATON_MAGES_3_OPTION_2"),
						reqs = [],
						type = 'next_dialogue',
						dialogue_argument = 2
					},
				]
			},
		],
	},
	final_operation_mages_5_4 = {
		image = null,
		tags = ['master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_MAGES_5_4"), reqs = []},
		],
		options = [
			{code = 'leave', text = tr("DIALOGUELEAVE"), reqs = []},
		],
	},
	final_operation_mages_3_1 = {
		image = null,
		tags = ['master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_MAGES_3_1"), reqs = []},
		],
		options = [
			{code = 'leave', text = tr("DIALOGUELEAVE"), reqs = []},
		],
	},
	final_operation_mages_3_2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_MAGES_3_2"), reqs = []},
		],
		options = [
			{
				code = 'final_operation_mages_5_3',
				text = tr("FINAL_OPERATON_MAGES_3_OPTION_1"),
				reqs = [],
				dialogue_argument = 1
			},
			{
				code = 'final_operation_mages_4',
				text = tr("FINAL_OPERATON_MAGES_3_OPTION_2"),
				reqs = [],
				dialogue_argument = 2
			},
		],
	},
	final_operation_mages_4 = {
		image = null,
		tags = ['master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_MAGES_4"), reqs = []},
		],
		options = [
			{code = 'leave', text = tr("DIALOGUELEAVE"), reqs = []},
		],
	},
	final_operation_mages_5_3 = {
		image = null,
		tags = ['master_translate'],
		text = [
			{text = tr("FINAL_OPERATON_MAGES_5_3"), reqs = []},
		],
		options = [
			{code = 'leave', text = tr("DIALOGUELEAVE"), reqs = []},
		],
	},
}
