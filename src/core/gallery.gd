extends Node
#it is important for scenes seqs to have scenes with correct and actual change_dialogue_type commands - for it is currently difficult to analyse those changes and adding commands to option accordingly
#so in a sample seq _8 and _4 are the most important
var scenes = {
	anastasia_execution = ["anastasia_execution_start","anastasia_execution_1","anastasia_execution_2","anastasia_execution_3","anastasia_execution_4","anastasia_execution_5","anastasia_execution_6","anastasia_execution_7","anastasia_execution_8"],
	lich_aire_talk = ["lich_aire_talk1","lich_aire_talk5","lich_aire_talk2","lich_aire_talk3","lich_aire_talk6_1","lich_aire_talk4_1","lich_aire_talk4_2","lich_aire_talk4_3","lich_aire_talk4_4"],
	xari_encounter = ["xari_encounter1","xari_encounter2","xari_encounter3","xari_encounter4","xari_encounter5","xari_encounter6",{scene = "xari_encounter7", variant = 3},"xari_encounter8"],
	daisy_admirer = ["daisy_admirer_message","daisy_admirer_message_1_3",{scene = "daisy_admirer_first_event_1",variant = 0},"daisy_admirer_first_event_2","daisy_admirer_first_event_3","daisy_admirer_first_event_4","daisy_admirer_first_event_5"],
	daisy_dress_acquired_normal = ["daisy_dress_acquired_normal_1","daisy_dress_acquired_normal_2",{scene = "daisy_dress_acquired_normal_3",variant = 0},"daisy_dress_acquired_normal_4_1","daisy_dress_acquired_normal_4_2","daisy_dress_acquired_normal_4_3","daisy_dress_acquired_normal_4_4","daisy_dress_acquired_normal_4_5"],
	daisy_training = ["daisy_training_1","daisy_training_2"],
	daisy_public = ["training_complete_fucktoy_1","training_complete_fucktoy_2","training_complete_fucktoy_3_1_1","training_complete_fucktoy_3_1_2","training_complete_fucktoy_3_1_3","training_complete_fucktoy_3_1_4"],
	daisy_consensual = ["daisy_consensual_1","daisy_consensual_2","daisy_consensual_3","daisy_consensual_4","daisy_consensual_5"],
	anastasia_sex = ["princess_cutscene_good_2", "princess_sex_good_1", "princess_sex_good_2", "princess_sex_good_3", "princess_sex_good_4", "princess_sex_good_5", "princess_sex_good_6", "princess_sex_good_7", "princess_sex_good_8"], #sample
	anastasia_rape = ["princess_cutscene_mindbreak_1", "princess_cutscene_mindbreak_2","princess_cutscene_mindbreak_3","princess_cutscene_mindbreak_4","princess_cutscene_mindbreak_5","princess_cutscene_mindbreak_6","princess_cutscene_mindbreak_7","princess_cutscene_mindbreak_8"],
	halloween_start = ["halloween_start","halloween_1","halloween_2","halloween_3","halloween_4","halloween_5","halloween_6","halloween_7","halloween_8","halloween_9","halloween_10","halloween_11","halloween_12"],
	aire_amelia1 = ["aire_amelia1","aire_amelia2","aire_amelia3","aire_amelia4","aire_amelia5","aire_amelia6"],
	amelia_titjob = ["amelia_silk_1","amelia_silk_2","amelia_silk_3","amelia_silk_4","amelia_silk_5","amelia_silk_6","amelia_silk_7","amelia_silk_8","amelia_silk_9","amelia_silk_10"],
	amelia_bondage = ["amelia_bondage_1","amelia_bondage_2","amelia_bondage_3","amelia_bondage_4","amelia_bondage_5","amelia_bondage_6","amelia_bondage_7","amelia_bondage_8","amelia_bondage_9"],
	anastasia_aire = ["aire_anastasia1","aire_anastasia2","aire_anastasia3"],
	aire_anal = ["ana_gryphon_sex_1","ana_gryphon_sex_2","ana_gryphon_sex_3","ana_gryphon_sex_4","ana_gryphon_sex_5","ana_gryphon_sex_6","ana_gryphon_sex_7","ana_gryphon_sex_8","ana_gryphon_sex_9","ana_gryphon_sex_10"],
	force_cali = ["force_cali_1","force_cali_2","force_cali_3","force_cali_4","force_cali_5","force_cali_6"],
	cali_touching = ["cali_sex_1_1","cali_sex_1_2","cali_sex_2_3","cali_sex_2","cali_sex_3_1","cali_sex_3_2","cali_sex_4"],
	cali_bj_happy = ["cali_sex_5","cali_sex_6","cali_sex_7","cali_sex_8","cali_sex_9","cali_sex_10","cali_sex_11","cali_sex_12","cali_sex_13"],
	cali_riding = ["cali_serve_start","cali_serve_2_1","cali_serve_2_2","cali_serve_2_3"],
	heleviel = ["after_temple_priestess_1","after_temple_priestess_2","after_temple_priestess_3","after_temple_priestess_4",{scene = "after_temple_priestess_5_1",variant = 1},"after_temple_priestess_5_1_2","after_temple_priestess_5_1_3","after_temple_priestess_5_1_4","after_temple_priestess_5_1_5","after_temple_priestess_5_1_6","after_temple_priestess_5_1and2"]
}	
#was forced to add a id to scene lists for unlock purpose
var scenes_order = ["anastasia_sex","anastasia_rape","anastasia_execution","lich_aire_talk","halloween_start","daisy_public","daisy_consensual","daisy_training","amelia_titjob","aire_amelia1","amelia_bondage","anastasia_aire","aire_anal","force_cali","cali_touching","xari_encounter","daisy_admirer","daisy_dress_acquired_normal","cali_bj_happy","cali_riding","heleviel"]
var story_scenes = ['church_event', 'jail', 'anastasia_event_alive', 'anastasia_event_dead', 'elven_temple_scene', 'act1_art', 'act2_art'] #maybe we should define this as 'scenes' unlocks and ero_scenes as 'backgrounds' unlocks - but for now there are no more and i can't add something like 'daisyevent' or 'aire_death'
var ero_scenes = [
 'anastasia_execution1', 'anastasia_execution2', 'anastasia_execution3',
 'lich_aire_talk4', 'lich_aire_talk7',
 'xari_encounter8',
 'daisy_discipline',
 'daisy_bj1', 'daisy_bj2', 'daisy_bj3', 'daisy_bj4', 'daisy_bj5', 'daisy_bj6',
 'daisy_training1', 'daisy_training2', 'daisy_training3', 'daisy_training4', 'daisy_training5',
 'daisy_public1', 'daisy_public2', 'daisy_public3', 'daisy_public4', 'daisy_public5',
 'daisy_bent1', 'daisy_bent2', 'daisy_bent3',
 'anastasia_sex_1', 'anastasia_sex_2', 'anastasia_sex_3',
 'anastasia_rape_1', 'anastasia_rape_2',
 'aire_amelia1', 'aire_amelia2',
 'amelia_titjob1', 'amelia_titjob2', 'amelia_titjob3',
 'amelia_bondage1', 'amelia_bondage2', 'amelia_bondage3',
 'anastasia_aire1', 'anastasia_aire2', 'anastasia_aire3',
 'aire_ana1', 'aire_ana2', 'aire_ana3', 'aire_ana4', 'aire_ana5', 'aire_ana6',
 'force_cali1', 'force_cali2', 'force_cali3', 'force_cali4', 'force_cali5', 'force_cali6',
 'mae_scene1', 'mae_scene2', 'mae_scene3', 'mae_scene4', 'mae_scene5', 'mae_scene6', 'mae_scene7', 'mae_scene8', 'mae_scene9', 'mae_scene10',
 'heleviel1', 'heleviel2', 'heleviel3', 'heleviel4',
'lilia_sex_1','lilia_sex_2','lilia_sex_3','lilia_sex_4',
'cali_touching_1','cali_touching_2','cali_touching_3','cali_touching_4',
'cali_bj_happy_1','cali_bj_happy_2','cali_bj_happy_3',
'amelia_cali_1','amelia_cali_2','amelia_cali_3',
'cali_riding_1','cali_riding_2','cali_riding_3',
'halloween_scene'] 

