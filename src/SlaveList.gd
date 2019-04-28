extends Panel

var time = 4

var characterdata = load("res://src/combatant.gd")

func _ready():
	globals.CurrentScene = self
#	var x = 5
#	while x > 0:
#		var character = load("res://src/combatant.gd").new()
#		character.create('random', 'random', 'random')
#		state.characters[character.id] = character
#		x -= 1

	var character = characterdata.new()
	character.create('random', 'random', 'random')
	character.tame_factor = 3
	state.characters[character.id] = character
#	var character2 = characterdata.new()
#	character2.create('random', 'random', 'random')
#	character2.tame_factor = 4
#	state.characters[character2.id] = character2
	rebuild()

func _process(delta):
	time += delta
	if time >= 1:
		time -= 1
		for i in state.characters.values():
			i.tick()
		if get_parent().get_node("SlavePanel").visible == true:
			get_parent().get_node("SlavePanel").open(get_parent().get_node("SlavePanel").person)


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
	var rval
	return rval

