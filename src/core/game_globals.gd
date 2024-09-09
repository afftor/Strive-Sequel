extends Reference
#extends Node

#mostly static part
var starting_preset = ''
var skip_prologue = false
var original_version = globals.gameversion
var newgame = false
var difficulty = 'medium'

var seed_salt = randi()

#dynamic part
var date = 1
var hour = 1

var daily_sex_left = 1
var daily_dates_left = 1
var weekly_sex_left = 2
var weekly_sex_max = 1
var weekly_dates_left = 3
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

#Cheats
var cheats_active = false
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

# Cheat codes
var cheat_code = "fkfynroh"
# var cheat_code = "111"


func get_date():
	return [date, hour]

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
	return inst2dict(self)


func advance_hour():
	if int(date) % input_handler.globalsettings.autosave_frequency == 0 and hour + 1 > variables.HoursPerDay:
		globals.autosave()
	for i in ResourceScripts.game_party.characters.values():
		i.pretick()
	for i in ResourceScripts.game_party.characters.values():
		i.act_prepared()
	for i in ResourceScripts.game_party.characters.values():
		i.tick()
	
	hour += 1
	ResourceScripts.game_world.advance_hour()
	if hour > variables.HoursPerDay:
		advance_day()
		


func advance_day():
	ResourceScripts.game_party.update_global_cooldowns()
	hour = 1
	date += 1
	ResourceScripts.game_progress.days_from_last_church_quest += 1
	ResourceScripts.game_party.advance_day()
	
	#guilds and shops check
	ResourceScripts.game_world.advance_day()
	
	
	
	#weeks check
	if int(date) % variables.DaysPerWeek == 1 or variables.DaysPerWeek == 1:
		reset_limits()
		
		ResourceScripts.game_res.subtract_taxes()
	
	if gui_controller.current_screen == gui_controller.mansion:
		gui_controller.mansion.rebuild_mansion()

func reset_limits():
	weekly_sex_max = 2 + ceil(ResourceScripts.game_party.get_master().get_stat('sexuals_factor') * 0.5) + ResourceScripts.game_res.upgrades.sex_times
	weekly_sex_left = weekly_sex_max
	weekly_dates_max = 3 + floor(ResourceScripts.game_party.get_master().get_stat('charm_factor') * 0.34)
	weekly_dates_left = weekly_dates_max
