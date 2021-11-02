extends Node
#it is important for scenes seqs to have scenes with correct and actual change_dialogue_type commands - for it is currently difficult to analyse those changes and adding commands to option accordingly
#so in a sample seq _8 and _4 are the most important
var scenes = {
	test_scene = ["princess_cutscene_good_2", "princess_sex_good_1", "princess_sex_good_2", "princess_sex_good_3", "princess_sex_good_4", "princess_sex_good_5", "princess_sex_good_6", "princess_sex_good_7", "princess_sex_good_8"], #sample
}
#was forced to add a id to scene lists for inlock purpose
var scenes_order = ['test_scene']
var story_scenes = ['church_event']
var ero_scenes = ['anastasia_sex_1', 'anastasia_sex_2', 'anastasia_sex_2', 'anastasia_sex_2', 'anastasia_sex_2', 'anastasia_sex_2', 'anastasia_sex_2', 'anastasia_sex_2', 'anastasia_sex_2', 'anastasia_sex_2']
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
				data = data.variants[scene.variant]
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
