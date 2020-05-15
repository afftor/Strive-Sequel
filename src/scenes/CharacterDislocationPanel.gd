extends "res://src/scenes/ClosingPanel.gd"
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
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if !person.travel.location in ['mansion','travel'] && populatedlocations.has(person.travel.location) == false:
			populatedlocations.append(person.travel.location)
		elif person.travel.location == 'travel':
			travelers.append(person)
	
	input_handler.ClearContainer($TravelersContainer/VBoxContainer)
	
	for i in travelers:
		var newbutton = input_handler.DuplicateContainerTemplate($TravelersContainer/VBoxContainer)
		newbutton.text = i.get_short_name()
		if i.travel.travel_target.location != 'mansion':
			newbutton.text += " - " + ResourceScripts.world_gen.get_location_from_code(i.travel.travel_target.location).name
		else:
			newbutton.text += " - " + tr("MANSION")
		newbutton.get_node("Progress").value = i.travel.initial_travel_time - i.travel.travel_time
		newbutton.get_node("Progress").max_value = i.travel.initial_travel_time
		newbutton.get_node("Progress/Label").text = 'Until arrival: ' + str(ceil(i.travel.travel_time/i.travel_per_tick())) + " hours"
		globals.connectslavetooltip(newbutton, i)
		newbutton.connect('pressed',self,'cancel_travel', [i])
	
	for i in populatedlocations:
		$HomeButton.add_item(ResourceScripts.world_gen.get_location_from_code(i).name)
		$HomeButton.set_item_metadata($HomeButton.get_item_count()-1, i)
	
	
	update_character_dislocation()
	update_location_list()

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

func select_dislocation_area(number):
	selected_travel_characters.clear()
	dislocation_area = $HomeButton.get_selected_metadata()
	update_character_dislocation()
	update_location_list()

func select_destination_area(number):
	destination_area = $DestinationButton.get_selected_metadata()
	update_location_list()

func update_location_list():
	input_handler.ClearContainerForced($DestinationContainer/VBoxContainer)
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
		newbutton.connect('pressed', self, 'select_destination', ['mansion'])
		newbutton.name = 'mansion'
	
	if destination_area != 'plains':
		var newbutton = input_handler.DuplicateContainerTemplate($DestinationContainer/VBoxContainer)
		var text = tr(ResourceScripts.game_world.areas[destination_area].capital_name)
		newbutton.get_node("Label").text = text
		newbutton.connect('pressed', self, 'select_destination', [ResourceScripts.game_world.areas[destination_area].capital_name])
		newbutton.name = ResourceScripts.game_world.areas[destination_area].capital_name
	
	for i in array:
		if i.id == dislocation_area:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($DestinationContainer/VBoxContainer)
		var text = i.name
		if ResourceScripts.game_world.areas[destination_area].questlocations.has(i.id):
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
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if person.check_location(dislocation_area):
			char_array.append(i)
	#char_array.sort_custom(self, 'sort_dislocation')
	for i in char_array:
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		var person = ResourceScripts.game_party.characters[i]
		newbutton.get_node("Label").text = person.get_full_name()
		var obed_text = str(person.get_stat('obedience'))
		var obed_color
		if person.get_stat('obedience') <= 0:
			obed_color = variables.hexcolordict.red
		else:
			obed_color = variables.hexcolordict.green
		if person.is_controllable():
			obed_text = "∞"
			obed_color = variables.hexcolordict.green
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
			text += "\nTravel Time: " + str(ceil(globals.calculate_travel_time(dislocation_area, 'mansion').time / ResourceScripts.game_party.characters[selected_travel_characters[0]].travel_per_tick())) + " hours."
	else:
		var location = ResourceScripts.world_gen.get_location_from_code(destination)
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
			var travel_time = globals.calculate_travel_time(destination, dislocation_area) 
			text += "\n\nTravel Time: " + str(ceil(travel_time.time/ ResourceScripts.game_party.characters[selected_travel_characters[0]].travel_per_tick())) + " hours."
			obed_cost = ceil(travel_time.obed_cost/ResourceScripts.game_party.characters[selected_travel_characters[0]].travel_per_tick())
			text += "\nObedience Cost: " + str(obed_cost)
	
	var can_travel = true
	
	if selected_travel_characters.size() < 1 || destination == null:
		can_travel = false
	else:
		for i in selected_travel_characters:
			var person = ResourceScripts.game_party.characters[i]
			if person.is_controllable():
				continue
			if person.get_stat('obedience') < obed_cost:
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
		var person = ResourceScripts.game_party.characters[i]
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
	input_handler.update_slave_list()
	selected_travel_characters.clear()
	update_location_list()
	open_character_dislocation()
