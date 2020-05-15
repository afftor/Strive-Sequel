extends Reference
#extends Node

var questcounter = 0

var mainprogress = 0
var decisions = []
var active_quests = []
var completed_quests = []
var areaprogress = {}
var currentarea
var active_tutorials = []
var seen_tutorials = []
var show_tutorial = true

var seen_dialogues = []
var selected_dialogues = []

var stored_events = {
	timed_events = [],
}

var completed_locations = {}

func _init():
	globals.connect("hour_tick", self, 'check_timed_events')

func serialize():
	return inst2dict(self)

#finders
func get_active_quest(code):
	for i in active_quests:
		if i.code == code:
			return i
	return 

func check_timed_events():
	for i in stored_events.timed_events:
		if globals.checkreqs(i.reqs):
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
			stored_events.timed_events.erase(i)
			break

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

func if_has_progress(value, operant):
	return input_handler.operate(operant, mainprogress, value)

func update_progress(operant, value):
	match operant:
		'+':
			mainprogress += value
		'-':
			mainprogress -= value
		'=':
			mainprogress = value

