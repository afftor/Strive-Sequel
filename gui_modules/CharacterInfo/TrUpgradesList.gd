extends Control

var person
var root

var tr_data = {}
var tr_traits = []
var tr_traits_s = []
var tr_rewards = []

func _ready():
	gather_data()
	$no_trainer/TextureButton.connect("pressed", self, 'build_trainer_list')
	$training/trainer_frame.connect("pressed", self, 'build_trainer_list')
	$finished/reset_button.connect("pressed", self, 'reset_training')
	$training/complete_button.connect("pressed", self, 'finish_training')
	globals.connecttexttooltip($training/Tooltip, tr("INFOTRAINING"))
	globals.connecttexttooltip($trainer_list/tooltip, tr("INFOSLAVETRAINER"))
	$training/spirit.max_value = 100
	globals.connecttexttooltip($training/TextureRect, tr("LOYALTYTOOLTIP")) 
	globals.connecttexttooltip($training/TextureRect2, tr("SPIRITTOOLTIP")) 
	globals.connecttexttooltip($training/spirit, tr("SPIRITTOOLTIP")) 
	globals.connecttexttooltip($training/trainer_frame, tr("CLICKTOCHANGE"))
	
	globals.connecttexttooltip($finished/reset_button, tr("RESETTRAINREQ"))
	input_handler.register_btn_source("trainer_btn", self, "tut_get_no_trainer_btn")
	input_handler.register_btn_source("trainer_select_btn", self, "tut_get_trainer_select")
	input_handler.register_btn_source("praise_btn", self, "tut_get_praise_btn")
	input_handler.register_btn_source("obedience_btn", self, "tut_get_obedience_btn")
	

func tut_get_no_trainer_btn():
	return $no_trainer/TextureButton
func tut_get_trainer_select():
	return $trainer_list/Container2/Container.get_children()[0]
func tut_get_praise_btn():
	return $training/ScrollContainer/VBoxContainer.get_children()[0]
func tut_get_obedience_btn():
	return $training/HBoxContainer2.get_children()[1]

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
	tr_traits_s.clear()
	tr_rewards.clear()
	for tr in Traitdata.traits.values():
		if tr.code == 'untrained':
			continue
		if !tr.has('tags'):
			continue
		if tr.tags.has('training'):
			tr_traits.push_back(tr.code)
		if tr.tags.has('servant_training'):
			tr_traits_s.push_back(tr.code)
		if tr.tags.has('training_success'):
			tr_rewards.push_back(tr.code)
		

func match_state():
	hide_all()
	if person.get_stat('slave_class') in ['servant', 'servant_notax', 'heir']:
		build_training_servant()
	elif person.training.enable:
		if person.get_trainer() != null:
			build_training()
		else:
			build_no_trainer()
	else:
		build_posttrain()


func build_trainees(): #not used
	$trainees.visible = true
	var container = $trainees/ScrollContainer/Container
	var list = person.get_trainees()
	var empty = person.get_stat('trainee_amount') - list.size()
	input_handler.ClearContainer(container, ['Button'])
	for id in list:
		var tchar = characters_pool.get_char_by_id(id)
		var panel = input_handler.DuplicateContainerTemplate(container, 'Button')
		panel.get_node('icon').texture = tchar.get_icon()
		globals.connectslavetooltip(panel.get_node('icon'), tchar)
		panel.get_node('name').text = tchar.get_full_name()
	for i in range(empty):
		var panel = input_handler.DuplicateContainerTemplate(container, 'Button')
		panel.get_node('icon').texture = null
		panel.get_node('name').text = ""


func build_no_trainer():
	$no_trainer.visible = true


