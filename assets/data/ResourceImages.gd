extends Node

var backgrounds = {
	#backgrounds
	Null = null,
	mansion = "res://assets/images/backgrounds/mansion.png",
	dungeon = "res://assets/images/backgrounds/dungeon.png",
	garden = "res://assets/images/backgrounds/garden.png",
	aliron = "res://assets/images/backgrounds/Aliron.png",
	elf_capital = "res://assets/images/backgrounds/elf_capital.png",
	beastkin_capital = "res://assets/images/backgrounds/beastkin_capital.png",
	dwarfs_city = "res://assets/images/backgrounds/dwarf_city.png",
	
	forest1_menu = "res://assets/images/backgroundmenu/forest1.jpg",
	mountain1_menu = "res://assets/images/backgroundmenu/mountain1.jpg",
	mountain2_menu = "res://assets/images/backgroundmenu/mountain2.jpg",
	town1_menu = "res://assets/images/backgroundmenu/town1.jpg",
	town2_menu = "res://assets/images/backgroundmenu/town2.jpg",

	cave_1 = "res://assets/images/backgrounds/cave1.png",
	cave_2 = "res://assets/images/backgrounds/cave2.png",
	cave_3 = "res://assets/images/backgrounds/cave3.png",
	cave_4 = "res://assets/images/backgrounds/cave4.png",
	cave_5 = "res://assets/images/backgrounds/cave5.png",
	
	xari_hut = "res://assets/images/backgrounds/xari_hut.png",

	village1 = "res://assets/images/backgrounds/village.png",
	village2 = "res://assets/images/backgrounds/village1.png",
	village3 = "res://assets/images/backgrounds/village2.png",
	village4 = "res://assets/images/backgrounds/village3.png",

	forest1 = "res://assets/images/backgrounds/forest1.png",
	forest2 = "res://assets/images/backgrounds/forest2.png",
	forest3 = "res://assets/images/backgrounds/forest3.png",
	forest4 = "res://assets/images/backgrounds/forest4.png",
	
	spider_lair1 = "res://assets/images/backgrounds/spider_lair1.png",
	spider_lair2 = "res://assets/images/backgrounds/spider_lair2.png",
	spider_lair3 = "res://assets/images/backgrounds/spider_lair3.png",
	spider_lair4 = "res://assets/images/backgrounds/spider_lair4.png",

	crypt1 = "res://assets/images/backgrounds/crypt1.png",
	crypt2 = "res://assets/images/backgrounds/crypt2.png",
	crypt3 = "res://assets/images/backgrounds/crypt3.png",
	crypt4 = "res://assets/images/backgrounds/crypt4.png",
	crypt5 = "res://assets/images/backgrounds/crypt5.png",

	fort1 = "res://assets/images/backgrounds/fort1.png",
	fort2 = "res://assets/images/backgrounds/fort2.png",
	fort3 = "res://assets/images/backgrounds/fort3.png",

	jungle1 = "res://assets/images/backgrounds/jungle1.png",
	jungle2 = "res://assets/images/backgrounds/jungle2.png",
	jungle3 = "res://assets/images/backgrounds/jungle3.png",
	jungle4 = "res://assets/images/backgrounds/jungle4.png",

	fire_depths1 = "res://assets/images/backgrounds/fire_depths1.png",
	fire_depths2 = "res://assets/images/backgrounds/fire_depths2.png",
	fire_depths3 = "res://assets/images/backgrounds/fire_depths3.png",
	fire_depths4 = "res://assets/images/backgrounds/fire_depths4.png",
	
	combat_cave = "res://assets/images/combat_back/combat_cave.png",
	combat_crypt = "res://assets/images/combat_back/combat_crypt.png",
	combat_forest = "res://assets/images/combat_back/combat_forest.png",
	combat_fort = "res://assets/images/combat_back/combat_fort.png",
	combat_jungle = "res://assets/images/combat_back/combat_jungle.png",
	combat_volcano = "res://assets/images/combat_back/combat_volcano.png",
	
	fighters_guild = "res://assets/images/backgrounds/fighters_guild.png",
	mages_guild = "res://assets/images/backgrounds/mage_guild.png",
	servants_guild = "res://assets/images/backgrounds/servants_guild.png",
	workers_guild = "res://assets/images/backgrounds/workers_guild.png",
	#events
	anastasia_event_alive = "res://assets/images/fullscreen scenes/AnastasiaCG009.png",
	anastasia_event_dead = "res://assets/images/fullscreen scenes/AnastasiaCG010.png",
	anastasia_execution1 = "res://assets/images/fullscreen scenes/AnastasiaCG006.png",
	anastasia_execution2 = "res://assets/images/fullscreen scenes/AnastasiaCG007.png",
	anastasia_execution3 = "res://assets/images/fullscreen scenes/AnastasiaCG008.png",
	act1_art = "res://assets/images/fullscreen scenes/splash_pure_act1.png",
	act2_art = "res://assets/images/fullscreen scenes/splash_pure_act2.png",
	act3_art = "res://assets/images/fullscreen scenes/splash_act3.png",
	elven_temple_scene = "res://assets/images/fullscreen scenes/Scene_Elven_Temple.png",
	
	tower = "res://assets/images/backgrounds/tower.png",

	#custom dialogue backgrounds
	church_event = "res://assets/images/backgrounds/church.png",
	jail = "res://assets/images/backgrounds/dungeon.png",
	lich_aire_talk4 = "res://assets/images/fullscreen scenes/AireCG001.png",
	lich_aire_talk7 = "res://assets/images/fullscreen scenes/AireCG002.png",
	xari_encounter8 = "res://assets/images/fullscreen scenes/XariCG001.png",
	daisy_discipline = "res://assets/images/fullscreen scenes/DaisyCG001.png",

	daisy_bj_old_1 = "res://assets/images/fullscreen scenes/DaisyCG002.png",
	daisy_bj_old_2 = "res://assets/images/fullscreen scenes/DaisyCG003.png",
	daisy_bj_old_3 = "res://assets/images/fullscreen scenes/DaisyCG004.png",
	daisy_bj_old_4 = "res://assets/images/fullscreen scenes/DaisyCG005.png",
	daisy_bj_old_5 = "res://assets/images/fullscreen scenes/DaisyCG006.png",
	daisy_bj_old_6 = "res://assets/images/fullscreen scenes/DaisyCG007.png",
	
	daisy_bj1 = "res://assets/images/fullscreen scenes/DaisyCG029.png",
	daisy_bj2 = "res://assets/images/fullscreen scenes/DaisyCG030.png",#daisy_bj_old_1
	daisy_bj3 = "res://assets/images/fullscreen scenes/DaisyCG031.png",#daisy_bj_old_2
	daisy_bj4 = "res://assets/images/fullscreen scenes/DaisyCG032.png",#daisy_bj_old_3
	daisy_bj5 = "res://assets/images/fullscreen scenes/DaisyCG033.png",
	daisy_bj6 = "res://assets/images/fullscreen scenes/DaisyCG034.png",#daisy_bj_old_4
	daisy_bj7 = "res://assets/images/fullscreen scenes/DaisyCG035.png",#daisy_bj_old_5
	daisy_bj8 = "res://assets/images/fullscreen scenes/DaisyCG036.png",#daisy_bj_old_6
	daisy_bj9 = "res://assets/images/fullscreen scenes/DaisyCG037.png",
	daisy_bj10 = "res://assets/images/fullscreen scenes/DaisyCG038.png",
	daisy_bj11 = "res://assets/images/fullscreen scenes/DaisyCG039.png",
	daisy_bj12 = "res://assets/images/fullscreen scenes/DaisyCG040.png",
	
	daisy_training1 = "res://assets/images/fullscreen scenes/DaisyCG008.png",
	daisy_training2 = "res://assets/images/fullscreen scenes/DaisyCG009.png",
	daisy_training3 = "res://assets/images/fullscreen scenes/DaisyCG010.png",
	daisy_training4 = "res://assets/images/fullscreen scenes/DaisyCG011.png",
	daisy_training5 = "res://assets/images/fullscreen scenes/DaisyCG012.png",

	daisy_public1 = "res://assets/images/fullscreen scenes/DaisyCG013.png",
	daisy_public2 = "res://assets/images/fullscreen scenes/DaisyCG014.png",
	daisy_public3 = "res://assets/images/fullscreen scenes/DaisyCG015.png",
	daisy_public4 = "res://assets/images/fullscreen scenes/DaisyCG016.png",
	daisy_public5 = "res://assets/images/fullscreen scenes/DaisyCG017.png",
	
	daisy_bent1 = "res://assets/images/fullscreen scenes/DaisyCG018.png",
	daisy_bent2 = "res://assets/images/fullscreen scenes/DaisyCG019.png",
	daisy_bent3 = "res://assets/images/fullscreen scenes/DaisyCG020.png",
	
	daisy_wedding1 = "res://assets/images/fullscreen scenes/DaisyCG022.png",
	daisy_wedding2 = "res://assets/images/fullscreen scenes/DaisyCG023.png",
	daisy_wedding3 = "res://assets/images/fullscreen scenes/DaisyCG024.png",
	daisy_wedding4 = "res://assets/images/fullscreen scenes/DaisyCG025.png",
	daisy_wedding_anal1 = "res://assets/images/fullscreen scenes/DaisyCG026.png",
	daisy_wedding_anal2 = "res://assets/images/fullscreen scenes/DaisyCG027.png",
	daisy_wedding_anal3 = "res://assets/images/fullscreen scenes/DaisyCG028.png",

	anastasia_sex_1 = "res://assets/images/fullscreen scenes/AnastasiaCG001.png",
	anastasia_sex_2 = "res://assets/images/fullscreen scenes/AnastasiaCG002.png",
	anastasia_sex_3 = "res://assets/images/fullscreen scenes/AnastasiaCG003.png",
	anastasia_rape_1 = "res://assets/images/fullscreen scenes/AnastasiaCG004.png",
	anastasia_rape_2 = "res://assets/images/fullscreen scenes/AnastasiaCG005.png",
	aire_amelia1 = "res://assets/images/fullscreen scenes/AireAmeliaCG001.png",
	aire_amelia2 = "res://assets/images/fullscreen scenes/AireAmeliaCG002.png",

	amelia_titjob1 = "res://assets/images/fullscreen scenes/AmeliaCG001.png",
	amelia_titjob2 = "res://assets/images/fullscreen scenes/AmeliaCG002.png",
	amelia_titjob3 = "res://assets/images/fullscreen scenes/AmeliaCG003.png",

	amelia_bondage1 = "res://assets/images/fullscreen scenes/AmeliaCG004.png",
	amelia_bondage2 = "res://assets/images/fullscreen scenes/AmeliaCG005.png",
	amelia_bondage3 = "res://assets/images/fullscreen scenes/AmeliaCG006.png",

	amelia_sex1 = "res://assets/images/fullscreen scenes/AmeliaCG007.png",
	amelia_sex2 = "res://assets/images/fullscreen scenes/AmeliaCG008.png",
	amelia_sex3 = "res://assets/images/fullscreen scenes/AmeliaCG009.png",
	
	amelia_wedding1 = "res://assets/images/fullscreen scenes/AmeliaCG010.png",
	amelia_wedding2 = "res://assets/images/fullscreen scenes/AmeliaCG011.png",
	amelia_wedding3 = "res://assets/images/fullscreen scenes/AmeliaCG012.png",
	amelia_wedding4 = "res://assets/images/fullscreen scenes/AmeliaCG013.png",
	amelia_wedding_anal1 = "res://assets/images/fullscreen scenes/AmeliaCG014.png",
	amelia_wedding_anal2 = "res://assets/images/fullscreen scenes/AmeliaCG015.png",
	amelia_wedding_anal3 = "res://assets/images/fullscreen scenes/AmeliaCG016.png",

	anastasia_aire1 = "res://assets/images/fullscreen scenes/AnastasiaAireCG001.png",
	anastasia_aire2 = "res://assets/images/fullscreen scenes/AnastasiaAireCG002.png",
	anastasia_aire3 = "res://assets/images/fullscreen scenes/AnastasiaAireCG003.png",

	aire_ana1 = "res://assets/images/fullscreen scenes/AireAna001.png",
	aire_ana2 = "res://assets/images/fullscreen scenes/AireAna002.png",
	aire_ana3 = "res://assets/images/fullscreen scenes/AireAna003.png",
	aire_ana4 = "res://assets/images/fullscreen scenes/AireAna004.png",
	aire_ana5 = "res://assets/images/fullscreen scenes/AireAna005.png",
	aire_ana6 = "res://assets/images/fullscreen scenes/AireAna006.png",
	
	force_cali1 = "res://assets/images/fullscreen scenes/CaliCG001.png",
	force_cali2 = "res://assets/images/fullscreen scenes/CaliCG002.png",
	force_cali3 = "res://assets/images/fullscreen scenes/CaliCG003.png",
	force_cali4 = "res://assets/images/fullscreen scenes/CaliCG004.png",
	force_cali5 = "res://assets/images/fullscreen scenes/CaliCG005.png",
	force_cali6 = "res://assets/images/fullscreen scenes/CaliCG006.png",
	
	mae_scene1 = "res://assets/images/fullscreen scenes/MaeCG001.png",
	mae_scene2 = "res://assets/images/fullscreen scenes/MaeCG002.png",
	mae_scene3 = "res://assets/images/fullscreen scenes/MaeCG003.png",
	mae_scene4 = "res://assets/images/fullscreen scenes/MaeCG004.png",
	mae_scene5 = "res://assets/images/fullscreen scenes/MaeCG005.png",
	mae_scene6 = "res://assets/images/fullscreen scenes/MaeCG006.png",
	mae_scene7 = "res://assets/images/fullscreen scenes/MaeCG007.png",
	mae_scene8 = "res://assets/images/fullscreen scenes/MaeCG008.png",
	mae_scene9 = "res://assets/images/fullscreen scenes/MaeCG009.png",
	mae_scene10 = "res://assets/images/fullscreen scenes/MaeCG010.png",
	
	heleviel1 = "res://assets/images/fullscreen scenes/HelevielCG001.png",
	heleviel2 = "res://assets/images/fullscreen scenes/HelevielCG002.png",
	heleviel3 = "res://assets/images/fullscreen scenes/HelevielCG003.png",
	heleviel4 = "res://assets/images/fullscreen scenes/HelevielCG004.png",
	
	cali_bj_happy_1 = "res://assets/images/fullscreen scenes/CaliCG007.png",
	cali_bj_happy_2 = "res://assets/images/fullscreen scenes/CaliCG008.png",
	cali_bj_happy_3 = "res://assets/images/fullscreen scenes/CaliCG009.png",
	
	cali_bj_outside_1 = "res://assets/images/fullscreen scenes/CaliCG010.png",
	cali_bj_outside_2 = "res://assets/images/fullscreen scenes/CaliCG011.png",
	cali_bj_outside_3 = "res://assets/images/fullscreen scenes/CaliCG012.png",
	
	cali_touching_1 = "res://assets/images/fullscreen scenes/CaliCG013.png",
	cali_touching_2 = "res://assets/images/fullscreen scenes/CaliCG014.png",
	cali_touching_3 = "res://assets/images/fullscreen scenes/CaliCG015.png",
	cali_touching_4 = "res://assets/images/fullscreen scenes/CaliCG016.png",
	
	cali_fuck_1 = "res://assets/images/fullscreen scenes/CaliCG017.png",
	cali_fuck_2 = "res://assets/images/fullscreen scenes/CaliCG018.png",
	
	cali_bowl_1 = "res://assets/images/fullscreen scenes/CaliCG022.png",
	cali_bowl_2 = "res://assets/images/fullscreen scenes/CaliCG023.png",
	
	cali_bowl_naked_1 = "res://assets/images/fullscreen scenes/CaliCG024.png",
	cali_bowl_naked_2 = "res://assets/images/fullscreen scenes/CaliCG025.png",
	cali_bowl_naked_3 = "res://assets/images/fullscreen scenes/CaliCG026.png",
	cali_bowl_naked_4 = "res://assets/images/fullscreen scenes/CaliCG027.png",
	
	cali_riding_1 = "res://assets/images/fullscreen scenes/CaliCG019.png",
	cali_riding_2 = "res://assets/images/fullscreen scenes/CaliCG020.png",
	cali_riding_3 = "res://assets/images/fullscreen scenes/CaliCG021.png",
	
	cali_wedding1 = "res://assets/images/fullscreen scenes/CaliCG028.png",
	cali_wedding2 = "res://assets/images/fullscreen scenes/CaliCG029.png",
	cali_wedding3 = "res://assets/images/fullscreen scenes/CaliCG030.png",
	cali_wedding4 = "res://assets/images/fullscreen scenes/CaliCG031.png",
	cali_wedding_anal1 = "res://assets/images/fullscreen scenes/CaliCG032.png",
	cali_wedding_anal2 = "res://assets/images/fullscreen scenes/CaliCG033.png",
	cali_wedding_anal3 = "res://assets/images/fullscreen scenes/CaliCG034.png",
	
	amelia_cali_1 = "res://assets/images/fullscreen scenes/AmeliaCaliCG001.png",
	amelia_cali_2 = "res://assets/images/fullscreen scenes/AmeliaCaliCG002.png",
	amelia_cali_3 = "res://assets/images/fullscreen scenes/AmeliaCaliCG003.png",
	
	lilia_sex_1_1 = "res://assets/images/fullscreen scenes/LiliaCG001.png",
	lilia_sex_1_2 = "res://assets/images/fullscreen scenes/LiliaCG002.png",
	lilia_sex_1_3 = "res://assets/images/fullscreen scenes/LiliaCG003.png",
	lilia_sex_1_4 = "res://assets/images/fullscreen scenes/LiliaCG004.png",
	lilia_sex_2_1 = "res://assets/images/fullscreen scenes/LiliaCG005.png",
	lilia_sex_2_2 = "res://assets/images/fullscreen scenes/LiliaCG006.png",
	
	heleviel_bj_1 = "res://assets/images/fullscreen scenes/HelevielCG005.png",
	heleviel_bj_2 = "res://assets/images/fullscreen scenes/HelevielCG006.png",
	heleviel_bj_3 = "res://assets/images/fullscreen scenes/HelevielCG007.png",
	
	lira_sex_1 = "res://assets/images/fullscreen scenes/LiraCG001.png",
	lira_sex_2 = "res://assets/images/fullscreen scenes/LiraCG002.png",
	lira_sex_3 = "res://assets/images/fullscreen scenes/LiraCG003.png",
	
	halloween_scene = "res://assets/images/fullscreen scenes/AnaCaliCG001.png",
	christmas_scene = "res://assets/images/fullscreen scenes/DaisyCG021.png",
	cali_zephyra_1 = "res://assets/images/fullscreen scenes/CaliZephyraCG001.png",
	cali_zephyra_2 = "res://assets/images/fullscreen scenes/CaliZephyraCG002.png",
	
	zephyra_bath_1 = "res://assets/images/fullscreen scenes/ZephyraCG001.png", 
	zephyra_bath_2 = "res://assets/images/fullscreen scenes/ZephyraCG002.png",
	zephyra_bath_3 = "res://assets/images/fullscreen scenes/ZephyraCG003.png", 
	zephyra_bath_4 = "res://assets/images/fullscreen scenes/ZephyraCG004.png",
	
	stag_sex_1 = "res://assets/images/fullscreen scenes/StagCG001.png",
	stag_sex_2 = "res://assets/images/fullscreen scenes/StagCG002.png",
	stag_sex_3 = "res://assets/images/fullscreen scenes/StagCG003.png",
	
	zephyra_lilia_1 = "res://assets/images/fullscreen scenes/ZephyraLiliaCG001.png",
	zephyra_lilia_2 = "res://assets/images/fullscreen scenes/ZephyraLiliaCG002.png",
	zephyra_lilia_3 = "res://assets/images/fullscreen scenes/ZephyraLiliaCG003.png",
	
	zephyra_back_1 = "res://assets/images/fullscreen scenes/ZephyraCG005.png",
	zephyra_back_2 = "res://assets/images/fullscreen scenes/ZephyraCG006.png",
	zephyra_back_3 = "res://assets/images/fullscreen scenes/ZephyraCG007.png",
	zephyra_back_4 = "res://assets/images/fullscreen scenes/ZephyraCG008.png",
	
	zephyra_facefuck_1 = "res://assets/images/fullscreen scenes/ZephyraCG009.png",
	zephyra_facefuck_2 = "res://assets/images/fullscreen scenes/ZephyraCG010.png",
	zephyra_facefuck_3 = "res://assets/images/fullscreen scenes/ZephyraCG011.png",
	zephyra_facefuck_4 = "res://assets/images/fullscreen scenes/ZephyraCG012.png",
	
	lilia_transform_1 = "res://assets/images/fullscreen scenes/FairyCG010.png",
	lilia_transform_2 = "res://assets/images/fullscreen scenes/FairyCG011.png",
	lilia_transform_3 = "res://assets/images/fullscreen scenes/FairyCG014.png",
	lilia_transform_4 = "res://assets/images/fullscreen scenes/FairyCG018.png",
	lilia_transform_5 = "res://assets/images/fullscreen scenes/FairyCG013.png",
	lilia_transform_6 = "res://assets/images/fullscreen scenes/FairyCG016.png",
	lilia_transform_7 = "res://assets/images/fullscreen scenes/FairyCG019.png",
	
	lilith_blow_1 = "res://assets/images/fullscreen scenes/LilithCG001.png",
	lilith_blow_2 = "res://assets/images/fullscreen scenes/LilithCG002.png",
	lilith_blow_3 = "res://assets/images/fullscreen scenes/LilithCG004.png",
	lilith_blow_4 = "res://assets/images/fullscreen scenes/LilithCG005.png",
	
	lilith_ride_1 = "res://assets/images/fullscreen scenes/FairyCG006.png",
	lilith_ride_2 = "res://assets/images/fullscreen scenes/FairyCG007.png",
	lilith_ride_3 = "res://assets/images/fullscreen scenes/FairyCG008.png",
	
	lilia_wedding_1 = "res://assets/images/fullscreen scenes/LiliaCG007.png",
	lilia_wedding_2 = "res://assets/images/fullscreen scenes/LiliaCG008.png",
	lilia_wedding_3 = "res://assets/images/fullscreen scenes/LiliaCG009.png",
	lilia_wedding_4 = "res://assets/images/fullscreen scenes/LiliaCG010.png",
	lilia_wedding_5 = "res://assets/images/fullscreen scenes/LiliaCG011.png",
	lilia_wedding_6 = "res://assets/images/fullscreen scenes/LiliaCG012.png",
	lilia_wedding_7 = "res://assets/images/fullscreen scenes/LiliaCG013.png",
	
	lilith_wedding_1 = "res://assets/images/fullscreen scenes/LilithCG006.png",
	lilith_wedding_2 = "res://assets/images/fullscreen scenes/LilithCG007.png",
	lilith_wedding_3 = "res://assets/images/fullscreen scenes/LilithCG008.png",
	lilith_wedding_4 = "res://assets/images/fullscreen scenes/LilithCG009.png",
	lilith_wedding_5 = "res://assets/images/fullscreen scenes/LilithCG010.png",
	
	kuro_book_0_0 = "res://assets/images/fullscreen scenes/kuro_book_0.png",
	kuro_book_0_1 = "res://assets/images/fullscreen scenes/kuro_book_0_1.png",
	kuro_book_0_2 = "res://assets/images/fullscreen scenes/kuro_book_0_2.png",
	kuro_book_0_3 = "res://assets/images/fullscreen scenes/kuro_book_0_3.png",
	kuro_book_0_4 = "res://assets/images/fullscreen scenes/kuro_book_0_4.png",
	kuro_book_0_5 = "res://assets/images/fullscreen scenes/kuro_book_0_5.png",
	
	kuro_top_0 = "res://assets/images/fullscreen scenes/kuro_0.png",
	kuro_top_1 = "res://assets/images/fullscreen scenes/kuro_1.png",
	kuro_top_2 = "res://assets/images/fullscreen scenes/kuro_2.png",
	kuro_top_3 = "res://assets/images/fullscreen scenes/kuro_3.png",
	kuro_top_4 = "res://assets/images/fullscreen scenes/kuro_4.png",
	kuro_top_5 = "res://assets/images/fullscreen scenes/kuro_5.png",
	
	kuro_zephyra_1 = "res://assets/images/fullscreen scenes/Kuro_zephyra1.png",
	kuro_zephyra_2 = "res://assets/images/fullscreen scenes/Kuro_zephyra2.png",
	kuro_zephyra_3 = "res://assets/images/fullscreen scenes/Kuro_zephyra3.png",
	kuro_zephyra_4 = "res://assets/images/fullscreen scenes/Kuro_zephyra4.png",
	kuro_zephyra_5 = "res://assets/images/fullscreen scenes/Kuro_zephyra5.png",
	
	kuro_wedding_1 = "res://assets/images/fullscreen scenes/Kuro_wed1.png",
	kuro_wedding_2 = "res://assets/images/fullscreen scenes/Kuro_wed2.png",
	kuro_wedding_3 = "res://assets/images/fullscreen scenes/Kuro_wed3.png",
	kuro_wedding_4 = "res://assets/images/fullscreen scenes/Kuro_wed4.png",
	kuro_wedding_5 = "res://assets/images/fullscreen scenes/Kuro_wed5.png",
	kuro_wedding_6 = "res://assets/images/fullscreen scenes/Kuro_wed6.png",
	
	
	#masteries
	mastery_air = "res://assets/Textures_v2/CLASS_INFO/back_masteri/back_air.png",
	mastery_stealth = "res://assets/Textures_v2/CLASS_INFO/back_masteri/back_rogue.png",
	mastery_dark = "res://assets/Textures_v2/CLASS_INFO/back_masteri/back_darkness.png",
	mastery_leadership = "res://assets/Textures_v2/CLASS_INFO/back_masteri/back_leader.png",
	mastery_light = "res://assets/Textures_v2/CLASS_INFO/back_masteri/back_light.png",
	mastery_mind = "res://assets/Textures_v2/CLASS_INFO/back_masteri/back_mind.png",
	mastery_fire = "res://assets/Textures_v2/CLASS_INFO/back_masteri/back_pyro.png",
	mastery_marksmanship = "res://assets/Textures_v2/CLASS_INFO/back_masteri/back_marks2.png",
	mastery_earth = "res://assets/Textures_v2/CLASS_INFO/back_masteri/earth.png",
	mastery_water = "res://assets/Textures_v2/CLASS_INFO/back_masteri/back_water.png",
	mastery_protection = "res://assets/Textures_v2/CLASS_INFO/back_masteri/back_defence.png",
	mastery_warfare = "res://assets/Textures_v2/CLASS_INFO/back_masteri/back_warrior.png",
	
	#technical screens
	whitescreen = "res://assets/sfx/white.png",
	blackscreen = "res://assets/sfx/black.png",

	}

