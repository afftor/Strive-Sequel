extends Panel



var dislocation_area = 'mansion'
var destination_area = 'plains'

func _ready():
	$HomeButton.connect("item_selected", self, 'select_dislocation_area')
	$DestinationButton.connect("item_selected", self, 'select_destination_area')
	$TravelConfirmButton.connect("pressed", self, "travel_confirm")
	$TravelCancelButton.connect("pressed", self, "travel_cancel")

func open_character_dislocation():
	show()
	dislocation_area = 'mansion'
	destination_area = 'plains'
	
	$HomeButton.clear()
	$HomeButton.add_item(tr("MANSION"))
	$HomeButton.set_item_metadata($HomeButton.get_item_count()-1, 'mansion')
	var populatedlocations = []
	var travelers = []
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if !person.travel.location in [ResourceScripts.game_world.mansion_location,'travel'] && populatedlocations.has(person.travel.location) == false:
			populatedlocations.append(person.travel.location)
		elif person.travel.location == 'travel':
			travelers.append(person)
	
	input_handler.ClearContainer($TravelersContainer/VBoxContainer)
	for i in travelers:
		var newlabel = input_handler.DuplicateContainerTemplate($TravelersContainer/VBoxContainer)
		newlabel.get_node("Label").text = i.get_short_name()
		if i.travel.travel_target.location != ResourceScripts.game_world.mansion_location:
			newlabel.get_node("Label").tex += " - " + ResourceScripts.world_gen.get_location_from_code(i.travel.travel_target.location).name
		else:
			newlabel.get_node("Label").text += " - " + tr("MANSION")
		newlabel.get_node("Progress").value = i.travel.initial_travel_time - i.travel.travel_time
		newlabel.get_node("Progress").max_value = i.travel.initial_travel_time
		newlabel.get_node("Progress/Time").text = 'Until arrival: ' + str(ceil(i.travel.travel_time/i.travel_per_tick())) + " hours"
		globals.connectslavetooltip(newlabel, i)
		newlabel.get_node("ReturnButton").connect('pressed',self,'cancel_travel', [i])
	
	for i in populatedlocations:
		$HomeButton.add_item(ResourceScripts.world_gen.get_location_from_code(i).name)
		$HomeButton.set_item_metadata($HomeButton.get_item_count()-1, i)


func cancel_travel(person):
	if person.travel.travel_target.location != ResourceScripts.game_world.mansion_location:
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

func select_dislocation_area(number):
	var selected_travel_characters = get_parent().selected_travel_characters
	selected_travel_characters.clear()
	dislocation_area = $HomeButton.get_selected_metadata()
	update_character_dislocation()
	update_location_list()

func select_destination_area(number):
	destination_area = $DestinationButton.get_selected_metadata()
	update_location_list()

func update_location_list():
	input_handler.ClearContainerForced($DestinationContainer/ScrollContainer/VBoxContainer)
	var array = []
	
	$DestinationButton.clear()
	for i in ResourceScripts.game_world.areas.values():
		if i.unlocked == true:
			array.append(i)
	
	for i in array:
		$DestinationButton.add_item(i.name)
		$DestinationButton.set_item_metadata($DestinationButton.get_item_count()-1, i.code)
		if destination_area == i.code:
			$DestinationButton.select($DestinationButton.get_item_count()-1)
	
	array.clear()
	
	for i in ResourceScripts.game_world.areas[destination_area].locations.values() + ResourceScripts.game_world.areas[destination_area].questlocations.values():
		array.append(i)
	
	if dislocation_area != 'mansion':
		var newbutton = input_handler.DuplicateContainerTemplate($DestinationContainer/VBoxContainer)
		var text = tr("RETURNTOMANSION")
		newbutton.get_node("Label").text = text
		newbutton.connect('pressed', self, 'select_destination', [ResourceScripts.game_world.mansion_location])
		newbutton.name = 'mansion'
	
	if destination_area != 'plains':
		var newbutton = input_handler.DuplicateContainerTemplate($DestinationContainer/ScrollContainer/VBoxContainer)
		var text = tr(ResourceScripts.game_world.areas[destination_area].capital_name)
		newbutton.get_node("Label").text = text
		newbutton.connect('pressed', self, 'select_destination', [ResourceScripts.game_world.areas[destination_area].capital_name])
		newbutton.name = ResourceScripts.game_world.areas[destination_area].capital_name
	
	for i in array:
		if i.id == dislocation_area:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($DestinationContainer/ScrollContainer/VBoxContainer)
		var text = i.name
		if ResourceScripts.game_world.areas[destination_area].questlocations.has(i.id):
			text = "Q:" + text
		newbutton.get_node("Label").text = text
		newbutton.connect('pressed', self, 'select_destination', [i.id])
		newbutton.name = i.id

