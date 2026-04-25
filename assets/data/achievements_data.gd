extends Reference

var achievements = {
	prologue = {
		name = "ACHIEVEMENT_PROLOGUE_NAME",
		description = "ACHIEVEMENT_PROLOGUE_DESC",
		hint = "ACHIEVEMENT_PROLOGUE_HINT",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_master.png",
		points = 5
	},
	act1 = {
		name = "ACHIEVEMENT_ACT1_NAME",
		description = "ACHIEVEMENT_ACT1_DESC",
		hint = "ACHIEVEMENT_ACT1_HINT",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_master.png",
		points = 5
	},
	act2 = {
		name = "ACHIEVEMENT_ACT2_NAME",
		description = "ACHIEVEMENT_ACT2_DESC",
		hint = "ACHIEVEMENT_ACT2_HINT",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_master.png",
		points = 5
	},
	act3 = {
		name = "ACHIEVEMENT_ACT3_NAME",
		description = "ACHIEVEMENT_ACT3_DESC",
		hint = "ACHIEVEMENT_ACT3_HINT",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_master.png",
		points = 5
	},
	wedding_daisy = {
		name = "ACHIEVEMENT_WED_DAISY_NAME",
		description = "ACHIEVEMENT_WED_DAISY_DESC",
		hint = "ACHIEVEMENT_WED_DAISY_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/daisy_prt/daisy_wed_prt_kind.png",
		points = 3
	},
	wedding_heleviel = {
		name = "ACHIEVEMENT_WED_HELEVIEL_NAME",
		description = "ACHIEVEMENT_WED_HELEVIEL_DESC",
		hint = "ACHIEVEMENT_WED_HELEVIEL_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/heleviel_prt/heleviel_wed_prt_kind.png",
		points = 3
	},
	wedding_amelia = {
		name = "ACHIEVEMENT_WED_AMELIA_NAME",
		description = "ACHIEVEMENT_WED_AMELIA_DESC",
		hint = "ACHIEVEMENT_WED_AMELIA_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/amelia_prt/amelia_wed_prt_kind.png",
		points = 3
	},
	wedding_cali = {
		name = "ACHIEVEMENT_WED_CALI_NAME",
		description = "ACHIEVEMENT_WED_CALI_DESC",
		hint = "ACHIEVEMENT_WED_CALI_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/cali_prt/cali_wed_prt_kind.png",
		points = 3
	},
	wedding_lilia = {
		name = "ACHIEVEMENT_WED_LILIA_NAME",
		description = "ACHIEVEMENT_WED_LILIA_DESC",
		hint = "ACHIEVEMENT_WED_LILIA_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/lilia_prt/lilia_wed_prt_kind.png",
		points = 3
	},
	wedding_lilith = {
		name = "ACHIEVEMENT_WED_LILITH_NAME",
		description = "ACHIEVEMENT_WED_LILITH_DESC",
		hint = "ACHIEVEMENT_WED_LILITH_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/lilia_prt/lilith_wed_prt_kind.png",
		points = 3
	},
	wedding_kuro = {
		name = "ACHIEVEMENT_WED_KURO_NAME",
		description = "ACHIEVEMENT_WED_KURO_DESC",
		hint = "ACHIEVEMENT_WED_KURO_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/kuro_prt/kuro_wed_prt_kind.png",
		points = 3
	},
	wedding_anastasia = {
		name = "ACHIEVEMENT_WED_ANA_NAME",
		description = "ACHIEVEMENT_WED_ANA_DESC",
		hint = "ACHIEVEMENT_WED_ANA_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/anastasia_prt/anastasia_wed_prt_kind.png",
		points = 3
	},
	wedding_zephyra = {
		name = "ACHIEVEMENT_WED_ZEPHYRA_NAME",
		description = "ACHIEVEMENT_WED_ZEPHYRA_DESC",
		hint = "ACHIEVEMENT_WED_ZEPHYRA_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/zephyra_prt/zephyra_wed_prt_kind.png",
		points = 3
	},
	wedding_mae = {
		name = "ACHIEVEMENT_WED_MAE_NAME",
		description = "ACHIEVEMENT_WED_MAE_DESC",
		hint = "ACHIEVEMENT_WED_MAE_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/mae_prt/mae_wed_prt_kind.png",
		points = 3
	},
	wedding_jean = {
		name = "ACHIEVEMENT_WED_JEAN_NAME",
		description = "ACHIEVEMENT_WED_JEAN_DESC",
		hint = "ACHIEVEMENT_WED_JEAN_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/jean_prt/jean_wed_prt_kind.png",
		points = 3
	},
	wedding_hara = {
		name = "ACHIEVEMENT_WED_HARA_NAME",
		description = "ACHIEVEMENT_WED_HARA_DESC",
		hint = "ACHIEVEMENT_WED_HARA_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/hara_prt/hara_wed_prt_kind.png",
		points = 3
	},
	wedding_lira = {
		name = "ACHIEVEMENT_WED_LIRA_NAME",
		description = "ACHIEVEMENT_WED_LIRA_DESC",
		hint = "ACHIEVEMENT_WED_LIRA_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/lira_prt/lira_wed_prt_kind.png",
		points = 3
	},
	wedding_rouge = {
		name = "ACHIEVEMENT_WED_ROUGE_NAME",
		description = "ACHIEVEMENT_WED_ROUGE_DESC",
		hint = "ACHIEVEMENT_WED_ROUGE_HINT",
		group = "wedding",
		icon = "res://assets/images/portraits/rouge_prt/rouge_wed_prt_kind.png",
		points = 3
	},
	max_tailor = {
		name = "ACHIEVEMENT_MAX_TAILOR_NAME",
		description = "ACHIEVEMENT_MAX_TAILOR_DESC",
		hint = "ACHIEVEMENT_MAX_TAILOR_HINT",
		icon = "res://assets/images/gui/upgrades/tailor.png",
		sub_to = "three_upgrades"
	},
	max_forge = {
		name = "ACHIEVEMENT_MAX_FORGE_NAME",
		description = "ACHIEVEMENT_MAX_FORGE_DESC",
		hint = "ACHIEVEMENT_MAX_FORGE_HINT",
		icon = "res://assets/images/gui/upgrades/forge.png",
		sub_to = "three_upgrades"
	},
	max_alchemy = {
		name = "ACHIEVEMENT_MAX_ALCHEMY_NAME",
		description = "ACHIEVEMENT_MAX_ALCHEMY_DESC",
		hint = "ACHIEVEMENT_MAX_ALCHEMY_HINT",
		icon = "res://assets/images/gui/upgrades/alchemy.png",
		sub_to = "three_upgrades"
	},
	three_upgrades = {
		name = "ACHIEVEMENT_UPGRADES_NAME",
		description = "ACHIEVEMENT_UPGRADES_DESC",
		hint = "ACHIEVEMENT_UPGRADES_HINT",
		icon = "res://assets/images/gui/upgrades/upgrade_tier3.png",
		points = 5
	},
	dung_bandit_den = {
		name = "ACHIEVEMENT_DUNG_BANDEN_NAME",
		description = "ACHIEVEMENT_DUNG_BANDEN_DESC",
		hint = "ACHIEVEMENT_DUNG_BANDEN_HINT",
		group = "dungeons",
		icon = "res://assets/images/enemies/bandit.png",
		points = 2
	},
	dung_bandit_fort = {
		name = "ACHIEVEMENT_DUNG_BANFORT_NAME",
		description = "ACHIEVEMENT_DUNG_BANFORT_DESC",
		hint = "ACHIEVEMENT_DUNG_BANFORT_HINT",
		group = "dungeons",
		icon = "res://assets/images/enemies/bandit.png",
		points = 2
	},
	dung_rebel_redoubt = {
		name = "ACHIEVEMENT_DUNG_REBEL_NAME",
		description = "ACHIEVEMENT_DUNG_REBEL_DESC",
		hint = "ACHIEVEMENT_DUNG_REBEL_HINT",
		group = "dungeons",
		icon = "res://assets/images/enemies/rebel_knight.png",
		points = 2
	},
	dung_undead_crypt = {
		name = "ACHIEVEMENT_DUNG_CRYPT_NAME",
		description = "ACHIEVEMENT_DUNG_CRYPT_DESC",
		hint = "ACHIEVEMENT_DUNG_CRYPT_HINT",
		group = "dungeons",
		icon = "res://assets/images/enemies/undead_warrior_portrait.png",
		points = 2
	},
	dung_goblin_cave = {
		name = "ACHIEVEMENT_DUNG_GOBCAV_NAME",
		description = "ACHIEVEMENT_DUNG_GOBCAV_DESC",
		hint = "ACHIEVEMENT_DUNG_GOBCAV_HINT",
		group = "dungeons",
		icon = "res://assets/images/enemies/goblin.png",
		points = 2
	},
	dung_grove = {
		name = "ACHIEVEMENT_DUNG_GROVE_NAME",
		description = "ACHIEVEMENT_DUNG_GROVE_DESC",
		hint = "ACHIEVEMENT_DUNG_GROVE_HINT",
		group = "dungeons",
		icon = "res://assets/images/enemies/ent.png",
		points = 2
	},
	dung_spider_lair = {
		name = "ACHIEVEMENT_DUNG_SPIDER_NAME",
		description = "ACHIEVEMENT_DUNG_SPIDER_DESC",
		hint = "ACHIEVEMENT_DUNG_SPIDER_HINT",
		group = "dungeons",
		icon = "res://assets/images/enemies/spider_boss.png",
		points = 2
	},
	dung_ancient_jungles = {
		name = "ACHIEVEMENT_DUNG_JUNGLES_NAME",
		description = "ACHIEVEMENT_DUNG_JUNGLES_DESC",
		hint = "ACHIEVEMENT_DUNG_JUNGLES_HINT",
		group = "dungeons",
		icon = "res://assets/images/enemies/ent_boss.png",
		points = 2
	},
	dung_fire_depths = {
		name = "ACHIEVEMENT_DUNG_DEPTHS_NAME",
		description = "ACHIEVEMENT_DUNG_DEPTHS_DESC",
		hint = "ACHIEVEMENT_DUNG_DEPTHS_HINT",
		group = "dungeons",
		icon = "res://assets/images/enemies/ifrit.png",
		points = 2
	},
	dung_goblin_stronghold = {
		name = "ACHIEVEMENT_DUNG_GOBHOLD_NAME",
		description = "ACHIEVEMENT_DUNG_GOBHOLD_DESC",
		hint = "ACHIEVEMENT_DUNG_GOBHOLD_HINT",
		group = "dungeons",
		icon = "res://assets/images/enemies/goblin_boss.png",
		points = 2
	},
	dung_infinite_5 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "5",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_10 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "10",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_15 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "15",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_20 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "20",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_25 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "25",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_30 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "30",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_35 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "35",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_40 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "40",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_45 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "45",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_50 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "50",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_55 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "55",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_60 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "60",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_65 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "65",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_70 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "70",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_75 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "75",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_80 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "80",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_85 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "85",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_90 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "90",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_95 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "95",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	dung_infinite_100 = {
		name = "",
		description = "",
		hint = "",
		no_tr = true,
		level_text = "100",
		group = "infinite_levels",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
		points = 1
	},
	item_aire_bow = {
		name = "ACHIEVEMENT_ITEM_AIREBOW_NAME",
		description = "ACHIEVEMENT_ITEM_AIREBOW_DESC",
		hint = "ACHIEVEMENT_ITEM_AIREBOW_HINT",
		icon = "res://assets/images/iconsgear/airesbow.png",
		points = 3
	},
	item_zephyra_brush = {
		name = "ACHIEVEMENT_ITEM_ZBRUSH_NAME",
		description = "ACHIEVEMENT_ITEM_ZBRUSH_DESC",
		hint = "ACHIEVEMENT_ITEM_ZBRUSH_HINT",
		icon = "res://assets/images/iconsitems/magic brush.png",
		points = 3
	},
	item_holy_sword = {
		name = "ACHIEVEMENT_ITEM_HOLYSWORD_NAME",
		description = "ACHIEVEMENT_ITEM_HOLYSWORD_DESC",
		hint = "ACHIEVEMENT_ITEM_HOLYSWORD_HINT",
		icon = "res://assets/images/iconsitems/holy_sword.png",
		points = 3
	},
	quest_meteorite = {
		name = "ACHIEVEMENT_METEORITE_NAME",
		description = "ACHIEVEMENT_METEORITE_DESC",
		hint = "ACHIEVEMENT_METEORITE_HINT",
		icon = "res://assets/images/iconsskills/skill_meteor.png",
		points = 3
	},
}

