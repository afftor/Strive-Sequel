extends Reference

var active_btns = {
#	name = btn
}
var in_abort = false

#var btns = {
#	#name = {source, get_btn_func, rect_obj, rect_func, act_obj, act_func}
#}

var tutorials = {
	general = [
		{
			buttons = [],
			text = "Welcome text",
			panel_pos = Vector2(733,456)
		},
		#1
		{
			buttons = ['first_skill_btn'],
			text = "Use master's mentor skill on subordinate",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['slave_2_line'],
			text = "Use master's mentor skill on subordinate",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['event_opt_1'],
			text = "Use master's mentor skill on subordinate",
			panel_pos = Vector2(50,850),
			delay = 1.0
		},
		#2
		{
			buttons = ['food_mode'],
			text = "Player set extra rations for characters",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['ff_meat'],
			text = "Player set extra rations for characters",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['ff_vegetables'],
			text = "Player set extra rations for characters",
			panel_pos = Vector2(733,50)
		},
		#3
		{
			buttons = ['default_mode'],
			text = "Assign master as Daisy's trainer",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['daisy_line'],
			text = "Assign master as Daisy's trainer",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['char_info'],
			text = "Assign master as Daisy's trainer",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['trainer_btn'],
			text = "Assign master as Daisy's trainer",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['trainer_select_btn'],
			text = "Assign master as Daisy's trainer",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['praise_btn'],
			text = "Choose praise as training",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['event_opt_1'],
			text = "Choose praise as training",
			panel_pos = Vector2(50,850),
			delay = 1.0
		},{
			buttons = ['obedience_btn'],
			text = "Unlock obedience training",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['alert_panel_yes'],
			text = "Unlock obedience training",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['minor_upg'],
			text = "Assign minor training for etiquette",
			panel_pos = Vector2(733,50),
			delay = 3.0
		},{
			buttons = ['etiquette'],
			text = "Assign minor training for etiquette",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['alert_panel_yes'],
			text = "Unlock obedience training",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['char_close_button'],
			text = "Start forge upgrade",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['upgrades_button'],
			text = "Start forge upgrade",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['forge'],
			text = "Start forge upgrade",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['upgrade_confirm'],
			text = "Start forge upgrade",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['upgrade_close_button'],
			text = "Set Daisy to work on upgrading",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['work_button'],
			text = "Set Daisy to work on upgrading",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['building_work'],
			text = "Set Daisy to work on upgrading",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['daisy_work'],
			text = "Set Daisy to work on upgrading",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['close_work'],
			text = "Make player skip turn",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['finish_turn'],
			text = "Make player skip turn",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['service_mode'],
			text = "Assign Daisy to waitress work in character list",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['daisy_waitress'],
			text = "Assign Daisy to waitress work in character list",
			ban_mass_select = true,
			panel_pos = Vector2(733,150)
		},{
			buttons = ['work_button'],
			text = "Set Daisy to work at service",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['service_work'],
			text = "Set Daisy to work at service",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['daisy_work'],
			text = "Set Daisy to work at service",
			panel_pos = Vector2(733,150)
		},
		#4
		{
			buttons = ['close_work'],
			text = "Have player open inventory and use experience scroll",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['inventory_button'],
			text = "Have player open inventory and use experience scroll",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['inv_master_line'],
			text = "Have player open inventory and use experience scroll",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['inv_exp_scroll'],
			text = "Have player open inventory and use experience scroll",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['event_opt_1'],
			text = "Have master learn fighter class",
			panel_pos = Vector2(50,850),
			delay = 1.0
		},{
			buttons = ['inv_close_button'],
			text = "Have master learn fighter class",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['char_info'],
			text = "Have master learn fighter class",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['leveling_button'],
			text = "Have master learn fighter class",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['class_fighter'],
			text = "Have master learn fighter class",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['class_unlock'],
			text = "Have master learn fighter class",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['leveling_button'],
			text = "Have master assign point into leadership",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['mastery_leadership'],
			text = "Have master assign point into leadership",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['mastery_add_point', 'mastery_add_point2'],
			highlight = ['mastery_add_point_highlight'],
			text = "Have master assign point into leadership",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['alert_panel_yes'],
			text = "Have master assign point into leadership",
			panel_pos = Vector2(733,150)
		},
		#5
		{
			buttons = ['char_close_button'],
			text = 'Take quest for "Trouble Solving"',
			panel_pos = Vector2(733,150)
		},
		{
			buttons = ['aliron_btn'],
			text = 'Take quest for "Trouble Solving"',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['quest_board'],
			text = 'Take quest for "Trouble Solving"',
			panel_pos = Vector2(733,150),
			delay = 0.5
		},{
			buttons = ['quest_btn'],
			text = 'Take quest for "Trouble Solving"',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['quest_accept'],
			text = 'Take quest for "Trouble Solving"',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['travel_btn'],
			text = 'Send 2 characters to travel "Threat - Wild wolves"',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['travel_master'],
			ban_mass_select = true,
			text = 'Send 2 characters to travel "Threat - Wild wolves"',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['travel_servant'],
			ban_mass_select = true,
			text = 'Send 2 characters to travel "Threat - Wild wolves"',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['travel_send'],
			ban_mass_select = true,
			text = 'Send 2 characters to travel "Threat - Wild wolves"',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['travel_to_loc'],
			ban_mass_select = true,
			text = 'Send 2 characters to travel "Threat - Wild wolves"',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['travel_confirm'],
			ban_mass_select = true,
			text = 'Send 2 characters to travel "Threat - Wild wolves"',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['travel_back'],
			ban_mass_select = true,
			text = 'Send 2 characters to travel "Threat - Wild wolves"',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['finish_turn'],
			text = 'Send 2 characters to travel "Threat - Wild wolves"',
			panel_pos = Vector2(733,150),
			delay = 0.5
		},{
			buttons = ['quest_loc_nav_btn'],
			text = 'Assign characters to party, master for melee, second character for ranged',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['location_master', 'location_front_pos1', 'location_front_pos2', 'location_front_pos3', 'alert_panel_no'],
			dont_listen = ['location_master', 'alert_panel_no'],
			highlight = ['location_master', 'location_front_highlight'],
			text = 'Assign characters to party, master for melee, second character for ranged',
			panel_pos = Vector2(733,150),
			delay = 1.0
		},{
			buttons = ['location_servent', 'location_back_pos1', 'location_back_pos2', 'location_back_pos3', 'alert_panel_no'],
			highlight = ['location_servent', 'location_back_highlight'],
			dont_listen = ['location_servent', 'alert_panel_no'],
			text = 'Assign characters to party, master for melee, second character for ranged',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['location_proceed'],
			text = 'Assign characters to party, master for melee, second character for ranged',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['event_opt_1'],
			text = 'Assign characters to party, master for melee, second character for ranged',
			panel_pos = Vector2(50,850),
			delay = 1.0
		},{
			buttons = ['pos_select_confirm'],
			text = 'Assign characters to party, master for melee, second character for ranged',
			panel_pos = Vector2(733,50)
		},{
			buttons = ['tut_full_screen'],
			dont_listen = ['tut_full_screen'],
			listen = ['combat_rewards_signal'],
			no_highlight = true,
			tut_func = "add_combat_reward_char",
			text = 'Complete encounter',
			panel_pos = Vector2(100,50)
		},{
			buttons = ['combat_close'],
			text = 'Complete encounter',
			panel_pos = Vector2(733,50),
			delay = 1.0
		},{
			buttons = ['first_recruit'],
			text = 'Recruit the character',
			panel_pos = Vector2(733,50),
			delay = 0.5
		},{
			buttons = ['event_opt_1'],
			text = 'Recruit the character',
			panel_pos = Vector2(50,850),
			delay = 1.0
		},{
			buttons = ['slave_select'],
			text = 'Recruit the character',
			panel_pos = Vector2(50,850)
		},{
			buttons = ['event_opt_2'],
			text = 'Recruit the character',
			panel_pos = Vector2(50,850),
			delay = 1.0
		},{
			buttons = ['event_opt_1'],
			text = 'Recruit the character',
			panel_pos = Vector2(50,850),
			delay = 1.0
		},{
			buttons = ['mansion_btn'],
			text = 'Turn in quest',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['journal_button'],
			text = 'Turn in quest',
			panel_pos = Vector2(733,150),
			delay = 1.0
		},{
			buttons = ['journal_minor'],
			text = 'Turn in quest',
			panel_pos = Vector2(733,50)
		},{
			buttons = ['journal_first_quest'],
			text = 'Turn in quest',
			panel_pos = Vector2(733,50)
		},{
			buttons = ['journal_complete'],
			text = 'Turn in quest',
			panel_pos = Vector2(733,50)
		},{
			buttons = [],
			text = "End of tutorial",
			panel_pos = Vector2(733,456)
		},
	]
}
var on_exit_step = {
	buttons = ['alert_panel_yes', 'alert_panel_no'],
	dont_listen = ['alert_panel_yes', 'alert_panel_no'],
	no_highlight = true
}
var cur_tut
var cur_step = -1
var cur_step_dict
var multiple_listeners = false
var tut_panel

