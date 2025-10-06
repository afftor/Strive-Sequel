extends Reference

#Loot tables consists of records. Each record is a dictionary.
#common params (any record can have them):
#* reqs - common array suitable for globals.checkreqs(). If reqs not met, record ignored
#* chance - float chance to process record (1.0 = 100%). If not lucky, record ignored.
#	No chance param means 100%
#* amount - precise amount of generated stuff. Quantity of generated material, for example
#* min and max - generate random amount within those boundaries.
#* chance_per_unit - (specific rule for old enemies' loot_tables) Like normal chance,
#	but it rolls separately for each unit in amount. For example, {amount = 4, chance_per_unit = 0.5}
#	will make 4 rolls. With only 2 successful, true amount becomes 2 instead of 4.
#specific params:
#* list - array of records, each will be processed by common rules. The record with list param itself
#	ignores amount params and all other specific params
#* loot_table - string with name of another record in loot_tables, which should be processed.
#	The record with loot_table param itself ignores amount params and all other specific params
#* selector - array of records. For each unit in amount one random record from array will be processed.
#	Records in selector respects reqs and chance rules, but also can have "weight" param,
#	which determines there probability of being selected. No weight param equals to 1.0.
#	The record with selector param itself ignores all other specific params
#* gold - bool flag, gives gold
#* material - string, gives designated material
#* item - string, gives designated item. For gear type, if param "quality"
#	provided, item will be generated with designated quality.
#	Also "parts" param can be provided (string or dict).
#	Bool param "autoassign_quality" used for [probably legacy] generating with
#	autoassigning "quality" and no "parts" (it was in use for chests)
#	(seems to be useful only for items in Items.fixed_quality_stats).
#* no_enchant - bool flag, gear-items with "true" will have no enchantments, IF it could otherwise.
#	"False" will not add enchantments, where it shouldn't be
#* random - string, determines type of randomly generated loot. Can be:
#	* material - randomly generated material from tear lists provided by string param "tier" or bool
#		param "from_location". In last case tier taken from location. If no tier param provided,
#		default will be used.
#	* usable - random usable item from all possible within tier array provaided in param "tiers".
#	* static_gear - same as usable, but for items with "costume" geartype
#	* gear - same as usable, but for items of "gear" type with "weapon" or "armor" itemtype.
#		Can also have "material_tiers" array param or "from_location" bool param to randomly select
#		material for generation.
#	* weapon - same as gear, but only for "weapon" itemtype.
#	* armor - same as gear, but only for "armor" itemtype.


#example = {selector = [
# {loot_table = 'easy_chest_usable', weight = 1},
# {loot_table = 'easy_chest_gear', weight = 0.7},
# {loot_table = 'easy_chest_cosmetics', weight = 0.2},
# {loot_table = 'easy_chest_map', weight = 0.3},
#]},



