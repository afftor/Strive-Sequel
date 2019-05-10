extends Panel


#warning-ignore-all:return_value_discarded
func _ready():
	state.connect("slave_added",self,"rebuild")
	rebuild()



func rebuild():
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	for i in state.characters.values():
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node("icon").texture = load(i.icon)
		newbutton.get_node("name").text = i.get_full_name()
		newbutton.get_node("obed").texture = get_obed_texture(i)
		newbutton.get_node("fear").texture = get_fear_texture(i)
		newbutton.get_node("state").texture = get_state_texture(i)
		newbutton.get_node("obed/Label").text = str(i.obedience)
		newbutton.get_node("fear/Label").text = str(i.fear)
		newbutton.get_node("en/Label").text = str(i.energy)
		newbutton.get_node("mp/Label").text = str(i.mp)
		newbutton.set_meta('slave', i)
		newbutton.connect('pressed', self, 'open_slave_tab', [i])
		globals.connectslavetooltip(newbutton, i)

func update():
	for newbutton in $ScrollContainer/VBoxContainer.get_children():
		var i = newbutton.get_meta('slave')
		newbutton.get_node("icon").texture = load(i.icon)
		newbutton.get_node("name").text = i.get_full_name()
		newbutton.get_node("obed").texture = get_obed_texture(i)
		newbutton.get_node("fear").texture = get_fear_texture(i)
		newbutton.get_node("state").texture = get_state_texture(i)
		newbutton.get_node("obed/Label").text = str(i.obedience)
		newbutton.get_node("fear/Label").text = str(i.fear)
		newbutton.get_node("en/Label").text = str(i.energy)
		newbutton.get_node("mp/Label").text = str(i.mp)

func open_slave_tab(character):
	get_parent().get_node("SlavePanel").open(character)

var obed_textures = {high = load("res://assets/images/gui/obed_good.png"), med = load("res://assets/images/gui/obed_med.png"), low = load("res://assets/images/gui/obed_bad.png")}
var fear_textures = {high = load('res://assets/images/gui/fear_good.png'), med = load("res://assets/images/gui/fear_med.png"), low = load("res://assets/images/gui/fear_bad.png")}

func get_obed_texture(tempchar):
	var rval 
	if tempchar.obedience >= 50:
		rval = 'high'
	elif tempchar.obedience + tempchar.loyal/2 < tempchar.brave_factor*8:
		rval = 'low'
	else:
		rval = 'med'
	return obed_textures[rval]

func get_fear_texture(tempchar):
	var rval
	if tempchar.fear >= 50:
		rval = 'high'
	elif tempchar.fear + tempchar.loyal/2 < tempchar.brave_factor*8:
		rval = 'low'
	else:
		rval = 'med'
	return fear_textures[rval]

func get_state_texture(tempchar):
	var rval = tempchar
	return rval

