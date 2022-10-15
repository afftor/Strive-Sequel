extends "res://src/scenes/ClosingPanel.gd"
# warning-ignore-all:return_value_discarded

#var active_location
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
#	active_location = input_handler.active_location
	show()
	build_location_group()

var pos

func selectfighter(position):
	pos = 'pos'+str(position)
	var reqs = [{code = 'is_at_location', value = input_handler.active_location.id, check = true}]
	if variables.allow_remote_intereaction == true: reqs = []
	input_handler.ShowSlaveSelectPanel(self, 'slave_position_selected', reqs, true)

func slave_position_selected(character):
	if character == null:
		input_handler.active_location.group.erase(pos)
		build_location_group()
		return
	if character.has_status('no_combat'):
		input_handler.SystemMessage(character.translate("[name] has sustained a grave injury and is unable to participate in fights."))
		return
	elif !character.is_master() and !character.has_status('combatant'):
		input_handler.SystemMessage(character.translate("[name] refuses to participate in a fight (low obedience).")) #2fix
		return
	character = character.id
	var positiontaken = false
	var oldheroposition = null
	if input_handler.active_location.group.has(pos) && ResourceScripts.game_party.characters[input_handler.active_location.group[pos]].check_location(input_handler.active_location.id, true):
		positiontaken = true
	
	for i in input_handler.active_location.group:
		if input_handler.active_location.group[i] == character:
			oldheroposition = i
			input_handler.active_location.group.erase(i)
	
	if oldheroposition != null && positiontaken == true && oldheroposition != pos:
		input_handler.active_location.group[oldheroposition] = input_handler.active_location.group[pos]
	
	input_handler.active_location.group[pos] = character
	build_location_group()


func build_location_group():
	for i in positiondict:
		if input_handler.active_location.group.has('pos'+str(i)) && ResourceScripts.game_party.characters[input_handler.active_location.group['pos'+str(i)]] != null:
			var character = ResourceScripts.game_party.characters[input_handler.active_location.group['pos'+str(i)]]
			get_node(positiondict[i]+"/Image").texture = character.get_icon()
			get_node(positiondict[i]+"/Image").show()
			get_node(positiondict[i]+"/Image/hp").text = str(ceil(character.hp)) + '/' + str(ceil(character.get_stat('hpmax')))
			get_node(positiondict[i]+"/Image/mp").text = str(floor(character.mp)) + '/' + str(floor(character.get_stat('mpmax')))
		else:
			get_node(positiondict[i]+"/Image").texture = null
			get_node(positiondict[i]+"/Image").hide()

func start_combat():
	if globals.check_location_group() == false:
		input_handler.SystemMessage("Select at least 1 character to fight. ")
		return
	hide()
	input_handler.get_spec_node(input_handler.NODE_DIALOGUE).close({finish_scene = false})
	if globals.current_enemy_group == 'random_local_group':
		globals.StartAreaCombat()
	else:
		globals.StartCombat(globals.current_enemy_group)
