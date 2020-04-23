extends "res://files/Close Panel Button/ClosingPanel.gd"
# warning-ignore-all:return_value_discarded


var dislocation_area = 'mansion'
var selected_travel_characters = []
var destination_area = 'plains'
var destination = null

func _ready():
	
	$HomeButton.connect("item_selected", self, 'select_dislocation_area')
	$DestinationButton.connect("item_selected", self, 'select_destination_area')
	$TravelConfirmButton.connect("pressed", self, "travel_confirm")

func open_character_dislocation():
	show()
	selected_travel_characters.clear()
	dislocation_area = 'mansion'
	destination_area = 'plains'
	destination = null
	
	$HomeButton.clear()
	$HomeButton.add_item(tr("MANSION"))
	$HomeButton.set_item_metadata($HomeButton.get_item_count()-1, 'mansion')
	var populatedlocations = []
	var travelers = []
	for i in state.character_order:
		var person = state.characters[i]
		if !person.location in ['mansion','travel'] && populatedlocations.has(person.location) == false:
			populatedlocations.append(person.location)
		elif person.location == 'travel':
			travelers.append(person)
	
	globals.ClearContainer($TravelersContainer/VBoxContainer)
	
	for i in travelers:
		var newbutton = globals.DuplicateContainerTemplate($TravelersContainer/VBoxContainer)
		newbutton.text = i.get_short_name()
		if i.travel_target.location != 'mansion':
			newbutton.text += " - " + world_gen.get_location_from_code(i.travel_target.location).name
		else:
			newbutton.text += " - " + tr("MANSION")
		newbutton.get_node("Progress").value = i.initial_travel_time - i.travel_time
		newbutton.get_node("Progress").max_value = i.initial_travel_time
		newbutton.get_node("Progress/Label").text = 'Until arrival: ' + str(ceil(i.travel_time/i.travel_tick())) + " hours"
		globals.connectslavetooltip(newbutton, i)
		newbutton.connect('pressed',self,'cancel_travel', [i])
	
	for i in populatedlocations:
		$HomeButton.add_item(world_gen.get_location_from_code(i).name)
		$HomeButton.set_item_metadata($HomeButton.get_item_count()-1, i)
	
	
	update_character_dislocation()
	update_location_list()

func cancel_travel(person):
	if person.travel_target.location != 'mansion':
		return_confirm(person)
	else:
		input_handler.SystemMessage(person.translate("[name] is already heading back to Mansion."))

var returnperson

func return_confirm(person):
	returnperson = person
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'return_character', person.translate('Send [name] back to Mansion?')])

func return_character():
	var person = returnperson
	var active_area
	var active_location
	if person.location == 'travel':
		active_area = state.areas[state.location_links[person.travel_target.location].area]
		active_location = state.areas[state.location_links[person.travel_target.location].area][state.location_links[person.travel_target.location].category][person.travel_target.location]
	else:
		active_area = state.areas[state.location_links[person.location].area]
		active_location = state.areas[state.location_links[person.location].area][state.location_links[person.location].category][person.location]
	var location = world_gen.get_location_from_code(active_location)
	if active_location.has("group"):
		for i in active_location.group:
			if active_location.group[i] == person.id:
				active_location.group.erase(i)
				break
	if variables.instant_travel == false:
		person.location = 'travel'
		person.travel_target = {area = '', location = 'mansion'}
		person.travel_time = max(1, abs(round(active_area.travel_time + active_location.travel_time - person.travel_time)))
	else:
		person.location = 'mansion'
	open_character_dislocation()
	input_handler.update_slave_list()

func select_dislocation_area(number):
	selected_travel_characters.clear()
	dislocation_area = $HomeButton.get_selected_metadata()
	update_character_dislocation()
	update_location_list()

func select_destination_area(number):
	destination_area = $DestinationButton.get_selected_metadata()
	update_location_list()

func update_location_list():
	globals.ClearContainerForced($DestinationContainer/VBoxContainer)
	var array = []
	
	$DestinationButton.clear()
	
	for i in state.areas.values():
		if i.unlocked == true:
			array.append(i)
	
	for i in array:
		$DestinationButton.add_item(i.name)
		$DestinationButton.set_item_metadata($DestinationButton.get_item_count()-1, i.code)
		if destination_area == i.code:
			$DestinationButton.select($DestinationButton.get_item_count()-1)
	
	array.clear()
	
	
	
	for i in state.areas[destination_area].locations.values() + state.areas[destination_area].questlocations.values():
		array.append(i)
	
	if dislocation_area != 'mansion':
		var newbutton = globals.DuplicateContainerTemplate($DestinationContainer/VBoxContainer)
		var text = tr("RETURNTOMANSION")
		newbutton.get_node("Label").text = text
		newbutton.connect('pressed', self, 'select_destination', ['mansion'])
		newbutton.name = 'mansion'
	
	if destination_area != 'plains':
		var newbutton = globals.DuplicateContainerTemplate($DestinationContainer/VBoxContainer)
		var text = tr(state.areas[destination_area].capital_name)
		newbutton.get_node("Label").text = text
		newbutton.connect('pressed', self, 'select_destination', [state.areas[destination_area].capital_name])
		newbutton.name = state.areas[destination_area].capital_name
	
	for i in array:
		if i.id == dislocation_area:
			continue
		var newbutton = globals.DuplicateContainerTemplate($DestinationContainer/VBoxContainer)
		var text = i.name
		if state.areas[destination_area].questlocations.has(i.id):
			text = "Q:" + text
		newbutton.get_node("Label").text = text
		newbutton.connect('pressed', self, 'select_destination', [i.id])
		newbutton.name = i.id

