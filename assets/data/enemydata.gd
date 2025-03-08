extends Node

var predeterminatedgroups = {
}

var encounters = {
	wolves_skirmish = {unittype = 'randomgroup', unitcode = 'wolves_easy1', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'skirmish_complete', args = []}], lose_effects = []},
	rebels_skirmish = {unittype = 'randomgroup', unitcode = 'rebels_small', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'skirmish_complete', args = []}], lose_effects = []},
	slavers_small = {unittype = 'randomgroup', unitcode = 'slavers_small', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'event_person_acquired', args = []}], lose_effects = []},
	rebels_small = {unittype = 'randomgroup', unitcode = 'rebels_small', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'event_person_acquired', args = []}], lose_effects = []},
	goblins_skirmish = {unittype = 'randomgroup', unitcode = 'goblins_skirmish', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'skirmish_complete', args = []}], lose_effects = []},
	ogre_skirmish = {unittype = 'randomgroup', unitcode = 'ogre_skirmish', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'skirmish_complete', args = []}], lose_effects = []},
	troll_skirmish = {unittype = 'randomgroup', unitcode = 'troll_skirmish', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'skirmish_complete', args = []}], lose_effects = []},
	tribal_elves = {unittype = 'randomgroup', unitcode = 'tribal_elves', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'tribal_elves_win', args = []}], lose_effects = []},
	

	lich_fight_easy = {unittype = 'randomgroup', unitcode = 'quest_lich_easy', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'lich_enc_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	lich_fight_normal = {unittype = 'randomgroup', unitcode = 'quest_lich_normal', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'lich_enc_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},

	mimic = {unittype = 'randomgroup', unitcode = 'mimic', bg = 'default', bgm = 'default', win_effects = [], lose_effects = []},


	rebel_group = {unittype = 'randomgroup', unitcode = 'rebel_group_mines', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'rebel_group_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	demon_kurdan = {unittype = 'randomgroup', unitcode = 'demon_kurdan', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'demon_kurdan_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	demon = {unittype = 'randomgroup', unitcode = 'demon', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'demon_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	rebel_convoy = {unittype = 'randomgroup', unitcode = 'rebel_convoy', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'rebel_convoy_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	event_rebels_1 = {unittype = 'randomgroup', unitcode = 'event_rebels_1', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'betrayal_confirmed_rebels_1_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	event_rebels_2 = {unittype = 'randomgroup', unitcode = 'event_rebels_2', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'betrayal_confirmed_rebels_2_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	patrol = {unittype = 'randomgroup', unitcode = 'patrol', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'patrol_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	wrong_building_rebels = {unittype = 'randomgroup', unitcode = 'wrong_building_rebels', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'wrong_building_rebels_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	two_guards = {unittype = 'randomgroup', unitcode = 'two_guards', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'two_guards_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	daisy_admirer_guards1 = {unittype = 'randomgroup', unitcode = 'bandits_golem', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'daisy_lost_4', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	daisy_admirer_guards2 = {unittype = 'randomgroup', unitcode = 'ramont_boss_fight', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'daisy_lost_9', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	gryphon = {unittype = 'randomgroup', unitcode = 'gryphon', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'gryphon_cave_1', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	mae_slavers = {unittype = 'randomgroup', unitcode = 'mae_slavers', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'pre_ritual_5', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	leon = {unittype = 'randomgroup', unitcode = 'leon', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'leon_fight_3', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	leon_2 = {unittype = 'randomgroup', unitcode = 'leon_2', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'leon_encounter_1', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	elder_gryphon_boss = {unittype = 'randomgroup', unitcode = 'elder_gryphon_boss', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'gryphon_cave_1', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	cali_slavers = {unittype = 'randomgroup', unitcode = 'cali_slavers', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'got_cali_1_1', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	white_stag_human = {unittype = 'randomgroup', unitcode = 'white_stag_human', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'white_stag_encounter_fight_2', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	white_stag = {unittype = 'randomgroup', unitcode = 'white_stag', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'white_stag_encounter_13', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	temple_raiders = {unittype = 'randomgroup', unitcode = 'temple_raiders', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'temple_5', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	temple_specters = {unittype = 'randomgroup', unitcode = 'temple_specters', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'temple_8', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	bridge_guards = {unittype = 'randomgroup', unitcode = 'bridge_guards', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'erlen_leon_4', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	cali_goblins_first = {unittype = 'randomgroup', unitcode = 'cali_goblins_first', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'cali_goblins_2', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	cali_goblins_second = {unittype = 'randomgroup', unitcode = 'cali_goblins_second', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'cali_goblins_5', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	troll_clothes = {unittype = 'randomgroup', unitcode = 'troll_clothes', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'troll_clothes_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	goblin_quest = {unittype = 'randomgroup', unitcode = 'goblin_quest', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'goblin_quest_10', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	ketch_group = {unittype = 'randomgroup', unitcode = 'ketch_group', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'zephyra_disappearance_ketch_3_f_2', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	robbed_man = {unittype = 'randomgroup', unitcode = 'robbed_man', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'lilith_good_route_1', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	lilia_boss = {unittype = 'randomgroup', unitcode = 'lilia_boss', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'lilith_good_route_village_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	lilith_patron = {unittype = 'randomgroup', unitcode = 'lilith_patron', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'lilith_beat_demon', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},


	mercenary_fred_quest = {unittype = 'randomgroup', unitcode = 'mercenary_fred_quest', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'fred_got_after_fight', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},



	greg_boss_fight = {unittype = 'randomgroup', unitcode = 'greg_boss_fight', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'greg_combat_on_win_1', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	aire_boss_fight = {unittype = 'randomgroup', unitcode = 'aire_boss_fight', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'aire_combat_on_win_2', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	
	hector = {unittype = 'randomgroup', unitcode = 'hector_boss_fight', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'cali_finale_1', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	
	dwarf_tavern_patrons = {unittype = 'randomgroup', unitcode = 'dwarf_tavern_patrons', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'dwarf_tavern_bark_after_fight', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	vault_golem = {unittype = 'randomgroup', unitcode = 'vault_golem', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'jean_mountain_guards', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	coalition_base_kuro = {unittype = 'randomgroup', unitcode = 'coalition_base_kuro', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'coalbase_attack_after_fight', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	dwarf_ceremony_cult = {unittype = 'randomgroup', unitcode = 'dwarf_ceremony_cult', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'dwarf_ceremony_kuro', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	dwarf_ceremony_guards = {unittype = 'randomgroup', unitcode = 'dwarf_ceremony_guards', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'dwarf_ceremony_kuro', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	dwarf_ceremony_coal = {unittype = 'randomgroup', unitcode = 'dwarf_ceremony_coal', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'kuro_resolution_intro', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	dwarf_ceremony_cult2 = {unittype = 'randomgroup', unitcode = 'dwarf_ceremony_cult2', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'kuro_resolution_intro', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
	kuro_cult_hideout = {unittype = 'randomgroup', unitcode = 'kuro_cult_hideout', bg = 'default', bgm = 'default', win_effects = [{code = 'start_event', data = 'kuro_hideout_win', args = []}], lose_effects = [{code = 'start_event', data = 'generic_lose_scene', args = []}]},
}

var enemygroups = {
	
	tutorial_lich_fight = {reqs = [], units = {rat = [2,2]}},
	
	rats_easy = {reqs = [], units = {rat = [2,6]}, challenges = [['event_enemy_strength_scare', 1]], challenge_chance = 0.3},
	rats_goblins_easy = {reqs = [], units = {rat = [1,4], cave_goblin_melee = [1,3]}, challenges = [['event_enemy_strength_scare', 1],['event_enemy_distract',0.5]], challenge_chance = 0.3},
	bandits_easy = {reqs = [], units = {bandit_melee = [1,3], trained_dog = [0,2]}, challenges = [['event_enemy_charm_avoid', 1],['event_enemy_charm_damage',0.8]], challenge_chance = 0.4},
	bandits_easy2 = {reqs = [], units = {bandit_melee = [1,3], bandit_archer = [1,2]}, challenges = [['event_enemy_charm_avoid', 1],['event_enemy_dexterity_sneak',0.5]], challenge_chance = 0.4},
	bandits_easy3 = {reqs = [], units = {trained_dog = [1,2], bandit_archer = [0,3]}, challenges = [['event_enemy_charm_avoid', 1],['event_enemy_charm_damage',0.8]], challenge_chance = 0.4},

	bandits_easy_boss = {maxunits = 3, reqs = [], units = {bandit_boss_melee = [1,1], bandit_melee = [0,2], bandit_archer = [0,2]}},
	bandits_easy_boss2 = {maxunits = 3, reqs = [], units = {bandit_boss_archer = [1,1], bandit_melee = [1,2], bandit_archer = [0,1]}},
	bandits_easy_boss3 = {maxunits = 3, reqs = [], units = {bandit_boss_mage = [1,1], bandit_melee = [1,2], bandit_archer = [0,1]}},
	bandits_medium_boss = {maxunits = 6, reqs = [], units = {bandit_boss_melee = [1,1], bandit_melee = [1,2], bandit_archer = [1,2], bandit_mage = [1,1]}},
	
	rebels_boss = {maxunits = 6, reqs = [], units = {bandit_boss_melee = [1,1], rebel_knight = [1,2], rebel_mage = [1,2], rebel_healer = [1,1]}},
	
	
	bandits_assassin = {reqs = [], units = {bandit_melee = [1,2], bandit_assassin = [1,2]}, challenges = [['event_enemy_charm_avoid', 1],['event_enemy_charm_damage',0.8]], challenge_chance = 0.4},
	bandits_assassin2 = {reqs = [], units = {bandit_melee = [0,3], bandit_assassin = [0,2], bandit_archer = [0,2]}, challenges = [['event_enemy_charm_avoid', 1],['event_enemy_charm_damage',0.8]], challenge_chance = 0.4},
	bandits_medium = {reqs = [], units = {bandit_melee = [2,3], bandit_archer = [2,3]}, challenges = [['event_enemy_charm_avoid', 1],['event_enemy_charm_damage',0.8]], challenge_chance = 0.4},
	bandits_medium2 = {reqs = [], units = {bandit_melee = [2,3], bandit_archer = [1,2], bandit_mage = [1,2]}, challenges = [['event_enemy_charm_avoid', 1],['event_enemy_charm_damage',0.8]], challenge_chance = 0.4},
	bandits_medium_bear = {reqs = [], units = {trained_bear = [1,2], bandit_archer = [1,2]}, challenges = [['event_enemy_charm_avoid', 1],['event_enemy_charm_damage',0.8]], challenge_chance = 0.4},
	bandits_golem = {reqs = [], units = {bandit_melee = [0,2], bandit_archer = [0,2], guardian_golem = [1,1]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_distract',0.8]], challenge_chance = 0.4},

	bandits_raptors = {reqs = [], units = {bandit_melee = [1,2], trained_raptor = [1,2]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_distract',0.8]], challenge_chance = 0.4},
	bandits_ballista = {reqs = [], units = {bandit_melee = [1,2], ballista = [1,2]}, challenges = [['event_enemy_charm_avoid', 1],['event_enemy_charm_damage',0.8]], challenge_chance = 0.4},

	goblins_skirmish = {reqs = [], units = {cave_goblin_melee = [2,3], cave_goblin_archer = [2,3], cave_goblin_mage = [0,1]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_distract',0.8]], challenge_chance = 0.4},
	ogre_skirmish = {reqs = [], units = {cave_goblin_melee = [2,2], ogre_melee = [1,1]}},
	troll_skirmish = {reqs = [], units = {cave_goblin_melee = [1,1], troll = [1,1], cave_goblin_archer = [1,1]}},

	tribal_elves = {reqs = [], units = {bandit_melee = [2,3], bandit_archer = [2,3]}},

	goblins_easy = {reqs = [], units = {cave_goblin_melee = [2,3]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_charm_avoid',0.8]], challenge_chance = 0.4},
	goblins_easy2 = {reqs = [], units = {cave_goblin_melee = [1,3], cave_goblin_archer = [1,2]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_charm_damage',0.8]], challenge_chance = 0.4},
	goblins_easy3 = {reqs = [], units = {cave_goblin_melee = [1,2], cave_goblin_archer = [1,3]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_distract',0.8]], challenge_chance = 0.4},
	goblins_easy_boss1 = {maxunits = 3, reqs = [], units = {cave_goblin_boss = [1,1], cave_goblin_melee = [0,2], cave_goblin_archer = [0,2]}},
	goblins_easy_boss2 = {maxunits = 4, reqs = [], units = {cave_goblin_shaman = [1,1], cave_goblin_melee = [1,3], cave_goblin_archer = [0,1]}},
	grove_easy_boss = {maxunits = 5, reqs = [], units = {troll = [1,1], wolf = [1,2]}},
	#ogre_med1 = {reqs = [], units = {ogre_melee = [1,1], cave_goblin_melee = [0,1], cave_goblin_archer = [0,1]}},
	#ogre_med2 = {reqs = [], units = {ogre_melee = [0,1], ogre_mage = [1,1]}},
	#troll_boss = {maxunits = 4, reqs = [], units = {cave_goblin_boss = [1,1], cave_goblin_melee = [0,2]}},

	wolves_easy1 = {reqs = [], units = {wolf = [4,6]}, challenges = [['event_enemy_strength_scare', 1],['event_enemy_dexterity_sneak',0.8]], challenge_chance = 0.4},
	wolves_easy2 = {reqs = [], units = {wolf = [3,5]}, challenges = [['event_enemy_strength_scare', 1],['event_enemy_dexterity_sneak',0.8]], challenge_chance = 0.4},
	grove_1 = {reqs = [], units = {willowisp = [2,3]}, challenges = [['event_enemy_dexterity_sneak',1]], challenge_chance = 0.2},
	grove_2 = {reqs = [], units = {willowisp = [1,2], spider = [1,2]}, challenges = [['event_enemy_dexterity_sneak',1],['event_enemy_strength_scare', 1]], challenge_chance = 0.2},

	slavers_small = {reqs = [], units = {bandit_melee = [2,3]}, challenges = [['event_enemy_charm_avoid', 1],['event_enemy_distract',0.8]], challenge_chance = 0.4},
	rebels_small = {reqs = [], units = {rebel_recruit = [2,3]}, challenges = [['event_enemy_charm_avoid', 1],['event_enemy_distract',0.8]], challenge_chance = 0.4},
	spiders = {reqs = [], units = {spider_weak = [2,3]}, challenges = [['event_enemy_strength_scare', 1],['event_enemy_dexterity_sneak',0.8]], challenge_chance = 0.4},
	spiders2 = {reqs = [], units = {spider_aoe = [1,1], spider = [2,2]}, challenges = [['event_enemy_strength_scare', 1],['event_enemy_dexterity_sneak',0.8]], challenge_chance = 0.4},
	spiders3 = {reqs = [], units = {spider_ranged = [1,2], spider = [2,2]}, challenges = [['event_enemy_strength_scare', 1],['event_enemy_dexterity_sneak',0.8]], challenge_chance = 0.4},
	spiders_many = {reqs = [], units = {spider = [4,6]}, challenges = [['event_enemy_strength_scare', 1],['event_enemy_dexterity_sneak',0.8]], challenge_chance = 0.4},
	spiders_many2 = {maxunits = 5, reqs = [], units = {spider = [3,3], spider_aoe = [0,1], spider_ranged = [1,2]}, challenges = [['event_enemy_strength_scare', 1],['event_enemy_dexterity_sneak',0.8]], challenge_chance = 0.4},
	spiders_alfa_boss = {maxunits = 3, reqs = [], units = {spider_alfa_boss = [1,1], spider_ranged = [0,2]}, challenges = [['event_enemy_strength_scare', 1],['event_enemy_dexterity_sneak',0.8]], challenge_chance = 0.4},
	spiders_queen_boss = {maxunits = 4, reqs = [], units = {spider_queen_boss = [1,1],  spider = [3,3]}, challenges = [['event_enemy_strength_scare', 1],['event_enemy_dexterity_sneak',0.8]], challenge_chance = 0.4},

	rats = {reqs = [], units = {rat = [3,5]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},

	skeletons_easy = {reqs = [], units = {skeleton_melee = [2,3]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	skeletons_easy2 = {reqs = [], units = {skeleton_melee = [1,2], skeleton_archer = [1,2]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	skeletons_zombies = {reqs = [], units = {skeleton_melee = [1,2], zombie = [1,2]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	skeletons_zombies2 = {reqs = [], units = {skeleton_archer = [1,2], zombie = [2,3]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	skeletons_lich = {reqs = [], units = {skeleton_melee = [2,3], skeleton_archer = [1,2], undead_lich = [1,1]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	skeletons_lich_boss = {maxunits = 6, reqs = [], units = {undead_lich = [1,1], skeleton_archer = [2,2], zombie = [3,3]}},

	rebel_group_mines = {reqs = [], units = {rebel_recruit = [3,3], rebel_mage = [1,1]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_charm_avoid',0.8]], challenge_chance = 0.4},
	demon_kurdan = {reqs = [], units = {demoness = [1,1],kurdan = [1,1], rebel_recruit = [2,2]}},
	demon = {reqs = [], units = {demoness = [1,1], rebel_recruit = [2,2], rebel_mage = [1,1]}},
	rebel_convoy = {reqs = [], units = {rebel_recruit = [2,2], rebel_knight = [1,1], rebel_healer = [1,1], rebel_mage = [1,1]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_charm_avoid',0.8]], challenge_chance = 0.4},
	event_rebels_1 = {reqs = [], units = {rebel_recruit = [3,3], rebel_healer = [2,2], rebel_mage = [1,1]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_charm_avoid',0.8]], challenge_chance = 0.4},
	event_rebels_2 = {reqs = [], units = {rebel_knight = [2,2], rebel_healer = [1,1], rebel_mage = [2,2]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_charm_avoid',0.8]], challenge_chance = 0.4},
	patrol = {reqs = [], units = {rebel_recruit = [3,3], rebel_mage = [1,1]}},
	wrong_building_rebels = {reqs = [], units = {rebel_recruit = [2,2]}},
	two_guards = {reqs = [], units = {rebel_knight = [1,1], rebel_recruit = [2,2], rebel_healer = [1,1]}},
	gryphon = {reqs = [], units = {gryphon = [1,1]}},
	elder_gryphon_boss = {reqs = [], units = {elder_gryphon_boss = [1,1]}},
	mae_slavers = {reqs = [], units = {bandit_melee = [3,3], bandit_archer = [2,2], bandit_mage = [1,1]}}, 
	leon = {reqs = [], units = {leon = [1,1]}},
	leon_2 = {reqs = [], units = {leon = [1,1], wild_raptor = [3,3]}},
	white_stag_human = {reqs = [], units = {white_stag_human = [1,1]}},
	white_stag = {reqs = [], units = {white_stag = [1,1], wolf = [1,1], centipede = [1,1]}},
	temple_raiders = {reqs = [], units = {bandit_melee = [2,2], bandit_boss_melee = [1,1], bandit_mage = [3,3]}},
	temple_specters = {reqs = [], units = {elf_specter = [6,6]}},
	bridge_guards = {reqs = [], units = {elf_soldier = [6,6]}},
	cali_goblins_first = {reqs = [], units = {cave_goblin_melee = [1,3], cave_goblin_archer = [1,2]}},
	cali_goblins_second = {reqs = [], units = {cave_goblin_melee = [2,3], cave_goblin_archer = [2,3], cave_goblin_mage = [0,1]}},
	troll_clothes = {reqs = [], units = {troll = [1,1]}},
	goblin_quest = {reqs = [], units = {quest_goblin_boss = [2,2], quest_goblin_shaman = [2,2]}},
	ketch_group = {reqs = [], units = {rebel_knight = [1,1], rebel_recruit = [2,2], rebel_healer = [1,1]}},
	robbed_man = {reqs = [], units = {rebel_knight = [1,1], rebel_recruit = [2,2], rebel_healer = [1,1]}},
	lilia_boss = {reqs = [], units = {lilith_boss = [1,1]}},
	lilith_patron = {reqs = [], units = {lilith_boss_2 = [1,1], anthropoid = [2,2]}},

	mercenary_fred_quest = {reqs = [], units = {bandit_melee = [2,2], bandit_archer = [2,2], bandit_mage = [1,1]}},

	rebel_group_hideout1 = {reqs = [], units = {rebel_recruit = [1,3], rebel_healer = [1,2], rebel_mage = [0,1]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_charm_avoid',0.8]], challenge_chance = 0.4},
	rebel_group_hideout2 = {reqs = [], units = {rebel_knight = [0,1], rebel_healer = [1,2], rebel_recruit = [1,2]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_charm_avoid',0.8]], challenge_chance = 0.4},
	rebel_group_hideout3 = {reqs = [], units = {rebel_knight = [1,2], rebel_healer = [0,1], rebel_mage = [1,2]}},
	greg_boss_fight = {reqs = [], units = {greg = [1,1], rebel_knight = [2,2], rebel_healer = [1,1], rebel_mage = [2,2]}},
	aire_boss_fight = {reqs = [], units = {rebel_knight = [3,3], aire = [1,1], rebel_healer = [2,2]}},

	quest_lich_easy = {reqs = [], units = {lich_quest = [1,1], skeleton_shield_melee = [1,1], skeleton_archer_quest = [1,1]}},
	quest_lich_normal = {reqs = [], units = {lich_quest = [1,1], skeleton_shield_melee = [2,2], skeleton_archer_quest = [2,2]}},


	ramont_boss_fight = {reqs = [], units = {guardian_golem = [2,2], ramont_boss = [1,1], bandit_assassin = [1,1]}},

	mimic = {reqs = [], units = {mimic = [1,1]}},
	
	cali_slavers = {reqs = [], units = {bandit_melee = [2,2], bandit_archer = [1,1], bandit_mage = [1,1]}}, 
	
	jungle_easy1 = {reqs = [], units = {giant_ant = [2,3], wild_raptor = [0,1], maneater_plant = [0,1]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	jungle_easy2 = {reqs = [], units = {giant_ant = [1,2], centipede = [0,1], maneater_plant = [0,1]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	jungle_medium1 = {reqs = [], units = {wild_raptor = [2,3], maneater_plant = [1,2]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	jungle_medium2 = {reqs = [], units = {centipede = [1,2], giant_ant = [2,3]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	jungle_boss1 = {reqs = [], units = {wild_raptor = [1,2], great_viper = [1,1]}},
	jungle_boss2 = {reqs = [], units = {ogre_melee = [1,1], ogre_alpha = [1,1], ogre_mage = [1,1]}},
	jungle_boss3 = {reqs = [], units = {maneater_plant = [0,2], gryphon = [1,1]}},

	firedepths_easy1 = {reqs = [], units = {salamander = [1,2], rock_thrower = [1,2]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	firedepths_easy2 = {reqs = [], units = {anthropoid = [1,2], ifrit = [0,1]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	firedepths_medium1 = {reqs = [], units = {salamander = [1,3], rock_thrower = [1,2], ifrit = [0,1]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	firedepths_medium2 = {reqs = [], units = {ifrit = [2,4]}, challenges = [['event_enemy_dexterity_sneak', 1],['event_enemy_strength_scare',0.8]], challenge_chance = 0.4},
	firedepths_boss1 = {reqs = [], units = {magma_beast = [1,1], salamander = [1,1]}},
	firedepths_boss2 = {reqs = [], units = {erebus_stone = [2,2]}},

	hector_boss_fight = {reqs = [], units = {bandit_melee = [2,2], hector_boss = [1,1], bandit_archer = [2,2], bandit_mage = [1,1]}}, 

	dwarf_tavern_patrons = {reqs = [], units = {dwarf_fighter = [3,3]}}, 
	vault_golem = {reqs = [], units = {guardian_golem = [1,1], dwarf_fighter = [1,1], dwarf_ranged = [1,1]}}, 
	coalition_base_kuro = {reqs = [], units = {kuro = [1,1], dwarf_fighter = [2,2], dwarf_ranged = [2,2]}}, 
	dwarf_ceremony_cult = {reqs = [], units = {dwarf_fighter = [2,2]}}, 
	dwarf_ceremony_guards = {reqs = [], units = {dwarf_fighter = [2,2], dwarf_fighter_elite = [1,1], dwarf_ranged = [3,3]}},
	dwarf_ceremony_coal = {reqs = [], units = {dwarf_fighter_elite = [2,2]}},
	dwarf_ceremony_cult2 = {reqs = [], units = {dwarf_fighter = [2,2]}},
	kuro_cult_hideout = {reqs = [], units = {dwarf_fighter = [2,2]}}, #dummy
}

#Ai patterns: basic - basic attack/ranged attack or pass (if exist), ads - advanced single target skill, aoe - aoe skill, buff - buffing skill
#ai_hard is selected when difficulty set to hard mode (if exists)
var enemies = {
	bandit_melee = {
		code = 'bandit_melee',
		name = '',
		descript = '',
		hpmax = 75,
		armor = 15,
		mdef = 0,
		hitrate = 85,
		evasion = 10,
		armorpenetration = 0,
		atk = 20,
		matk = 5,
		speed = 35,
		resists = {},
		status_resists = {},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/bandit.png", 
		skills = ['attack', 'earth_atk'],
		traits = [],
		tags = ['human','bandit'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_hard = [['basic', 50], ['ads', 50]],
		ai_position = ['melee'],
		xpreward = 10,
	},
	bandit_archer = {
		code = 'bandit_archer',
		name = '',
		descript = '',
		hpmax = 70,
		armor = 5,
		mdef = 0,
		hitrate = 95,
		evasion = 0,
		armorpenetration = 0,
		atk = 35,
		matk = 5,
		speed = 40,
		resists = {},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/bandit_archer.png", 
		skills = ['wind_atk','ranged_attack'],
		traits = [],
		tags = ['human','bandit'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['ranged'],
		xpreward = 10,
	},
	bandit_assassin = {
		code = 'bandit_assassin',
		name = '',
		descript = '',
		hpmax = 500,
		armor = 10,
		mdef = 5,
		hitrate = 130,
		evasion = 0,
		armorpenetration = 10,
		atk = 110,
		matk = 10,
		speed = 50,
		resists = {},
		race = 'humanoid',
		loot = 'assassin_loot',
		icon = "res://assets/images/enemies/assassin.png", 
		skills = ['ranged_attack', 'assassinate_en'],
		traits = [],
		tags = ['human','bandit'], 
		ai =  [['basic', 66], ['ads', 33]],
		ai_position = ['ranged'],
		xpreward = 15,
	},
	bandit_boss_melee = {
		code = 'bandit_boss_melee',
		name = '',
		descript = '',
		hpmax = 450,
		armor = 15,
		mdef = 10,
		hitrate = 85,
		evasion = 15,
		armorpenetration = 0,
		atk = 40,
		matk = 15,
		speed = 35,
		resists = {},
		status_resists = {stun = 25},
		race = 'humanoid',
		loot = 'bandit_boss_loot',
		icon = "res://assets/images/enemies/bandit_boss.png", 
		skills = ['attack', 'enemy_slash'],
		traits = ['boss_resists'],
		tags = ['human','bandit'], 
		ai = [['basic', 85], ['aoe', 50]],
		ai_hard = [['basic', 85], ['aoe', 50]],
		ai_position = ['melee'],
		xpreward = 40,
	},
	bandit_boss_archer = {
		code = 'bandit_boss_archer',
		name = '',
		descript = '',
		hpmax = 400,
		armor = 10,
		mdef = 15,
		hitrate = 95,
		evasion = 25,
		armorpenetration = 5,
		atk = 55,
		matk = 12,
		speed = 50,
		resists = {},
		status_resists = {stun = 25},
		race = 'humanoid',
		loot = 'bandit_boss_loot',
		icon = "res://assets/images/enemies/bandit_archer.png", 
		skills = ['attack', 'arrowrain', 'wind_atk'],
		traits = ['boss_resists'],
		tags = ['human','bandit'], 
		ai = [['basic', 45], ['ads', 40], ['aoe', 15]],
		ai_hard = [['basic', 85], ['aoe', 50]],
		ai_position = ['ranged'],
		xpreward = 40,
	},
	bandit_boss_mage = {
		code = 'bandit_boss_mage',
		name = '',
		descript = '',
		hpmax = 350,
		armor = 5,
		mdef = 25,
		hitrate = 75,
		evasion = 10,
		armorpenetration = 0,
		atk = 15,
		matk = 60,
		speed = 30,
		resists = {},
		status_resists = {stun = 10},
		race = 'humanoid',
		loot = 'bandit_boss_loot',
		icon = "res://assets/images/enemies/rebel_mage.png", 
		skills = ['attack', 'firearr','lightning', 'light_spell_aoe'],
		traits = ['boss_resists'],
		tags = ['human','bandit'], 
		ai = [['basic', 45], ['ads', 40], ['aoe', 15]],
		ai_hard = [['basic', 85], ['aoe', 50]],
		ai_position = ['ranged'],
		xpreward = 40,
	},
	rebel_recruit = {
		code = 'rebel_recruit',
		name = '',
		descript = '',
		hpmax = 150,
		armor = 5,
		mdef = 5,
		hitrate = 85,
		evasion = 10,
		armorpenetration = 0,
		atk = 31,
		matk = 5,
		speed = 35,
		resists = {},
		status_resists = {},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/rebel_recruit.png", 
		skills = ['attack'],
		traits = [],
		tags = ['human'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_hard = [['basic', 50], ['ads', 50]],
		ai_position = ['melee'],
		xpreward = 10,
	},
	rebel_knight = {
		code = 'rebel_knight',
		name = '',
		descript = '',
		hpmax = 250,
		armor = 25,
		mdef = 0,
		hitrate = 95,
		evasion = 0,
		armorpenetration = 10,
		atk = 55,
		matk = 3,
		speed = 40,
		resists = {fire = -25},
		status_resists = {},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/rebel_knight.png", 
		skills = ['attack','fire_cleave'],
		traits = [],
		tags = ['human'], 
		ai = [['basic', 75], ['aoe', 25]],
		ai_hard = [['basic', 50], ['aoe', 50]],
		ai_position = ['melee'],
		xpreward = 10,
	},
	rebel_mage = {
		code = 'rebel_mage',
		name = '',
		descript = '',
		hpmax = 180,
		armor = 5,
		mdef = 20,
		hitrate = 80,
		evasion = 10,
		armorpenetration = 0,
		atk = 6,
		matk = 51,
		speed = 30,
		resists = {mind = -50},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/rebel_mage.png", 
		skills = ['firearr','ranged_attack','blizzard'],
		traits = [],
		tags = ['human'], 
		ai = [['aoe', 33], ['ads', 66]],
		ai_position = ['ranged'],
		xpreward = 15,
	},
	rebel_healer = {
		code = 'rebel_healer',
		name = '',
		descript = '',
		hpmax = 150,
		armor = 15,
		mdef = 15,
		hitrate = 90,
		evasion = 10,
		armorpenetration = 0,
		atk = 15,
		matk = 35,
		speed = 30,
		resists = {earth = -50},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/rebel_healer.png", 
		skills = ['lesser_heal','attack'],
		traits = [],
		tags = ['human'], 
		ai = [['basic', 25], ['heal', 75]],
		ai_position = ['ranged'],
		xpreward = 15,
	},

	trained_dog = {
		code = 'trained_dog',
		name = '',
		descript = '',
		hpmax = 120,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 25,
		armorpenetration = 0,
		atk = 30,
		matk = 0,
		speed = 45,
		resists = {},
		race = 'beast',
		loot = 'dog_loot',
		icon = "res://assets/images/enemies/dog.png", 
		skills = ['attack'],
		traits = [],
		tags = ['beast'], 
		ai = [['basic', 100],['ads', 0]],
		ai_position = ['melee'],
		xpreward = 10,
	},
	trained_bear = {
		code = 'trained_bear',
		name = '',
		descript = '',
		hpmax = 500,
		armor = 33,
		mdef = 10,
		hitrate = 90,
		evasion = 0,
		armorpenetration = 0,
		atk = 50,
		matk = 0,
		speed = 30,
		resists = {fire = -50},
		race = 'beast',
		loot = 'bear_loot',
		icon = "res://assets/images/enemies/bear.png", 
		skills = ['attack'],
		traits = [],
		tags = ['beast'], 
		ai = [['basic', 100],['ads', 0]],
		ai_position = ['melee'],
		xpreward = 15,
	},
	trained_raptor = {
		code = 'trained_raptor',
		name = '',
		descript = '',
		hpmax = 250,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 30,
		armorpenetration = 0,
		atk = 70,
		matk = 0,
		speed = 50,
		resists = {air = -50},
		race = 'beast',
		loot = 'raptor_loot',
		icon = "res://assets/images/enemies/trained_raptor.png", 
		skills = ['bleeding_strike'],
		traits = [],
		tags = ['beast'], 
		ai = [['basic', 50],['ads', 50]],
		ai_position = ['melee'],
		xpreward = 20,
	},
	guardian_golem = {
		code = 'guardian_golem',
		name = '',
		descript = '',
		hpmax = 650,
		armor = 45,
		mdef = 0,
		hitrate = 80,
		evasion = 0,
		armorpenetration = 0,
		atk = 90,
		matk = 25,
		speed = 30,
		resists = {mind = -50, fire = 50},
		status_resists = {stun = 100, bleed = 100, poison = 100},
		race = 'golem',
		loot = 'guardian_golem_loot',
		icon = "res://assets/images/enemies/guardian_golem.png", 
		skills = [],
		traits = [],
		tags = ['golem'], 
		ai = [['basic', 100],['ads', 0]],
		ai_position = ['melee'],
		xpreward = 25,
	},
	ballista = {
		code = 'ballista',
		name = '',
		descript = '',
		hpmax = 500,
		armor = 25,
		mdef = 10,
		hitrate = 90,
		evasion = 0,
		armorpenetration = 0,
		atk = 55,
		matk = 5,
		speed = 25,
		resists = {fire = -100, earth = 50},
		status_resists = {stun = 100, bleed = 100, poison = 100},
		race = 'mech',
		loot = 'ballista_loot',
		icon = "res://assets/images/enemies/ballista.png", 
		skills = ['ranged_attack'],
		traits = [],
		tags = ['mech'], 
		ai = [['basic', 50],['ads', 50]],
		ai_position = ['ranged'],
		xpreward = 20,
	},
	bandit_mage = {
		code = 'bandit_mage',
		name = '',
		descript = '',
		hpmax = 350,
		armor = 0,
		mdef = 30,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 0,
		atk = 10,
		matk = 65,
		speed = 30,
		resists = {},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/bandit_mage.png", 
		skills = ['firearr', 'mindblast','wind_blade'],
		traits = [],
		tags = ['human','bandit'], 
		ai = [['ads', 45], ['aoe', 45], ['support', 10]], #add healing on self when hp < 50 with 75% chance
		ai_position = ['ranged'],
		xpreward = 15,
	},
	cave_goblin_melee = {
		code = 'cave_goblin_melee',
		name = '',
		descript = '',
		hpmax = 55,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 25,
		armorpenetration = 0,
		atk = 15,
		matk = 5,
		speed = 30,
		resists = {},
		race = 'humanoid',
		loot = 'goblin_loot',
		icon = "res://assets/images/enemies/goblin.png", 
		skills = [],
		traits = [],
		tags = ['goblin'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 7,
	},
	cave_goblin_archer = {
		code = 'cave_goblin_archer',
		name = '',
		descript = '',
		hpmax = 50,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 20,
		armorpenetration = 0,
		atk = 20,
		matk = 5,
		speed = 35,
		resists = {},
		race = 'humanoid',
		loot = 'goblin_loot',
		icon = "res://assets/images/enemies/goblin_archer.png", 
		skills = ['ranged_attack'],
		traits = [],
		tags = ['goblin'], 
		ai = [['basic', 100]],
		ai_position = ['ranged'],
		xpreward = 10,
	},
	cave_goblin_mage = {
		code = 'cave_goblin_mage',
		name = '',
		descript = '',
		hpmax = 45,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 25,
		armorpenetration = 0,
		atk = 10,
		matk = 25,
		speed = 25,
		resists = {},
		traits = [],
		race = 'humanoid',
		loot = 'goblin_loot',
		icon = "res://assets/images/enemies/goblin_mage.png", 
		skills = ['firearr'],
		tags = ['goblin'], 
		ai = [['ads', 100]],
		ai_position = ['ranged'],
		xpreward = 10,
	},
	cave_goblin_boss = {
		code = 'cave_goblin_boss',
		name = '',
		descript = '',
		hpmax = 250,
		armor = 20,
		mdef = 10,
		hitrate = 85,
		evasion = 10,
		armorpenetration = 0,
		atk = 40,
		matk = 5,
		speed = 40,
		resists = {},
		race = 'humanoid',
		loot = 'goblin_loot',
		icon = "res://assets/images/enemies/goblin_boss.png", 
		skills = [],
		traits = ['boss_resists'],
		tags = ['goblin'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 20,
	},
	cave_goblin_shaman = {
		code = 'cave_goblin_shaman',
		name = '',
		descript = '',
		hpmax = 160,
		armor = 5,
		mdef = 30,
		hitrate = 85,
		evasion = 10,
		armorpenetration = 0,
		atk = 20,
		matk = 5,
		speed = 40,
		resists = {},
		race = 'humanoid',
		loot = 'goblin_loot',
		icon = "res://assets/images/enemies/goblin_mage.png", 
		skills = ['attack','firearr'],
		traits = ['boss_resists'],
		tags = ['goblin'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['ranged'],
		xpreward = 20,
	},
	
	quest_goblin_boss = {
		code = 'quest_goblin_boss',
		name = '',
		descript = '',
		hpmax = 200,
		armor = 20,
		mdef = 10,
		hitrate = 85,
		evasion = 10,
		armorpenetration = 0,
		atk = 40,
		matk = 15,
		speed = 40,
		resists = {},
		race = 'humanoid',
		loot = 'goblin_loot',
		icon = "res://assets/images/enemies/goblin_boss.png", 
		skills = [],
		traits = ['boss_resists'],
		tags = ['goblin'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 20,
	},
	quest_goblin_shaman = {
		code = 'quest_goblin_shaman',
		name = '',
		descript = '',
		hpmax = 150,
		armor = 5,
		mdef = 30,
		hitrate = 85,
		evasion = 10,
		armorpenetration = 0,
		atk = 30,
		matk = 50,
		speed = 40,
		resists = {},
		race = 'humanoid',
		loot = 'goblin_loot',
		icon = "res://assets/images/enemies/goblin_mage.png", 
		skills = ['attack','firearr'],
		traits = ['boss_resists'],
		tags = ['goblin'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['ranged'],
		xpreward = 20,
	},
	
	ogre_melee = {
		code = 'ogre_melee',
		name = '',
		descript = '',
		hpmax = 500,
		armor = 45,
		mdef = 0,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 0,
		atk = 69,
		matk = 10,
		speed = 35,
		resists = {fire = 50, air = -50},
		status_resists = {stun = 50},
		race = 'giant',
		loot = 'ogre_loot',
		icon = "res://assets/images/enemies/ogre.png", 
		skills = [],
		traits = [],
		tags = ['ogre'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 20,
	},
	ogre_mage = {
		code = 'ogre_mage',
		name = '',
		descript = '',
		hpmax = 400,
		armor = 30,
		mdef = 30,
		hitrate = 80,
		evasion = 0,
		armorpenetration = 0,
		atk = 35,
		matk = 45,
		speed = 25,
		resists = {fire = 50, air = -50},
		status_resists = {stun = 30},
		race = 'giant',
		loot = 'ogre_loot',
		icon = "res://assets/images/enemies/ogre_mage.png", 
		skills = ['magicward'],
		traits = [],
		tags = ['ogre'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['ranged'],
		xpreward = 25,
	},
	troll = {
		code = 'troll',
		name = '',
		descript = '',
		hpmax = 600,
		armor = 35,
		mdef = 20,
		hitrate = 100,
		evasion = 10,
		armorpenetration = 15,
		atk = 90,
		matk = 5,
		speed = 40,
		resists = {fire = -50, earh = 50},
		race = 'giant',
		loot = 'troll_loot',
		icon = "res://assets/images/enemies/troll.png", 
		skills = [],
		traits = [],
		tags = ['troll'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 50,
	},
	skeleton_melee = {
		code = 'skeleton_melee',
		name = '',
		descript = '',
		hpmax = 220,
		armor = 25,
		mdef = 10,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 0,
		atk = 47,
		matk = 5,
		speed = 55,
		resists = {light = -100, dark = 25},
		status_resists = {bleed = 1000},
		race = 'undead',
		loot = 'skeleton_melee_loot',
		icon = "res://assets/images/enemies/skeleton_warrior.png", 
		skills = [],
		traits = [],
		tags = ['undead'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 10,
	},
	skeleton_shield_melee = {
		code = 'skeleton_shield_melee',
		name = '',
		descript = '',
		hpmax = 115,
		armor = 20,
		mdef = 20,
		hitrate = 75,
		evasion = 0,
		armorpenetration = 0,
		atk = 31,
		matk = 5,
		speed = 40,
		resists = {light = -100, dark = 25},
		status_resists = {bleed = 1000},
		race = 'undead',
		loot = 'skeleton_melee_loot',
		icon = "res://assets/images/enemies/skeleton_warrior.png", 
		skills = [],
		traits = ['enemy_defender'],
		tags = ['undead'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 10,
	},
	skeleton_archer = {
		code = 'skeleton_archer',
		name = '',
		descript = '',
		hpmax = 160,
		armor = 0,
		mdef = 15,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 10,
		atk = 60,
		matk = 5,
		speed = 65,
		resists = {light = -100, dark = 25},
		status_resists = {bleed = 1000},
		race = 'undead',
		loot = 'skeleton_archer_loot',
		icon = "res://assets/images/enemies/skeleton_archer.png", 
		skills = ['ranged_attack'],
		traits = [],
		tags = ['undead'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['ranged'],
		xpreward = 10,
	},
	skeleton_archer_quest = {
		code = 'skeleton_archer_quest',
		name = '',
		descript = '',
		hpmax = 80,
		armor = 0,
		mdef = 5,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 10,
		atk = 30,
		matk = 5,
		speed = 50,
		resists = {light = -100, dark = 25},
		status_resists = {bleed = 1000},
		race = 'undead',
		loot = 'skeleton_archer_loot',
		icon = "res://assets/images/enemies/skeleton_archer.png", 
		skills = ['ranged_attack'],
		traits = [],
		tags = ['undead'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['ranged'],
		xpreward = 10,
	},
	zombie = {
		code = 'zombie',
		name = '',
		descript = '',
		hpmax = 300,
		armor = 15,
		mdef = 5,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 0,
		atk = 30,
		matk = 5,
		speed = 35,
		resists = {fire = -50, light = -100, dark = 50},
		status_resists = {poison = 90},
		race = 'undead',
		loot = 'zombie_loot',
		icon = "res://assets/images/enemies/zombie.png", 
		skills = [],
		traits = [],
		tags = ['undead'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 10,
	},
	undead_lich = {
		code = 'undead_lich',
		name = '',
		descript = '',
		hpmax = 750,
		armor = 12,
		mdef = 27,
		hitrate = 90,
		evasion = 0,
		armorpenetration = 0,
		atk = 20,
		matk = 75,
		speed = 45,
		resists = {light = -50, dark = 50},
		status_resists = {bleed = 1000},
		race = 'undead',
		loot = 'lich_loot',
		icon = "res://assets/images/enemies/lich.png", 
		skills = ['decay'],
		traits = ['boss_resists'],
		tags = ['undead'], 
		ai = [['aoe', 33], ['ads', 66]],
		ai_hard = [['basic', 50], ['ads', 50]],
		ai_position = ['ranged'],
		xpreward = 35,
	},
	lich_quest = {
		code = 'lich_quest',
		name = '',
		descript = '',
		hpmax = 250,
		armor = 10,
		mdef = 30,
		hitrate = 90,
		evasion = 10,
		armorpenetration = 0,
		atk = 40,
		matk = 55,
		speed = 40,
		resists = {light = -50, dark = 50},
		status_resists = {bleed = 1000},
		race = 'undead',
		loot = 'quest_lich_loot',
		icon = "res://assets/images/enemies/lich.png", 
		skills = ['decay'],
		traits = ['boss_resists'],
		tags = ['undead'], 
		ai = [['aoe', 33], ['ads', 66]],
		ai_hard = [['basic', 50], ['ads', 50]],
		ai_position = ['ranged'],
		xpreward = 35,
	},
	wolf = {
		code = 'wolf',
		name = '',
		descript = '',
		hpmax = 80,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 0,
		atk = 25,
		matk = 2,
		speed = 30,
		resists = {fire = -25},
		race = 'beast',
		loot = 'wolf_loot',
		icon = "res://assets/images/enemies/wolf.png", 
		skills = [],
		traits = [],
		tags = ['beast'], 
		ai = [['basic', 100]],
		ai_position = ['melee'],
		xpreward = 5,
	},
	spider_weak = {
		code = 'spider_weak',
		name = '',
		descript = '',
		hpmax = 40,
		armor = 0,
		mdef = 5,
		hitrate = 80,
		evasion = 15,
		armorpenetration = 0,
		atk = 20,
		matk = 6,
		speed = 35,
		resists = {},
		race = 'beast',
		loot = 'spider_loot',
		icon = "res://assets/images/enemies/spider_1.png", 
		skills = ['poison_bite_s'],
		traits = [],
		tags = ['insect'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 7,
	},
	spider = {
		code = 'spider',
		name = '',
		descript = '',
		hpmax = 200,
		armor = 20,
		mdef = 20,
		hitrate = 80,
		evasion = 40,
		armorpenetration = 40,
		atk = 90,
		matk = 6,
		speed = 50,
		resists = {},
		race = 'beast',
		loot = 'spider_loot',
		icon = "res://assets/images/enemies/spider_1.png", 
		skills = ['poison_bite_s'],
		traits = [],
		tags = ['insect'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 7,
	},
	willowisp = {
		code = 'willowisp',
		name = '',
		descript = '',
		hpmax = 50,
		armor = 0,
		mdef = 0,
		hitrate = 95,
		evasion = 0,
		armorpenetration = 0,
		atk = 10,
		matk = 30,
		speed = 30,
		resists = {fire = 150, water = -50},
		race = 'demon',
		loot = 'willowisp_loot',
		icon = "res://assets/images/enemies/willowisp.png", 
		skills = ['firearr','malediction'],
		traits = [],
		tags = ['demon'], 
		ai = [['ads', 100]],
		ai_position = ['ranged'],
		xpreward = 7,
	},
	spider_ranged = {
		code = 'spider_ranged',
		name = '',
		descript = '',
		hpmax = 140,
		armor = 20,
		mdef = 20,
		hitrate = 95,
		evasion = 50,
		armorpenetration = 20,
		atk = 80,
		matk = 40,
		speed = 30,
		resists = {},
		race = 'beast',
		loot = 'spider_loot',
		icon = "res://assets/images/enemies/spider_1.png", 
		skills = ['spider_ranged','darkness'],
		traits = [],
		tags = ['insect'], 
		ai = [['basic', 0], ['ads', 100]],
		ai_position = ['ranged'],
		xpreward = 7,
	},
	spider_aoe = {
		code = 'spider_aoe',
		name = '',
		descript = '',
		hpmax = 120,
		armor = 20,
		mdef = 30,
		hitrate = 80,
		evasion = 60,
		armorpenetration = 15,
		atk = 40,
		matk = 30,
		speed = 30,
		resists = {},
		race = 'beast',
		loot = 'spider_loot',
		icon = "res://assets/images/enemies/spider_1.png", 
		skills = ['spider_aoe'],
		traits = [],
		tags = ['insect'], 
		ai = [['basic', 33], ['ads', 66]],
		ai_position = ['ranged'],
		xpreward = 7,
	},
	spider_alfa_boss = {
		code = 'spider_alfa_boss',
		name = '',
		descript = '',
		hpmax = 1000,
		armor = 70,
		mdef = 40,
		hitrate = 150,
		evasion = 70,
		armorpenetration = 70,
		atk = 70,
		matk = 6,
		speed = 60,
		resists = {},
		race = 'beast',
		loot = 'spider_loot',
		icon = "res://assets/images/enemies/spider_boss.png", 
		skills = ['poison_bite', 'entangle_sa'],
		traits = ['boss_resists'],
		tags = ['insect'], 
		ai = [['basic', 50], ['ads', 50]],
		ai_position = ['melee'],
		xpreward = 20,
	},
		spider_queen_boss = {
		code = 'spider_queen_boss',
		name = '',
		descript = '',
		hpmax = 800,
		armor = 60,
		mdef = 40,
		hitrate = 150,
		evasion = 80,
		armorpenetration = 50,
		atk = 90,
		matk = 70,
		speed = 60,
		resists = {},
		race = 'beast',
		loot = 'spider_loot',
		icon = "res://assets/images/enemies/spider_matriarch.png", 
		skills = ['sticky_web', 'disarm_enemy_sq'],
		traits = ['boss_resists'],
		tags = ['insect'], 
		ai = [['basic', 33], ['ads', 66]],
		ai_position = ['ranged'],
		xpreward = 20,
	},
	rat = {
		code = 'rat',
		name = '',
		descript = '',
		hpmax = 30,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 0,
		atk = 15,
		matk = 1,
		speed = 30,
		resists = {},
		race = 'beast',
		loot = 'rat_loot',
		icon = "res://assets/images/enemies/enemy_rat.png", 
		skills = [],
		traits = [],
		tags = ['beast'], 
		ai = [['basic', 100]],
		ai_position = ['melee'],
		xpreward = 5,
	},
	gryphon = {
		code = 'gryphon',
		name = '',
		descript = '',
		hpmax = 2500,
		armor = 30,
		mdef = 40,
		hitrate = 120,
		evasion = 40,
		armorpenetration = 10,
		atk = 150,
		matk = 30,
		speed = 50,
		resists = {air = 50, fire = -25, earth = -50},
		status_resists = {stun = 75, disarm = 90},
		race = 'beast',
		loot = 'gryphon_loot',
		icon = "res://assets/images/enemies/gryphon.png", 
		skills = ['windblast','swipe_en'],
		traits = ['boss_resists'],
		tags = ['beast'], 
		ai = [['basic', 50],['ads',50]],
		ai_position = ['melee'],
		xpreward = 50,
	},
	elder_gryphon_boss = {
		code = 'elder_gryphon_boss',
		name = '',
		descript = '',
		hpmax = 1750,
		armor = 40,
		mdef = 30,
		hitrate = 135,
		evasion = 40,
		armorpenetration = 15,
		atk = 150,
		matk = 30,
		speed = 45,
		resists = {air = 50, fire = -25, earth = -50},
		status_resists = {stun = 75, disarm = 90},
		race = 'beast',
		loot = 'gryphon_loot',
		icon = "res://assets/images/enemies/gryphon.png", 
		skills = ['windblast','swipe_en'],
		traits = ['boss_resists'],
		tags = ['beast'], 
		ai = [['basic', 50],['ads',50]],
		ai_position = ['melee'],
		xpreward = 75,
	},

	mimic = {
		code = 'mimic',
		name = '',
		descript = '',
		hpmax = 200,
		armor = 50,
		mdef = 75,
		hitrate = 120,
		evasion = 10,
		armorpenetration = 25,
		atk = 110,
		matk = 20,
		speed = 40,
		resists = {fire = -50, air = 50},
		status_resists = {stun = 50, bleed = 100, poison = 100},
		race = 'monster',
		loot = 'mimic_loot',
		icon = 'res://assets/images/enemies/mimic.png', 
		skills = ['mimic_attack'],
		traits = ['boss_resists'],
		tags = ['monster'], 
		ai = [['basic', 50], ['ads', 50]],
		ai_position = ['melee'],
		xpreward = 50,
	},


	salamander = {
		code = 'salamander',
		name = '',
		descript = '',
		hpmax = 900,
		armor = 75,
		mdef = 40,
		hitrate = 110,
		evasion = 20,
		armorpenetration = 20,
		atk = 90,
		matk = 20,
		speed = 50,
		resists = {fire = 75, water = -50},
		race = 'beast',
		loot = 'salamander_loot',
		icon = "res://assets/images/enemies/salamander.png", 
		skills = ['growl'],
		traits = [],
		tags = ['beast'], 
		ai = [['basic', 50],['aoe', 50]],
		ai_position = ['melee'],
		xpreward = 15,
	},
	rock_thrower = {
		code = 'rock_thrower',
		name = '',
		descript = '',
		hpmax = 750,
		armor = 120,
		mdef = 25,
		hitrate = 140,
		evasion = 0,
		armorpenetration = 0,
		atk = 70,
		matk = 25,
		speed = 40,
		resists = {earth = 50},
		status_resists = {stun = 75, bleed = 100, poison = 100},
		race = 'beast',
		loot = 'rockthrower_loot',
		icon = "res://assets/images/enemies/golem_1.png", 
		skills = [],
		traits = [],
		tags = ['golem'], 
		ai = [['basic', 100]],
		ai_position = ['ranged'],
		xpreward = 15,
	},
	maneater_plant = {
		code = 'maneater_plant',
		name = '',
		descript = '',
		hpmax = 600,
		armor = 40,
		mdef = 15,
		hitrate = 120,
		evasion = 0,
		armorpenetration = 0,
		atk = 60,
		matk = 25,
		speed = 40,
		resists = {earth = 50, fire = -50},
		race = 'plant',
		loot = 'maneater_loot',
		icon = "res://assets/images/enemies/maneater_plant.png", 
		skills = ['entangle_enemy','poison_spray'],
		traits = [],
		tags = ['plant'], 
		ai = [['basic', 20],['ads',40],['aoe',40]],
		ai_position = ['any'],
		xpreward = 15,
	},

	giant_ant = {
		code = 'giant_ant',
		name = '',
		descript = '',
		hpmax = 400,
		armor = 30,
		mdef = 15,
		hitrate = 80,
		evasion = 25,
		armorpenetration = 10,
		atk = 45,
		matk = 10,
		speed = 50,
		resists = {fire = 25, earth = 25},
		race = 'beast',
		loot = 'ant_loot',
		icon = "res://assets/images/enemies/giant_ant.png", 
		skills = [],
		traits = [],
		tags = ['insect'], 
		ai = [['basic', 100]],
		ai_position = ['any'],
		xpreward = 10,
	},
	wild_raptor =  {
		code = 'wild_raptor',
		name = '',
		descript = '',
		hpmax = 450,
		armor = 15,
		mdef = 35,
		hitrate = 115,
		evasion = 10,
		armorpenetration = 15,
		atk = 69,
		matk = 25,
		speed = 60,
		resists = {},
		race = 'beast',
		loot = 'raptor_loot',
		icon = "res://assets/images/enemies/raptor.png", 
		skills = [],
		traits = [],
		tags = ['beast'], 
		ai = [['basic', 100]],
		ai_position = ['any'],
		xpreward = 15,
	},
	centipede = {
		code = 'centipede',
		name = '',
		descript = '',
		hpmax = 700,
		armor = 45,
		mdef = 12,
		hitrate = 140,
		evasion = 0,
		armorpenetration = 0,
		atk = 130,
		matk = 45,
		speed = 35,
		resists = {air = 50},
		race = 'beast',
		loot = 'centipede_loot',
		icon = "res://assets/images/enemies/centipede.png", 
		skills = ['poison_bite'],
		traits = ['absorb_atk_trait'],
		tags = ['insect'], 
		ai = [['basic', 25],['ads',75]],
		ai_position = ['any'],
		xpreward = 20,
	},
	ogre_alpha = {
		code = 'ogre_alpha',
		name = '',
		descript = '',
		hpmax = 2000,
		armor = 50,
		mdef = 45,
		hitrate = 110,
		evasion = 0,
		armorpenetration = 20,
		atk = 110,
		matk = 44,
		speed = 50,
		resists = {},
		status_resists = {stun = 70},
		race = 'giant',
		loot = 'ogre_alpha_loot',
		icon = "res://assets/images/enemies/ogre_alpha.png", 
		skills = ['shred'],
		traits = ['boss_resists'],
		tags = ['ogre'], 
		ai = [['basic', 30],['ads',70]],
		ai_position = ['ranged'],
		xpreward = 100,
	},
	great_viper = {
		code = 'great_viper',
		name = '',
		descript = '',
		hpmax = 2100,
		armor = 15,
		mdef = 55,
		hitrate = 150,
		evasion = 15,
		armorpenetration = 0,
		atk = 91,
		matk = 25,
		speed = 40,
		resists = {earh = 25},
		status_resists = {stun = 75, poison = 100},
		race = 'beast',
		loot = 'great_viper_loot',
		icon = "res://assets/images/enemies/viper.png", 
		skills = [],
		traits = ['boss_resists'],
		tags = ['beast'], 
		ai = [['basic', 100]],
		ai_position = ['any'],
		xpreward = 100,
	},
	anthropoid = {
		code = 'anthropoid',
		name = '',
		descript = '',
		hpmax = 600,
		armor = 40,
		mdef = 15,
		hitrate = 120,
		evasion = 0,
		armorpenetration = 0,
		atk = 66,
		matk = 25,
		speed = 40,
		resists = {earth = 50},
		status_resists = {stun = 75},
		race = 'beast',
		loot = 'anthropoid_loot',
		icon = "res://assets/images/enemies/GolemIcon.png", 
		skills = [],
		traits = [],
		tags = ['golem'], 
		ai = [['basic', 100]],
		ai_position = ['any'],
		xpreward = 15,
	},
	ifrit = {
		code = 'ifrit',
		name = '',
		descript = '',
		hpmax = 1100,
		armor = 40,
		mdef = 70,
		hitrate = 120,
		evasion = 0,
		armorpenetration = 0,
		atk = 54,
		matk = 41,
		speed = 40,
		resists = {fire = 150, water = -50},
		status_resists = {freeze = 90},
		race = 'demon',
		loot = 'ifrit_loot',
		icon = "res://assets/images/enemies/ifrit.png", 
		skills = ['firearr'],
		traits = ['fireshield_trait'],
		tags = ['demon'], 
		ai = [['basic', 30],['ads',70]],
		ai_position = ['any'],
		xpreward = 15,
	},
	magma_beast = {
		code = 'magma_beast',
		name = '',
		descript = '',
		hpmax = 2500,
		armor = 70,
		mdef = 60,
		hitrate = 110,
		evasion = 30,
		armorpenetration = 30,
		atk = 105,
		matk = 65,
		speed = 45,
		resists = {fire = 75, water = -50},
		status_resists = {stun = 80},
		race = 'beast',
		loot = 'magma_beast_loot',
		icon = "res://assets/images/enemies/magma_beast.png", 
		skills = ['fire_burst'],
		traits = ['boss_resists'],
		tags = ['beast'], 
		ai = [['aoe', 100]],
		ai_position = ['ranged'],
		xpreward = 100,
	},
	erebus_stone = {
		code = 'erebus_stone',
		name = '',
		descript = '',
		hpmax = 2000,
		armor = 120,
		mdef = 75,
		hitrate = 100,
		evasion = 0,
		armorpenetration = 0,
		atk = 130,
		matk = 95,
		speed = 30,
		resists = {earth = 90, neutral = 50, air = -25},
		status_resists = {stun = 75, bleed = 100, poison = 100},
		race = 'mech',
		loot = 'erebus_stone_loot',
		icon = "res://assets/images/enemies/erebus_stone.png", 
		skills = ['voidslam','hammerfall'],
		traits = ['atkpass_trait','boss_resists'],
		tags = ['mech'], 
		ai = [['basic', 25],['ads', 75]],
		ai_position = ['ranged'],
		xpreward = 50,
	},
	
	dwarf_fighter = {
		code = 'dwarf_fighter',
		name = '',
		descript = '',
		hpmax = 750,
		armor = 60,
		mdef = 45,
		hitrate = 95,
		evasion = 30,
		armorpenetration = 0,
		atk = 41,
		matk = 5,
		speed = 45,
		resists = {},
		status_resists = {},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/dwarf fighter.png", 
		skills = ['attack','sunder'],
		traits = [],
		tags = ['human'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_hard = [['basic', 50], ['ads', 50]],
		ai_position = ['melee'],
		xpreward = 15,
	},
	dwarf_fighter_elite = {
		code = 'dwarf_fighter_elite',
		name = '',
		descript = '',
		hpmax = 1000,
		armor = 95,
		mdef = 55,
		hitrate = 135,
		evasion = 25,
		armorpenetration = 15,
		atk = 56,
		matk = 5,
		speed = 40,
		resists = {},
		status_resists = {},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/dwarf fighter.png", 
		skills = ['attack','sunder','fire_cleave'],
		traits = [],
		tags = ['human'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_hard = [['basic', 50], ['ads', 50]],
		ai_position = ['melee'],
		xpreward = 25,
	},
	dwarf_ranged = {
		code = 'dwarf_ranged',
		name = '',
		descript = '',
		hpmax = 800,
		armor = 25,
		mdef = 40,
		hitrate = 110,
		evasion = 20,
		armorpenetration = 0,
		atk = 68,
		matk = 5,
		speed = 40,
		resists = {},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/dwarf crossbow.png", 
		skills = ['ranged_attack','arrow_hail'],
		traits = [],
		tags = ['human'], 
		ai = [['basic', 100]],
		ai_position = ['ranged'],
		xpreward = 10,
	},

	#quest enemies


	greg = {
		code = 'greg',
		name = '',
		descript = '',
		hpmax = 750,
		armor = 35,
		mdef = 50,
		hitrate = 120,
		evasion = 20,
		armorpenetration = 25,
		atk = 100,
		matk = 5,
		speed = 45,
		resists = {},
		status_resists = {stun = 100, freeze = 90},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/greg_enemy.png", 
		skills = [],
		traits = ['boss_resists'],
		tags = ['human','boss'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 100,
	},
	aire = {
		code = 'aire',
		name = '',
		descript = '',
		hpmax = 1000,
		armor = 25,
		mdef = 45,
		hitrate = 150,
		evasion = 40,
		armorpenetration = 35,
		atk = 95,
		matk = 40,
		speed = 55,
		resists = {},
		status_resists = {stun = 75, freeze = 75},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/aire_enemy.png", 
		skills = ['explosivearr','arrowrain'],
		traits = ['boss_resists'],
		tags = ['human','boss'], 
		ai = [['ads', 33],['aoe',33], ['ads', 33]],
		ai_position = ['ranged'],
		xpreward = 100,
	},
	demoness = {
		code = 'demoness',
		name = '',
		descript = '',
		hpmax = 400,
		armor = 15,
		mdef = 80,
		hitrate = 100,
		evasion = 20,
		armorpenetration = 10,
		atk = 50,
		matk = 75,
		speed = 40,
		resists = {light = -25},
		status_resists = {stun = 100, freeze = 100},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/demon_enemy.png", 
		skills = ['shadowstrike','decay','voidslam'],
		traits = [],
		tags = ['human','demon','boss'],
		gear = ['boss_resists'],
		ai = [['ads', 33],['aoe',33], ['basic', 33]],
		ai_position = ['ranged'],
		xpreward = 50,
	},
	
	lilith_boss = {
		code = 'lilith_boss',
		name = '',
		descript = '',
		hpmax = 750,
		armor = 35,
		mdef = 45,
		hitrate = 120,
		evasion = 30,
		armorpenetration = 25,
		atk = 50,
		matk = 75,
		speed = 50,
		resists = {light = -50, dark = 75},
		status_resists = {stun = 100, freeze = 100},
		race = 'demon',
		loot = 'erebus_stone_loot',
		icon = "res://assets/images/enemies/lilith_boss.png", 
		skills = ['shadowstrike','decay','voidslam'],
		traits = ['boss_resists'],
		tags = ['human','boss'], 
		ai = [['ads', 33],['aoe',33], ['basic', 33]],
		ai_position = ['ranged'],
		xpreward = 50,
	},
	lilith_boss_2 = {
		code = 'lilith_boss_2',
		name = '',
		descript = '',
		hpmax = 1200,
		armor = 55,
		mdef = 65,
		hitrate = 120,
		evasion = 30,
		armorpenetration = 25,
		atk = 70,
		matk = 120,
		speed = 65,
		resists = {light = -50, dark = 75},
		status_resists = {stun = 100, freeze = 100},
		race = 'demon',
		loot = 'erebus_stone_loot',
		icon = "res://assets/images/enemies/lilith_boss.png", 
		skills = ['shadowstrike','decay','voidslam'],
		traits = ['boss_resists'],
		tags = ['human','boss'], 
		ai = [['ads', 33],['aoe',33], ['basic', 33]],
		ai_position = ['ranged'],
		xpreward = 50,
	},
	kurdan = {
		code = 'kurdan',
		name = '',
		descript = '',
		hpmax = 400,
		armor = 10,
		mdef = 25,
		hitrate = 90,
		evasion = 10,
		armorpenetration = 10,
		atk = 30,
		matk = 45,
		speed = 35,
		resists = {},
		status_resists = {stun = 50, freeze = 50},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/kurdan_enemy.png", 
		skills = ['entangle','firearr'],
		traits = ['boss_resists'],
		tags = ['human','boss'], 
		ai = [['ads', 66],['basic', 33]],
		ai_position = ['ranged'],
		xpreward = 25,
	},
	
	leon = {
		code = 'leon',
		name = '',
		descript = '',
		hpmax = 1000,
		armor = 35,
		mdef = 25,
		hitrate = 140,
		evasion = 40,
		armorpenetration = 15,
		atk = 130,
		matk = 45,
		speed = 75,
		resists = {},
		status_resists = {stun = 75, freeze = 50},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/enemy_leon.png", 
		skills = ['attack','swipe_en'],
		traits = ['boss_resists'],
		tags = ['human','boss'], 
		ai = [['ads', 66],['basic', 33]],
		ai_position = ['melee'],
		xpreward = 100,
	},
	
	kuro = {
		code = 'kuro',
		name = '',
		descript = '',
		hpmax = 1350,
		armor = 15,
		mdef = 90,
		hitrate = 120,
		evasion = 60,
		armorpenetration = 30,
		atk = 40,
		matk = 115,
		speed = 55,
		resists = {light = -50},
		status_resists = {stun = 100, freeze = 100},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/kuro.png", 
		skills = ['shadowstrike','void','void_barrage'],
		traits = ['boss_resists'],
		tags = ['human','boss'], 
		ai = [['ads', 33],['aoe',33], ['basic', 33]],
		ai_position = ['ranged'],
		xpreward = 50,
	},
	
	white_stag = {
		code = 'white_stag',
		name = '',
		descript = '',
		hpmax = 900,
		armor = 15,
		mdef = 55,
		hitrate = 120,
		evasion = 20,
		armorpenetration = 0,
		atk = 140,
		matk = 90,
		speed = 50,
		resists = {air = 50},
		status_resists = {stun = 100, freeze = 100},
		race = 'beast',
		loot = 'white_stag_loot',
		icon = "res://assets/images/enemies/white_stag.png", 
		skills = ['attack'],
		traits = ['boss_resists'],
		tags = ['boss'], 
		ai = [['ads', 66],['basic', 33]],
		ai_position = ['melee'],
		xpreward = 100,
	},
	white_stag_human = {
		code = 'white_stag_human',
		name = '',
		descript = '',
		hpmax = 600,
		armor = 20,
		mdef = 30,
		hitrate = 110,
		evasion = 20,
		armorpenetration = 0,
		atk = 120,
		matk = 75,
		speed = 50,
		resists = {air = 25, fire = 50},
		status_resists = {stun = 100, freeze = 100},
		race = 'beast',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/white_stag_human.png", 
		skills = ['attack','shadowstrike','voidslam','enemy_slash'],
		traits = ['boss_resists'],
		tags = ['boss'], 
		ai = [['ads', 66],['basic', 33]],
		ai_position = ['melee'],
		xpreward = 100,
	},
	elf_specter = {
		code = 'elf_specter',
		name = '',
		descript = '',
		hpmax = 500,
		armor = 25,
		mdef = 15,
		hitrate = 105,
		evasion = 0,
		armorpenetration = 0,
		atk = 85,
		matk = 3,
		speed = 40,
		resists = {neutral = 85, light = -100, dark = -50},
		status_resists = {},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/elf_specter.png", 
		skills = ['attack','fire_cleave'],
		traits = [],
		tags = ['undead'], 
		ai = [['basic', 75], ['aoe', 25]],
		ai_hard = [['basic', 50], ['aoe', 50]],
		ai_position = ['melee'],
		xpreward = 20,
	},
	elf_soldier = {
		code = 'elf_soldier',
		name = '',
		descript = '',
		hpmax = 750,
		armor = 35,
		mdef = 25,
		hitrate = 95,
		evasion = 25,
		armorpenetration = 0,
		atk = 75,
		matk = 30,
		speed = 40,
		resists = {},
		status_resists = {},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/elf_warrior.png", 
		skills = ['attack','fire_cleave'],
		traits = [],
		tags = [], 
		ai = [['basic', 75], ['aoe', 25]],
		ai_hard = [['basic', 50], ['aoe', 50]],
		ai_position = ['melee'],
		xpreward = 20,
	},
	ramont_boss = {#daisy quest option
		code = 'ramont_boss',
		name = '',
		descript = '',
		hpmax = 500,
		armor = 50,
		mdef = 65,
		hitrate = 110,
		evasion = 10,
		armorpenetration = 35,
		atk = 125,
		matk = 5,
		speed = 45,
		resists = {},
		status_resists = {stun = 100, freeze = 90},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/bandit_boss.png", 
		skills = [],
		traits = ['boss_resists'],
		tags = ['human','boss'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 100,
	},
	hector_boss = {#cali quest option !!! copied from above, needs fixing
		code = 'hector_boss',
		name = '',
		descript = '',
		hpmax = 800,
		armor = 50,
		mdef = 65,
		hitrate = 110,
		evasion = 10,
		armorpenetration = 35,
		atk = 142,
		matk = 5,
		speed = 45,
		resists = {},
		status_resists = {stun = 100, freeze = 90},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = "res://assets/images/enemies/bandit_boss.png", 
		skills = [],
		traits = ['boss_resists'],
		tags = ['human','boss'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 100,
	},
	
	
	summon_skeleton_melee = {
		code = 'summon_skeleton_melee',
		name = '',
		descript = '',
		hpmax = 250,
		armor = 20,
		mdef = 10,
		hitrate = 90,
		evasion = 0,
		armorpenetration = 0,
		atk = 65,
		matk = 5,
		speed = 30,
		resists = {light = -50},
		status_resists = {bleed = 1000},
		race = 'undead',
		loot = 'skeleton_melee_loot',
		icon = "res://assets/images/enemies/skeleton_warrior.png", 
		skills = [],
		traits = [],
		tags = ['undead'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['melee'],
		xpreward = 10,
	},
	summon_skeleton_archer = {
		code = 'summon_skeleton_archer',
		name = '',
		descript = '',
		hpmax = 200,
		armor = 5,
		mdef = 10,
		hitrate = 90,
		evasion = 0,
		armorpenetration = 10,
		atk = 90,
		matk = 5,
		speed = 40,
		resists = {light = -50},
		status_resists = {bleed = 1000},
		race = 'undead',
		loot = 'skeleton_archer_loot',
		icon = "res://assets/images/enemies/skeleton_archer.png", 
		skills = ['ranged_attack'],
		traits = [],
		tags = ['undead'], 
		ai = [['basic', 66], ['ads', 33]],
		ai_position = ['ranged'],
		xpreward = 10,
	},
	
	summon_dog = {
		code = 'summon_dog',
		name = '',
		descript = '',
		hpmax = 125,
		armor = 15,
		mdef = 10,
		hitrate = 90,
		evasion = 10,
		armorpenetration = 0,
		atk = 35,
		matk = 0,
		speed = 45,
		resists = {},
		race = 'beast',
		loot = 'dog_loot',
		icon = "res://assets/images/enemies/dog.png", 
		skills = ['attack'],
		traits = [],
		tags = ['beast'], 
		ai = [['basic', 100],['ads', 0]],
		ai_position = ['melee'],
		xpreward = 10,
	},
	
}

var summons = {
	summon_skeletons = {
		summon = ['summon_skeleton_melee', 'summon_skeleton_archer'],
		amount = [{stat = 'magic_factor', mod = 0.5}]
	},
	summon_dog = {
		summon = ['summon_dog',null],
		amount = [1]
	}
}



var loot_variants_data = {
	easy_chest_usable = [
		{code = 'material', min = 3, max = 8, grade = 't1'},
		{code = 'material', min = 3, max = 10, grade = 'location'},
		{code = 'usable', min = 2, max = 4, grade = ['easy']},
	],
	easy_chest_gear = [
		{code = 'material', min = 4, max = 10, grade = 'location'},
		{code = 'gear', min = 1, max = 1, grade = ['easy'], material_grade = [['t1',10], ['t1', 3]]},
	],
	easy_chest_cosmetics = [
		{code = 'material', min = 4, max = 10, grade = 'location'},
		{code = 'static_gear', min = 1, max = 1, grade = ['easy']}
	],
	easy_chest_map = [
		{code = 'material', min = 4, max = 10, grade = 'location'},
		{code = 'map', min = 1, max = 1, maps = ['map_bandit_den','map_goblin_cave','map_bandit_fort','map_grove','map_ancient_jungle','map_undead_crypt','map_spider_lair']}
	],

	medium_chest_usable = [
		{code = 'material', min = 3, max = 5, grade = 't1'},
		{code = 'material', min = 3, max = 5, grade = 'location'},
		{code = 'usable', min = 2, max = 4, grade = ['easy','medium']},
		{code = 'usable', min = 0, max = 1, grade = ['easy','medium']},
	],
	medium_chest_gear = [
		{code = 'material', min = 4, max = 8, grade = 'location'},
		{code = 'gear', min = 1, max = 1, grade = ['easy'], material_grade = [['t1',3], ['t1', 10], ['t1',1]]},
	],
	medium_chest_cosmetics = [
		{code = 'material', min = 4, max = 8, grade = 'location'},
		{code = 'static_gear', min = 1, max = 1, grade = ['easy','medium']}
	],
	medium_chest_map = [
		{code = 'material', min = 4, max = 8, grade = 'location'},
		{code = 'map', min = 1, max = 1, maps = ['map_bandit_fort','map_ancient_jungle','map_undead_crypt','map_fire_depths','map_spider_lair']}
	],
	easy_armory_weapon = [
		{code = 'weapon', min = 1, max = 1, grade = ['easy'], material_grade = [['t1',10], ['t1', 3], ['t1',1]]},
	],
	easy_armory_armor = [
		{code = 'armor', min = 1, max = 1, grade = ['easy'], material_grade = [['t1',10], ['t1', 3], ['t1',1]]},
	],
	medium_armory_weapon = [
		{code = 'weapon', min = 1, max = 1, grade = ['easy'], material_grade = [['t1',2], ['t1', 10], ['t1',3]]},
	],
	medium_armory_armor = [
		{code = 'armor', min = 1, max = 1, grade = ['easy'], material_grade = [['t1',2], ['t1', 10], ['t1',3]]},
	],

	easy_prisoner_reward_item = [
		{code = 'gear', min = 1, max = 1, grade = ['easy'], material_grade = [['t1',10], ['t1', 5]]},
	],
	easy_prisoner_reward_resource = [
		{code = 'material', min = 5, max = 10, grade = 't1'},
		{code = 'material', min = 3, max = 6, grade = 'location'},
	],
	easy_boss_chest = [
		{code = 'static_gear', min = 1, max = 1, grade = ['easy']},
		{code = 'gear', min = 1, max = 2, grade = ['easy'], material_grade = [['t1',10], ['t1', 4]]},
		{code = 'defined', name = 'exp_scroll', min = 1, max = 2},
		{code = 'gold', min = 150, max = 200}
	],
	medium_boss_chest = [
		{code = 'static_gear', min = 1, max = 1, grade = ['easy','medium']},
		{code = 'gear', min = 1, max = 2, grade = ['easy','medium'], material_grade = [['t1',4], ['t1', 10],['t1',1]]},
		{code = 'defined', name = 'exp_scroll', min = 1, max = 3},
		{code = 'gold', min = 250, max = 400}
	],
	hard_boss_chest = [
		{code = 'static_gear', min = 1, max = 2, grade = ['easy','medium','hard']},
		{code = 'gear', min = 1, max = 2, grade = ['medium','hard'], material_grade = [['t1', 5],['t1',5]]},
		{code = 'defined', name = 'exp_scroll', min = 2, max = 4},
		{code = 'defined', name = 'soul_stone', min = 0, max = 1},
		{code = 'gold', min = 400, max = 600},
		{code = 'map', min = 1, max = 1, maps = ['map_bandit_fort','map_ancient_jungle','map_undead_crypt','map_fire_depths','map_spider_lair']}
	],
	grove_wood_reward = [
		{code = 'material_selected', 
		options = [
			{code = 'wood', weight = 1, amount = [15,30]},
			{code = 'woodmagic', weight = 0.7, amount = [10,15]},
			{code = 'woodancient', weight = 0.2, amount = [1,3]},
		]
		},
	],
	grove_leather_reward = [
		{code = 'material_selected', options = [
			{code = 'leather', weight = 1, amount = [15,30]},
			{code = 'leatherthick', weight = 1, amount = [10,15]},
			{code = 'leathermythic', weight = 0.7, amount = [5,10]},
			{code = 'leatherdragon', weight = 0.2, amount = [1,3]},
		]
		}
	],
	crypt_bone_reward = [
		{code = 'material_selected', options = [
			{code = 'bone', weight = 1, amount = [15,25]},
			{code = 'boneancient', weight = 0.5, amount = [5,10]},
			{code = 'bonedragon', weight = 0.3, amount = [1,3]},
	]
	}
	],

	test_chest_mimic = [],
	fighters_join_reward = [
		{code = 'defined', name = 'sword', min = 1, max = 1, parts = {WeaponHandle = 'wood', Blade = 'iron'}},
		{code = 'defined', name = 'chest_base_leather', min = 1, max = 1, parts = {ArmorBaseMed = 'leather', ArmorTrim = 'wood'}},
	],
	workers_join_reward = [
		{code = 'defined', name = 'axe', min = 1, max = 1, parts = {ToolHandle = 'wood', ToolBlade = 'iron'}},
		{code = 'defined', name = 'worker_outfit', min = 1, max = 1},
	],
	servants_join_reward = [
		{code = 'defined', name = 'elegant_choker', min = 1, max = 1},
		{code = 'defined', name = 'maid_dress', min = 1, max = 1},
		{code = 'defined', name = 'beer', min = 4, max = 4}
	],
	mages_join_reward = [
		{code = 'defined', name = 'staff', min = 1, max = 1, parts = {WeaponHandle = 'wood', Rod = 'woodmagic'}},
		{code = 'defined', name = 'lifeshard', min = 3, max = 3},
		{code = 'defined', name = 'energyshard', min = 2, max = 2},
	],
	servants_election_bonus = [
		{code = 'defined', name = 'amulet_of_recognition', min = 1, max = 1},
	],
	fighters_lich_bonus_loot = [
		{code = 'defined', name = 'energyshard', min = 3, max = 4},
		{code = 'defined', name = 'lifegem', min = 3, max = 4},
		{code = 'defined', name = 'boneancient', min = 5, max = 5},
	],
	aliron_church_bonus = [
		{code = 'defined', name = 'lifeshard', min = 5, max = 5},
	],
	blessed_divine_symbol = [
		{code = 'defined', name = 'blessed_divine_symbol', min = 1, max = 1},
	],
	celena_reward = [
		{code = 'defined', name = 'lifeshard', min = 3, max = 5},
	],
	celena_reward2 = [
		{code = 'defined', name = 'lifegem', min = 2, max = 4},
	],
	celena_reward3 = [
		{code = 'defined', name = 'blessed_divine_symbol', min = 1, max = 1},
	],
	celena_reward4 = [
		{code = 'defined', name = 'oblivion_potion', min = 1, max = 1},
	],
	celena_reward5 = [
		{code = 'defined', name = 'soul_stone', min = 1, max = 1},
	],
	celena_destroy_shrine1 = [
		{code = 'defined', name = 'iron', min = 5, max = 10},
		{code = 'defined', name = 'steel', min = 1, max = 3},
	],
	celena_destroy_shrine2 = [
		{code = 'defined', name = 'steel', min = 2, max = 5},
		{code = 'defined', name = 'mithril', min = 1, max = 2},
	],
	erebus_reward = [
		{code = 'defined', name = 'energyshard', min = 3, max = 5},
	],
	erebus_reward2 = [
		{code = 'defined', name = 'energygem', min = 2, max = 4},
	],
	erebus_reward3 = [
		{code = 'defined', name = 'ice_crystal', min = 2, max = 3},
	],
	erebus_reward4 = [
		{code = 'defined', name = 'crystalized_ether', min = 2, max = 3},
	],
	freya_reward1 = [
		{code = 'defined', name = 'woodancient', min = 3, max = 5},
	],
	hybris_reward1 = [
		{code = 'defined', name = 'bone', min = 4, max = 5},
	],
	hybris_reward2 = [
		{code = 'defined', name = 'boneancient', min = 2, max = 3},
	],
	hybris_reward3 = [
		{code = 'defined', name = 'boneancient', min = 4, max = 5},
	],
	hybris_reward4 = [
		{code = 'defined', name = 'bonedragon', min = 3, max = 5},
	],
	hybris_reward5 = [
		{code = 'material_selected', options = [
			{code = 'leather', weight = 1, amount = [4,8]},
			{code = 'leatherthick', weight = 0.5, amount = [2,5]},
			{code = 'leathermythic', weight = 0.3, amount = [1,3]},
			{code = 'leatherdragon', weight = 0.1, amount = [1,2]},
			]
		}
	],
	hybris_destroy_shrine = [
		{code = 'defined', name = 'wood', min = 3, max = 6},
		{code = 'defined', name = 'stone', min = 4, max = 9},
		{code = 'defined', name = 'steel', min = 2, max = 4},
		
	],
	erebus_destroy_shrine = [
		{code = 'defined', name = 'stone', min = 10, max = 20},
		{code = 'defined', name = 'obsidian', min = 1, max = 4},
	],
	freya_destroy_shrine = [
		{code = 'defined', name = 'wood', min = 5, max = 15},
		{code = 'defined', name = 'woodmagic', min = 2, max = 5},
		{code = 'defined', name = 'woodancient', min = 0, max = 1},
	],
	rebels_ore_reward = [
		{code = 'defined', name = 'steel', min = 25, max = 25},
		{code = 'defined', name = 'mithril', min = 10, max = 10},
	],
	holy_sword_reward = [
		{code = 'defined', name = 'holy_sword', min = 1, max = 1},
	],
	holy_spear_reward = [
		{code = 'defined', name = 'holy_spear', min = 1, max = 1},
	],
	sacred_scales_reward = [
		{code = 'defined', name = 'sacred_scales', min = 1, max = 1},
	],
	zephyra_bribe_1 = [
		{code = 'gold', min = 500, max = 500},
	],
	zephyra_bribe_2 = [
		{code = 'defined', name = 'zephyra_underwear', min = 1, max = 1},
	],
	ramont_axe_reward = [
		{code = 'defined', name = 'ramont_axe', min = 1, max = 1},
	],
	hector_armor_reward = [
		{code = 'defined', name = 'hector_armor', min = 1, max = 1},
	],
	erlen_sword_reward = [
		{code = 'defined', name = 'erlen_sword', min = 1, max = 1},
		{code = 'defined', name = 'sacred_bowl', min = 1, max = 1},
	],
	ayneris_rapier_reward = [
		{code = 'defined', name = 'ayneris_rapier', min = 1, max = 1},
	],
	garb_of_forest_reward = [
		{code = 'defined', name = 'garb_of_forest', min = 1, max = 1},
	],
	chloe_goggles_reward = [
		{code = 'defined', name = 'chloe_goggles', min = 1, max = 1},
	],
	priestess_tiara_reward = [
		{code = 'defined', name = 'priestess_tiara', min = 1, max = 1},
		{code = 'defined', name = 'sacred_bowl', min = 1, max = 1},
	],
	xari_amulet_reward = [
		{code = 'defined', name = 'xari_amulet', min = 1, max = 1},
	],
	amelia_dress_reward = [
		{code = 'defined', name = 'amelia_dress', min = 1, max = 1},
	],
	zephyra_brush_reward = [
		{code = 'defined', name = 'zephyra_brush', min = 1, max = 1},
	],
	
}


var locks_data = { #makes locks to lockpick for related chests
	easy_chest_usable = {locks = [['normal', 1],['none', 5],['mimic',0.1],['mimic_erotic',0.1]], difficulty = [5,20]},
	easy_chest_gear = {locks = [['normal', 1], ['none', 4],['mimic',0.1],['mimic_erotic',0.1]], difficulty = [10,25]},
	easy_chest_cosmetics = {locks = [['normal', 1],['none', 4],['mimic',0.1],['mimic_erotic',0.1]], difficulty = [5,20]},
	easy_chest_map = {locks = [['normal', 1],['none', 4],['mimic',0.1],['mimic_erotic',0.1]], difficulty = [5,20]},
	easy_boss_chest = {locks = [['normal', 1],['none',4]], difficulty = [10,25]},

	easy_armory_weapon = {locks = [['normal', 1], ['alarm', 1]], difficulty = [15,25]},
	easy_armory_armor = {locks = [['normal', 1], ['alarm', 1]], difficulty = [15,25]},

	medium_armory_weapon = {locks = [['normal', 1], ['alarm', 1]], difficulty = [30,60]},
	medium_armory_armor = {locks = [['normal', 1], ['alarm', 1]], difficulty = [30,60]},

	medium_chest_usable = {locks = [['normal', 1],['none', 3],['bomb',1],['gas',1],['mimic',0.3],['mimic_erotic',0.3]], difficulty = [15,40]},
	medium_chest_gear = {locks = [['normal', 1],['mimic',1],['mimic_erotic',0.2]], difficulty = [25,55]},
	medium_chest_cosmetics = {locks = [['normal', 1],['none', 1],['mimic',0.2],['mimic_erotic',0.2]], difficulty = [20,50]},
	medium_chest_map = {locks = [['normal', 1],['none', 3],['mimic',0.2],['mimic_erotic',0.2]], difficulty = [20,50]},
	medium_boss_chest = {locks = [['normal', 1],['none',2]], difficulty = [20,55]},

	hard_boss_chest = {locks = [['normal', 1],['none',2]], difficulty = [45,80]},
	test_chest_mimic = {locks = [['mimic_erotic', 1]], difficulty = [1,1]},
	}

#loot part
var loottables = {
	rat_loot = [['leather', 0.1], ['lifeshard', 0.05]],
	willowisp_loot = [['lifeshard', 0.3], ['energyshard',0.2]],
	spider_loot = [['clothsilk', 0.5, 2],['lifeshard', 0.1],['insect_chitin',0.1,1]],
	bandit_loot = [['cloth', 0.4, 2], ['lifeshard', 0.1], ['energyshard', 0.03], ['gold', 1, 3],],# ['axe', 't1', 1.0, 2], {'sword':1, ['bow', 't1', 1.0, 3]:1}],
	bandit_boss_loot = [['clothsilk', 0.8, 4], ['lifeshard', 0.3], ['gold', 15, 30]],
	wolf_loot = [['leather', 0.2, 2], ['bone', 0.2]],
	gryphon_loot = [['leathermythic', 1, 5], ['leathermythic', 0.5, 3]],
	goblin_loot = [['stone', 0.2, 1], ['gold', 0, 2]],
	bear_loot = [['leatherthick', 0.5, 3]],
	dog_loot = [['leather', 0.1, 2]],
	ballista_loot = [['woodiron', 0.5, 3], ['wood', 0.25, 5]],
	assassin_loot = [['gold', 5, 10],['energyshard', 0.2]],
	guardian_golem_loot = [['stone',0.9,5]],
	raptor_loot = [['leatherthick', 0.5, 2]],
	skeleton_melee_loot = [['bone', 0.5, 3],['lifeshard', 0.1]],
	skeleton_archer_loot = [['bone', 0.5, 2]],
	quest_lich_loot = [['boneancient', 0.5, 2], ['lich_skull', 1, 1], ['energygem', 0.5]],
	lich_loot = [['boneancient', 0.5, 2], ['energygem', 0.5]],
	zombie_loot = [['cloth', 0.5, 2], ['gold',1, 3]],
	mimic_loot = [['woodiron', 0.8, 8], ['lifegem', 0.75, 3], ['gold', 20, 30]],

	troll_loot = [['troll_blood', 1, 1],['gold', 10, 15]],
	ogre_loot = [['ogre_teeth', 0.6, 1], ['gold', 5, 10], ['lifegem', 0.05, 1],['earth_shard', 0.01, 1]],
	maneater_loot = [['blue_moss', 0.3, 1], ['gold',3,10]],
	centipede_loot = [['insect_chitin', 0.7, 1]],
	rockthrower_loot = [['stone', 0.6, 5], ['lifegem', 0.1, 1]],
	salamander_loot = [['lizard_skin', 0.4, 1]],
	ant_loot = [['insect_chitin', 0.4, 1]],
	great_viper_loot = [['lizard_skin', 0.8, 6], ['leathermythic', 0.8, 5],['ice_crystal', 0.1, 1], ['fire_ruby', 0.1, 1], ['crystalized_ether', 0.1, 1],['earth_shard', 0.1, 1]],
	ogre_alpha_loot = [['ogre_teeth', 1, 2], ['gold', 30, 50],['ice_crystal', 0.1, 1], ['fire_ruby', 0.1, 1], ['crystalized_ether', 0.1, 1],['earth_shard', 0.1, 1]],
	ifrit_loot = [['obsidian', 0.5, 1], ['fire_ruby', 0.3, 1], ['lifegem', 0.1, 1],['energygem',0.2, 1]],
	anthropoid_loot = [['crystalized_ether', 0.5, 2]],
	magma_beast_loot = [['lizard_skin', 0.8, 5], ['obsidian', 0.8, 6], ['fire_ruby', 0.2, 1], ['lifegem', 0.5, 2]],
	erebus_stone_loot = [['obsidian', 0.8, 5],['ice_crystal', 0.05, 1], ['fire_ruby', 0.05, 1], ['crystalized_ether', 0.05, 1], ['earth_shard', 0.3, 1], ['energygem',0.5, 1]],
	white_stag_loot = [['energyshard', 0.7]],
}

func process_loottable(table, rewarddict, amount_mul = 1):
	if table is String:
		if !loottables.has(table):
			print('error: wrong loottable %s' % table)
			return
		table = loottables[table]
	
	if !(table is Array):
		print ('error in loottable')
		print(table)
	
	if !(table.back() is Array or table.back() is Dictionary):
		process_loottable_record(table, rewarddict, amount_mul)
		return
	
	for rec in table:
		if rec is String:
			process_loottable(rec, rewarddict, amount_mul)
		elif rec is Dictionary:
			process_loottable_item_selector(rec, rewarddict, amount_mul)
		elif rec is Array:
			process_loottable_record(rec, rewarddict, amount_mul)
		else:
			print ('error in loottable record')
			print(table)


func process_loottable_record(record, rewarddict, amount_mul = 1):
	var trecord = record.duplicate(true)
	if trecord[0] is Array:
		if trecord[0][0] is Dictionary and trecord[0][0].has('type'):
			if !globals.checkreqs(trecord[0]):
				return
			else:
				trecord.remove(0)
	var temp = trecord[0]
	if temp is String:
		if temp == 'gold':
			rewarddict.gold += amount_mul * globals.rng.randi_range(trecord[1], trecord[2])
			return
	var amount
	if trecord.back() is int:
		amount = trecord.back() * amount_mul
		trecord.pop_back()
	else:
		amount = amount_mul
	for i in range(amount):
		var chance = trecord.back()
		if randf() < chance:
			process_loottable_item(trecord, rewarddict, amount_mul)



func process_loottable_item(record, rewarddict, amount_mul = 1):
	var data = record.duplicate(true)
	data.pop_back()
	var reward = data[0]
	if reward is Array:
		process_loottable(reward, rewarddict, amount_mul)
	elif reward is Dictionary:
		process_loottable_item_selector(reward, rewarddict, amount_mul)
	elif loottables.has(reward):
		process_loottable(reward, rewarddict, amount_mul)
	elif Items.materiallist.has(reward):
		if rewarddict.materials.has(reward):
			rewarddict.materials[reward] += 1
		else:
			rewarddict.materials[reward] = 1
	elif Items.itemlist.has(reward):
		var i_template = Items.itemlist[reward]
		if i_template.type == 'usable':
			var itemfound = false
			for i in rewarddict.items:
				if i.itembase == reward:
					i.amount += 1
					itemfound = true
					break
			if !itemfound:
				var newitem = globals.CreateUsableItem(reward)
				rewarddict.items.push_back(newitem)
		elif i_template.type == 'gear':
			if i_template.crafttype == 'basic':
				var newitem = globals.CreateGearItemLoot(reward, {})
				rewarddict.items.push_back(newitem)
			elif data.size() == 2:
				var newitem = globals.CreateGearItemLoot(reward, data[1])
				rewarddict.items.push_back(newitem)
			else: #shortcut - modular gear from defaut materials
				var newitem = globals.CreateGearItemLoot(reward, ResourceScripts.game_progress.get_default_materials())
				rewarddict.items.push_back(newitem)
		else:
			print('error: wrong itemtype at %s' % reward)


func process_loottable_item_selector (record, rewarddict, amount_mul = 1):
	var pool = {}
	for key in record:
		if key is String:
			pool[key] = record[key]
		if key is Array: #key is unnamed lootatble or loottable record
			if key[0] is Array: #key[0] is condition or unnamed lootatble or loottable record
				if key[0][0] is Dictionary: #key[0] is condition and key is record or key[0] is loottable record with item selector and key is loottable
					if key[0][0].has('type'): #key[0] is condition
						if globals.checkreqs(key[0]):
							var newkey = key.duplicate(true)
							newkey.remove(0)
							pool[newkey] = record[key]
					else: #key[0] is selector, key is record
						pool[key] = record[key]
				else: #key[0] is not condition by condition syntax
					pool[key] = record[key]
			else: #key[0] is not condition by definition
				pool[key] = record[key]
		else: #key is id or selector (highly undesired)
			pool[key] = record[key]
	if pool.empty():
		return
	var res = input_handler.weightedrandom_dict(pool)
	if res is String:
		if loottables.has(res):
			process_loottable(res, rewarddict)
		elif Items.materiallist.has(res):
			if rewarddict.materials.has(res):
				rewarddict.materials[res] += 1
			else:
				rewarddict.materials[res] = 1
		elif Items.itemlist.has(res):
			var i_template = Items.itemlist[res]
			if i_template.type == 'usable':
				var itemfound = false
				for i in rewarddict.items:
					if i.itembase == res:
						i.amount += 1
						itemfound = true
						break
				if !itemfound:
					var newitem = globals.CreateUsableItem(res)
					rewarddict.items.push_back(newitem)
			elif i_template.type == 'gear':
				if i_template.crafttype == 'basic':
					var newitem = globals.CreateGearItemLoot(res, {})
					rewarddict.items.push_back(newitem)
				else: #shortcut - modular gear from defaut materials
					var newitem = globals.CreateGearItemLoot(res, ResourceScripts.game_progress.get_default_materials())
					rewarddict.items.push_back(newitem)
			else:
				print('error: wrong itemtype at %s' % res)
		else:
			print('error: wrong item selected %s' % res)
	elif res is Dictionary: #bad case - nested selector
		process_loottable_item_selector(res, rewarddict)
	elif res is Array:
		process_loottable(res, rewarddict)


#shrines part
var shrines = {
	celena = {
		options = {
			"material" : {input = 'material', output = 'celena_item'},
			"character" : {input = 'character', output = 'celena_character'},
			"destroy" : {input = 'destroy', output = 'celena_destroy'}
		},
		bless = 'celena_bless',
		curse = 'celena_curse',
	},
	erebus = {
		options = {
			"material" : {input = 'material', output = 'erebus_item'},
			#"character" : {input = 'character', output = 'erebus_character'},
			"destroy" : {input = 'destroy', output = 'erebus_destroy'},
			"item" : {input = "item", output = 'erebus_disenchant'},
		},
		bless = '',
		curse = '',
	},
	freya = {
		options = {
			"material" : {input = 'material', output = 'freya_item'},
			"character" : {input = 'character', output = 'freya_character'},
			"destroy" : {input = 'destroy', output = 'freya_destroy'}
		},
		bless = 'freya_bless',
		curse = 'freya_curse',
	},
	hybris = {
		options = {
			"material" : {input = 'material', output = 'hybris_item'},
			"character" : {input = 'character', output = 'hybris_character'},
			"destroy" : {input = 'destroy', output = 'hybris_destroy'}
		},
		bless = 'hybris_bless',
		curse = 'hybris_curse',

	},
}

var celena_item_dict = {
	
}


var shrine_item_dict = {
	stone = "erebus_reward",
	obsidian = "erebus_reward2",
	fire_ruby = "erebus_reward3",
	earth_shard = "erebus_reward4",
	leather = "hybris_reward1",
	leatherthick = "hybris_reward2",
	leathermythic = "hybris_reward3",
	leatherdragon = "hybris_reward4",
	meat = "hybris_reward5",
}

func celena_item(code):
	var dict = {text = tr('ALTAR_ITEM_1'), image = '', options = [], tags = ['active_character_translate']}
	var item = Items.materiallist[code]
	
	if item.type == 'food':
		globals.common_effects([{code = 'material_change', operant = '-', material = code, value = 1}])
		if item.tags.has("cooked"):
			dict.text += tr('ALTAR_ITEM_GOOD')
			dict.common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['celena_reward2',1]]}]
			dict.tags.append("free_loot")
		else:
			dict.text += tr('ALTAR_ITEM_GOOD')
			dict.common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['celena_reward',2]]}]
			dict.tags.append("free_loot")
	elif item.code == 'divine_symbol':
		dict.text += tr('ALTAR_ITEM_GOOD')
		globals.common_effects([{code = 'material_change', operant = '-', material = code, value = 1}])
		dict.common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['celena_reward3',2]]}]
		dict.tags.append("free_loot")
	elif item.code == 'alcohol':#this part is not working because you can't select alcohol in material selection yet
		dict.text += tr('ALTAR_ITEM_GOOD')
		globals.common_effects([{code = 'remove_item', operant = '-', name = 'alcohol', number = 1}])
		dict.common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['celena_reward4',2]]}]
		dict.tags.append("free_loot")
	elif item.code == 'woodancient':
		dict.text += tr('ALTAR_ITEM_GOOD')
		globals.common_effects([{code = 'material_change', operant = '-', material = code, value = 1}])
		dict.common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['celena_reward5',2]]}]
		dict.tags.append("free_loot")
	else:
		dict.text += tr('ALTAR_ITEM_BAD')
		dict.options.append({code = 'close', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]})
	input_handler.interactive_message_follow(dict, 'direct', [])

func celena_character(person):

	var dict = {text = tr('ALTAR_CHAR_1'), image = '', options = [], tags = ['active_character_translate'], common_effects = []}

	if randf() <= 0.5:
		dict.text += tr('ALTAR_CHAR_GOOD')

		dict.common_effects.append({code = 'affect_active_character', type = 'effect', value = 'celena_bless'})
	else:
		dict.text += tr('ALTAR_CHAR_BAD')

	dict.options.append({code = 'close', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]})
	input_handler.interactive_message_follow(dict, 'direct', [])

func celena_destroy(person):

	var dict = {text = tr('ALTAR_DESTROY_1'), image = '', options = [], tags = ['active_character_translate'], common_effects = []}

	if randf() <= 0.33:
		dict.text += tr('ALTAR_DESTROY_2')

		dict.common_effects.append({code = 'affect_active_character', type = 'effect', value = 'celena_curse'})

	dict.common_effects.append({code = 'make_loot', type = 'tableloot', pool = [['celena_destroy_shrine1',3], ['celena_destroy_shrine2',1]]})
	dict.tags.append("free_loot")


	input_handler.interactive_message_follow(dict, 'direct', [])

func freya_item(code):
	var dict = {text = tr('ALTAR_ITEM_1'), image = '', options = [], tags = ['active_character_translate']}
	var item = Items.materiallist[code]
	
	if item.type in ['wood']:
		globals.common_effects([{code = 'material_change', operant = '-', material = code, value = 1}])
		
		dict.text += tr('FREYA_ITEM_WOOD')
		dict.common_effects = [{code = 'affect_active_character', type = 'effect', value = 'freya_curse'}]
	else:
		globals.common_effects([{code = 'material_change', operant = '-', material = code, value = 1}])
		match item.code:
			'cloth':
				dict.text += tr('FREYA_ITEM_CLOTH')
				dict.common_effects = [{code = 'affect_active_character', type = 'effect', value = 'freya_bless', override = {duration = 4}}]
			'clothsilk':
				dict.text += tr('FREYA_ITEM_CLOTH')
				dict.common_effects = [{code = 'affect_active_character', type = 'effect', value = 'freya_bless', override = {duration = 8}}]
			'clothmagic':
				dict.text += tr('FREYA_ITEM_CLOTHMAGICC')
				dict.common_effects = [{code = 'affect_active_character', type = 'stat_set', stat = 'mp', value = 999}]
			'clothethereal':
				dict.text += tr('FREYA_ITEM_CLOTHETHERIAL')
				dict.common_effects = [{code = 'make_loot', type = 'tableloot', pool = [['freya_reward1',1]]}]
				dict.tags.append("free_loot")
			_:
				dict.text += tr('ALTAR_ITEM_BAD')

	dict.options.append({code = 'close', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]})

	input_handler.interactive_message_follow(dict, 'direct', [])

func freya_character(person):

	var dict = {text = tr('ALTAR_CHAR_1'), image = '', options = [], tags = ['active_character_translate'], common_effects = []}

	if person.get_stat('unique') == 'aire' && globals.checkreqs([{type = 'decision', value = 'aire_got_bow', check = false}]):
		dict.text += tr('FREYA_CHAR_BOW')
		dict.common_effects.append({code = 'unique_character_changes',
					value = 'aire',
					args = [
						{code = 'create_and_equip', item = "aire_bow", parts = {}}
						],
			})
		ResourceScripts.game_progress.decisions.append('aire_got_bow')
	else:
		if person.checkreqs([{code = 'has_wooden_gear'}]):
			dict.text += tr('FREYA_CHAR_WOODEN')
			dict.common_effects.append({code = 'affect_active_character', type = 'effect', value = 'freya_curse'})
		else:
			if randf() >= 0.5 || person.get_stat('race') in ['Elf','DarkElf','TribalElf','Fairy','Dryad']:
				dict.text += tr('FREYA_CHAR_RACE_GOOD')

				dict.common_effects.append({code = 'affect_active_character', type = 'effect', value = 'freya_bless'})
			else:
				dict.text += tr('FREYA_CHAR_RACE_BAD')

	dict.options.append({code = 'close', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]})


	input_handler.interactive_message_follow(dict, 'direct', [])

func freya_destroy(person):

	var dict = {text = tr('ALTAR_DESTROY_1'), image = '', options = [], tags = ['active_character_translate'], common_effects = []}

	if randf() <= 0.75:
		dict.text += tr('ALTAR_DESTROY_2')

		dict.common_effects.append({code = 'affect_active_character', type = 'effect', value = 'freya_curse'})

	dict.common_effects.append({code = 'make_loot', type = 'tableloot', pool = [['freya_destroy_shrine',1]]})
	dict.tags.append("free_loot")

	input_handler.interactive_message_follow(dict, 'direct', [])

func hybris_destroy(person):

	var dict = {text = tr('ALTAR_DESTROY_1'), image = '', options = [], tags = ['active_character_translate'], common_effects = []}

	if randf() <= 0.90:
		dict.text += tr('ALTAR_DESTROY_2')

		dict.common_effects.append({code = 'affect_active_character', type = 'effect', value = 'hybris_curse'})

	dict.common_effects.append({code = 'make_loot', type = 'tableloot', pool = [['hybris_destroy_shrine',1]]})
	dict.tags.append("free_loot")

	input_handler.interactive_message_follow(dict, 'direct', [])



func erebus_item(code):
	var dict = {text = tr('ALTAR_ITEM_1'), image = '', options = [], tags = ['active_character_translate']}
	var item = Items.materiallist[code]
	if shrine_item_dict.has(item.code):
		globals.common_effects([{code = 'material_change', operant = '-', material = code, value = 1}])
		dict.text += tr('ALTAR_ITEM_GOOD')
		dict.common_effects = [{code = 'make_loot', type = 'tableloot', pool = [[shrine_item_dict[item.code],3]]}]
		dict.tags.append("free_loot")
	else:
		dict.text += tr('ALTAR_ITEM_BAD')
		dict.options.append({code = 'close', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]})


	input_handler.interactive_message_follow(dict, 'direct', [])
	

func erebus_character(person):

	var dict = {text = tr('ALTAR_CHAR_1'), image = '', options = [], tags = ['active_character_translate'], common_effects = []}

	if randf() <= 0.5:
		dict.text += tr('ALTAR_CHAR_GOOD')

		dict.common_effects.append({code = 'affect_active_character', type = 'effect', value = 'celena_bless'})
	else:
		dict.text += tr('ALTAR_CHAR_BAD')

	dict.options.append({code = 'close', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]})
	input_handler.interactive_message_follow(dict, 'direct', [])

func hybris_character(person):
	var dict = {}
	if person.get_stat('unique') != null || person.is_master():
		dict = {text = tr('HYBRIS_ALTAR_CHAR_FAIL'), image = '', options = [], tags = ['active_character_translate','dialogue_scene'], common_effects = []}
	else:
		dict = {text = tr('HYBRIS_ALTAR_CHAR'), image = '', options = [], tags = ['active_character_translate','dialogue_scene'], common_effects = []}
		if person.get_stat('slave_class') == 'servant':
			dict.options.append({code = 'hybris_character_convert', reqs = [], text = "HYBRIS_ALTAR_CHAR_OPTION1", dialogue_argument = 1})
#		dict.options.append({code = 'hybris_character_loyalty', reqs = [], text = "HYBRIS_ALTAR_CHAR_OPTION2", dialogue_argument = 1})
	
	dict.options.append({code = 'close', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]})
	input_handler.interactive_message_follow(dict, 'direct', [])

func hybris_character_convert():
	var dict = {text = tr('HYBRIS_ALTAR_CHAR_RESULT1'), image = '', options = [], tags = ['active_character_translate'], common_effects = []}
	dict.common_effects.append({code = 'change_type_scene_characters', type = 'all', value = 'slave'})
	dict.options.append({code = 'close', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]})
	input_handler.interactive_message_follow(dict, 'direct', [])

#func hybris_character_loyalty():
#	var dict = {text = tr('HYBRIS_ALTAR_CHAR_RESULT2'), image = '', options = [], tags = ['active_character_translate'], common_effects = []}
#	dict.common_effects.append({code = 'affect_scene_characters', type = 'all', stat = 'loyalty', value = 50})
#	dict.options.append({code = 'close', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]})
#	input_handler.interactive_message_follow(dict, 'direct', [])

func hybris_item(code):
	var dict = {text = tr('ALTAR_ITEM_1'), image = '', options = [], tags = ['active_character_translate']}
	var item = Items.materiallist[code]
	if shrine_item_dict.has(item.code):
		globals.common_effects([{code = 'material_change', operant = '-', material = code, value = 1}])
		dict.text += tr('ALTAR_ITEM_GOOD')
		dict.common_effects = [{code = 'make_loot', type = 'tableloot', pool = [[shrine_item_dict[item.code],3]]}]
		dict.tags.append("free_loot")
	else:
		dict.text += tr('ALTAR_ITEM_BAD')
		dict.options.append({code = 'close', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]})


	input_handler.interactive_message_follow(dict, 'direct', [])

func erebus_destroy(person):

	var dict = {text = tr('ALTAR_DESTROY_1'), image = '', options = [], tags = ['active_character_translate'], common_effects = []}


	dict.common_effects.append({code = 'make_loot', type = 'tableloot', pool = [['erebus_destroy_shrine',3]]})
	dict.tags.append("free_loot")


	input_handler.interactive_message_follow(dict, 'direct', [])

func erebus_disenchant(item):
	var dict = {text = '[name] puts an offer on the altar. ', image = '', options = [], tags = ['active_character_translate']}
	
	item.clear_enchants()
	dict.text += item.name + " slowly starts to glow on the altar. After a few moments the light dissipates and all magic leaves the item."
	dict.options.append({code = 'close', reqs = [], text = "DIALOGUELEAVE", bonus_effects = [{code = 'advance_location'}]})
	
	input_handler.interactive_message_follow(dict, 'direct', [])
