extends Reference

var party
var interval = -1
var hours_past = 0
var interval_min = 10
var interval_max = 14
var events_data
var unplayed_events = []

func _init(new_party):
	party = new_party
	events_data = load("res://assets/data/char_events_data.gd").new()

func supplement_events():
	events_data.supplement_events()

func make_new_interval():
	interval = globals.rng.randi_range(interval_min, interval_max)
	hours_past = 0

func advance_time():
	if interval < 0:
		make_new_interval()
	hours_past += 1
	if hours_past >= interval:
		make_new_interval()
		start_event()


func start_event():
	if unplayed_events.empty():
		unplayed_events = events_data.list.keys()
	var rand_event_num = randi() % unplayed_events.size()
	var event_id = unplayed_events[rand_event_num]
	unplayed_events.remove(rand_event_num)
	
	var list = []
	for id in party.characters:
		if !party.characters[id].has_profession("master"):
			list.append(id)
#	return input_handler.random_from_array(list)
	var test_id = input_handler.random_from_array(list)
#	print(party.characters[test_id].get_short_name())
	var chara = party.characters[test_id]
	
	input_handler.active_character = chara
	input_handler.scene_characters.append(chara)
	input_handler.interactive_message(event_id)
