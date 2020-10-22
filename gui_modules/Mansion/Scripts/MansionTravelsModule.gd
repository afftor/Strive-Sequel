extends Panel



var dislocation_area = 'mansion'
var destination_area = 'plains'
var selected_location

func _ready():
	$HomeButton.connect("item_selected", self, 'select_dislocation_area')
	$DestinationButton.connect("item_selected", self, 'select_destination_area')
	$TravelConfirmButton.connect("pressed", self, "travel_confirm")
	$TravelCancelButton.connect("pressed", self, "travel_update")
	$LocationListButton.connect("toggled", self, "show_location_list")
	$Forget.connect("pressed", self, "forget_location")
	globals.connect("hour_tick", self, "open_character_dislocation")


func show_location_list(pressed):
	var locations_window = get_parent().Locations
	get_parent().submodules.append(locations_window) if pressed else get_parent().submodules.erase(locations_window)
	locations_window.visible = pressed
	locations_window.open()


func update():
	var locations_window = get_parent().Locations
	$LocationListButton.pressed = locations_window.is_visible()


func open_character_dislocation():
	$Forget.hide()
	if selected_location != null:
		var location = ResourceScripts.world_gen.get_location_from_code(selected_location)
		if location.type in ["quest_location", "encounter", "dungeon"]:
			if location.has("completed"):
				$Forget.visible = location.completed
	if get_parent().mansion_state == "travels":
		show()
	if get_parent().active_person == null:
		return
	dislocation_area = get_parent().active_person.travel.location
	# destination_area = 'plains'
	$HomeButton.clear()
	$HomeButton.add_item(tr("MANSION"))
	$HomeButton.set_item_metadata($HomeButton.get_item_count()-1, 'mansion')
	$LocationListButton.pressed = get_parent().Locations.is_visible()
	var populatedlocations = []
	var travelers = []
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if !person.travel.location in ['mansion','travel'] && populatedlocations.has(person.travel.location) == false:
			populatedlocations.append(person.travel.location)
		elif person.travel.location == 'travel':
			travelers.append(person)
	
	input_handler.ClearContainer($TravelersContainer/VBoxContainer)
	for i in travelers:
		var newlabel = input_handler.DuplicateContainerTemplate($TravelersContainer/VBoxContainer)
		newlabel.get_node("Label").text = i.get_short_name()
		if i.travel.travel_target.location != 'mansion':
			newlabel.get_node("Label").text += " - " + ResourceScripts.world_gen.get_location_from_code(i.travel.travel_target.location).name
		else:
			newlabel.get_node("Label").text += " - " + tr("MANSION")
		newlabel.get_node("Progress").value = i.travel.initial_travel_time - i.travel.travel_time
		newlabel.get_node("Progress").max_value = i.travel.initial_travel_time
		newlabel.get_node("Progress/Time").text = 'Until arrival: ' + str(ceil(i.travel.travel_time/i.travel_per_tick())) + " hours"
		# globals.connectslavetooltip(newlabel, i)
		newlabel.get_node("ReturnButton").connect('pressed',self,'cancel_travel', [i])
	
	for i in populatedlocations:
		$HomeButton.add_item(ResourceScripts.world_gen.get_location_from_code(i).name)
		$HomeButton.set_item_metadata($HomeButton.get_item_count()-1, i)




func cancel_travel(person):
	if person.travel.travel_target.location != 'mansion':
		return_confirm(person)
	else:
		input_handler.SystemMessage(person.translate("[name] is already heading back to Mansion."))

var returnperson

func return_confirm(person):
	returnperson = person
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'return_character', person.translate('Send [name] back to Mansion?')])

func return_character():
	returnperson.return_to_mansion()
	open_character_dislocation()
	input_handler.update_slave_list()


var params = {code = '', destination = ""}
func select_destination(destination_code):
	selected_location = destination_code
	params = {code = 'destination_selected', destination = destination_code}
	destination_area = ResourceScripts.game_world.location_links[destination_code].area
	get_parent().travels_manager(params)
	show_location_resources(destination_code)

func forget_location():
	input_handler.get_spec_node(
		input_handler.NODE_CONFIRMPANEL,
		[
			self,
			'clear_dungeon_confirm',
			"Forget this location? All present characters will be sent back to Mansion. This action can't be undone."
		]
	)


func clear_dungeon_confirm():
	globals.remove_location(selected_location)
	selected_location = null
	# action_type = 'location_finish'

func show_location_resources(location_code):
	var dungeon = false
	$Resources.show()
	var location = ResourceScripts.world_gen.get_location_from_code(location_code)
	var gatherable_resources
	if location.type in ["capital", "quest_location"]:
		$Resources.hide()
		return
	elif location.type == "dungeon":
		dungeon = true
		if location.completed:
			gatherable_resources = location.gather_limit_resources
	else:
		if location.has('gather_resources'):
			gatherable_resources = location.gather_resources
	input_handler.ClearContainer($Resources/GridContainer)
	if gatherable_resources != null:
		for i in gatherable_resources:
			var item = Items.materiallist[i]
			var newbutton = input_handler.DuplicateContainerTemplate($Resources/GridContainer)
			newbutton.get_node("TextureRect").texture = Items.materiallist[i].icon
			if dungeon:
				newbutton.get_node("Label").text = str(gatherable_resources[i])
				newbutton.set_meta("gather_mod", round(location.gather_mod*100))
			else:
				var max_workers_count = gatherable_resources[i]
				var current_workers_count = 0
				var active_tasks = ResourceScripts.game_party.active_tasks
				for task in active_tasks:
					if (task.code == i) && (task.task_location == location_code):
						current_workers_count = task.workers_count
				newbutton.get_node("Label").text = str(max_workers_count - current_workers_count) + "/" + str(max_workers_count)
				newbutton.set_meta("max_workers", max_workers_count)
				newbutton.set_meta("current_workers", current_workers_count)
			globals.connectmaterialtooltip(newbutton, item)
	$Resources/Label.visible = gatherable_resources != null