var achi_groups = {
	wedding = {
		name = "ACHIGROUP_WEDDING_NAME",
		description = "ACHIGROUP_WEDDING_DESC",
#		hint = "ACHIGROUP_WEDDING_HINT",
		icon = "res://assets/images/portraits/daisy_prt/daisy_wed_prt_kind.png",
	},
	dungeons = {
		name = "ACHIGROUP_DUNGEONS_NAME",
		description = "ACHIGROUP_DUNGEONS_DESC",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_travel_dungeon.png",
	},
	infinite_levels = {
		name = "ACHIGROUP_INFINITE_NAME",
		description = "ACHIGROUP_INFINITE_DESC",
		icon = "res://assets/Textures_v2/Universal/Icons/icon_infinity.png",
	}
}

var bonuses = {
	daisy_start = {
		name = "ACHIBONUS_DAISY_START",
		description = "ACHIBONUS_DAISY_START_DESC",
		hint = "ACHIBONUS_DAISY_START_HINT",
		icon = "res://assets/images/portraits/daisy_prt/daisy_default_prt_bold.png",
		preparation = "prep_daisy_start",
		cost = 5
	},
	cali_start = {
		name = "ACHIBONUS_CALI_START",
		description = "ACHIBONUS_CALI_START_DESC",
		hint = "ACHIBONUS_CALI_START_HINT",
		icon = "res://assets/images/portraits/cali_prt/cali_default_prt_kind.png",
		preparation = "prep_cali_start",
		cost = 10
	},
	aire_start = {
		name = "ACHIBONUS_AIRE_START",
		description = "ACHIBONUS_AIRE_START_DESC",
		hint = "ACHIBONUS_AIRE_START_HINT",
		icon = "res://assets/images/portraits/aire_prt.png",
		preparation = "prep_aire_start",
		cost = 10
	},
	anastasia_start = {
		name = "ACHIBONUS_ANA_START",
		description = "ACHIBONUS_ANA_START_DESC",
		hint = "ACHIBONUS_ANA_START_HINT",
		icon = "res://assets/images/portraits/anastasia_prt/anastasia_default_prt_kind.png",
		preparation = "prep_ana_start",
		cost = 15
	},
	amelia_start = {
		name = "ACHIBONUS_AMELIA_START",
		description = "ACHIBONUS_AMELIA_START_DESC",
		hint = "ACHIBONUS_AMELIA_START_HINT",
		icon = "res://assets/images/portraits/amelia_prt/amelia_default_prt_kind.png",
		preparation = "prep_amelia_start",
		cost = 15
	},
	heleviel_start = {
		name = "ACHIBONUS_HELEVIEL_START",
		description = "ACHIBONUS_HELEVIEL_START_DESC",
		hint = "ACHIBONUS_HELEVIEL_START_HINT",
		icon = "res://assets/images/portraits/heleviel_prt/heleviel_default_prt_kind.png",
		preparation = "prep_heleviel_start",
		cost = 20
	},
	lira_start = {
		name = "ACHIBONUS_LIRA_START",
		description = "ACHIBONUS_LIRA_START_DESC",
		hint = "ACHIBONUS_LIRA_START_HINT",
		icon = "res://assets/images/portraits/lira_prt/lira_default_prt_kind.png",
		preparation = "prep_lira_start",
		cost = 15
	},
	kuro_start = {
		name = "ACHIBONUS_KURO_START",
		description = "ACHIBONUS_KURO_START_DESC",
		hint = "ACHIBONUS_KURO_START_HINT",
		icon = "res://assets/images/portraits/kuro_prt/kuro_default_prt_bold.png",
		preparation = "prep_kuro_start",
		cost = 25
	},
	zephyra_start = {
		name = "ACHIBONUS_ZEPHYRA_START",
		description = "ACHIBONUS_ZEPHYRA_START_DESC",
		hint = "ACHIBONUS_ZEPHYRA_START_HINT",
		icon = "res://assets/images/portraits/zephyra_prt/zephyra_default_prt_kind.png",
		preparation = "prep_zephyra_start",
		cost = 20
	},
	mae_start = {
		name = "ACHIBONUS_MAE_START",
		description = "ACHIBONUS_MAE_START_DESC",
		hint = "ACHIBONUS_MAE_START_HINT",
		icon = "res://assets/images/portraits/mae_prt/mae_default_prt_kind.png",
		preparation = "prep_mae_start",
		cost = 15
	},
	jean_start = {
		name = "ACHIBONUS_JEAN_START",
		description = "ACHIBONUS_JEAN_START_DESC",
		hint = "ACHIBONUS_JEAN_START_HINT",
		icon = "res://assets/images/portraits/jean_prt/jean_default_prt_kind.png",
		preparation = "prep_jean_start",
		cost = 15
	},
	hara_start = {
		name = "ACHIBONUS_HARA_START",
		description = "ACHIBONUS_HARA_START_DESC",
		hint = "ACHIBONUS_HARA_START_HINT",
		icon = "res://assets/images/portraits/hara_prt/hara_default_prt_kind.png",
		preparation = "prep_hara_start",
		cost = 20
	},
	lilia_start = {
		name = "ACHIBONUS_LILIA_START",
		description = "ACHIBONUS_LILIA_START_DESC",
		hint = "ACHIBONUS_LILIA_START_HINT",
		icon = "res://assets/images/portraits/lilia_prt/lilia_default_prt_kind.png",
		restricted_by = ["lilith_start"],
		preparation = "prep_lilia_start",
		cost = 15
	},
	lilith_start = {
		name = "ACHIBONUS_LILITH_START",
		description = "ACHIBONUS_LILITH_START_DESC",
		hint = "ACHIBONUS_LILITH_START_HINT",
		icon = "res://assets/images/portraits/lilia_prt/lilith_default_prt_kind.png",
		restricted_by = ["lilia_start"],
		preparation = "prep_lilith_start",
		cost = 20
	},
	rouge_start = {
		name = "ACHIBONUS_ROUGE_START",
		description = "ACHIBONUS_ROUGE_START_DESC",
		hint = "ACHIBONUS_ROUGE_START_HINT",
		icon = "res://assets/images/portraits/rouge_prt/rouge_default_prt_kind.png",
		preparation = "prep_rouge_start",
		cost = 25
	},
	exp_scrolls = {
		name = "ACHIBONUS_EXPSCROLLS",
		description = "ACHIBONUS_EXPSCROLLS_DESC",
		hint = "",
		icon = "res://assets/images/iconsitems/icon_scroll2.png",
		preparation = "prep_exp_scrolls",
		cost = 10
	},
	talent_points = {
		name = "ACHIBONUS_TALENT",
		description = "ACHIBONUS_TALENT_DESC",
		hint = "",
		icon = "res://assets/images/iconstraits/l_fortitude.png",
		preparation = "prep_talent_points",
		cost = 15
	},
	master_factor_points = {
		name = "ACHIBONUS_MASTER_FACTORS",
		description = "ACHIBONUS_MASTER_FACTORS_DESC",
		hint = "",
		icon = "res://assets/images/gui/gui icons/growth_factor.png",
		preparation = "prep_master_factor_points",
		cost = 10
	},
	craftsman = {
		name = "ACHIBONUS_CRAFTSMAN",
		description = "ACHIBONUS_CRAFTSMAN_DESC",
		hint = "",
		icon = "res://assets/images/gui/upgrades/upgrade_tier1.png",
		preparation = "prep_craftsman",
		cost = 5
	},
	rooms = {
		name = "ACHIBONUS_ROOMS",
		description = "ACHIBONUS_ROOMS_DESC",
		hint = "",
		icon = "res://assets/images/gui/upgrades/rooms.png",
		preparation = "prep_rooms",
		cost = 5
	},
	literate = {
		name = "ACHIBONUS_LITERATE",
		description = "ACHIBONUS_LITERATE_DESC",
		hint = "",
		icon = "res://assets/images/minor_training/literacy.png",
		preparation = "prep_literate",
		cost = 5
	},
}
var always_ulocked_bonuses = ["exp_scrolls", "talent_points", "master_factor_points", "craftsman", "rooms", "literate"]

func prepare_data():
	#infinite_levels group
	for achi in achievements.values():
		if achi.has("group") and achi.group == "infinite_levels":
			achi.name = tr("ACHIEVEMENT_DUNG_INF_NAME") % achi.level_text
			achi.description = tr("ACHIEVEMENT_DUNG_INF_DESC") % achi.level_text
			achi.hint = tr("ACHIEVEMENT_DUNG_INF_HINT") % achi.level_text
	
