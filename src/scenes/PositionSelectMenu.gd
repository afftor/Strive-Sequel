extends "res://src/scenes/ClosingPanel.gd"
# warning-ignore-all:return_value_discarded

var active_location
var positiondict = {
	1 : "HBoxContainer/frontrow/1",
	2 : "HBoxContainer/frontrow/2",
	3 : "HBoxContainer/frontrow/3",
	4 : "HBoxContainer/backrow/4",
	5 : "HBoxContainer/backrow/5",
	6 : "HBoxContainer/backrow/6",
}


func _ready():
	$ConfirmButton.connect("pressed", self, "start_combat")
	
	for i in positiondict:
		get_node(positiondict[i]).connect('pressed', self, 'selectfighter', [i])

func open():
	active_location = input_handler.active_location
	show()
	build_location_group()

var pos

func selectfighter(position):
	pos = 'pos'+str(position)
	var reqs = [{code = 'is_at_location', value = active_location.id, check = true}]
	if variables.allow_remote_intereaction == true: reqs = []
	input_handler.ShowSlaveSelectPanel(self, 'slave_position_selected', reqs, true)

func slave_position_selected(character):
	if character == null:
		active_location.group.erase(pos)
		build_location_group()
		return
	character = character.id
	var positiontaken = false
	var oldheroposition = null
	if active_location.group.has(pos) && ResourceScripts.game_party.characters[active_location.group[pos]].check_location(active_location.id, true):
		positiontaken = true
	
	for i in active_location.group:
		if active_location.group[i] == character:
			oldheroposition = i
			active_location.group.erase(i)
	
	if oldheroposition != null && positiontaken == true && oldheroposition != pos:
		active_location.group[oldheroposition] = active_location.group[pos]
	
	active_location.group[pos] = character
	build_location_group()


func build_location_group():
	for i in positiondict:
		if active_location.group.has('pos'+str(i)) && ResourceScripts.game_party.characters[active_location.group['pos'+str(i)]] != null:
			var character = ResourceScripts.game_party.characters[active_location.group['pos'+str(i)]]
			get_node(positiondict[i]+"/Image").texture = character.get_icon()
			get_node(positiondict[i]+"/Image").show()
			get_node(positiondict[i]+"/Image/hp").text = str(floor(character.hp)) + '/' + str(floor(character.hpmax))
			get_node(positiondict[i]+"/Image/mp").text = str(floor(character.mp)) + '/' + str(floor(character.mpmax))
		else:
			get_node(positiondict[i]+"/Image").texture = null
			get_node(positiondict[i]+"/Image").hide()

func start_combat():
	if globals.check_location_group() == false:
		input_handler.SystemMessage("Select at least 1 character to fight. ")
		return
	hide()
	globals.StartCombat(input_handler.current_enemy_group)
