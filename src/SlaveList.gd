extends Panel


#warning-ignore-all:return_value_discarded
func _ready():
	state.connect("slave_added",self,"rebuild")
	state.connect("hour_tick", self, "update")
	input_handler.slave_list_node = self
	rebuild()

func rebuild():
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	for i in state.character_order:
		var person = state.characters[i]
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node("icon").texture = person.get_icon()
		newbutton.get_node("name").text = person.get_full_name()
		newbutton.get_node("obed").texture = get_obed_texture(person)
		newbutton.get_node("state").texture = get_state_texture(person)
		newbutton.get_node("obed/Label").text = str(round(person.obedience))
		if person.obedience > 0:
			newbutton.get_node("obed").texture = load("res://assets/images/gui/obed_good.png")
		else:
			newbutton.get_node("obed").texture = load("res://assets/images/gui/obed_bad.png")
		#newbutton.get_node("fear/Label").text = str(round(person.fear))
		#newbutton.get_node("en/Label").text = str(round(person.energy))
		newbutton.get_node("mp/Label").text = str(round(person.mp))
		newbutton.set_meta('slave', person)
		
		if person.location != 'mansion':
			newbutton.get_node('name').text = person.get_full_name() + ' - Traveling'
			newbutton.get_node("state").visible = person.location == 'mansion'
			newbutton.get_node("en").visible = person.location == 'mansion'
			newbutton.get_node("mp").visible = person.location == 'mansion'
			newbutton.get_node("obed").visible = person.location == 'mansion'
		
		if person.professions.has("master") == true:
			newbutton.get_node("obed").hide()
		newbutton.connect('pressed', self, 'open_slave_tab', [person])
		globals.connectslavetooltip(newbutton, person)

func update():
	for newbutton in $ScrollContainer/VBoxContainer.get_children():
		if newbutton.name == 'Button':
			continue
		var i = newbutton.get_meta('slave')
		newbutton.get_node("icon").texture = i.get_icon()
		newbutton.get_node("name").text = i.get_full_name()
#		newbutton.get_node("obed").texture = get_obed_texture(i)
#		if newbutton.get_node('obed').texture == obed_textures.low && i.check_escape_chance() == false:
#			newbutton.get_node("obed").texture = null
#		newbutton.get_node("fear").texture = get_fear_texture(i)
#		if newbutton.get_node('fear').texture == fear_textures.low && i.check_escape_chance() == false:
#			newbutton.get_node("fear").texture = null
		newbutton.get_node("state").texture = get_state_texture(i)
		if i.obedience > 0:
			newbutton.get_node("obed").texture = load("res://assets/images/gui/obed_good.png")
		else:
			newbutton.get_node("obed").texture = load("res://assets/images/gui/obed_bad.png")
		newbutton.get_node("obed/Label").text = str(round(i.obedience))
		#newbutton.get_node("fear/Label").text = str(round(i.fear))
		#newbutton.get_node("en/Label").text = str(round(i.energy))
		newbutton.get_node("mp/Label").text = str(round(i.mp))
		if i.location != 'mansion':
			if i.location == 'travel':
				newbutton.get_node('name').text = i.get_full_name() + ' - Relocating: ' + str(round(i.travel_time / i.travel_tick())) + " hours until arrival. " 
			else:
				newbutton.get_node('name').text = i.get_full_name() + ' - Positioned: ' + state.areas[state.location_links[i.location].area][state.location_links[i.location].category][i.location].name
		newbutton.get_node("state").visible = i.location == 'mansion'
		#newbutton.get_node("en").visible = i.location == 'mansion'
		newbutton.get_node("mp").visible = i.location == 'mansion'
		newbutton.get_node("obed").visible = i.location == 'mansion'
		#newbutton.get_node("fear").visible = i.location == 'mansion'
		if i.professions.has("master") == true:
			newbutton.get_node("obed").hide()

func open_slave_tab(character):
	input_handler.ShowSlavePanel(character)
	#input_handler.get_spec_node(input_handler.NODE_SLAVEPANEL, [character])

var obed_textures = {high = load("res://assets/images/gui/gui icons/obedience1.png"), med = load("res://assets/images/gui/gui icons/obedience2.png"), low = load("res://assets/images/gui/gui icons/obedience3.png")}
var fear_textures = {high = load('res://assets/images/gui/gui icons/fear1.png'), med = load("res://assets/images/gui/gui icons/fear2.png"), low = load("res://assets/images/gui/gui icons/fear3.png")}

func get_obed_texture(tempchar):
	var rval 
	if tempchar.obedience >= 50:
		rval = 'high'
	elif tempchar.obedience < tempchar.timid_factor*7:
		rval = 'low'
	else:
		rval = 'med'
	return obed_textures[rval]

func get_fear_texture(tempchar):
	var rval
	if tempchar.submission >= 50:
		rval = 'high'
	elif tempchar.submission < tempchar.timid_factor*7:
		rval = 'low'
	else:
		rval = 'med'
	return fear_textures[rval]

var stateicons = {
	work = load('res://assets/images/gui/gui icons/workicon.png'),
	rest = load('res://assets/images/gui/gui icons/sleepicon.png'),
	joy = load('res://assets/images/gui/gui icons/joyicon.png'),
}
func get_state_texture(tempchar):
	return
	var rval = tempchar.last_tick_assignement
	
	rval = stateicons[rval]
	return rval

