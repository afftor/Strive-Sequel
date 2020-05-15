extends Reference

var parent
var area = ''
var location = 'mansion'
var travel_target = {area = '', location = ''}
var travel_time = 0
var initial_travel_time = 0 setget set_travel_time

func travel_per_tick():
	var value = 1
	if ResourceScripts.game_res.upgrades.has('stables'):
		value = 1 + variables.stable_boost_per_level * ResourceScripts.game_res.upgrades.stables
	return value

func calculate_estimated_travel_time(t_time):
	return ceil(t_time/travel_per_tick())

func set_travel_time(value):
	travel_time = value
	initial_travel_time = value

func check_location(value, completed = false):
	if completed: return travel_time == 0 && location == value
	else: return location == value

func same_location_with(ch_travel_mod):
	return location == ch_travel_mod.location

func tick():
	if travel_time > 0:
		travel_time -= travel_per_tick()
		if travel_time <= 0:
			travel_time = 0
			area = travel_target.area
			location = travel_target.location
			globals.emit_signal("slave_arrived", parent)
			input_handler.PlaySound("ding")
			if location == 'mansion':
				parent.return_to_task()
				globals.text_log_add("travel", parent.get_short_name() + " returned to mansion. ")
			else:
#					if state.capitals.has(location):
#						state.text_log_add("travel", get_short_name() + " arrived at location: " + state.areas[state.capitals[location].area].capital_name)
#					else:
				globals.text_log_add("travel", parent.get_short_name() + " arrived at location: " + ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[location].area][ResourceScripts.game_world.location_links[location].category][location].name)

func make_location_description():
	var text = ''
	var active_area_name
	var active_location_name
	if location == 'travel':
		if travel_target.location == 'mansion':
			active_location_name = 'Mansion'
			active_area_name = ResourceScripts.game_world.starting_area
		else:
			active_area_name = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[travel_target.location].area].name
			active_location_name = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[travel_target.location].area][ResourceScripts.game_world.location_links[location].category][travel_target.location].name
	else:
		active_area_name = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[location].area].name
		active_location_name = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[location].area][ResourceScripts.game_world.location_links[location].category][travel_target.location].name
	
	if location == 'travel':
		text = '[name] currently relocating to [color=yellow]' + active_location_name + "[/color], which is located at [color=aqua]" + active_area_name + "[/color]. [He] will be there in " + str(ceil(travel_time / travel_per_tick())) + ' hours.'
	else:
		text = '[name] currently positioned at [color=yellow]' + active_location_name + "[/color], which is located at [color=aqua]" + active_area_name + "[/color]"
	return text

func return_to_mansion():
	var active_area
	var active_location
	if location == 'travel':
		active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[travel_target.location].area]
		active_location = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[travel_target.location].area][ResourceScripts.game_world.location_links[travel_target.location].category][travel_target.location]
	else:
		active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[location].area]
		active_location = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[location].area][ResourceScripts.game_world.location_links[location].category][location]
	
	if active_location.has("group"):
		for i in active_location.group:
			if active_location.group[i] == parent.id:
				active_location.group.erase(i)
				break
	if variables.instant_travel == false:
		location = 'travel'
		travel_target = {area = '', location = 'mansion'}
		travel_time = max(1, abs(round(active_area.travel_time + active_location.travel_time - travel_time)))
	else:
		location = 'mansion'

func recruit():
	if variables.instant_travel == false:
		travel_target = {area = '', location = 'mansion'}
		travel_time = input_handler.active_area.travel_time + input_handler.active_location.travel_time
		parent.set_work('travel')
		location = 'travel'
	else:
		location = 'mansion'
