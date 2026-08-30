extends Reference
#extends Node

#mostly static part
var starting_preset = ''
var skip_prologue = false
var original_version = globals.gameversion
var newgame = false
var difficulty = 'medium'
#diff
var diff_gf_only_upg = false
var diff_permadeath = false
var diff_bonus_taskmod = false
var diff_bonus_loot = false
var diff_stop_loan = true
var diff_small_loan = false
var diff_solo = false
var diff_free_upgrade = true
var diff_free_gather = false
var diff_hard_monsters = false

var diff_money = 'easy'
var diff_materials = 'easy'
var diff_free_chars = 0
var easytrain = false
var all_starting_races = false

var seed_salt = randi()

#dynamic part
var date = 1
var hour = 1

#var daily_sex_left = 1
#var daily_dates_left = 1
var weekly_sex_left = 2
var weekly_sex_max = 1
var weekly_dates_left = 3
var weekly_dates_max = 1
var mansion_activity_log = []

#not used
#var votelinksseen = false

#moved to globals
#for i am sure that those parameters should not be serialized
#var hour_turns_set = 1
#var CurrentTextScene
#var CurrentScreen
#var CurrentLine = 0
#var log_node
#var log_storage = []

#Cheats
#cheats_active and cheat_code moved to input_handler.progress_data - they are account-wide, not per-save
var instant_travel = false
var skip_combat = false
var free_upgrades = false
var instant_upgrades = false
var unlock_all_upgrades = false
var invincible_player = false
var show_enemy_hp = true
var social_skill_unlimited_charges = false
var allow_skip_fights = false
var unlimited_date_sex = false
var unlock_all_classes = false
var unlimited_popcap = false
#var unlock_all_scenes = false


func get_date():
	return [date, hour]

func get_turn(): #date and hour flattened into a single ever-growing turn number
	return (date - 1) * variables.HoursPerDay + hour

func get_week_and_day():
	return [((date - 1) / 7 + 1), int((date - 1) % 7 + 1)]

func get_week_and_day_custom(new_date):
	return [((new_date - 1) / 7), int((int(new_date) - 1) % 7 + 1)]

func fix_serialization():
	date = int(date)
	hour = int(hour)
	seed_salt = int(seed_salt)
	weekly_sex_left = int(weekly_sex_left)
	weekly_sex_max = int(weekly_sex_max)
	weekly_dates_left = int(weekly_dates_left)
	weekly_dates_max = int(weekly_dates_max)
	if mansion_activity_log == null:
		mansion_activity_log = []
	while mansion_activity_log.size() > 50:
		mansion_activity_log.pop_front()
	if original_version == null: #stub, technically not correct
		original_version = globals.gameversion
	if difficulty == 'normal':
		difficulty = 'medium'


func fix_import():
	fix_serialization()
	date = 1
	hour = 1
	original_version = globals.gameversion
#	if !starting_presets.preset_data.has(starting_preset):
	starting_preset = 'import'


func serialize():
	return inst2dict(self).duplicate(true)


func autosave_due():
	return int(date) % input_handler.globalsettings.autosave_frequency == 0 and hour + 1 > variables.HoursPerDay


