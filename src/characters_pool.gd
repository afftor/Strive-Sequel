extends Node
# warning-ignore-all:return_value_discarded

var characters: = {}

func get_new_id():
	var s := "hid%d"
	var t = randi()
	while characters.has(s % t):
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
	return characters[id]

func cleanup():
	for id in characters:
		if !characters[id].is_active:
			characters[id].clean_effects()
			remove_id(id)

func remove_id(id):
	characters.erase(id)


func serialize():
	var tmp = {}
	for hid in characters.keys():
		tmp[hid] = inst2dict(characters[hid])
	return tmp

func deserialize(tmp):
	characters.clear()
	for hid in tmp.keys():
		characters[hid] = dict2inst(tmp[hid])