#func update_buttons():
#	for i in $DestinationContainer/ScrollContainer/VBoxContainer.get_children():
#		if !i.has_meta("code"):
#			continue
#		i.pressed = i.get_meta("code") == get_parent().selected_destination


func update_character_dislocation():
	input_handler.ActivateTutorial("traveling")
	var destination = get_parent().selected_destination
	var selected_travel_characters = get_parent().selected_travel_characters
	var char_array = []
	var obed_cost = 0
	var text = "Characters selected: " + str(selected_travel_characters.size())
	var text2 = ''
	if destination == null:
		text += "\n\nSelect location to proceed"
	elif destination in ['mansion', 'aliron']:
		text += "\n\nTarget Location: " + tr("MANSION")
		if selected_travel_characters.size() > 0 :
			var max_time = 0
			for person in selected_travel_characters:
				var person_location
				if person.travel.location == "travel":
					person_location = person.previous_location
				else:
					person_location = person.travel.location
				max_time = max(ceil(globals.calculate_travel_time(person_location, 'aliron').time /  ResourceScripts.game_party.characters[person.id].travel_per_tick()), max_time)
			text += "\nTravel Time: " + str(max_time) + " hours."
	else:
		var location = ResourceScripts.world_gen.get_location_from_code(destination)
		# text += "\n\nTarget Location: \n[color=yellow]" + location.name + "[/color]" 
		match location.type:
			'dungeon':
				text += "\nType: " + location.classname + "\n" + tr("DUNGEONDIFFICULTY") + ": " + tr("DUNGEONDIFFICULTY" + location.difficulty.to_upper())
			'settlement':
				text += "\nType: " + tr(location.type.to_upper())
			'skirmish':
				pass
		if selected_travel_characters.size() > 0 :
			if dislocation_area == "mansion":
				dislocation_area = "aliron"
			if dislocation_area == "travel":
				dislocation_area = selected_travel_characters[0].travel.location
			var travel_time = globals.calculate_travel_time(destination, dislocation_area) 
			text2 = "Travel Time: " + str(ceil(travel_time.time / selected_travel_characters[0].travel_per_tick())) + " hours."
			obed_cost = ceil(travel_time.obed_cost / selected_travel_characters[0].travel_per_tick())
			text2 += "\nObedience Cost: " + str(obed_cost)
		else:
			text += "\nSelect Characters to send"

	
	var can_travel = true
	
	if selected_travel_characters.size() < 1 || destination == null:
		can_travel = false
	else:
		for person in selected_travel_characters:
			# var person = ResourceScripts.game_party.characters[i]
			if person.is_controllable():
				continue
			if person.xp_module.check_infinite_obedience() || person.xp_module.predict_obed_time() < obed_cost:
				can_travel = false
	$DescriptText.bbcode_text = text
	$DescriptText2.bbcode_text = text2
	$TravelConfirmButton.disabled = !can_travel



func set_travel_character(id):
	var selected_travel_characters = get_parent().selected_travel_characters
	if !selected_travel_characters.has(id):
		selected_travel_characters.append(id)
	else:
		selected_travel_characters.erase(id)
	input_handler.get_spec_node(input_handler.NODE_SLAVETOOLTIP).hide()
	update_character_dislocation()

func travel_confirm():
	if dislocation_area == "mansion":
		dislocation_area = "aliron"
	var destination = get_parent().selected_destination
	var selected_travel_characters = get_parent().selected_travel_characters
	for person in selected_travel_characters:
		person.remove_from_task()
		person.process_event(variables.TR_MOVE)
		var travel_cost = globals.calculate_travel_time(destination,person.travel.location)
		if !person.is_controllable():
			person.add_stat('obedience', -ceil((travel_cost.obed_cost/person.travel_per_tick())))
		if ResourceScripts.game_progress.instant_travel == false:
			person.previous_location = person.travel.location
			person.xp_module.work = 'travel'
			person.travel.location = 'travel'
			person.travel.travel_target = {area = destination_area, location = destination}
			person.travel.travel_time = travel_cost.time
			person.travel.initial_travel_time = travel_cost.time
		else:
			person.xp_module.work = 'travel'
			person.travel.location = destination
			person.travel.area  = destination_area
	get_parent().selected_travel_characters.clear()
	
	# update_location_list()
	open_character_dislocation()
	get_parent().SlaveListModule.rebuild()
	get_parent().SlaveListModule.show_location_characters()
	travel_update("confirm")
	selected_location = null

func reset_travels():
	$Resources.hide()
	$SelectedLocation/Label.text = "Select Location"
	selected_location = null


func travel_update(action = "cancel"):
	get_parent().selected_travel_characters.clear()
	get_parent().selected_destination = null
	# update_location_list()
	open_character_dislocation()
	reset_travels()
	if action == "cancel":
		get_parent().mansion_state_set("default")
	get_parent().match_state()
	selected_location = null



# var lands_order = ['plains','forests','mountains','steppe','seas']

# func sort_lands(first, second):
# 	if lands_order.has(first.code):
# 		if lands_order.has(second.code):
# 			return  lands_order.find(first.code) < lands_order.find(second.code)
# 		else:
# 			return true