var loot_tables = {
	#enemy's loot
	#MIND! in old enemies' loot tables second param became "chance_per_unit" if there was third param (amount)
	rat_loot = {list = [
		{material = 'leather', chance = 0.1},
		{item = 'lifeshard', chance = 0.05}]},
	willowisp_loot = {list = [
		{item = 'lifeshard', chance = 0.3},
		{item = 'energyshard', chance = 0.2}]},
	spider_loot = {list = [
		{material = 'clothsilk', amount = 2, chance_per_unit = 0.5},
		{item = 'lifeshard', chance = 0.1},
		{material = 'insect_chitin', chance = 0.1}]},
	assassin_loot = {list = [
		{gold = true, min = 5, max = 10},
		{item = 'energyshard', chance = 0.2}]},
	ant_loot = {material = 'insect_chitin', chance = 0.4},
	anthropoid_loot = {material = 'crystalized_ether', amount = 2, chance_per_unit = 0.5},
	ballista_loot = {list = [
		{material = 'woodiron', amount = 3, chance_per_unit = 0.5},
		{material = 'wood', amount = 5, chance_per_unit = 0.25}]},
	bandit_boss_loot = {list = [
		{material = 'clothsilk', amount = 4, chance_per_unit = 0.8},
		{item = 'lifeshard', chance = 0.3},
		{gold = true, max = 30, min = 15}]},
	bandit_loot = {list = [
		{material = 'cloth', amount = 2, chance_per_unit = 0.4},
		{item = 'lifeshard', chance = 0.1},
		{item = 'energyshard', chance = 0.03},
		{gold = true, max = 3, min = 1}]},
	bear_loot = {material = 'leatherthick', amount = 3, chance_per_unit = 0.5},
	centipede_loot = {material = 'insect_chitin', chance = 0.7},
	dog_loot = {material = 'leather', amount = 2, chance_per_unit = 0.1},
	erebus_stone_loot = {list = [
		{material = 'obsidian', amount = 5, chance_per_unit = 0.8},
		{material = 'ice_crystal', chance = 0.05},
		{material = 'fire_ruby', chance = 0.05},
		{material = 'crystalized_ether', chance = 0.05},
		{material = 'earth_shard', chance = 0.3},
		{item = 'energygem', chance = 0.5}]},
	goblin_loot = {list = [
		{material = 'stone', chance = 0.2},
		{gold = true, max = 2, min = 0}]},
	great_viper_loot = {list = [
		{material = 'lizard_skin', amount = 6, chance_per_unit = 0.8},
		{material = 'leathermythic', amount = 5, chance_per_unit = 0.8},
		{material = 'ice_crystal', chance = 0.1},
		{material = 'fire_ruby', chance = 0.1},
		{material = 'crystalized_ether', chance = 0.1},
		{material = 'earth_shard', chance = 0.1}]},
	gryphon_loot = {list = [
		{material = 'leathermythic', amount = 5},
		{material = 'leathermythic', amount = 3, chance_per_unit = 0.5}]},
	guardian_golem_loot = {material = 'stone', amount = 5, chance_per_unit = 0.9},
	ifrit_loot = {list = [
		{material = 'obsidian', chance = 0.5},
		{material = 'fire_ruby', chance = 0.3},
		{item = 'lifegem', chance = 0.1},
		{item = 'energygem', chance = 0.2}]},
	lich_loot = {list = [
		{material = 'boneancient', amount = 2, chance_per_unit = 0.5},
		{item = 'energygem', chance = 0.5}]},
	magma_beast_loot = {list = [
		{material = 'lizard_skin', amount = 5, chance_per_unit = 0.8},
		{material = 'obsidian', amount = 6, chance_per_unit = 0.8},
		{material = 'fire_ruby', chance = 0.2},
		{item = 'lifegem', amount = 2, chance_per_unit = 0.5}]},
	maneater_loot = {list = [
		{material = 'blue_moss', chance = 0.3},
		{gold = true, max = 10, min = 3}]},
	mimic_loot = {list = [
		{material = 'woodiron', amount = 8, chance_per_unit = 0.8},
		{item = 'lifegem', amount = 3, chance_per_unit = 0.75},
		{gold = true, max = 30, min = 20}]},
	ogre_alpha_loot = {list = [
		{material = 'ogre_teeth', amount = 2},
		{gold = true, max = 50, min = 30},
		{material = 'ice_crystal', chance = 0.1},
		{material = 'fire_ruby', chance = 0.1},
		{material = 'crystalized_ether', chance = 0.1},
		{material = 'earth_shard', chance = 0.1}]},
	ogre_loot = {list = [
		{material = 'ogre_teeth', chance = 0.6},
		{gold = true, max = 10, min = 5},
		{item = 'lifegem', chance = 0.05},
		{material = 'earth_shard', chance = 0.01}]},
	quest_lich_loot = {list = [
		{material = 'boneancient', amount = 2, chance_per_unit = 0.5},
		{material = 'lich_skull'},
		{item = 'energygem', chance = 0.5}]},
	raptor_loot = {material = 'leatherthick', amount = 2, chance_per_unit = 0.5},
	rockthrower_loot = {list = [
		{material = 'stone', amount = 5, chance_per_unit = 0.6},
		{item = 'lifegem', chance = 0.1}]},
	salamander_loot = {material = 'lizard_skin', chance = 0.4},
	skeleton_archer_loot = {material = 'bone', amount = 2, chance_per_unit = 0.5},
	skeleton_melee_loot = {list = [
		{material = 'bone', amount = 3, chance_per_unit = 0.5},
		{item = 'lifeshard', chance = 0.1}]},
	troll_loot = {list = [
		{material = 'troll_blood'},
		{gold = true, max = 15, min = 10}]},
	white_stag_loot = {item = 'energyshard', chance = 0.7},
	wolf_loot = {list = [
		{material = 'leather', amount = 2, chance_per_unit = 0.2},
		{material = 'bone', chance = 0.2}]},
	zombie_loot = {list = [
		{material = 'cloth', amount = 2, chance_per_unit = 0.5},
		{gold = true, max = 3, min = 1}]},
	
	#chest loot
	#mind! Tiers are different for materials and items!
	easy_chest_usable = {list = [
		{random = 'material', min = 3, max = 8, tier = 't1'},
		{random = 'material', min = 3, max = 10, from_location = true},
		{random = 'usable', min = 2, max = 4, tiers = ['easy']},]},
	easy_chest_gear = {list = [
		{random = 'material', min = 4, max = 10, from_location = true},
		{random = 'gear', amount = 1, material_tiers = [['t1', 10], ['t1', 3]], tiers = ['easy']},]},
	easy_chest_cosmetics = {list = [
		{random = 'material', min = 4, max = 10, from_location = true},
		{random = 'static_gear', amount = 1, tiers = ['easy']},]},
	easy_chest_map = {list = [
		{random = 'material', min = 4, max = 10, from_location = true},
		{selector = [
			{loot_table = "easy_maps", weight = 5},
			{loot_table = "medium_maps", weight = 1},
			]},
		]},
	easy_maps = {list = [
		{selector = [
			{item = 'map_bandit_den'},
			{item = 'map_goblin_cave'},
			{item = 'map_grove'},
			{item = 'map_spider_lair'}]}
		]},
	medium_maps = {list = [
		{selector = [
			{item = 'map_undead_crypt'},
			{item = 'map_ancient_jungle'},
			{item = 'map_bandit_fort'},
			]}
		]},
	hard_maps = {list = [
		{selector = [
			{item = 'map_fire_depths'},
			{item = 'map_goblin_stronghold'},
			{item = 'map_rebel_redoubt'},
			]}
		]},
	medium_chest_usable = {list = [
		{random = 'material', min = 3, max = 5, tier = 't1'},
		{random = 'material', min = 3, max = 5, from_location = true},
		{random = 'usable', min = 2, max = 4, tiers = ['easy', 'medium']},
		{random = 'usable', min = 0, max = 1, tiers = ['easy', 'medium']}]},
	medium_chest_gear = {list = [
		{random = 'material', min = 4, max = 8, from_location = true},
		{random = 'gear', amount = 1, material_tiers = [['t1', 3], ['t1', 10], ['t1', 1]], tiers = ['easy']}]},
	medium_chest_cosmetics = {list = [
		{random = 'material', min = 4, max = 8, from_location = true},
		{random = 'static_gear', amount = 1, tiers = ['easy', 'medium']}]},
	medium_chest_map = {list = [
		{random = 'material', min = 4, max = 8, from_location = true},
		
		{selector = [
			{loot_table = "easy_maps", weight = 1},
			{loot_table = "medium_maps", weight = 4},
			{loot_table = "hard_maps", weight = 1},
			]},
		]},
	easy_armory_weapon = {random = 'weapon', amount = 1, material_tiers = [['t1', 10], ['t1', 3], ['t1', 1]], tiers = ['easy']},
	easy_armory_armor = {random = 'armor', amount = 1, material_tiers = [['t1', 10], ['t1', 3], ['t1', 1]], tiers = ['easy']},
	medium_armory_weapon = {random = 'weapon', amount = 1, material_tiers = [['t1', 2], ['t1', 10], ['t1', 3]], tiers = ['easy']},
	medium_armory_armor = {random = 'armor', amount = 1, material_tiers = [['t1', 2], ['t1', 10], ['t1', 3]], tiers = ['easy']},
	easy_prisoner_reward_item = {random = 'gear', amount = 1, material_tiers = [['t1', 10], ['t1', 5]], tiers = ['easy']},
	easy_prisoner_reward_resource = {list = [
		{random = 'material', min = 5, max = 10, tier = 't1'},
		{random = 'material', min = 3, max = 6, from_location = true}]},
	easy_boss_chest = {list = [
		{random = 'static_gear', amount = 1, tiers = ['easy']},
		{random = 'gear', min = 1, max = 2, material_tiers = [['t1', 10], ['t1', 4]], tiers = ['easy']},
		{item = 'exp_scroll', min = 1, max = 2},
		{gold = true, min = 150, max = 200}]},
	medium_boss_chest = {list = [
		{random = 'static_gear', amount = 1, tiers = ['easy', 'medium']},
		{random = 'gear', min = 1, max = 2, material_tiers = [['t1', 4], ['t1', 10], ['t1', 1]], tiers = ['easy', 'medium']},
		{item = 'exp_scroll', min = 1, max = 3},
		
		{item = 'corruptive_essence', chance = 0.1},
		{gold = true, min = 250, max = 400}]},
	hard_boss_chest = {list = [
		{random = 'static_gear', min = 1, max = 2, tiers = ['easy', 'medium', 'hard']},
		{random = 'gear', min = 1, max = 2, material_tiers = [['t1', 5], ['t1', 5]], tiers = ['medium', 'hard']},
		{item = 'exp_scroll', min = 2, max = 4},
		{item = 'soul_stone', min = 0, max = 1},
		{gold = true, min = 400, max = 600},
		{item = 'corruptive_essence', chance = 0.3},
		{selector = [
			{loot_table = "medium_maps", weight = 2},
			{loot_table = "hard_maps", weight = 3},
			]},
		]},
	grove_wood_reward = {selector = [
		{material = 'wood', weight = 1, min = 15, max = 30},
		{material = 'woodmagic', weight = 0.7, min = 10, max = 15},
		{material = 'woodancient', weight = 0.2, min = 1, max = 3}]},
	grove_leather_reward = {selector = [
		{material = 'leather', weight = 1, min = 15, max = 30},
		{material = 'leatherthick', weight = 1, min = 10, max = 15},
		{material = 'leathermythic', weight = 0.7, min = 5, max = 10},
		{material = 'leatherdragon', weight = 0.2, min = 1, max = 3},]},
	crypt_bone_reward = {selector = [
		{material = 'bone', weight = 1, min = 15, max = 25},
		{material = 'boneancient', weight = 0.5, min = 5, max = 10},
		{material = 'bonedragon', weight = 0.3, min = 1, max = 3},]},
	test_chest_mimic = {},
	fighters_join_reward = {list = [
		{item = 'sword', quality = 'poor', amount = 1, parts = {WeaponHandle = 'wood', Blade = 'iron'}},
		{item = 'chest_base_leather', quality = 'poor', amount = 1, parts = {ArmorBaseMed = 'leather', ArmorTrim = 'wood'}}]},
	workers_join_reward = {list = [
		{item = 'axe', quality = 'poor', amount = 1, parts = {ToolHandle = 'wood', ToolBlade = 'iron'}},
		{item = 'worker_outfit', amount = 1}]},#autoassign_quality = true
	servants_join_reward = {list = [
		{item = 'elegant_choker', amount = 1},#autoassign_quality = true
		{item = 'maid_dress', amount = 1},#autoassign_quality = true
		{item = 'beer', amount = 4}]},
	mages_join_reward = {list = [
		{item = 'staff', quality = 'poor', amount = 1, parts = {WeaponHandle = 'wood', Rod = 'woodmagic'}},
		{item = 'lifeshard', amount = 3},
		{item = 'energyshard', amount = 2}]},
	servants_election_bonus = {item = 'amulet_of_recognition', amount = 1},#autoassign_quality = true
	fighters_lich_bonus_loot = {list = [
		{item = 'energyshard', min = 3, max = 4},
		{item = 'lifegem', min = 3, max = 4},
		{material = 'boneancient', amount = 5}]},
	aliron_church_bonus = {item = 'lifeshard', amount = 5},
	blessed_divine_symbol = {material = 'blessed_divine_symbol', amount = 1},
	celena_reward = {item = 'lifeshard', min = 3, max = 5},
	celena_reward2 = {item = 'lifegem', min = 2, max = 4},
	celena_reward3 = {material = 'blessed_divine_symbol', amount = 1},
	celena_reward4 = {item = 'oblivion_potion', amount = 1},
	celena_reward5 = {item = 'soul_stone', amount = 1},
	celena_destroy_shrine1 = {list = [
		{material = 'iron', min = 5, max = 10},
		{material = 'steel', min = 1, max = 3}]},
	celena_destroy_shrine2 = {list = [
		{material = 'steel', min = 2, max = 5},
		{material = 'mithril', min = 1, max = 2}]},
	erebus_reward = {item = 'energyshard', min = 3, max = 5},
	erebus_reward2 = {item = 'energygem', min = 2, max = 4},
	erebus_reward3 = {material = 'ice_crystal', min = 2, max = 3},
	erebus_reward4 = {material = 'crystalized_ether', min = 2, max = 3},
	freya_reward1 = {material = 'woodancient', min = 3, max = 5},
	hybris_reward1 = {material = 'bone', min = 4, max = 5},
	hybris_reward2 = {material = 'boneancient', min = 2, max = 3},
	hybris_reward3 = {material = 'boneancient', min = 4, max = 5},
	hybris_reward4 = {material = 'bonedragon', min = 3, max = 5},
	hybris_reward5 = {selector = [
		{material = 'leather', weight = 1, min = 4, max = 8},
		{material = 'leatherthick', weight = 0.5, min = 2, max = 5},
		{material = 'leathermythic', weight = 0.3, min = 1, max = 3},
		{material = 'leatherdragon', weight = 0.1, min = 1, max = 2}]},
	hybris_destroy_shrine = {list = [
		{material = 'wood', min = 3, max = 6},
		{material = 'stone', min = 4, max = 9},
		{material = 'steel', min = 2, max = 4}]},
	erebus_destroy_shrine = {list = [
		{material = 'stone', min = 10, max = 20},
		{material = 'obsidian', min = 1, max = 4}]},
	freya_destroy_shrine = {list = [
		{material = 'wood', min = 5, max = 15},
		{material = 'woodmagic', min = 2, max = 5},
		{material = 'woodancient', min = 0, max = 1}]},
	rebels_ore_reward = {list = [
		{material = 'steel', amount = 25},
		{material = 'mithril', amount = 10}]},
	holy_sword_reward = {item = 'holy_sword', autoassign_quality = true, amount = 1},
	holy_spear_reward = {item = 'holy_spear', autoassign_quality = true, amount = 1},
	sacred_scales_reward = {item = 'sacred_scales', amount = 1},#autoassign_quality = true
	zephyra_bribe_1 = {gold = true, amount = 500},
	zephyra_bribe_2 = {item = 'zephyra_underwear', amount = 1},
	ramont_axe_reward = {item = 'ramont_axe', amount = 1},#autoassign_quality = true
	hector_armor_reward = {item = 'hector_armor', amount = 1, no_enchant = true},#autoassign_quality = true
	erlen_sword_reward = {list = [
		{item = 'erlen_sword', amount = 1},#autoassign_quality = true
		{item = 'sacred_bowl', amount = 1}]},#autoassign_quality = true
	ayneris_rapier_reward = {item = 'ayneris_rapier', amount = 1},#autoassign_quality = true
	garb_of_forest_reward = {item = 'garb_of_forest', amount = 1, no_enchant = true},#autoassign_quality = true
	chloe_goggles_reward = {item = 'chloe_goggles', amount = 1},#autoassign_quality = true
	priestess_tiara_reward = {list = [
		{item = 'priestess_tiara', amount = 1},#autoassign_quality = true
		{item = 'sacred_bowl', amount = 1}]},#autoassign_quality = true
	xari_amulet_reward = {item = 'xari_amulet', amount = 1},#autoassign_quality = true
	amelia_dress_reward = {item = 'amelia_dress', amount = 1},#autoassign_quality = true
	zephyra_brush_reward = {item = 'zephyra_brush', amount = 1},#autoassign_quality = true
	
	#area_shop_items
	plains_area_shop = {list = [
		{material = 'meat', min = 40, max = 80},
		{material = 'fish', min = 40, max = 80, chance = 0.9},
		{material = 'vegetables', min = 40, max = 80, chance = 0.9},
		{material = 'grain', min = 60, max = 150},
		{material = 'bread', min = 30, max = 60},
		{material = 'wood', min = 40, max = 50},
		{material = 'stone', min = 40, max = 50},
		{material = 'leather', min = 3, max = 15, chance = 0.7},
		{material = 'iron', min = 10, max = 20, chance = 0.8},
		{material = 'steel', min = 5, max = 15, chance = 0.3},
		{material = 'cloth', min = 5, max = 20, chance = 0.9},
		{material = 'clothsilk', min = 5, max = 10, chance = 0.8},
		{material = 'blue_moss', min = 1, max = 3, chance = 0.3},
		{material = 'bone', min = 5, max = 20, chance = 0.7},
		{item = 'lifeshard', min = 4, max = 8},
		{item = 'energyshard', min = 2, max = 5},
		{material = 'trap', min = 5, max = 10},
		{material = 'ink_base', min = 2, max = 3},
		{material = 'bandage', min = 2, max = 6},
		{min = 1, max = 2, selector = [
			{item = 'dagger'},
			{item = 'club'}]},
		{min = 3, max = 6, chance = 0.8, selector = [
			{item = 'sword'},
			{item = 'axe'},
			{item = 'spear'},
			{item = 'mace'},
			{item = 'battleaxe'},
			{item = 'pickaxe'},
			{item = 'hammer'},
			{item = 'fishingtools'},
			{item = 'sickle'},
			{item = 'bow'},
			{item = 'crossbow'},
			{item = 'staff'},
			{item = 'hunt_knife'},
			{item = 'shield'}]},
		{min = 1, max = 3, chance = 0.8, selector = [
			{item = 'chest_base_cloth'},
			{item = 'chest_base_leather'},
			{item = 'chest_base_metal'},
			{item = 'legs_base_cloth'},
			{item = 'legs_base_leather'},
			{item = 'legs_base_metal'}]},
		{min = 3, max = 6, chance = 0.8, selector = [
			{item = 'leather_collar'},
			{item = 'animal_ears'},
			{item = 'animal_gloves'},
			{item = 'maid_dress'},
			{item = 'worker_outfit'},
			{item = 'lacy_underwear'},
			{item = 'handcuffs'},
			{item = 'strapon'},
			{item = 'mask'},
			{item = 'anal_beads'}]},
		{min = 4, max = 8, chance = 0.8, selector = [
			{item = 'beer'},
			{item = 'wine'},
			{item = 'wine2'},
			{item = 'alcohol'},
			{item = 'aphrodisiac'},
			{item = 'hairdye'}]},
		{min = 1, max = 2, selector = [
			{item = 'map_goblin_cave'},
			{item = 'map_bandit_den'}]},
		{selector = [
			{loot_table = "medium_maps", weight = 10},
			{loot_table = "hard_maps", weight = 1},
			{item = 'map_rebel_redoubt', weight = 5},
			]},
		]},
	forests_area_shop = {list = [
		{material = 'vegetables', min = 40, max = 80},
		{material = 'grain', min = 60, max = 150},
		{material = 'bread', min = 30, max = 60},
		{material = 'cloth', min = 10, max = 25, chance = 0.9},
		{material = 'clothsilk', min = 10, max = 15, chance = 0.9},
		{material = 'salvia', min = 10, max = 20, chance = 0.7},
		{material = 'bone', min = 5, max = 20, chance = 0.7},
		{item = 'lifeshard', min = 4, max = 8},
		{item = 'energyshard', min = 3, max = 5},
		{material = 'obsidian', min = 3, max = 5, chance = 0.3},
		{min = 2, max = 4, chance = 0.8, selector = [
			{item = 'sword'},
			{item = 'bow'},
			{item = 'battleaxe'},
			{item = 'dagger'},
			{item = 'spear'},
			{item = 'staff'},
			{item = 'shield'},
			{item = 'foxmask'}]},
		{min = 1, max = 2, chance = 0.8, selector = [
			{item = 'chest_base_cloth'},
			{item = 'chest_base_leather'},
			{item = 'legs_base_cloth'},
			{item = 'legs_base_leather'}]},
		{item = 'soul_stone', amount = 1, chance = 0.1},
		{selector = [
			{loot_table = "medium_maps", weight = 3},
			{loot_table = "hard_maps", weight = 1},
			]},
		]},
	mountain_area_shop = {list = [
		{material = 'vegetables', min = 40, max = 80},
		{material = 'grain', min = 60, max = 150},
		{material = 'bread', min = 30, max = 60},
		{material = 'clothsilk', min = 10, max = 15, chance = 0.9},
		{material = 'bone', min = 5, max = 20, chance = 0.7},
		{item = 'lifeshard', min = 4, max = 8},
		{material = 'obsidian', min = 3, max = 5, chance = 0.7},
		{material = 'stone', min = 40, max = 80, chance = 1},
		{material = 'steel', min = 6, max = 12, chance = 0.9},
		{material = 'mithril', min = 5, max = 8, chance = 0.8},
		{min = 2, max = 4, chance = 0.8, selector = [
			{item = 'sword'},
			{item = 'crossbow'},
			{item = 'mace'},
			{item = 'battleaxe'},
			{item = 'spear'},
			{item = 'pickaxe'},
			{item = 'hammer'},
			{item = 'shield'}]},
		{min = 1, max = 2, chance = 0.8, selector = [
			{item = 'chest_base_metal'},
			{item = 'chest_base_leather'},
			{item = 'legs_base_metal'},
			{item = 'legs_base_leather'}]},
		{min = 6, max = 12, chance = 0.95, selector = [
			{item = 'beer'},
			{item = 'wine'},
			{item = 'wine2'},
			{item = 'alcohol'}]},
		{amount = 1, selector = [
			{item = 'map_fire_depths'},
			{item = 'map_goblin_stronghold'}]},
		]},
	empire_area_shop = {list = [
		{material = 'vegetables', min = 40, max = 80},
		{material = 'grain', min = 60, max = 150},
		{material = 'bread', min = 30, max = 60},
		{material = 'clothsilk', min = 10, max = 15, chance = 0.9},
		{material = 'bone', min = 5, max = 20, chance = 0.7},
		{item = 'lifegem', min = 4, max = 8},
		{material = 'steel', min = 15, max = 30, chance = 0.9},
		{material = 'mithril', min = 6, max = 12, chance = 0.8},
		{min = 2, max = 4, chance = 0.8, selector = [
			{item = 'sword'},
			{item = 'swordadv'},
			{item = 'spear'},
			{item = 'spearadv'},
			{item = 'crossbow'},
			{item = 'crossbowadv'},
			{item = 'mace'},
			{item = 'maceadv'},
			{item = 'battleaxe'},
			{item = 'battleaxeadv'},]},
		{min = 1, max = 2, chance = 0.8, selector = [
			{item = 'chest_base_metal'},
			{item = 'chest_base_leather'},
			{item = 'chest_base_cloth'},
			{item = 'chest_adv_metal'},
			{item = 'chest_adv_leather'},
			{item = 'chest_adv_cloth'},
			{item = 'legs_base_metal'},
			{item = 'legs_base_leather'},
			{item = 'legs_base_cloth'},
			{item = 'legs_adv_metal'},
			{item = 'legs_adv_leather'},
			{item = 'legs_adv_cloth'}]},
		{amount = 2, selector = [
			{loot_table = "medium_maps", weight = 1},
			{loot_table = "hard_maps", weight = 1},
			]},
		{amount = 1, chance = 0.7, selector = [
			{material = 'adamantine', min = 3, max = 6},
			{material = 'bonedragon', min = 4, max = 8},
			{material = 'letherdragon', min = 4, max = 8},
			{material = 'woodancinet', min = 3, max = 5},
			]},
		]},
	beastkin_area_shop = {list = [
		{material = 'meat', min = 40, max = 80},
		{material = 'leather', min = 25, max = 35, chance = 0.7},
		{material = 'leatherthick', min = 10, max = 20, chance = 0.9},
		{material = 'leathermythic', min = 5, max = 15, chance = 0.9},
		{material = 'salvia', min = 10, max = 20, chance = 0.7},
		{material = 'bone', min = 5, max = 20, chance = 0.7},
		{item = 'lifeshard', min = 4, max = 8},
		{min = 1, max = 2, chance = 0.8, selector = [
			{item = 'chest_base_cloth'},
			{item = 'chest_base_leather'},
			{item = 'legs_base_cloth'},
			{item = 'legs_base_leather'},
			{item = 'foxmask'}]},
		]},
	settlement_plains1_shop = {list = [
		{material = 'meat', min = 20, max = 30, chance = 0.2},
		{material = 'fish', min = 15, max = 45},
		{material = 'vegetables', min = 20, max = 30, chance = 0.2},
		{material = 'grain', min = 40, max = 60, chance = 0.9},
		{material = 'wood', min = 10, max = 30, chance = 0.75},
		{material = 'stone', min = 10, max = 20, chance = 0.5},
		{material = 'leather', min = 3, max = 6, chance = 0.1},
		{material = 'iron', min = 10, max = 20},
		{material = 'cloth', min = 3, max = 6, chance = 0.1},
		{material = 'blue_moss', min = 1, max = 2, chance = 0.2},
		{material = 'salvia', min = 2, max = 6, chance = 0.6},
		{item = 'lifeshard', min = 2, max = 6, chance = 0.9},
		{material = 'bandage', min = 4, max = 6, chance = 0.8},
		{min = 1, max = 2, chance = 0.8, selector = [
			{item = 'axe'},
			{item = 'pickaxe'},
			{item = 'fishingtools'},
			{item = 'sickle'},
			{item = 'club'},
			{item = 'shield'},]},
		{amount = 1, chance = 0.3, selector = [
			{item = 'worker_outfit'},]},
		{min = 2, max = 6, chance = 0.8, selector = [
			{item = 'beer'},
			{item = 'alcohol'},]},
		{amount = 1, selector = [
			{item = 'chest_base_leather'},
			{item = 'legs_base_leather'},
			{item = 'chest_base_metal'},
			{item = 'legs_base_metal'},]},
	]},
	settlement_plains2_shop = {list = [
		{material = 'meat', min = 20, max = 50, chance = 0.8},
		{material = 'fish', min = 15, max = 45, chance = 0.6},
		{material = 'vegetables', min = 20, max = 40, chance = 0.9},
		{material = 'grain', min = 40, max = 60, chance = 0.9},
		{material = 'cloth', min = 5, max = 15},
		{material = 'clothsilk', min = 2, max = 5, chance = 0.8},
		{material = 'blue_moss', min = 1, max = 2, chance = 0.2},
		{material = 'salvia', min = 2, max = 6, chance = 0.6},
		{item = 'lifeshard', min = 3, max = 6, chance = 0.9},
		{material = 'bandage', min = 3, max = 5, chance = 0.9},
		{min = 1, max = 2, chance = 0.8, selector = [
			{item = 'axe'},
			{item = 'sickle'},
			{item = 'club'},
			{item = 'shield'},
			{item = 'bow'},]},
		{amount = 1, chance = 0.3, selector = [
			{item = 'worker_outfit'},]},
		{min = 1, max = 2, chance = 0.8, selector = [
			{item = 'chest_base_cloth'},
			{item = 'legs_base_cloth'},]},
	]},
	
	#gatherable_resources for dungeons
	biome_bandit_den_res = {selector = [
		{material = 'wood', weight = 10, min = 25, max = 40},
		{material = 'stone', weight = 6, min = 25, max = 40},
		{material = 'iron', weight = 2, min = 15, max = 25}]},
	biome_bandit_fort_res = {selector = [
		{material = 'wood', weight = 10, min = 45, max = 60},
		{material = 'stone', weight = 6, min = 35, max = 50},
		{material = 'iron', weight = 2, min = 15, max = 25},
		{material = 'woodiron', weight = 2, min = 15, max = 25}]},
	biome_undead_crypt_res = {selector = [
		{material = 'stone', weight = 10, min = 45, max = 60},
		{material = 'bone', weight = 6, min = 35, max = 50},
		{material = 'boneancient', weight = 2, min = 15, max = 25}]},
	biome_goblin_cave_res = {selector = [
		{material = 'stone', weight = 6, min = 45, max = 60},
		{material = 'bone', weight = 3, min = 35, max = 50},
		{material = 'leather', weight = 4, min = 15, max = 25}]},
	biome_grove_res = {selector = [
		{material = 'meat', weight = 6, min = 90, max = 120},
		{material = 'wood', weight = 8, min = 60, max = 90},
		{material = 'woodmagic', weight = 3, min = 15, max = 25},
		{material = 'woodiron', weight = 1, min = 15, max = 25}]},
	biome_ancient_jungles_res = {selector = [
		{material = 'woodmagic', weight = 5, min = 25, max = 45},
		{material = 'woodiron', weight = 8, min = 30, max = 45},
		{material = 'leatherthick', weight = 4, min = 20, max = 35},
		{material = 'leathermythic', weight = 1, min = 10, max = 15}]},
	biome_goblin_stronghold_res = {selector = [
		{material = 'woodiron', weight = 8, min = 40, max = 55},
		{material = 'leatherthick', weight = 4, min = 20, max = 35},
		{material = 'lizard_skin', weight = 4, min = 20, max = 25},
		]},
	biome_fire_depths_res = {selector = [
		{material = 'iron', weight = 6, min = 40, max = 70},
		{material = 'mithril', weight = 4, min = 25, max = 40},
		{material = 'adamantine', weight = 2, min = 10, max = 20}]},
	dungeon_rebel_camp_res = {selector = [
		{material = 'stone', weight = 6, min = 25, max = 40},
		{material = 'iron', weight = 2, min = 15, max = 25}]},
	quest_gryphon_forest_res = {selector = [
		{material = 'wood', weight = 6, min = 25, max = 40},
		{material = 'leather', weight = 2, min = 15, max = 25}]},
	quest_amelia_bandits_res = {selector = [
		{material = 'iron', weight = 2, min = 15, max = 25}]},
	quest_fighters_lich_res = {selector = [
		{material = 'stone', weight = 2, min = 15, max = 25}]},

	#gather_resources for settlements
	#(Mind, that amount here is number of allowed workers)
	settlement_plains1_res = {list = [
		{material = 'wood', min = 2, max = 3},
		{material = 'stone', min = 2, max = 3},
		{material = 'grain', min = 2, max = 3},
		{material = 'iron', amount = 1},]},
	settlement_plains2_res = {list = [
		{material = 'vegetables', min = 2, max = 3},
		{material = 'leather', min = 2, max = 3},
		{material = 'cloth', min = 2, max = 3},
		{material = 'clothsilk', amount = 1}]},
	settlement_forest1_res = {list = [
		{material = 'wood', min = 2, max = 3},
		{material = 'woodmagic', amount = 3},
		{material = 'woodiron', amount = 2},
		{material = 'leatherthick', amount = 1}]},
	
	library_loot = {list = [
		{item = 'exp_scroll', min = 1, max = 2},
		
		{selector = [
			{loot_table = "library_loot_map", weight = 3},
			{loot_table = "library_loot_book", weight = 1},
			]},
		]},
	
	library_loot_map = {list = [
		{selector = [
			{loot_table = "easy_maps", weight = 3},
			{loot_table = "medium_maps", weight = 2},
			{loot_table = "hard_maps", weight = 1},
			]}
		]},
	library_loot_book = {list = [
		{selector = [
			{item = "skillbook_hyperborea"},
			{item = "skillbook_holy_lance"},
			{item = "skillbook_poison_vapors"},
			{item = "skillbook_meteor"},
			{item = "skillbook_abyss_gaze"},
			{item = "skillbook_dark_flame"},
			]}
		]},
	
	settlement_mountains1_res = {list = [
		{material = 'iron', min = 1, max = 2},
		{material = 'mithril', amount = 1},
		{material = 'boneancient', amount = 1}]},
	
	
	start_corruptive_essence = {
		list = [
		{item = 'corruptive_essence', min = 1, max = 1}]
	},
	
	
}


var gather_settings = {
	base = {
		_default = {
			mod = [2,2.5],
			stamina = [5,10]},
		wood = {
			mod = [2,2.5],
			stamina = [5,10]},
		stone = {
			mod = [2,2.5],
			stamina = [5,10]},
		iron = {
			mod = [2,2.5],
			stamina = [5,10]},
		woodiron = {
			mod = [2,2.5],
			stamina = [5,10]},
		bone = {
			mod = [2,2.5],
			stamina = [5,10]},
		boneancient = {
			mod = [2,2.5],
			stamina = [5,10]},
	}
}


#not sure if it should be here, but logical to keep it close to chests' loot tables
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


