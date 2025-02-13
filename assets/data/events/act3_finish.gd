extends Reference
var data = {
	dwarf_ceremony_intro = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "dwarf_king",
		text = [
			{
				text = "DWARF_CEREMONY_INTRO",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_ceremony_intro2",
				text = "DWARF_CEREMONY_OPT_PAYMENT",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "dwarf_ceremony_intro2",
				text = "DWARF_CEREMONY_OPT_SAFE",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	dwarf_ceremony_intro2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		character2 = "kuro",
		text = [
			{
				text = "DWARF_CEREMONY_REPLY_PAYMENT",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DWARF_CEREMONY_REPLY_SAFE",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DWARF_CEREMONY_INTRO2",
				reqs = [

				]
			},
			{
				text = "DWARF_CEREMONY_INTRO2_VAULT",
				reqs = [
					{
						type = "decision",
						value = "JeanHelp",
						check = true
					}
				]
			},
			{
				text = "DWARF_CEREMONY_INTRO2_NOVAULT",
				reqs = [
					{
						type = "decision",
						value = "JeanReport",
						check = true
					}
				]
			}
		],
		options = [
			{
				code = "dwarf_ceremony_intro3",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	dwarf_ceremony_intro3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		character2 = "kuro",
		text = [
			{
				text = "DWARF_CEREMONY_INTRO3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_ceremony_peak",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	dwarf_ceremony_peak = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		character2 = "kuro",
		text = [
			{
				text = "DWARF_CEREMONY_PEAK_KING",
				reqs = [
					{
						type = "decision",
						value = "JoinCoalition",
						check = false
					}
				]
			},
			{
				text = "DWARF_CEREMONY_PEAK_COAL",
				reqs = [
					{
						type = "decision",
						value = "JoinCoalition",
						check = true
					}
				]
			}
		],
		options = [
			{
				code = "dwarf_ceremony_reply_chase",
				text = "DWARF_CEREMONY_OPT_CHASE",
				type = "next_dialogue",
				reqs = [

				],
				select_person = true,
				challenge = "dexterity",
				not_hide = true
			},
			{
				code = "quest_fight",
				args = "dwarf_ceremony_cult",
				text = "DWARF_CEREMONY_OPT_FIGHT",
				type = "next_dialogue",
				reqs = [
					{
						type = "decision",
						value = "JoinCoalition",
						check = false
					}
				]
			},
			{
				code = "quest_fight",
				args = "dwarf_ceremony_guards",
				text = "DWARF_CEREMONY_OPT_FIGHT",
				type = "next_dialogue",
				reqs = [
					{
						type = "decision",
						value = "JoinCoalition",
						check = true
					}
				]
			}
		]
	},
	dwarf_ceremony_reply_chase = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DWARF_CEREMONY_REPLY_CHASE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_ceremony_kuro",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	dwarf_ceremony_kuro = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		character = "kuro",
		text = [
			{
				text = "DWARF_CEREMONY_KURO",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_ceremony_kuro2",
				dialogue_argument = 1,
				text = "DWARF_CEREMONY_OPT_BETRAYAL",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "dwarf_ceremony_kuro2",
				dialogue_argument = 2,
				text = "DWARF_CEREMONY_OPT_ARTIFACT",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "dwarf_ceremony_kuro2",
				dialogue_argument = 3,
				text = "DWARF_CEREMONY_OPT_TALKOVER",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	dwarf_ceremony_kuro2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "DWARF_CEREMONY_REPLY_BETRAYAL",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DWARF_CEREMONY_REPLY_ARTIFACT",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DWARF_CEREMONY_REPLY_TALKOVER",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "dwarf_ceremony_caughtup",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	dwarf_ceremony_caughtup = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "dwarf_king",
		text = [
			{
				text = "DWARF_CEREMONY_CAUGHTUP",
				reqs = [

				]
			},
			{
				text = "DWARF_CEREMONY_CAUGHTUP_COAL",
				reqs = [
					{
						type = "decision",
						value = "JoinCoalition",
						check = false
					}
				]
			},
			{
				text = "DWARF_CEREMONY_CAUGHTUP_CULT",
				reqs = [
					{
						type = "decision",
						value = "JoinCoalition",
						check = true
					}
				]
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "dwarf_ceremony_coal",
				dialogue_argument = 0,
				text = "DWARF_CEREMONY_OPT_FIGHT",
				type = "next_dialogue",
				reqs = [
					{
						type = "decision",
						value = "JoinCoalition",
						check = false
					}
				]
			},
			{
				code = "quest_fight",
				args = "dwarf_ceremony_cult2",
				dialogue_argument = 0,
				text = "DWARF_CEREMONY_OPT_FIGHT",
				type = "next_dialogue",
				reqs = [
					{
						type = "decision",
						value = "JoinCoalition",
						check = true
					}
				]
			}
		]
	},
	kuro_resolution_intro = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "KURO_RESOLUTION_INTRO",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_resolution_finale",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_resolution_finale = {
		variations = [
			{
				reqs = [
					{
						type = "decision",
						value = "KetchKilled",
						check = true
					}
				],
				tags = [
					"dialogue_scene"
				],
				character = "kuro",
				character2 = "demon_female",
				text = [
					{
						text = "KURORES_FINALE_NO_KETCH",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "kurores_finale_no_ketch2",
						dialogue_argument = 0,
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						type = "next_dialogue"
					}
				]
			},
			{
				reqs = [
					{
						type = "decision",
						value = "KetchKilled",
						check = false
					}
				],
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				character = "kuro",
				character2 = "ketch",
				text = [
					{
						text = "KURORES_FINALE_KETCH",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "kurores_finale_ketch2",
						dialogue_argument = 0,
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						type = "next_dialogue"
					}
				]
			}
		]
	},
	kurores_finale_no_ketch2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		character2 = "demon_female",
		text = [
			{
				text = "KURORES_FINALE_NO_KETCH2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_aftermatch_start",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kurores_finale_ketch2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		character2 = "ketch",
		text = [
			{
				text = "KURORES_FINALE_KETCH2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kurores_finale_ketch3",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kurores_finale_ketch3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "ketch",
		text = [
			{
				text = "KURORES_FINALE_KETCH3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kurores_finale_ketch4",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kurores_finale_ketch4 = {
		variations = [
			{
				reqs = [
					{
						type = "location_has_specific_slaves",
						check = true,
						value = 1,
						location = "dwarf_capital",
						reqs = [
							{
								code = "unique",
								value = "zephyra"
							}
						]
					}
				],
				tags = [
					"dialogue_scene"
				],
				character = "kuro",
				character2 = "ketch",
				text = [
					{
						text = "KURORES_FINALE_ZEPHHIT",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "kurores_finale_helpzeph",
						dialogue_argument = 0,
						text = "KURORES_FINALE_OPT_HELPZEPH",
						reqs = [

						],
						type = "next_dialogue"
					},
					{
						code = "kurores_finale_chase",
						dialogue_argument = 0,
						text = "KURORES_FINALE_OPT_CHASE",
						reqs = [

						],
						type = "next_dialogue",
						bonus_effects = [
							{
								code = "unique_character_changes",
								value = "zephyra",
								args = [
									{
										code = "remove_character"
									}
								]
							}
						]
					}
				]
			},
			{
				reqs = [

				],
				tags = [
					"dialogue_scene"
				],
				character = "kuro",
				character2 = "ketch",
				text = [
					{
						text = "KURORES_FINALE_KUROHIT",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "kurores_finale_helpkuro",
						dialogue_argument = 0,
						text = "KURORES_FINALE_OPT_HELPKURO",
						reqs = [

						],
						type = "next_dialogue"
					},
					{
						code = "kurores_finale_chase",
						dialogue_argument = 0,
						text = "KURORES_FINALE_OPT_CHASE",
						reqs = [

						],
						type = "next_dialogue",
						bonus_effects = [
							{
								code = "decision",
								value = "KuroDead"
							}
						]
					}
				]
			}
		]
	},
	kurores_finale_helpkuro = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURORES_FINALE_HELPKURO",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kurores_finale_helpkuro2",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kurores_finale_helpkuro2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		character = "kuro",
		text = [
			{
				text = "KURORES_FINALE_HELPKURO2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_aftermatch_start",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kurores_finale_helpzeph = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		character2 = "zephyra",
		text = [
			{
				text = "KURORES_FINALE_HELPZEPH",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kurores_finale_helpzeph_reply",
				dialogue_argument = 1,
				text = "KURORES_FINALE_OPT_CANT",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "zephyra",
						args = [
							{
								code = "remove_character"
							}
						]
					}
				]
			},
			{
				code = "kurores_finale_helpzeph_reply",
				dialogue_argument = 2,
				text = "KURORES_FINALE_OPT_POWER",
				type = "next_dialogue",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "has_profession",
								profession = "bishop",
								check = true
							}
						]
					}
				],
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "mp",
								operant = "=",
								value = 0
							}
						]
					}
				]
			},
			{
				code = "kurores_finale_helpzeph_reply",
				dialogue_argument = 3,
				text = "KURORES_FINALE_OPT_PRAY",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "master",
						args = [
							{
								code = "growth_factor",
								value = 1,
								operant = "-"
							}
						]
					}
				]
			}
		]
	},
	kurores_finale_helpzeph_reply = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURORES_FINALE_REPLY_CANT",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURORES_FINALE_REPLY_POWER",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURORES_FINALE_REPLY_PRAY",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "dwarf_aftermatch_start",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kurores_finale_chase = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "ketch",
		text = [
			{
				text = "KURORES_FINALE_CHASE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kurores_finale_chase2",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kurores_finale_chase2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "ketch",
		text = [
			{
				text = "KURORES_FINALE_CHASE2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_aftermatch_start",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "make_loot",
						pool = [
							[
								"sacred_scales_reward",
								1
							]
						]
					},
					{
						code = "open_loot"
					}
				]
			}
		]
	},
	dwarf_aftermatch_start = {
		variations = [
			{
				reqs = [
					{
						type = "decision",
						value = "JoinCoalition",
						check = false
					},
					{
						type = "decision",
						value = "KuroDead",
						check = true
					},
					{
						type = "dialogue_seen",
						check = false,
						value = "DWARF_AFTERMATCH_KING_NOKURO"
					}
				],
				tags = [
					"dialogue_scene"
				],
				character = "dwarf_king",
				text = [
					{
						text = "DWARF_AFTERMATCH_KING_NOKURO",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "dwarf_aftermatch_start",
						dialogue_argument = 0,
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						type = "next_dialogue"
					}
				],
				common_effects = [
					{
						code = "decision",
						value = "act3_finish"
					}
				]
			},
			{
				reqs = [
					{
						type = "decision",
						value = "JoinCoalition",
						check = false
					}
				],
				tags = [
					"dialogue_scene"
				],
				character = "dwarf_king",
				text = [
					{
						text = "DWARF_AFTERMATCH_KING_NOKURO2",
						previous_dialogue_option = 0,
						reqs = [
							{
								type = "decision",
								value = "KuroDead",
								check = true
							}
						]
					},
					{
						text = "DWARF_AFTERMATCH_KING",
						previous_dialogue_option = 0,
						reqs = [
							{
								type = "decision",
								value = "KuroDead",
								check = false
							}
						]
					},
					{
						text = "DWARF_AFTERMATCH_REPLY_K_HARA",
						reqs = [

						],
						previous_dialogue_option = 1
					},
					{
						text = "",
						reqs = [

						],
						previous_dialogue_option = 2
					}
				],
				options = [
					{
						code = "dwarf_aftermatch_start",
						dialogue_argument = 1,
						remove_after_first_use = true,
						text = "DWARF_AFTERMATCH_OPT_HARA",
						reqs = [

						],
						bonus_effects = [
							{
								code = "decision",
								value = "TempRecruitHara"
							},
							{
								code = "update_city"
							}
						]
					},
					{
						code = "dwarf_aftermatch_reply_k_jean",
						dialogue_argument = 0,
						text = "DWARF_AFTERMATCH_OPT_JEAN",
						type = "next_dialogue",
						reqs = [
							{
								type = "decision",
								value = "TempBlockJean",
								check = false
							}
						]
					},
					{
						code = "dwarf_aftermatch_reply_k_kuro",
						dialogue_argument = 0,
						text = "DWARF_AFTERMATCH_OPT_KURO",
						reqs = [
							{
								type = "decision",
								value = "KuroDead",
								check = false
							},
							{
								type = "decision",
								value = "TempRecruitKuro",
								check = false
							}
						]
					},
					{
						code = "close",
						dialogue_argument = 0,
						text = "DIALOGUELEAVE",
						type = "next_dialogue",
						reqs = [
							{
								type = "decision",
								value = "KuroDead",
								check = true
							},
							{
								type = "dialogue_selected",
								value = "DWARF_AFTERMATCH_OPT_HARA",
								check = true
							},
							{
								type = "dialogue_selected",
								value = "DWARF_AFTERMATCH_OPT_JEAN",
								check = true
							}
						],
						bonus_effects = [
							{
								code = "complete_quest",
								value = "hara_scales_quest"
							},
							{
								code = "update_city"
							},
							{
								code = "remove_decision",
								value = "TempBlockJean"
							}
						]
					},
					{
						code = "close",
						dialogue_argument = 0,
						text = "DIALOGUELEAVE",
						type = "next_dialogue",
						reqs = [
							{
								type = "decision",
								value = "KuroDead",
								check = false
							},
							{
								type = "dialogue_selected",
								value = "DWARF_AFTERMATCH_OPT_KURO",
								check = true
							},
							{
								type = "dialogue_selected",
								value = "DWARF_AFTERMATCH_OPT_HARA",
								check = true
							},
							{
								type = "dialogue_selected",
								value = "DWARF_AFTERMATCH_OPT_JEAN",
								check = true
							}
						],
						bonus_effects = [
							{
								code = "complete_quest",
								value = "hara_scales_quest"
							},
							{
								code = "update_city"
							},
							{
								code = "remove_decision",
								value = "TempBlockJean"
							}
						]
					}
				]
			},
			{
				reqs = [
					{
						type = "decision",
						value = "JoinCoalition",
						check = true
					}
				],
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				text = [
					{
						text = "DWARF_AFTERMATCH_COAL",
						reqs = [

						],
						previous_dialogue_option = 0
					},
					{
						text = "DWARF_AFTERMATCH_COAL_ART",
						previous_dialogue_option = 0,
						reqs = [
							{
								type = "has_items",
								operant = "gte",
								value = 1,
								name = "sacred_scales"
							}
						]
					},
					{
						text = "DWARF_AFTERMATCH_COAL_NOART",
						previous_dialogue_option = 0,
						reqs = [
							{
								type = "has_items",
								operant = "lt",
								value = 1,
								name = "sacred_scales"
							}
						]
					},
					{
						text = "DWARF_AFTERMATCH_REPLY_C_HARA",
						reqs = [

						],
						previous_dialogue_option = 1
					},
					{
						text = "",
						reqs = [

						],
						previous_dialogue_option = 2
					},
					{
						text = "DWARF_AFTERMATCH_REPLY_C_JEAN",
						reqs = [

						],
						previous_dialogue_option = 3
					}
				],
				options = [
					{
						code = "dwarf_aftermatch_start",
						dialogue_argument = 1,
						remove_after_first_use = true,
						text = "DWARF_AFTERMATCH_OPT_HARA",
						reqs = [

						],
						type = "next_dialogue",
						bonus_effects = [
							{
								code = "decision",
								value = "TempRecruitHara"
							},
							{
								code = "update_city"
							}
						]
					},
					{
						code = "dwarf_aftermatch_start",
						dialogue_argument = 3,
						remove_after_first_use = true,
						text = "DWARF_AFTERMATCH_OPT_JEAN",
						reqs = [

						],
						type = "next_dialogue",
						bonus_effects = [
							{
								code = "decision",
								value = "TempRecruitJean"
							},
							{
								code = "update_city"
							}
						]
					},
					{
						code = "dwarf_aftermatch_reply_c_kuro",
						dialogue_argument = 0,
						text = "DWARF_AFTERMATCH_OPT_KURO",
						type = "next_dialogue",
						reqs = [
							{
								type = "decision",
								value = "KuroDead",
								check = false
							},
							{
								type = "decision",
								value = "TempRecruitKuro",
								check = false
							}
						]
					},
					{
						code = "close",
						dialogue_argument = 0,
						text = "DIALOGUELEAVE",
						type = "next_dialogue",
						reqs = [
							{
								type = "decision",
								value = "KuroDead",
								check = true
							},
							{
								type = "dialogue_selected",
								value = "DWARF_AFTERMATCH_OPT_HARA",
								check = true
							},
							{
								type = "dialogue_selected",
								value = "DWARF_AFTERMATCH_OPT_JEAN",
								check = true
							}
						],
						bonus_effects = [
							{
								code = "complete_quest",
								value = "hara_scales_quest"
							},
							{
								code = "update_city"
							}
						]
					},
					{
						code = "close",
						dialogue_argument = 0,
						text = "DIALOGUELEAVE",
						type = "next_dialogue",
						reqs = [
							{
								type = "decision",
								value = "KuroDead",
								check = false
							},
							{
								type = "dialogue_selected",
								value = "DWARF_AFTERMATCH_OPT_KURO",
								check = true
							},
							{
								type = "dialogue_selected",
								value = "DWARF_AFTERMATCH_OPT_HARA",
								check = true
							},
							{
								type = "dialogue_selected",
								value = "DWARF_AFTERMATCH_OPT_JEAN",
								check = true
							}
						],
						bonus_effects = [
							{
								code = "complete_quest",
								value = "hara_scales_quest"
							},
							{
								code = "update_city"
							}
						]
					}
				],
				common_effects = [
					{
						code = "decision",
						value = "act3_finish"
					}
				]
			}
		]
	},
	dwarf_aftermatch_reply_k_kuro = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		text = [
			{
				text = "DWARF_AFTERMATCH_REPLY_K_KURO",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_aftermatch_reply_ties",
				dialogue_argument = 0,
				text = "DWARF_AFTERMATCH_OPT_TIES",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "dwarf_aftermatch_start",
				dialogue_argument = 2,
				text = "DWARF_AFTERMATCH_OPT_RIGHT",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	dwarf_aftermatch_reply_ties = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		text = [
			{
				text = "DWARF_AFTERMATCH_REPLY_TIES",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_aftermatch_start",
				dialogue_argument = 2,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "TempRecruitKuro"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	dwarf_aftermatch_reply_c_kuro = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "DWARF_AFTERMATCH_REPLY_C_KURO",
		options = [
			{
				code = "dwarf_aftermatch_reply_take",
				text = "DWARF_AFTERMATCH_OPT_TAKE",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "dwarf_aftermatch_start",
				dialogue_argument = 2,
				text = "DIALOGUENEVERMIND",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		character = "bolthar"
	},
	dwarf_aftermatch_reply_take = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "DWARF_AFTERMATCH_REPLY_TAKE",
		options = [
			{
				code = "dwarf_aftermatch_start",
				dialogue_argument = 2,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "TempRecruitKuro"
					},
					{
						code = "update_city"
					}
				]
			}
		],
		character = "bolthar"
	},
	dwarf_aftermatch_reply_k_jean = {
		variations = [
			{
				reqs = [
					{
						type = "decision",
						value = "JeanReport",
						check = true
					},
					{
						type = "dialogue_seen",
						check = false,
						value = "DWARF_AFTERMATCH_K_JEAN_REPORT"
					}
				],
				tags = [
					"dialogue_scene"
				],
				character = "dwarf_king",
				text = [
					{
						text = "DWARF_AFTERMATCH_REPLY_K_JEAN",
						reqs = [

						]
					},
					{
						text = "DWARF_AFTERMATCH_K_JEAN_REPORT",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "dwarf_aftermatch_reply_k_jean",
						dialogue_argument = 1,
						text = "DWARF_AFTERMATCH_OPT_ENSLAVE",
						reqs = [

						],
						type = "next_dialogue"
					},
					{
						code = "dwarf_aftermatch_reply_free",
						dialogue_argument = 1,
						text = "DWARF_AFTERMATCH_OPT_FREE",
						reqs = [

						],
						type = "next_dialogue"
					},
					{
						code = "dwarf_aftermatch_start",
						dialogue_argument = 2,
						text = "DIALOGUENEVERMIND",
						reqs = [

						],
						type = "next_dialogue"
					}
				]
			},
			{
				reqs = [

				],
				tags = [
					"dialogue_scene"
				],
				character = "dwarf_king",
				text = [
					{
						text = "DWARF_AFTERMATCH_REPLY_K_JEAN",
						previous_dialogue_option = 0,
						reqs = [
							{
								type = "decision",
								value = "JeanHelp",
								check = true
							}
						]
					},
					{
						text = "DWARF_AFTERMATCH_K_JEAN_HELP",
						previous_dialogue_option = 0,
						reqs = [
							{
								type = "decision",
								value = "JeanHelp",
								check = true
							}
						]
					},
					{
						text = "DWARF_AFTERMATCH_REPLY_ENSLAVE",
						reqs = [

						],
						previous_dialogue_option = 1
					}
				],
				options = [
					{
						code = "dwarf_aftermatch_reply_pay",
						dialogue_argument = 0,
						text = "DWARF_AFTERMATCH_OPT_PAY",
						type = "next_dialogue",
						reqs = [
							{
								type = "has_money",
								value = 1000
							}
						],
						bonus_effects = [
							{
								code = "money_change",
								operant = "-",
								value = 1000
							}
						],
						not_hide = true
					},
					{
						code = "dwarf_aftermatch_slave",
						dialogue_argument = 1,
						text = "DWARF_AFTERMATCH_OPT_INSTEAD",
						reqs = [

						],
						type = "next_dialogue"
					},
					{
						code = "dwarf_aftermatch_start",
						dialogue_argument = 2,
						text = "DWARF_AFTERMATCH_OPT_NEVERMIND",
						reqs = [

						],
						type = "next_dialogue"
					}
				]
			}
		]
	},
	dwarf_aftermatch_reply_pay = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		text = [
			{
				text = "DWARF_AFTERMATCH_REPLY_PAY",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_recruit_start",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [
					{
						type = "has_active_quest",
						name = "jean_free_quest",
						check = true
					}
				],
				bonus_effects = [
					{
						code = "complete_quest",
						value = "jean_free_quest"
					}
				]
			},
			{
				code = "jean_recruit_start",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [
					{
						type = "has_active_quest",
						name = "jean_free_quest",
						check = false
					}
				]
			}
		]
	},
	dwarf_aftermatch_slave = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		text = [
			{
				text = "DWARF_AFTERMATCH_REPLY_INSTEAD",
				reqs = [

				],
				dialogue_argument = 1
			}
		],
		options = [
			{
				code = "dwarf_aftermatch_slave2",
				text = "DWARF_AFTERMATCH_OPT_SLAVE",
				reqs = [

				],
				type = "next_dialogue",
				select_person = true,
				person_reqs = [
					{
						code = "is_at_location",
						value = "dwarf_capital",
						check = true
					},
					{
						code = "race",
						race = "Elf",
						check = true
					},
					{
						code = "sex",
						operant = "eq",
						value = "female"
					},
					{
						code = "stat",
						stat = "hair_color",
						operant = "eq",
						value = "yellow"
					}
				]
			},
			{
				code = "dwarf_aftermatch_start",
				dialogue_argument = 2,
				text = "DIALOGUELEAVE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "jean_free_quest",
						stage = "price"
					},
					{
						code = "decision",
						value = "TempBlockJean"
					}
				]
			}
		]
	},
	dwarf_aftermatch_slave2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		common_effects = [
			{
				code = "affect_active_character",
				type = "remove"
			}
		],
		text = [
			{
				text = "DWARF_AFTERMATCH_REPLY_SLAVE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_recruit_start",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [
					{
						type = "has_active_quest",
						name = "jean_free_quest",
						check = true
					}
				],
				bonus_effects = [
					{
						code = "complete_quest",
						value = "jean_free_quest"
					}
				]
			},
			{
				code = "jean_recruit_start",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [
					{
						type = "has_active_quest",
						name = "jean_free_quest",
						check = false
					}
				]
			}
		]
	},
	dwarf_aftermatch_reply_free = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		text = [
			{
				text = "DWARF_AFTERMATCH_REPLY_FREE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_aftermatch_start",
				dialogue_argument = 2,
				text = "DIALOGUENEVERMIND",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "TempBlockJean"
					}
				]
			}
		]
	},
	dwarf_aftermatch_jean_return = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		text = "DWARF_AFTERMATCH_JEAN_RETURN",
		options = [
			{
				code = "dwarf_aftermatch_reply_pay",
				text = "DWARF_AFTERMATCH_OPT_PAY",
				type = "next_dialogue",
				reqs = [
					{
						type = "has_money",
						value = 1000
					}
				],
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 1000
					}
				],
				not_hide = true
			},
			{
				code = "dwarf_aftermatch_slave2",
				text = "DWARF_AFTERMATCH_OPT_SLAVE",
				reqs = [

				],
				type = "next_dialogue",
				select_person = true,
				person_reqs = [
					{
						code = "is_at_location",
						value = "dwarf_capital",
						check = true
					},
					{
						code = "race",
						race = "Elf",
						check = true
					},
					{
						code = "sex",
						operant = "eq",
						value = "female"
					},
					{
						code = "stat",
						stat = "hair_color",
						operant = "eq",
						value = "yellow"
					}
				]
			},
			{
				code = "close",
				text = "DIALOGUENEVERMIND",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	jean_recruit_start = {
		variations = [
			{
				reqs = [
					{
						type = "decision",
						value = "JeanHelp",
						check = true
					}
				],
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				character = "jean",
				text = [
					{
						text = "JEAN_RECRUIT_START_HELP",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "jean_recruit_reply",
						dialogue_argument = 1,
						text = "JEAN_RECRUIT_OPT_JOIN",
						reqs = [

						],
						type = "next_dialogue",
						bonus_effects = [
							{
								code = "make_story_character",
								value = "Jean",
								recruit_from_location = true
							}
						]
					},
					{
						code = "jean_recruit_reply",
						dialogue_argument = 2,
						text = "JEAN_RECRUIT_OPT_NONEED",
						reqs = [

						],
						type = "next_dialogue"
					}
				]
			},
			{
				reqs = [
					{
						type = "decision",
						value = "JeanReport",
						check = true
					}
				],
				tags = [
					"dialogue_scene"
				],
				character = "jean",
				text = [
					{
						text = "JEAN_RECRUIT_START_REPORT",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "jean_recruit_reply",
						dialogue_argument = 3,
						text = "JEAN_RECRUIT_OPT_SLAVE",
						reqs = [

						],
						type = "next_dialogue",
						bonus_effects = [
							{
								code = "make_story_character",
								value = "Jean",
								recruit_from_location = true,
								slave_category = "slave"
							}
						]
					},
					{
						code = "jean_recruit_go",
						dialogue_argument = 0,
						text = "JEAN_RECRUIT_OPT_GO",
						reqs = [

						],
						type = "next_dialogue"
					}
				]
			}
		]
	},
	jean_recruit_reply = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "jean",
		text = [
			{
				text = "JEAN_RECRUIT_REPLY_JOIN",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_RECRUIT_REPLY_NONEED",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_RECRUIT_REPLY_SLAVE",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "JEAN_RECRUIT_REPLY_FIX",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "dwarf_aftermatch_start",
				dialogue_argument = 2,
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [
					{
						type = "quest_completed",
						name = "hara_scales_quest",
						check = false
					}
				],
				bonus_effects = [
					{
						code = "decision",
						value = "TempBlockJean"
					}
				]
			},
			{
				code = "close",
				dialogue_argument = 0,
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [
					{
						type = "quest_completed",
						name = "hara_scales_quest",
						check = true
					}
				],
				bonus_effects = [
					{
						code = "remove_decision",
						value = "TempRecruitJean"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_recruit_go = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "jean",
		text = "JEAN_RECRUIT_GO",
		options = [
			{
				code = "jean_recruit_reply_asap",
				text = "JEAN_RECRUIT_OPT_ASAP",
				reqs = [

				],
				type = "next_dialogue",
				select_person = true,
				challenge = "persuasion",
				not_hide = true
			},
			{
				code = "jean_recruit_reply",
				dialogue_argument = 4,
				text = "JEAN_RECRUIT_OPT_FIX",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	jean_recruit_reply_asap = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		common_effects = [
			{
				code = "make_story_character",
				value = "Jean",
				recruit_from_location = true
			}
		],
		character = "jean",
		text = [
			{
				text = "JEAN_RECRUIT_REPLY_ASAP",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_aftermatch_start",
				dialogue_argument = 2,
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [
					{
						type = "quest_completed",
						name = "hara_scales_quest",
						check = false
					}
				],
				bonus_effects = [
					{
						code = "decision",
						value = "TempBlockJean"
					}
				]
			},
			{
				code = "close",
				dialogue_argument = 0,
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [
					{
						type = "quest_completed",
						name = "hara_scales_quest",
						check = true
					}
				],
				bonus_effects = [
					{
						code = "remove_decision",
						value = "TempRecruitJean"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	hara_recruit_start = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "hara",
		text = [
			{
				text = "HARA_RECRUIT_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "hara_recruit_reply",
				dialogue_argument = 1,
				text = "HARA_RECRUIT_OPT_PRO",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "make_story_character",
						value = "Hara",
						recruit_from_location = true
					}
				]
			},
			{
				code = "hara_recruit_flirty",
				dialogue_argument = 0,
				text = "HARA_RECRUIT_OPT_FLIRTY",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "close",
				dialogue_argument = 0,
				text = "DIALOGUENEVERMIND",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	hara_recruit_reply = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		common_effects = [
			{
				code = "remove_decision",
				value = "TempRecruitHara"
			},
			{
				code = "update_city"
			}
		],
		character = "hara",
		text = [
			{
				text = "HARA_RECRUIT_REPLY_PRO",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "HARA_RECRUIT_REPLY_DO",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "close",
				dialogue_argument = 0,
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	hara_recruit_flirty = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "hara",
		text = [
			{
				text = "HARA_RECRUIT_FLIRTY",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "hara_recruit_reply",
				dialogue_argument = 2,
				text = "HARA_RECRUIT_OPT_DO",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "make_story_character",
						value = "Hara",
						recruit_from_location = true
					}
				]
			},
			{
				code = "close",
				dialogue_argument = 0,
				text = "HARA_RECRUIT_OPT_OTHER",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_start = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_RECRUIT_START",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "kuro_recruit_answers",
				dialogue_argument = 0,
				text = "KURO_RECRUIT_OPT_ANSWER",
				reqs = [

				]
			},
			{
				code = "kuro_recruit_join",
				dialogue_argument = 0,
				text = "KURO_RECRUIT_OPT_JOIN",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "close",
				dialogue_argument = 0,
				text = "KURO_RECRUIT_OPT_LEAVE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_answers = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "KURO_RECRUIT_REPLY_TRUST",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_RECRUIT_REPLY_HAPPENED",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO_RECRUIT_REPLY_CULTJOIN",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "KURO_RECRUIT_REPLY_MIND",
				reqs = [

				],
				previous_dialogue_option = 4
			},
			{
				text = "KURO_RECRUIT_REPLY_PLAN",
				reqs = [

				],
				previous_dialogue_option = 5
			}
		],
		options = [
			{
				code = "kuro_recruit_answers",
				dialogue_argument = 1,
				text = "KURO_RECRUIT_OPT_TRUST",
				reqs = [

				]
			},
			{
				code = "kuro_recruit_answers",
				dialogue_argument = 2,
				text = "KURO_RECRUIT_OPT_HAPPENED",
				reqs = [

				]
			},
			{
				code = "kuro_recruit_answers",
				dialogue_argument = 3,
				text = "KURO_RECRUIT_OPT_CULTJOIN",
				reqs = [

				]
			},
			{
				code = "kuro_recruit_cultplan",
				dialogue_argument = 0,
				text = "KURO_RECRUIT_OPT_CULTPLAN",
				reqs = [

				]
			},
			{
				code = "kuro_recruit_answers",
				dialogue_argument = 5,
				text = "KURO_RECRUIT_OPT_PLAN",
				reqs = [

				]
			},
			{
				code = "kuro_recruit_start",
				dialogue_argument = 1,
				text = "KURO_RECRUIT_OPT_ENOUGH",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_cultplan = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_RECRUIT_REPLY_CULTPLAN",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "KURO_RECRUIT_REPLY_CRYPTIC",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "kuro_recruit_cultplan",
				dialogue_argument = 1,
				text = "KURO_RECRUIT_OPT_CRYPTIC",
				reqs = [

				]
			},
			{
				code = "kuro_recruit_answers",
				dialogue_argument = 4,
				text = "KURO_RECRUIT_OPT_MIND",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_join = {
		variations = [
			{
				reqs = [
					{
						type = "location_has_specific_slaves",
						check = true,
						value = 1,
						location = "dwarf_capital",
						reqs = [
							{
								code = "unique",
								value = "zephyra"
							}
						]
					},
					{
						type = "decision",
						value = "TempRejectZephyra",
						check = false
					}
				],
				tags = [
					"dialogue_scene"
				],
				character = "kuro",
				text = [
					{
						text = "KURO_RECRUIT_JOIN_ZEPH",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "kuro_recruit_join_zeph2",
						dialogue_argument = 0,
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						type = "next_dialogue"
					}
				]
			},
			{
				reqs = [

				],
				tags = [
					"dialogue_scene"
				],
				character = "kuro",
				text = [
					{
						text = "KURO_RECRUIT_JOIN_NOZEPH",
						reqs = [

						],
						previous_dialogue_option = 0
					},
					{
						text = "KURO_RECRUIT_REPLY_NO",
						reqs = [

						],
						previous_dialogue_option = 1
					},
					{
						text = "KURO_RECRUIT_JOIN",
						reqs = [

						],
						previous_dialogue_option = [
							0,
							1
						]
					},
					{
						text = "KURO_RECRUIT_REPLY_PUNISH",
						reqs = [

						],
						previous_dialogue_option = 2
					}
				],
				options = [
					{
						code = "kuro_recruit_join",
						dialogue_argument = 2,
						text = "KURO_RECRUIT_OPT_PUNISH",
						reqs = [

						]
					},
					{
						code = "kuro_recruit_q_trust",
						dialogue_argument = 0,
						text = "KURO_RECRUIT_OPT_FAIR",
						reqs = [

						],
						type = "next_dialogue",
						bonus_effects = [
							{
								code = "remove_decision",
								value = "TempRejectZephyra"
							}
						]
					},
					{
						code = "kuro_recruit_wrong",
						dialogue_argument = 5,
						text = "KURO_RECRUIT_OPT_QUIZ",
						reqs = [

						],
						type = "next_dialogue",
						bonus_effects = [
							{
								code = "remove_decision",
								value = "TempRejectZephyra"
							}
						]
					}
				]
			}
		]
	},
	kuro_recruit_join_zeph2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "zephyra",
		text = [
			{
				text = "KURO_RECRUIT_JOIN_ZEPH2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_recruit_join_zeph3",
				dialogue_argument = 0,
				text = "KURO_RECRUIT_OPT_ALRIGHT",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "kuro_recruit_join",
				dialogue_argument = 1,
				text = "KURO_RECRUIT_OPT_NO",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "TempRejectZephyra"
					}
				]
			}
		]
	},
	kuro_recruit_join_zeph3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "zephyra",
		text = [
			{
				text = "KURO_RECRUIT_JOIN_ZEPH3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_recruit_reply_noworry",
				dialogue_argument = 0,
				text = "KURO_RECRUIT_OPT_NOWORRY",
				reqs = [

				]
			},
			{
				code = "kuro_recruit_join_zeph4",
				dialogue_argument = 0,
				text = "KURO_RECRUIT_OPT_SILENT",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_reply_noworry = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "zephyra",
		text = [
			{
				text = "KURO_RECRUIT_REPLY_NOWORRY",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_recruit_join_zeph4",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_join_zeph4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		character2 = "zephyra",
		text = [
			{
				text = "KURO_RECRUIT_JOIN_ZEPH4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_recruit_join_zeph5",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_join_zeph5 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		character2 = "zephyra",
		text = [
			{
				text = "KURO_RECRUIT_JOIN_ZEPH5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_recruit_end_zeph",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_end_zeph = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		character2 = "zephyra",
		text = [
			{
				text = "KURO_RECRUIT_JOIN_ZEPH6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				dialogue_argument = 0,
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "make_story_character",
						value = "Kuro",
						recruit_from_location = true
					},
					{
						code = "remove_decision",
						value = "TempRecruitKuro"
					},
					{
						code = "update_city"
					},
					{
						code = "add_timed_event",
						value = "kuro_tome_start",
						args = [
							{
								type = "add_to_date",
								date = [
									7,
									8
								],
								hour = 1
							}
						]
					}
				]
			}
		]
	},
	kuro_recruit_q_trust = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_RECRUIT_Q_TRUST",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_recruit_reply_q_trust",
				dialogue_argument = 1,
				text = "KURO_RECRUIT_A_BEST",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "kuro_recruit_reply_q_trust",
				dialogue_argument = 2,
				text = "KURO_RECRUIT_A_NOOPTION",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "kuro_recruit_wrong",
				dialogue_argument = 1,
				text = "KURO_RECRUIT_A_NOTRUST",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_reply_q_trust = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_RECRUIT_REPLY_A_BEST",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_RECRUIT_REPLY_A_NOOPTION",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "kuro_recruit_q_reason",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_q_reason = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_RECRUIT_Q_REASON",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_recruit_reply_q_reason",
				dialogue_argument = 0,
				text = "KURO_RECRUIT_A_SMART",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "kuro_recruit_wrong",
				dialogue_argument = 2,
				text = "KURO_RECRUIT_A_CUTE",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "kuro_recruit_wrong",
				dialogue_argument = 3,
				text = "KURO_RECRUIT_A_PAYBACK",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_reply_q_reason = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_RECRUIT_REPLY_A_SMART",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_recruit_q_kill",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_q_kill = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "blackscreen",
		character = "kuro",
		text = "KURO_RECRUIT_Q_KILL",
		options = [
			{
				code = "kuro_recruit_right",
				text = "KURO_RECRUIT_A_WEIGHT",
				reqs = [

				],
				type = "next_dialogue",
				select_person = true,
				challenge = "strength",
				not_hide = true
			},
			{
				code = "kuro_recruit_right",
				text = "KURO_RECRUIT_A_STOP",
				reqs = [

				],
				type = "next_dialogue",
				select_person = true,
				challenge = "dexterity",
				not_hide = true
			},
			{
				code = "kuro_recruit_right",
				text = "KURO_RECRUIT_A_PURPOSE",
				reqs = [

				],
				type = "next_dialogue",
				select_person = true,
				challenge = "wisdom",
				not_hide = true
			},
			{
				code = "kuro_recruit_right",
				text = "KURO_RECRUIT_A_WANT",
				reqs = [

				],
				type = "next_dialogue",
				select_person = true,
				challenge = "persuasion",
				not_hide = true
			},
			{
				code = "kuro_recruit_wrong",
				dialogue_argument = 4,
				text = "KURO_RECRUIT_A_DARE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_wrong = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_RECRUIT_REPLY_A_NOTRUST",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_RECRUIT_REPLY_A_CUTE",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO_RECRUIT_REPLY_A_PAYBACK",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "KURO_RECRUIT_REPLY_A_DARE",
				reqs = [

				],
				previous_dialogue_option = 4
			},
			{
				text = "KURO_RECRUIT_REPLY_QUIZ",
				reqs = [

				],
				previous_dialogue_option = 5
			}
		],
		options = [
			{
				code = "close",
				dialogue_argument = 0,
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "remove_decision",
						value = "TempRecruitKuro"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	kuro_recruit_right = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_RECRUIT_RIGHT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_recruit_end",
				dialogue_argument = 0,
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	kuro_recruit_end = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_RECRUIT_END",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				dialogue_argument = 0,
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "make_story_character",
						value = "Kuro",
						recruit_from_location = true
					},
					{
						code = "remove_decision",
						value = "TempRecruitKuro"
					},
					{
						code = "update_city"
					},
					{
						code = "add_timed_event",
						value = "kuro_tome_start",
						args = [
							{
								type = "add_to_date",
								date = [
									7,
									8
								],
								hour = 1
							}
						]
					}
				]
			}
		]
	}
}
