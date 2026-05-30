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
				not_hide = true,
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
						type = "stat",
						stat = "base_exp",
						value = "var_injury_exp"
					}
				]
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
						type = "stat",
						stat = "physics",
						value = "var_injury_physics"
					}
				]
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
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [

				]
			}
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
						type = "stat",
						stat = "base_exp",
						value = "var_asleep_exp"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_asleep_loyalty"
					}
				]
			},
			{
				code = "char_rnd_asleep2",
				text = "CHARRND_ASLEEP_OPT_FEEL",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [
					{
						type = "active_character_checks",
						value = [
							{
								code = "stat",
								stat = "consent",
								operant = "lt",
								value = "var_asleep_consent_req"
							}
						]
					}
				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "lust",
						value = "var_asleep_lust"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "consent",
						value = "var_asleep_consent"
					}
				]
			},
			{
				code = "char_rnd_asleep2",
				text = "CHARRND_ASLEEP_OPT_FEEL",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [
					{
						type = "active_character_checks",
						value = [
							{
								code = "stat",
								stat = "consent",
								operant = "gte",
								value = "var_asleep_consent_req"
							}
						]
					}
				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "lust",
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
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [

				]
			}
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
						type = "stat",
						stat = "loyalty",
						value = "var_bullying_loyalty"
					}
				]
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
						type = "stat",
						stat = "base_exp",
						value = "var_bullying_exp_char"
					}
				]
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
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [

				]
			}
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
						type = "stat",
						stat = "charm",
						value = "var_misbehave_charm"
					}
				]
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
						type = "stat",
						stat = "physics",
						value = "var_misbehave_physics"
					}
				]
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

				]
			}
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

				]
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
						type = "stat",
						stat = "loyalty",
						value = "var_lost_loyalty"
					}
				]
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
						type = "stat",
						stat = "wits",
						value = "var_lost_wits"
					}
				]
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

				]
			}
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
						type = "stat",
						stat = "base_exp",
						value = "var_unwell_exp"
					}
				]
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
					}
				]
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
						type = "stat",
						stat = "physics",
						value = "var_unwell_physics"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "hp",
						value = "var_unwell_hp"
					}
				]
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

				]
			}
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
						type = "active_character_checks",
						value = [
							{
								code = "stat",
								stat = "consent",
								operant = "gte",
								value = "var_attention_consent_high"
							}
						]
					}
				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "charm",
						value = "var_attention_charm"
					}
				]
			},
			{
				code = "char_rnd_attention2",
				text = "CHARRND_ATTENTION_OPT_ENDORSE",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [
					{
						type = "active_character_checks",
						value = [
							{
								code = "stat",
								stat = "consent",
								operant = "lt",
								value = "var_attention_consent_low"
							}
						]
					}
				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "charm",
						value = "var_attention_charm"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "consent",
						value = "var_attention_consent"
					}
				]
			},
			{
				code = "char_rnd_attention2",
				text = "CHARRND_ATTENTION_OPT_ENDORSE",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [
					{
						type = "active_character_checks",
						value = [
							{
								code = "stat",
								stat = "consent",
								operant = "gte",
								value = "var_attention_consent_low"
							}
						]
					},
					{
						type = "active_character_checks",
						value = [
							{
								code = "stat",
								stat = "consent",
								operant = "lt",
								value = "var_attention_consent_high"
							}
						]
					}
				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "charm",
						value = "var_attention_charm"
					}
				]
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
						type = "stat",
						stat = "loyalty",
						value = "var_attention_loyalty"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
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

				]
			}
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
					}
				]
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
						type = "stat",
						stat = "charm",
						value = "var_treasure_charm"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_treasure_loyalty"
					}
				]
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
						type = "stat",
						stat = "base_exp",
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

				]
			}
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
						type = "stat",
						stat = "loyalty",
						value = "var_nightmare_loyalty"
					}
				]
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
				]
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

				]
			}
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
						value = "var_hated_food_relation_up"
					}
				]
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
						value = "var_hated_food_relation_down"
					}
				]
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
					}
				]
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

				]
			}
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
						type = "stat",
						stat = "loyalty",
						value = "var_quarrel_loyalty"
					},
					{
						code = "affect_one_scene_character",
						char_num = 1,
						type = "stat",
						stat = "base_exp",
						value = "var_quarrel_exp"
					}
				]
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
						type = "stat",
						stat = "loyalty",
						value = "var_quarrel_loyalty"
					},
					{
						code = "affect_one_scene_character",
						char_num = 2,
						type = "stat",
						stat = "base_exp",
						value = "var_quarrel_exp"
					}
				]
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
						type = "stat",
						stat = "physics",
						value = "var_quarrel_physics"
					}
				]
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

				]
			}
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
						code = "change_relationship",
						value = "lovers"
					}
				]
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
						value = "var_love_relation"
					},
					{
						code = "affect_one_scene_character",
						char_num = 2,
						type = "stat",
						stat = "charm",
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
				]
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
				]
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

				]
			}
		]
	},
	char_rnd_discustomer = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "bar_quarrel",
		text = "CHARRND_DISCUSTOMER",
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
						type = "stat",
						stat = "charm",
						value = "var_discustomer_charm"
					},
					{
						code = "change_relationship_precise",
						value = "var_discustomer_relation_down"
					}
				]
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
						type = "stat",
						stat = "charm",
						value = "var_discustomer_charm"
					},
					{
						code = "change_relationship_precise",
						value = "var_discustomer_relation_down"
					}
				]
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
						type = "stat",
						stat = "loyalty",
						value = "var_discustomer_loyalty"
					}
				]
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
						type = "stat",
						stat = "physics",
						value = "var_discustomer_physics"
					},
					{
						code = "change_relationship_precise",
						value = "var_discustomer_relation_up"
					}
				]
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
		image = "bar_quarrel",
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

				]
			}
		]
	},
	char_rnd_likecustomer = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "bar_quarrel2",
		text = "CHARRND_LIKECUSTOMER",
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
						type = "stat",
						stat = "charm",
						value = "var_likecustomer_charm"
					}
				]
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
					}
				]
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
						type = "stat",
						stat = "base_exp",
						value = "var_likecustomer_exp"
					}
				]
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
		image = "bar_quarrel2",
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

				]
			}
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
						type = "location_effect",
						value = "pay_stamina",
						cost = "var_trap_stamina"
					}
				]
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
						type = "set_availability",
						value = false,
						duration = "var_trap_injury_dur"
					}
				]
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

				]
			}
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
						type = "location_effect",
						value = "pay_stamina",
						cost = "var_skirmish_stamina"
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
						type = "stat",
						stat = "charm",
						value = "var_skirmish_charm"
					}
				]
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
				not_hide = true,
				bonus_effects = [
					{
						code = "money_change",
						value = "var_skirmish_money",
						operant = "-"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "physics",
						value = "var_skirmish_physics"
					}
				]
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
						type = "stat",
						stat = "hp",
						value = "var_skirmish_hp"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_skirmish_exp"
					}
				]
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

				]
			}
		]
	},
	char_rnd_pray = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		text = "CHARRND_PRAY",
		options = [
			{
				code = "char_rnd_pray2",
				text = "CHARRND_PRAY_OPT_ALLOW",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_pray_loyalty"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "resistance",
						value = "var_pray_resistance"
					}
				]
			},
			{
				code = "char_rnd_pray2",
				text = "CHARRND_PRAY_OPT_FORBID",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_pray_exp"
					},
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "base_exp",
								value = "var_pray_exp",
								operant = "+"
							}
						]
					}
				]
			}
		],
		image = "slave_pray"
	},
	char_rnd_pray2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		text = [
			{
				text = "CHARRND_PRAY_REPLY_ALLOW",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_PRAY_REPLY_FORBID",
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

				]
			}
		],
		image = "slave_pray"
	},
	char_rnd_letter = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		text = "CHARRND_LETTER",
		options = [
			{
				code = "char_rnd_letter2",
				text = "CHARRND_LETTER_OPT_HELP",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [
					{
						type = "has_material",
						operant = "gte",
						value = "var_letter_grain",
						material = "grain"
					}
				],
				not_hide = true,
				bonus_effects = [
					{
						code = "material_change",
						operant = "-",
						material = "grain",
						value = "var_letter_grain"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_letter_loyalty"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "resistance",
						value = "var_letter_resistance"
					},
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "base_exp",
								value = "var_letter_exp",
								operant = "+"
							}
						]
					}
				]
			},
			{
				code = "char_rnd_letter2",
				text = "CHARRND_LETTER_OPT_BURN",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_letter_burn_exp"
					},
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "base_exp",
								value = "var_letter_burn_exp",
								operant = "+"
							}
						]
					}
				]
			}
		],
		image = "slave_letter"
	},
	char_rnd_letter2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		text = [
			{
				text = "CHARRND_LETTER_REPLY_HELP",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_LETTER_REPLY_BURN",
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

				]
			}
		],
		image = "slave_letter"
	},
	char_rnd_brokenvase = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		text = "CHARRND_BROKENVASE",
		options = [
			{
				code = "char_rnd_brokenvase2",
				text = "CHARRND_BROKENVASE_OPT_REPAIR",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "set_availability",
						value = false,
						duration = "var_brokenvase_duration"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_brokenvase_loyalty"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_brokenvase_exp_repair"
					}
				]
			},
			{
				code = "char_rnd_brokenvase2",
				text = "CHARRND_BROKENVASE_OPT_REPLACE",
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
								code = "base_exp",
								value = "var_brokenvase_exp_replace",
								operant = "+"
							}
						]
					},
					{
						code = "money_change",
						value = "var_brokenvase_money",
						operant = "+"
					}
				]
			},
			{
				code = "char_rnd_brokenvase2",
				text = "CHARRND_BROKENVASE_OPT_PUNISH",
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
								value = "var_brokenvase_exp_punish",
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_brokenvase_exp_punish"
					}
				]
			}
		],
		image = "daisyevent"
	},
	char_rnd_brokenvase2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		text = [
			{
				text = "CHARRND_BROKENVASE_REPLY_REPAIR",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_BROKENVASE_REPLY_REPLACE",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_BROKENVASE_REPLY_PUNISH",
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

				]
			}
		],
		image = "daisyevent"
	},
	char_rnd_hunt_offering = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "prey",
		text = [
			{
				text = "CHARRND_HUNT_OFFERING",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_hunt_offering2",
				text = "CHARRND_HUNT_OFFERING_OPT_ACCEPT",
				active_char_translate = true,
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_hunt_loyalty_accept"
					}
				]
			},
			{
				code = "char_rnd_hunt_offering2",
				text = "CHARRND_HUNT_OFFERING_OPT_EXPLAIN",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_hunt_exp_explain"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_hunt_loyalty_explain"
					}
				]
			},
			{
				code = "char_rnd_hunt_offering2",
				text = "CHARRND_HUNT_OFFERING_OPT_REFUSE",
				active_char_translate = true,
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
								value = "var_hunt_wits_refuse",
								operant = "+"
							}
						]
					}
				]
			}
		]
	},
	char_rnd_hunt_offering2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "prey",
		text = [
			{
				text = "CHARRND_HUNT_OFFERING_REPLY_ACCEPT",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_HUNT_OFFERING_REPLY_EXPLAIN",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_HUNT_OFFERING_REPLY_REFUSE",
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

				]
			}
		]
	},
	char_rnd_late_knock = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "night",
		text = [
			{
				text = "CHARRND_LATE_KNOCK",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_late_knock2",
				text = "CHARRND_LATE_KNOCK_OPT_DISMISS",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_late_knock_exp_dismiss"
					}
				]
			},
			{
				code = "char_rnd_late_knock2",
				text = "CHARRND_LATE_KNOCK_OPT_INVITE",
				active_char_translate = true,
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "charm",
						value = "var_late_knock_charm_invite"
					}
				]
			},
			{
				code = "char_rnd_late_knock2",
				text = "CHARRND_LATE_KNOCK_OPT_PULL",
				active_char_translate = true,
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_late_knock_loyalty_pull"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_late_knock_exp_pull"
					}
				]
			}
		]
	},
	char_rnd_late_knock2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "night",
		text = [
			{
				text = "CHARRND_LATE_KNOCK_REPLY_DISMISS",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_LATE_KNOCK_REPLY_INVITE",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_LATE_KNOCK_REPLY_PULL",
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

				]
			}
		]
	},
	char_rnd_caught = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "slave_sex",
		text = [
			{
				text = "CHARRND_CAUGHT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_caught2",
				text = "CHARRND_CAUGHT_OPT_LEAVE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_caught_xp"
					}
				]
			},
			{
				code = "char_rnd_caught2",
				text = "CHARRND_CAUGHT_OPT_LEDGER",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_caught_xp"
					}
				]
			},
			{
				code = "char_rnd_caught2",
				text = "CHARRND_CAUGHT_OPT_TIME",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_caught_xp"
					}
				]
			}
		]
	},
	char_rnd_caught2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "slave_sex",
		text = [
			{
				text = "CHARRND_CAUGHT_REPLY_LEAVE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_CAUGHT_REPLY_LEDGER",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_CAUGHT_REPLY_TIME",
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

				]
			}
		]
	},
	char_rnd_admirer = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "jewelry",
		text = [
			{
				text = "CHARRND_ADMIRER",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_admirer2",
				text = "CHARRND_ADMIRER_OPT_SEND",
				active_char_translate = true,
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "wits",
						value = "var_admirer_wits_send"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_admirer_exp_send"
					}
				]
			},
			{
				code = "char_rnd_admirer2",
				text = "CHARRND_ADMIRER_OPT_NEGOTIATE",
				active_char_translate = true,
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "charm",
						value = "var_admirer_charm_negotiate"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_admirer_exp_negotiate"
					}
				]
			},
			{
				code = "char_rnd_admirer2",
				text = "CHARRND_ADMIRER_OPT_REFUSE",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_admirer_exp_refuse"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_admirer_loyalty_refuse"
					}
				]
			}
		]
	},
	char_rnd_admirer2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "jewelry",
		text = [
			{
				text = "CHARRND_ADMIRER_REPLY_SEND",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_ADMIRER_REPLY_NEGOTIATE",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_ADMIRER_REPLY_REFUSE",
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

				]
			}
		]
	},
	char_rnd_bath = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "bathroom",
		text = [
			{
				text = "CHARRND_BATH",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_bath2",
				text = "CHARRND_BATH_OPT_ACCEPT",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_bath_loyalty_accept"
					},
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "base_exp",
								value = "var_bath_exp_accept",
								operant = "+"
							}
						]
					}
				]
			},
			{
				code = "char_rnd_bath2",
				text = "CHARRND_BATH_OPT_PULLIN",
				active_char_translate = true,
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_bath_loyalty_pullin"
					}
				]
			},
			{
				code = "char_rnd_bath2",
				text = "CHARRND_BATH_OPT_DISMISS",
				active_char_translate = true,
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
								value = "var_bath_exp_dismiss",
								operant = "+"
							}
						]
					}
				]
			}
		]
	},
	char_rnd_bath2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "bathroom",
		text = [
			{
				text = "CHARRND_BATH_REPLY_ACCEPT",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_BATH_REPLY_PULLIN",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_BATH_REPLY_DISMISS",
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

				]
			}
		]
	},
	char_rnd_theft = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "warn",
		text = [
			{
				text = "CHARRND_THEFT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_theft2",
				text = "CHARRND_THEFT_OPT_PUNISH",
				active_char_translate = true,
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_theft_exp_punish"
					}
				]
			},
			{
				code = "char_rnd_theft2",
				text = "CHARRND_THEFT_OPT_EXPLAIN",
				active_char_translate = true,
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_theft_loyalty_explain"
					}
				]
			},
			{
				code = "char_rnd_theft2",
				text = "CHARRND_THEFT_OPT_SILENT",
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
								value = "var_theft_exp_silent",
								operant = "+"
							},
							{
								code = "wits",
								value = "var_theft_wits_silent",
								operant = "+"
							}
						]
					}
				]
			}
		]
	},
	char_rnd_theft2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "warn",
		text = [
			{
				text = "CHARRND_THEFT_REPLY_PUNISH",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_THEFT_REPLY_EXPLAIN",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_THEFT_REPLY_SILENT",
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

				]
			}
		]
	},
	char_rnd_sparring = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "kneel",
		text = [
			{
				text = "CHARRND_SPARRING",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_sparring2",
				text = "CHARRND_SPARRING_OPT_MOVE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_sparring_loyalty_move"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_sparring_exp_move"
					}
				]
			},
			{
				code = "char_rnd_sparring2",
				text = "CHARRND_SPARRING_OPT_CARE",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "change_relationship_precise",
						value = "var_sparring_relation_care"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_sparring_exp_care"
					}
				]
			},
			{
				code = "char_rnd_sparring2",
				text = "CHARRND_SPARRING_OPT_FORMAL",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "change_relationship_precise",
						value = "var_sparring_relation_formal"
					},
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "base_exp",
								value = "var_sparring_exp_formal",
								operant = "+"
							}
						]
					}
				]
			}
		]
	},
	char_rnd_sparring2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"few_scene_characters_translate"
		],
		image = "kneel",
		text = [
			{
				text = "CHARRND_SPARRING_REPLY_MOVE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_SPARRING_REPLY_CARE",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_SPARRING_REPLY_FORMAL",
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

				]
			}
		]
	},
	char_rnd_laying = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "no_image",
		text = [
			{
				text = "lilia_sick",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "char_rnd_laying2",
				text = "CHARRND_LAYING_OPT_TIME",
				active_char_translate = true,
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "real_affect_scene_characters",
						type = "set_availability",
						value = false,
						duration = "var_laying_rest_dur"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "base_exp",
						value = "var_laying_exp_time"
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_laying_loyalty_time"
					}
				]
			},
			{
				code = "char_rnd_laying2",
				text = "CHARRND_LAYING_OPT_STAY",
				active_char_translate = true,
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
								value = "var_laying_charm_stay",
								operant = "+"
							},
							{
								code = "base_exp",
								value = "var_laying_exp_stay",
								operant = "+"
							}
						]
					},
					{
						code = "real_affect_scene_characters",
						type = "stat",
						stat = "loyalty",
						value = "var_laying_loyalty_stay"
					}
				]
			},
			{
				code = "char_rnd_laying2",
				text = "CHARRND_LAYING_OPT_WORK",
				active_char_translate = true,
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
								value = "var_laying_exp_work",
								operant = "+"
							}
						]
					}
				]
			}
		]
	},
	char_rnd_laying2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		image = "lilia_sick",
		text = [
			{
				text = "CHARRND_LAYING_REPLY_TIME",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CHARRND_LAYING_REPLY_STAY",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CHARRND_LAYING_REPLY_WORK",
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

				]
			}
		]
	}
}
