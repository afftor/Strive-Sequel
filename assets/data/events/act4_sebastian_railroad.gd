extends Reference

var data = {
	act4_sebastian_proposal_dwarf_king_1 = {
		image = null,
		character = "sebastian",
		character2 = "dwarf_king",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROPOSAL_DKING_1",
		options = [{code = "act4_sebastian_proposal_dwarf_king_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_proposal_dwarf_king_2 = {
		image = null,
		character = "sebastian",
		character2 = "dwarf_king",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROPOSAL_DKING_2",
		options = [{code = "act4_sebastian_proposal_dwarf_king_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_proposal_dwarf_king_3 = {
		image = null,
		character = "sebastian",
		character2 = "dwarf_king",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROPOSAL_DKING_3",
		options = [{code = "act4_sebastian_proposal_dwarf_king_4", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_proposal_dwarf_king_4 = {
		image = null,
		character = "sebastian",
		character2 = "dwarf_king",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_PROPOSAL_DKING_4",
		options = [
			{code = "act4_sebastian_proposal_dwarf_king_support", text = "ACT4_SEBASTIAN_OPTION_CONSIDER", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_proposal_dwarf_king_caution", text = "ACT4_SEBASTIAN_OPTION_CAREFUL", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_proposal_dwarf_king_support = {
		image = null,
		character = "sebastian",
		character2 = "dwarf_king",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROPOSAL_DKING_SUPPORT",
		options = [{code = "act4_sebastian_proposal_dwarf_king_merge", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_proposal_dwarf_king_caution = {
		image = null,
		character = "sebastian",
		character2 = "dwarf_king",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROPOSAL_DKING_CAUTION",
		options = [{code = "act4_sebastian_proposal_dwarf_king_merge", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_proposal_dwarf_king_merge = {
		image = null,
		character = "sebastian",
		character2 = "dwarf_king",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROPOSAL_DKING_MERGE",
		options = [{code = "act4_sebastian_project_offer_1", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},

	act4_sebastian_proposal_bolthar_1 = {
		image = null,
		character = "sebastian",
		character2 = "bolthar",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROPOSAL_BOLTHAR_1",
		options = [{code = "act4_sebastian_proposal_bolthar_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_proposal_bolthar_2 = {
		image = null,
		character = "sebastian",
		character2 = "bolthar",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROPOSAL_BOLTHAR_2",
		options = [{code = "act4_sebastian_proposal_bolthar_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_proposal_bolthar_3 = {
		image = null,
		character = "sebastian",
		character2 = "bolthar",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROPOSAL_BOLTHAR_3",
		options = [{code = "act4_sebastian_proposal_bolthar_4", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_proposal_bolthar_4 = {
		image = null,
		character = "sebastian",
		character2 = "bolthar",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_PROPOSAL_BOLTHAR_4",
		options = [
			{code = "act4_sebastian_proposal_bolthar_support", text = "ACT4_SEBASTIAN_OPTION_CONSIDER", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_proposal_bolthar_caution", text = "ACT4_SEBASTIAN_OPTION_CAREFUL", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_proposal_bolthar_support = {
		image = null,
		character = "sebastian",
		character2 = "bolthar",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROPOSAL_BOLTHAR_SUPPORT",
		options = [{code = "act4_sebastian_proposal_bolthar_merge", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_proposal_bolthar_caution = {
		image = null,
		character = "sebastian",
		character2 = "bolthar",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROPOSAL_BOLTHAR_CAUTION",
		options = [{code = "act4_sebastian_proposal_bolthar_merge", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_proposal_bolthar_merge = {
		image = null,
		character = "sebastian",
		character2 = "bolthar",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROPOSAL_BOLTHAR_MERGE",
		options = [{code = "act4_sebastian_project_offer_1", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},

	act4_sebastian_project_offer_1 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_PROJECT_OFFER_1",
		options = [{code = "act4_sebastian_project_offer_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_project_offer_2 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROJECT_OFFER_2",
		options = [
			{code = "act4_sebastian_project_offer_3", text = "ACT4_SEBASTIAN_PROJECT_OFFER_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_project_offer_3", text = "ACT4_SEBASTIAN_PROJECT_OFFER_OPTION_2", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_project_offer_3", text = "ACT4_SEBASTIAN_PROJECT_OFFER_OPTION_3", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_project_offer_3 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PROJECT_OFFER_3",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "find_technician"},
				{code = "update_city"}
			]
		}]
	},

	act4_sebastian_hara_mansion_1 = {
		reqs = [
			{type = "unique_character_at_mansion", name = "hara", check = true},
			{type = "active_quest_stage", value = "sebastian_railroad_quest", stage = "find_technician"}
		],
		image = null,
		character2 = null,
		character = "$hara",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_HARA_MANSION_1",
		options = [{code = "act4_sebastian_hara_mansion_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_hara_mansion_2 = {
		image = null,
		character2 = null,
		character = "$hara",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_HARA_MANSION_2",
		options = [
			{code = "act4_sebastian_hara_mansion_accept", text = "ACT4_SEBASTIAN_HARA_OPTION_HELP", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_hara_mansion_accept", text = "ACT4_SEBASTIAN_HARA_OPTION_PROBLEMS", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_hara_mansion_accept = {
		image = null,
		character2 = null,
		character = "$hara",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_HARA_MANSION_ACCEPT",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "decision", value = "Act4SebastianTechnicianHara"},
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "report_technician"},
				{code = "update_city"}
			]
		}]
	},

	act4_sebastian_hara_capital_1 = {
		image = null,
		character2 = null,
		character = "$hara",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_HARA_CAPITAL_1",
		options = [{code = "act4_sebastian_hara_capital_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_hara_capital_2 = {
		image = null,
		character2 = null,
		character = "$hara",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_HARA_CAPITAL_2",
		options = [
			{code = "act4_sebastian_hara_capital_3", text = "ACT4_SEBASTIAN_TECHNICIAN_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_hara_capital_3", text = "ACT4_SEBASTIAN_HARA_CAPITAL_OPTION_2", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_hara_capital_3 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_HARA_CAPITAL_3",
		options = [{code = "act4_sebastian_hara_capital_4", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_hara_capital_4 = {
		image = null,
		character2 = null,
		character = "$hara",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_HARA_CAPITAL_4",
		options = [
			{code = "act4_sebastian_hara_capital_accept", text = "ACT4_SEBASTIAN_HARA_CAPITAL_OPTION_3", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_hara_capital_accept", text = "ACT4_SEBASTIAN_HARA_CAPITAL_OPTION_4", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_hara_capital_accept = {
		image = null,
		character2 = null,
		character = "$hara",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_HARA_CAPITAL_ACCEPT",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "decision", value = "Act4SebastianTechnicianHara"},
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "report_technician"},
				{code = "update_city"}
			]
		}]
	},

	act4_sebastian_kargun_intro_1 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KARGUN_INTRO_1",
		options = [{code = "act4_sebastian_kargun_intro_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kargun_intro_2 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_KARGUN_INTRO_2",
		options = [
			{code = "act4_sebastian_kargun_intro_3", text = "ACT4_SEBASTIAN_TECHNICIAN_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_kargun_intro_3", text = "ACT4_SEBASTIAN_KARGUN_OPTION_RAILROAD", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_kargun_intro_3 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KARGUN_INTRO_3",
		options = [{code = "act4_sebastian_kargun_intro_4", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kargun_intro_4 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KARGUN_INTRO_4",
		options = [{code = "act4_sebastian_kargun_offer_hub", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kargun_offer_hub = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KARGUN_OFFER_HUB",
		options = [
			{code = "act4_sebastian_kargun_wits", text = "ACT4_SEBASTIAN_KARGUN_OPTION_WITS", reqs = [{type = "master_check", value = [{code = "stat", stat = "wits_factor", operant = "gte", value = 5}]}], type = "next_dialogue"},
			{code = "act4_sebastian_kargun_pay", text = "ACT4_SEBASTIAN_KARGUN_OPTION_PAY", reqs = [{type = "has_money", value = 500}], type = "next_dialogue", bonus_effects = [{code = "money_change", operant = "-", value = 500}]},
			{code = "act4_sebastian_kargun_later", text = "ACT4_SEBASTIAN_KARGUN_OPTION_LATER", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_kargun_wits = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KARGUN_WITS",
		options = [{code = "act4_sebastian_kargun_accept", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kargun_pay = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KARGUN_PAY",
		options = [{code = "act4_sebastian_kargun_accept", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kargun_later = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KARGUN_LATER",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [{code = "decision", value = "Act4SebastianKargunRefused"}, {code = "update_city"}]
		}]
	},
	act4_sebastian_kargun_return = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KARGUN_RETURN",
		options = [{code = "act4_sebastian_kargun_offer_hub", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kargun_accept = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KARGUN_ACCEPT",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "decision", value = "Act4SebastianTechnicianKargun"},
				{code = "remove_decision", value = "Act4SebastianKargunRefused"},
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "report_technician"},
				{code = "update_city"}
			]
		}]
	},

	act4_sebastian_report_technician_1 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_REPORT_TECHNICIAN_1",
		options = [{code = "act4_sebastian_report_technician_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_report_technician_2 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_REPORT_TECHNICIAN_2",
		options = [{code = "act4_sebastian_report_technician_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_report_technician_3 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_REPORT_TECHNICIAN_3",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "wait_preparation"},
				{code = "add_timed_event", value = "act4_sebastian_mansion_visit_1", args = [{type = "add_to_date", date = [2, 2], hour = 1}]},
				{code = "update_city"}
			]
		}]
	},

	act4_sebastian_mansion_visit_1 = {
		reqs = [{type = "active_quest_stage", value = "sebastian_railroad_quest", stage = "wait_preparation"}],
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_MANSION_VISIT_1",
		options = [
			{code = "act4_sebastian_mansion_visit_2", text = "ACT4_SEBASTIAN_MANSION_VISIT_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_mansion_visit_2", text = "ACT4_SEBASTIAN_MANSION_VISIT_OPTION_2", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_mansion_visit_2 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_MANSION_VISIT_2",
		options = [{code = "act4_sebastian_mansion_visit_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_mansion_visit_3 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_MANSION_VISIT_3",
		options = [{code = "act4_sebastian_mansion_visit_4", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_mansion_visit_4 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_MANSION_VISIT_4",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "investigate_trouble"},
				{code = "update_city"}
			]
		}]
	},

	act4_sebastian_trouble_hara_1 = {
		image = null,
		character2 = null,
		character = "$hara",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_TROUBLE_HARA_1",
		options = [{code = "act4_sebastian_trouble_hara_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_trouble_hara_2 = {
		image = null,
		character2 = null,
		character = "$hara",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_TROUBLE_HARA_2",
		options = [{code = "act4_sebastian_trouble_hara_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_trouble_hara_3 = {
		image = null,
		character2 = null,
		character = "$hara",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_TROUBLE_HARA_3",
		options = [
			{code = "act4_sebastian_trouble_hara_4", text = "ACT4_SEBASTIAN_TROUBLE_OPTION_THINK", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_trouble_hara_4", text = "ACT4_SEBASTIAN_TROUBLE_OPTION_INVESTIGATE", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_trouble_hara_4 = {
		image = null,
		character2 = null,
		character = "$hara",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_TROUBLE_HARA_4",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "investigate_kharzug"},
				{code = "make_quest_location", value = "quest_kharzug_deep"},
				{code = "update_city"}
			]
		}]
	},
	act4_sebastian_trouble_kargun_1 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_TROUBLE_KARGUN_1",
		options = [{code = "act4_sebastian_trouble_kargun_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_trouble_kargun_2 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_TROUBLE_KARGUN_2",
		options = [{code = "act4_sebastian_trouble_kargun_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_trouble_kargun_3 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_TROUBLE_KARGUN_3",
		options = [
			{code = "act4_sebastian_trouble_kargun_4", text = "ACT4_SEBASTIAN_TROUBLE_OPTION_THINK", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_trouble_kargun_4", text = "ACT4_SEBASTIAN_TROUBLE_OPTION_INVESTIGATE", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_trouble_kargun_4 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_TROUBLE_KARGUN_4",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "investigate_kharzug"},
				{code = "make_quest_location", value = "quest_kharzug_deep"},
				{code = "update_city"}
			]
		}]
	},

	act4_sebastian_kharzug_arrive_1 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KHARZUG_ARRIVE_1",
		options = [{code = "act4_sebastian_kharzug_arrive_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kharzug_arrive_2 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KHARZUG_ARRIVE_2",
		options = [{code = "quest_fight", args = "act4_sebastian_kharzug_undead", text = "DIALOGUEFIGHTOPTION", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kharzug_after_undead_1 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KHARZUG_AFTER_UNDEAD_1",
		options = [{code = "act4_sebastian_kharzug_after_undead_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kharzug_after_undead_2 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KHARZUG_AFTER_UNDEAD_2",
		options = [{code = "act4_sebastian_kharzug_after_undead_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kharzug_after_undead_3 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KHARZUG_AFTER_UNDEAD_3",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "clear_lower_tomb"},
				{code = "update_city"}
			]
		}]
	},
	act4_sebastian_kharzug_tomb_1 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KHARZUG_TOMB_1",
		options = [{code = "act4_sebastian_kharzug_tomb_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kharzug_tomb_2 = {
		image = null,
		character = "rilu",
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KHARZUG_TOMB_2",
		options = [{code = "act4_sebastian_kharzug_tomb_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kharzug_tomb_3 = {
		image = null,
		character = "rilu",
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KHARZUG_TOMB_3",
		options = [{code = "quest_fight", args = "act4_sebastian_kharzug_tomb_woman", text = "DIALOGUEFIGHTOPTION", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kharzug_tomb_victory_1 = {
		image = null,
		character = "rilu",
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KHARZUG_TOMB_VICTORY_1",
		options = [{code = "act4_sebastian_kharzug_tomb_victory_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_kharzug_tomb_victory_2 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_KHARZUG_TOMB_VICTORY_2",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "return_to_technician"},
				{code = "remove_quest_location", value = "quest_kharzug_deep"},
				{code = "update_city"}
			]
		}]
	},

	act4_sebastian_return_hara = {
		image = null,
		character2 = null,
		character = "$hara",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_RETURN_HARA",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "report_kharzug"},
				{code = "update_city"}
			]
		}]
	},
	act4_sebastian_return_kargun = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_RETURN_KARGUN",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "report_kharzug"},
				{code = "update_city"}
			]
		}]
	},

	act4_sebastian_report_kharzug_1 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_REPORT_KHARZUG_1",
		options = [{code = "act4_sebastian_report_kharzug_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_report_kharzug_2 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_REPORT_KHARZUG_2",
		options = [
			{code = "act4_sebastian_report_kharzug_response_1", text = "ACT4_SEBASTIAN_REPORT_KHARZUG_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_report_kharzug_response_2", text = "ACT4_SEBASTIAN_REPORT_KHARZUG_OPTION_2", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_report_kharzug_response_3", text = "ACT4_SEBASTIAN_REPORT_KHARZUG_OPTION_3", reqs = [], type = "next_dialogue", bonus_effects = [{code = "money_change", operant = "+", value = 500}]
			}
		]
	},
	act4_sebastian_report_kharzug_response_1 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_REPORT_KHARZUG_RESPONSE_1",
		options = [{code = "act4_sebastian_report_kharzug_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_report_kharzug_response_2 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_REPORT_KHARZUG_RESPONSE_2",
		options = [{code = "act4_sebastian_report_kharzug_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_report_kharzug_response_3 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_REPORT_KHARZUG_RESPONSE_3",
		options = [{code = "act4_sebastian_report_kharzug_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_report_kharzug_3 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_REPORT_KHARZUG_3",
		options = [{code = "act4_sebastian_church_offer_1", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "sebastian_railroad_quest", stage = "speak_to_church"}]}]
	},
	act4_sebastian_church_offer_1 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_CHURCH_OFFER_1",
		options = [{code = "act4_sebastian_church_offer_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_church_offer_2 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_CHURCH_OFFER_2",
		options = [
			{code = "act4_sebastian_church_offer_3", text = "ACT4_SEBASTIAN_CHURCH_OFFER_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_church_offer_3", text = "ACT4_SEBASTIAN_CHURCH_OFFER_OPTION_2", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_church_offer_3 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_CHURCH_OFFER_3",
		options = [{code = "act4_sebastian_church_offer_4", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_church_offer_4 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_CHURCH_OFFER_4",
		options = [
			{code = "act4_sebastian_church_offer_accept", text = "ACT4_SEBASTIAN_CHURCH_OFFER_OPTION_3", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_church_offer_accept", text = "ACT4_SEBASTIAN_CHURCH_OFFER_OPTION_4", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_church_offer_accept = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_CHURCH_OFFER_ACCEPT",
		options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "update_city"}]}]
	},

	act4_sebastian_church_visit = {
		image = null,
		character2 = null,
		character = "ginny",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_CHURCH_VISIT",
		options = [
			{code = "act4_sebastian_church_protect_1", text = "ACT4_SEBASTIAN_CHURCH_VISIT_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_church_pressure_1", text = "ACT4_SEBASTIAN_CHURCH_VISIT_OPTION_2", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_church_protect_1 = {
		image = null,
		character2 = null,
		character = "ginny",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_CHURCH_PROTECT_1",
		options = [{code = "act4_sebastian_church_protect_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_church_protect_2 = {
		image = null,
		character2 = null,
		character = "ginny",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_CHURCH_PROTECT_2",
		options = [
			{code = "act4_sebastian_church_protect_4", text = "ACT4_SEBASTIAN_CHURCH_PROTECT_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_church_protect_4", text = "ACT4_SEBASTIAN_CHURCH_PROTECT_OPTION_2", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_church_protect_4 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_CHURCH_PROTECT_4",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "find_warehouse_owner"},
				{code = "update_city"}
			]
		}]
	},
	act4_sebastian_church_pressure_1 = {
		image = null,
		character2 = null,
		character = "ginny",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_CHURCH_PRESSURE_1",
		options = [
			{code = "act4_sebastian_church_pressure_3", text = "ACT4_SEBASTIAN_CHURCH_PRESSURE_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_church_pressure_3", text = "ACT4_SEBASTIAN_CHURCH_PRESSURE_OPTION_2", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_church_pressure_3 = {
		image = null,
		character2 = null,
		character = "ginny",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_CHURCH_PRESSURE_3",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "return_ginny_refusal"},
				{code = "update_city"}
			]
		}]
	},

	act4_sebastian_return_ginny_refusal_1 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_RETURN_GINNY_REFUSAL_1",
		options = [{code = "act4_sebastian_return_ginny_refusal_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_return_ginny_refusal_2 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_RETURN_GINNY_REFUSAL_2",
		options = [
			{code = "act4_sebastian_return_ginny_refusal_3", text = "ACT4_SEBASTIAN_RETURN_GINNY_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_return_ginny_refusal_3", text = "ACT4_SEBASTIAN_RETURN_GINNY_OPTION_2", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_return_ginny_refusal_3 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_RETURN_GINNY_REFUSAL_3",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "offer_alternative_site"},
				{code = "update_city"}
			]
		}]
	},

	act4_sebastian_offer_alternative_site_1 = {
		image = null,
		character2 = null,
		character = "ginny",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_OFFER_ALTERNATIVE_SITE_1",
		options = [
			{code = "act4_sebastian_ginny_dominator", text = "ACT4_SEBASTIAN_GINNY_DOMINATOR_OPTION", reqs = [{type = "master_check", value = [{code = "has_profession", profession = "dominator", check = true}]}], type = "next_dialogue"},
			{code = "act4_sebastian_ginny_insist_fail_1", text = "ACT4_SEBASTIAN_GINNY_INSIST_OPTION", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_ginny_dominator = {
		image = null,
		character2 = null,
		character = "ginny",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_GINNY_DOMINATOR",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "decision", value = "Act4SebastianChurchMoved"},
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "new_church_site"},
				{code = "update_city"}
			]
		}]
	},
	act4_sebastian_ginny_insist_fail_1 = {
		image = null,
		character2 = null,
		character = "ginny",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_GINNY_INSIST_FAIL_1",
		options = [{code = "act4_sebastian_ginny_insist_fail_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_ginny_insist_fail_2 = {
		image = null,
		character2 = null,
		character = "ginny",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_GINNY_INSIST_FAIL_2",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "add_timed_event", value = "act4_sebastian_parishioners_ready", args = [{type = "add_to_date", date = [1, 1], hour = 1}]},
				{code = "update_city"}
			]
		}]
	},
	act4_sebastian_parishioners_ready = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PARISHIONERS_READY",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "persuade_parishioners"},
				{
					code = "add_special_task_for_location",
					location = "aliron",
					amount = 5,
					descript = "ACT4_SEBASTIAN_PARISHIONER_TASK_DESC",
					name = "ACT4_SEBASTIAN_PARISHIONER_TASK_NAME",
					max_workers = 4,
					icon = "res://assets/Textures_v2/MANSION/quest_task.png",
					args = [{code = "start_event", data = "act4_sebastian_parishioner_task_done", args = {}}]
				},
				{code = "update_city"}
			]
		}]
	},
	act4_sebastian_parishioner_task_done = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_PARISHIONER_TASK_DONE",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "parishioners_persuaded"},
				{code = "update_city"}
			]
		}]
	},
	act4_sebastian_ginny_parishioners_persuaded = {
		image = null,
		character2 = null,
		character = "ginny",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_GINNY_PARISHIONERS_PERSUADED",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "decision", value = "Act4SebastianChurchMoved"},
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "new_church_site"},
				{code = "update_city"}
			]
		}]
	},
	act4_sebastian_new_church_opening_1 = {
		image = null,
		character = "ginny",
		character2 = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_NEW_CHURCH_OPENING_1",
		options = [{code = "act4_sebastian_new_church_opening_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_new_church_opening_2 = {
		image = null,
		character = "ginny",
		character2 = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_NEW_CHURCH_OPENING_2",
		options = [
			{code = "act4_sebastian_new_church_opening_3", text = "ACT4_SEBASTIAN_NEW_CHURCH_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_new_church_opening_3", text = "ACT4_SEBASTIAN_NEW_CHURCH_OPTION_2", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_new_church_opening_3 = {
		image = null,
		character = "ginny",
		character2 = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_NEW_CHURCH_OPENING_3",
		options = [
			{code = "act4_sebastian_new_church_opening_4", text = "ACT4_SEBASTIAN_NEW_CHURCH_OPTION_3", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_new_church_opening_4", text = "ACT4_SEBASTIAN_NEW_CHURCH_OPTION_4", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_new_church_opening_4 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_NEW_CHURCH_OPENING_4",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "sebastian_route_complete"},
				{code = "add_timed_event", value = "act4_road_courier_1", skip_existing = true, args = [{type = "add_to_date", date = [2, 2], hour = 1}]},
				{code = "update_city"}
			]
		}]
	},

	act4_sebastian_find_warehouse_owner_1 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_FIND_WAREHOUSE_OWNER_1",
		options = [{code = "act4_sebastian_find_warehouse_owner_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_find_warehouse_owner_2 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_FIND_WAREHOUSE_OWNER_1B",
		options = [
			{code = "act4_sebastian_find_warehouse_owner_3", text = "ACT4_SEBASTIAN_WAREHOUSE_OWNER_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_find_warehouse_owner_3", text = "ACT4_SEBASTIAN_WAREHOUSE_OWNER_OPTION_2", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_find_warehouse_owner_3 = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_FIND_WAREHOUSE_OWNER_2",
		options = [
			{code = "act4_sebastian_warehouse_purchase", text = "ACT4_SEBASTIAN_WAREHOUSE_OWNER_OPTION_PAY", reqs = [{type = "has_money", value = 3000}], type = "next_dialogue", bonus_effects = [{code = "money_change", operant = "-", value = 3000}]},
			{code = "act4_sebastian_warehouse_later", text = "ACT4_SEBASTIAN_WAREHOUSE_OWNER_OPTION_LATER", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_warehouse_purchase = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_WAREHOUSE_PURCHASE",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "decision", value = "Act4SebastianWarehousePurchased"},
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "report_warehouse_solution"},
				{code = "update_city"}
			]
		}]
	},
	act4_sebastian_warehouse_later = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_WAREHOUSE_LATER",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "buy_warehouse"},
				{code = "update_city"}
			]
		}]
	},
	act4_sebastian_revisit_warehouse_owner = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_REVISIT_WAREHOUSE_OWNER",
		options = [
			{code = "act4_sebastian_warehouse_purchase_return", text = "ACT4_SEBASTIAN_REVISIT_WAREHOUSE_OPTION_PAY", reqs = [{type = "has_money", value = 3000}], type = "next_dialogue", bonus_effects = [{code = "money_change", operant = "-", value = 3000}]},
			{code = "act4_sebastian_revisit_warehouse_later", text = "ACT4_SEBASTIAN_REVISIT_WAREHOUSE_OPTION_LATER", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_warehouse_purchase_return = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_WAREHOUSE_PURCHASE_RETURN",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "decision", value = "Act4SebastianWarehousePurchased"},
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "report_warehouse_solution"},
				{code = "update_city"}
			]
		}]
	},
	act4_sebastian_revisit_warehouse_later = {
		image = null,
		character = null,
		character2 = null,
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_WAREHOUSE_LATER",
		options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "update_city"}]}]
	},
	act4_sebastian_report_warehouse_solution_1 = {
		image = null,
		character2 = null,
		character = "ginny",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_REPORT_WAREHOUSE_SOLUTION_1",
		options = [
			{code = "act4_sebastian_report_warehouse_solution_2", text = "ACT4_SEBASTIAN_REPORT_WAREHOUSE_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_report_warehouse_solution_2", text = "ACT4_SEBASTIAN_REPORT_WAREHOUSE_OPTION_2", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_report_warehouse_solution_2 = {
		image = null,
		character2 = null,
		character = "ginny",
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		text = "ACT4_SEBASTIAN_REPORT_WAREHOUSE_SOLUTION_2",
		options = [{code = "act4_sebastian_report_warehouse_solution_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_report_warehouse_solution_3 = {
		image = null,
		character = "sebastian",
		character2 = "ginny",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_REPORT_WAREHOUSE_SOLUTION_3",
		options = [
			{code = "act4_sebastian_report_warehouse_solution_4", text = "ACT4_SEBASTIAN_REPORT_WAREHOUSE_OPTION_3", reqs = [], type = "next_dialogue"},
			{code = "act4_sebastian_report_warehouse_solution_4", text = "ACT4_SEBASTIAN_REPORT_WAREHOUSE_OPTION_4", reqs = [], type = "next_dialogue"}
		]
	},
	act4_sebastian_report_warehouse_solution_4 = {
		image = null,
		character2 = null,
		character = "sebastian",
		tags = ["dialogue_scene"],
		text = "ACT4_SEBASTIAN_REPORT_WAREHOUSE_SOLUTION_4",
		options = [{code = "act4_sebastian_report_warehouse_solution_5", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	act4_sebastian_report_warehouse_solution_5 = {
		image = null,
		character = "sebastian",
		character2 = "ginny",
		tags = ["dialogue_scene", "master_translate"],
		text = "ACT4_SEBASTIAN_REPORT_WAREHOUSE_SOLUTION_5",
		options = [{
			code = "close",
			text = "DIALOGUECLOSE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "progress_quest", value = "sebastian_railroad_quest", stage = "church_protected_complete"},
				{code = "add_timed_event", value = "act4_road_courier_1", skip_existing = true, args = [{type = "add_to_date", date = [2, 2], hour = 1}]},
				{code = "update_city"}
			]
		}]
	}
}
