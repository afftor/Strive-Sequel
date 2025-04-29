extends Control

onready var positions_node = $PrefightPanel/Positions
onready var cur_reward_cont = $PrefightPanel/cur_reward_panel/CurRewardCont/BoxContainer
onready var cur_reward_panel = $PrefightPanel/cur_reward_panel
onready var next_reward_cont = $PrefightPanel/next_reward_panel/NextRewardCont/BoxContainer
onready var start_btn = $PrefightPanel/start_btn
onready var finish_btn = $base_panel/leave_btn
onready var main_panel = $PrefightPanel
onready var unwelcome_label = $base_panel/unwelcome_label
onready var reset_timer = $base_panel/timer_rect/timer
onready var reset_timer_panel = $base_panel/timer_rect
onready var timer_pos_open = $base_panel/timer_open.position
onready var timer_pos_close = $base_panel/timer_close.position
onready var screen_block = $block

#if code can't find round and/or difficulty in enemy_groups, it go's here
var enemy_groups_defaults = {
	#non determined difficulty and round
	"default" : [['arena_test1', 1], ['arena_test2', 1], ['arena_test3', 1]],
	#non determined difficulty for determined rounds
	1 : [['arena_test1', 1], ['arena_test2', 1], ['arena_test3', 1]],
	2 : [['arena_test1', 1], ['arena_test2', 1], ['arena_test3', 1]],
	3 : [['arena_test1', 1], ['arena_test2', 1], ['arena_test3', 1]],
	4 : [['arena_test1', 1], ['arena_test2', 1], ['arena_test3', 1]],
	5 : [['arena_test1', 1], ['arena_test2', 1], ['arena_test3', 1]],
}
#keys of first level are rounds, second level - difficulty (party limit)
var enemy_groups = {
	1 : {#round 1
		1 : [['arena_1r_easy_1', 3], ['arena_1r_medium_1', 1]],
		2 : [['arena_1r_easy_1', 1], ['arena_1r_medium_1', 2]],
		3 : [['arena_1r_easy_1', 1], ['arena_1r_medium_1', 3], ['arena_1r_hard_1', 1]],
		4 : [['arena_1r_medium_1', 3], ['arena_1r_hard_1', 1]],
		5 : [['arena_1r_medium_1', 1], ['arena_1r_hard_1', 3]],
	},
	2 : {#round 2
		1 : [['arena_2r_easy_1', 3], ['arena_2r_easy_2', 3], ['arena_2r_medium_1', 1],['arena_2r_medium_2', 1]],
		2 : [['arena_2r_easy_1', 2], ['arena_2r_easy_2', 2], ['arena_2r_medium_1', 1],['arena_2r_medium_2', 2]],
		3 : [['arena_2r_medium_1',2],['arena_2r_medium_2', 2], ['arena_2r_hard_1', 1], ['arena_2r_hard_2', 1]],
		4 : [['arena_2r_medium_1',1],['arena_2r_medium_2', 1], ['arena_2r_hard_1', 1], ['arena_2r_hard_2', 1]],
		5 : [['arena_2r_medium_1',1],['arena_2r_medium_2', 1], ['arena_2r_hard_1', 4], ['arena_2r_hard_2', 4]],
	},
	3 : {#round 3
		1 : [['arena_3r_easy_1', 3], ['arena_3r_easy_2', 3], ['arena_3r_easy_3', 3]],
		2 : [['arena_3r_easy_1', 2], ['arena_3r_easy_2', 2], ['arena_3r_medium_1', 1], ['arena_3r_medium_2', 1]],
		3 : [['arena_3r_medium_1', 2], ['arena_3r_medium_2', 2], ['arena_3r_medium_3', 2], ['arena_3r_hard_1', 1]],
		4 : [['arena_3r_medium_1', 1], ['arena_3r_medium_2', 1], ['arena_3r_hard_1', 2], ['arena_3r_hard_2', 1]],
		5 : [['arena_3r_hard_1', 3], ['arena_3r_hard_2', 3], ['arena_3r_hard_3', 3]],
	},
	4 : {#round 4
		1 : [['arena_4r_easy_1', 3], ['arena_4r_easy_2', 3]],
		2 : [['arena_4r_easy_1', 2], ['arena_4r_easy_2', 2], ['arena_4r_medium_1', 1]],
		3 : [['arena_4r_medium_1', 2], ['arena_4r_medium_2', 2], ['arena_4r_hard_1', 1]],
		4 : [['arena_4r_medium_1', 1], ['arena_4r_medium_2', 1], ['arena_4r_hard_1', 2], ['arena_4r_hard_2', 1]],
		5 : [['arena_4r_hard_1', 3], ['arena_4r_hard_2', 3]],
	},
	5 : {#round 5
		1 : [['arena_5r_easy_1', 3]],
		2 : [['arena_5r_easy_1', 2], ['arena_5r_medium_1', 1], ['arena_5r_medium_2', 2]],
		3 : [['arena_5r_medium_1', 3], ['arena_5r_medium_2', 2], ['arena_5r_hard_1', 1]],
		4 : [['arena_5r_medium_1', 2], ['arena_5r_medium_2', 1], ['arena_5r_hard_1', 1]],
		5 : [['arena_5r_hard_1', 1]],
	},
}

