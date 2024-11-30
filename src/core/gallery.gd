extends Node
#it is important for scenes seqs to have scenes with correct and actual change_dialogue_type commands - for it is currently difficult to analyse those changes and adding commands to option accordingly
#so in a sample seq _8 and _4 are the most important
var scenes = {
	anastasia_execution = ["anastasia_execution_start","anastasia_execution_1","anastasia_execution_2","anastasia_execution_3","anastasia_execution_4","anastasia_execution_5","anastasia_execution_6","anastasia_execution_7","anastasia_execution_8"],
	lich_aire_talk = ["lich_aire_talk1","lich_aire_talk2","lich_aire_talk5","lich_aire_talk6_1","lich_aire_talk6_2","lich_aire_talk6_3","lich_aire_talk6_4","lich_aire_talk6_5","lich_aire_talk6_6","lich_aire_talk7"],
	lich_aire_talkk = ["lich_aire_talk1","lich_aire_talk2","lich_aire_talk3",{scene = "lich_aire_talk4",variant = 0},"lich_aire_talk4_1","lich_aire_talk4_2","lich_aire_talk4_3","lich_aire_talk4_4"],
	xari_encounter = ["xari_encounter1","xari_encounter2","xari_encounter3","xari_encounter4","xari_encounter5","xari_encounter6",{scene = "xari_encounter7", variant = 1},"xari_encounter8"],
	daisy_admirer = ["daisy_admirer_message","daisy_admirer_message_1_3",{scene = "daisy_admirer_first_event_1",variant = 0},"daisy_admirer_first_event_2","daisy_admirer_first_event_3","daisy_admirer_first_event_4","daisy_admirer_first_event_5"],
	daisy_dress_acquired_normal = ["daisy_dress_acquired_normal_1","daisy_dress_acquired_normal_2",{scene = "daisy_dress_acquired_normal_3",variant = 0},"daisy_dress_acquired_normal_4_1","daisy_dress_acquired_normal_4_2","daisy_dress_acquired_normal_4_3","daisy_dress_acquired_normal_4_4","daisy_dress_acquired_normal_4_5"],
	daisy_training = ["daisy_training_intermission_1","daisy_training_intermission_2","daisy_training_intermission_3","daisy_training_intermission_4","daisy_training_intermission_5","daisy_training_intermission_6","daisy_training_intermission_7"],
	daisy_public = ["training_complete_fucktoy_1","training_complete_fucktoy_2","training_complete_fucktoy_3_1_1","training_complete_fucktoy_3_1_2","training_complete_fucktoy_3_1_3","training_complete_fucktoy_3_1_4"],
	daisy_consensual = ["daisy_consensual_1","daisy_consensual_2","daisy_consensual_3","daisy_consensual_4","daisy_consensual_5"],
	anastasia_sex = ["princess_cutscene_good_1","princess_cutscene_good_2", "princess_sex_good_1", "princess_sex_good_2", "princess_sex_good_3", "princess_sex_good_4", "princess_sex_good_5", "princess_sex_good_6", "princess_sex_good_7", "princess_sex_good_8"], #sample
	anastasia_rape = ["princess_cutscene_mindbreak_1", "princess_cutscene_mindbreak_2","princess_cutscene_mindbreak_3","princess_cutscene_mindbreak_4","princess_cutscene_mindbreak_5","princess_cutscene_mindbreak_6","princess_cutscene_mindbreak_7","princess_cutscene_mindbreak_8"],
	aire_amelia1 = ["aire_amelia1","aire_amelia2","aire_amelia3","aire_amelia4","aire_amelia5","aire_amelia6"],
	amelia_titjob = ["amelia_silk_1","amelia_silk_2","amelia_silk_3","amelia_silk_4","amelia_silk_5","amelia_silk_6","amelia_silk_7","amelia_silk_8","amelia_silk_9","amelia_silk_10"],
	amelia_bondage = ["amelia_bondage_1","amelia_bondage_2","amelia_bondage_3","amelia_bondage_4","amelia_bondage_5","amelia_bondage_6","amelia_bondage_7","amelia_bondage_8","amelia_bondage_9"],
	anastasia_aire = ["aire_anastasia1","aire_anastasia2","aire_anastasia3"],
	aire_gryphon = ["ana_gryphon_sex_1","ana_gryphon_sex_2","ana_gryphon_sex_3","ana_gryphon_sex_4","ana_gryphon_sex_5","ana_gryphon_sex_6","ana_gryphon_sex_7","ana_gryphon_sex_8","ana_gryphon_sex_9","ana_gryphon_sex_10"],
	force_cali = ["force_cali_1","force_cali_2","force_cali_3","force_cali_4","force_cali_5","force_cali_6"],
	heleviel = ["after_temple_priestess_3","after_temple_priestess_4",{scene = "after_temple_priestess_5_1",variant = 1},"after_temple_priestess_5_1_2","after_temple_priestess_5_1_3","after_temple_priestess_5_1_4","after_temple_priestess_5_1_5","after_temple_priestess_5_1_6","after_temple_priestess_5_1and2"],
	lilia_sex = ["lilia_sex_scene_1","lilia_sex_scene_1_1","lilia_sex_scene_2","lilia_sex_scene_3","lilia_starting_2"],
	cali_touching = ["cali_sex_1_1","cali_sex_1_2","cali_sex_2_3","cali_sex_2","cali_sex_3_1","cali_sex_3_2","cali_sex_4"],
	cali_bj_happy = ["cali_sex_5","cali_sex_6","cali_sex_7","cali_sex_8","cali_sex_9","cali_sex_10","cali_sex_11","cali_sex_12","cali_sex_13"],
	cali_riding = ["cali_serve_start","cali_serve_2_1","cali_serve_2_2","cali_serve_2_3"],
	halloween_start = ["halloween_start","halloween_1","halloween_2","halloween_3","halloween_4","halloween_5","halloween_6","halloween_7","halloween_8","halloween_9","halloween_10","halloween_11","halloween_12"],
	christmas = ["christmas_pre_start","christmas_start","christmas_1","christmas_2","christmas_3","christmas_4","christmas_5","christmas_6","christmas_7","christmas_8","christmas_9","christmas_10"],
	heleviel_mansion = ["heleviel_mansion_1","heleviel_mansion_2","heleviel_mansion_3","heleviel_mansion_4","heleviel_mansion_5","heleviel_mansion_6","heleviel_mansion_7","heleviel_mansion_8"],
	lira_mansion = ["lira_mansion_1","lira_mansion_2","lira_mansion_3","lira_mansion_4","lira_mansion_5","lira_mansion_6","lira_mansion_7","lira_mansion_8","lira_mansion_9"],
	cali_zephyra = ["ZCEvent_9","ZCEvent_10","ZCEvent_11",],
	cali_act5_pet = ["cali_act5_pet_1","cali_act5_pet_2","cali_act5_pet_3","cali_act5_pet_4","cali_act5_pet_5","cali_act5_pet_6","cali_act5_pet_7","cali_act5_pet_8","cali_act5_pet_9_1","cali_act5_pet_9_2","cali_act5_pet_10"],
	cali_act6_naked = ["cali_act6_naked_1","cali_act6_naked_2","cali_act6_naked_3","cali_act6_naked_4","cali_act6_naked_5","cali_act6_naked_6","cali_act6_naked_7"],
	pre_ritual_blow = ["pre_ritual_blow_1","pre_ritual_blow_2","pre_ritual_blow_3","pre_ritual_blow_4","pre_ritual_7_3_3","pre_ritual_8","pre_ritual_10"],
	zephyra_lilia = ['zephyra_lilia_5', 'zephyra_lilia_6', 'zephyra_lilia_7', 'zephyra_lilia_8', 'zephyra_lilia_9'],
	amelia_sex = ['amelia_sex_1', 'amelia_sex_2', 'amelia_sex_3', 'amelia_sex_4', 'amelia_sex_5'],
	zephyra_disappearance_sex = ['zephyra_disappearance_sex_1', 'zephyra_disappearance_sex_2', 'zephyra_disappearance_sex_3', 'zephyra_disappearance_sex_4', 'zephyra_disappearance_sex_5'],
	zephyra_disappearance_guards = ['zephyra_disappearance_guards_1', 'zephyra_disappearance_guards_2', 'zephyra_disappearance_guards_3', 'zephyra_disappearance_guards_4', 'zephyra_disappearance_guards_5'],
	daisy_wedding = ['daisy_wedding_2_1', 'daisy_wedding_3', 'daisy_wedding_4', 'daisy_wedding_5', 'daisy_wedding_6'],
	cali_wedding = ['cali_wedding_2_1', 'cali_wedding_3', 'cali_wedding_4', 'cali_wedding_5', 'cali_wedding_6'],
	amelia_wedding = ['amelia_wedding_2_1', 'amelia_wedding_3', 'amelia_wedding_4_1', 'amelia_wedding_5', 'amelia_wedding_6'],
	lilia_transform_t = ['lilia_transform_1','lilia_transform_2','lilia_transform_3','lilia_transform_4'],
	lilia_transform_mc = ['lilia_transform_1','lilia_transform_5','lilia_transform_6','lilia_transform_7','lilia_transform_8'],
	lilith_blow = ['lilith_blow_1','lilith_blow_2','lilith_blow_3','lilith_blow_4','lilith_blow_5'],
	lilith_ride = ['lilith_ride_1', 'lilith_ride_2', 'lilith_ride_3', 'lilith_ride_4'],
	lilia_wedding = ['lilia_wedding_2', 'lilia_wedding_3', 'lilia_wedding_4', 'lilia_wedding_5', 'lilia_wedding_6', 'lilia_wedding_7'],
	lilith_wedding = ['lilith_wedding_1', 'lilith_wedding_2', 'lilith_wedding_3', 'lilith_wedding_4', 'lilith_wedding_5', 'lilith_wedding_6'],
	kuro_tome = ['kuro_tome_sex', 'kuro_tome_sex2', 'kuro_tome_sex3', 'kuro_tome_sex4', 'kuro_tome_sex5', 'kuro_tome_sex6', 'kuro_tome_sex7'],
	kuro_hideout = ['kuro_hideout_sex2', 'kuro_hideout_sex3', 'kuro_hideout_sex4', 'kuro_hideout_sex5', 'kuro_hideout_sex6'],
	kuro_zeph_tailjob = ['kuro_zeph_tailjob3', 'kuro_zeph_tailjob4', 'kuro_zeph_tailjob5', 'kuro_zeph_tailjob6', 'kuro_zeph_tailjob7', 'kuro_zeph_tailjob8'],
	kuro_wedding_pussy = ['kuro_wedding_1', 'kuro_wedding_2', 'kuro_wedding_pussy', 'kuro_wedding_pussy2']
}
#was forced to add a id to scene lists for unlock purpose
var scenes_order = [
	"anastasia_sex","anastasia_rape","anastasia_execution","lich_aire_talk","lich_aire_talkk","halloween_start",
	"daisy_public","daisy_consensual","daisy_training","amelia_titjob","aire_amelia1","amelia_bondage",
	"anastasia_aire","aire_gryphon","force_cali","cali_touching","xari_encounter","daisy_admirer",
	"daisy_dress_acquired_normal","cali_bj_happy","cali_riding","heleviel","lilia_sex","christmas",
	"heleviel_mansion","lira_mansion", "cali_zephyra","cali_act5_pet","cali_act6_naked","pre_ritual_blow",
	"zephyra_lilia", 'amelia_sex', 'zephyra_disappearance_sex', 'zephyra_disappearance_guards', 'daisy_wedding', 'cali_wedding', 'amelia_wedding', 'lilia_transform_t', 'lilia_transform_mc', 'lilith_blow', 'lilith_ride', 'lilia_wedding', 'lilith_wedding',
	'kuro_tome', 'kuro_hideout', 'kuro_zeph_tailjob', 'kuro_wedding_pussy'
	]
