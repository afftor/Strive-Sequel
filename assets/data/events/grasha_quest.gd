extends Reference
var data = {
	#Grasha's old crew: three days after she joins the word arrives, the fight itself waits for a visit to Aliron
	grasha_old_crew_rumor = {
		image = null, tags = [],
		reqs = [{type = 'unique_character_checks', name = 'grasha', value = [], negative = 'cancel'}],
		text = [{text = "GRASHA_CREW_RUMOR", reqs = []}],
		common_effects = [
			{code = 'progress_quest', value = 'grasha_old_crew', stage = 'start'},
			{code = 'plan_loc_event', loc = 'aliron', event = 'grasha_old_crew_start'},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
		} ],
	},

	grasha_old_crew_start = {
		image = null, character = "bandits", tags = ['dialogue_scene'],
		reqs = [
			{type = 'active_quest_stage', value = 'grasha_old_crew', stage = 'start'},
			{type = 'unique_character_at_mansion', name = 'grasha', check = true},
		],
		text = [{text = "GRASHA_CREW_START", reqs = []}],
		options = [ {
			code = 'grasha_old_crew_who',
			text = "GRASHA_CREW_OPTION_WHO", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'grasha_old_crew_bring',
			text = "GRASHA_CREW_OPTION_BRING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'grasha_old_crew_refuse',
			text = "GRASHA_CREW_OPTION_REFUSE", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		} ],
	},

	grasha_old_crew_who = {
		image = null, character = "bandits", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_CREW_WHO", reqs = []}],
		options = [ {
			code = 'grasha_old_crew_bring',
			text = "GRASHA_CREW_OPTION_BRING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'grasha_old_crew_refuse',
			text = "GRASHA_CREW_OPTION_REFUSE", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		} ],
	},

	grasha_old_crew_bring = {
		image = null, character = "$grasha", character2 = "bandits", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_CREW_BRING", reqs = []}],
		options = [ {
			code = 'grasha_old_crew_reveal',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},

	grasha_old_crew_refuse = {
		image = null, character = "bandits", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_CREW_REFUSE", reqs = []}],
		options = [ {
			code = 'quest_fight', args = 'grasha_old_crew_street',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},

	#win of grasha_old_crew_street
	grasha_old_crew_after_fight = {
		image = null, character = "$grasha", character2 = "bandits", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_CREW_AFTER_FIGHT", reqs = []}],
		options = [ {
			code = 'grasha_old_crew_reveal',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},

	grasha_old_crew_reveal = {
		variations = [ {
			reqs = [{type = 'decision', value = 'GrashaCrewBeaten', check = true}],
			image = null, character = "$grasha", character2 = "bandits", tags = ['dialogue_scene'],
			text = [{text = "GRASHA_CREW_REVEAL", reqs = []}],
			options = [ {
				code = 'grasha_old_crew_beaten_exit',
				text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			} ],
		}, {
			reqs = [{type = 'decision', value = 'GrashaCrewBeaten', check = false}],
			image = null, character = "$grasha", character2 = "bandits", tags = ['dialogue_scene'],
			text = [{text = "GRASHA_CREW_REVEAL", reqs = []}],
			options = [ {
				code = 'grasha_old_crew_standoff',
				text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			} ],
		} ],
	},

	#the street fight ends here, so the amulet scene opens on the way back home (argument 1)
	grasha_old_crew_beaten_exit = {
		image = null, character = "$grasha", character2 = "bandits", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_CREW_BEATEN", reqs = []}, {text = "GRASHA_CREW_BEATEN_LEAVE_STREET", reqs = []}],
		options = [ {
			code = 'grasha_old_crew_amulet_reveal',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},

	grasha_old_crew_standoff = {
		image = null, character = "$grasha", character2 = "bandits", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_CREW_STANDOFF", reqs = []}],
		options = [ {
			code = 'grasha_old_crew_charm',
			text = "GRASHA_CREW_OPTION_CHARM", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'quest_fight', args = 'grasha_old_crew_mansion',
			text = "GRASHA_CREW_OPTION_FIGHT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'grasha_old_crew_leave',
			text = "GRASHA_CREW_OPTION_LEAVE", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		} ],
	},

	grasha_old_crew_charm = {
		variations = [ {
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'gte', value = 60}]}],
			image = null, character = "$grasha", character2 = "bandits", tags = ['dialogue_scene'],
			text = [{text = "GRASHA_CREW_CHARM", reqs = []}],
			options = [ {
				code = 'grasha_old_crew_charm_2',
				text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			} ],
		}, {
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'lt', value = 60}]}],
			image = null, character = "$grasha", character2 = "bandits", tags = ['dialogue_scene'],
			text = [{text = "GRASHA_CREW_CHARM_FAIL", reqs = []}],
			options = [ {
				code = 'quest_fight', args = 'grasha_old_crew_mansion',
				text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			} ],
		} ],
	},

	grasha_old_crew_charm_2 = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_CREW_CHARM_2", reqs = []}],
		options = [ {
			code = 'grasha_old_crew_amulet_reveal',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		} ],
	},

	#win of grasha_old_crew_mansion; the reveal was already shown before the fight
	grasha_old_crew_beaten_home = {
		image = null, character = "$grasha", character2 = "bandits", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_CREW_BEATEN", reqs = []}, {text = "GRASHA_CREW_BEATEN_LEAVE_HOME", reqs = []}],
		options = [ {
			code = 'grasha_old_crew_amulet_reveal',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		} ],
	},

	grasha_old_crew_amulet_reveal = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		text = [
			{text = "GRASHA_CREW_AMULET_OPEN_STREET", reqs = [], previous_dialogue_option = 1},
			{text = "GRASHA_CREW_AMULET_OPEN_HOME", reqs = [], previous_dialogue_option = 2},
			{text = "GRASHA_CREW_AMULET_REVEAL", reqs = []},
		],
		common_effects = [
			{code = 'decision', value = 'GrashaAmuletRevealed'},
			{code = 'complete_quest', value = 'grasha_old_crew'},
			{code = 'add_timed_event', value = 'grasha_thoth_intro', args = [{type = 'add_to_date', date = [3,3], hour = 2}]},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
		} ],
	},

	grasha_old_crew_leave = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_CREW_LEAVE", reqs = []}],
		common_effects = [
			{code = 'decision', value = 'GrashaLeftWithCrew'},
			{code = 'unique_character_changes', value = 'grasha', args = [{code = 'remove_character'}]},
			{code = 'complete_quest', value = 'grasha_old_crew'},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
		} ],
	},

	#Grasha: Trace of the Amulet
	grasha_thoth_intro = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		reqs = [
			{type = 'unique_character_checks', name = 'grasha', value = [], negative = 'cancel'},
			{type = 'unique_character_at_mansion', name = 'grasha', check = true, negative = 'repeat_next_day'},
		],
		text = [{text = "GRASHA_THOTH_INTRO", reqs = []}],
		options = [ {
			code = 'grasha_thoth_intro_why_not',
			text = "GRASHA_THOTH_OPTION_WHY_NOT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'grasha_thoth_intro_why_kargan',
			text = "GRASHA_THOTH_OPTION_WHY_KARGAN", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'grasha_thoth_intro_answer',
			text = "GRASHA_THOTH_OPTION_GO", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		} ],
	},

	grasha_thoth_intro_why_not = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_THOTH_WHY_NOT", reqs = []}],
		options = [ {
			code = 'grasha_thoth_intro_answer',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		} ],
	},

	grasha_thoth_intro_why_kargan = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_THOTH_WHY_KARGAN", reqs = []}],
		options = [ {
			code = 'grasha_thoth_intro_answer',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		} ],
	},

	grasha_thoth_intro_answer = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_THOTH_ANSWER", reqs = []}],
		common_effects = [
			{code = 'progress_quest', value = 'grasha_amulet', stage = 'find_kargan'},
			{code = 'make_quest_location', value = 'quest_grasha_settlement'},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
		} ],
	},

	#quest_grasha_settlement, first visit
	grasha_thoth_settlement = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRASHA_THOTH_SETTLEMENT", reqs = []}],
		options = [ {
			code = 'grasha_thoth_settlement_grasha',
			text = "GRASHA_THOTH_SETTLEMENT_OPTION_GRASHA", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'decision', value = 'GrashaWarriorsSentByGrasha'}],
		}, {
			code = 'grasha_thoth_settlement_defiant',
			text = "GRASHA_THOTH_SETTLEMENT_OPTION_DEFIANT", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			bonus_effects = [{code = 'decision', value = 'GrashaWarriorsDefied'}],
		}, {
			code = 'grasha_thoth_settlement_book',
			text = "GRASHA_THOTH_SETTLEMENT_OPTION_BOOK", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			bonus_effects = [{code = 'decision', value = 'GrashaWarriorsBookStory'}],
		} ],
	},

	grasha_thoth_settlement_grasha = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "GRASHA_THOTH_SETTLEMENT_GRASHA", reqs = []}],
		options = [ {
			code = 'grasha_thoth_settlement_kargan',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		} ],
	},

	grasha_thoth_settlement_defiant = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "GRASHA_THOTH_SETTLEMENT_DEFIANT", reqs = []}],
		options = [ {
			code = 'grasha_thoth_settlement_kargan',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		} ],
	},

	grasha_thoth_settlement_book = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "GRASHA_THOTH_SETTLEMENT_BOOK", reqs = []}],
		options = [ {
			code = 'grasha_thoth_settlement_kargan',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		} ],
	},

	grasha_thoth_settlement_kargan = {
		image = null, character = "kargan", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_THOTH_KARGAN", reqs = []}],
		common_effects = [{code = 'decision', value = 'GrashaSettlementWarriorsMet'}],
		options = [ {
			code = 'grasha_thoth_settlement_kargan_2',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 5, type = 'next_dialogue'
		} ],
	},

	grasha_thoth_settlement_kargan_2 = {
		image = null, character = "kargan", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_THOTH_KARGAN_2", reqs = []}],
		options = [ {
			code = 'grasha_thoth_settlement_kargan_3',
			text = "GRASHA_THOTH_KARGAN_OPTION_LATER", reqs = [], dialogue_argument = 6, type = 'next_dialogue'
		}, {
			code = 'grasha_thoth_settlement_kargan_3',
			text = "GRASHA_THOTH_KARGAN_OPTION_BRING", reqs = [], dialogue_argument = 7, type = 'next_dialogue'
		} ],
	},

	grasha_thoth_settlement_kargan_3 = {
		image = null, character = "kargan", tags = [],
		text = [{text = "GRASHA_THOTH_KARGAN_3", reqs = []}],
		#make_quest_location repoints input_handler.active_location at the ruins, so it goes after the screen refresh
		common_effects = [
			{code = 'progress_quest', value = 'grasha_amulet', stage = 'retrieve_chronicle'},
			{code = 'update_location'},
			{code = 'make_quest_location', value = 'quest_grasha_ruins'},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
		} ],
	},

	#quest_grasha_ruins
	grasha_thoth_ruins = {
		image = null, tags = [],
		text = [{text = "GRASHA_THOTH_RUINS", reqs = []}],
		common_effects = [
			{code = 'material_change', operant = '+', material = 'thoth_chronicle', value = 1},
			{code = 'progress_quest', value = 'grasha_amulet', stage = 'return_book'},
			{code = 'remove_quest_location', value = 'quest_grasha_ruins'},
			{code = 'update_location'},
		],
		options = [ {
			code = 'close', text = "GRASHA_THOTH_RUINS_OPTION_TAKE", reqs = []
		} ],
	},

	#quest_grasha_settlement, with the chronicle
	grasha_thoth_kargan_return = {
		image = null, character = "kargan", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_THOTH_KARGAN_RETURN", reqs = []}],
		options = [ {
			code = 'grasha_thoth_kargan_more',
			text = "GRASHA_THOTH_KARGAN_OPTION_MORE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'grasha_thoth_kargan_finish',
			text = "GRASHA_THOTH_KARGAN_OPTION_DIRECTIONS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		} ],
	},

	grasha_thoth_kargan_more = {
		image = null, character = "kargan", tags = ['dialogue_scene'],
		text = [{text = "GRASHA_THOTH_KARGAN_MORE", reqs = []}],
		options = [ {
			code = 'grasha_thoth_kargan_finish',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		} ],
	},

	grasha_thoth_kargan_finish = {
		image = null, character = "kargan", tags = [],
		text = [{text = "GRASHA_THOTH_KARGAN_FINISH", reqs = []}],
		common_effects = [
			{code = 'material_change', operant = '-', material = 'thoth_chronicle', value = 1},
			{code = 'complete_quest', value = 'grasha_amulet'},
			{code = 'decision', value = 'GrashaThothTempleLead'},
			{code = 'remove_quest_location', value = 'quest_grasha_settlement'},
			{code = 'update_location'},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
		} ],
	},
}
