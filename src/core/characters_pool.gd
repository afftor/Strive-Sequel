extends Node
# warning-ignore-all:return_value_discarded

var characters: = {}
# for now for the sake of working of all legacy code only temporal characters are stored directly in pool, all player-controlled characters are still stored in state.characters

func get_new_id():
	var s := "hid%d"
	var t = randi()
	while characters.has(s % t) or ResourceScripts.game_party.characters.has(s % t):
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
	if ResourceScripts.game_party.characters.has(id): return ResourceScripts.game_party.characters[id]
	if characters.has(id): return characters[id]

func cleanup(on_exit = false):
	for id in characters.keys():
		if !characters[id].is_active or on_exit:
			characters[id].clean_effects()
#			if state.characters.has(id):
#				state.character_order.erase(id)
#				input_handler.slave_list_node.rebuild()
			characters[id].clean_references()
			remove_id(id)
	if ResourceScripts.game_party == null: return
	if ResourceScripts.game_party.characters == null: return
	for id in ResourceScripts.game_party.characters.keys():
		if !ResourceScripts.game_party.characters[id].is_active or on_exit:
			ResourceScripts.game_party.characters[id].clean_effects()
			ResourceScripts.game_party.characters[id].clean_references()
			ResourceScripts.game_party.character_order.erase(id)
			if !on_exit: input_handler.slave_list_node.rebuild() #temporal, needs remake
			remove_id(id)

func remove_id(id):
	if ResourceScripts.game_party.characters.has(id): ResourceScripts.game_party.characters.erase(id)
	else: characters.erase(id)

func move_to_state(id):
	if !characters.has(id): return
	var tmp = characters[id]
	characters.erase(id)
	ResourceScripts.game_party.characters[id] = tmp
	ResourceScripts.game_party.character_order.append(id)


func move_baby_to_state(id):
	if !ResourceScripts.game_party.babies.has(id): return
	var tmp = ResourceScripts.game_party.babies[id]
	ResourceScripts.game_party.babies.erase(id)
	ResourceScripts.game_party.characters[id] = tmp
	ResourceScripts.game_party.character_order.append(id)


func move_to_baby(id):
	if !characters.has(id): return
	var tmp = characters[id]
	characters.erase(id)
	ResourceScripts.game_party.babies[id] = tmp


func move_to_pool(id):
	if !ResourceScripts.game_party.characters.has(id): return
	var tmp = ResourceScripts.game_party.characters[id]
	ResourceScripts.game_party.characters.erase(id)
	characters[id] = tmp
	ResourceScripts.game_party.character_order.erase(id) #not sure about placing this here and not onto a higher level


func serialize():
	cleanup()
	var tmp = {}
	for hid in characters.keys():
		tmp[hid] = characters[hid].serialize()
#		characters[hid].fix_serialize(tmp[hid])
	return tmp

func deserialize(tmp):
	characters.clear()
	for hid in tmp.keys():
		characters[hid] = dict2inst(tmp[hid])
		characters[hid].fix_serialization()



func get_babies_from_data(tmp):
	pass