var story_scenes = ['anastasia_event_alive', 'elven_temple_scene', 'act1_art', 'act2_art'] #maybe we should define this as 'scenes' unlocks and ero_scenes as 'backgrounds' unlocks - but for now there are no more and i can't add something like 'daisyevent' or 'aire_death'
var ero_scenes = [
 'anastasia_execution1',
 'lich_aire_talk4',
 'xari_encounter8',
 'daisy_discipline',
 'daisy_bj1',
 'daisy_training1',
 'daisy_public1',
 'daisy_bent1',
 'anastasia_sex_1',
 'anastasia_rape_1', 
 'aire_amelia1',
 'amelia_titjob1',
 'amelia_bondage1',
# 'anastasia_aire1', uncomment it when it's possible to unlock this scene in-game
 'aire_ana1',
 'aire_ana4',
 'force_cali1',
 'mae_scene1',
 'mae_scene3',
 'heleviel_bj_1',
 'heleviel1',
 'lilia_sex_1_3',
'cali_touching_1',
'cali_bj_happy_1',
#'amelia_cali_1','amelia_cali_2','amelia_cali_3',
'cali_riding_1',
'halloween_scene',
'christmas_scene',
'lira_sex_1',
'cali_zephyra_1',
'cali_bowl_1',
'cali_bowl_naked_1',
'zephyra_bath_1',
'stag_sex_1',
'zephyra_lilia_1',
'amelia_sex1',
'zephyra_disappearance_sex_1',
'zephyra_disappearance_guards_1',
'daisy_wedding1',
'cali_wedding1',
'amelia_wedding1',
'lilia_transform_1',
'lilith_blow_1',
'lilith_ride_1',
'lilia_wedding_1',
'lilith_wedding_1',
'kuro_book_0_0',
'kuro_top_1',
'kuro_zephyra_1',
'kuro_wedding_1'
] 

