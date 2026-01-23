extends Reference

var active_btns = {
#	name = btn
}
var temp_active_btns

#var btns = {
#	#name = {source, get_btn_func, rect_obj, rect_func}
#}
var prepare_tutorial_funcs = {
	training = ['prepare_general_tut'],
	work = ['prepare_general_tut'],#'prepare_work_tut'
	leveling = ['prepare_general_tut'],
	quest_and_combat = ['prepare_general_tut', 'prepare_combat_tut']
}

#		{
#			buttons = ['char_close_button'],
#			text = "Start forge upgrade",
#			panel_pos = Vector2(733,150)
#		}
#		{
#			buttons = ['close_work'],
#			text = "Have player open inventory and use experience scroll",
#			panel_pos = Vector2(733,150)
#		}

var tutorials = {
	training = [
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
			buttons = [],
			text = "End of tutorial",
			panel_pos = Vector2(733,456)
		}
	],
	work = [
		{
			buttons = [],
			text = "Welcome text",
			panel_pos = Vector2(733,456)
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
		},{
			buttons = [],
			text = "End of tutorial",
			panel_pos = Vector2(733,456)
		}
	],
	leveling = [
		#4
		{
			buttons = [],
			text = "Welcome text",
			panel_pos = Vector2(733,456)
		},{
			buttons = ['inventory_button'],
			text = "Have player open inventory and use experience scroll",
			panel_pos = Vector2(733,150)
#		},{
#			buttons = ['inv_master_line'],
#			text = "Have player open inventory and use experience scroll",
#			panel_pos = Vector2(733,50)
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
		},{
			buttons = [],
			text = "End of tutorial",
			panel_pos = Vector2(733,456)
		}
	],
	quest_and_combat = [
		#5
		{
			buttons = [],
			text = "Welcome text",
			panel_pos = Vector2(733,456)
		},{
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
			buttons = ['travel_master', 'travel_servant'],
			highlight = ['travel_chars_highlight'],
			condition_func = "check_travel_select",
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
			buttons = ['location_master', 'location_front_pos1', 'location_front_pos2', 'location_front_pos3'],
			dont_listen = ['location_master'],
			block_event = {location_master = ['released']},
			highlight = ['location_master', 'location_front_highlight'],
			text = 'Assign characters to party, master for melee, second character for ranged',
			panel_pos = Vector2(733,150),
			delay = 1.0
		},{
			buttons = ['location_servent', 'location_back_pos1', 'location_back_pos2', 'location_back_pos3'],
			dont_listen = ['location_servent'],
			block_event = {location_servent = ['released']},
			highlight = ['location_servent', 'location_back_highlight'],
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
			listen = ['combat_turn_signal'],
			no_highlight = true,
			condition_func = "check_turn_master",
			text = 'Complete encounter',
			panel_pos = Vector2(100,50)
		},{
			buttons = ['combat_skill_1'],
			text = 'Use skill',
			panel_pos = Vector2(733,50),
			delay = 0.5
		},{
			buttons = ['combat_enemy'],
			text = 'Use skill',
			panel_pos = Vector2(733,50)
		},{
			buttons = ['tut_full_screen'],
			dont_listen = ['tut_full_screen'],
			listen = ['combat_turn_signal'],
			no_highlight = true,
			condition_func = "check_turn_servent",
			text = 'Complete encounter',
			panel_pos = Vector2(100,50)
		},{
			buttons = ['combat_skill_2'],
			text = 'Use skill',
			panel_pos = Vector2(733,50),
			delay = 0.5
		},{
			buttons = ['combat_ally'],
			text = 'Use skill',
			panel_pos = Vector2(733,50)
		},{
			buttons = ['tut_full_screen'],
			dont_listen = ['tut_full_screen'],
			listen = ['combat_finished_signal'],
			no_highlight = true,
			text = 'Complete encounter',
			panel_pos = Vector2(100,50)
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
			buttons = ['first_recruit_char'],
			text = 'Inspect the character',
			panel_pos = Vector2(733,50),
			delay = 0.5
		},{
			buttons = ['slave_info_close_button'],
			text = 'Recruit the character',
			panel_pos = Vector2(733,50),
			delay = 2.0
		},{
			buttons = ['first_recruit'],
			text = 'Recruit the character',
			panel_pos = Vector2(733,50)
		},{
			buttons = ['event_opt_1'],
			text = 'Recruit the character',
			panel_pos = Vector2(50,850),
			delay = 1.5
		},{
			buttons = ['slave_select'],
			text = 'Recruit the character',
			panel_pos = Vector2(50,850)
		},{
			buttons = ['event_opt_2'],
			text = 'Recruit the character',
			panel_pos = Vector2(50,850),
			delay = 1.7
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
var cur_tut
var cur_step = -1
var cur_dont_listen
var temp_cur_dont_listen
var tut_panel
var tut_menu
var listeners = [
	#{source, sig, fun}
]

func _init():
	tut_panel = input_handler.get_spec_node(input_handler.NODE_HARD_TUTORIAL_PANEL)
	tut_panel.hide()

func _notification(what):
	if what == NOTIFICATION_PREDELETE and is_instance_valid(tut_panel):
		tut_panel.queue_free()

func get_btns():
	return input_handler.hard_tutorial_btns

func activate_btn(btn_name):
	var btn = get_btns()[btn_name]
	active_btns[btn_name] = btn.source.get_ref().call(btn.get_btn_func)
	if active_btns[btn_name] == null:
		push_error("no tutorial button %s" % btn_name)
		return
	if cur_dont_listen == null or !(btn_name in cur_dont_listen):
		set_listener(active_btns[btn_name], get_btns_signal(btn_name), "btn_truly_pressed")

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

func get_btns_signal(btn_name):
	var btns = get_btns()
	if btns[btn_name].has('conf_signal'):
		return btns[btn_name].conf_signal
	else:
		return 'pressed'

func btn_truly_pressed():
	var step_info = tutorials[cur_tut][cur_step]
	if step_info.has('condition_func'):
		if !self.call(step_info.condition_func):
			return
	free_listeners()
	active_btns.clear()
	tut_panel.highlight_off()
	yield(input_handler.get_tree(), 'idle_frame')#buttens can be rearranged after activation
	next_tut_step()

func is_action_pass(btn_name, action):
	if is_tut_active():
		var step_info = tutorials[cur_tut][cur_step]
		if (step_info.has('block_event')
				and step_info.block_event.has(btn_name)
				and action in step_info.block_event[btn_name]):
			return false
	return true
	

func start_tutorial(tut_name):
	cur_tut = tut_name
	cur_step = -1
	btn_truly_pressed()

func stop_tut():
	cur_tut = null
	cur_step = -1
	active_btns.clear()
	tut_panel.hide()

func next_tut_step():
	cur_step += 1
	if tutorials[cur_tut].size() <= cur_step:
		stop_tut()
		tutorial_menu()
		return
	var step_info = tutorials[cur_tut][cur_step]
	active_btns.clear()
	if step_info.has('delay'):
		yield(input_handler.get_tree().create_timer(step_info.delay), "timeout")
	if step_info.has('dont_listen'):#strictly befor activate_btn()!
		cur_dont_listen = step_info.dont_listen
	else:
		cur_dont_listen = null
	var has_custom_highlight = step_info.has('highlight')
	var has_no_highlight = step_info.has('no_highlight')
	var btns_to_activate = step_info.buttons
	if btns_to_activate.empty():
		btns_to_activate = ["tut_panel_next"]
		has_no_highlight = true
		tut_panel.next_btn_on()
	else:
		tut_panel.next_btn_off()
	for btn_name in btns_to_activate:
		activate_btn(btn_name)
		if !has_custom_highlight and !has_no_highlight:
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
	if step_info.has('listen'):
		for sig_btn_name in step_info.listen:
			set_listener(get_btns()[sig_btn_name].source.get_ref(), get_btns_signal(sig_btn_name), "btn_truly_pressed")
	if step_info.has("ban_mass_select"):
		input_handler.stop_mass_select()
	if step_info.has("tut_func"):
		self.call(step_info.tut_func)

#in-tutorial funcs
func add_combat_reward_char():
	var newslave = ResourceScripts.scriptdict.class_slave.new("random_combat")
	newslave.generate_random_character_from_data('random', null, 1)
	newslave.is_active = true
#	newslave.set_slave_category('servant')
	input_handler.combat_node.set_external_reward_chars([newslave.id])

func check_turn_master():
	return input_handler.combat_node.get_current_actor().is_master()
func check_turn_servent():
	return input_handler.combat_node.get_current_actor().get_stat('unique') == 'tutorial_servant'

func check_travel_select():
	return (active_btns['travel_master'].pressed and active_btns['travel_servant'].pressed)
#--------------

func tutorial_menu():
	if tut_menu == null:
		tut_menu = input_handler.get_spec_node(input_handler.NODE_HARD_TUTORIAL_LIST)
	tut_menu.raise()
	tut_menu.show()
	temp_active_btns = active_btns.duplicate()
	temp_cur_dont_listen = cur_dont_listen
	active_btns.clear()
	var menu_btns = ['tut_menu_yes', 'tut_menu_no', "tut_menu_training", "tut_menu_work",
		"tut_menu_leveling", "tut_menu_quest", "tut_menu_abort", "tut_menu_back"]
	cur_dont_listen = menu_btns
	for btn in menu_btns:
		activate_btn(btn)

func abort_tutorial():
	stop_tut()
	globals.return_to_main_menu()
	input_handler.deactivate_hard_tutorial()

func on_tutorial_menu_hide():
	if temp_active_btns != null:
		active_btns = temp_active_btns
		cur_dont_listen = temp_cur_dont_listen
	temp_active_btns = null
	temp_cur_dont_listen = null

func is_in_menu():
	return tut_menu != null and tut_menu.visible

#tutorial prepare funcs
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

func prepare_combat_tut():
	var character = ResourceScripts.game_party.get_unique_slave('tutorial_master')
	character.unlock_class("fighter")
	character.upgrade_mastery('leadership', true)

#func prepare_work_tut():
#	var master_ch = ResourceScripts.game_party.get_unique_slave('tutorial_master')
#	var character = ResourceScripts.game_party.get_unique_slave('daisy')
#	master_ch.add_trainee(character.id)
	

#---------------------

func set_listener(source, sig, fun):
	if source.is_connected(sig, self, fun):
		return
	source.connect(sig, self, fun)
	listeners.append({source = source, sig = sig, fun = fun})

func free_listeners():
	for listener in listeners:
		if (listener.source != null
				and is_instance_valid(listener.source)
				and listener.source.is_connected(listener.sig, self, listener.fun)):
			listener.source.disconnect(listener.sig, self, listener.fun)
	listeners.clear()

func prepare_tutorial(tut_name):
	if !input_handler.globalsettings.tutorial_prompt_seen:
		input_handler.globalsettings.tutorial_prompt_seen = true
	if input_handler.CurrentScene.name == "MansionMainModule":#should remake it somehow
		globals.preexit_clear_up()
	ResourceScripts.game_world.make_world()
	ResourceScripts.game_globals.original_version = globals.gameversion
	ResourceScripts.game_progress.intro_tutorial_seen = true
#	get_node("/root").remove_child(self)
	input_handler.ChangeScene('mansion')
	yield(globals, 'scene_changed')
	gui_controller.windows_opened.clear()
#	self.queue_free()
	
	if prepare_tutorial_funcs.has(tut_name):
		for prepare_func in prepare_tutorial_funcs[tut_name]:
			call(prepare_func)
	start_tutorial(tut_name)

func is_tut_active():
	return cur_tut != null
