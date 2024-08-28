extends Control

var person
var root

var tr_data = {}
var tr_traits = []
var tr_rewards = []

func _ready():
	gather_data()
	$no_trainer/TextureButton.connect("pressed", self, 'build_trainer_list')
	$finished/reset_button.connect("pressed", self, 'reset_training')
	$training/complete_button.connect("pressed", self, 'finish_training')
	globals.connecttexttooltip($training/Tooltip, tr("INFOTRAINING"))
	


func hide_all():
	for cat in get_children():
		cat.visible = false

func gather_data(): 
	tr_data.clear()
	for tr in Skilldata.training_actions.values():
		if !globals.checkreqs(tr.reqs):
			continue
		if !tr_data.has(tr.type):
			tr_data[tr.type] = []
		tr_data[tr.type].push_back(tr.code)
	tr_traits.clear()
	tr_rewards.clear()
	for tr in Traitdata.traits.values():
		if tr.code == 'untrained':
			continue
		if !tr.has('tags'):
			continue
		if tr.tags.has('training'):
			tr_traits.push_back(tr.code)
		if tr.tags.has('training_success'):
			tr_rewards.push_back(tr.code)
		

func match_state():
	hide_all()
	if person.training.enable:
		if person.get_trainer() != null:
			build_training()
		else:
			build_no_trainer()
	else:
		build_posttrain()


func build_trainees(): #not used
	$trainees.visible = true
	var list = person.get_trainees()
	var empty = person.get_stat('trainee_amount') - list.size()
	input_handler.ClearContainer($trainees/Container, ['Button'])
	for id in list:
		var tchar = characters_pool.get_char_by_id(id)
		var panel = input_handler.DuplicateContainerTemplate($trainees/Container, 'Button')
		panel.get_node('icon').texture = tchar.get_icon()
		globals.connectslavetooltip(panel.get_node('icon'), tchar)
		panel.get_node('name').text = tchar.get_full_name()
	for i in range(empty):
		var panel = input_handler.DuplicateContainerTemplate($trainees/Container, 'Button')
		panel.get_node('icon').texture = null
		panel.get_node('name').text = ""


func build_no_trainer():
	$no_trainer.visible = true


func build_trainer_list():
	hide_all()
	$trainer_list.visible = true
	input_handler.ClearContainer($trainer_list/Container, ['Button'])
	for id in ResourceScripts.game_party.character_order:
		var tchar = characters_pool.get_char_by_id(id)
		if !tchar.can_be_trainer():
			continue
		var amount = tchar.get_stat('trainee_amount')
		var used = tchar.get_trainees().size()
		var panel = input_handler.DuplicateContainerTemplate($trainer_list/Container, 'Button')
		panel.get_node('icon').texture = tchar.get_icon()
		globals.connectslavetooltip(panel.get_node('icon'), tchar)
		panel.get_node('name').text = tchar.get_full_name() + "%d/%d" % [used, amount]
		panel.connect('pressed', self, 'assign_trainer', [id])
		if used >= amount:
			panel.disabled = true
			panel.get_node('icon').material = load("res://assets/sfx/bw_shader.tres")
		var text = ""
		for prof in tchar.xp_module.professions:
			var data = classesdata.professions[prof]
			if data.traits.has('trainer'):
				text += "%s, " % tr(data.name)
		text = text.trim_suffix(', ')
		panel.get_node('desc').text = text 


func assign_trainer(id):
	var tchar = characters_pool.get_char_by_id(id)
	tchar.add_trainee(person.id)
	match_state()


func build_posttrain():
	$finished.visible = true
	var spirit = person.get_stat('spirit')
	#add par about training result selection & other
	
	var text = "Trainings by the end of training:"
	var list = person.get_traits_by_tag('training')
	for tr in list:
		var trdata = Traitdata.traits[tr]
		text += "\n \t"
		text += tr(trdata.name)
	$finished/VBoxContainer/list.text = text
	
	var tmp = person.get_traits_by_tag('training_final')
	if !tmp.empty():
		var trdata = Traitdata.traits[tmp[0]]
		$finished/VBoxContainer/result_frame.visible = true
		$finished/VBoxContainer/select_text.visible = false
		$finished/VBoxContainer/rewards.visible = false
		if trdata.icon is String:
			$finished/VBoxContainer/result_frame/icon.texture = load(trdata.icon)
		else:
			$finished/VBoxContainer/result_frame/icon.texture = trdata.icon
		$finished/VBoxContainer/result_frame/header_text.text = tr(trdata.name)
		globals.connecttexttooltip($finished/VBoxContainer/result_frame, tr(trdata.descript))
	elif person.get_stat('spirit') >= variables.spirit_limits[2]:
		$finished/VBoxContainer/result_frame.visible = false
		$finished/VBoxContainer/select_text.visible = true
		$finished/VBoxContainer/rewards.visible = true
		input_handler.ClearContainer($finished/VBoxContainer/rewards, ['button'])
		for tr in tr_rewards:
			var trdata = Traitdata.traits[tr]
			var panel = input_handler.DuplicateContainerTemplate($finished/VBoxContainer/rewards, 'button')
			if trdata.icon is String:
				panel.get_node('icon').texture = load(trdata.icon)
			else:
				panel.get_node('icon').texture = trdata.icon
			globals.connecttexttooltip(panel, tr(trdata.name) + "\n" + tr(trdata.descript))
			panel.connect('pressed', self, 'select_final_trait', [tr])
	
	if spirit < variables.spirit_limits[0]:
		$finished/status.text = "Spirit status: broken"
	elif spirit < variables.spirit_limits[0]:
		$finished/status.text = "Spirit status: damaged"
	elif spirit < variables.spirit_limits[0]:
		$finished/status.text = "Spirit status: retained"
	else:
		$finished/status.text = "Spirit status: preserved"


