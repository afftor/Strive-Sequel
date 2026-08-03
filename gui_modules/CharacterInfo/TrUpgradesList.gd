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
	$training/complete_button.visible = false
	globals.connecttexttooltip($training/Tooltip, tr("INFOTRAINING"))
	globals.connecttexttooltip($trainer_list/tooltip, tr("INFOSLAVETRAINER"))
	$training/spirit.max_value = 100
	globals.connecttexttooltip($training/TextureRect, tr("TRAININGPOINTSTOOLTIP"))
	globals.connecttexttooltip($training/TextureRect2, tr("LOYALTYTOOLTIP"))
	globals.connecttexttooltip($training/spirit, tr("LOYALTYTOOLTIP"))
	globals.connecttexttooltip($training/trainer_frame, tr("CLICKTOCHANGE"))
	globals.connecttexttooltip($training/cd, tr("LOYALTYDECAYTOOLTIP"))
	$training_servant/TalkButton.connect("pressed", self, 'open_servant_unlock_dialogue')
	$training_servant/TalkButton.text = tr('SERVANTUNLOCK_TALK_BUTTON')

	globals.connecttexttooltip($finished/reset_button, tr("RESETTRAINREQ"))
	input_handler.register_btn_source("trainer_btn", self, "tut_get_no_trainer_btn")
	input_handler.register_btn_source("trainer_select_btn", self, "tut_get_trainer_select")
	input_handler.register_btn_source("praise_btn", self, "tut_get_praise_btn")
	input_handler.register_btn_source("training_bonus_btn", self, "tut_get_training_bonus_btn")
	

func tut_get_no_trainer_btn():
	return $no_trainer/TextureButton
func tut_get_trainer_select():
	return $trainer_list/Container2/Container.get_children()[0]
func tut_get_praise_btn():
	return $training/ScrollContainer/VBoxContainer.get_children()[0]
func tut_get_training_bonus_btn():
	for btn in $finished/VBoxContainer/HBoxContainer3.get_children():
		if btn.get_meta('trait', "") == "training_productivity":
			return btn

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
		panel.get_node('name').text = tr("TRAINING_SLAVES_ASSIGNED") % [tchar.get_full_name(), used, amount]
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
	var training_points = person.get_stat('training_points')
	var training_points_cap = person.training.get_training_points_cap()
	$finished/status.text = tr('TRAININGLABELLOYALTY') % [training_points, training_points_cap]
	globals.connecttexttooltip($finished/tp_icon, tr("TRAININGPOINTSTOOLTIP"))
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
	
	$finished/VBoxContainer/select_text.text = tr('TRAININGBONUSES')
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
			if training_points < trdata.cost:
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


const SERVANT_UNLOCK_LIST = [
	{code = 'training_s_working', label = 'SERVANTUNLOCK_WORKING', node = 'working', select_code = 'negotiation_select_working'},
	{code = 'training_s_combat', label = 'SERVANTUNLOCK_COMBAT', node = 'combat', select_code = 'negotiation_select_combat'},
	{code = 'training_s_relation', label = 'SERVANTUNLOCK_DATING', node = 'dating', select_code = 'negotiation_select_dating', extra_reqs = [
		{req = {code = 'stat', stat = 'affection', operant = 'gte', value = 25}, text = 'SERVANTUNLOCK_REQ_AFFECTION'},
	]},
	{code = 'training_s_sexservice', label = 'SERVANTUNLOCK_SEX', node = 'sex', select_code = 'negotiation_select_sex', extra_reqs = [
		{req = {code = 'has_status', status = 'no_sex', check = false}, text = 'SERVANTUNLOCK_REQ_SEX_ACCESS'},
	]},
	{code = 'training_s_sexservice_adv', label = 'SERVANTUNLOCK_SEXSERVICE', node = 'sexservice', select_code = 'negotiation_select_sexservice', extra_reqs = [
		{req = {code = 'stat', stat = 'consent', operant = 'gte', value = 2}, text = 'SERVANTUNLOCK_REQ_CONSENT'},
		{req = {code = 'has_status', status = 'no_sex', check = false}, text = 'SERVANTUNLOCK_REQ_SEX_ACCESS'},
	]},
]


func get_missing_req_texts(entry):
	var texts = []
	for extra_req in entry.get('extra_reqs', []):
		if !person.checkreqs(extra_req.req):
			texts.append(tr(extra_req.text))
	return texts


func build_training_servant():
	gather_data()
	$training_servant.visible = true
	$training_servant/cost.visible = false
	$training_servant/resistance.visible = false
	$training_servant/loyalty.visible = false
	$training_servant/HBoxContainer2.visible = false

	var all_unlocked = true
	for entry in SERVANT_UNLOCK_LIST:
		var row = $training_servant/UnlockList.get_node(entry.node)
		row.get_node('name').text = tr(entry.label)
		var status_label = row.get_node('status')
		if person.check_trait(entry.code):
			status_label.text = tr('SERVANTUNLOCK_UNLOCKED')
			status_label.set("custom_colors/font_color", Color(variables.hexcolordict.green))
		else:
			all_unlocked = false
			status_label.text = tr('SERVANTUNLOCK_LOCKED')
			status_label.set("custom_colors/font_color", Color(variables.hexcolordict.red))
			var missing_texts = get_missing_req_texts(entry)
			if !missing_texts.empty():
				globals.connecttexttooltip(row, PoolStringArray(missing_texts).join("\n"))

	if all_unlocked:
		$training_servant/TalkButton.visible = false
	else:
		$training_servant/TalkButton.visible = true
		if person.training.can_negotiate():
			$training_servant/TalkButton.disabled = false
			$training_servant/TalkButton.text = tr('SERVANTUNLOCK_TALK_BUTTON')
		else:
			$training_servant/TalkButton.disabled = true
			$training_servant/TalkButton.text = tr('SERVANTUNLOCK_TALK_BUTTON_COOLDOWN') % person.training.cooldown.negotiation


