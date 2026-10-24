extends Reference
#Temple conversions: the character and the religious slot the faith takes are picked before these scenes open
#(custom_effects.FAITH_CONVERSIONS for the city buttons, trait_confirm on the Aliron church option).
#Each scene takes the offering and adds the faith; add_trait writes it over the slot picked.
var data = {
	faith_conversion_celena = {
		custom_background = "church_event",
		image = null,
		character = 'ginny',
		tags = ['dialogue_scene', 'active_character_translate'],
		text = [
			{text = "FAITH_CONVERSION_CELENA", reqs = []},
		],
		common_effects = [
			{code = 'money_change', operant = '-', value = 200},
			{code = 'affect_active_character', type = 'add_trait', trait = 'faith_celena_1'},
		],
		options = [
			{code = 'aliron_church_enter', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 5, type = 'next_dialogue'},
		],
	},

	#Freya's high priestess is whoever the act 2 ceremony chose
	faith_conversion_freya = {
		variations = [
			{
				reqs = [{type = 'decision', value = 'LiraPriestess', check = true}],
				image = null,
				character = 'lira_priestess',
				tags = ['dialogue_scene', 'active_character_translate'],
				text = [
					{text = "FAITH_CONVERSION_FREYA_LIRA", reqs = []},
				],
				common_effects = [
					{code = 'material_change', operant = '-', material = 'clothsilk', value = 5},
					{code = 'affect_active_character', type = 'add_trait', trait = 'faith_freya_1'},
				],
				options = [
					{code = 'close', text = "DIALOGUECLOSE", reqs = []},
				],
			},
			{
				reqs = [],
				image = null,
				character = 'heleviel',
				tags = ['dialogue_scene', 'active_character_translate'],
				text = [
					{text = "FAITH_CONVERSION_FREYA_HELEVIEL", reqs = []},
				],
				common_effects = [
					{code = 'material_change', operant = '-', material = 'clothsilk', value = 5},
					{code = 'affect_active_character', type = 'add_trait', trait = 'faith_freya_1'},
				],
				options = [
					{code = 'close', text = "DIALOGUECLOSE", reqs = []},
				],
			},
		],
	},

	faith_conversion_spirits = {
		image = null,
		character = 'savra',
		tags = ['dialogue_scene', 'active_character_translate'],
		text = [
			{text = "FAITH_CONVERSION_SPIRITS", reqs = []},
		],
		common_effects = [
			{code = 'material_change', operant = '-', material = 'meat', value = 30},
			{code = 'affect_active_character', type = 'add_trait', trait = 'faith_spirits_1'},
		],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = []},
		],
	},
}