func build_trainer_list():
	hide_all()
	$trainer_list.visible = true
	input_handler.ClearContainer($trainer_list/Container2/Container, ['Button'])
	
	if person.get_trainer() != null:
		var panel = input_handler.DuplicateContainerTemplate($trainer_list/Container2/Container, 'Button')
		panel.get_node('icon').texture = load("res://assets/Textures_v2/MANSION/no.png")
		panel.get_node('name').text = tr('REMOVETRAINER')
		panel.connect('pressed', self, 'remove_trainer')
	
	for id in ResourceScripts.game_party.character_order:
		var tchar = characters_pool.get_char_by_id(id)
		if !tchar.can_be_trainer():
			continue
		var amount = tchar.get_stat('trainee_amount')
		var used = tchar.get_trainees().size()
		var panel = input_handler.DuplicateContainerTemplate($trainer_list/Container2/Container, 'Button')
		panel.get_node('icon').texture = tchar.get_icon()
		globals.connectslavetooltip(panel.get_node('icon'), tchar)
		panel.get_node('name').text = tchar.get_full_name() + " - Slaves Assigned: %d/%d" % [used, amount]
		panel.connect('pressed', self, 'assign_trainer', [id])
		var text = ""
		for prof in tchar.get_professions():
			var data = classesdata.professions[prof]
			if data.traits.has('trainer'):
				text += "%s, " % tr(data.name)
		text = text.trim_suffix(', ')
		if used >= amount:
			panel.disabled = true
			panel.get_node('icon').material = load("res://assets/sfx/bw_shader.tres")
			text += "\n" + tr('NOTRAINSLOTS')
		if id == person.training.trainer:
			panel.disabled = true
			panel.get_node('icon').material = load("res://assets/sfx/bw_shader.tres")
			text += "\n" + tr('ALREADYTRAINER')
		panel.get_node('desc').text = text 
	
	var panel = input_handler.DuplicateContainerTemplate($trainer_list/Container2/Container, 'Button')
	panel.get_node('icon').texture = load("res://assets/Textures_v2/MANSION/arrow_navigator.png")
	panel.get_node('name').text = tr('CANCEL')
	panel.connect('pressed', self, 'hide_training_list')
	


func hide_training_list():
	$trainer_list.visible = false
	match_state()


func assign_trainer(id):
	var tchar = characters_pool.get_char_by_id(id)
	tchar.add_trainee(person.id)
	match_state()


func remove_trainer():
	if person.get_trainer() != null:
		person.clear_training()
	match_state()


func build_posttrain():
	$finished.visible = true
	$finished/reset_button.disabled = (ResourceScripts.game_res.if_has_items('oblivion_potion', 'lt', 1))
	var spirit = person.get_stat('spirit')
	var spirit_1 = person.get_stat('spirit_1')
	$finished/status.text = tr('STATSPIRIT') + ": " + str(spirit) + "/" + str(spirit_1)
	var text = tr('TRAININGFINISHHEADER')
	var list = person.get_traits_by_tag('training')
	input_handler.ClearContainer($finished/VBoxContainer/HBoxContainer2, ['Button'])
	$finished/VBoxContainer/list.text = text
	for tr in list:
		var trdata = Traitdata.traits[tr]
#		text += "\n \t"
#		text += tr(trdata.name)
		var panel = input_handler.DuplicateContainerTemplate($finished/VBoxContainer/HBoxContainer2, 'Button')
		if trdata.icon is String:
			panel.get_node('icon').texture = load(trdata.icon)
		else:
			panel.get_node('icon').texture = trdata.icon
		globals.connecttexttooltip(panel, "[center]" +tr(trdata.name) + "[/center]\n" +  person.translate(tr(trdata.descript)))
	
	input_handler.ClearContainer($finished/VBoxContainer/HBoxContainer3, ['Button'])
	for tr in tr_rewards:
		var trdata = Traitdata.traits[tr]
		var panel = input_handler.DuplicateContainerTemplate($finished/VBoxContainer/HBoxContainer3, 'Button')
		panel.get_node('Label').text = str(trdata.cost)
		if trdata.icon is String:
			panel.get_node('icon').texture = load(trdata.icon)
		else:
			panel.get_node('icon').texture = trdata.icon
		if person.check_trait(tr):
			panel.pressed = true
			panel.get_node('Label').visible = false
			panel.disabled = true
			panel.texture_disabled = load("res://assets/Textures_v2/CHAR_INFO/loyalty/Assigned trainer/button traits/button_traits_hover.png")
		else:
			panel.pressed = false
			if spirit < trdata.cost:
				panel.disabled = true
				panel.get_node('Label').set("custom_colors/font_color", Color(variables.hexcolordict.k_red))
			else:
				panel.set_meta('trait', tr)
				panel.connect('toggled', self, 'press_trait_post', [tr])
				panel.get_node('Label').set("custom_colors/font_color", Color(variables.hexcolordict.green))
		globals.connecttexttooltip(panel, person.translate(trdata.descript))


func reset_training():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'reset_training_confirm', tr("RESETTRAINING")])


func reset_training_confirm():
	ResourceScripts.game_res.remove_item('oblivion_potion', 1)
	person.reset_training()
	person.try_breakdown('brk_training_reset')
	match_state()


func build_training():
	gather_data()
	$training.visible = true
	globals.connecttexttooltip($training/d_button, person.get_dispositions_text()) 
	build_training_header()
	build_training_list()
	build_training_traits()
	update_confirm_finish()


