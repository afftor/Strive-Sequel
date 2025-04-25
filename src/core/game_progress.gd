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


var work_quests_finished = []

var dialogue_local_counters = {}

var planned_mansion_events = []
var planned_loc_events = {}


var master_points = 1

var char_events = {
	interval = -1,
	hours_past = 0,
	unplayed_events = []
}

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
	master_points = int(master_points)
	
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
	
	fix_event_duplicate("lilia_finale_1")
	
	while planned_mansion_events.has("ZCEvent_1"): # fixes multiple ZCEvent_1 events
		planned_mansion_events.erase("ZCEvent_1")
	if !seen_events.has("ZCEvent_1") && !planned_mansion_events.has("ZCEvent_1") && (completed_quests.has('cali_heirloom_quest') || completed_quests.has('cali_taming_quest')):
		planned_mansion_events.append("ZCEvent_1")
	if !seen_events.has("goblin_quest_0") && !timed_event_exists("goblin_quest_0") && !seen_events.has("goblin_quest_1") && !timed_event_exists("goblin_quest_1") && completed_quests.has('sword_artifact_quest'):
		globals.common_effects([{code = 'add_timed_event', value = "goblin_quest_0", args = [{type = 'add_to_date', date = [1,1], hour = 1}]}])
	if !seen_events.has("zephyra_lilia_1") && !timed_event_exists("zephyra_lilia_1") && completed_quests.has('zephyra_bath_quest'):
		globals.common_effects([{code = 'add_timed_event', value = "zephyra_lilia_1", args = [{type = 'add_to_date', date = [5,10], hour = 2}]}])
	if !timed_event_exists("lilia_finale_1") and !seen_events.has("lilia_finale_1") and completed_quests.has("sick_lilia_quest") and ResourceScripts.game_party.get_unique_slave("lilia") != null:
		globals.common_effects([{code = 'add_timed_event', value = "lilia_finale_1", args = [{type = 'add_to_date', date = [1,1], hour = 1}]}])
	if !seen_events.has("zephyra_painting_1") && !timed_event_exists("zephyra_painting_1") && completed_quests.has('zephyra_bath_quest') && completed_quests.has('getting_lira_quest'):
		globals.common_effects([{code = 'add_timed_event', value = "zephyra_painting_1", args = [{type = 'add_to_date', date = [2,5], hour = 1}]}])
	#2add amelia questline here. idk how cause herbs quest can be failed - so need correct condition


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
	return int(res)


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
					'quest':
						globals.common_effects([{code = 'progress_quest', value = i.code.quest, stage = i.code.stage}])
					'affect_unique_character':
						var k = ResourceScripts.game_party.get_unique_slave(i.code.name.to_lower())
						if k != null:
							k.affect_char(i.code)
				deleting_events.append(i)
#				if (int(ResourceScripts.game_globals.date) % input_handler.globalsettings.autosave_frequency == 0) and int(ResourceScripts.game_globals.hour) == 1:
#					globals.autosave(true)
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


func fix_event_duplicate(code):
	var tres = null
	var tmp = []
	for i in stored_events.timed_events:
		if i.has('action'):
			continue
		if i.has("code") and i.code == code:
			if tres == null:
				tres = i
			else:
				var f = true
				for req in range(i.reqs.size()):
					var req1 = i.reqs[req]
					var req2 = tres.reqs[req]
					if req1.value > req2.value:
						tmp.push_back(tres)
						tres = i
						f = false
						break
					elif req1.value < req2.value:
						tmp.push_back(i)
						f = false
						break
				if f:
					tmp.push_back(i)
	for ev in tmp:
		stored_events.timed_events.erase(ev)


func timed_event_exists(event):
	for i in stored_events.timed_events:
		if i.has('action'):
			continue
		if i.has("code") and i.code == event:
			return true
	return false

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

func get_counter(c_name):
	if !dialogue_local_counters.has(c_name):
		dialogue_local_counters[c_name] = 0
	return dialogue_local_counters[c_name]

func if_quest_active(id):
	if completed_quests.has(id): return false
	for q in active_quests:
		if q.code == id:
			return true
	var qdata = ResourceScripts.game_world.get_quest_by_id(id)
	if qdata != null and !(qdata.state in ['complete', 'failed']):
		return true
	return false

#planned_loc_events, theoretically, can be used for any location, while it's id is unique,
#including mansion (by incorporating planned_mansion_events functionality in planned_loc_events),
#but for now I'll make it only for cities
func plan_loc_event(loc, event):
	if !planned_loc_events.has(loc):
		planned_loc_events[loc] = []
	if planned_loc_events[loc].has(event):
		return
	planned_loc_events[loc].append(event)

func try_planned_loc_event(loc):
	if !planned_loc_events.has(loc):
		return
	
	var to_rem = []
	for loc_event in planned_loc_events[loc]:
		if globals.checkreqs(scenedata.scenedict[loc_event].reqs.duplicate(true)):#is duplicate() truly needed?
			input_handler.interactive_message(loc_event, '', {})
			to_rem.append(loc_event)
	
	for rem in to_rem:
		planned_loc_events[loc].erase(rem)
	if planned_loc_events[loc].empty():
		planned_loc_events.erase(loc)


func get_default_materials(): 
	if decisions.has('act3_finish'):
		return 't6'
	if decisions.has('act2_finish'):
		return 't5'
	if decisions.has('act1_finish') and true:
		return 't4'
	if decisions.has('act1_finish'):
		return 't3'
	if decisions.has('act1_start'):
		return 't2'
	return 't1' #any



func get_materials_from_conds(data):
	for tier in data:
		if globals.checkreqs(data[tier]):
			return tier
	return get_default_materials()


func can_gather_item(mat_id):
	var tmp = Items.material_tiers[get_default_materials()]
	var matdata = Items.materiallist[mat_id]
	if matdata.type in ['food'] or ResourceScripts.game_globals.diff_free_gather:
		return true
	return tmp.has(mat_id)
