var data = {
	initiate_hideout_attack = {
		variations = [
			{
				image = null,
				tags = ['dialogue_scene', 'master_translate'],
				text = "INITIATE_HIDEOUT_ATTACK_1",
				reqs = [],
				options = [
					{
						code = 'initiate_hideout_attack_6',
						text = tr("INITIATE_HIDEOUT_ATTACK_OFCOURSE"),
						reqs = [],
						type = 'next_dialogue',
						dialogue_argument = 1
					},
				]
			},
			{
				image = null,
				tags = ['dialogue_scene', 'master_translate'],
				text = "INITIATE_HIDEOUT_ATTACK_2",
				reqs = [],
				options = [
					{
						code = 'initiate_hideout_attack_6',
						text = tr("INITIATE_HIDEOUT_ATTACK_OFCOURSE"),
						reqs = [],
						type = 'next_dialogue',
						dialogue_argument = 1
					},
				]
			}
		]
	},
	initiate_hideout_attack_3 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = tr("INITIATE_HIDEOUT_ATTACK_3"), reqs = []},
		],
		options = [
			{
				code = 'initiate_hideout_attack_4',
				text = tr("INITIATE_HIDEOUT_ATTACK_3_OPTION_1"),
				reqs = [],
				dialogue_argument = 1
			},
			{
				code = 'initiate_hideout_attack_4',
				text = tr("INITIATE_HIDEOUT_ATTACK_3_OPTION_2"),
				reqs = [],
				dialogue_argument = 2
			},
			{
				code = 'initiate_hideout_attack_5',
				text = tr("INITIATE_HIDEOUT_ATTACK_3_OPTION_3"),
				reqs = [],
				dialogue_argument = 3
			},
		]
	},
	initiate_hideout_attack_6 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = tr("INITIATE_HIDEOUT_ATTACK_6"), reqs = []},
		],
		options = [
			{
				code = 'initiate_hideout_attack_3',
				text = tr("INITIATE_HIDEOUT_ATTACK_OPTION_1"),
				reqs = [],
				dialogue_argument = 1
			},
			{
				code = 'initiate_hideout_attack_5',
				text = tr("INITIATE_HIDEOUT_ATTACK_OPTION_2"),
				reqs = [],
				dialogue_argument = 2
			},
		]
	},
	initiate_hideout_attack_4 = {
		image = null,
		tags = ['master_translate'],
		text = [
			{text = tr("INITIATE_HIDEOUT_ATTACK_4"), reqs = []},
		],
		options = [
			{
				code = 'fight',
				text = tr("DIALOGUEFIGHTOPTION"),
				reqs = [],
			},
		]
	},
	initiate_hideout_attack_5 = {
		image = null,
		tags = ['master_translate'],
		text = [
			{text = tr("INITIATE_HIDEOUT_ATTACK_5"), reqs = []},
		],
		options = [
			{
				code = 'fight',
				text = tr("DIALOGUEFIGHTOPTION"),
				reqs = [],
			},
		]
	},
	guild_attack_on_hideout_1 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = tr("GUILD_ATTACK_ON_HIDEOUT_1"), reqs = []},
		],
		options = [
			{
				code = 'guild_attack_on_hideout_2',
				text = tr("DIALOGUECONTINUE"),
                reqs = [],
                dialogue_argument = 1
			},
		]
	},
	guild_attack_on_hideout_2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = tr("GUILD_ATTACK_ON_HIDEOUT_2"), reqs = []},
		],
		options = [
			{
				code = 'guild_attack_on_hideout_3',
				text = tr("DIALOGUECONTINUE"),
                reqs = [],
                dialogue_argument = 1
			},
		]
    },
    
    guild_attack_on_hideout_3 = {
		variations = [
			{
				image = null,
				tags = ['dialogue_scene', 'master_translate'],
				text = "GUILD_ATTACK_ON_HIDEOUT_4_1",
				reqs = [],
				options = [
					{
						code = 'guild_attack_on_hideout_4_3',
						text = tr("DIALOGUECONTINUE"),
						reqs = [],
						type = 'next_dialogue',
						dialogue_argument = 1
					},
				]
			},
			{
				image = null,
				tags = ['dialogue_scene', 'master_translate'],
				text = "GUILD_ATTACK_ON_HIDEOUT_4_2",
				reqs = [],
				options = [
					{
						code = 'guild_attack_on_hideout_4_3',
						text = tr("DIALOGUECONTINUE"),
						reqs = [],
						type = 'next_dialogue',
						dialogue_argument = 1
					},
				]
			}
		]
    },

    guild_attack_on_hideout_4_3 = {
		image = null,
		tags = ['master_translate'],
		text = [
			{text = tr("GUILD_ATTACK_ON_HIDEOUT_4_3"), reqs = []},
		],
		options = [
			{
				code = 'close',
				text = tr("DIALOGUECLOSE"),
				reqs = [],
			},
		]
    },
}