func build_training_servant():
	gather_data()
	var cost = person.get_servant_training_cost()
	$training_servant.visible = true
	$training_servant/cost.text = tr('TRAININGCOST') % cost
	
	var resistance_value = person.get_stat('resistance')
	var resistance_reduction = person.get_stat('resistance_red')
	var resistance_text
	if resistance_value > 0:
		resistance_text = tr('TRAININGLABELRESISTANCEDROP') % [
			resistance_value, resistance_reduction]
	else:
		resistance_text = tr('TRAININGLABELRESISTANCE') % resistance_value
	$training_servant/resistance/label.text = resistance_text
	globals.connecttexttooltip($training_servant/resistance, tr("TRAINSERVTOOLTIPRESISTANCE") % [person.get_short_name(), resistance_reduction])
	
	var loyalty_label = $training_servant/loyalty/label
	var loyalty_value = person.get_stat('loyalty')
	var loyalty_growth = person.get_loyalty_growth()
	loyalty_label.text = tr('TRAININGLABELLOYALTYGROW') % [
		floor(loyalty_value), loyalty_growth]
	var loyalty_color = variables.hexcolordict.yellow
	if loyalty_value >= cost:
		loyalty_color = variables.hexcolordict.green
	loyalty_label.set("custom_colors/font_color", Color(loyalty_color))
	globals.connecttexttooltip($training_servant/loyalty, tr("TRAINSERVTOOLTIPLOYALTY") % [
		person.get_short_name(), loyalty_growth])
	
	input_handler.ClearContainer($training_servant/HBoxContainer2, ['Button'])
	for tr in tr_traits_s:
		var panel = input_handler.DuplicateContainerTemplate($training_servant/HBoxContainer2, 'Button')
		var trdata = Traitdata.traits[tr]
		if trdata.icon is String:
			panel.get_node('icon').texture = load(trdata.icon)
		else:
			panel.get_node('icon').texture = trdata.icon
		globals.connecttexttooltip(panel, "[center]" + tr(trdata.name) + "[/center]\n"+ person.translate(tr(trdata.descript)))
		if person.check_trait(tr):
			panel.pressed = true
		else:
			panel.pressed = false
			if person.get_stat('loyalty') >= cost and person.checkreqs(trdata.reqs) and person.training.check_stored_reqs(tr):
				panel.connect('toggled', self, 'press_trait_servant', [tr])
			else:
				panel.disabled = true
				panel.material = load("res://assets/sfx/bw_shader.tres")
				panel.get_node('icon').material = load("res://assets/sfx/bw_shader.tres")


func build_training_header():
	var trainer = person.get_trainer()
	$training/trainer_frame/icon.texture = trainer.get_icon()
	$training/name.text = "Trainer: " + trainer.get_full_name()
#	$training/spirit.text = tr('TRAININGLABELSPIRIT') % person.get_stat('spirit')
	$training/spirit.value = person.get_stat('spirit')
	
	var resistance_value = person.get_stat('resistance')
	var resistance_reduction = person.get_stat('resistance_red')
	var resistance_text
	if resistance_value > 0:
		resistance_text = tr('TRAININGLABELRESISTANCEDROP') % [
			resistance_value, resistance_reduction]
	else:
		resistance_text = tr('TRAININGLABELRESISTANCE') % resistance_value
	$training/resistance/label.text = resistance_text
	var penalty_data = person.get_loyalty_penalty_data()
	globals.connecttexttooltip($training/resistance, "%s\n{color=%s|%s}" % [
		(tr("TRAININGTOOLTIPRESISTANCE") % [
			person.get_short_name(), resistance_reduction]
		),
		penalty_data.color, tr(penalty_data.text)
	])
	
	var loyalty_label = $training/loyalty
	var loyalty_value = person.get_stat('loyalty')
	loyalty_label.text = tr('TRAININGLABELLOYALTY') % floor(loyalty_value)
	var loyalty_color = variables.hexcolordict.yellow
	if loyalty_value >= person.get_training_cost():
		loyalty_color = variables.hexcolordict.green
	loyalty_label.set("custom_colors/font_color", Color(loyalty_color))
	
	if person.has_resistance_block():
		$training/cd.text = tr ('TRAINRESISTANT')
	else:
		$training/cd.text = tr ('TRAINREADY')

 
