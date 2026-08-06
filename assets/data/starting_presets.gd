extends Node


var preset_data = {
	easy = {
		code = 'easy',
		name = 'PRESETDATADEBUGEASYNAME',
		mc = 'custom',
		start = 'default',
		descript = "PRESETDATADEBUGEASYDIS",
		gold = 750,
		materials = {meat = 15,fish = 15,bread = 12,vegetables = 15},
		items = {},
		upgrades = {},
		decisions = [],
		active_quests = [],
		completed_quests = [],
		args = {
			skip_prologue = false,
			diff_gf_only_upg = false,
			diff_permadeath = false,
			diff_bonus_taskmod = true,
			diff_bonus_loot = true,
			diff_stop_loan = true,
			diff_small_loan = true,
			diff_solo = false,
			diff_free_upgrade = true,
			diff_hard_monsters = false,
			
			diff_money = 'easy',
			diff_materials = 'easy'
		}
	},
	normal = {
		code = 'normal',
		name = 'PRESETDATADEBUGNORMALNAME',
		mc = 'custom',
		start = 'default',
		descript = "PRESETDATADEBUGNORMALDIS",
		gold = 500,
		materials = {meat = 12,fish = 12, bread = 8,vegetables = 12},
		items = {},
		upgrades = {},
		decisions = [],
		active_quests = [],
		completed_quests = [],
		args = {
			skip_prologue = false,
			diff_gf_only_upg = false,
			diff_permadeath = false,
			diff_bonus_taskmod = false,
			diff_bonus_loot = false,
			diff_stop_loan = true,
			diff_small_loan = false,
			diff_solo = false,
			diff_free_upgrade = true,
			diff_hard_monsters = false,
			
			diff_money = 'normal',
			diff_materials = 'normal'
		}
	},
	hard = {
		code = 'hard',
		name = 'PRESETDATADEBUGHARDNAME',
		mc = 'custom',
		start = 'default',
		descript = "PRESETDATADEBUGHARDDIS",
		gold = 300,
		materials = {meat = 8,fish = 8,bread = 4, vegetables = 8},
		items = {},
		upgrades = {},
		decisions = [],
		active_quests = [],
		completed_quests = [],
		args = {
			skip_prologue = false,
			diff_gf_only_upg = true,
			diff_permadeath = true,
			diff_bonus_taskmod = false,
			diff_bonus_loot = false,
			diff_stop_loan = false,
			diff_small_loan = false,
			diff_solo = false,
			diff_free_upgrade = false,
			diff_hard_monsters = true,
			
			diff_money = 'hard',
			diff_materials = 'hard'
		}
	},
}
var import_preset = { #don't remove, for import purpose
		gold = 500,
		materials = {meat = 15,fish = 15,bread = 15,vegetables = 15},
		items = {},
		upgrades = {},
		decisions = [],
		active_quests = [],
		completed_quests = [],
		tags = ['hidden']
	}
var advanced_preset = { #don't remove
		gold = 3000,
		materials = {meat = 50, fish = 50, bread = 50, vegetables = 50},
		items = {writ_of_exemption = 1},
		upgrades = {forge = 1, tailor = 1},
		decisions = ['aire_is_saved','ginny_visit'],
		active_quests = [],
		unlocked_classes = ['priest'],
		total_reputation = 1000,
		completed_quests = ['main_quest_loan','guilds_introduction','fighters_election_quest','mages_election_quest','workers_election_quest','election_global_quest','aliron_church_quest'],
		seen_dialogues = ['FIGHTERSINTRODUCTION1','SERVANTSINTRODUCTION1','WORKERSINTRODUCTION1','MAGESINTRODUCTION1'],
		master_points = 2
	}