func open_servant_unlock_dialogue():
	var options = []
	for entry in SERVANT_UNLOCK_LIST:
		if person.check_trait(entry.code):
			continue
		var option_text = tr(entry.label)
		var reqs = []
		for extra_req in entry.get('extra_reqs', []):
			reqs.append({type = 'active_character_checks', value = [extra_req.req]})
		for missing_text in get_missing_req_texts(entry):
			option_text += " (%s)" % missing_text
		options.append({code = entry.select_code, text = option_text, reqs = reqs, not_hide = true})
	options.append({code = 'close', text = tr('SERVANTUNLOCK_LEAVE'), reqs = []})
	var dialogue_data = {
		text = tr('SERVANTUNLOCK_DIALOGUE_TEXT') % person.get_short_name(),
		image = 'handshake',
		tags = ['custom_effect'],
		options = options,
	}
	input_handler.active_character = person
	input_handler.interactive_message_custom(dialogue_data)


func build_training_header():
	var trainer = person.get_trainer()
	$training/trainer_frame/icon.texture = trainer.get_icon()
	$training/name.text = tr("TRAINING_TRAINER_NAME") % trainer.get_full_name()
	$training/spirit.value = person.get_stat('loyalty')
	$training/spirit/percent_label.text = "%d%%" % int(person.get_stat('loyalty'))
	$training/resistance.visible = false

	var tp_label = $training/loyalty
	var tp_value = person.get_stat('training_points')
	var tp_cap = person.training.get_training_points_cap()
	tp_label.text = tr('TRAININGLABELLOYALTY') % [floor(tp_value), tp_cap]
	var tp_color = variables.hexcolordict.yellow
	if tp_value >= person.get_training_cost():
		tp_color = variables.hexcolordict.green
	tp_label.set("custom_colors/font_color", Color(tp_color))
	
	var decay_grace = person.training.get_loyalty_decay_grace()
	var decay_amount = person.training.get_loyalty_decay_amount()
	var days_left = int(floor(decay_grace)) + 1 - person.training.days_since_training
	if days_left > 0:
		$training/cd.text = tr('TRAININGDECAYSIN') % [days_left, decay_amount]
		$training/cd.set("custom_colors/font_color", Color(variables.hexcolordict.yellow))
	else:
		$training/cd.text = tr('TRAININGDECAYING') % decay_amount
		$training/cd.set("custom_colors/font_color", Color(variables.hexcolordict.red))

 
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
			#rebellious slave refuses training right after being acquired
			elif !gui_controller.mansion.in_test_mode and person.training.is_rebel_blocked():
				panel.disabled = true
				text = "{color=red|"+tr('ACTIONREBELBLOCKED') +"}\n\n"+ text
				globals.connecttexttooltip(panel, text)
				panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.gray))
			#avail check
			elif !gui_controller.mansion.in_test_mode and ((tr == 'mindread' and person.training.cooldown.mindread > 0)
					or person.training.cooldown.positive > 0):
				panel.disabled = true
				text = "{color=red|"+tr('ACTIONALREADYDONETODAY') +"}\n\n"+ text
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
			if person.get_stat('training_points') >= person.get_training_cost() and person.checkreqs(trdata.reqs) and person.training.check_stored_reqs(tr) and !person.has_status('no_trainings'):
				panel.connect('toggled', self, 'press_trait', [tr])
			else:
				panel.disabled = true
				panel.material = load("res://assets/sfx/bw_shader.tres")
				panel.get_node('icon').material = load("res://assets/sfx/bw_shader.tres")
				panel.get_node('icon').modulate = Color(0.3, 0.3, 0.3, 1.0)


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
	root.update()
	match_state()


var selected_id = ""
func press_trait(value, tr_code):
	if !person.check_trait(tr_code):
		selected_id = tr_code
		var data = Traitdata.traits[tr_code]
		var text = tr("UPGRADELIST_UNLOCK") % [str(person.get_training_cost()), tr("STATTRAINING_POINTS")]
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'learn_upgrade_confirmed', text])
#		person.add_training(tr_code)
	build_training_traits()


func press_trait_post(value, tr_code):
	if !person.check_trait(tr_code):
		selected_id = tr_code
		var data = Traitdata.traits[tr_code]
		var text = tr("UPGRADELIST_UNLOCK") % [str(data.cost), tr("STATTRAINING_POINTS")]
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'learn_upgrade_post_confirmed', text])
#		person.add_training(tr_code)
	build_posttrain()


func press_trait_servant(value, tr_code):
	if !person.check_trait(tr_code):
		var args = {}
		args["current_trait"] = tr_code
		args["person"] = person
		person.add_training(tr_code)
		root.update()
		input_handler.play_animation("trait_aquired", args)
	build_training_servant()


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

