extends Reference
#extends Node

#mostly static part
var starting_preset = ''
var original_version
var newgame = false
var difficulty = 'medium'

#dynamic part
var date = 0
var hour = 1

var daily_sex_left = 1
var daily_dates_left = 1
var weekly_sex_left = 1
var weekly_sex_max = 1
var weekly_dates_left = 1
var weekly_dates_max = 1

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


func fix_serialization():
	date = int(date)
	hour = int(hour)
	weekly_sex_left = int(weekly_sex_left)
	weekly_sex_max = int(weekly_sex_max)
	weekly_dates_left = int(weekly_dates_left)
	weekly_dates_max = int(weekly_dates_max)


func fix_import():
	fix_serialization()
	original_version = globals.gameversion


func serialize():
	return inst2dict(self)


func advance_hour():
	for i in ResourceScripts.game_party.characters.values():
		i.pretick()
	for i in ResourceScripts.game_party.characters.values():
		i.act_prepared()
	for i in ResourceScripts.game_party.characters.values():
		i.tick()
	
	hour += 1
	if hour > variables.HoursPerDay:
		advance_day()


func advance_day():
	ResourceScripts.game_party.update_global_cooldowns()
	hour = 1
	date += 1
	ResourceScripts.game_progress.days_from_last_church_quest += 1
#	daily_sex_left = 1 + ResourceScripts.game_res.upgrades.sex_times
#	daily_dates_left = 1
	ResourceScripts.game_party.advance_day()
	
	#guilds and shops check
	ResourceScripts.game_world.advance_day()
	
	#weeks check
	if int(date) % variables.DaysPerWeek == 0:
		reset_limits()
	
	globals.autosave()
	
	if gui_controller.current_screen == gui_controller.mansion:
		gui_controller.mansion.rebuild_mansion()

func reset_limits():
	weekly_sex_max = ResourceScripts.game_party.get_master().get_stat('sexuals_factor') / 2 # + ResourceScripts.game_res.upgrades.sex_times
	weekly_sex_left = weekly_sex_max
	weekly_dates_max = 1 + ResourceScripts.game_party.get_master().get_stat('charm_factor')
	weekly_dates_left = weekly_dates_max