#if code can't find round and/or difficulty in rewards, it go's here
var rewards_defaults = {
	#non determined difficulty and round
	"default" : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
	#non determined difficulty for determined rounds
	1 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
	2 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
	3 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
	4 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
	5 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
}
var rewards = {
	1 : {#round 1
		1 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		2 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		3 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		4 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		5 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
	},
	2 : {#round 2
		1 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		2 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		3 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		4 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		5 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
	},
	3 : {#round 3
		1 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		2 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		3 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		4 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		5 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
	},
	4 : {#round 4
		1 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		2 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		3 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		4 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		5 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
	},
	5 : {#round 5
		1 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		2 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		3 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		4 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
		5 : [['bandit_loot', 1], ['goblin_loot', 1], ['easy_prisoner_reward_item', 1]],
	},
}

var group = {}
var limits = [[1, 1], [2, 2], [3, 2], [4, 2], [5, 1]]
var cur_reward = {gold = 0, materials = {}, items = []}
var next_reward = {}
var round_num = 1
var round_max = 5
var reset_time = 3
var opened = false


func _ready():
	finish_btn.connect("pressed", self, 'on_leave_btn')
	$PrefightPanel/reset_btn.connect("pressed", self, 'reset')
	start_btn.connect("pressed", self, 'on_start_btn')
	positions_node.strip_buttons()
	positions_node.open_defined(group)
	positions_node.set_remote(true)
	positions_node.connect("group_changed", self, 'update_limit_label')
	gui_controller.add_close_button(self, "custom", [72, 32])
	globals.connecttexttooltip($main_tooltip, tr("ARENA_TOOLTIP"))
	var progress = ResourceScripts.game_progress.arena
	if progress.last_reset_date < 0:
		progress.last_reset_date = -reset_time

#very ugly fix! Need to do something with this
func temp_save_fix():
	var progress = ResourceScripts.game_progress.arena
	progress.last_reset_date = int(progress.last_reset_date)
	progress.group_limit = int(progress.group_limit)
	if next_reward.empty():
		make_next_reward()

func open():
	temp_save_fix()
	var progress = ResourceScripts.game_progress.arena
	if ResourceScripts.game_globals.date >= progress.last_reset_date + reset_time:
		reset()
	call_deferred('raise')
#	gui_controller.previous_screen = gui_controller.current_screen
#	gui_controller.current_screen = self
	if !gui_controller.windows_opened.has(self):
		gui_controller.windows_opened.append(self)
	ResourceScripts.core_animations.OpenAnimation(self, 0.5)#show()
	positions_node.set_limit(progress.group_limit)
	positions_node.show()#not quite sure why it should be called separately
	update_screen()
	if progress.finished and opened:
		close_doors()
	elif !progress.finished and !opened:
		open_doors()
	
#	main_panel.hide()
#	main_panel.modulate.a = 0
#	yield(get_tree().create_timer(0.5), "timeout")
#	ResourceScripts.core_animations.OpenAnimation(main_panel, 0.5)

func update_screen():
	var progress = ResourceScripts.game_progress.arena
	reset_timer.text = String(progress.last_reset_date + reset_time - ResourceScripts.game_globals.date)
	update_round_label()
	update_limit_label()
	update_reward(cur_reward_cont, cur_reward)
	update_reward(next_reward_cont, next_reward)

