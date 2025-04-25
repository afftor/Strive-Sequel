extends Reference

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
						value = "var_injury_money"
					}
				],
				bonus_effects = [
					{
						code = "money_change",
						value = "var_injury_money",
						operant = "-"
					},
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "base_exp",
								value = "var_injury_exp",
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'base_exp',
						value = "var_injury_exp"
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
								value = "var_injury_physics",
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'physics',
						value = "var_injury_physics"
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
								value = "var_injury_charm",
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
		image = "scarhand",
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
								value = "var_asleep_exp",
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'base_exp',
						value = "var_asleep_exp"
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'loyalty',
						value = "var_asleep_loyalty"
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
								value = "var_asleep_consent_req"
							},
						]
					}
				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'lust',
						value = "var_asleep_lust"
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'consent',
						value = "var_asleep_consent"
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
								operant = 'gte',
								value = "var_asleep_consent_req"
							},
						]
					}
				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'lust',
						value = "var_asleep_lust"
					}
				]
			},
			{
				code = "char_rnd_asleep2",
				text = "CHARRND_ASLEEP_OPT_LEAVE",
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
								code = "wits",
								value = "var_asleep_wits",
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
		image = "table_sleep",
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
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_ASLEEP_REPLY_LEAVE",
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
	char_rnd_bullying = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "bulling",
		text = [
			{
				text = "CHARRND_BULLYING",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_bullying2",
				text = "CHARRND_BULLYING_OPT_PROTECT",
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
								code = "charm",
								value = "var_bullying_charm",
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'loyalty',
						value = "var_bullying_loyalty"
					}
				],
			},
			{
				code = "char_rnd_bullying2",
				text = "CHARRND_BULLYING_OPT_IGNORE",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'base_exp',
						value = "var_bullying_exp_char"
					}
				],
			},
			{
				code = "char_rnd_bullying2",
				text = "CHARRND_BULLYING_OPT_JOIN",
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
								code = "base_exp",
								value = "var_bullying_exp_mast",
								operant = "+"
							}
						]
					}
				]
			}
		]
	},
	char_rnd_bullying2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "bulling",
		text = [
			{
				text = "CHARRND_BULLYING_REPLY_PROTECT",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_BULLYING_REPLY_IGNORE",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_BULLYING_REPLY_JOIN",
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
	char_rnd_misbehave = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "no_reaction",
		text = [
			{
				text = "CHARRND_MISBEHAVE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_misbehave2",
				text = "CHARRND_MISBEHAVE_OPT_PARDON",
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
								code = "charm",
								value = "var_misbehave_charm",
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'charm',
						value = "var_misbehave_charm"
					}
				],
			},
			{
				code = "char_rnd_misbehave2",
				text = "CHARRND_MISBEHAVE_OPT_PUNISH",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'physics',
						value = "var_misbehave_physics"
					}
				],
			}
		]
	},
	char_rnd_misbehave2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "no_reaction",
		text = [
			{
				text = "CHARRND_MISBEHAVE_REPLY_PARDON",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_MISBEHAVE_REPLY_PUNISH",
				reqs = [

				],
				previous_dialogue_option = 2
			}
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
	char_rnd_lost = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "cargo_loss",
		text = [
			{
				text = "CHARRND_LOST",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_lost2",
				text = "CHARRND_LOST_OPT_PUNISH",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [

				],
			},
			{
				code = "char_rnd_lost2",
				text = "CHARRND_LOST_OPT_PARDON",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "money_change",
						value = "var_lost_money",
						operant = "-"
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'loyalty',
						value = "var_lost_loyalty"
					}
				],
			},
			{
				code = "char_rnd_lost2",
				text = "CHARRND_LOST_OPT_SEARCH",
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
								code = "wits",
								value = "var_lost_wits",
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'wits',
						value = "var_lost_wits"
					}
				],
			}
		]
	},
	char_rnd_lost2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "cargo_loss",
		text = [
			{
				text = "CHARRND_LOST_REPLY_PUNISH",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_LOST_REPLY_PARDON",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_LOST_REPLY_SEARCH",
				reqs = [

				],
				previous_dialogue_option = 3
			}
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
	char_rnd_unwell = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "rest",
		text = [
			{
				text = "CHARRND_UNWELL",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_unwell2",
				text = "CHARRND_UNWELL_OPT_REST",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'base_exp',
						value = "var_unwell_exp"
					}
				],
			},
			{
				code = "char_rnd_unwell2",
				text = "CHARRND_UNWELL_OPT_COMFORT",
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
								code = "charm",
								value = "var_unwell_charm",
								operant = "+"
							}
						]
					},
				],
			},
			{
				code = "char_rnd_unwell2",
				text = "CHARRND_UNWELL_OPT_FORCE",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'physics',
						value = "var_unwell_physics"
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'hp',
						value = "var_unwell_hp"
					}
				],
			}
		]
	},
	char_rnd_unwell2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "rest",
		text = [
			{
				text = "CHARRND_UNWELL_REPLY_REST",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_UNWELL_REPLY_COMFORT",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_UNWELL_REPLY_FORCE",
				reqs = [

				],
				previous_dialogue_option = 3
			}
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
	char_rnd_attention = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "guest_harrasment",
		text = [
			{
				text = "CHARRND_ATTENTION",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_attention2",
				text = "CHARRND_ATTENTION_OPT_ENDORSE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [
					{
						type = 'active_character_checks',
						value = [
							{
								code = 'stat',
								stat = 'consent',
								operant = 'gte',
								value = "var_attention_consent_high"
							},
						]
					}
				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'charm',
						value = "var_attention_charm"
					}
				],
			},
			{
				code = "char_rnd_attention2",
				text = "CHARRND_ATTENTION_OPT_ENDORSE",
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
								value = "var_attention_consent_low"
							},
						]
					}
				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'charm',
						value = "var_attention_charm"
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'consent',
						value = "var_attention_consent"
					}
				],
			},
			{
				code = "char_rnd_attention2",
				text = "CHARRND_ATTENTION_OPT_ENDORSE",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [
					{
						type = 'active_character_checks',
						value = [
							{
								code = 'stat',
								stat = 'consent',
								operant = 'gte',
								value = "var_attention_consent_low"
							},
						]
					},
					{
						type = 'active_character_checks',
						value = [
							{
								code = 'stat',
								stat = 'consent',
								operant = 'lt',
								value = "var_attention_consent_high"
							},
						]
					},
				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'charm',
						value = "var_attention_charm"
					}
				],
			},
			{
				code = "char_rnd_attention2",
				text = "CHARRND_ATTENTION_OPT_PROTECT",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'loyalty',
						value = "var_attention_loyalty"
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'base_exp',
						value = "var_attention_exp"
					},
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "base_exp",
								value = "var_attention_exp",
								operant = "+"
							}
						]
					}
				]
			}
		]
	},
	char_rnd_attention2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "guest_harrasment",
		text = [
			{
				text = "CHARRND_ATTENTION_REPLY_ENDORSE_A",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_ATTENTION_REPLY_ENDORSE_B",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_ATTENTION_REPLY_PROTECT",
				reqs = [

				],
				previous_dialogue_option = 3
			}
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
	char_rnd_treasure = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "treasure",
		text = [
			{
				text = "CHARRND_TREASURE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_treasure2",
				text = "CHARRND_TREASURE_OPT_TAKE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "money_change",
						value = "var_treasure_money",
						operant = "+"
					},
				],
			},
			{
				code = "char_rnd_treasure2",
				text = "CHARRND_TREASURE_OPT_LET",
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
								code = "charm",
								value = "var_treasure_charm",
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'charm',
						value = "var_treasure_charm"
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'loyalty',
						value = "var_treasure_loyalty"
					}
				],
			},
			{
				code = "char_rnd_treasure2",
				text = "CHARRND_TREASURE_OPT_OWNER",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'base_exp',
						value = "var_treasure_exp"
					},
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "base_exp",
								value = "var_treasure_exp",
								operant = "+"
							}
						]
					}
				]
			}
		]
	},
	char_rnd_treasure2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "treasure",
		text = [
			{
				text = "CHARRND_TREASURE_REPLY_TAKE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_TREASURE_REPLY_LET",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_TREASURE_REPLY_OWNER",
				reqs = [

				],
				previous_dialogue_option = 3
			}
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
	char_rnd_nightmare = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "nightmare",
		text = [
			{
				text = "CHARRND_NIGHTMARE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_nightmare2",
				text = "CHARRND_NIGHTMARE_OPT_COMFORT",
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
								code = "charm",
								value = "var_nightmare_charm",
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'loyalty',
						value = "var_nightmare_loyalty"
					}
				],
			},
			{
				code = "char_rnd_nightmare2",
				text = "CHARRND_NIGHTMARE_OPT_DISCIP",
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
								code = "wits",
								value = "var_nightmare_wits",
								operant = "+"
							}
						]
					}
				],
			}
		]
	},
	char_rnd_nightmare2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "nightmare",
		text = [
			{
				text = "CHARRND_NIGHTMARE_REPLY_COMFORT",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_NIGHTMARE_REPLY_DISCIP",
				reqs = [

				],
				previous_dialogue_option = 2
			}
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
	char_rnd_hated_food = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "dining_table",
		text = [
			{
				text = "CHARRND_HATED_FOOD",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_hated_food2",
				text = "CHARRND_HATED_FOOD_OPT_RECON",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "change_relationship_precise",
						value = "var_hated_food_relation_up",
					}
				],
			},
			{
				code = "char_rnd_hated_food2",
				text = "CHARRND_HATED_FOOD_OPT_AGITATE",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "change_relationship_precise",
						value = "var_hated_food_relation_down",
					}
				],
			},
			{
				code = "char_rnd_hated_food2",
				text = "CHARRND_HATED_FOOD_OPT_IGNORE",
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
								code = "base_exp",
								value = "var_hated_food_exp",
								operant = "+"
							}
						]
					},
				],
			}
		]
	},
	char_rnd_hated_food2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "dining_table",
		text = [
			{
				text = "CHARRND_HATED_FOOD_REPLY_RECON",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_HATED_FOOD_REPLY_AGITATE",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_HATED_FOOD_REPLY_IGNORE",
				reqs = [

				],
				previous_dialogue_option = 3
			}
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
	char_rnd_quarrel = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "quarrel",
		text = [
			{
				text = "CHARRND_QUARREL",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_quarrel2",
				text = "CHARRND_QUARREL_OPT_SUPPORT1",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "affect_one_scene_character",
						char_num = 1,
						type = 'stat',
						stat = 'loyalty',
						value = "var_quarrel_loyalty"
					},
					{
						code = "affect_one_scene_character",
						char_num = 1,
						type = 'stat',
						stat = 'base_exp',
						value = "var_quarrel_exp"
					}
				],
			},
			{
				code = "char_rnd_quarrel2",
				text = "CHARRND_QUARREL_OPT_SUPPORT2",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "affect_one_scene_character",
						char_num = 2,
						type = 'stat',
						stat = 'loyalty',
						value = "var_quarrel_loyalty"
					},
					{
						code = "affect_one_scene_character",
						char_num = 2,
						type = 'stat',
						stat = 'base_exp',
						value = "var_quarrel_exp"
					}
				],
			},
			{
				code = "char_rnd_quarrel2",
				text = "CHARRND_QUARREL_OPT_PUNISH",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'physics',
						value = "var_quarrel_physics"
					}
				],
			}
		]
	},
	char_rnd_quarrel2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "quarrel",
		text = [
			{
				text = "CHARRND_QUARREL_REPLY_SUPPORT1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_QUARREL_REPLY_SUPPORT2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_QUARREL_REPLY_PUNISH",
				reqs = [

				],
				previous_dialogue_option = 3
			}
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
	char_rnd_love = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "slave_love",
		text = [
			{
				text = "CHARRND_LOVE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_love2",
				text = "CHARRND_LOVE_OPT_HELP",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = 'change_relationship',
						value = 'lovers'#freelovers?
					}
				],
			},
			{
				code = "char_rnd_love2",
				text = "CHARRND_LOVE_OPT_FLIRT",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "change_relationship_precise",
						value = "var_love_relation",
					},
					{
						code = "affect_one_scene_character",
						char_num = 2,
						type = 'stat',
						stat = 'charm',
						value = "var_love_charm"
					},
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "charm",
								value = "var_love_charm",
								operant = "+"
							}
						]
					}
				],
			},
			{
				code = "char_rnd_love2",
				text = "CHARRND_LOVE_OPT_IGNORE",
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
								code = "wits",
								value = "var_love_wits",
								operant = "+"
							}
						]
					},
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "base_exp",
								value = "var_love_exp",
								operant = "+"
							}
						]
					}
				],
			}
		]
	},
	char_rnd_love2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "slave_love",
		text = [
			{
				text = "CHARRND_LOVE_REPLY_HELP",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_LOVE_REPLY_FLIRT",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_LOVE_REPLY_IGNORE",
				reqs = [

				],
				previous_dialogue_option = 3
			}
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
	char_rnd_discustomer = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "restoraunt_quarrel",
		text = [
			{
				text = "CHARRND_DISCUSTOMER",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_discustomer2",
				text = "CHARRND_DISCUSTOMER_OPT_SERVE1",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "affect_one_scene_character",
						char_num = 1,
						type = 'stat',
						stat = 'charm',
						value = "var_discustomer_charm"
					},
					{
						code = "change_relationship_precise",
						value = "var_discustomer_relation_down",
					}
				],
			},
			{
				code = "char_rnd_discustomer2",
				text = "CHARRND_DISCUSTOMER_OPT_SERVE2",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "affect_one_scene_character",
						char_num = 2,
						type = 'stat',
						stat = 'charm',
						value = "var_discustomer_charm"
					},
					{
						code = "change_relationship_precise",
						value = "var_discustomer_relation_down",
					}
				],
			},
			{
				code = "char_rnd_discustomer2",
				text = "CHARRND_DISCUSTOMER_OPT_NEITHER",
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
								code = "wits",
								value = "var_discustomer_wits",
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'loyalty',
						value = "var_discustomer_loyalty"
					}
				],
			},
			{
				code = "char_rnd_discustomer2",
				text = "CHARRND_DISCUSTOMER_OPT_BOTH",
				dialogue_argument = 4,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'physics',
						value = "var_discustomer_physics"
					},
					{
						code = "change_relationship_precise",
						value = "var_discustomer_relation_up",
					}
				],
			}
		]
	},
	char_rnd_discustomer2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "restoraunt_quarrel",
		text = [
			{
				text = "CHARRND_DISCUSTOMER_REPLY_SERVE1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_DISCUSTOMER_REPLY_SERVE2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_DISCUSTOMER_REPLY_NEITHER",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "CHARRND_DISCUSTOMER_REPLY_BOTH",
				reqs = [

				],
				previous_dialogue_option = 4
			}
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
	char_rnd_likecustomer = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "restoraunt_quarrel",
		text = [
			{
				text = "CHARRND_LIKECUSTOMER",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_likecustomer2",
				text = "CHARRND_LIKECUSTOMER_OPT_SCOLD2",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "affect_one_scene_character",
						char_num = 1,
						type = 'stat',
						stat = 'charm',
						value = "var_likecustomer_charm"
					}
				],
			},
			{
				code = "char_rnd_likecustomer2",
				text = "CHARRND_LIKECUSTOMER_OPT_DISMISS1",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "money_change",
						value = "var_likecustomer_money",
						operant = "+"
					},
				],
			},
			{
				code = "char_rnd_likecustomer2",
				text = "CHARRND_LIKECUSTOMER_OPT_SERVEYOU",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "affect_one_scene_character",
						char_num = 1,
						type = 'stat',
						stat = 'base_exp',
						value = "var_likecustomer_exp"
					}
				],
			}
		]
	},
	char_rnd_likecustomer2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "restoraunt_quarrel",
		text = [
			{
				text = "CHARRND_LIKECUSTOMER_REPLY_SCOLD2",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_LIKECUSTOMER_REPLY_DISMISS1",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_LIKECUSTOMER_REPLY_SERVEYOU",
				reqs = [

				],
				previous_dialogue_option = 3
			}
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
	char_rnd_trap = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "trap_rnd",
		text = [
			{
				text = "CHARRND_TRAP",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_trap2",
				text = "CHARRND_TRAP_OPT_HELP",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'location_effect',
						value = 'pay_stamina',
						cost = 'var_trap_stamina'
					}
				],
			},
			{
				code = "char_rnd_trap2",
				text = "CHARRND_TRAP_OPT_BACK",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'effect',
						value = 'e_grave_injury',
						override = {duration = 'var_trap_injury_dur'}
					}
				],
			}
		]
	},
	char_rnd_trap2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "trap_rnd",
		text = [
			{
				text = "CHARRND_TRAP_REPLY_HELP",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_TRAP_REPLY_BACK",
				reqs = [

				],
				previous_dialogue_option = 2
			}
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
	char_rnd_skirmish = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "rest",
		text = [
			{
				text = "CHARRND_SKIRMISH",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_skirmish2",
				text = "CHARRND_SKIRMISH_OPT_AGREE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'location_effect',
						value = 'pay_stamina',
						cost = 'var_skirmish_stamina'
					},
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "charm",
								value = "var_skirmish_charm",
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'charm',
						value = "var_skirmish_charm"
					}
				],
			},
			{
				code = "char_rnd_skirmish2",
				text = "CHARRND_SKIRMISH_OPT_GOLD",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [
					{
						type = "has_money",
						value = "var_skirmish_money"
					}
				],
				bonus_effects = [
					{
						code = "money_change",
						value = "var_skirmish_money",
						operant = "-"
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'physics',
						value = "var_skirmish_physics"
					}
				],
			},
			{
				code = "char_rnd_skirmish2",
				text = "CHARRND_SKIRMISH_OPT_IGNORE",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'hp',
						value = "var_skirmish_hp"
					},
					{
						code = "real_affect_scene_characters",
						type = 'stat',
						stat = 'base_exp',
						value = "var_skirmish_exp"
					}
				],
			}
		]
	},
	char_rnd_skirmish2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "rest",
		text = [
			{
				text = "CHARRND_SKIRMISH_REPLY_AGREE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_SKIRMISH_REPLY_GOLD",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_SKIRMISH_REPLY_IGNORE",
				reqs = [

				],
				previous_dialogue_option = 3
			}
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
