extends Node
# warning-ignore-all:return_value_discarded

var characters: = {}
# for now for the sake of working of all legacy code only temporal characters are stored directly in pool, all player-controlled characters are still stored in state.characters
  
func get_new_id():
	var s := "hid%d"
	var t = randi()
	while characters.has(s % t) or state.characters.has(s % t):
		t += 1
	return s % t


func add_char(ch):
	var id = get_new_id()
	characters[id] = ch
	ch.id = id
	return id

func add_stored_char(id, ch):
	characters[id] = ch

func get_char_by_id(id):
	if state.characters.has(id): return state.characters[id]
	if characters.has(id): return characters[id]

func cleanup():
	for id in characters.keys():
		if !characters[id].is_active:
			characters[id].clean_effects()
#			if state.characters.has(id):
#				state.character_order.erase(id)
#				input_handler.slave_list_node.rebuild()
			remove_id(id)
	for id in state.characters.keys():
		if !state.characters[id].is_active:
			state.characters[id].clean_effects()
			state.character_order.erase(id)
			input_handler.slave_list_node.rebuild()
			remove_id(id)

func remove_id(id):
	if state.characters.has(id): state.characters.erase(id)
	else: characters.erase(id)

func move_to_state(id):
	if !characters.has(id): return
	var tmp = characters[id]
	characters.erase(id)
	state.characters[id] = tmp
	state.character_order.append(id)

func move_baby_to_state(id):
	if !state.babies.has(id): return
	var tmp = state.babies[id]
	state.babies.erase(id)
	state.characters[id] = tmp
	state.character_order.append(id)

func move_to_pool(id):
	if !state.characters.has(id): return
	var tmp = state.characters[id]
	state.characters.erase(id)
	characters[id] = tmp
	state.character_order.erase(id) #not sure about placing this here and not onto a higher level



func serialize():
	var tmp = {}
	for hid in characters.keys():
		tmp[hid] = inst2dict(characters[hid])
		characters[hid].fix_serialize(tmp[hid])
	return tmp

func deserialize(tmp):
	characters.clear()
	for hid in tmp.keys():
		characters[hid] = dict2inst(tmp[hid])
