var data = {
	# =========================================================
	# JEAN QUEST 2 — The Ruins
	# Trigger: 3 days after completing Jean's first quest (jean_q1_book_recovered decision)
	# =========================================================

	# =========================================================
	# SCENE 1: JEAN'S ROOM VISIT
	# =========================================================
	jean_q2_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_START", reqs = []}],
		options = [{
			code = 'jean_q2_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_1", reqs = []}],
		options = [{
			code = 'jean_q2_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_2", reqs = []}],
		options = [{
			code = 'jean_q2_3', text = "JEAN_Q2_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_3", reqs = []}],
		options = [{
			code = 'jean_q2_4', text = "JEAN_Q2_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_4', text = "JEAN_Q2_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_4_STUCK", reqs = []}],
		options = [{
			code = 'jean_q2_5_kind', text = "JEAN_Q2_4_OPTION_KIND", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'decision', value = 'jean_q2_kind'}],
		}, {
			code = 'jean_q2_5_blunt', text = "JEAN_Q2_4_OPTION_BLUNT", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_5_kind = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_5_KIND", reqs = []}],
		options = [{
			code = 'jean_q2_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_5_blunt = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_5_BLUNT", reqs = []}],
		options = [{
			code = 'jean_q2_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_6_PROBLEM", reqs = []}],
		options = [{
			code = 'jean_q2_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_7_SUGGESTIONS", reqs = []}],
		options = [{
			code = 'jean_q2_myr_reject', text = "JEAN_Q2_7_OPTION_MYR", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_church_agree', text = "JEAN_Q2_7_OPTION_CHURCH", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_myr_reject = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_MYR_REJECT", reqs = []}],
		options = [{
			code = 'jean_q2_church_agree', text = "JEAN_Q2_7_OPTION_CHURCH", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_church_agree = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_CHURCH_AGREE", reqs = []}],
		common_effects = [{code = 'progress_quest', value = 'jean_ruins_quest', stage = 'stage1'}],
		options = [{
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'make_quest_location', value = 'quest_jean_ruins_church'}],
		}],
	},

	# =========================================================
	# SCENE 2: CHURCH — Ginny helps with research
	# =========================================================
	jean_q2_church = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'ginny',
		text = [{text = "JEAN_Q2_CHURCH_ENTER", reqs = []}],
		options = [{
			code = 'jean_q2_church_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_church_2 = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'ginny',
		text = [{text = "JEAN_Q2_CHURCH_2", reqs = []}],
		options = [{
			code = 'jean_q2_church_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_church_3 = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'ginny',
		text = [{text = "JEAN_Q2_CHURCH_3_ARTIFACT", reqs = []}],
		options = [{
			code = 'jean_q2_church_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_church_4 = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'ginny',
		text = [{text = "JEAN_Q2_CHURCH_4_DEMON", reqs = []}],
		options = [{
			code = 'jean_q2_demon_warn', text = "JEAN_Q2_CHURCH_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_demon_info', text = "JEAN_Q2_CHURCH_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'jean_q2_crossref', text = "JEAN_Q2_CHURCH_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}],
	},

	jean_q2_demon_warn = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_DEMON_WARN", reqs = []}],
		options = [{
			code = 'jean_q2_church_4', text = "DIALOGUEBACK", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_demon_info = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'ginny',
		text = [{text = "JEAN_Q2_DEMON_INFO", reqs = []}],
		options = [{
			code = 'jean_q2_church_4', text = "DIALOGUEBACK", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_crossref = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'ginny',
		text = [{text = "JEAN_Q2_CROSSREF", reqs = []}],
		options = [{
			code = 'jean_q2_library', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_library = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], reqs = [], character = 'ginny',
		text = [{text = "JEAN_Q2_LIBRARY", reqs = []}],
		common_effects = [{code = 'progress_quest', value = 'jean_ruins_quest', stage = 'stage2'}],
		options = [{
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [
				{code = 'remove_quest_location', value = 'quest_jean_ruins_church'},
				{code = 'unique_character_changes', value = 'jean', args = [{code = 'assign_task', task = 'church_library_study'}]},
			],
		}],
	},

	# =========================================================
	# SCENE 3: Research Complete — called after task finishes
	# =========================================================
	jean_q2_research_done = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_RESEARCH_DONE", reqs = []}],
		common_effects = [{code = 'progress_quest', value = 'jean_ruins_quest', stage = 'stage3'}],
		options = [{
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'make_quest_location', value = 'quest_jean_ruins_location'}],
		}],
	},

	# =========================================================
	# SCENE 4: RUINS — Approach event (dungeon entrance)
	# =========================================================
	jean_q2_ruins_approach = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_RUINS_APPROACH", reqs = []}],
		options = [{
			code = 'close', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},

	# =========================================================
	# SCENE 5: CENTRAL HALL — Monsters, Rynn's cage, Hooded Figure
	# (fires after completing dungeon floor 1)
	# =========================================================
	jean_q2_central_hall = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_CENTRAL_HALL", reqs = []}],
		options = [{
			code = 'jean_q2_central_hall_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_central_hall_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [{text = "JEAN_Q2_HALL_FIGURE", reqs = []}],
		options = [{
			code = 'quest_fight', args = 'jean_ruins_monsters_1',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_after_fight = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [{text = "JEAN_Q2_AFTER_FIGHT", reqs = []}],
		options = [{
			code = 'jean_q2_path_a', text = "JEAN_Q2_CHOICE_FREE_RYNN", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_path_b', text = "JEAN_Q2_CHOICE_PURSUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	# =========================================================
	# PATH A: Free Rynn First, then clear floor 2
	# =========================================================
	jean_q2_path_a = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		common_effects = [{code = 'decision', value = 'jean_q2_freed_rynn_first'}],
		text = [{text = "JEAN_Q2_FREE_RYNN_1", reqs = []}],
		options = [{
			code = 'jean_q2_rynn_reprimand', text = "JEAN_Q2_FREE_RYNN_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_rynn_glad', text = "JEAN_Q2_FREE_RYNN_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_rynn_reprimand = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_RYNN_REPRIMAND", reqs = []}],
		options = [{
			code = 'jean_q2_rynn_how_found', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_rynn_glad = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_RYNN_GLAD", reqs = []}],
		options = [{
			code = 'jean_q2_rynn_how_found', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_rynn_how_found = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_RYNN_HOW_FOUND", reqs = []}],
		options = [{
			code = 'jean_q2_rynn_how_found_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_rynn_how_found_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_RYNN_HOW_FOUND_2", reqs = []}],
		options = [{
			code = 'jean_q2_rynn_how_found_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_rynn_how_found_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_RYNN_HOW_FOUND_3", reqs = []}],
		options = [{
			code = 'jean_q2_rynn_camp_setup', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_rynn_camp_setup = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_RYNN_CAMP_SETUP", reqs = []}],
		options = [{
			code = 'quest_fight', args = 'jean_ruins_floor2_a',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_lab_a = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_LAB_ESCAPED", reqs = []}],
		options = [{
			code = 'jean_q2_lab_search_a', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_lab_search_a = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_LAB_SEARCH", reqs = []}],
		options = [{
			code = 'jean_q2_lab_react_a', text = "JEAN_Q2_LAB_OPTION_LET", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_lab_press_a', text = "JEAN_Q2_LAB_OPTION_PRESS", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_lab_react_a = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_LAB_REACT_LET", reqs = []}],
		options = [{
			code = 'jean_q2_burn_lab_a', text = "JEAN_Q2_LAB_BURN_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_burn_lab_a', text = "JEAN_Q2_LAB_BURN_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_lab_press_a = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_LAB_REACT_PRESS", reqs = []}],
		options = [{
			code = 'jean_q2_burn_lab_a', text = "JEAN_Q2_LAB_BURN_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_burn_lab_a', text = "JEAN_Q2_LAB_BURN_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_burn_lab_a = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], reqs = [], character = 'jean',
		common_effects = [{code = 'decision', value = 'jean_q2_lab_burned'}],
		text = [{text = "JEAN_Q2_BURN_LAB", reqs = []}],
		options = [{
			code = 'jean_q2_rynn_camp_return', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	# Path A continues: return to Rynn at camp
	jean_q2_rynn_camp_return = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_RYNN_CAMP_RETURN", reqs = []}],
		options = [{
			code = 'jean_q2_rynn_fever_1', text = "JEAN_Q2_RYNN_CAMP_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_rynn_fever_1', text = "JEAN_Q2_RYNN_CAMP_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_rynn_fever_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_RYNN_FEVER_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "JEAN_Q2_RYNN_FEVER_1_2", reqs = [], previous_dialogue_option = 2}],
		options = [{
			code = 'jean_q2_rynn_fever_2', text = "JEAN_Q2_RYNN_FEVER_ASK_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_rynn_fever_2', text = "JEAN_Q2_RYNN_FEVER_ASK_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_rynn_fever_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_RYNN_FEVER_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "JEAN_Q2_RYNN_FEVER_2_2", reqs = [], previous_dialogue_option = 2}],
		options = [{
			code = 'jean_q2_rynn_voice_push', text = "JEAN_Q2_RYNN_PUSH_TELL_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_rynn_voice_push', text = "JEAN_Q2_RYNN_PUSH_TELL_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_rynn_voice_push = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_RYNN_VOICE_PUSH_1", reqs = [], previous_dialogue_option = 1},
		{text = "JEAN_Q2_RYNN_VOICE_PUSH_2", reqs = [], previous_dialogue_option = 2}],
		options = [{
			code = 'jean_q2_rynn_overheard', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_rynn_overheard = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_RYNN_OVERHEARD", reqs = []}],
		options = [{
			code = 'jean_q2_curse_reveal', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_curse_reveal = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_CURSE_REVEAL", reqs = []}],
		options = [{
			code = 'jean_q2_curse_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_curse_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_CURSE_2_JEAN", reqs = []}],
		options = [{
			code = 'jean_q2_curse_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_curse_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_CURSE_3_RYNN", reqs = []}],
		options = [{
			code = 'jean_q2_curse_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_curse_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_CURSE_4_TIME", reqs = []}],
		options = [{
			code = 'jean_q2_curse_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_curse_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_CURSE_5_RYNN", reqs = []}],
		options = [{
			code = 'jean_q2_curse_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_curse_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		text = [{text = "JEAN_Q2_CURSE_6_HOPE", reqs = []}],
		options = [{
			code = 'jean_q2_curse_faint', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_curse_faint = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_CURSE_FAINT", reqs = []}],
		options = [{
			code = 'jean_q2_save_rynn', text = "JEAN_Q2_RYNN_SAVE_OPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_leave_rynn', text = "JEAN_Q2_RYNN_LEAVE_OPTION", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_save_rynn = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], reqs = [], character = 'jean',
		common_effects = [{code = 'decision', value = 'jean_q2_saved_rynn'}],
		text = [{text = "JEAN_Q2_SAVE_RYNN", reqs = []}],
		options = [{
			code = 'jean_q2_church_rynn_arrive', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_leave_rynn = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], reqs = [],
		common_effects = [{code = 'decision', value = 'jean_q2_abandoned_rynn'}],
		text = [{text = "JEAN_Q2_LEAVE_RYNN", reqs = []}],
		options = [{
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [
				{code = 'progress_quest', value = 'jean_ruins_quest', stage = 'stage4'},
				{code = 'complete_quest', value = 'jean_ruins_quest'},
			],
		}],
	},

	jean_q2_church_rynn_arrive = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'ginny',
		text = [{text = "JEAN_Q2_CHURCH_RYNN_ARRIVE", reqs = []}],
		options = [{
			code = 'jean_q2_church_rynn_2', text = "JEAN_Q2_CHURCH_RYNN_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_church_rynn_2', text = "JEAN_Q2_CHURCH_RYNN_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_church_rynn_2 = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'ginny',
		text = [{text = "JEAN_Q2_CHURCH_RYNN_2", reqs = []}],
		options = [{
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [
				{code = 'progress_quest', value = 'jean_ruins_quest', stage = 'stage4'},
				{code = 'complete_quest', value = 'jean_ruins_quest'},
				{code = 'decision', value = 'rynn_cursed_at_church'},
			],
		}],
	},

	# =========================================================
	# PATH B: Pursue Hooded Figure First
	# =========================================================
	jean_q2_path_b = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'rynn',
		common_effects = [{code = 'decision', value = 'jean_q2_pursued_first'}],
		text = [{text = "JEAN_Q2_PURSUE_PAST_RYNN", reqs = []}],
		options = [{
			code = 'jean_q2_path_b_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_path_b_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_PURSUE_JEAN_DOUBTS", reqs = []}],
		options = [{
			code = 'jean_q2_boss_intro', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_boss_intro = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [{text = "JEAN_Q2_BOSS_FIGHT_INTRO", reqs = []}],
		options = [{
			code = 'quest_fight', args = 'jean_ruins_boss_fight',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_capture_figure = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_CAPTURE_FIGURE", reqs = []}],
		options = [{
			code = 'jean_q2_interrogate', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_interrogate = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [{text = "JEAN_Q2_INTERROGATE", reqs = []}],
		options = [{
			code = 'jean_q2_interrogate_who', text = "JEAN_Q2_INTERROGATE_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			remove_after_first_use = true,
		}, {
			code = 'jean_q2_interrogate_master', text = "JEAN_Q2_INTERROGATE_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			remove_after_first_use = true,
		}, {
			code = 'jean_q2_interrogate_full', text = "JEAN_Q2_INTERROGATE_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}],
	},

	jean_q2_interrogate_who = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [{text = "JEAN_Q2_INTERROGATE_WHO", reqs = []}],
		options = [{
			code = 'jean_q2_interrogate', text = "DIALOGUEBACK", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_interrogate_master = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [{text = "JEAN_Q2_INTERROGATE_MASTERLOC", reqs = []}],
		options = [{
			code = 'jean_q2_interrogate', text = "DIALOGUEBACK", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_interrogate_full = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [{text = "JEAN_Q2_INTERROGATE_FULL", reqs = []}],
		options = [{
			code = 'jean_q2_artifact_mention', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_artifact_mention = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_ARTIFACT_MENTION", reqs = []}],
		options = [{
			code = 'jean_q2_artifact_let', text = "JEAN_Q2_ARTIFACT_OPTION_LET", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_artifact_press', text = "JEAN_Q2_ARTIFACT_OPTION_PRESS", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_artifact_let = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_ARTIFACT_LET", reqs = []}],
		options = [{
			code = 'jean_q2_captive_fate', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_artifact_press = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_ARTIFACT_PRESS", reqs = []}],
		options = [{
			code = 'jean_q2_captive_fate', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_captive_fate = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [{text = "JEAN_Q2_CAPTIVE_FATE", reqs = []}],
		options = [{
			code = 'jean_q2_captive_free', text = "JEAN_Q2_CAPTIVE_OPTION_FREE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_captive_jail', text = "JEAN_Q2_CAPTIVE_OPTION_JAIL", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'jean_q2_captive_kill', text = "JEAN_Q2_CAPTIVE_OPTION_KILL", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}],
	},

	jean_q2_captive_free = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		common_effects = [{code = 'decision', value = 'jean_q2_captive_freed'}],
		text = [{text = "JEAN_Q2_CAPTIVE_FREE", reqs = []}],
		options = [{
			code = 'jean_q2_lab_b', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_captive_jail = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		common_effects = [{code = 'decision', value = 'jean_q2_captive_jailed'}],
		text = [{text = "JEAN_Q2_CAPTIVE_JAIL", reqs = []}],
		options = [{
			code = 'jean_q2_lab_b', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_captive_kill = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		common_effects = [{code = 'decision', value = 'jean_q2_captive_killed'}],
		text = [{text = "JEAN_Q2_CAPTIVE_KILL", reqs = []}],
		options = [{
			code = 'jean_q2_lab_b', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	# Path B: lab search, burn, then return to Rynn (unconscious from fever)
	jean_q2_lab_b = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_LAB_SEARCH", reqs = []}],
		options = [{
			code = 'jean_q2_lab_react_b', text = "JEAN_Q2_LAB_OPTION_LET", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_lab_press_b', text = "JEAN_Q2_LAB_OPTION_PRESS", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_lab_react_b = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_LAB_REACT_LET", reqs = []}],
		options = [{
			code = 'jean_q2_burn_lab_b', text = "JEAN_Q2_LAB_BURN_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_burn_lab_b', text = "JEAN_Q2_LAB_BURN_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_lab_press_b = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_LAB_REACT_PRESS", reqs = []}],
		options = [{
			code = 'jean_q2_burn_lab_b', text = "JEAN_Q2_LAB_BURN_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_burn_lab_b', text = "JEAN_Q2_LAB_BURN_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},

	jean_q2_burn_lab_b = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], reqs = [], character = 'jean',
		common_effects = [{code = 'decision', value = 'jean_q2_lab_burned'}],
		text = [{text = "JEAN_Q2_BURN_LAB", reqs = []}],
		options = [{
			code = 'jean_q2_rynn_unconscious', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_rynn_unconscious = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [{text = "JEAN_Q2_RYNN_UNCONSCIOUS", reqs = []}],
		options = [{
			code = 'jean_q2_captive_spoke_b', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	jean_q2_captive_spoke_b = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [{text = "JEAN_Q2_CAPTIVE_SPOKE_B", reqs = []}],
		options = [{
			code = 'jean_q2_curse_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},

	# Paths rejoin: curse revealed via captive (Path B) → same curse scenes as Path A
	# jean_q2_curse_2 through jean_q2_curse_faint are shared above
	# jean_q2_save_rynn / jean_q2_leave_rynn are shared above
	# jean_q2_church_rynn_arrive / jean_q2_church_rynn_2 are shared above
}
