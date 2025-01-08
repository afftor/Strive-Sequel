extends Node


var preset_data = {
	easy = {
		gold = 750,
		materials = {meat = 50,fish = 50,bread = 50,vegetables = 50},
		items = {},
		upgrades = {},
		decisions = [],
		active_quests = [],
		completed_quests = [],
	},
	normal = {
		gold = 500,
		materials = {meat = 25,fish = 25,bread = 25,vegetables = 25},
		items = {},
		upgrades = {},
		decisions = [],
		active_quests = [],
		completed_quests = [],
	},
	hard = {
		gold = 500,
		materials = {meat = 20,fish = 20,bread = 20, vegetables = 20},
		items = {},
		upgrades = {},
		decisions = [],
		active_quests = [],
		completed_quests = [],
	},
}
var import_preset = { #don't remove, for import purpose
		gold = 500,
		materials = {meat = 25,fish = 25,bread = 25,vegetables = 25},
		items = {},
		upgrades = {},
		decisions = [],
		active_quests = [],
		completed_quests = [],
		tags = ['hidden']
	}
var advanced_preset = { #don't remove
		gold = 3000,
		materials = {meat = 100, fish = 100, bread = 100, vegetables = 100},
		items = {writ_of_exemption = 1},
		upgrades = {forge = 1, tailor = 1},
		decisions = ['aire_is_saved','ginny_visit'],
		active_quests = [],
		unlocked_classes = ['priest'],
		total_reputation = 1000,
		completed_quests = ['main_quest_loan','guilds_introduction','fighters_election_quest','mages_election_quest','workers_election_quest','election_global_quest','aliron_church_quest'],
		seen_dialogues = ['FIGHTERSINTRODUCTION1','SERVANTSINTRODUCTION1','WORKERSINTRODUCTION1','MAGESINTRODUCTION1'],
	}