var ero_scenes_collection = {
	"anastasia_execution":["anastasia_execution1","anastasia_execution2","anastasia_execution3"],
	"lich_aire_talk":["lich_aire_talk4","lich_aire_talk7"],
	"xari_encounter":["xari_encounter8"],
	"daisy_discipline":["daisy_discipline"],
	"daisy_bj":["daisy_bj1","daisy_bj3","daisy_bj4","daisy_bj6"],
	"daisy_training":["daisy_training1","daisy_training2","daisy_training3","daisy_training4","daisy_training5"],
	"daisy_public":["daisy_public1","daisy_public2","daisy_public3","daisy_public4","daisy_public5"],
	"daisy_bent":['daisy_bent1', 'daisy_bent2', 'daisy_bent3'],
	"anastasia_sex_":['anastasia_sex_1', 'anastasia_sex_2', 'anastasia_sex_3'],
	"anastasia_rape_":['anastasia_rape_1', 'anastasia_rape_2'],
	"aire_amelia":[ 'aire_amelia1', 'aire_amelia2'],
	"amelia_titjob":['amelia_titjob1', 'amelia_titjob2', 'amelia_titjob3'],
	"amelia_bondage":['amelia_bondage1', 'amelia_bondage2', 'amelia_bondage3'],
	"anastasia_aire":['anastasia_aire1', 'anastasia_aire2', 'anastasia_aire3'],
	"aire_ana":['aire_ana1', 'aire_ana2', 'aire_ana3','aire_ana4', 'aire_ana5', 'aire_ana6'],
	"force_cali":['force_cali1', 'force_cali2', 'force_cali3', 'force_cali4', 'force_cali5', 'force_cali6'],
	"mae_scene":['mae_scene1', 'mae_scene2'],
	"mae_scene_ritual":['mae_scene3', 'mae_scene4', 'mae_scene5', 'mae_scene6', 'mae_scene7'],
	"heleviel":[ 'heleviel1', 'heleviel2', 'heleviel3', 'heleviel4'],
	"heleviel_bj_":[ 'heleviel_bj_1', 'heleviel_bj_2', 'heleviel_bj_3'],
	"lilia_sex_1_":['lilia_sex_1_3'],
	"cali_touching_":['cali_touching_1','cali_touching_2','cali_touching_3','cali_touching_4'],
	"cali_bj_happy_":['cali_bj_happy_1','cali_bj_happy_2','cali_bj_happy_3'],
	"amelia_cali_":['amelia_cali_1','amelia_cali_2','amelia_cali_3'],
	"cali_riding_":['cali_riding_1','cali_riding_2','cali_riding_3'],
	"halloween_scene":["halloween_scene"],
	"lira_sex_":["lira_sex_1","lira_sex_2","lira_sex_3"],
	"cali_zephyra_":["cali_zephyra_1","cali_zephyra_2"],
	"cali_bowl_":["cali_bowl_1","cali_bowl_2"],
	"cali_bowl_naked_":["cali_bowl_naked_1","cali_bowl_naked_2","cali_bowl_naked_3","cali_bowl_naked_4"],
	"zephyra_bath_":["zephyra_bath_1","zephyra_bath_2","zephyra_bath_4"],
	"stag_sex_":["stag_sex_1","stag_sex_2","stag_sex_3"],
	'zephyra_lilia_' :['zephyra_lilia_1', 'zephyra_lilia_2','zephyra_lilia_3'],
	'amelia_sex':['amelia_sex1', 'amelia_sex2', 'amelia_sex3'],
	'zephyra_back_':['zephyra_back_1', 'zephyra_back_2', 'zephyra_back_3', 'zephyra_back_4'],
	'zephyra_facefuck_':['zephyra_facefuck_1', 'zephyra_facefuck_2', 'zephyra_facefuck_3', 'zephyra_facefuck_4'],
	'daisy_wedding': ['daisy_wedding1', 'daisy_wedding2', 'daisy_wedding3', 'daisy_wedding4'],
	'cali_wedding': ['cali_wedding1', 'cali_wedding2', 'cali_wedding3', 'cali_wedding4'],
	'amelia_wedding': ['amelia_wedding1', 'amelia_wedding2', 'amelia_wedding3', 'amelia_wedding4'],
	'lilia_transform_' : ['lilia_transform_1','lilia_transform_2','lilia_transform_3','lilia_transform_4','lilia_transform_5','lilia_transform_6','lilia_transform_7'],
	'lilith_blow_' : ['lilith_blow_1','lilith_blow_2','lilith_blow_3','lilith_blow_4','lilith_blow_5'],
	'lilith_ride_' : ['lilith_ride_1', 'lilith_ride_2', 'lilith_ride_3', 'lilith_ride_4'],
	'lilia_wedding_' : ['lilia_wedding_1', 'lilia_wedding_2', 'lilia_wedding_3', 'lilia_wedding_4', 'lilia_wedding_5', 'lilia_wedding_6', 'lilia_wedding_7', ],
	'lilith_wedding_' : ['lilith_wedding_1', 'lilith_wedding_2', 'lilith_wedding_3', 'lilith_wedding_4', 'lilith_wedding_5',],
	'kuro_book_0_' : ['kuro_book_0_0', 'kuro_book_0_1', 'kuro_book_0_2', 'kuro_book_0_3', 'kuro_book_0_4', 'kuro_book_0_5'],
	'kuro_top_' : ['kuro_top_1', 'kuro_top_2', 'kuro_top_3', 'kuro_top_4', 'kuro_top_5'],
	'kuro_zephyra_' : ['kuro_zephyra_1', 'kuro_zephyra_2', 'kuro_zephyra_3', 'kuro_zephyra_4', 'kuro_zephyra_5'],
	'kuro_wedding_' : ['kuro_wedding_1', 'kuro_wedding_2', 'kuro_wedding_3', 'kuro_wedding_4', 'kuro_wedding_5', 'kuro_wedding_6'],
}
#so these arrays are needed for storing order 