func get_background(id, cash = false):
	if !backgrounds.has(id):
		return null
	var res = backgrounds[id]
	if res is String:
		res = load(res)
		if cash:
			backgrounds[id] = res
	return res


var scenes = {
	no_image = load("res://assets/images/scenes/image_wip.png"),
	abuse = load("res://assets/images/scenes/abuse.png"),
	bosscapturefemale = load("res://assets/images/scenes/bosscapturefemale.png"),
	bosscapturemale = load("res://assets/images/scenes/bosscapturemale.png"),
	cell = load("res://assets/images/scenes/cell.png"),
	charm = load("res://assets/images/scenes/charm.png"),
	chest = load("res://assets/images/scenes/chest.png"),
	childbirth = load("res://assets/images/scenes/childbirth.png"),
	daisyconfess = "res://assets/images/scenes/daisyconfession.png",
	daisyevent = "res://assets/images/scenes/daisyevent.png",
	daisystart = "res://assets/images/scenes/daisystart.png",
	dungeonclear = load("res://assets/images/scenes/dungeonclear.png"),
	execution = load("res://assets/images/scenes/execution.png"),
	exotic_slaver = load("res://assets/images/scenes/exotic_slaver.png"),
	fear = load("res://assets/images/scenes/fear.png"),
	locationpurchase = load("res://assets/images/scenes/locationpurchase.png"),
	mindcontrol = load("res://assets/images/scenes/mindcontrol.png"),
	noevent = load("res://assets/images/scenes/noevent.png"),
	pot = load("res://assets/images/scenes/pot.png"),
	potmaj = load("res://assets/images/scenes/potmaj.png"),
	potmin = load("res://assets/images/scenes/potmin.png"),
	potused = load("res://assets/images/scenes/potused.png"),
	praise = load("res://assets/images/scenes/praise.png"),
	public_punish = load("res://assets/images/scenes/public_punish.png"),
	public_sex = load("res://assets/images/scenes/public_sex.png"),
	punish = load("res://assets/images/scenes/punish.png"),
	rebels_furry = load("res://assets/images/scenes/rebels_furry.png"),
	recruit = load("res://assets/images/scenes/recruit.png"),
	sedation = load("res://assets/images/scenes/sedation.png"),
	seduce = load("res://assets/images/scenes/seduce.png"),
	serve = load("res://assets/images/scenes/serve.png"),
	sexreward = load("res://assets/images/scenes/sexreward.png"),
	shackles = load("res://assets/images/scenes/shackles.png"),
	performance = load("res://assets/images/scenes/performance.png"),
	slaveescape = "res://assets/images/scenes/slaveescape.png",
	slavers_elf = load("res://assets/images/scenes/slavers_elf.png"),
	slave_decision = load("res://assets/images/scenes/slave_decision.png"),
	souleat = load("res://assets/images/scenes/souleat.png"),
	succubuslust = load("res://assets/images/scenes/succubuslust.png"),
	trap = load("res://assets/images/scenes/trap.png"),
	warn = load("res://assets/images/scenes/warn.png"),
	wolves_skirmish = "res://assets/images/scenes/wolves_skirmish.png",
	fairy = "res://assets/images/scenes/fairy.png",
	avermik = "res://assets/images/scenes/avermik.png",
	armory = load("res://assets/images/scenes/armory.png"),
	goblin_encounter = load("res://assets/images/scenes/goblin_encounter.png"),
	fairy_encounter = load("res://assets/images/scenes/fairy_encounter.png"),
	chest_mimic = load("res://assets/images/scenes/chest_mimic.png"),
	battlefield = load("res://assets/images/scenes/battlefield.png"),
	city_guards = "res://assets/images/scenes/city_guards.png",
	dome = "res://assets/images/scenes/dome.png",
	fred = "res://assets/images/scenes/fred.png",
	fred_mercs = "res://assets/images/scenes/fred_mercs.png",
	refugees = "res://assets/images/scenes/refugees.png",
	spring = "res://assets/images/scenes/spring.png",
	tribal_elves = load("res://assets/images/scenes/tribal_elves.png"),
	letter = load("res://assets/images/scenes/letter.png"),
	kobold = load("res://assets/images/scenes/kobold.png"),
	mines_quest = 'res://assets/images/scenes/mines_quest.png',
	aire_death = 'res://assets/images/scenes/aire_death.png',
	aire_wound = 'res://assets/images/scenes/aire_wound.png',
	tracking = 'res://assets/images/scenes/tracking.png',
	gryphon = 'res://assets/images/scenes/gryphon.png',
	temple_gates = 'res://assets/images/scenes/temple_gates.png',
	temple_source = 'res://assets/images/scenes/temple_source.png',
	temple_specters = 'res://assets/images/scenes/temple_specters.png',
	deer = 'res://assets/images/scenes/deer.png',
	leon = 'res://assets/images/scenes/leon.png',
	ritual = 'res://assets/images/scenes/ritual.png',
	mae_camp = 'res://assets/images/scenes/mae_camp.png',
	wedding = "res://assets/images/scenes/marriage.png",
	stone_sword = "res://assets/images/scenes/stone_sword.png",
	stone_sword2 = "res://assets/images/scenes/stone_sword2.png",
	goblins_traps = "res://assets/images/scenes/goblins_traps.png",
	forest_hut = "res://assets/images/scenes/forest_hut.png",
	forest_hut_fire = "res://assets/images/scenes/forest_hut_fire.png",
	hut_knife = "res://assets/images/scenes/hut_knife.png",
	hut_window ="res://assets/images/scenes/hut_window.png",
	interiour_hut = "res://assets/images/scenes/interiour_hut.png",
	interiour_hut_boy = "res://assets/images/scenes/interiour_hut_boy.png",
	kitchen_hut = "res://assets/images/scenes/kitchen_hut.png",
	ketch_hit = "res://assets/images/scenes/ketch_hit.png",
	ketch_trade = "res://assets/images/scenes/ketch_trade.png",
	zephyra_forest = "res://assets/images/scenes/zephyra_forest.png",
	zephyra_forest_shining = "res://assets/images/scenes/zephyra_forest_shining.png",
	zephyra_kiss = "res://assets/images/scenes/zephyra_kiss.png",
	zephyra_painting = "res://assets/images/scenes/Zephyra_painting.png",
	slave_drink = "res://assets/images/scenes/slave_drink.png",
	
	lilia_gem = "res://assets/images/scenes/lilia_gem.png",
	lilia_farewell= "res://assets/images/scenes/lilia_farewell.png",
	lilia_unicorn = "res://assets/images/scenes/lilia_unicorn.png",
	lilith_angry = "res://assets/images/scenes/lilith_angry.png",
	
	
	celena_shrine = load("res://assets/images/scenes/celena_shrine.png"),
	freya_shrine = load("res://assets/images/scenes/freya_shrine.png"),
	erebus_shrine = load("res://assets/images/scenes/erebus_shrine.png"),
	hybris_shrine = load("res://assets/images/scenes/altar.png"),
	cali_bandit_win = "res://assets/images/scenes/cali win.png",
	cali_mother_dead = "res://assets/images/scenes/cali mother.png",
	cali_meeting = "res://assets/images/scenes/conference.png",
	lilia_sick = "res://assets/images/scenes/lilia_sick.png",
	aire_hunter = "res://assets/images/scenes/aire_hunter.png",
	
	amelia_norlan = "res://assets/images/scenes/norlan.png",
	amelia_box = "res://assets/images/scenes/amelia_box.png",
	amelia_guards = "res://assets/images/scenes/amelia_guards.png",
	amelia_slave = "res://assets/images/scenes/amelia_slave.png",
	amelia_dungeon = "res://assets/images/scenes/amelia_dungeon.png",
	amelia_court = "res://assets/images/scenes/amelia_court.png",
	amelia_hostage = "res://assets/images/scenes/amelia_hostage.png",
	
	hire = load("res://assets/images/scenes/hire.png"),
	
	dungeon_door = load("res://assets/images/scenes/dungeon_door.png"),
	dungeon_broken_bridge = load("res://assets/images/scenes/dungeon_broken_bridge.png"),
	dungeon_cavein = load("res://assets/images/scenes/dungeon_cavein.png"),
	dungeon_forest_bridge = load("res://assets/images/scenes/dungeon_forest_bridge.png"),
	dungeon_enemies = load("res://assets/images/scenes/dungeon_enemies.png"),
	dungeon_gate = load("res://assets/images/scenes/dungeon_gate.png"),
	dungeon_fountain = load("res://assets/images/scenes/dungeon_fountain.png"),
	dungeon_magic_barrier = load("res://assets/images/scenes/dungeon_magic_barrier.png"),
	
	day_off = load("res://assets/images/scenes/day off.png"),
	grope = load("res://assets/images/scenes/grope.png"),
	kneel = load("res://assets/images/scenes/kneel.png"),
	mindread = load("res://assets/images/scenes/mindread.png"),
	public_use = load("res://assets/images/scenes/publicuse.png"), 
	reward = load("res://assets/images/scenes/reward.png"),
	slap = load("res://assets/images/scenes/slap.png"),
	spank = load("res://assets/images/scenes/spank.png"),
	strip = load("res://assets/images/scenes/strip.png"),
	
	#act 3
	dwarf_king_palace = "res://assets/images/scenes/dwarf_king_palace.png",
	dwarf_barman = "res://assets/images/scenes/barman.png",
	dwarf_goons = "res://assets/images/scenes/dwarf_goons.png",
	elven_prisoners = "res://assets/images/scenes/elven_prisoner.png",
	dwarf_guard = "res://assets/images/scenes/dwarf_guard.png",
	kobolds = "res://assets/images/scenes/kobolds.png",
	dwarf_machine = "res://assets/images/scenes/machine.png",
	kuro_dwarves = "res://assets/images/scenes/kuro_dwarves.png",
	rings_in_box = "res://assets/images/scenes/rings_in_box.png",
	dwarf_tavern_stranger = "res://assets/images/scenes/tavern stranger.png",
	dwarf_prison = "res://assets/images/scenes/dwarf_prison.png",
	dwarf_prison_attack = "res://assets/images/scenes/dwarf_prison_attack.png",
	dwarf_treasury = "res://assets/images/scenes/treasury.png",
	kobold_temple = "res://assets/images/scenes/kobold_temple.png",
	dwarf_prisoner = "res://assets/images/scenes/gnome_prisoner.png",
	dwarf_gates = "res://assets/images/scenes/dwarf_gates.png",
}