func select_destination(code):
	for i in $DestinationContainer/VBoxContainer.get_children():
		i.pressed = i.name == code
	destination = code
	update_character_dislocation()

func sort_dislocation(first, second):
	if selected_travel_characters.has(first):
		return true
	else:
		return false

func update_character_dislocation():
	var char_array = []
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	for i in state.character_order:
		var person = state.characters[i]
		if person.location == dislocation_area:
			char_array.append(i)
	#char_array.sort_custom(self, 'sort_dislocation')
	for i in char_array:
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		var person = state.characters[i]
		newbutton.get_node("Label").text = person.get_full_name()
		var obed_text = str(person.obedience)
		var obed_color
		if person.obedience <= 0:
			obed_color = globals.hexcolordict.red
		else:
			obed_color = globals.hexcolordict.green
		if person.loyalty >= 100 || person.submission >= 100 || state.get_master() == person:
			obed_text = "∞"
			obed_color = globals.hexcolordict.green
		newbutton.get_node("obed").text = obed_text
		newbutton.get_node("obed").set("custom_colors/font_color", obed_color)
		globals.connectslavetooltip(newbutton, person)
		if selected_travel_characters.has(i):
			newbutton.pressed = true
		newbutton.connect('pressed', self, 'set_travel_character', [i])
	var obed_cost = 0
	var text = "Characters selected: " + str(selected_travel_characters.size())
	if destination == null:
		text += "\n\nPlease select location to proceed"
	elif destination == 'mansion':
		text += "\n\nTarget Location: " + tr("MANSION")
		if selected_travel_characters.size() > 0 :
			text += "\nTravel Time: " + str(ceil(state.characters[selected_travel_characters[0]].calculate_travel_time(dislocation_area, 'mansion').time / state.characters[selected_travel_characters[0]].travel_tick())) + " hours."
	else:
		var location = world_gen.get_location_from_code(destination)
		text += "\n\nTarget Location: \n[color=yellow]" + location.name + "[/color]" 
		match location.type:
			'dungeon':
				text += "\nType: " + location.classname + "\n" + tr("DUNGEONDIFFICULTY") + ": " + tr("DUNGEONDIFFICULTY" + location.difficulty.to_upper())
				#ext += "\nProgress: Levels - " + str(current_level) + "/" + str(active_location.levels.size()) + ", "
				#text += "Stage - " + str(active_location.progress.stage) 
			'settlement':
				text += "\nType: " + location.classname
			'skirmish':
				pass
		if selected_travel_characters.size() > 0 :
			var travel_time = state.characters[selected_travel_characters[0]].calculate_travel_time(destination, dislocation_area) 
			text += "\n\nTravel Time: " + str(ceil(travel_time.time/ state.characters[selected_travel_characters[0]].travel_tick())) + " hours."
			obed_cost = ceil(travel_time.obed_cost/state.characters[selected_travel_characters[0]].travel_tick())
			text += "\nObedience Cost: " + str(obed_cost)
	
	var can_travel = true
	
	if selected_travel_characters.size() < 1 || destination == null:
		can_travel = false
	else:
		for i in selected_travel_characters:
			var person = state.characters[i]
			if person.loyalty >= 100 || person.submission >= 100 || state.get_master() == person:
				continue
			if person.obedience < obed_cost:
				can_travel = false
	
	$DescriptText.bbcode_text = text
	$TravelConfirmButton.disabled = !can_travel


func set_travel_character(id):
	if !selected_travel_characters.has(id):
		selected_travel_characters.append(id)
	else:
		selected_travel_characters.erase(id)
	input_handler.get_spec_node(input_handler.NODE_SLAVETOOLTIP).hide()
	update_character_dislocation()

func travel_confirm():
	for i in selected_travel_characters:
		var person = state.characters[i]
		person.remove_from_task(true)
		person.process_event(variables.TR_MOVE)
		var travel_cost = person.calculate_travel_time(destination,dislocation_area)
		if person.loyalty < 100 && person.submission < 100 && state.get_master() != person:
			person.obedience -= ceil((travel_cost.obed_cost/person.travel_tick()))
		if variables.instant_travel == false:
			person.work = 'travel'
			person.location = 'travel'
			person.travel_target = {area = destination_area, location = destination}
			person.travel_time = travel_cost.time
		else:
			person.work = 'travel'
			person.location = destination
			person.area = destination_area
	input_handler.update_slave_list()
	selected_travel_characters.clear()
	update_location_list()
	open_character_dislocation()
