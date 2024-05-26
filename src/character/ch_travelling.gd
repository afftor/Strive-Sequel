extends Reference

var parent: WeakRef
var area = ''
var location = ResourceScripts.game_world.mansion_location
var travel_target = {area = '', location = ''}
var travel_time = 0
var initial_travel_time = 0 setget set_travel_time


func remove_from_travel():
	if travel_time > 0:
		set_travel_time(0)
		travel_target = {area = '', location = ''}


func fix_infinite_travel():
	if travel_time <= 0 and location == 'travel':
#		parent.get_ref().remove_from_task()
		set_travel_time(0)
		area = travel_target.area
		location = travel_target.location
		travel_target = {area = '', location = ''}




func set_location_to_default():
	location = ResourceScripts.game_world.mansion_location
	area =  ResourceScripts.game_world.starting_area


func fix_import():
	location = ResourceScripts.game_world.mansion_location
	area = ResourceScripts.game_world.starting_area
	travel_target = {area = '', location = ''}
	travel_time = 0
	initial_travel_time = 0


func travel_per_tick():
	var value = 1
#	if ResourceScripts.game_res.upgrades.has('stables'):
#		value = 1 + variables.stable_boost_per_level * ResourceScripts.game_res.upgrades.stables
	return value


func calculate_estimated_travel_time(t_time):
	return ceil(t_time/travel_per_tick())


func set_travel_time(value):
	travel_time = value
	initial_travel_time = value


func check_location(value, completed = false):
	if completed: return travel_time == 0 && location == value
	else: 
		if location == 'travel' and value != 'travel':
			return travel_target.location == value
		else:
			return location == value


func same_location_with(ch_travel_mod):
	return location == ch_travel_mod.location


func tick():
	if travel_time > 0:
		travel_time -= travel_per_tick()
		if travel_time <= 0:
			travel_time = 0
			area = travel_target.area
			location = travel_target.location
			globals.emit_signal("slave_arrived", parent.get_ref())
			input_handler.PlaySound("ding")
			if location == ResourceScripts.game_world.mansion_location:
				# parent.get_ref().return_to_task()
				parent.get_ref().remove_from_task()
				input_handler.update_slave_list()
				globals.text_log_add(tr("TRAVEL_LABEL"), parent.get_ref().get_short_name() + " " + tr("RETURNED_TO_MANSION_LABEL") + ". ")
			else:
				parent.get_ref().remove_from_task()
				input_handler.update_slave_list()
#					if state.capitals.has(location):
#						state.text_log_add("travel", get_short_name() + " arrived at location: " + state.areas[state.capitals[location].area].capital_name)
#					else:
				globals.text_log_add(tr("TRAVEL_LABEL"), parent.get_ref().get_short_name() + " " + tr("ARRIVED_AT_LOC_LABEL") + ": " + ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[location].area][ResourceScripts.game_world.location_links[location].category][location].name)
			parent.get_ref().return_to_task()

func make_location_description():
	var text = ''
	var active_area_name
	var active_location_name
	if location == 'travel':
		if travel_target.location == ResourceScripts.game_world.mansion_location:
			active_location_name = 'Mansion'
			active_area_name = ResourceScripts.game_world.get_default_area_name()
		else:
			active_area_name = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[travel_target.location].area].name
			active_location_name = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[travel_target.location].area][ResourceScripts.game_world.location_links[travel_target.location].category][travel_target.location].name
	else:
		active_area_name = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[location].area].name
		active_location_name = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[location].area][ResourceScripts.game_world.location_links[location].category][travel_target.location].name
	
	if location == 'travel':
		text = '[name] currently relocating to [color=yellow]' + active_location_name + "[/color], which is located at [color=aqua]" + active_area_name + "[/color]. [He] will be there in " + str(ceil(travel_time / travel_per_tick())) + ' turns'
	else:
		text = '[name] currently positioned at [color=yellow]' + active_location_name + "[/color], which is located at [color=aqua]" + active_area_name + "[/color]"
	return text

func return_to_mansion():
#	parent.get_ref().set_work('travel')
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
			if active_location.group[i] == parent.get_ref().id:
				active_location.group.erase(i)
				break
	if ResourceScripts.game_progress.instant_travel == false and parent.get_ref().get_work() != 'disabled':
		location = 'travel'
		parent.get_ref().set_work('travel')
		travel_target = {area = ResourceScripts.game_world.starting_area, location = ResourceScripts.game_world.mansion_location}
		travel_time = max(1, abs(round(active_area.travel_time + active_location.travel_time - travel_time - variables.stable_boost_per_level * ResourceScripts.game_res.upgrades.stables)))
		globals.emit_signal("slave_departed")
	else:
		location = ResourceScripts.game_world.mansion_location
		globals.emit_signal("slave_arrived")

func return_recruit():
	if ResourceScripts.game_progress.instant_travel == false:
		travel_target = {area = ResourceScripts.game_world.starting_area, location = ResourceScripts.game_world.mansion_location}
		travel_time = input_handler.active_area.travel_time + input_handler.active_location.travel_time
		parent.get_ref().set_work('travel')
		location = 'travel'
	else:
		location = ResourceScripts.game_world.mansion_location
		globals.emit_signal("slave_arrived")
