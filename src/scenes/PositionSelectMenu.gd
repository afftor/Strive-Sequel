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

var group#dict: key - position, value - char's id
var confirm_call# = {target, method}
var allow_remote = false

func _ready():
	$ConfirmButton.connect("pressed", self, "on_confirm")
	
	for i in positiondict:
		get_node(positiondict[i]).connect('pressed', self, 'selectfighter', [i])

func open():#for default use
	open_defined(input_handler.active_location.group)

func open_defined(new_group = null, con_target = null, con_method = null, new_remote = false):
	group = new_group
	allow_remote = (new_remote or variables.allow_remote_intereaction)
	show()
	build_location_group()
	confirm_call = null
	if con_target != null:
		confirm_call = {
			target = con_target,
			method = con_method
		}

var pos

func selectfighter(position):
	pos = 'pos'+str(position)
	var reqs
	if allow_remote:
		reqs = []
	else:
		reqs = [{code = 'is_at_location', value = input_handler.active_location.id, check = true}]
	input_handler.ShowSlaveSelectPanel(self, 'slave_position_selected', reqs, true)

func slave_position_selected(character):
	if character == null:
		group.erase(pos)
		build_location_group()
		return
	if character.has_status('no_combat'):
		input_handler.SystemMessage(character.translate("[name] has sustained a grave injury and is unable to participate in fights."))
		return
	elif !character.is_combatant():
		input_handler.SystemMessage(character.translate("[name] refuses to participate in a fight (low obedience).")) #2fix
		return
	var char_id = character.id
	var positiontaken = false
	var oldheroposition = null
	if group.has(pos):
		if allow_remote || ResourceScripts.game_party.characters[group[pos]].check_location(input_handler.active_location.id, true):
			positiontaken = true
	
	for i in group:
		if group[i] == char_id:
			oldheroposition = i
			group.erase(i)
	
	if oldheroposition != null && positiontaken == true && oldheroposition != pos:
		group[oldheroposition] = group[pos]
	
	group[pos] = char_id
	build_location_group()


func build_location_group():
	for i in positiondict:
		var position = 'pos'+str(i)
		if group.has(position) && ResourceScripts.game_party.characters[group[position]] != null:
			var character = ResourceScripts.game_party.characters[group[position]]
			get_node(positiondict[i]+"/Image").texture = character.get_icon()
			get_node(positiondict[i]+"/Image").show()
			get_node(positiondict[i]+"/Image/hp").text = str(ceil(character.hp)) + '/' + str(ceil(character.get_stat('hpmax')))
			get_node(positiondict[i]+"/Image/mp").text = str(floor(character.mp)) + '/' + str(floor(character.get_stat('mpmax')))
		else:
			get_node(positiondict[i]+"/Image").texture = null
			get_node(positiondict[i]+"/Image").hide()

func on_confirm():
	if confirm_call != null:
		confirm_call.target.call(confirm_call.method)
		return
	#by default
	start_event_combat()

func start_event_combat():
	# by default group must be input_handler.active_location.group
	if globals.check_location_group() == false:
		input_handler.SystemMessage(tr("SYSMESSAGEATLEAST1CHAR"))#)
		return
	hide()
	input_handler.get_spec_node(input_handler.NODE_DIALOGUE).close({finish_scene = false})
	if globals.current_enemy_group == 'random_local_group':
		globals.StartAreaCombat()
	else:
		globals.StartCombat(globals.current_enemy_group)
