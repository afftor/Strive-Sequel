extends Reference
#extends Node

var questcounter = 0

var decisions = []
var active_quests = []
var completed_quests = []
var areaprogress = {}
var currentarea
var active_tutorials = []
var seen_tutorials = []
var show_tutorial = false
var intro_tutorial_seen = false
var unlocked_classes = []

var seen_dialogues = []
var selected_dialogues = []

var stored_events = {
	timed_events = [],
}

var completed_locations = {}

var days_from_last_church_quest = 0

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

# Cheat codes
var cheat_code = "fkfynroh"
# var cheat_code = "111"

var work_quests_finished = []

var dialogue_local_counters = {}


func _init():
	globals.connect("hour_tick", self, 'check_timed_events')

func serialize():
	return inst2dict(self)

func fix_serialization():
	var tmp = []
	for line in seen_dialogues:
		if input_handler.if_translation_key(line):
			tmp.push_back(line)
	seen_dialogues = tmp


func fix_import():#this is the most questionable fix
	var tmp = []
	for i in active_quests:
		if !scenedata.quests.has(i.code): continue
		var data = scenedata.quests[i.code]
		var record = i.duplicate()
		record.stage = 0
		tmp.push_back(record)
	active_quests = tmp

#finders
func get_active_quest(code):
	for i in active_quests:
		if i.code == code:
			return i
	return 

func check_timed_events():
	var deleting_events = []
	for i in stored_events.timed_events:
		if globals.checkreqs(i.reqs):
			if i.has('action'):
				match i.action:
					'decision':
						if !ResourceScripts.game_progress.decisions.has(i.code):
							ResourceScripts.game_progress.decisions.append(i.code)
					'remove_decision':
						if ResourceScripts.game_progress.decisions.has(i.code):
							ResourceScripts.game_progress.decisions.erase(i.code)
				
				deleting_events.append(i)
				return
			var event = scenedata.scenedict[i.code]
			if event.has('reqs'):
				for k in event.reqs:
					if globals.valuecheck(k) == false:
						match k.negative:
							'repeat_next_day':
								for j in i.reqs:
									if j.type in ['date']:
										j.value += 1
						return
			input_handler.interactive_message(i.code, 'story_event', {})
			deleting_events.append(i)
	for i in deleting_events:
		stored_events.timed_events.erase(i)

#checks
func if_quest_stage(name, value, operant):
	var questprogress
	#questprogress = GetQuest(name)
	if questprogress == null:
		questprogress = 0
	return input_handler.operate(operant, questprogress, value)

func if_has_area_progress(value, operant, area):
	if !areaprogress.has(area):return false
	return input_handler.operate(operant, areaprogress[area], value)


func if_class_unlocked(name, value, operant):
	return input_handler.operate(operant, unlocked_classes.has(name), value)


func if_time_passed(value, quest):
	var check = false
	match quest:
		"aliron_church":
			check = days_from_last_church_quest > value
	return check

func reset_day_count(quest):
	match quest:
		"aliron_church":
			days_from_last_church_quest = 0


func operate_counter(c_name, c_op):
	if !dialogue_local_counters.has(c_name): 
		dialogue_local_counters[c_name] = 0
	match c_op:
		'+': dialogue_local_counters[c_name] += 1
		'-': dialogue_local_counters[c_name] -= 1
		_: dialogue_local_counters[c_name] = c_op


func counter_cond(c_name, c_op, value):
	if !dialogue_local_counters.has(c_name): 
		dialogue_local_counters[c_name] = 0
	return input_handler.operate(c_op, dialogue_local_counters[c_name], value)