var scene_tooltips = {
	anastasia_execution1 = "ANASTASIA_EXECUTION1_SS",
	lich_aire_talk4 = "LICH_AIRE_TALK4_SS",
	xari_encounter8 = "XARI_ENCOUNTER8_SS",
	daisy_discipline = "DAISY_DISCIPLINE_SS", 
	daisy_bj1 = "DAISY_BJ1_SS",
	daisy_training1 = "DAISY_TRAINING1_SS",
	daisy_public1 = "DAISY_PUBLIC1_SS",
	daisy_bent1 = "DAISY_BENT1_SS",
	anastasia_sex_1 = "ANASTASIA_SEX_1_SS",
	anastasia_rape_1 = "ANASTASIA_RAPE_1_SS",
	aire_amelia1 = "AIRE_AMELIA1_SS",
	amelia_titjob1 = "AMELIA_TITJOB1_SS",
	amelia_bondage1 = "AMELIA_BONDAGE1_SS",
	anastasia_aire1 = "ANASTASIA_AIRE1_SS",
	aire_ana1 = "AIRE_ANA1_SS",
	aire_ana4 = "AIRE_ANA4_SS",
	force_cali1 = "FORCE_CALI1_SS",
	mae_scene1 = "MAE_SCENE1_SS",
	mae_scene3 = "MAE_SCENE3_SS",
	heleviel1 = "HELEVIEL1_SS",
	lilia_sex_1_3 = "LILIA_SEX_1_3_SS",
	cali_touching_1 = "CALI_TOUCHING_1_SS",
	cali_bj_happy_1 = "CALI_BJ_HAPPY_1_SS",
	cali_riding_1 = "CALI_RIDING_1_SS",
	halloween_scene = "HALLOWEEN_SCENE_SS",
	christmas_scene = "CHRISTMAS_SCENE_SS",
	heleviel_bj_1 = "HELEVIEL_MANSION_SS",
	lira_sex_1 = "LIRA_SEX_1_SS",
	cali_zephyra_1 = "CALI_ZEPHYRA_1_SS",
	cali_bowl_1 = "CALI_BOWL_1_SS",
	cali_bowl_naked_1 = "CALI_BOWL_NAKED_1_SS",
	zephyra_bath_1 = "ZEPHYRA_BATH_1_SS",
	stag_sex_1 = "STAG_SEX_1_SS",
	zephyra_lilia_1 = "ZEPHYRA_LILIA_1_SS",
	amelia_sex1 = "AMELIA_SEX_1_SS",
	zephyra_disappearance_sex_1 = "ZEPHYRA_DISAPPEARANCE_SEX_1_SS",
	zephyra_disappearance_guards_1 = "ZEPHYRA_DISAPPEARANCE_GUARDS_1_SS",
	daisy_wedding1 = "DAISY_WEDDING_SS",
	cali_wedding1 = "CALI_WEDDING_SS",
	anastasia_event_alive = "ANASTASIA_EVENT_ALIVE_SS",
	elven_temple_scene = "ELVEN_TEMPLE_SCENE_SS",
	act1_art = "ACT1_ART_SS",
	act2_art = "ACT2_ART_SS",
	amelia_wedding1 = "AMELIA_WEDDING_SS",
	lilia_transform_1 = "LILIA_TRANSFORM_SS",
	lilith_blow_1 = "LILITH_BLOW_SS",
	lilith_ride_1 = "LILITH_RIDE_SS",
	lilia_wedding_1 = "LILIA_WEDDING_SS",
	lilith_wedding_1 = "LILITH_WEDDING_SS",
	kuro_book_0_0 = "KURO_BOOK_SS",
	kuro_top_1 = "KURO_TOP_SS",
	kuro_zephyra_1 = "KURO_ZEPHYRA_SS",
	kuro_wedding_1 = "KURO_WEDDING_SS",
}


