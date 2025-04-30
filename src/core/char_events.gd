extends Node#Reference


var interval_min = 10
var interval_max = 14
var events_data = load("res://assets/data/char_events_data.gd").new()
var return_events = []
var max_trys

func _init():
	max_trys = events_data.list.size()
#	party = new_party
#	events_data

func supplement_events():
	events_data.supplement_events()

func make_new_interval():
	var progress = ResourceScripts.game_progress.char_events
	progress.interval = globals.rng.randi_range(interval_min, interval_max)
	progress.hours_past = 0

func advance_hour():
	var progress = ResourceScripts.game_progress.char_events
	if progress.interval < 0:
		make_new_interval()
	progress.hours_past += 1
	if progress.hours_past >= progress.interval:
		make_new_interval()
		for i in range(max_trys):
			if try_start_event():
				break
#			if i == max_trys - 1:
#				print("no suitable events!")

#this is simpler version of game_party._in_same_location()
#maybe it will be better to move it there
func is_same_location(char1_id, char2_id):
	var person1 = characters_pool.get_char_by_id(char1_id)
	var person2 = characters_pool.get_char_by_id(char2_id)
	return person1.get_location() == person2.get_location()
	

func try_start_event():
	var party = ResourceScripts.game_party
	var progress = ResourceScripts.game_progress.char_events
	if progress.unplayed_events.empty():
		progress.unplayed_events = events_data.list.keys()
		return_events.clear()
	var rand_event_num = randi() % progress.unplayed_events.size()
	var event_id = progress.unplayed_events[rand_event_num]
	progress.unplayed_events.remove(rand_event_num)
	
	var event_reqs
	if events_data.list[event_id].has("special_reqs"):
		event_reqs = events_data.list[event_id].special_reqs
	
	var list_by_loc = {}
	#get_romance_pair made unique solution. I can't come up with any universal idea
	if event_reqs and event_reqs.has('get_romance_pair'):
		var romance_pairs = party.get_all_possible_love_pairs()
		var true_pairs = []
		for pair in romance_pairs:
			if is_same_location(pair[0], pair[1]):
				true_pairs.append(pair)
		if !true_pairs.empty():
			list_by_loc.romance = input_handler.random_from_array(true_pairs)
	else:
		for id in party.characters:
			var party_char = party.characters[id]
			#char_reqs_precise rule should be added here somewhere
			if !party_char.has_profession("master"):
				if (!event_reqs
						or !event_reqs.has('char_reqs')
						or party_char.checkreqs(event_reqs.char_reqs)):
					var loc = party_char.get_location()
					if !list_by_loc.has(loc):
						list_by_loc[loc] = []
					list_by_loc[loc].append(id)
	
	var char_count = 1
	if event_reqs and event_reqs.has('char_count'):
		char_count = event_reqs.char_count
	var useable_locs = []
	for loc_id in list_by_loc:
		if list_by_loc[loc_id].size() >= char_count:
			useable_locs.append(loc_id)
	if useable_locs.empty():
#		print("no suitable char for %s!" % event_id)
		return_events.append(event_id)
		return false
	
	var rnd_key = input_handler.random_from_array(useable_locs)
	var list = list_by_loc[rnd_key]
	for i in range(char_count):
		var list_id = randi() % list.size()
		var chara = party.characters[list[list_id]]
		if i == 0:
			input_handler.active_character = chara
		input_handler.scene_characters.append(chara)
		list.remove(list_id)
	
	if !return_events.empty():
		progress.unplayed_events.append_array(return_events)
#		print("return %s" % String(return_events))
		return_events.clear()
	input_handler.interactive_message(event_id)
	return true