func get_scene(id):
	if !scenes.has(id):
		return null
	var res = scenes[id]
	if res is String:
		res = load(res)
	return res

var sprites = {
	amelia = load("res://assets/images/sprites/amelia.png"),
	duncan = load("res://assets/images/sprites/duncan.png"),
	sigmund = load("res://assets/images/sprites/sigmund.png"),
	myr = load("res://assets/images/sprites/myr.png"),
	anastasia = load("res://assets/images/sprites/anastasia.png"),
	anastasia_body = load("res://assets/images/sprites/anastasia_body.png"),
	aire = load("res://assets/images/sprites/aire.png"),
	aire_body = load("res://assets/images/sprites/aire_body.png"),
	xari = load("res://assets/images/sprites/xari.png"),
	ginny = load("res://assets/images/sprites/ginny.png"),
	kurdan = load("res://assets/images/sprites/kurdan.png"),
	kurdan_body = load("res://assets/images/sprites/kurdan_body.png"),
	ketch = load("res://assets/images/sprites/ketch.png"),
	ketch_body = load("res://assets/images/sprites/ketch.png"),
	demon_female = load("res://assets/images/sprites/demon_female.png"),
	greg = load("res://assets/images/sprites/greg.png"),
	heleviel = load("res://assets/images/sprites/heleviel.png"),
	zephyra = load("res://assets/images/sprites/zephyra.png"),
	zephyra_body = load("res://assets/images/sprites/zephyra_body.png"),
	zephyra_mad = load("res://assets/images/sprites/zephyra_neko.png"),
	kuro = load("res://assets/images/sprites/Kuro.png"),
	kuro_body = load("res://assets/images/sprites/Kuro_body.png"),
	daisy_default = load("res://assets/images/sprites/daisy_default.png"),
	daisy_default_body = load("res://assets/images/sprites/daisy_body.png"),
	daisy_default_happy = load("res://assets/images/sprites/daisy_happy.png"),
	daisy_default_happy_body = load("res://assets/images/sprites/daisy_happy_body.png"),
	daisy_maid = load("res://assets/images/sprites/daisy_maid.png"),
	daisy_maid_body = load("res://assets/images/sprites/daisy_maid_body.png"),
	daisy_maid_nude = load("res://assets/images/sprites/daisy_maid_nude.png"),
	daisy_maid_nude_body = load("res://assets/images/sprites/daisy_maid_nude_body.png"),
	daisy_christmas = load("res://assets/images/sprites/daisy_christmas.png"),
	daisy_christmas_body = load("res://assets/images/sprites/daisy_christmas_body.png"),
	lira = load("res://assets/images/sprites/Lira.png"),
	mae = load("res://assets/images/sprites/mae.png"),
	mae_body = load("res://assets/images/sprites/mae_body.png"),
	lilia = load("res://assets/images/sprites/lilia.png"),
	lilia_body = load("res://assets/images/sprites/lilia_body.png"),
	lilith = load("res://assets/images/sprites/lilith.png"),
	lilith_body = load("res://assets/images/sprites/lilith_body.png"),
	heleviel_body = load("res://assets/images/sprites/heleviel_body.png"),
	leon = load("res://assets/images/sprites/leon.png"),
	savra = load("res://assets/images/sprites/savra.png"),
	jean = load("res://assets/images/sprites/jean.png"),
	jean_body = load("res://assets/images/sprites/jean_body.png"),
	hara = load("res://assets/images/sprites/hara.png"),
	hara_body = load("res://assets/images/sprites/hara_body.png"),
	cali = load("res://assets/images/sprites/cali.png"),
	cali_body = load("res://assets/images/sprites/cali_body.png"),
	cali_collar = load("res://assets/images/sprites/cali_collar.png"),
	cali_collar_body = load("res://assets/images/sprites/cali_collar_body.png"),
	white_stag = load("res://assets/images/sprites/white_stag.png"),
	white_stag_body = load("res://assets/images/sprites/white_stag_body.png"),
	white_stag_christmas = load("res://assets/images/sprites/white_stag_christmas.png"),
	erlen = load("res://assets/images/sprites/Erlen.png"),
	lira_body = load("res://assets/images/sprites/lira_body.png"),
	bandits = load("res://assets/images/sprites/bandits.png"),
	
	cali_halloween = load("res://assets/images/sprites/cali_halloween.png"),
	cali_halloween_body = load("res://assets/images/sprites/cali_halloween_body.png"),
	anastasia_halloween = load("res://assets/images/sprites/anastasia_halloween.png"),
	anastasia_halloween_body = load("res://assets/images/sprites/anastasia_halloween_body.png"),
	
	daisy_nude = load("res://assets/images/sprites/daisy_nude.png"),
	daisy_nude_body = load("res://assets/images/sprites/daisy_nude_body.png"),
	daisy_wed = load("res://assets/images/sprites/daisy_wed.png"),
	daisy_wed_body = load("res://assets/images/sprites/daisy_wed_body.png"),
	cali_nude = load("res://assets/images/sprites/cali_nude.png"),
	cali_nude_body = load("res://assets/images/sprites/cali_nude_body.png"),
	cali_wed = load("res://assets/images/sprites/cali_wed.png"),
	cali_wed_body = load("res://assets/images/sprites/cali_wed_body.png"),
	aire_nude = load("res://assets/images/sprites/aire_nude.png"),
	aire_nude_body = load("res://assets/images/sprites/aire_nude_body.png"),
	anastasia_nude = load("res://assets/images/sprites/anastasia_nude.png"), 
	anastasia_nude_body = load("res://assets/images/sprites/anastasia_nude_body.png"),
	anastasia_wed = load("res://assets/images/sprites/anastasia_wed.png"), 
	anastasia_wed_body = load("res://assets/images/sprites/anastasia_wed_body.png"),
	zephyra_nude = load("res://assets/images/sprites/zephyra_nude.png"),
	zephyra_nude_body = load("res://assets/images/sprites/zephyra_nude_body.png"),
	kuro_nude = load("res://assets/images/sprites/Kuro_nude.png"),
	kuro_nude_body = load("res://assets/images/sprites/Kuro_nude_body.png"),
	kuro_wed = load("res://assets/images/sprites/Kuro_wed.png"),
	kuro_wed_body = load("res://assets/images/sprites/Kuro_wed_body.png"),
	zephyra_wed = load("res://assets/images/sprites/zephyra_wed.png"),
	zephyra_wed_body = load("res://assets/images/sprites/zephyra_wed_body.png"),
	zephyra_costume_7 = load("res://assets/images/sprites/zephyra_costume_7.png"),
	zephyra_costume_7_body = load("res://assets/images/sprites/zephyra_costume_7_body.png"),
	mae_nude = load("res://assets/images/sprites/mae_nude.png"),
	mae_nude_body = load("res://assets/images/sprites/mae_nude_body.png"),
	lilia_nude = load("res://assets/images/sprites/lilia_nude.png"),
	lilia_nude_body = load("res://assets/images/sprites/lilia_nude_body.png"),
	lilia_wed = load("res://assets/images/sprites/lilia_wed.png"),
	lilia_wed_body = load("res://assets/images/sprites/lilia_wed_body.png"),
	lilith_nude = load("res://assets/images/sprites/lilith_nude.png"), 
	lilith_nude_body = load("res://assets/images/sprites/lilith_nude_body.png"), 
	lilith_wed = load("res://assets/images/sprites/lilith_wed.png"),
	lilith_wed_body = load("res://assets/images/sprites/lilith_wed_body.png"),
	hara_nude = load("res://assets/images/sprites/hara_nude.png"),
	hara_nude_body = load("res://assets/images/sprites/hara_nude_body.png"),
	hara_wed = load("res://assets/images/sprites/hara_wed.png"),
	hara_wed_body = load("res://assets/images/sprites/hara_wed_body.png"),
	jean_nude = load("res://assets/images/sprites/jean_nude.png"),
	jean_nude_body = load("res://assets/images/sprites/jean_nude_body.png"),
	jean_wed = load("res://assets/images/sprites/jean_wed.png"),
	jean_wed_body = load("res://assets/images/sprites/jean_wed_body.png"),
	heleviel_nude = load("res://assets/images/sprites/heleviel_nude.png"),
	heleviel_nude_body = load("res://assets/images/sprites/heleviel_nude_body.png"),
	heleviel_wed = load("res://assets/images/sprites/heleviel_wed.png"),
	heleviel_wed_body = load("res://assets/images/sprites/heleviel_wed_body.png"),
	lira_nude = load("res://assets/images/sprites/Lira_nude.png"),
	lira_nude_body = load("res://assets/images/sprites/Lira_nude_body.png"),
	amelia_body = load("res://assets/images/sprites/amelia_body.png"),
	amelia_nude_body = load("res://assets/images/sprites/amelia_nude_body.png"),
	amelia_wed_body = load("res://assets/images/sprites/amelia_wed_body.png"),
	dwarf_king = load("res://assets/images/sprites/king.png"),
#	dwarf_king_body = load("res://assets/images/sprites/king_body.png"),#?
	zephyras_sister = load("res://assets/images/sprites/zephyrasister.png"),
#	zephyras_sister_body = load("res://assets/images/sprites/zephyrasister_body.png"),
#	zephyras_sister_nude = load("res://assets/images/sprites/zephyrasister_nude.png"),
#	zephyras_sister_nude_body = load("res://assets/images/sprites/zephyrasister_nude_body.png"),
	bolthar = load("res://assets/images/sprites/gnome.png"),
	keeper = load("res://assets/images/sprites/keeper.png"),
	alise = load("res://assets/images/sprites/alise.png"),
	}