var close_template = {
	code = 'close',
	text = "DIALOGUECLOSE",
	type = 'next_dialogue',
	reqs = [],
	dialogue_argument = 1,
}
var continue_template = {
	code = '',
	text = "DIALOGUECONTINUE",
	type = 'next_dialogue',
	reqs = [],
	dialogue_argument = 1,
}

func _ready():
	for list in scenes.values():
		process_scene_seq(list)


func process_scene_seq(scene_list):
	for i in range(scene_list.size()):
		var scene = scene_list[i]
		var data
		var scname
		if typeof(scene) == TYPE_STRING:
			scname = scene
			data = scenedata.scenedict[scname].duplicate(true)
		elif typeof(scene) == TYPE_DICTIONARY:
			scname = scene.scene
			data = scenedata.scenedict[scname].duplicate(true)
			if scene.has("variant"):
				data = data.variations[scene.variant]
				data.erase("reqs")
			if scene.has("previous_option"):
				var temp_text = []
				for line in data.text:
					if line.has("previous_dialogue_option") and line.previous_dialogue_option != data.previous_option: continue
					if line.has("previous_dialogue_option"): line.erase("previous_dialogue_option")
					
					temp_text.push_back(line)
				data.text = temp_text
			#2add syntax for passing reqs
		else:
			print("error in template")
			return
		for line in data.text: # doesnt work with variations
			if line is Dictionary and line.has("reqs"): 
				line.reqs.clear()
		for line in data.text:
			if line is Dictionary and line.has("bonus_effects"): 
				line.erase("bonus_effects")
		data.erase("save_scene_to_gallery")
		data.erase("common_effects")
		#2add syntax for passing direct order to change dialogue type (or simply remove this nonsence)
		#modifying options
		var new_options = []
