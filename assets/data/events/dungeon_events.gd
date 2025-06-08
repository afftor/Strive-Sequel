extends Reference
var data = {
	event_locked_door = {
		variations = [
			{
				reqs = [
					{
						type = "random",
						value = 50
					}
				],
				text = "DIALOUELOCKEDDOOR",
				tags = [
					"linked_event"
				],
				default_event_type = "trap",
				image = "dungeon_door",
				options = [
					{
						code = "pass_lock_discount",
						select_person = true,
						challenge = "dexterity",
						not_hide = true,
						reqs = [
							{
								type = "has_stamina",
								value = 3
							}
						],
						text = "DIALOUELOCKEDDOORSELECT"
					},
					{
						code = "close",
						reqs = [
							{
								type = "has_stamina",
								value = 10
							}
						],
						not_hide = true,
						bonus_effects = [
							{
								code = "pay_stamina",
								value = 10
							},
							{
								code = "unlock_subroom"
							}
						],
						text = "DIALOUELOCKEDDOORBREAK"
					},
					{
						code = "close",
						reqs = [

						],
						text = "DIALOGUECANCEL"
					}
				]
			},
			{
				reqs = [
					{
						type = "no_check"
					}
				],
				text = "DIALOUELOCKEDDOOR2",
				tags = [
					"linked_event"
				],
				default_event_type = "trap",
				image = "dungeon_door",
				options = [
					{
						code = "close",
						text = "DIALOUELOCKEDDOORSELECT2",
						not_hide = true,
						reqs = [
							{
								type = "has_stamina",
								value = 3
							},
							{
								type = "has_material",
								material = "unstable_concoction",
								operant = "gte",
								value = 1
							}
						],
						bonus_effects = [
							{
								code = "pay_stamina",
								value = 3
							},
							{
								code = "unlock_subroom"
							},
							{
								code = "material_change",
								operant = "-",
								material = "unstable_concoction",
								value = 1
							}
						]
					},
					{
						code = "close",
						not_hide = true,
						reqs = [
							{
								type = "has_stamina",
								value = 10
							}
						],
						bonus_effects = [
							{
								code = "pay_stamina",
								value = 10
							},
							{
								code = "unlock_subroom"
							}
						],
						text = "DIALOUELOCKEDDOORBREAK"
					},
					{
						code = "close",
						reqs = [

						],
						text = "DIALOGUECANCEL"
					}
				]
			}
		]
	},
	pass_lock_discount = {
		text = "DIALOUELOCKEDDOORPASS",
		tags = [
			"linked_event",
			"active_character_translate"
		],
		default_event_type = "trap",
		image = "dungeon_door",
		options = [
			{
				code = "close",
				reqs = [

				],
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 3
					},
					{
						code = "unlock_subroom"
					}
				],
				text = "DIALOGUECLOSE"
			}
		]
	},
	event_blocked_path = {
		variations = [
			{
				reqs = [
					{
						type = "random",
						value = 50
					}
				],
				text = "DIALOGUEBLOCKEDPATH",
				tags = [
					"linked_event"
				],
				default_event_type = "trap",
				image = "dungeon_cavein",
				options = [
					{
						code = "pass_blocked_path",
						select_person = true,
						challenge = "strength",
						not_hide = true,
						reqs = [
							{
								type = "has_stamina",
								value = 3
							}
						],
						text = "DIALOGUEBLOCKEDPATHSELECT"
					},
					{
						code = "close",
						not_hide = true,
						reqs = [
							{
								type = "has_stamina",
								value = 10
							}
						],
						bonus_effects = [
							{
								code = "pay_stamina",
								value = 10
							},
							{
								code = "unlock_subroom"
							}
						],
						text = "DIALOGUEBLOCKEDPATHBREAK"
					},
					{
						code = "close",
						reqs = [

						],
						text = "DIALOGUECANCEL"
					}
				]
			},
			{
				reqs = [
					{
						type = "no_check"
					}
				],
				text = "DIALOGUEBLOCKEDPATH2",
				tags = [
					"linked_event"
				],
				default_event_type = "trap",
				image = "dungeon_cavein",
				options = [
					{
						code = "close",
						text = "DIALOUELOCKEDDOORSELECT2",
						not_hide = true,
						reqs = [
							{
								type = "has_stamina",
								value = 3
							},
							{
								type = "has_material",
								material = "unstable_concoction",
								operant = "gte",
								value = 1
							}
						],
						bonus_effects = [
							{
								code = "pay_stamina",
								value = 3
							},
							{
								code = "unlock_subroom"
							},
							{
								code = "material_change",
								operant = "-",
								material = "unstable_concoction",
								value = 1
							}
						]
					},
					{
						code = "close",
						reqs = [
							{
								type = "has_stamina",
								value = 10
							}
						],
						not_hide = true,
						bonus_effects = [
							{
								code = "pay_stamina",
								value = 10
							},
							{
								code = "unlock_subroom"
							}
						],
						text = "DIALOGUEBLOCKEDPATHBREAK"
					},
					{
						code = "close",
						reqs = [

						],
						text = "DIALOGUECANCEL"
					}
				]
			}
		]
	},
	pass_blocked_path = {
		text = "DIALOGUEBLOCKEDPATHPASS",
		tags = [
			"linked_event",
			"active_character_translate"
		],
		default_event_type = "trap",
		image = "dungeon_cavein",
		options = [
			{
				code = "close",
				reqs = [

				],
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 3
					},
					{
						code = "unlock_subroom"
					}
				],
				text = "DIALOGUECLOSE"
			}
		]
	},
	event_magic_barrier = {
		text = "DIALOGUEMAGICBARRIER",
		tags = [
			"linked_event"
		],
		default_event_type = "trap",
		image = "dungeon_magic_barrier",
		options = [
			{
				code = "pass_magic_barrier",
				select_person = true,
				challenge = "wisdom",
				not_hide = true,
				reqs = [
					{
						type = "has_stamina",
						value = 3
					}
				],
				text = "DIALOGUEMAGICBARRIERSELECT"
			},
			{
				code = "close",
				reqs = [
					{
						type = "has_stamina",
						value = 10
					}
				],
				not_hide = true,
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 10
					},
					{
						code = "unlock_subroom"
					}
				],
				text = "DIALOGUEMAGICBARRIERBREAK"
			},
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUECANCEL"
			}
		]
	},
	pass_magic_barrier = {
		text = "DIALOGUEMAGICBARRIERPASS",
		tags = [
			"linked_event",
			"active_character_translate"
		],
		default_event_type = "trap",
		image = "dungeon_magic_barrier",
		options = [
			{
				code = "close",
				reqs = [

				],
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 3
					},
					{
						code = "unlock_subroom"
					}
				],
				text = "DIALOGUECLOSE"
			}
		]
	},
	event_fallen_bridge = {
		variations = [
			{
				reqs = [
					{
						type = "random",
						value = 50
					}
				],
				text = "DIALOGUEFALLENBRIDGE",
				tags = [
					"linked_event"
				],
				default_event_type = "trap",
				image = "dungeon_forest_bridge",
				options = [
					{
						code = "pass_fallen_bridge",
						select_person = true,
						challenge = "strength",
						not_hide = true,
						reqs = [
							{
								type = "has_stamina",
								value = 3
							}
						],
						text = "DIALOGUEFALLENBRIDGESELECT"
					},
					{
						code = "close",
						reqs = [
							{
								type = "has_stamina",
								value = 10
							}
						],
						not_hide = true,
						bonus_effects = [
							{
								code = "pay_stamina",
								value = 10
							},
							{
								code = "unlock_subroom"
							}
						],
						text = "DIALOGUEFALLENBRIDGEBREAK"
					},
					{
						code = "close",
						reqs = [

						],
						text = "DIALOGUECANCEL"
					}
				]
			},
			{
				text = "DIALOGUEFALLENBRIDGE2",
				reqs = [

				],
				tags = [
					"linked_event"
				],
				default_event_type = "trap",
				image = "trap",
				options = [
					{
						code = "pass_fallen_bridge2",
						not_hide = true,
						reqs = [
							{
								type = "has_material",
								material = "wood",
								operant = "gte",
								value = 10
							}
						],
						text = "DIALOGUEFALLENBRIDGESELECT2",
						bonus_effects = [
							{
								code = "material_change",
								operant = "-",
								material = "wood",
								value = 10
							}
						]
					},
					{
						code = "close",
						reqs = [
							{
								type = "has_stamina",
								value = 10
							}
						],
						not_hide = true,
						bonus_effects = [
							{
								code = "pay_stamina",
								value = 10
							},
							{
								code = "unlock_subroom"
							}
						],
						text = "DIALOGUEFALLENBRIDGEBREAK"
					},
					{
						code = "close",
						reqs = [

						],
						text = "DIALOGUECANCEL"
					}
				]
			}
		]
	},
	pass_fallen_bridge = {
		text = "DIALOGUEFALLENBRIDGEPASS",
		tags = [
			"linked_event",
			"active_character_translate"
		],
		default_event_type = "trap",
		image = "dungeon_forest_bridge",
		options = [
			{
				code = "close",
				reqs = [

				],
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 3
					},
					{
						code = "unlock_subroom"
					}
				],
				text = "DIALOGUECLOSE"
			}
		]
	},
	pass_fallen_bridge2 = {
		text = "DIALOGUEFALLENBRIDGEPASS2",
		tags = [
			"linked_event",
			"active_character_translate"
		],
		default_event_type = "trap",
		image = "dungeon_forest_bridge",
		options = [
			{
				code = "close",
				reqs = [

				],
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 3
					},
					{
						code = "unlock_subroom"
					}
				],
				text = "DIALOGUECLOSE"
			}
		]
	},
	event_small_crack = {
		text = "DIALOGUESMALLCRACK",
		tags = [
			"linked_event"
		],
		default_event_type = "trap",
		image = "dungeon_door",
		options = [
			{
				code = "pass_small_crack",
				select_person = true,
				challenge = "dexterity",
				not_hide = true,
				reqs = [
					{
						type = "has_stamina",
						value = 3
					}
				],
				text = "DIALOGUESMALLCRACKSELECT"
			},
			{
				code = "close",
				reqs = [
					{
						type = "has_stamina",
						value = 10
					}
				],
				not_hide = true,
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 10
					},
					{
						code = "unlock_subroom"
					}
				],
				text = "DIALOGUESMALLCRACKBREAK"
			},
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUECANCEL"
			}
		]
	},
	pass_small_crack = {
		text = "DIALOGUESMALLCRACKPASS",
		tags = [
			"linked_event",
			"active_character_translate"
		],
		default_event_type = "trap",
		image = "dungeon_door",
		options = [
			{
				code = "close",
				reqs = [

				],
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 3
					},
					{
						code = "unlock_subroom"
					}
				],
				text = "DIALOGUECLOSE"
			}
		]
	},
	event_ancient_lock = {
		text = "DIALOGUEANCIENTLOCK",
		tags = [
			"linked_event"
		],
		default_event_type = "trap",
		image = "dungeon_gate",
		options = [
			{
				code = "pass_ancient_lock",
				select_person = true,
				challenge = "wisdom",
				not_hide = true,
				reqs = [
					{
						type = "has_stamina",
						value = 3
					}
				],
				text = "DIALOGUEANCIENTLOCKSELECT"
			},
			{
				code = "close",
				reqs = [
					{
						type = "has_stamina",
						value = 10
					}
				],
				not_hide = true,
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 10
					},
					{
						code = "unlock_subroom"
					}
				],
				text = "DIALOGUEANCIENTLOCKBREAK"
			},
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUECANCEL"
			}
		]
	},
	pass_ancient_lock = {
		text = "DIALOGUEANCIENTLOCKPASS",
		tags = [
			"linked_event",
			"active_character_translate"
		],
		default_event_type = "trap",
		image = "dungeon_gate",
		options = [
			{
				code = "close",
				reqs = [

				],
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 3
					},
					{
						code = "unlock_subroom"
					}
				],
				text = "DIALOGUECLOSE"
			}
		]
	},
	event_enemy_charm_avoid = {
		text = "DIALOGUEENEMYCHARMAVOID",
		tags = [
			"linked_event"
		],
		default_event_type = "trap",
		image = "dungeon_enemies",
		options = [
			{
				code = "pass_enemy_charm_avoid",
				select_person = true,
				challenge = "persuasion",
				not_hide = true,
				reqs = [
					{
						type = "has_stamina",
						value = 0.3
					}
				],
				text = "DIALOGUEENEMYCHARMAVOIDSELECT"
			},
			{
				code = "close",
				reqs = [
					{
						type = "has_stamina",
						value = 1
					}
				],
				not_hide = true,
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 1
					},
					{
						code = "unlock_combat"
					}
				],
				text = "DIALOGUEATTACK"
			},
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUECANCEL",
				bonus_effects = [
					{
						code = "deny_combat"
					}
				]
			}
		]
	},
	pass_enemy_charm_avoid = {
		text = "DIALOGUEENEMYCHARMAVOIDPASS",
		tags = [
			"linked_event",
			"active_character_translate"
		],
		default_event_type = "trap",
		image = "dungeon_enemies",
		options = [
			{
				code = "close",
				reqs = [

				],
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 0.3
					},
					{
						code = "alter_combat",
						victory = true,
						xp_mod = 0.5
					},
					{
						code = "unlock_combat"
					}
				],
				text = "DIALOGUECLOSE"
			}
		]
	},
	event_enemy_charm_damage = {
		text = "DIALOGUEENEMYCHARMDAMAGE",
		tags = [
			"linked_event"
		],
		default_event_type = "trap",
		image = "dungeon_enemies",
		options = [
			{
				code = "pass_enemy_charm_damage",
				select_person = true,
				challenge = "persuasion",
				not_hide = true,
				reqs = [
					{
						type = "has_stamina",
						value = 0.3
					}
				],
				text = "DIALOGUEENEMYCHARMDAMAGESELECT"
			},
			{
				code = "close",
				reqs = [
					{
						type = "has_stamina",
						value = 1
					}
				],
				not_hide = true,
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 1
					},
					{
						code = "unlock_combat"
					}
				],
				text = "DIALOGUEATTACK"
			},
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUECANCEL",
				bonus_effects = [
					{
						code = "deny_combat"
					}
				]
			}
		]
	},
	pass_enemy_charm_damage = {
		text = "DIALOGUEENEMYCHARMDAMAGEPASS",
		tags = [
			"linked_event",
			"active_character_translate"
		],
		default_event_type = "trap",
		image = "dungeon_enemies",
		options = [
			{
				code = "close",
				reqs = [

				],
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 0.3
					},
					{
						code = "alter_combat",
						victory = false,
						reduce_hp = 0.33
					},
					{
						code = "unlock_combat"
					}
				],
				text = "DIALOGUECLOSE"
			}
		]
	},
	event_enemy_dexterity_sneak = {
		text = "DIALOGUEENEMYDEXSNEAK",
		tags = [
			"linked_event"
		],
		default_event_type = "trap",
		image = "dungeon_enemies",
		options = [
			{
				code = "pass_enemy_dexterity_sneak",
				select_person = true,
				challenge = "dexterity",
				not_hide = true,
				reqs = [
					{
						type = "has_stamina",
						value = 0.3
					}
				],
				text = "DIALOGUEENEMYDEXSNEAKSELECT"
			},
			{
				code = "close",
				reqs = [
					{
						type = "has_stamina",
						value = 1
					}
				],
				not_hide = true,
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 1
					},
					{
						code = "unlock_combat"
					}
				],
				text = "DIALOGUEATTACK"
			},
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUECANCEL",
				bonus_effects = [
					{
						code = "deny_combat"
					}
				]
			}
		]
	},
	pass_enemy_dexterity_sneak = {
		text = "DIALOGUEENEMYDEXSNEAKPASS",
		tags = [
			"linked_event",
			"active_character_translate"
		],
		default_event_type = "trap",
		image = "dungeon_enemies",
		options = [
			{
				code = "close",
				reqs = [

				],
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 0.3
					},
					{
						code = "alter_combat",
						victory = true,
						xp_mod = 0.5
					},
					{
						code = "unlock_combat"
					}
				],
				text = "DIALOGUECLOSE"
			}
		]
	},
	event_enemy_strength_scare = {
		text = "DIALOGUEENEMYSTRSCARE",
		tags = [
			"linked_event"
		],
		default_event_type = "trap",
		image = "dungeon_enemies",
		options = [
			{
				code = "pass_enemy_strength_scare",
				select_person = true,
				challenge = "strength",
				not_hide = true,
				reqs = [
					{
						type = "has_stamina",
						value = 0.3
					}
				],
				text = "DIALOGUEENEMYSTRSCARESELECT"
			},
			{
				code = "close",
				reqs = [
					{
						type = "has_stamina",
						value = 1
					}
				],
				not_hide = true,
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 1
					},
					{
						code = "unlock_combat"
					}
				],
				text = "DIALOGUEATTACK"
			},
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUECANCEL",
				bonus_effects = [
					{
						code = "deny_combat"
					}
				]
			}
		]
	},
	pass_enemy_strength_scare = {
		text = "DIALOGUEENEMYSTRSCAREPASS",
		tags = [
			"linked_event",
			"active_character_translate"
		],
		default_event_type = "trap",
		image = "dungeon_enemies",
		options = [
			{
				code = "close",
				reqs = [

				],
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 0.3
					},
					{
						code = "alter_combat",
						victory = true,
						xp_mod = 0.5
					},
					{
						code = "unlock_combat"
					}
				],
				text = "DIALOGUECLOSE"
			}
		]
	},
	event_enemy_distract = {
		text = "DIALOGUEEVENTENEMYDISTRACT",
		tags = [
			"linked_event"
		],
		default_event_type = "trap",
		image = "dungeon_enemies",
		options = [
			{
				code = "pass_enemy_distract",
				select_person = true,
				challenge = "captured",
				not_hide = true,
				reqs = [
					{
						type = "has_stamina",
						value = 0.3
					},
					{
						type = "captured_number",
						operant = "gte",
						value = 1
					}
				],
				text = "DIALOGUEEVENTENEMYDISTRACTSELECT"
			},
			{
				code = "close",
				reqs = [
					{
						type = "has_stamina",
						value = 1
					}
				],
				not_hide = true,
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 1
					},
					{
						code = "unlock_combat"
					}
				],
				text = "DIALOGUEATTACK"
			},
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUECANCEL",
				bonus_effects = [
					{
						code = "deny_combat"
					}
				]
			}
		]
	},
	pass_enemy_distract = {
		text = "DIALOGUEEVENTENEMYDISTRACTPASS",
		tags = [
			"linked_event",
			"active_character_translate"
		],
		default_event_type = "trap",
		image = "dungeon_enemies",
		options = [
			{
				code = "close",
				reqs = [

				],
				bonus_effects = [
					{
						code = "pay_stamina",
						value = 0.3
					},
					{
						code = "alter_combat",
						victory = true,
						xp_mod = 0.5
					},
					{
						code = "unlock_combat"
					}
				],
				text = "DIALOGUECLOSE"
			}
		]
	},
	event_dungeon_coccoon_1 = {
		text = "DIALOGUEEVENTDUNGEONCOCCOON_1",
		tags = [
			"linked_event"
		],
		default_event_type = "character_event",
		image = "dungeon_cocoon",
		common_effects = [
			{
				code = "make_scene_character",
				value = [
					{
						type = "function",
						function = "make_local_recruit",
						args = {
							races = [
								[
									"local",
									1
								]
							],
							difficulty = [
								0,
								2
							],
							type = "slave"
						}
					}
				]
			}
		],
		options = [
			{
				code = "event_dungeon_coccoon_2",
				reqs = [
					{
						type = "has_stamina",
						value = 10
					}
				],
				text = "DIALOGUEEVENTDUNGEONCOCCOON_OPTION1"
			},
			{
				code = "event_dungeon_coccoon_3",
				select_person = true,
				challenge = "strength",
				reqs = [
					{
						type = "has_stamina",
						value = 3
					}
				],
				text = "DIALOGUEEVENTDUNGEONCOCCOON_OPTION2"
			},
			{
				code = "event_dungeon_coccoon_4",
				reqs = [

				],
				text = "DIALOGUELEAVE"
			}
		]
	},
	event_dungeon_coccoon_2 = {
		text = "DIALOGUEEVENTDUNGEONCOCCOON_2",
		image = "dungeon_cocoon",
		options = [
			{
				code = "add_to_captured",
				reqs = [

				],
				text = "DIALOGUELEAVE",
				bonus_effects = [
					{
						code = "clear_subroom"
					},
					{
						code = "pay_stamina",
						value = 10
					}
				]
			}
		]
	},
	event_dungeon_coccoon_3 = {
		text = "DIALOGUEEVENTDUNGEONCOCCOON_3",
		tags = [
			"active_character_translate"
		],
		image = "dungeon_cocoon",
		options = [
			{
				code = "add_to_captured",
				reqs = [

				],
				text = "DIALOGUELEAVE",
				bonus_effects = [
					{
						code = "clear_subroom"
					},
					{
						code = "pay_stamina",
						value = 3
					}
				]
			}
		]
	},
	event_dungeon_coccoon_4 = {
		text = "DIALOGUEEVENTDUNGEONCOCCOON_4",
		image = "dungeon_cocoon",
		options = [
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUELEAVE",
				bonus_effects = [
					{
						code = "clear_subroom"
					}
				]
			}
		]
	},
	event_dungeon_library_1 = {
		text = "DIALOGUEEVENTDUNGEONLIBRARY_1",
		tags = [
			"linked_event"
		],
		default_event_type = "character_event",
		image = "dungeon_library",
		options = [
			{
				code = "event_dungeon_library_2",
				reqs = [
					{
						type = "has_stamina",
						value = 10
					}
				],
				text = "DIALOGUEEVENTDUNGEONLIBRARY_OPTION1"
			},
			{
				code = "event_dungeon_library_3",
				select_person = true,
				challenge = "wisdom",
				reqs = [
					{
						type = "has_stamina",
						value = 3
					}
				],
				text = "DIALOGUEEVENTDUNGEONLIBRARY_OPTION2"
			},
			{
				code = "event_dungeon_library_4",
				reqs = [

				],
				text = "DIALOGUELEAVE"
			}
		]
	},
	event_dungeon_library_2 = {
		text = "DIALOGUEEVENTDUNGEONLIBRARY_2",
		image = "dungeon_library",
		common_effects = [
			{
				code = "make_loot",
				type = "tableloot",
				pool = [
					[
						"library_loot",
						1
					]
				]
			}
		],
		options = [
			{
				code = "open_chest",
				reqs = [

				],
				text = "DIALOGUELEAVE",
				bonus_effects = [
					{
						code = "clear_subroom"
					},
					{
						code = "pay_stamina",
						value = 10
					}
				]
			}
		]
	},
	event_dungeon_library_3 = {
		text = "DIALOGUEEVENTDUNGEONLIBRARY_3",
		tags = [
			"active_character_translate"
		],
		image = "dungeon_library",
		common_effects = [
			{
				code = "make_loot",
				type = "tableloot",
				pool = [
					[
						"library_loot",
						1
					]
				]
			}
		],
		options = [
			{
				code = "open_chest",
				reqs = [

				],
				text = "DIALOGUELEAVE",
				bonus_effects = [
					{
						code = "clear_subroom"
					},
					{
						code = "pay_stamina",
						value = 2
					}
				]
			}
		]
	},
	event_dungeon_library_4 = {
		text = "DIALOGUEEVENTDUNGEONLIBRARY_4",
		image = "dungeon_library",
		options = [
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUELEAVE",
				bonus_effects = [
					{
						code = "clear_subroom"
					}
				]
			}
		]
	},
	event_dungeon_coffin_1 = {
		text = "DIALOGUEEVENTDUNGEONCOFFIN_1",
		tags = [
			"linked_event"
		],
		default_event_type = "character_event",
		image = "dungeon_tomb",
		options = [
			{
				code = "event_dungeon_coffin_2",
				reqs = [
					{
						type = "has_stamina",
						value = 5
					}
				],
				text = "DIALOGUEEVENTDUNGEONCOFFIN_OPTION1"
			},
			{
				code = "event_dungeon_coffin_3",
				reqs = [

				],
				text = "DIALOGUEEVENTDUNGEONCOFFIN_OPTION2"
			}
		]
	},
	event_dungeon_coffin_2 = {
		text = "DIALOGUEEVENTDUNGEONCOFFIN_2",
		image = "dungeon_tomb",
		common_effects = [
			{
				code = "make_loot",
				type = "tableloot",
				pool = [
					[
						"medium_boss_chest",
						1
					]
				]
			}
		],
		options = [
			{
				code = "open_chest",
				reqs = [

				],
				text = "DIALOGUELEAVE",
				bonus_effects = [
					{
						code = "clear_subroom"
					},
					{
						code = "pay_stamina",
						value = 5
					}
				]
			}
		]
	},
	event_dungeon_coffin_3 = {
		text = "DIALOGUEEVENTDUNGEONCOFFIN_3",
		image = "dungeon_tomb",
		options = [
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUELEAVE",
				bonus_effects = [
					{
						code = "affect_active_party",
						type = "effect",
						value = "e_coffin_bless"
					},
					{
						code = "clear_subroom"
					}
				]
			}
		]
	}
}
