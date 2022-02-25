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
var seen_events = []
var daily_dialogues = []

var stored_events = {
	timed_events = [],
}

var completed_locations = {}

var days_from_last_church_quest = 0

var spouse = null
var marriage_completed = false

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
#var unlock_all_scenes = false

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
	days_from_last_church_quest = int(days_from_last_church_quest)
	var tmp = []
	for line in seen_dialogues:
		if input_handler.if_translation_key(line):
			tmp.push_back(line)
	seen_dialogues = tmp
	
	#divine_symbol_quest fix
	var t = get_active_quest('divine_symbol_quest')
	if t != null:
#		if tmp.stage in []: # for i deduced that millford should be locked for full duration of quest
		globals.common_effects([{code = 'set_location_param', location = 'settlement_plains1', area = 'plains', param = 'locked', value = true},])
	#marriage spouse fix
	if spouse!= null and !globals.valuecheck({type = 'has_spouse', check = true}) and !marriage_completed:
		var clear = []
		for i in range(active_quests.size()):
			var q = active_quests[i]
			if q.code.begins_with('marriage_'):
				clear.push_front(i)
		for i in clear:
			print("removed questdata:")
			print(active_quests[i])
			active_quests.remove(i)
		for q in completed_quests.duplicate():
			if q.begins_with("marriage"):
				print("removed comquestdata: " + q)
				completed_quests.erase(q)
		for line in seen_dialogues.duplicate():
			if line.begins_with("MARRIAGE"):
				print("removed dialogue: " + line)
				seen_dialogues.erase(line)
		for line in selected_dialogues.duplicate():
			if line.begins_with("MARRIAGE"):
				print("removed dialogue: " + line)
				selected_dialogues.erase(line)


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
	return null


func get_time_of_event(ev):
	var res = {date = -1, hour = -1}
	for req in ev.reqs:
		if req.type == 'date':
			res.date = req.value
		if req.type == 'hour':
			res.hour = req.value
	return res

func get_next_event_time():
	var res = 0
	for i in stored_events.timed_events:
		if i.has('broken'): continue
		var time = get_time_of_event(i)
		#some debugging
		if time.date == -1: 
			print("error - broken timed event")
			print(i)
			i.broken = true
			continue
		if time.hour == -1 or time.hour > 4: 
			print("error - broken timed event")
			print(i)
			i.broken = true
			continue
		if time.date < ResourceScripts.game_globals.date: 
			print("error - broken timed event")
			print(i)
			i.broken = true
			continue
		var trem = time.hour - ResourceScripts.game_globals.hour + 4 * (time.date - ResourceScripts.game_globals.date)
		if trem < 0: 
			print("error - broken timed event")
			print(i)
			i.broken = true
			continue
		if res == 0: 
			res = trem
		else:
			res = min(res, trem)
	return res


func check_timed_events():
	var deleting_events = []
	for i in stored_events.timed_events:
		if globals.checkreqs(i.reqs):
			if i.has('action'): # it's for action_to_date
				match i.action:
					'decision':
						if !ResourceScripts.game_progress.decisions.has(i.code):
							ResourceScripts.game_progress.decisions.append(i.code)
					'remove_decision':
						if ResourceScripts.game_progress.decisions.has(i.code):
							ResourceScripts.game_progress.decisions.erase(i.code)
				deleting_events.append(i)
				continue
			var event = scenedata.scenedict[i.code]
			var failed = false
			if event.has('reqs'):
				for k in event.reqs:
					if globals.valuecheck(k) == false:
						failed = true
						if k.has('negative'):
							match k.negative:
								'repeat_next_day':
									for j in i.reqs:
										if j.type in ['date']:
											j.value += 1
									break
			if !failed:
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


func if_quest_active(id):
	if completed_quests.has(id): return false
	for q in active_quests:
		if q.code == id:
			return true
	var qdata = ResourceScripts.game_world.get_quest_by_id(id)
	if qdata != null and !(qdata.state in ['complete', 'failed']):
		return true
	return false