func build_training_list():
	var trainer = person.get_trainer()
	input_handler.ClearContainer($training/ScrollContainer/VBoxContainer, ['Button'])
	for category in Skilldata.training_categories:
		var cat_data = Skilldata.training_categories[category]
		var amount = tr_data[category].size()
		for tr in tr_data[category]:
			var trdata = Skilldata.training_actions[tr]
			if trdata.has('showup_reqs') and !trainer.checkreqs(trdata.showup_reqs):
				continue
			var panel = input_handler.DuplicateContainerTemplate($training/ScrollContainer/VBoxContainer, 'Button')
			var text = tr(trdata.name) + "\n" + tr("CATEGORYKEYWORD") + ": {color=yellow|" + tr("ACTIONCATEGORY"+trdata.type.to_upper()) + "}\n" + person.translate(tr(trdata.descript))
			if cat_data.icon is String:
				panel.get_node('icon').texture = load(cat_data.icon)
			else:
				panel.get_node('icon').texture = cat_data.icon
			panel.get_node('name').text = tr(trdata.name)
			panel.connect('pressed', self, 'activate_training', [tr])
			#reqs check
			if !trainer.checkreqs(trdata.reqs_trainer):
				panel.disabled = true
				text = "{color=red|"+tr('ACTIONTRAINERREQSNOTMET') +"}\n\n"+ text
				globals.connecttexttooltip(panel, text)
				panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.red))
			#avail check
			elif ((tr == 'mindread' and person.training.cooldown.mindread > 0)
					or (category == 'positive' and person.training.cooldown.positive > 0)):
				panel.disabled = true
				text = "{color=red|"+tr('ACTIONALREADYDONETODAY') +"}\n\n"+ text
				globals.connecttexttooltip(panel, text)
				panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.gray))
			elif category != 'positive' and person.has_resistance_block():
				panel.disabled = true
				text = "{color=red|"+tr('TRAINRESISTANT') +"}\n\n"+ text
				globals.connecttexttooltip(panel, text)
				panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.gray))
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
					globals.connecttexttooltip(panel, text)
					if person.training.dispositions_known[category]:
						match person.training.dispositions[category]:
							'weak', 'kink':
								panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.green))
							'neutral':
								panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.yellow))
							'resist':
								panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.red))


func build_training_traits():
	$training/cost.text = tr('TRAININGCOST') % person.get_training_cost()
	input_handler.ClearContainer($training/HBoxContainer2, ['Button'])
	for tr in tr_traits:
		var panel = input_handler.DuplicateContainerTemplate($training/HBoxContainer2, 'Button')
		var trdata = Traitdata.traits[tr]
		if trdata.icon is String:
			panel.get_node('icon').texture = load(trdata.icon)
		else:
			panel.get_node('icon').texture = trdata.icon
		globals.connecttexttooltip(panel, person.translate("[center]" + tr(trdata.name) + "[/center]\n" + tr(trdata.descript) +  person.training.build_stored_req_desc(tr)))
		panel.get_node('Label').text = str(person.get_training_cost())
		if person.check_trait(tr):
			panel.pressed = true
			panel.get_node('Label').visible = false
		else:
			panel.pressed = false
			if person.get_stat('loyalty') >= person.get_training_cost() and person.checkreqs(trdata.reqs) and person.training.check_stored_reqs(tr): 
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


func press_trait_post(value, tr_code):
	if !person.check_trait(tr_code):
		selected_id = tr_code
		var data = Traitdata.traits[tr_code]
		var text = "Unlock this for {color=green|" + str(data.cost) + "} Spirit?"
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'learn_upgrade_post_confirmed', tr(text)])
#		person.add_training(tr_code)
	build_posttrain()


func press_trait_servant(value, tr_code):
	if !person.check_trait(tr_code):
		selected_id = tr_code
		var data = Traitdata.traits[tr_code]
		var text = "Unlock this for {color=green|%s} Loyalty?" % person.get_servant_training_cost()
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'learn_upgrade_confirmed', tr(text)])
#		person.add_training(tr_code)
	build_training_servant()


func finish_training():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'finish_training_confirm', tr("FINISHTRAINING")])


func finish_training_confirm():
	person.finish_training()
	root.update()
	match_state()


func learn_upgrade_confirmed():
	if selected_id == "": 
		return
	var data = Traitdata.traits[selected_id]
	var args = {}
	args["current_trait"] = selected_id
	args["person"] = person
	person.add_training(selected_id)
	selected_id = ""
	root.update()
	input_handler.play_animation("trait_aquired", args)


func learn_upgrade_post_confirmed():
	if selected_id == "": 
		return
	var data = Traitdata.traits[selected_id]
	var args = {}
	args["current_trait"] = selected_id
	args["person"] = person
	person.add_training_post(selected_id)
	selected_id = ""
	root.update()
	input_handler.play_animation("trait_aquired", args)


func update_confirm_finish():
	$training/complete_button.disabled = false
	if !person.has_status('callmaster'):
		$training/complete_button.disabled = true