#managed = the caller (clock module) drives the autosave and the mansion rebuild itself,
#spreading the tick over frames instead of doing everything inside a single one.
#in managed mode this is a coroutine - yield on 'completed'. The optional clock target
#receives one cumulative fraction for the whole simulation without exposing its stages.
func advance_hour(managed = false, progress_target = null):
	if managed: #always a coroutine when managed, so the caller can yield on it
		yield(globals.get_tree(), 'idle_frame')
	_report_turn_progress(progress_target, 0.01)
	if !managed and autosave_due():
		globals.autosave()
	#slices are cut by elapsed time rather than character count, so one frame costs the same
	#whether a character is cheap or expensive and the transition animates at a steady rate
	#Who slept without a bed is decided once, here, before a single character ticks and long
	#before game_res.tick() works out what the day's work produced - the penalty has to be on
	#them while their work is counted, not after it.
	ResourceScripts.game_res.mark_slept_rough()
	var slice = OS.get_ticks_msec()
	var turn_characters = ResourceScripts.game_party.characters.values()
	var character_count = max(turn_characters.size(), 1)
	var character_index = 0
	for i in turn_characters:
		i.pretick()
		character_index += 1
		_report_turn_progress(progress_target, 0.02 + 0.16 * float(character_index) / character_count)
		if managed and OS.get_ticks_msec() - slice >= variables.turn_frame_budget_msec:
			yield(globals.get_tree(), 'idle_frame')
			slice = OS.get_ticks_msec()
	turn_characters = ResourceScripts.game_party.characters.values()
	character_count = max(turn_characters.size(), 1)
	character_index = 0
	for i in turn_characters:
		i.act_prepared()
		character_index += 1
		_report_turn_progress(progress_target, 0.18 + 0.10 * float(character_index) / character_count)
	slice = OS.get_ticks_msec()
	turn_characters = ResourceScripts.game_party.characters.values()
	character_count = max(turn_characters.size(), 1)
	character_index = 0
	for i in turn_characters:
		i.tick()
		character_index += 1
		_report_turn_progress(progress_target, 0.28 + 0.50 * float(character_index) / character_count)
		if managed and OS.get_ticks_msec() - slice >= variables.turn_frame_budget_msec:
			yield(globals.get_tree(), 'idle_frame')
			slice = OS.get_ticks_msec()
	if managed:
		yield(globals.get_tree(), 'idle_frame')
	_report_turn_progress(progress_target, 0.80)
	if managed:
		yield(ResourceScripts.game_res.tick(true), 'completed')
	else:
		ResourceScripts.game_res.tick()
	_report_turn_progress(progress_target, 0.88)
	if managed:
		yield(globals.get_tree(), 'idle_frame')
	hour += 1
	ResourceScripts.game_res.clear_buyback() #shops resell what they bought once the turn ends

	ResourceScripts.game_world.advance_hour()
	ResourceScripts.char_events.advance_hour()
	if hour > variables.HoursPerDay:
		if managed:
			yield(advance_day(true), 'completed')
		else:
			advance_day()
	_report_turn_progress(progress_target, 1.0)


func _report_turn_progress(progress_target, value):
	if progress_target != null and progress_target.has_method("set_turn_simulation_progress"):
		progress_target.set_turn_simulation_progress(value)


func advance_day(managed = false):
	if managed: #always a coroutine when managed, so the caller can yield on it
		yield(globals.get_tree(), 'idle_frame')
	ResourceScripts.game_party.update_global_cooldowns()
	hour = 1
	date += 1
	ResourceScripts.game_progress.days_from_last_church_quest += 1
	if managed:
		yield(ResourceScripts.game_party.advance_day(true), 'completed')
	else:
		ResourceScripts.game_party.advance_day()

	#a night shared in the master's bed is worth something to everyone who shared it
	ResourceScripts.game_res.reward_master_bed_night()

	#the clerk's morning trip to market, against the standing orders the player left
	ResourceScripts.game_res.process_autobuy()

	#guilds and shops check
	ResourceScripts.game_world.advance_day()

	#weeks check
	if int(date) % variables.DaysPerWeek == 1 or variables.DaysPerWeek == 1:
		reset_limits()

		ResourceScripts.game_res.subtract_taxes()
		ResourceScripts.slave_quests.regen_quests()

	if !managed and gui_controller.current_screen == gui_controller.mansion:
		gui_controller.mansion.rebuild_mansion()


func reset_limits():
	weekly_sex_max = 2 + ceil(ResourceScripts.game_party.get_master().get_stat('sexuals_factor') * 0.5) + ResourceScripts.game_res.findupgradelevel('sex_times')
	weekly_sex_left = weekly_sex_max
	update_weekly_dates()
	weekly_dates_left = weekly_dates_max

func update_weekly_dates():
	weekly_dates_max = 3 + floor(ResourceScripts.game_party.get_master().get_stat('charm_factor') * 0.34)
	if ResourceScripts.game_party.get_master().check_trait('master_communicative'):
		weekly_dates_max += 2
	