func _init():
	tut_panel = input_handler.get_spec_node(input_handler.NODE_HARD_TUTORIAL_PANEL)
	tut_panel.hide()

#func _notification(what):
#	if what == NOTIFICATION_PREDELETE:
#		print("freed!")

func get_btns():
	return input_handler.hard_tutorial_btns

func activate_btn(btn_name):
	var btn = get_btns()[btn_name]
	active_btns[btn_name] = btn.source.get_ref().call(btn.get_btn_func)
	if active_btns[btn_name] == null:
		push_error("no tutorial button %s" % btn_name)

func validate_btn(btn_name):
	if !active_btns.has(btn_name) or !is_instance_valid(active_btns[btn_name]):
		activate_btn(btn_name)

func get_true_rect(btn_name):
	var true_rect
	var btn_info = get_btns()[btn_name]
	if btn_info.has('rect_obj'):
		true_rect = btn_info.rect_obj.get_ref().call(btn_info.rect_func)
	else:
		true_rect = active_btns[btn_name].get_global_rect()
		true_rect.size *= active_btns[btn_name].get_global_transform().get_scale()
	return true_rect

func has_custom_activation(btn_name):
	return get_btns()[btn_name].has('act_obj')

func custom_pressed(btn_name):
#	if !has_custom_activation(btn_name):#done externally
#		return
	if cur_step_dict.has('dont_listen') and (btn_name in cur_step_dict.dont_listen):
		return
	var btns = get_btns()
	btns[btn_name].act_obj.get_ref().call(btns[btn_name].act_func)
	btn_truly_pressed()

