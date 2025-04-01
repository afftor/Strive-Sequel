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

var pos_int
var group#dict: key - position (string), value - char's id
var confirm_call# = {target, method}
var allow_remote = false
var limit = 0
var group_fixed = false

func _ready():
	$ConfirmButton.connect("pressed", self, "on_confirm")
	
	for i in positiondict:
		get_node(positiondict[i]).connect('pressed', self, 'selectfighter', [i])

func open():#for default use
	open_defined(input_handler.active_location.group)

func open_defined(new_group, con_target = null, con_method = null):
	group = new_group
	set_remote(variables.allow_remote_intereaction)
	set_limit(0)
	show()
	build_location_group()
	confirm_call = null
	if con_target != null:
		confirm_call = {
			target = con_target,
			method = con_method
		}



func selectfighter(position):
	pos_int = position
	var reqs
	if allow_remote:
		reqs = []
	else:
		reqs = [{code = 'is_at_location', value = input_handler.active_location.id, check = true}]
	input_handler.ShowSlaveSelectPanel(self, 'slave_position_selected', reqs, true)

func slave_position_selected(character):
	var pos = 'pos'+str(pos_int)
	if character == null:
		if group.has(pos):#removing old char
			if group_fixed:
				input_handler.SystemMessage(tr('PARTY_FIXED'))
				return
			ResourceScripts.game_party.characters[group[pos]].combat_position = 0
			group.erase(pos)
			build_location_group()
		return
	if character.has_status('no_combat'):
		input_handler.SystemMessage(character.translate(tr('CHAR_NO_COMBAT')))
		return
	elif !character.is_combatant():
		input_handler.SystemMessage(character.translate(tr('NO_FIGHT_LOW_OBED2'))) #2fix
		return
	var char_id = character.id
	var positiontakenby = null
	var oldheroposition = null
	if group.has(pos):
		var cur_char = ResourceScripts.game_party.characters[group[pos]]
		if allow_remote or cur_char.check_location(input_handler.active_location.id, true):
			positiontakenby = cur_char
	for i in group:
		if group[i] == char_id:
			if oldheroposition != null:
				print("error. Char double in PositionSelectMenu.gd")
			oldheroposition = i
	
	if oldheroposition == null:#adding new char to group
		if group_fixed:
			input_handler.SystemMessage(tr('PARTY_FIXED'))
			return
		if positiontakenby != null:#switching chars, old one goes out
			positiontakenby.combat_position = 0
		elif limit != 0 and group.size() >= limit:#increasing group size by adding new char
			input_handler.SystemMessage(tr('PARTY_LIMIT'))
			return
	else:#no new char in group
		if positiontakenby != null and oldheroposition != pos:#switching chars in group
			group[oldheroposition] = group[pos]
		else:#move char to another position
			group.erase(oldheroposition)
	
	group[pos] = char_id
	build_location_group()


func build_location_group():
	for i in positiondict:
		var position = 'pos'+str(i)
		var character
		var free_pos = false
		if group.has(position):
			character = ResourceScripts.game_party.characters[group[position]]
			character.combat_position = i
			if character != null:
				if !character.has_status('no_combat'):
					get_node(positiondict[i]+"/Image").texture = character.get_icon()
					get_node(positiondict[i]+"/Image").show()
					get_node(positiondict[i]+"/Image/hp").text = str(ceil(character.hp)) + '/' + str(ceil(character.get_stat('hpmax')))
					get_node(positiondict[i]+"/Image/mp").text = str(floor(character.mp)) + '/' + str(floor(character.get_stat('mpmax')))
				else:
					group.erase(position)
					free_pos = true
			else:
				free_pos = true
		else:
			free_pos = true
		
		if free_pos:
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

#for external tuneup, use after open_defined()
func strip_buttons():
	closebutton.queue_free()
	$ConfirmButton.queue_free()

func fix_group():
	group_fixed = true

func unfix_group():
	group_fixed = false

func set_remote(value):
	allow_remote = (value or variables.allow_remote_intereaction)

func set_limit(new_limit):
	limit = new_limit