#		if i == scene_list.size() - 1:
#			new_options.push_back(close_template.duplicate())
#		else:
		for option in data.options:
			if new_options.size() > 0: break
			var nscene
			if i == scene_list.size() - 1:
				nscene = 'close'
			else:
				nscene = scene_list[i+1]
			if typeof(nscene) == TYPE_DICTIONARY:
				nscene = nscene.scene
			if option.code != nscene: continue
			var toption = option.duplicate(true)
			if toption.has("reqs"): toption.reqs.clear()
			if toption.has("bonus_effects"): toption.erase("bonus_effects")
			if i < scene_list.size() - 1: 
				toption.code = toption.code + "_gallery"
			new_options.push_back(toption)
		if new_options.empty():
			if i == scene_list.size() - 1:
				new_options.push_back(close_template.duplicate())
			else:
				var option = continue_template.duplicate()
				var nscene = scene_list[i+1]
				if typeof(nscene) == TYPE_DICTIONARY:
					nscene = nscene.scene
				option.code = nscene + "_gallery"
				new_options.push_back(option)
		data.options = new_options
		scenedata.scenedict[scname + "_gallery"] = data


func play_scene(index):
	var list = scenes[index]
	var sname = list[0]
	if typeof(sname) == TYPE_DICTIONARY:
		sname = sname.scene
	sname = sname + "_gallery"
	input_handler.interactive_message(sname, '', {})


func get_image_for_seq(id):
	#stub
	var res = null
	for scene in scenes[id]:
		var scname
		var data
		if typeof(scene) == TYPE_STRING:
			scname = scene
			data = scenedata.scenedict[scname + "_gallery"].duplicate(true)
		elif typeof(scene) == TYPE_DICTIONARY:
			scname = scene.scene
			data = scenedata.scenedict[scname + "_gallery"].duplicate(true)
		else: continue
		if data.has("custom_background"):
			if data.custom_background in ['whitescreen', 'blackscreen']:
				continue
			return data.custom_background
	return res


func unlock_all():
	for sc in story_scenes:
		if !input_handler.progress_data.story_scenes.has(sc):
			input_handler.progress_data.story_scenes.push_back(sc)
	for sc in ero_scenes:
		if !input_handler.progress_data.ero_scenes.has(sc):
			input_handler.progress_data.ero_scenes.push_back(sc)
	for sc in scenes_order:
		if !input_handler.progress_data.gallery_seq.has(sc):
			input_handler.progress_data.gallery_seq.push_back(sc)
	input_handler.store_progress()