func get_sprite(id):
	if !sprites.has(id):
		return null
	var res = sprites[id]
	if res is String:
		res = load(res)
	return res


var dynamic_backgrounds = {
	aliron = load("res://assets/dynamic_backgrounds/aliron.ogv"),
	elf_capital = load("res://assets/dynamic_backgrounds/elf_capital.ogv"),
	beastkin_capital = load("res://assets/dynamic_backgrounds/furry_camp.ogv"),
	dwarfs_city = load("res://assets/dynamic_backgrounds/dwarfs_city.ogv"),
}

var portraits = {
	daisy = 'res://assets/images/portraits/daisy_prt.png',
	daisy_nude = 'res://assets/images/portraits/daisy_nude_prt.png',
	daisy_wed = 'res://assets/images/portraits/daisy_wed_prt.png',
	daisy_sad = "res://assets/images/portraits/daisysad_prt.png",
	daisy_maid = 'res://assets/images/portraits/daisy_maid_prt.png',
	daisy_christmas = 'res://assets/images/portraits/daisy_christmas_prt.png',
	anastasia = "res://assets/images/portraits/anastasia_prt.png",
	anastasia_nude = "res://assets/images/portraits/anastasia_nude_prt.png",
	anastasia_wed = "res://assets/images/portraits/anastasia_wed_prt.png",
	aire = "res://assets/images/portraits/aire_prt.png",
	aire_nude = "res://assets/images/portraits/aire_nude_prt.png",
	kurdan = "res://assets/images/portraits/kurdan_prt.png",
	zephyra = 'res://assets/images/portraits/zephyra_prt.png',
	zephyra_nude = 'res://assets/images/portraits/zephyra_nude_prt.png',
	zephyra_wed = 'res://assets/images/portraits/zephyra_wed_prt.png',
	zephyra_costume_7 = 'res://assets/images/portraits/zephyra_7_prt.png',
	mae = "res://assets/images/portraits/mae_prt.png",
	mae_nude = "res://assets/images/portraits/mae_nude_prt.png",
	lilia = "res://assets/images/portraits/lilia_prt.png",
	lilia_nude = "res://assets/images/portraits/lilia_nude_prt.png",
	lilia_wed = "res://assets/images/portraits/lilia_wed_prt.png",
	lilith = "res://assets/images/portraits/lilia_prt/lilith_prt.png",
	lilith_nude = "res://assets/images/portraits/lilia_prt/lilith_nude_prt_bold.png",
	lilith_wed = "res://assets/images/portraits/lilia_prt/lilith_wed_prt_bold.png", 
	jean = "res://assets/images/portraits/jean_prt.png",
	jean_nude = "res://assets/images/portraits/jean_nude_prt.png",
	jean_wed = "res://assets/images/portraits/jean_wed_prt.png",
	hara = "res://assets/images/portraits/hara_prt.png",
	hara_nude = "res://assets/images/portraits/hara_nude_prt.png",
	hara_wed = "res://assets/images/portraits/hara_wed_prt.png",
	cali = "res://assets/images/portraits/cali_prt.png",
	cali_nude = "res://assets/images/portraits/cali_nude_prt.png",
	cali_wed = "res://assets/images/portraits/cali_wed_prt.png",
	heleviel = "res://assets/images/portraits/heleviel_prt.png",
	heleviel_nude = "res://assets/images/portraits/heleviel_nude_prt.png",
	heleviel_wed = "res://assets/images/portraits/heleviel_wed_prt.png",
	lira = "res://assets/images/portraits/lira_prt.png",
	lira_nude = "res://assets/images/portraits/lira_nude_prt.png",
	cali_halloween = "res://assets/images/portraits/cali_halloween_prt.png",
	cali_collar = "res://assets/images/portraits/cali_collar_prt.png",
	anastasia_halloween = "res://assets/images/portraits/anastasia_halloween_prt.png",
	amelia = "res://assets/images/portraits/amelia_prt.png",
	amelia_nude = "res://assets/images/portraits/amelia_nude_prt.png",
	amelia_wed = "res://assets/images/portraits/amelia_wed_prt.png",
	kuro = "res://assets/images/portraits/Kuro_prt.png",
	kuro_nude = "res://assets/images/portraits/Kuro_prt_nude.png",
	kuro_wed = "res://assets/images/portraits/kuro_wed_prt.png",
}

