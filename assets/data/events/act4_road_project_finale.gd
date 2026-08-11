extends Reference
var data = {
	act4_road_courier_1 = {
		reqs = [
			{
				type = "any_quest_stage",
				value = "sebastian_railroad_quest",
				stages = [
					"sebastian_route_complete",
					"church_protected_complete"
				]
			},
			{
				type = "quest_completed",
				name = "rouge_quest",
				check = true
			},
			{
				type = "event_seen",
				value = "act4_3_opened_seal_after_fight",
				check = true
			}
		],
		image = null,
		character = null,
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_COURIER_1",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "complete_quest",
						value = "sebastian_railroad_quest"
					},
					{
						code = "progress_quest",
						value = "act4_road_project_quest",
						stage = "visit_road_project"
					},
					{
						code = "make_quest_location",
						value = "quest_dwarf_railroad"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	act4_road_arrive_1 = {
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_ARRIVE_1",
		options = [
			{
				code = "act4_road_arrive_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "exploration"
	},
	act4_road_arrive_2 = {
		image = null,
		character = null,
		character2 = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "ACT4_ROAD_ARRIVE_2",
		options = [
			{
				code = "act4_road_tunnel_1",
				text = "ACT4_ROAD_ARRIVE_OPTION_TAKE_ME",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_tunnel_1",
				text = "ACT4_ROAD_ARRIVE_OPTION_URGENT",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_tunnel_1 = {
		image = null,
		character = null,
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_TUNNEL_1",
		options = [
			{
				code = "act4_road_tunnel_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_tunnel_2 = {
		image = null,
		character = null,
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_TUNNEL_2",
		options = [
			{
				code = "act4_road_tunnel_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_tunnel_3 = {
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_TUNNEL_3",
		options = [
			{
				code = "act4_road_tunnel_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "dungeon"
	},
	act4_road_tunnel_4 = {
		image = null,
		character = null,
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_TUNNEL_4",
		options = [
			{
				code = "quest_fight",
				args = "act4_road_tunnel_undead",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_after_ambush_1 = {
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_AFTER_AMBUSH_1",
		options = [
			{
				code = "act4_road_rilu_reveal_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "intimate_dark"
	},
	act4_road_rilu_reveal_1 = {
		character = "rilu2",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_RILU_REVEAL_1",
		options = [
			{
				code = "act4_road_rilu_reveal_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		],
		music = "intimate_dark"
	},
	act4_road_rilu_reveal_2 = {
		image = null,
		character = "rilu2",
		character2 = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "ACT4_ROAD_RILU_REVEAL_2",
		options = [
			{
				code = "act4_road_rilu_hub",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 1
			}
		]
	},
	act4_road_rilu_hub = {
		character = "rilu2",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "ACT4_ROAD_RILU_HUB",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_ROAD_RILU_Q1",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_ROAD_RILU_Q2",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "ACT4_ROAD_RILU_Q3",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "act4_road_rilu_hub",
				text = "ACT4_ROAD_RILU_OPTION_WHO",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "act4_road_rilu_hub",
				text = "ACT4_ROAD_RILU_OPTION_HELPED",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "act4_road_rilu_hub",
				text = "ACT4_ROAD_RILU_OPTION_WHAT",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 4,
				remove_after_first_use = true
			},
			{
				code = "act4_road_rilu_q4",
				text = "ACT4_ROAD_RILU_OPTION_DEAD",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_rilu_q4 = {
		image = null,
		character = "rilu2",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_RILU_Q4",
		options = [
			{
				code = "act4_road_rilu_exit_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_rilu_exit_1 = {
		image = null,
		character = "rilu2",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_RILU_EXIT_1",
		options = [
			{
				code = "act4_road_rilu_exit_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_rilu_exit_2 = {
		image = null,
		character = "rilu2",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_RILU_EXIT_2",
		options = [
			{
				code = "act4_road_rilu_exit_3",
				text = "ACT4_ROAD_RILU_OPTION_CAPITAL",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_rilu_exit_3",
				text = "ACT4_ROAD_RILU_OPTION_ANSWERS",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_rilu_exit_3 = {
		image = null,
		character = "rilu2",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_RILU_EXIT_3",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "act4_road_project_quest",
						stage = "guild_quarters"
					},
					{
						code = "remove_quest_location",
						value = "quest_dwarf_railroad"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	act4_road_guild_quarters_1 = {
		character = "rilu2",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GUILD_QUARTERS_1",
		options = [
			{
				code = "act4_road_guild_quarters_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "threat"
	},
	act4_road_guild_quarters_2 = {
		image = null,
		character = "rilu2",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GUILD_QUARTERS_2",
		options = [
			{
				code = "quest_fight",
				args = "act4_road_guild_undead",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_guild_deeper_1 = {
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GUILD_DEEPER_1",
		options = [
			{
				code = "act4_road_guild_deeper_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "dungeon"
	},
	act4_road_guild_deeper_2 = {
		image = null,
		character = "rilu2",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GUILD_DEEPER_2",
		options = [
			{
				code = "act4_road_guild_deeper_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_guild_deeper_3 = {
		character = "sebastian",
		character2 = "demon_female",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GUILD_DEEPER_3",
		options = [
			{
				code = "act4_road_ritual_chamber_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "intimate_dark"
	},
	act4_road_ritual_chamber_1 = {
		image = null,
		character = "sebastian",
		character2 = "demon_female",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_RITUAL_CHAMBER_1",
		options = [
			{
				code = "act4_road_lich_reveal",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_lich_reveal = {
		character = "sebastian2",
		character2 = "demon_female",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "ACT4_ROAD_LICH_REVEAL",
		options = [
			{
				code = "act4_road_mhyrana_leaves",
				text = "ACT4_ROAD_LICH_OPTION_SOMETHING_ELSE",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_mhyrana_leaves",
				text = "ACT4_ROAD_LICH_OPTION_LICH",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_mhyrana_leaves",
				text = "ACT4_ROAD_LICH_OPTION_REGRET",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "threat"
	},
	act4_road_mhyrana_leaves = {
		image = null,
		character = "sebastian2",
		character2 = "demon_female",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MHYRANA_LEAVES",
		options = [
			{
				code = "act4_road_lich_monologue_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_lich_monologue_1 = {
		image = null,
		character = "sebastian2",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_LICH_MONOLOGUE_1",
		options = [
			{
				code = "act4_road_lich_monologue_2",
				text = "ACT4_ROAD_LICH_OPTION_RITUAL",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_lich_monologue_2",
				text = "ACT4_ROAD_LICH_OPTION_HIDDEN",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_lich_monologue_2 = {
		image = null,
		character = "sebastian2",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_LICH_MONOLOGUE_2",
		options = [
			{
				code = "act4_road_lich_prefight",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_lich_prefight = {
		character = "sebastian2",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_LICH_PREFIGHT",
		options = [
			{
				code = "quest_fight",
				args = "act4_road_sebastian_lich",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		character2 = "rilu2"
	},
	act4_road_rilu_sacrifice_1 = {
		character = "sebastian2",
		character2 = "rilu2",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_RILU_SACRIFICE_1",
		options = [
			{
				code = "act4_road_rilu_sacrifice_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "threat"
	},
	act4_road_rilu_sacrifice_2 = {
		character = "sebastian2",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_RILU_SACRIFICE_2",
		options = [
			{
				code = "act4_road_rilu_sacrifice_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		character2 = "rilu2"
	},
	act4_road_rilu_sacrifice_3 = {
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_RILU_SACRIFICE_3",
		options = [
			{
				code = "act4_road_rilu_sacrifice_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		],
		character2 = "rilu2",
		character = "sebastian2"
	},
	act4_road_rilu_sacrifice_4 = {
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "ACT4_ROAD_RILU_SACRIFICE_4",
		options = [
			{
				code = "act4_road_capital_chaos_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "dungeon"
	},
	act4_road_capital_chaos_1 = {
		image = null,
		character = null,
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_CAPITAL_CHAOS_1",
		options = [
			{
				code = "act4_road_capital_chaos_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_capital_chaos_2 = {
		image = null,
		character = null,
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_CAPITAL_CHAOS_2",
		options = [
			{
				code = "act4_road_giant_doors_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_giant_doors_1 = {
		character = "$rouge",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GIANT_DOORS_1",
		options = [
			{
				code = "act4_road_giant_doors_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "rouge_theme"
	},
	act4_road_giant_doors_2 = {
		image = null,
		character = "$rouge",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GIANT_DOORS_2",
		options = [
			{
				code = "act4_road_melchor_arrives",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_melchor_arrives = {
		image = null,
		character = "$rouge",
		character2 = "chancellor",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MELCHOR_ARRIVES",
		options = [
			{
				code = "act4_road_side_choice",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_side_choice = {
		image = null,
		character = "$rouge",
		character2 = "chancellor",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "ACT4_ROAD_SIDE_CHOICE",
		options = [
			{
				code = "act4_road_side_rouge",
				text = "ACT4_ROAD_SIDE_OPTION_ROUGE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "Act4SidedWithRouge"
					}
				]
			},
			{
				code = "act4_road_side_alone",
				text = "ACT4_ROAD_SIDE_OPTION_NEITHER",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_side_rouge = {
		image = null,
		character = "$rouge",
		character2 = "chancellor",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_SIDE_ROUGE",
		options = [
			{
				code = "quest_fight",
				args = "act4_road_cave_fight_rouge",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_side_alone = {
		image = null,
		character = "$rouge",
		character2 = "chancellor",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_SIDE_ALONE",
		options = [
			{
				code = "quest_fight",
				args = "act4_road_cave_fight_alone",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_mhyrana_ritual_1 = {
		character = "demon_female",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MHYRANA_RITUAL_1",
		options = [
			{
				code = "act4_road_mhyrana_ritual_rouge",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "Act4SidedWithRouge",
						check = true
					}
				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_mhyrana_ritual_2",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "Act4SidedWithRouge",
						check = false
					}
				],
				type = "next_dialogue"
			}
		],
		music = "threat"
	},
	act4_road_mhyrana_ritual_rouge = {
		image = null,
		character = "demon_female",
		character2 = "$rouge",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MHYRANA_RITUAL_ROUGE",
		options = [
			{
				code = "act4_road_mhyrana_ritual_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_mhyrana_ritual_2 = {
		image = null,
		character = "demon_female",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MHYRANA_RITUAL_2",
		options = [
			{
				code = "act4_road_mhyrana_ritual_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_mhyrana_ritual_3 = {
		image = null,
		character = "demon_female",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MHYRANA_RITUAL_3",
		options = [
			{
				code = "act4_road_grotus_power_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	act4_road_grotus_power_1 = {
		image = null,
		character = "grotus",
		character2 = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "ACT4_ROAD_GROTUS_POWER_1",
		options = [
			{
				code = "act4_road_grotus_comic_entry",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_grotus_comic_entry = {
		comic_scene = "act4_road_grotus_comic",
		image = null,
		character = null,
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "",
		options = [

		]
	},
	act4_road_grotus_ascended_1 = {
		character = "grotus_evil",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_ASCENDED_1",
		options = [
			{
				code = "act4_road_grotus_ascended_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "intimate_dark"
	},
	act4_road_grotus_ascended_2 = {
		image = null,
		character = "grotus_evil",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_ASCENDED_2",
		options = [
			{
				code = "act4_road_grotus_palace_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	act4_road_grotus_palace_1 = {
		image = null,
		character = "grotus_evil",
		character2 = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "ACT4_ROAD_GROTUS_PALACE_1",
		options = [
			{
				code = "act4_road_grotus_palace_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_grotus_palace_2 = {
		image = null,
		character = "grotus_evil",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_PALACE_2",
		options = [
			{
				code = "act4_road_grotus_palace_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_grotus_palace_3 = {
		image = null,
		character = "grotus_evil",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_PALACE_3",
		options = [
			{
				code = "act4_road_grotus_palace_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_grotus_palace_4 = {
		image = null,
		character = "grotus_evil",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_PALACE_4",
		options = [
			{
				code = "act4_road_grotus_emperor_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	act4_road_grotus_emperor_1 = {
		image = null,
		character = "grotus_evil",
		character2 = "emperor",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "ACT4_ROAD_GROTUS_EMPEROR_1",
		options = [
			{
				code = "act4_road_grotus_emperor_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_grotus_emperor_2 = {
		image = null,
		character = "grotus_evil",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_EMPEROR_2",
		options = [
			{
				code = "act4_road_grotus_hall_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	act4_road_grotus_hall_1 = {
		image = null,
		character = "grotus_king",
		character2 = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "ACT4_ROAD_GROTUS_HALL_1",
		options = [
			{
				code = "act4_road_grotus_hall_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_grotus_hall_2 = {
		image = null,
		character = "grotus_king",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_HALL_2",
		options = [
			{
				code = "act4_road_grotus_throne_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_grotus_throne_1 = {
		image = null,
		character = "grotus_king",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_THRONE_1",
		options = [
			{
				code = "act4_road_grotus_throne_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_grotus_throne_2 = {
		image = null,
		character = "grotus_king",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_THRONE_2",
		options = [
			{
				code = "act4_road_grotus_throne_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_grotus_throne_3 = {
		image = null,
		character = "grotus_king",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_THRONE_3",
		options = [
			{
				code = "act4_road_grotus_throne_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_grotus_throne_4 = {
		image = null,
		character = "grotus_king",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_THRONE_4",
		options = [
			{
				code = "act4_road_grotus_throne_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_grotus_throne_5 = {
		image = null,
		character = "grotus_king",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_THRONE_5",
		options = [
			{
				code = "act4_road_wake_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	act4_road_wake_1 = {
		character = "$rouge",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "ACT4_ROAD_WAKE_1",
		options = [
			{
				code = "act4_road_wake_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "rouge_theme"
	},
	act4_road_wake_2 = {
		image = null,
		character = "$rouge",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "ACT4_ROAD_WAKE_2_ALLY",
				reqs = [
					{
						type = "decision",
						value = "Act4SidedWithRouge",
						check = true
					}
				]
			},
			{
				text = "ACT4_ROAD_WAKE_2_HOSTILE",
				reqs = [
					{
						type = "decision",
						value = "Act4SidedWithRouge",
						check = false
					}
				]
			}
		],
		options = [
			{
				code = "act4_road_wake_hub",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 1
			}
		]
	},
	act4_road_wake_hub = {
		character = "$rouge",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "ACT4_ROAD_WAKE_HUB",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_ROAD_WAKE_Q1",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_ROAD_WAKE_Q2",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "act4_road_wake_hub",
				text = "ACT4_ROAD_WAKE_OPTION_STAY",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "act4_road_wake_hub",
				text = "ACT4_ROAD_WAKE_OPTION_LEFT",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "act4_road_wake_q3",
				text = "ACT4_ROAD_WAKE_OPTION_MHYRANA",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_wake_q3 = {
		image = null,
		character = "$rouge",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_WAKE_Q3",
		options = [
			{
				code = "act4_road_city_return_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	act4_road_city_return_1 = {
		image = null,
		character = "$rouge",
		character2 = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "ACT4_ROAD_CITY_RETURN_1",
		options = [
			{
				code = "act4_road_rouge_stays_ally",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "Act4SidedWithRouge",
						check = true
					}
				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_rouge_fork",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "Act4SidedWithRouge",
						check = false
					}
				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_rouge_fork = {
		image = null,
		character = "$rouge",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_ROUGE_FORK",
		options = [
			{
				code = "act4_road_rouge_dismissed",
				text = "ACT4_ROAD_ROUGE_OPTION_DISMISS",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_rouge_stays",
				text = "ACT4_ROAD_ROUGE_OPTION_DEAL",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_rouge_dismissed = {
		image = null,
		character = "$rouge",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_ROUGE_DISMISSED",
		options = [
			{
				code = "act4_road_melchor_messenger_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "Act4RougeDismissed"
					},
					{
						code = "unique_character_changes",
						value = "rouge",
						args = [
							{
								code = "remove_character"
							}
						]
					},
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	act4_road_rouge_stays = {
		image = null,
		character = "$rouge",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_ROUGE_STAYS",
		options = [
			{
				code = "act4_road_melchor_messenger_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	act4_road_rouge_stays_ally = {
		image = null,
		character = "$rouge",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_ROUGE_STAYS_ALLY",
		options = [
			{
				code = "act4_road_melchor_messenger_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	act4_road_melchor_messenger_1 = {
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		text = "ACT4_ROAD_MELCHOR_MESSENGER_1",
		options = [
			{
				code = "act4_road_melchor_messenger_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "dungeon"
	},
	act4_road_melchor_messenger_2 = {
		image = null,
		character = null,
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MELCHOR_MESSENGER_2",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "act4_road_project_quest",
						stage = "meet_melchor"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	act4_road_melchor_hiding_1 = {
		character = "chancellor",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MELCHOR_HIDING_1",
		options = [
			{
				code = "act4_road_melchor_hiding_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "dungeon"
	},
	act4_road_melchor_hiding_2 = {
		image = null,
		character = "chancellor",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MELCHOR_HIDING_2",
		options = [
			{
				code = "act4_road_melchor_hiding_rouge",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "Act4RougeDismissed",
						check = false
					}
				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_melchor_hiding_3",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "Act4RougeDismissed",
						check = true
					}
				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_melchor_hiding_rouge = {
		image = null,
		character = "chancellor",
		character2 = "$rouge",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MELCHOR_HIDING_ROUGE",
		options = [
			{
				code = "act4_road_melchor_hiding_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_melchor_hiding_3 = {
		image = null,
		character = "chancellor",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MELCHOR_HIDING_3",
		options = [
			{
				code = "act4_road_melchor_hiding_4",
				text = "ACT4_ROAD_MELCHOR_OPTION_INDIVIDUAL",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_melchor_hiding_4",
				text = "ACT4_ROAD_MELCHOR_OPTION_SENERUS",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_melchor_hiding_4 = {
		image = null,
		character = "chancellor",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MELCHOR_HIDING_4",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "act4_road_project_quest",
						stage = "ask_senerus"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	act4_road_senerus_1 = {
		character = "senerus",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_SENERUS_1",
		options = [
			{
				code = "act4_road_senerus_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "dungeon"
	},
	act4_road_senerus_2 = {
		image = null,
		character = "senerus",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_SENERUS_2",
		options = [
			{
				code = "act4_road_senerus_hub",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_senerus_hub = {
		image = null,
		character = "senerus",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_SENERUS_HUB",
		options = [
			{
				code = "act4_road_senerus_asura",
				text = "ACT4_ROAD_SENERUS_OPTION_ASURA",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "has_profession",
								profession = "asura",
								check = true
							}
						]
					}
				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_senerus_satori",
				text = "ACT4_ROAD_SENERUS_OPTION_SATORI",
				reqs = [
					{
						type = "unique_available",
						name = "kuro",
						check = true
					},
					{
						type = "unique_character_checks",
						name = "kuro",
						value = [
							{
								code = "has_profession",
								profession = "satori",
								check = true
							}
						]
					}
				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_senerus_heleviel",
				text = "ACT4_ROAD_SENERUS_OPTION_HELEVIEL",
				reqs = [
					{
						type = "quest_completed",
						name = "heleviel_quest3",
						check = true
					}
				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_senerus_artifact_hub",
				text = "ACT4_ROAD_SENERUS_OPTION_ARTIFACT",
				reqs = [
					{
						type = "has_items",
						name = "sacred_scales",
						operant = "gte",
						value = 1
					},
					{
						type = "has_items",
						name = "sacred_bowl",
						operant = "gte",
						value = 1,
						orflag = true
					},
					{
						type = "has_items",
						name = "holy_sword",
						operant = "gte",
						value = 1,
						orflag = true
					},
					{
						type = "has_items",
						name = "holy_spear",
						operant = "gte",
						value = 1,
						orflag = true
					}
				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_senerus_arrow",
				text = "ACT4_ROAD_SENERUS_OPTION_NOTHING",
				reqs = [
					{
						type = "unique_available",
						name = "kuro",
						check = false
					},
					{
						type = "unique_character_checks",
						name = "kuro",
						value = [
							{
								code = "has_profession",
								profession = "satori",
								check = false
							}
						],
						orflag = true
					},
					{
						type = "master_check",
						value = [
							{
								code = "has_profession",
								profession = "asura",
								check = false
							}
						]
					},
					{
						type = "quest_completed",
						name = "heleviel_quest3",
						check = false
					},
					{
						type = "has_items",
						name = "sacred_scales",
						operant = "lt",
						value = 1
					},
					{
						type = "has_items",
						name = "sacred_bowl",
						operant = "lt",
						value = 1
					},
					{
						type = "has_items",
						name = "holy_sword",
						operant = "lt",
						value = 1
					},
					{
						type = "has_items",
						name = "holy_spear",
						operant = "lt",
						value = 1
					}
				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_senerus_asura = {
		image = null,
		character = "senerus",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_SENERUS_ASURA",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "Act4GrotusStrikeAsura"
					},
					{
						code = "progress_quest",
						value = "act4_road_project_quest",
						stage = "return_to_melchor"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	act4_road_senerus_satori = {
		image = null,
		character = "senerus",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_SENERUS_SATORI",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "Act4GrotusStrikeSatori"
					},
					{
						code = "progress_quest",
						value = "act4_road_project_quest",
						stage = "return_to_melchor"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	act4_road_senerus_heleviel = {
		image = null,
		character = "senerus",
		character2 = "$heleviel",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "ACT4_ROAD_SENERUS_HELEVIEL",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "Act4GrotusStrikeHeleviel"
					},
					{
						code = "progress_quest",
						value = "act4_road_project_quest",
						stage = "return_to_melchor"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	act4_road_senerus_artifact_hub = {
		image = null,
		character = "senerus",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_SENERUS_ARTIFACT_HUB",
		options = [
			{
				code = "act4_road_senerus_artifact_done",
				text = "ACT4_ROAD_SENERUS_ARTIFACT_SCALES",
				reqs = [
					{
						type = "has_items",
						name = "sacred_scales",
						operant = "gte",
						value = 1
					}
				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "remove_item",
						name = "sacred_scales",
						number = 1
					}
				]
			},
			{
				code = "act4_road_senerus_artifact_done",
				text = "ACT4_ROAD_SENERUS_ARTIFACT_BOWL",
				reqs = [
					{
						type = "has_items",
						name = "sacred_bowl",
						operant = "gte",
						value = 1
					}
				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "remove_item",
						name = "sacred_bowl",
						number = 1
					}
				]
			},
			{
				code = "act4_road_senerus_artifact_done",
				text = "ACT4_ROAD_SENERUS_ARTIFACT_SWORD",
				reqs = [
					{
						type = "has_items",
						name = "holy_sword",
						operant = "gte",
						value = 1
					}
				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "remove_item",
						name = "holy_sword",
						number = 1
					}
				]
			},
			{
				code = "act4_road_senerus_artifact_done",
				text = "ACT4_ROAD_SENERUS_ARTIFACT_SPEAR",
				reqs = [
					{
						type = "has_items",
						name = "holy_spear",
						operant = "gte",
						value = 1
					}
				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "remove_item",
						name = "holy_spear",
						number = 1
					}
				]
			},
			{
				code = "act4_road_senerus_hub",
				text = "ACT4_ROAD_SENERUS_ARTIFACT_BACK",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_senerus_artifact_done = {
		image = null,
		character = "senerus",
		character2 = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "ACT4_ROAD_SENERUS_ARTIFACT_DONE",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "Act4GrotusStrikeArtifact"
					},
					{
						code = "progress_quest",
						value = "act4_road_project_quest",
						stage = "return_to_melchor"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	act4_road_senerus_arrow = {
		image = null,
		character = "senerus",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_SENERUS_ARROW",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "act4_road_project_quest",
						stage = "imbue_arrow"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	act4_road_priestess_arrow = {
		variations = [
			{
				reqs = [
					{
						type = "decision",
						value = "LiraPriestess",
						check = true
					}
				],
				image = null,
				character = "lira_priestess",
				character2 = null,
				tags = [
					"dialogue_scene"
				],
				text = "ACT4_ROAD_PRIESTESS_ARROW_LIRA",
				options = [
					{
						code = "close",
						text = "DIALOGUECLOSE",
						reqs = [

						],
						type = "next_dialogue",
						bonus_effects = [
							{
								code = "decision",
								value = "Act4GrotusStrikeArrow"
							},
							{
								code = "progress_quest",
								value = "act4_road_project_quest",
								stage = "return_to_melchor"
							},
							{
								code = "update_city"
							}
						]
					}
				]
			},
			{
				reqs = [

				],
				image = null,
				character = "heleviel",
				character2 = null,
				tags = [
					"dialogue_scene"
				],
				text = "ACT4_ROAD_PRIESTESS_ARROW_HELEVIEL",
				options = [
					{
						code = "close",
						text = "DIALOGUECLOSE",
						reqs = [

						],
						type = "next_dialogue",
						bonus_effects = [
							{
								code = "decision",
								value = "Act4GrotusStrikeArrow"
							},
							{
								code = "progress_quest",
								value = "act4_road_project_quest",
								stage = "return_to_melchor"
							},
							{
								code = "update_city"
							}
						]
					}
				]
			}
		]
	},
	act4_road_melchor_plan_1 = {
		character = "chancellor",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MELCHOR_PLAN_1",
		options = [
			{
				code = "act4_road_melchor_plan_2",
				text = "ACT4_ROAD_MELCHOR_PLAN_OPTION_BREAK",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "act4_road_melchor_plan_2",
				text = "ACT4_ROAD_MELCHOR_PLAN_OPTION_OPENING",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "dungeon"
	},
	act4_road_melchor_plan_2 = {
		image = null,
		character = "chancellor",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MELCHOR_PLAN_2",
		options = [
			{
				code = "act4_road_melchor_plan_rouge",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "Act4RougeDismissed",
						check = false
					}
				],
				type = "next_dialogue"
			},
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [
					{
						type = "decision",
						value = "Act4RougeDismissed",
						check = true
					}
				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "act4_road_project_quest",
						stage = "charge_palace"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	act4_road_melchor_plan_rouge = {
		image = null,
		character = "chancellor",
		character2 = "$rouge",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MELCHOR_PLAN_ROUGE",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "act4_road_project_quest",
						stage = "charge_palace"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	act4_road_palace_1 = {
		character = "grotus_king",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_PALACE_1",
		options = [
			{
				code = "act4_road_palace_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "threat"
	},
	act4_road_palace_2 = {
		image = null,
		character = "grotus_king",
		character2 = null,
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_PALACE_2",
		options = [
			{
				code = "quest_fight",
				args = "act4_road_grotus_phase1",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_barrier_break = {
		character = "grotus_king",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "ACT4_ROAD_BARRIER_ASURA",
				reqs = [
					{
						type = "decision",
						value = "Act4GrotusStrikeAsura",
						check = true
					}
				]
			},
			{
				text = "ACT4_ROAD_BARRIER_SATORI",
				reqs = [
					{
						type = "decision",
						value = "Act4GrotusStrikeSatori",
						check = true
					}
				]
			},
			{
				text = "ACT4_ROAD_BARRIER_HELEVIEL",
				reqs = [
					{
						type = "decision",
						value = "Act4GrotusStrikeHeleviel",
						check = true
					}
				]
			},
			{
				text = "ACT4_ROAD_BARRIER_ARTIFACT",
				reqs = [
					{
						type = "decision",
						value = "Act4GrotusStrikeArtifact",
						check = true
					}
				]
			},
			{
				text = "ACT4_ROAD_BARRIER_ARROW",
				reqs = [
					{
						type = "decision",
						value = "Act4GrotusStrikeArrow",
						check = true
					}
				]
			},
			{
				text = "ACT4_ROAD_BARRIER_TAIL",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "act4_road_grotus_phase2",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		music = "threat"
	},
	act4_road_grotus_defeat_1 = {
		character = "grotus_king",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_GROTUS_DEFEAT_1",
		options = [
			{
				code = "act4_road_mhyrana_returns_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	act4_road_mhyrana_returns_1 = {
		character = "grotus_king",
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MHYRANA_RETURNS_1",
		options = [
			{
				code = "act4_road_mhyrana_returns_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_shake"
					}
				]
			}
		],
		character2 = "demon_female"
	},
	act4_road_mhyrana_returns_2 = {
		tags = [
			"dialogue_scene"
		],
		text = "ACT4_ROAD_MHYRANA_RETURNS_2",
		options = [
			{
				code = "act4_road_first_god_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		],
		common_effects = [
			{
				code = "play_sound",
				value = "crunch"
			}
		]
	},
	act4_road_first_god_1 = {
		character = "demon_female",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "ACT4_ROAD_FIRST_GOD_1",
		options = [
			{
				code = "act4_road_act4_end",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		],
		common_effects = [
			{
				code = "play_sound",
				value = "explosion"
			}
		]
	},
	act4_road_act4_end = {
		image = null,
		character = null,
		character2 = null,
		music = "stop",
		custom_background = "blackscreen",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "ACT4_ROAD_ACT4_END",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "act4_road_project_quest",
						stage = "story_end"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	}
}

var comic_events = {
	act4_road_grotus_comic = [
		[
			{type = 'frame', image = "res://assets/images/comic scenes/grotus_2/1.png", position = Vector2(0, -20), size = Vector2(1920, 1080)},
			{type = 'text', text = "ACT4_ROAD_GROTUS_COMIC_1"},
		],
		[
			{type = 'frame', image = "res://assets/images/comic scenes/grotus_2/2.png", position = Vector2(0, -20), size = Vector2(1920, 1080)},
			{type = 'text', text = "ACT4_ROAD_GROTUS_COMIC_2"},
		],
		[
			{type = 'frame', image = "res://assets/images/comic scenes/grotus_2/3.png", position = Vector2(0, -20), size = Vector2(1920, 1080)},
			{type = 'text', text = "ACT4_ROAD_GROTUS_COMIC_3"},
			{type = 'sound', value = 'speech'},
		],
		[
			{type = 'frame', image = "res://assets/images/comic scenes/grotus_2/4.png", position = Vector2(0, -20), size = Vector2(1920, 1080)},
			{type = 'text', text = "ACT4_ROAD_GROTUS_COMIC_4"},
		],
		[
			{type = 'frame', image = "res://assets/images/comic scenes/grotus_2/5.png", position = Vector2(0, -20), size = Vector2(1920, 1080), delay = 0.5},
			{type = 'text', text = "ACT4_ROAD_GROTUS_COMIC_5"},
			{type = 'shake_screen'},
		],
		{type = 'continue', scene = 'act4_road_grotus_ascended_1'}
	],
}