var ero_scenes_collection = {
	"anastasia_execution":["anastasia_execution1","anastasia_execution2","anastasia_execution3"],
	"lich_aire_talk":["lich_aire_talk4","lich_aire_talk7"],
	"xari_encounter":["xari_encounter8"],
	"daisy_discipline":["daisy_discipline"],
	"daisy_bj":["daisy_bj1","daisy_bj2","daisy_bj3","daisy_bj4","daisy_bj5","daisy_bj6"],
	"daisy_training":["daisy_training1","daisy_training2","daisy_training3","daisy_training4","daisy_training5"],
	"daisy_public":["daisy_public1","daisy_public2","daisy_public3","daisy_public4","daisy_public5"],
	"daisy_bent1":['daisy_bent1', 'daisy_bent2', 'daisy_bent3'],
	"anastasia_sex_":['anastasia_sex_1', 'anastasia_sex_2', 'anastasia_sex_3'],
	"anastasia_rape_":['anastasia_rape_1', 'anastasia_rape_2'],
	"aire_amelia":[ 'aire_amelia1', 'aire_amelia2'],
	"amelia_titjob":['amelia_titjob1', 'amelia_titjob2', 'amelia_titjob3'],
	"amelia_bondage":['amelia_bondage1', 'amelia_bondage2', 'amelia_bondage3'],
	"anastasia_aire":['anastasia_aire1', 'anastasia_aire2', 'anastasia_aire3'],
	"aire_ana":['aire_ana1', 'aire_ana2', 'aire_ana3', 'aire_ana4', 'aire_ana5', 'aire_ana6'],
	"force_cali":['force_cali1', 'force_cali2', 'force_cali3', 'force_cali4', 'force_cali5', 'force_cali6'],
	"mae_scene":['mae_scene1', 'mae_scene2', 'mae_scene3', 'mae_scene4', 'mae_scene5', 'mae_scene6', 'mae_scene7', 'mae_scene8', 'mae_scene9', 'mae_scene10'],
	"heleviel1":[ 'heleviel1', 'heleviel2', 'heleviel3', 'heleviel4'],
	"lilia_sex_":['lilia_sex_1','lilia_sex_2','lilia_sex_3','lilia_sex_4'],
	"cali_touching_":['cali_touching_1','cali_touching_2','cali_touching_3','cali_touching_4'],
	"cali_bj_happy_":['cali_bj_happy_1','cali_bj_happy_2','cali_bj_happy_3'],
	"amelia_cali_":['amelia_cali_1','amelia_cali_2','amelia_cali_3'],
	"cali_riding_":['cali_riding_1','cali_riding_2','cali_riding_3'],
	"halloween_scene":["halloween_scene"]
}
#so these arrays are needed for storing order 

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
		for line in data.text:
			if line.has("reqs"): line.reqs.clear()
		for line in data.text:
			if line.has("bonus_effects"): line.erase("bonus_effects")
		data.erase("save_scene_to_gallery")
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
