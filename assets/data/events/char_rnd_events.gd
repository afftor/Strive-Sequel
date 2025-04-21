extends Reference

var stats = {
	injury = {
		money = 20,
		exp_val = 50,
		physics_val = 5,
		charm_val = 5
	},
	asleep = {
		exp_val = 25,
		loyalty_val = 5,
		consent_req = 3,
		consent_val = 1,
		lust_val = 10,
		wits_val = 5
	}
}

var data = {
	char_rnd_injury = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "scarhand",
		text = [
			{
				text = "CHARRND_INJURY",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_injury2",
				text = "CHARRND_INJURY_OPT_HELP",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [
					{
						type = "has_money",
						value = stats.injury.money
					}
				],
				bonus_effects = [
					{
						code = "money_change",
						value = stats.injury.money,
						operant = "-"
					},
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "base_exp",
								value = stats.injury.exp_val,
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'base_exp',
						value = stats.injury.exp_val
					}
				],
			},
			{
				code = "char_rnd_injury2",
				text = "CHARRND_INJURY_OPT_DISC",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "physics",
								value = stats.injury.physics_val,
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'physics',
						value = stats.injury.physics_val
					}
				],
			},
			{
				code = "char_rnd_injury2",
				text = "CHARRND_INJURY_OPT_MANIP",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "charm",
								value = stats.injury.charm_val,
								operant = "+"
							}
						]
					}
				]
			}
		]
	},
	char_rnd_injury2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		character = "scarhand",
		text = [
			{
				text = "CHARRND_INJURY_REPLY_HELP",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_INJURY_REPLY_DISC",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_INJURY_REPLY_MANIP",
				reqs = [

				],
				previous_dialogue_option = 3
			},
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [

				],
			},
		]
	},
	char_rnd_asleep = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "table_sleep",
		text = [
			{
				text = "CHARRND_ASLEEP",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_asleep2",
				text = "CHARRND_ASLEEP_OPT_WAKE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "base_exp",
								value = stats.asleep.exp_val,
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'base_exp',
						value = stats.asleep.exp_val
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'loyalty',
						value = stats.asleep.loyalty_val
					}
				],
			},
			{
				code = "char_rnd_asleep2",
				text = "CHARRND_ASLEEP_OPT_FEEL",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [
					{
						type = 'active_character_checks',
						value = [
							{
								code = 'stat',
								stat = 'consent',
								operant = 'lt',
								value = stats.asleep.consent_req
							},
						]
					}
				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'lust',
						value = stats.asleep.lust_val
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'consent',
						value = stats.asleep.consent_val
					}
				],
			},
			{
				code = "char_rnd_asleep2",
				text = "CHARRND_ASLEEP_OPT_FEEL",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [
					{
						type = 'active_character_checks',
						value = [
							{
								code = 'stat',
								stat = 'consent',
								operant = 'gte',
								value = stats.asleep.consent_req
							},
						]
					}
				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'lust',
						value = stats.asleep.lust_val
					}
				]
			},
			{
				code = "char_rnd_asleep2",
				text = "CHARRND_ASLEEP_OPT_LEAVE",
				dialogue_argument = 4,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "wits",
								value = stats.asleep.wits_val,
								operant = "+"
							}
						]
					}
				]
			}
		]
	},
	char_rnd_asleep2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		character = "table_sleep",
		text = [
			{
				text = "CHARRND_ASLEEP_REPLY_WAKE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_ASLEEP_REPLY_FEEL",
				reqs = [

				],
				previous_dialogue_option = [2, 3]
			},
			{
				text = "CHARRND_ASLEEP_REPLY_LEAVE",
				reqs = [

				],
				previous_dialogue_option = 4
			},
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [

				],
			},
		]
	},
	
}