func select_destination(code):
	var params = {code = 'destination_selected', destination = code}
	for i in $DestinationContainer/ScrollContainer/VBoxContainer.get_children():
		i.pressed = i.name == code
	get_parent().travels_manager(params)
	


func sort_dislocation(first, second):
	var selected_travel_characters = get_parent().selected_travel_characters
	return selected_travel_characters.has(first)

func update_character_dislocation():
	var destination = get_parent().selected_destination
	var selected_travel_characters = get_parent().selected_travel_characters
	var char_array = []
	var obed_cost = 0
	var text = "Characters selected: " + str(selected_travel_characters.size())
	if destination == null:
		text += "\n\nPlease select location to proceed"
	elif destination == ResourceScripts.game_world.mansion_location:
		text += "\n\nTarget Location: " + tr("MANSION")
		if selected_travel_characters.size() > 0 :
			text += "\nTravel Time: " + str(ceil(globals.calculate_travel_time(dislocation_area, ResourceScripts.game_world.mansion_location).time / ResourceScripts.game_party.characters[selected_travel_characters[0]].travel_per_tick())) + " hours."
	else:
		var location = ResourceScripts.world_gen.get_location_from_code(destination)
		text += "\n\nTarget Location: \n[color=yellow]" + location.name + "[/color]" 
		match location.type:
			'dungeon':
				text += "\nType: " + location.classname + "\n" + tr("DUNGEONDIFFICULTY") + ": " + tr("DUNGEONDIFFICULTY" + location.difficulty.to_upper())
			'settlement':
				text += "\nType: " + location.classname
			'skirmish':
				pass
		if selected_travel_characters.size() > 0 :
			var travel_time = globals.calculate_travel_time(destination, dislocation_area) 
			text += "\n\nTravel Time: " + str(ceil(travel_time.time / selected_travel_characters[0].travel_per_tick())) + " hours."
			obed_cost = ceil(travel_time.obed_cost / selected_travel_characters[0].travel_per_tick())
			text += "\nObedience Cost: " + str(obed_cost)
	
	var can_travel = true
	
	if selected_travel_characters.size() < 1 || destination == null:
		can_travel = false
	else:
		for person in selected_travel_characters:
			# var person = ResourceScripts.game_party.characters[i]
			if person.is_controllable():
				continue
			if person.get_stat('obedience') < obed_cost:
				can_travel = false
	
	$DescriptText.bbcode_text = text
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
	var destination = get_parent().selected_destination
	var selected_travel_characters = get_parent().selected_travel_characters
	for person in selected_travel_characters:
		person.remove_from_task(true)
		person.process_event(variables.TR_MOVE)
		var travel_cost = globals.calculate_travel_time(destination,dislocation_area)
		if !person.is_controllable():
			person.add_stat('obedience', -ceil((travel_cost.obed_cost/person.travel_per_tick())))
		if variables.instant_travel == false:
			person.xp_module.work = 'travel'
			person.travel.location = 'travel'
			person.travel.travel_target = {area = destination_area, location = destination}
			person.travel.travel_time = travel_cost.time
		else:
			person.xp_module.work = 'travel'
			person.travel.location = destination
			person.travel.area  = destination_area
	get_parent().match_state()
	update_location_list()
	open_character_dislocation()

func travel_cancel():
	get_parent().selected_travel_characters.clear()
	get_parent().selected_destination = null
	update_location_list()
	open_character_dislocation()
	get_parent().match_state()

