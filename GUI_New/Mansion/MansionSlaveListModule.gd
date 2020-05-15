extends Panel

onready var slave_list_container = $ScrollContainer/VBoxContainer

#warning-ignore-all:return_value_discarded
func _ready():
	print($ScrollContainer/VBoxContainer)
	globals.connect("slave_added",self,"rebuild")
	globals.connect("hour_tick", self, "update")
	input_handler.slave_list_node = self
	#rebuild()


func rebuild():
	yield(get_tree(), 'idle_frame')
	input_handler.get_spec_node(input_handler.NODE_SLAVETOOLTIP).hide()
	print($ScrollContainer/VBoxContainer.name)
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.set_meta('slave', person)
		newbutton.connect('pressed', self, 'open_slave_tab', [person])
		globals.connectslavetooltip(newbutton, person)
		update_button(newbutton)
		newbutton.target_node = self
		newbutton.target_function = 'rebuild'
		newbutton.arraydata = i
		newbutton.parentnodearray = ResourceScripts.game_party.character_order

func update():
	for i in $ScrollContainer/VBoxContainer.get_children():
		update_button(i)

func update_button(newbutton):
	if newbutton.name == 'Button':
		return
	var person = newbutton.get_meta('slave')
	newbutton.get_node("HBoxContainer/icon").texture = person.get_icon()
	newbutton.get_node("HBoxContainer/name").text = person.get_full_name()
	newbutton.get_node("HBoxContainer/sex").texture = images.icons[person.get_stat('sex')]
	
	newbutton.get_node("HBoxContainer/stats/hp").max_value = person.get_stat('hpmax')
	newbutton.get_node("HBoxContainer/stats/hp").value = person.hp
	newbutton.get_node("HBoxContainer/stats/mp").max_value = person.get_stat('mpmax')
	newbutton.get_node("HBoxContainer/stats/mp").value = person.mp
	newbutton.get_node("HBoxContainer/stats").hint_tooltip = "HP: " + str(round(person.hp)) + "/" + str(round(person.get_stat('hpmax'))) + "\nMP: " + str(round(person.mp)) + "/" + str(round(person.get_stat('mpmax')))
	#newbutton.get_node("HBoxContainer/stats/hplabel").text = str(round(person.hp)) + "/" + str(round(person.hpmax))
	#newbutton.get_node("HBoxContainer/stats/mplabel").text = str(round(person.mp)) + "/" + str(round(person.mpmax))
	newbutton.get_node("HBoxContainer/explabel").text = str(round(person.get_stat('base_exp')))
	if person.get_work() == '':
		newbutton.get_node("HBoxContainer/job").text = tr("TASKREST")
	else:
		newbutton.get_node("HBoxContainer/job").text = races.tasklist[person.get_work()].name
	
	if person.get_stat('loyalty') < 100 && person.get_stat('submission') < 100 && !person.has_profession('master'):
		newbutton.get_node("HBoxContainer/obed").text = str(ceil(person.get_stat('obedience')))
		if person.get_stat('obedience') <= 0:
			newbutton.get_node("HBoxContainer/obed").set("custom_colors/font_color", Color(variables.hexcolordict.red))
		elif person.get_stat('obedience') <= 10:
			newbutton.get_node("HBoxContainer/obed").set("custom_colors/font_color", Color(variables.hexcolordict.yellow))
		else:
			newbutton.get_node("HBoxContainer/obed").set("custom_colors/font_color", Color(variables.hexcolordict.green))
	else:
		newbutton.get_node("HBoxContainer/obed").text = "∞"
	
	if person.get_next_class_exp() <= person.get_stat('base_exp'):
		newbutton.get_node("HBoxContainer/explabel").set("custom_colors/font_color", Color(variables.hexcolordict.levelup_text_color))
	else:
		newbutton.get_node("HBoxContainer/explabel").set("custom_colors/font_color", Color(1,1,1))
	if !person.check_location('mansion'):
		if person.check_location('travel'):
			newbutton.get_node('HBoxContainer/job').text = 'Relocating: in ' + str(ceil(person.travel.travel_time / person.travel_per_tick())) + " hours. " 
		else:
			newbutton.get_node('HBoxContainer/job').text = 'Positioned: ' + ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[person.get_location()].area].name
	var icon = person.get_class_icon()

	newbutton.get_node("HBoxContainer/state").texture = icon

		

func open_slave_tab(character):
	input_handler.ShowSlavePanel(character)
	#input_handler.get_spec_node(input_handler.NODE_SLAVEPANEL, [character])

var obed_textures = {
	high = input_handler.loadimage('obed1', 'icons'), 
	med = input_handler.loadimage('obed2', 'icons'), 
	low = input_handler.loadimage('obed3', 'icons'),
}
var fear_textures = {
	high = input_handler.loadimage('fear1', 'icons'),
	med = input_handler.loadimage('fear2', 'icons'),
	low = input_handler.loadimage('fear3', 'icons'),
}

func get_obed_texture(tempchar):
	var rval 
	if tempchar.get_stat('obedience') >= 50:
		rval = 'high'
	elif tempchar.get_stat('obedience') < tempchar.get_stat('timid_factor') * 7:
		rval = 'low'
	else:
		rval = 'med'
	return obed_textures[rval]

func get_fear_texture(tempchar):
	var rval
	if tempchar.get_stat('submission') >= 50:
		rval = 'high'
	elif tempchar.get_stat('submission') < tempchar.get_stat('timid_factor') * 7:
		rval = 'low'
	else:
		rval = 'med'
	return fear_textures[rval]

#var stateicons = {
#	work = load('res://assets/images/gui/gui icons/workicon.png'),
#	rest = load('res://assets/images/gui/gui icons/sleepicon.png'),
#	joy = load('res://assets/images/gui/gui icons/joyicon.png'),
#}
func get_state_texture(tempchar):
	return
	var rval = tempchar.get_stat('last_tick_assignement')
	
	rval = images.icons[rval]
	return rval