func reset_training():
	person.reset_training()
	match_state()


func select_final_trait(tr_code):
	person.add_trait(tr_code)
	build_posttrain()


func build_training():
	gather_data()
	$training.visible = true
	globals.connecttexttooltip($training/d_button, person.get_dispositions_text()) 
	build_training_header()
	build_training_list()
	build_training_traits()


func build_training_header():
	var trainer = person.get_trainer()
	$training/trainer_frame/icon.texture = trainer.get_icon()
	$training/name.text = trainer.get_full_name()
	$training/spirit.text = "Character spirit: %.1f" % person.get_stat('spirit')
	$training/loyalty.text = "Character loyalty: %.1f" % person.get_stat('loyalty')


func build_training_list():
	var trainer = person.get_trainer()
	input_handler.ClearContainer($training/ScrollContainer/VBoxContainer, ['category'])
	for category in Skilldata.training_categories:
		var cat_data = Skilldata.training_categories[category]
		var amount = tr_data[category].size()
		for i in range((amount - 1)/ 3 + 1):
			var line = input_handler.DuplicateContainerTemplate($training/ScrollContainer/VBoxContainer, 'category')
			var start = i * 3
			var finish = i * 3 + 3
			if finish > amount:
				finish = amount
			for j in range(start, finish):
				var panel = input_handler.DuplicateContainerTemplate(line, 'Button')
				var tr = tr_data[category][j]
				var trdata = Skilldata.training_actions[tr]
				if cat_data.icon is String:
					panel.get_node('icon').texture = load(cat_data.icon)
				else:
					panel.get_node('icon').texture = cat_data.icon
				panel.get_node('name').text = tr(trdata.name)
				panel.connect('pressed', self, 'activate_training', [tr])
				#reqs check
				if !trainer.checkreqs(trdata.reqs_trainer):
					panel.disabled = true
					globals.connecttexttooltip(panel, tr('WRONGTRAINER'))
					panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.red))
				#avail check
				elif !person.training.available:
					panel.disabled = true
					globals.connecttexttooltip(panel, tr('ALREADYTRAINED'))
					panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.red))
				#cost check
				else:
					var f = true
					for stat in trdata.cost:
						match stat:
							'gold':
								f = f and (ResourceScripts.game_res.money >= trdata.cost[stat])
							'mana':
								f = f and (trainer.mp >= trdata.cost[stat])
					if !f:
						panel.disabled = true
						globals.connecttexttooltip(panel, tr('COSTNOTMET'))
						panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.red))
					else:
						globals.connecttexttooltip(panel, person.translate(tr(trdata.descript)))


func build_training_traits():
	$training/complete_button.disabled = !person.has_status('callmaster')
	$training/cost.text = "Trait unlock: %d loyalty" % person.get_training_cost()
	input_handler.ClearContainer($training/HBoxContainer2, ['Button'])
	for tr in tr_traits:
		var panel = input_handler.DuplicateContainerTemplate($training/HBoxContainer2, 'Button')
		var trdata = Traitdata.traits[tr]
		if trdata.icon is String:
			panel.get_node('icon').texture = load(trdata.icon)
		else:
			panel.get_node('icon').texture = trdata.icon
		globals.connecttexttooltip(panel, tr(trdata.descript))
		if person.check_trait(tr):
			panel.pressed = true
		else:
			panel.pressed = false
			if person.get_stat('loyalty') >= person.get_training_cost() and person.checkreqs(trdata.reqs): 
				panel.connect('toggled', self, 'press_trait', [tr])
			else:
				panel.disabled = true
				panel.material = load("res://assets/sfx/bw_shader.tres")
				panel.get_node('icon').material = load("res://assets/sfx/bw_shader.tres")


func activate_training(tr_code):
	var trdata = Skilldata.training_actions[tr_code]
	var trainer = person.get_trainer()
	for stat in trdata.cost:
		match stat:
			'gold':
				ResourceScripts.game_res.money -= trdata.cost[stat]
			'mana':
				trainer.mp -= trdata.cost[stat]
	person.apply_training(tr_code)
	build_training()


var selected_id = ""
func press_trait(value, tr_code):
	if !person.check_trait(tr_code):
		selected_id = tr_code
		var data = Traitdata.traits[tr_code]
		var text = "Unlock this for {color=green|" + str(person.get_training_cost()) + "} Loyalty?"
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'learn_upgrade_confirmed', tr(text)])
#		person.add_training(tr_code)
	build_training_traits()


func finish_training():
	person.finish_training()
	match_state()


func learn_upgrade_confirmed():
	if selected_id == "": return
	var data = Traitdata.traits[selected_id]
	var args = {}
	args["current_trait"] = selected_id
	args["person"] = person
	person.add_training(selected_id)
	selected_id = ""
	root.update()
	input_handler.play_animation("trait_aquired", args)
