extends Reference
#extends Node

#mostly static part
var starting_preset = ''
var original_version
var newgame = false
var difficulty = 'medium'

#dynamic part
var date = 1
var hour = 1

var daily_sex_left = 1
var daily_dates_left = 1

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


func fix_import():
	original_version = globals.gameversion


func serialize():
	return inst2dict(self)

func advance_day():
	hour = 1
	date += 1
	daily_dates_left = 1
	daily_sex_left = 1