func update_round_label():
	$PrefightPanel/round_rect/round.text = String(round_num)
func update_limit_label():
	$PrefightPanel/limit_rect/limit.text = "%s/%s" % [group.size(), ResourceScripts.game_progress.arena.group_limit]

func close():
#	gui_controller.current_screen = gui_controller.previous_screen
#	gui_controller.previous_screen = null
	gui_controller.windows_opened.erase(self)
	screen_block.show()#not sure if it is a good idea
	ResourceScripts.core_animations.CloseAnimation(self, 0.5)
	yield(get_tree().create_timer(0.5), "timeout")
	clear_group()
	screen_block.hide()
	hide()

func reset():
	reset_group_limit()
	make_next_reward()
	start_btn.disabled = false
	open_doors()
	ResourceScripts.game_progress.arena.last_reset_date = ResourceScripts.game_globals.date

func open_doors():
	unwelcome_label.hide()
	reset_timer_panel.rect_position = timer_pos_open
	main_panel.show()
	opened = true
	ResourceScripts.game_progress.arena.finished = false
#	finish_btn.text = tr('ARENA_LEAVE_BTN')

func close_doors():
	unwelcome_label.show()
	reset_timer_panel.rect_position = timer_pos_close
	main_panel.hide()
	opened = false
	ResourceScripts.game_progress.arena.finished = true
	finish_btn.text = tr('ARENA_LEAVE_BTN')

func discard_progress():
	next_round(1)
	next_reward = {}
	cur_reward = {gold = 0, materials = {}, items = []}
	clear_reward(cur_reward_cont)
	clear_reward(next_reward_cont)
	clear_group()

func on_start_btn():
	if ResourceScripts.game_progress.arena.finished:
		input_handler.get_spec_node(input_handler.NODE_POPUP, [tr('ARENA_FINISHED')])
		return
	
	if !globals.check_group(group):
		input_handler.SystemMessage(tr("SYSMESSAGEATLEAST1CHAR"))#)
		return
	
	if round_num == 1:
		if !globals.valuecheck({type = "has_money", value = 1000}):
			input_handler.get_spec_node(input_handler.NODE_POPUP, [tr('ARENA_FEE')])
			return
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'start_combat', tr('ARENA_START')])
	else:
		start_combat()

func start_combat():
	#mind, that globals.check_group() logically should be here,
	#but practically better at on_start_btn()
	#move it back, if start_combat() would be used elsewhere (not after on_start_btn())
	
	if round_num == 1:
		ResourceScripts.game_res.update_money("-", 1000)
		positions_node.fix_group()
		start_listen_combat()
		finish_btn.text = tr('ARENA_RETREAT_BTN')
	
	input_handler.play_animation("fight")
	yield(get_tree().create_timer(1), "timeout")
	ResourceScripts.core_animations.BlackScreenTransition(0.5)
	yield(get_tree().create_timer(0.5), "timeout")
	
	if input_handler.combat_node == null:
		input_handler.combat_node = input_handler.get_combat_node()
	var data
	input_handler.encounter_win_script = null
	input_handler.encounter_lose_script = null

	if ResourceScripts.game_globals.skip_combat == true:
		input_handler.finish_combat()
		return

	var enemies = globals.make_enemies(get_enemy_group(), true)

	input_handler.combat_node.encountercode = 'arena'
	input_handler.combat_node.set_norun_mode(false)
	globals.char_roll_data.no_roll = true
	input_handler.combat_node.start_combat(group, enemies, 'arena')
	input_handler.combat_node.set_only_show_reward()
#	var progress = ResourceScripts.game_progress.arena
	input_handler.combat_node.set_external_reward(next_reward)

func start_listen_combat():
	input_handler.connect("CombatEnded", self, "on_combat_ended")

func stop_listen_combat():
	input_handler.disconnect("CombatEnded", self, "on_combat_ended")

func on_combat_ended(encounter_code, victory):
	if encounter_code != 'arena':
		print("error: arena listens non arena's combat")
		return
	
	if !victory:
		defeat()
		return
	
	positions_node.build_location_group()
	