func get_portrait(id):
	if !portraits.has(id):
		return null
	var res = portraits[id]
	if res is String: #always
		res = load(res)
	return res

var gui = {
	norm_back = load("res://assets/images/gui/text scene/textfieldpanel.png"),
	alt_back = load("res://assets/images/gui/text scene/textfieldpanel.png"), #stub
};


var icons = {
	food = "res://assets/images/gui/inventory/icon_food1.png",
	material = "res://assets/images/gui/inventory/icon_res1.png",
	'tool' : "res://assets/images/gui/inventory/icon_craft1.png",
	weapon = "res://assets/images/gui/inventory/icon_weap1.png",
	armor = "res://assets/images/gui/inventory/icon_armor1.png",
	costume = "res://assets/images/gui/inventory/icon_cosm1.png",
	usable = "res://assets/images/gui/inventory/icon_potion1.png",

	quest_dungeon = 'res://assets/images/gui/quest_dungeon.png',
	quest_char = "res://assets/images/gui/quest_char.png",
	quest_encounter = "res://assets/images/gui/quest_encounter.png",
	quest_enemy = "res://assets/images/gui/quest_enemy.png",
	quest_reputation = "res://assets/images/gui/quest_reputation.png",

	upgrade_farm = 'res://assets/images/buildings/upgrade_farm.png',

	stat_exp = "res://assets/images/gui/gui icons/base_exp.png",
	stat_gf = "res://assets/images/gui/gui icons/growth_factor.png",
	stat_pf = "res://assets/images/gui/gui icons/physics_factor.png",
	stat_wit = "res://assets/images/gui/gui icons/wit.png",
	stat_charm = "res://assets/images/gui/gui icons/charm.png",
	stat_sf = "res://assets/images/gui/gui icons/sex.png",
	stat_mf = "res://assets/images/gui/gui icons/magic_factor.png",
	stat_tf = "res://assets/images/gui/gui icons/tame_factor.png",
	stat_df = "res://assets/images/gui/gui icons/timid_factor.png",
	stat_bf = "res://assets/images/gui/gui icons/brave_factor.png",
	stat_obed = "res://assets/images/gui/obed_good.png",
	stat_fear = "res://assets/images/gui/fear_good.png",
	stat_cf = "res://assets/images/gui/gui icons/charm_factor.png",
	stat_food = "res://assets/images/gui/gui icons/food.png",
	obed_good = "res://assets/images/gui/obed_good.png",
	obed_bad = "res://assets/images/gui/obed_bad.png",

	food_love = "res://assets/images/gui/gui icons/food_love.png",
	food_hate = "res://assets/images/gui/gui icons/food_hate.png",
	meat = "res://assets/images/gui/gui icons/icon_meat.png",
	fish = "res://assets/images/gui/gui icons/icon_fish.png",
	vege = "res://assets/images/gui/gui icons/icon_veg.png",
	grain = "res://assets/images/gui/gui icons/icon_grain.png",

	fear1 = "res://assets/images/gui/gui icons/fear1.png",
	fear2 = "res://assets/images/gui/gui icons/fear2.png",
	fear3 = "res://assets/images/gui/gui icons/fear3.png",
	obed1 = "res://assets/images/gui/gui icons/obedience1.png",
	obed2 = "res://assets/images/gui/gui icons/obedience2.png",
	obed3 = "res://assets/images/gui/gui icons/obedience3.png",

	class_master = "res://assets/Textures_v2/MANSION/icon_master.png",
	class_servant = "res://assets/Textures_v2/MANSION/icon_servant.png",
	class_slave = "res://assets/Textures_v2/MANSION/icon_slave.png",
	class_heir = "res://assets/images/iconsclasses/renown_royalty.png", #temp, 2fix
	class_spouse = "res://assets/Textures_v2/MANSION/icon_ring.png", 

	quest_slave_delivery = "res://assets/images/gui/slavepanel/charm.png",
	quest_gold = 'res://assets/images/iconsitems/gold.png',
	complete_location = "res://assets/images/gui/quest_encounter.png",
	complete_dungeon = "res://assets/images/gui/quest_dungeon.png",
	reputation = "res://assets/images/gui/quest_reputation.png",

	craft_time = "res://assets/images/gui/craftgui/Time.png",

	work = 'res://assets/images/gui/gui icons/workicon.png',
	rest = 'res://assets/images/gui/gui icons/sleepicon.png',
	joy = 'res://assets/images/gui/gui icons/joyicon.png',

	male = "res://assets/Textures_v2/Universal/Icons/icon_male.png",
	female = "res://assets/Textures_v2//Universal/Icons/icon_female.png",
	futa = "res://assets/Textures_v2/Universal/Icons/icon_futa.png",

	alchemy = "res://assets/Textures_v2/MANSION/icon_alchemy_64.png",
	cooking = "res://assets/Textures_v2/MANSION/icon_cooking_64.png",
	smith = "res://assets/Textures_v2/MANSION/icon_blacksmith_64.png",
	tailor = "res://assets/Textures_v2/MANSION/icon_tailoring_64.png",
	upgrade = "res://assets/Textures_v2/MANSION/icon_upgrade_64.png",
	travel_city = "res://assets/Textures_v2/Universal/Icons/icon_travel_city.png",
	travel_dungeon = "res://assets/Textures_v2/Universal/Icons/icon_travel_dungeon.png",
	travel_event = "res://assets/Textures_v2/Universal/Icons/icon_travel_event.png",
	travel_village = "res://assets/Textures_v2/Universal/Icons/icon_travel_village.png",
	
	guilds_fighters = "res://assets/images/iconstraits/guilds_fighters.png",
	guilds_fighters_colored = "res://assets/images/iconstraits/guilds_fighters_color.png",
	guilds_mages = "res://assets/images/iconstraits/guilds_mages.png",
	guilds_mages_colored = "res://assets/images/iconstraits/guilds_mages_color.png",
	guilds_workers = "res://assets/images/iconstraits/guilds_workers.png",
	guilds_workers_colored = "res://assets/images/iconstraits/guilds_workers_color.png",
	guilds_servants = "res://assets/images/iconstraits/guilds_servants.png",
	guilds_servants_colored = "res://assets/images/iconstraits/guilds_servants_color.png",
	
	#dungeon
	chest = "res://assets/Textures_v2/DUNGEON/Icons/chest.png",
	man = "res://assets/Textures_v2/DUNGEON/Icons/bust.png",
	shrine = "res://assets/Textures_v2/DUNGEON/Icons/altar.png",
	exclaim = "res://assets/Textures_v2/DUNGEON/Icons/exclaim.png",
	question = "res://assets/Textures_v2/DUNGEON/Icons/question.png",
	
	#masteries gui
	frame_skill = "res://assets/Textures_v2/CLASS_INFO/skill_frames/skill_frame_grey_square.png",
	frame_skill_1 = "res://assets/Textures_v2/CLASS_INFO/skill_frames/skill_frame_gold_square.png",
	frame_skill_mask = "res://assets/Textures_v2/CLASS_INFO/skill_frames/skill_frame_grey_square_mask.png",
	frame_explore = "res://assets/Textures_v2/CLASS_INFO/skill_frames/skill_frame_grey_polygon.png",
	frame_explore_1 = "res://assets/Textures_v2/CLASS_INFO/skill_frames/skill_frame_gold_polygon.png",
	frame_explore_mask = "res://assets/Textures_v2/CLASS_INFO/skill_frames/skill_frame_grey_polygon_mask.png",
	frame_train = "res://assets/Textures_v2/CLASS_INFO/skill_frames/skill_frame_grey_rhomb.png",
	frame_train_1 = "res://assets/Textures_v2/CLASS_INFO/skill_frames/skill_frame_gold_rhomb.png",
	frame_train_mask = "res://assets/Textures_v2/CLASS_INFO/skill_frames/skill_frame_grey_rhomb_mask.png",
	frame_trait = "res://assets/Textures_v2/CLASS_INFO/skill_frames/skill_frame_grey_ellipse.png",
	frame_trait_1 = "res://assets/Textures_v2/CLASS_INFO/skill_frames/skill_frame_gold_ellipse.png",
	frame_trait_mask = "res://assets/Textures_v2/CLASS_INFO/skill_frames/skill_frame_grey_ellipse_mask.png",
	
	#masteries
	mastery_air = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/air.png",
	mastery_stealth = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/assassination.png",
	mastery_dark = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/darkness.png",
	mastery_leadership = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/leader.png",
	mastery_light = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/light.png",
	mastery_mind = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/mind.png",
	mastery_fire = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/pyro.png",
	mastery_marksmanship = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/shooting.png",
	mastery_earth = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/soil.png",
	mastery_water = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/water.png",
	mastery_protection = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/defence.png",
	mastery_warfare = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/weapon.png",
	
	mastery_point_combat = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/combat.png",
	mastery_point_magic = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/magic.png",
	mastery_point_universal = "res://assets/Textures_v2/CLASS_INFO/masteries_icons/universe.png",
#	TO COMPLETE AND USE IN DATA TABLES
#	NEED TO GET RID OF ALL LOAD FUNCTIONS
#	skill_abuse = "res://assets/images/iconsskills/abuse.png",
#	"res://assets/images/iconsskills/Acid-spit.png",
#	"res://assets/images/iconsskills/AcidBomb.png",
#	"res://assets/images/iconsskills/Aimed-strike.png",
#	"res://assets/images/iconsskills/arrowshower.png",
#	"res://assets/images/iconsskills/Attack.png",
#	skill_attract = "res://assets/images/iconsskills/Attract.png",
#	"res://assets/images/iconsskills/Barrier.png",
#	"res://assets/images/iconsskills/BloodMagic.png",
#	skill_charm = "res://assets/images/iconsskills/Charm.png",
#	skill_double_attack = "res://assets/images/iconsskills/comboattack.png",
#	skill_command = "res://assets/images/iconsskills/Command.png",
#	"res://assets/images/iconsskills/cripple.png",
#	"res://assets/images/iconsskills/Debilitate.png",
#	skill_attack = "res://assets/images/iconsskills/defaultattack.png",
#	skill_discipline = "res://assets/images/iconsskills/Discipline2.png",
#	skill_hardwork = "res://assets/images/iconsskills/Discipline.png",
#	skill_distract = "res://assets/images/iconsskills/distract.png",
#	skill_dragon_might = "res://assets/images/iconsskills/Drain.png",
#	"res://assets/images/iconsskills/Escape.png",
#	skill_publicexecution = "res://assets/images/iconsskills/Execution.png",
#	skill_fear = "res://assets/images/iconsskills/Fear.png",
#	"res://assets/images/iconsskills/firebolt.png",
#	"res://assets/images/iconsskills/FireBomb.png",
#	"res://assets/images/iconsskills/firestorm.png",
#	skill_greatseduce = "res://assets/images/iconsskills/Great_Seduce.png",
#	skill_lesser_heal = "res://assets/images/iconsskills/Heal.png",
#	skill_first_aid = "res://assets/images/iconsskills/HealBandage.png",
#	"res://assets/images/iconsskills/Heavy-Strike.png",
#	skill_ranged_attack = "res://assets/images/iconsskills/heavyshot.png",
#	skill_rserrated_shot = "res://assets/images/iconsskills/heavyshot.png",
#	"res://assets/images/iconsskills/icon_arrow_explode.png",
#	"res://assets/images/iconsskills/icon_dark.png",
#	"res://assets/images/iconsskills/icon_earth.png",
#	"res://assets/images/iconsskills/icon_eyes.png",
#	"res://assets/images/iconsskills/icon_ice.png",
#	"res://assets/images/iconsskills/icon_light.png",
#	"res://assets/images/iconsskills/icon_lightning.png",
#	"res://assets/images/iconsskills/icon_plant.png",
#	"res://assets/images/iconsskills/icon_tiny.png",
#	skill_innervate = "res://assets/images/iconsskills/Innervate.png",
#	skill_inspire = "res://assets/images/iconsskills/Inspire.png",
#	skill_mass_lesser_heal = "res://assets/images/iconsskills/lesserheal.png",
#	"res://assets/images/iconsskills/Lich-strike.png",
#	skill_drain = "res://assets/images/iconsskills/LifeDrain.png",
#	skill_shackles = "res://assets/images/iconsskills/Magic Shackles.png",
#	skill_drain_mana = "res://assets/images/iconsskills/ManaDrain.png",
#	"res://assets/images/iconsskills/meditate.png",
#	"res://assets/images/iconsskills/Mindblast.png",
#	"res://assets/images/iconsskills/Mindread.png",
#	skill_mindcontrol = "res://assets/images/iconsskills/Mind_Control.png",
#	skill_praise = "res://assets/images/iconsskills/Praise.png",
#	skill_protect = "res://assets/images/iconsskills/Protect.png",
#	skill_publichumiliation = "res://assets/images/iconsskills/PublicPunish.png",
#	skill_publicsexhumiliation = "res://assets/images/iconsskills/PublicSex.png",
#	skill_punish = "res://assets/images/iconsskills/Punish.png",
#	skill_stopmindcontrol = "res://assets/images/iconsskills/RemoveMindcontrol.png",
#	skill_reward = "res://assets/images/iconsskills/Reward.png",
#	skill_rewardsex = "res://assets/images/iconsskills/Reward_with_sex 3.png",
#	skill_sedate = "res://assets/images/iconsskills/Sedate.png",
#	"res://assets/images/iconsskills/Sedation.png",
#	skill_seduce = "res://assets/images/iconsskills/Seduce.png",
#	skill_serve = "res://assets/images/iconsskills/Serve2.png",
#	"res://assets/images/iconsskills/Serve.png",
#	skill_slash = "res://assets/images/iconsskills/Shackle.png",
#	"res://assets/images/iconsskills/slash.png",
#	skill_consume_soul = "res://assets/images/iconsskills/soulconsume.png",
#	skill_greatshavkles = "res://assets/images/iconsskills/Strong Magic Shackles.png",
#	skill_fire_attack = "res://assets/images/iconsskills/strongattack.png",
#	"res://assets/images/iconsskills/tackle.png",
#	"res://assets/images/iconsskills/taunt.png",
#	skill_trap = "res://assets/images/iconsskills/Trap.png",
#	skill_make_undead = "res://assets/images/iconsskills/TurnUndead.png",
#	skill_warn = "res://assets/images/iconsskills/Warn.png",
#	skill_weaponrefine = "res://assets/images/iconsskills/WeaponRefine.png",
#	"res://assets/images/iconsskills/windarrow.png"
}