func try_connect_pressed(btn_name):
	if cur_step_dict.has('dont_listen') and (btn_name in cur_step_dict.dont_listen):
		return
#	if has_custom_activation(btn_name):#done externallys
#		return
	var btns = get_btns()
	var confirm_signal = 'pressed'
	if btns[btn_name].has('conf_signal'):
		confirm_signal = btns[btn_name].conf_signal
	if !active_btns[btn_name].is_connected(confirm_signal, self, "btn_truly_pressed"):
		active_btns[btn_name].connect(confirm_signal, self, "btn_truly_pressed", [], CONNECT_ONESHOT)

func btn_truly_pressed():
	active_btns.clear()
	tut_panel.highlight_off()
	yield(input_handler.get_tree(), 'idle_frame')#buttens can be rearranged after activation
	next_tut_step()

func start_tutorial(tut_name):
	cur_tut = tut_name
	cur_step = -1
	btn_truly_pressed()

func stop_tut():
	cur_tut = null
	cur_step = -1
	active_btns.clear()
	tut_panel.hide()
	input_handler.deactivate_hard_tutorial()

func next_tut_step():
	if multiple_listeners:
		multiple_listeners = false
		for sig_btn_name in cur_step_dict.listen:#can't have 'multiple_listeners' and no 'listen'
			var btn = get_btns()[sig_btn_name]
			var confirm_signal = 'pressed'
			if btn.has('conf_signal'):
				confirm_signal = btn.conf_signal
			if btn.source.get_ref().is_connected(confirm_signal, self, "btn_truly_pressed"):
				btn.source.get_ref().disconnect(confirm_signal, self, "btn_truly_pressed")
	
	cur_step += 1
	if tutorials[cur_tut].size() <= cur_step:
		stop_tut()
		return
	set_tut_step(tutorials[cur_tut][cur_step])
	