#	var progress = ResourceScripts.game_progress.arena
	var loot_processor = Items.get_loot()
	loot_processor.merge_reward_dict(cur_reward, next_reward)
	update_reward(cur_reward_cont, cur_reward)
	
	if round_num >= round_max:
		start_btn.disabled = true
		finish_btn.text = tr('ARENA_FINISH_BTN')
		clear_reward(next_reward_cont)
	else:
		next_round()
		make_next_reward()


func clear_reward(list):
	input_handler.ClearContainer(list)

func update_reward(list, reward):
	clear_reward(list)
	var has_content = false
	if !reward.empty():
		if reward.gold > 0:
			has_content = true
			var newbutton = input_handler.DuplicateContainerTemplate(list)
			newbutton.show()
			newbutton.get_node("Icon").texture = images.get_icon('quest_gold')
			newbutton.get_node("name").text = tr('QUESTGOLD')
			newbutton.get_node("amount").text = String(reward.gold)
		for mat_id in reward.materials:
			has_content = true
			var item = Items.materiallist[mat_id]
			var newbutton = input_handler.DuplicateContainerTemplate(list)
			newbutton.show()
			newbutton.get_node("Icon").texture = item.icon
			newbutton.get_node("name").text = item.name
			newbutton.get_node("amount").text = str(reward.materials[mat_id])
			globals.connectmaterialtooltip(newbutton, item)
		for item in reward.items:
			has_content = true
			var newbutton = input_handler.DuplicateContainerTemplate(list)
			newbutton.show()
			item.set_icon(newbutton.get_node("Icon"))
			newbutton.get_node("name").text = item.name
			globals.connectitemtooltip_v2(newbutton, item)
			if item.amount == null || item.amount == 0:
				newbutton.get_node("amount").visible = false
			else:
				newbutton.get_node("amount").text = str(item.amount)
	
	if list == cur_reward_cont:
		cur_reward_panel.visible = has_content

func on_leave_btn():
	if round_num == 1 or ResourceScripts.game_progress.arena.finished:
		close()
	elif round_num == round_max:
		finish_arena()
	else:
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'finish_arena', tr('ARENA_FINISH')])

func finish_arena():
	stop_listen_combat()
	for i in cur_reward.materials:
		ResourceScripts.game_res.materials[i] += cur_reward.materials[i]
	for i in cur_reward.items:
		globals.AddItemToInventory(i)
	ResourceScripts.game_res.money += cur_reward.gold
	
	yield(close(), 'completed')#for animation
	
	discard_progress()
	close_doors()

func defeat():
	close_doors()
	input_handler.get_spec_node(input_handler.NODE_POPUP, [tr('ARENA_DEFEAT')])
	stop_listen_combat()
	discard_progress()

func clear_group():
	positions_node.unfix_group()
	for pos in group:
		ResourceScripts.game_party.characters[group[pos]].combat_position = 0
	group.clear()
	positions_node.build_location_group()

func next_round(fixed = null):
	if fixed != null:
		round_num = fixed
	else:
		round_num += 1
	update_round_label()

func reset_group_limit():
	var progress = ResourceScripts.game_progress.arena
	progress.group_limit = input_handler.weightedrandom(limits)
	update_limit_label()
	positions_node.set_limit(progress.group_limit)

func make_next_reward():
#	var progress = ResourceScripts.game_progress.arena
	var loot_processor = Items.get_loot()
	#in fact only first next_reward has to be in game_progress, but for now I'm keeping it simple
	next_reward = loot_processor.get_reward(get_reward_loot())
	update_reward(next_reward_cont, next_reward)

func get_enemy_group():
	var group_limit = ResourceScripts.game_progress.arena.group_limit
	var res
	if !enemy_groups.has(round_num):
		res = enemy_groups_defaults.default
	else:
		if !enemy_groups[round_num].has(group_limit):
			res = enemy_groups_defaults[round_num]
		else:
			res = enemy_groups[round_num][group_limit]
	return input_handler.weightedrandom(res)

func get_reward_loot():
	var group_limit = ResourceScripts.game_progress.arena.group_limit
	var res
	if !rewards.has(round_num):
		res = rewards_defaults.default
	else:
		if !rewards[round_num].has(group_limit):
			res = rewards_defaults[round_num]
		else:
			res = rewards[round_num][group_limit]
	return input_handler.weightedrandom(res)

func _custom_gui_controller_close():
	on_leave_btn()
