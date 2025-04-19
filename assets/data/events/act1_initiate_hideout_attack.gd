extends Reference
var data = {
	initiate_hideout_attack = {
		variations = [
			{ # no help
				image = null,
				character = "duncan",
				tags = ['dialogue_scene', 'master_translate'],
				text = "INITIATE_HIDEOUT_ATTACK_1",
				reqs = [{type = 'dialogue_seen', check = false, value = 'INITIATE_HIDEOUT_ATTACK_1'}, {type = 'dialogue_seen', check = false, value = 'INITIATE_HIDEOUT_ATTACK_2'}, {type = 'decision', value = 'MagesHelpDuncan', check = false}],
				options = [
					{
						code = 'initiate_hideout_attack_6',
						text = "INITIATE_HIDEOUT_ATTACK_OFCOURSE",
						reqs = [],
						type = 'next_dialogue',
						dialogue_argument = 1
					},
				]
			},
			{  # help
				image = null,
				character = "duncan",
				tags = ['dialogue_scene', 'master_translate'],
				text = "INITIATE_HIDEOUT_ATTACK_2",
				reqs = [{type = 'dialogue_seen', check = false, value = 'INITIATE_HIDEOUT_ATTACK_1'}, {type = 'dialogue_seen', check = false, value = 'INITIATE_HIDEOUT_ATTACK_2'}, {type = 'decision', value = 'MagesHelpDuncan', check = true}],
				options = [
					{
						code = 'initiate_hideout_attack_6',
						text = "DIALOGUECONTINUE",
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
		character = "duncan",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "INITIATE_HIDEOUT_ATTACK_3", reqs = []},
		],
		options = [
			{
				code = 'initiate_hideout_attack_4',
				text = "INITIATE_HIDEOUT_ATTACK_3_OPTION_1",
				reqs = [], type = 'next_dialogue',
				dialogue_argument = 1
			},
			{
				code = 'initiate_hideout_attack_4',
				text = "INITIATE_HIDEOUT_ATTACK_3_OPTION_2",
				reqs = [], type = 'next_dialogue',
				dialogue_argument = 2
			},
			{
				code = 'initiate_hideout_attack_5',
				text = "INITIATE_HIDEOUT_ATTACK_3_OPTION_3",
				reqs = [], type = 'next_dialogue',
				dialogue_argument = 3
			},
		]
	},
	initiate_hideout_attack_6 = {
		image = null,
		character = "duncan",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "INITIATE_HIDEOUT_ATTACK_6", reqs = []},
		],
		options = [
			{
				code = 'initiate_hideout_attack_3',
				text = "INITIATE_HIDEOUT_ATTACK_OPTION_1",
				reqs = [], type = 'next_dialogue',
				dialogue_argument = 1
			},
			{
				code = 'initiate_hideout_attack_5',
				text = "INITIATE_HIDEOUT_ATTACK_OPTION_2",
				reqs = [], type = 'next_dialogue',
				dialogue_argument = 2
			},
		]
	},
	initiate_hideout_attack_4 = {
		image = null,
		character = "duncan",
		tags = ['master_translate'],
		text = [
			{text = "INITIATE_HIDEOUT_ATTACK_4", reqs = []},
		],
		common_effects = [{code = 'decision', value = "PlayerFrontline"}], #affects reward after battle
		options = [
			{
				#code = 'fight',
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				type = 'next_dialogue',
			},
		]
	},
	initiate_hideout_attack_5 = {
		image = null,
		character = "duncan",
		tags = ['master_translate'],
		text = [
			{text = "INITIATE_HIDEOUT_ATTACK_5", reqs = []},
		],
		options = [
			{
				#code = 'fight',
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				type = 'next_dialogue',
			},
		]
	},
	guild_attack_on_hideout_1 = {
		variations = [{
			# (if Aire Alive)
			reqs = [{type = 'decision', value = 'aire_is_dead', check = false}],
			image = null,
			character = "greg", character2 = "anastasia",
			tags = ['dialogue_scene', 'master_translate'],
			text = [
				{text = "GUILD_ATTACK_ON_HIDEOUT_1", reqs = []},
			],
			options = [
				{
					code = 'guild_attack_on_hideout_2',
					text = "DIALOGUECONTINUE",
					reqs = [],
					dialogue_argument = 1,
					type = 'next_dialogue',
				} 
			]
		}, {
			# (if Aire Is Dead)
			reqs = [{type = 'decision', value = 'aire_is_dead', check = true}],
			image = null,
			character = "greg", character2 = "anastasia",
			tags = ['dialogue_scene', 'master_translate'],
			text = [
				{text = "GUILD_ATTACK_ON_HIDEOUT_4_2", reqs = []},
			],
			options = [
				{
					code = 'guild_attack_on_hideout_5',
					text = "DIALOGUECONTINUE",
					reqs = [],
					dialogue_argument = 1,
					type = 'next_dialogue',
				} 
			]
		}]
	},
	
	guild_attack_on_hideout_2 = {
		image = null,
		character = "greg", character2 = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "GUILD_ATTACK_ON_HIDEOUT_2", reqs = []},
		],
		options = [
			{
				code = 'guild_attack_on_hideout_3',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue',
			} 
		]
	},
	
	guild_attack_on_hideout_3 = {
		image = null,
		character = "anastasia", character2 = "aire",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "GUILD_ATTACK_ON_HIDEOUT_3", reqs = []},
		],
		options = [
			{
				code = 'guild_attack_on_hideout_4',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue',
			} 
		]
	},
	
	guild_attack_on_hideout_4 = {
		image = null,
		character = "greg", character2 = "aire",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "GUILD_ATTACK_ON_HIDEOUT_4_1", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue',
			} 
		]
	},
	
	guild_attack_on_hideout_5 = {
		image = null,
		character = "greg", character2 = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "GUILD_ATTACK_ON_HIDEOUT_4_3", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue',
			} 
		]
	},
}