func set_tut_step(step_info):
	cur_step_dict = step_info
	active_btns.clear()
	if step_info.has('delay'):
		yield(input_handler.get_tree().create_timer(step_info.delay), "timeout")
	var has_custom_highlight = step_info.has('highlight')
	for btn_name in step_info.buttons:
		activate_btn(btn_name)
		if !has_custom_highlight and !step_info.has('no_highlight'):
			tut_panel.highlight_rects([get_true_rect(btn_name)])
	if has_custom_highlight:
		var rects = []
		for highlight_btn in step_info.highlight:
			rects.append(get_true_rect(highlight_btn))
		tut_panel.highlight_rects(rects)
	if step_info.has('text'):
		tut_panel.show_tut(tr(step_info.text), step_info.panel_pos)
	else:
		tut_panel.hide_text()
	if step_info.buttons.empty():
		activate_btn("tut_panel_next")
		tut_panel.next_btn_on()
	else:
		tut_panel.next_btn_off()
	if step_info.has('listen'):
		multiple_listeners = (step_info.listen.size() > 1)
		for sig_btn_name in step_info.listen:
			var btn = get_btns()[sig_btn_name]
			var confirm_signal = 'pressed'
			if btn.has('conf_signal'):
				confirm_signal = btn.conf_signal
			btn.source.get_ref().connect(confirm_signal, self, "btn_truly_pressed", [], CONNECT_ONESHOT)
	if step_info.has("ban_mass_select"):
		input_handler.stop_mass_select()
	if step_info.has("tut_func"):
		self.call(step_info.tut_func)

func add_combat_reward_char():
	var newslave = ResourceScripts.scriptdict.class_slave.new("random_combat")
	newslave.generate_random_character_from_data('random', null, 1)
	newslave.is_active = true
#	newslave.set_slave_category('servant')
	input_handler.combat_node.set_external_reward_chars([newslave.id])

func abort_tutorial():
	input_handler.get_spec_node(input_handler.NODE_YESORNOPANEL, [self, 'abort_tutorial_confirm', 'withdraw_abort', tr('ABORTTUTORIAL')])
	tut_panel.highlight_off()
	in_abort = true
	set_tut_step(on_exit_step)

func abort_tutorial_confirm():
	in_abort = false
	stop_tut()

func withdraw_abort():
#	yield(input_handler.get_tree(), 'idle_frame')
	set_tut_step(tutorials[cur_tut][cur_step])
	in_abort = false

func prepare_general_tut():
	globals.common_effects([{code = 'make_story_character', value = 'tutorial_master'}])
	var character = ResourceScripts.game_party.get_unique_slave('tutorial_master')
	globals.equip_char(character, 'club', {WeaponMace = 'wood'})
	globals.equip_char(character, 'chest_base_cloth', {ArmorBaseCloth = 'cloth', ArmorTrim = 'wood'})
	globals.equip_char(character, 'legs_base_cloth', {ArmorBaseCloth = 'cloth', ArmorTrim = 'wood'})
	character.xp_module.base_exp = 150
	globals.common_effects([{code = 'make_story_character', value = 'tutorial_servant'}])
	character = ResourceScripts.game_party.get_unique_slave('tutorial_servant')
	globals.equip_char(character, 'staff', 't1')
	globals.equip_char(character, 'chest_base_cloth', 't1')
	globals.equip_char(character, 'legs_base_cloth', 't1')
	globals.common_effects([{code = 'make_story_character', value = 'Daisy'}])
	character = ResourceScripts.game_party.get_unique_slave('daisy')
	character.remove_trait('training_obedience')
	character.add_stat('loyalty', 25)
	character.set_brothel_rule('waitress', false)
	ResourceScripts.game_res.money = 800
	ResourceScripts.game_res.materials['wood'] = 10
	ResourceScripts.game_res.materials['stone'] = 25
	ResourceScripts.game_res.materials['iron'] = 10
	ResourceScripts.game_res.materials['meat'] = 50
	ResourceScripts.game_res.materials['fish'] = 50
	ResourceScripts.game_res.materials['bread'] = 50
	ResourceScripts.game_res.materials['vegetables'] = 50
	globals.AddItemToInventory(globals.CreateUsableItem("exp_scroll", 1))
#	var has_tut_quest = false
#	for quest_id in ResourceScripts.game_world.areas['plains'].quests.factions['workers']:
#		if ResourceScripts.game_world.areas['plains'].quests.factions['workers'][quest_id].code == 'workers_threat_easy':
#			has_tut_quest = true
#			break
#	if !has_tut_quest:
	var newquest = ResourceScripts.world_gen.make_quest('tutorial_threat_easy', {
		source = 'workers', area = 'plains',
		travel_time = 1, difficulty = 'easy'
	})
	ResourceScripts.game_world.areas[newquest.area].quests.factions[newquest.source][newquest.id] = newquest
	
	gui_controller.mansion.try_rebuild_slave_list()
	gui_controller.mansion.mansion_state_set("default")