func get_icon(id):
	if !icons.has(id):
		return null
	var res = icons[id]
	if res is String:
		res = load(res)
		icons[id] = res
	return res


var shades = {
	arachna_m = "res://assets/images/raceshades/Arachna_M.png",
	arachna_f = "res://assets/images/raceshades/Arachna_F.png",
	beastkinbunny_m = "res://assets/images/raceshades/Beastkin-Bunny_M.png",
	beastkinbunny_f = "res://assets/images/raceshades/Beastkin-Bunny_F.png",
	beastkincat_m = "res://assets/images/raceshades/Beastkin-Cat_M.png",
	beastkincat_f = "res://assets/images/raceshades/Beastkin-Cat_F.png",
	beastkinfox_m = "res://assets/images/raceshades/Beastkin-Fox_M.png",
	beastkinfox_f = "res://assets/images/raceshades/Beastkin-Fox_F.png",
	beastkintanuki_m = "res://assets/images/raceshades/Beastkin-Tanuki_M.png",
	beastkintanuki_f = "res://assets/images/raceshades/Beastkin-Tanuki_F.png",
	beastkinwolf_m = "res://assets/images/raceshades/Beastkin-Wolf_M.png",
	beastkinwolf_f = "res://assets/images/raceshades/Beastkin-Wolf_F.png",
	centaur_m = "res://assets/images/raceshades/Centaur_M.png",
	centaur_f = "res://assets/images/raceshades/Centaur_F.png",
	demon_m = "res://assets/images/raceshades/Demon_M.png",
	demon_f = "res://assets/images/raceshades/Demon_F.png",
	dragonkin_m = "res://assets/images/raceshades/Dragonkin_M.png",
	dragonkin_f = "res://assets/images/raceshades/Dragonkin_F.png",
	dryad_m = "res://assets/images/raceshades/Dryad_M.png",
	dryad_f = "res://assets/images/raceshades/Dryad_F.png",
	elf_m = "res://assets/images/raceshades/Elf_M.png",
	elf_f = "res://assets/images/raceshades/Elf_F.png",
	tribalelf_m = "res://assets/images/raceshades/Elf_M.png",
	tribalelf_f = "res://assets/images/raceshades/Elf_F.png",
	darkelf_m = "res://assets/images/raceshades/Elf_M.png",
	darkelf_f = "res://assets/images/raceshades/Elf_F.png",
	fairy_m = "res://assets/images/raceshades/Fairy_M.png",
	fairy_f = "res://assets/images/raceshades/Fairy_F.png",
	gnome_m = "res://assets/images/raceshades/Gnome_M.png",
	gnome_f = "res://assets/images/raceshades/Gnome_F.png",
	dwarf_m = "res://assets/images/raceshades/Dwarf_M.png",
	dwarf_f = "res://assets/images/raceshades/Dwarf_F.png",
	goblin_m = "res://assets/images/raceshades/Goblin_M.png",
	goblin_f = "res://assets/images/raceshades/Goblin_F.png",
	harpy_m = "res://assets/images/raceshades/Harpy_M.png",
	harpy_f = "res://assets/images/raceshades/Harpy_F.png",
	human_m = "res://assets/images/raceshades/Human_M.png",
	human_f = "res://assets/images/raceshades/Human_F.png",
	lamia_m = "res://assets/images/raceshades/Lamia_M.png",
	lamia_f = "res://assets/images/raceshades/Lamia_F.png",
	nereid_m = "res://assets/images/raceshades/Nereid_M.png",
	nereid_f = "res://assets/images/raceshades/Nereid_F.png",
	orc_m = "res://assets/images/raceshades/Orc_M.png",
	orc_f = "res://assets/images/raceshades/Orc_F.png",
	scylla_m = "res://assets/images/raceshades/Scylla_M.png",
	scylla_f = "res://assets/images/raceshades/Scylla_F.png",
	seraph_m = "res://assets/images/raceshades/Seraph_M.png",
	seraph_f = "res://assets/images/raceshades/Seraph_F.png",
	slime_m = "res://assets/images/raceshades/Slime_M.png",
	slime_f = "res://assets/images/raceshades/Slime_F.png",
	taurus_m = "res://assets/images/raceshades/Taurus_M.png",
	taurus_f = "res://assets/images/raceshades/Taurus_F.png",
	kobold_m = "res://assets/images/raceshades/Kobold_M.png",
	kobold_f = "res://assets/images/raceshades/Kobold_F.png",

}

