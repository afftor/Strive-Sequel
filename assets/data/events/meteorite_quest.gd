extends Reference
var data = {
	meteor_lounge_start = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_LOUNGE_REVISIT",
				reqs = [
					{
						type = "dialogue_seen",
						check = true,
						value = "METEOR_LOUNGE_START"
					}
				]
			},
			{
				text = "METEOR_LOUNGE_START",
				reqs = [
					{
						type = "dialogue_seen",
						check = false,
						value = "METEOR_LOUNGE_START"
					}
				]
			}
		],
		options = [
			{
				code = "meteor_lounge_brief",
				text = "METEOR_LOUNGE_START_OPT_WHAT",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
			},
			{
				code = "close",
				text = "METEOR_LOUNGE_START_OPT_ANOTHER",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
			}
		]
	},
	meteor_lounge_brief = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_LOUNGE_BRIEF",
				reqs = [

				]
			},
		],
		options = [
			{
				code = "meteor_lounge_response",
				text = "METEOR_LOUNGE_BRIEF_OPT_CHECK",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
			},
			{
				code = "meteor_lounge_response",
				text = "METEOR_LOUNGE_BRIEF_OPT_MAYBE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
			}
		]
	},
	meteor_lounge_response = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_LOUNGE_RESPONSE",
				reqs = [

				]
			},
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "meteorite_quest",
						stage = "check_out"
					},
					{
						code = "make_quest_location",
						value = "quest_star_crater"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	meteor_ogres_start = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_OGRES_START",
				reqs = [

				]
			},
		],
		options = [
			{
				code = "meteor_ogres_camp",
				text = "METEOR_OGRES_START_OPT_FOLLOW",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	meteor_ogres_camp = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = [
			{
				text = "METEOR_OGRES_CAMP",
				reqs = [

				]
			},
		],
		options = [
			{
				code = "meteor_ogres_fight",
				text = "METEOR_OGRES_CAMP_OPT_FIGHT",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "meteor_ogres_win",
				text = "METEOR_OGRES_CAMP_OPT_CURSED",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				select_person = true,
				challenge = "persuasion"
			}
		]
	},
	meteor_ogres_fight = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_OGRES_FIGHT",
				reqs = [

				]
			},
		],
		options = [
			{
				code = "quest_fight",
				args = "meteorite_ogres",
				text = "DIALOGUEFIGHTOPTION",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	meteor_ogres_win = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_OGRES_TRICKED",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "METEOR_OGRES_SECURE",
				reqs = [

				]
			},
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "meteorite_quest",
						stage = "return_meteor"
					}
				]
			}
		]
	},
	meteor_lounge_return = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_LOUNGE_RETURN",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "meteor_lounge_return2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	meteor_lounge_return2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_LOUNGE_RETURN2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "meteorite_quest",
						stage = "find_use"
					},
					{
						code = "unlock_class",
						name = "druid"
					},
					{
						code = "update_city"
					},
					{
						code = "remove_quest_location",
						value = "quest_star_crater"
					},
				]
			}
		]
	},
	meteor_sigmund_start = {
		reqs = [

		],
		character = "sigmund",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_SIGMUND_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "meteor_sigmund_gold",
				text = "METEOR_SIGMUND_START_OPT_INSIDE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "meteor_sigmund_gold",
				text = "METEOR_SIGMUND_START_OPT_USE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
		]
	},
	meteor_sigmund_gold = {
		reqs = [

		],
		character = "sigmund",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_SIGMUND_GOLD",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "meteor_sigmund_access",
				text = "METEOR_SIGMUND_GOLD_OPT_PAY",
				dialogue_argument = 1,
				type = "next_dialogue",
				not_hide = true,
				reqs = [
					{
						type = "has_money",
						value = 200
					}
				],
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 200
					},
					{
						code = "decision",
						value = "BoughtSigmundsPass"
					}
				],
			},
			{
				code = "meteor_sigmund_access",
				text = "METEOR_SIGMUND_GOLD_OPT_ALREADY",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [
					{
						type = "capital_closed",
						name = "dwarf_capital",
						check = false
					}
				]
			},
			{
				code = "close",
				text = "METEOR_SIGMUND_GOLD_OPT_BACK",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "meteorite_quest",
						stage = "get_inside"
					}
				]
			},
		]
	},
	meteor_sigmund_access = {
		reqs = [

		],
		character = "sigmund",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_SIGMUND_PAY",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "METEOR_SIGMUND_ACCESS",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "METEOR_SIGMUND_LEAVE",
				reqs = [

				]
			},
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [
					{
						type = "capital_closed",
						name = "dwarf_capital",
						check = false
					}
				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "meteorite_quest",
						stage = "search_durim"
					}
				],
			},
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [
					{
						type = "capital_closed",
						name = "dwarf_capital",
						check = true
					}
				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "meteorite_quest",
						stage = "search_durim"
					},
					{
						code = "plan_loc_event",
						loc = "dwarf_capital",
						event = "enter_city_t_0"
					}
				],
			},
		]
	},
	meteor_enter_city2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		image = "dwarf_gates",
		text = [
			{
				text = "METEOR_ENTER_CITY2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 9,
			},
		],
	},
	meteor_durim_start = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_DURIM_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "meteor_durim_start2",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 9,
			},
		],
	},
	meteor_durim_start2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_DURIM_START2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "meteorite_durim",
				text = "METEOR_DURIM_START_OPT_FIGHT",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 9,
			},
			{
				code = "meteor_durim_ingot",
				text = "METEOR_DURIM_START_OPT_LET",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1,
			},
		],
	},
	meteor_durim_ingot = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		common_effects = [
			{
				code = 'material_change',
				operant = '+',
				material = 'meteorite_iron',
				value = 15
			},
			{
				code = "remove_decision",
				value = "BoughtSigmundsPass"
			}
		],
		text = [
			{
				text = "METEOR_DURIM_LET",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "METEOR_DURIM_WIN",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "METEOR_DURIM_FOUNDME",
				reqs = [

				]
			},
			{
				text = "METEOR_DURIM_NOPAYMENT",
				reqs = [

				],
				previous_dialogue_option = 2
			}
			
		],
		options = [
			{
				code = "meteor_durim_hara",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [
					{
						type = "has_active_quest",
						name = "dking_hara_quest",
						check = false
					},
					{
						type = "quest_completed",
						name = "dking_hara_quest",
						check = false
					}
				],
				dialogue_argument = 9,
			},
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [
					{
						type = "has_active_quest",
						name = "dking_hara_quest",
						check = true
					},
					{
						type = "quest_completed",
						name = "dking_hara_quest",
						check = true,
						orflag = true
					}
				],
				dialogue_argument = 9,
				bonus_effects = [
					{
						code = "complete_quest",
						value = "meteorite_quest"
					},
					{
						code = "update_city"
					}
				]
			},
		],
	},
	meteor_durim_hara = {
		reqs = [

		],
		character = "hara",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "METEOR_DURIM_HARA",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 9,
				bonus_effects = [
					{
						code = "complete_quest",
						value = "meteorite_quest"
					},
					{
						code = "update_city"
					}
				]
			},
		],
	},
	
	
	
	
}