func get_shade(id):
	if !shades.has(id):
		return null
	var res = shades[id]
	if res is String:
		res = load(res)
	return res


var ages = {
	teen = load("res://assets/images/iconsages/T.png"),
	adult = load("res://assets/images/iconsages/Y.png"),
	mature = load("res://assets/images/iconsages/M.png"),
}

var cursors = {
	default = load("res://assets/images/gui/universal/cursordefault.png"),
	attack = load("res://assets/images/gui/universal/cursorfight.png"),
	support = load("res://assets/images/gui/universal/cursorsupport.png"),
}

var GFX = {
	slash = load("res://assets/images/gfx/slash-effect.png"),
	fire = load("res://assets/sfx/fire_effect.png"),
	slice = "res://assets/Textures_v2/BATTLE/overlays/slice.png"
}

var GFX_sprites = {
	strike = 'res://assets/sfx/hit_animation/strike.tscn',
	arrow = 'res://assets/sfx/arrow.tscn',
	water_attack = 'res://assets/sfx/water_attack.tscn',
	firebolt = 'res://assets/sfx/hit_animation/firebolt.tscn',
	flame = 'res://assets/sfx/hit_animation/flame.tscn',
	earth_spike = "res://assets/sfx/hit_animation/earth_spike.tscn",
	decay = "res://assets/sfx/hit_animation/DecayEffect.tscn",
	}

var GFX_particles = {
#	heal = "res://assets/sfx/HealEffect.tscn",
	heal = "res://assets/sfx/heal.tscn",
	buff = "res://assets/sfx/buff.tscn",
	debuff = "res://assets/sfx/debuff.tscn",
	snow = "res://assets/sfx/snow.tscn",
	sparks = "res://assets/sfx/spark.tscn",
}



func loadimages(): 
#	for i in icons:
#		icons[i] = input_handler.loadimage(icons[i])
#	for i in backgrounds:
#		backgrounds[i] = input_handler.loadimage(backgrounds[i])
#	for i in scenes:
#		scenes[i] = input_handler.loadimage(scenes[i])
#	for i in shades:
#		shades[i] = input_handler.loadimage(shades[i])
#	for i in portraits:
#		portraits[i] = input_handler.loadimage(portraits[i])
#	for i in sprites:
#		sprites[i] = input_handler.loadimage(sprites[i])
	for i in cursors:
		cursors[i] = input_handler.loadimage(cursors[i])
	for i in GFX:
		GFX[i] = input_handler.loadimage(GFX[i])


func add_portrait_paths():
	var regex = RegEx.new()
	regex.compile("[ \\w-]+?(?=\\.)")
	for i in input_handler.dir_contents("res://assets/images/portraits"):
		var result = regex.search(i)
		if result and not "import" in i: 
			images.portraits[result.get_string()] = i

var upgrade_icons = {
	alchemy = load("res://assets/images/gui/upgrades/alchemy.png"),
	bedroom = load("res://assets/images/gui/upgrades/bedroom.png"),
	cotton = load("res://assets/images/gui/upgrades/cotton.png"),
	forge = load("res://assets/images/gui/upgrades/forge.png"),
	stables = load("res://assets/images/gui/upgrades/stables.png"),
	tailor = load("res://assets/images/gui/upgrades/tailor.png"),
	tattoo = load("res://assets/images/gui/upgrades/tattoo.png"),
	tortureroom = load("res://assets/images/gui/upgrades/tortureroom.png"),
	veges = load("res://assets/images/gui/upgrades/veges.png"),
	wheat = load("res://assets/images/gui/upgrades/wheat.png"),
	exotic_trader = load("res://assets/images/gui/upgrades/exotic_trader.png"),
	fishing = load("res://assets/images/gui/upgrades/fishing.png"),
	hunting = load("res://assets/images/gui/upgrades/hunting.png"),
	mining = load("res://assets/images/gui/upgrades/mining.png"),
	rooms = load("res://assets/images/gui/upgrades/rooms.png"),
	rooms_lux = load("res://assets/images/gui/upgrades/rooms_lux.png"),
	woodcutting = load("res://assets/images/gui/upgrades/woodcutting.png"),
	academy = load("res://assets/images/gui/upgrades/academy.png")

}

var upgrade_tiers = {
	1 : load("res://assets/images/gui/upgrades/upgrade_tier1.png"),
	2 : load("res://assets/images/gui/upgrades/upgrade_tier2.png"),
	3 : load("res://assets/images/gui/upgrades/upgrade_tier3.png"),
	4 : load("res://assets/images/gui/upgrades/upgrade_tier4.png"),
	5 : load("res://assets/images/gui/upgrades/upgrade_tier5.png"),
	6 : load("res://assets/images/gui/upgrades/upgrade_tier6.png"),
	7 : load("res://assets/images/gui/upgrades/upgrade_tier7.png"),
	8 : load("res://assets/images/gui/upgrades/upgrade_tier8.png"),
	9 : load("res://assets/images/gui/upgrades/upgrade_tier9.png"),
	10 : load("res://assets/images/gui/upgrades/upgrade_tier10.png"),


}

#var statsicons = {#not used at all O_o
#lub1 = load("res://assets/images/sexicons/lub1.png"),
#lub2 = load("res://assets/images/sexicons/lub2.png"),
#lub3 = load("res://assets/images/sexicons/lub3.png"),
#lub4 = load("res://assets/images/sexicons/lub4.png"),
#lub5 = load("res://assets/images/sexicons/lub5.png"),
#lust1 = load("res://assets/images/sexicons/lust1.png"),
#lust2 = load("res://assets/images/sexicons/lust2.png"),
#lust3 = load("res://assets/images/sexicons/lust3.png"),
#lust4 = load("res://assets/images/sexicons/lust4.png"),
#lust5 = load("res://assets/images/sexicons/lust5.png"),
#sens1 = load("res://assets/images/sexicons/sens1.png"),
#sens2 = load("res://assets/images/sexicons/sens2.png"),
#sens3 = load("res://assets/images/sexicons/sens3.png"),
#sens4 = load("res://assets/images/sexicons/sens4.png"),
#sens5 = load("res://assets/images/sexicons/sens5.png"),
#stress1 = load("res://assets/images/gui/obed_bad.png"),
#stress2 = load("res://assets/images/gui/obed_med.png"),
#stress3 = load("res://assets/images/gui/obed_good.png")
#}
#var combatfullpictures = { #not used
#	rat = load("res://assets/images/enemies/RatFull.png"),
#	ent = load("res://assets/images/enemies/EntFull.png"),
#	bigent = load("res://assets/images/enemies/BigEntFull.png"),
#	golem = load("res://assets/images/enemies/Golem.png"),
#	golemalt = load("res://assets/images/enemies/GolemAlt.png"),
#	spider = load("res://assets/images/enemies/Spider.png"),
#}
#var combatportraits = {
#	##enemies
#	rat = load("res://assets/images/enemies/RatIcon2.png"),
#	ent = load("res://assets/images/enemies/EntIcon.png"),
#	bigent = load("res://assets/images/enemies/BigEntIcon.png"),
#	golem = load("res://assets/images/enemies/GolemIcon.png"),
#	golemalt = load("res://assets/images/enemies/GolemAltIcon.png"),
#	spider = load("res://assets/images/enemies/SpiderIcon.png"),
#	}
