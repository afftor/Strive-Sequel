extends Node

signal editor_save

var panel_scene = load("res://editor tools/classes/stat_panel.tscn")
var panel_scene_list = load("res://editor tools/classes/stat_panel_list.tscn")

var char_cond_scene = load("res://editor tools/forms/condition.tscn")
var glob_cond_scene = load("res://editor tools/forms/condition_global.tscn")
var event_glob_scene = load("res://editor tools/forms/event_global.tscn")
var professions_scene = load("res://editor tools/forms/profession.tscn")
var race_scene = load("res://editor tools/forms/race.tscn")
var char_type_scene = load("res://editor tools/forms/char_type.tscn")
var stat_change_scene = load("res://editor tools/forms/stat_change.tscn")
var stat_base_scene = load("res://editor tools/forms/stat_base.tscn")
var bodypart_scene = load("res://editor tools/forms/bodypart.tscn")
var part_cond_scene = load("res://editor tools/forms/part_condition.tscn")
var start_set_scene = load("res://editor tools/forms/start_settlement.tscn")
var race_chance_scene = load("res://editor tools/forms/race_chance.tscn")
var shop_item_scene = load("res://editor tools/forms/shop_item.tscn")
var rand_cond_scene = load("res://editor tools/forms/random_condition.tscn")
var rand_cond_char = load("res://editor tools/forms/random_condition_char.tscn")
var rand_cond_char_m = load("res://editor tools/forms/random_condition_char_m.tscn")
var reward_q_scene = load("res://editor tools/forms/reward_q.tscn")
var add_event_arg_scene = load("res://editor tools/forms/add_event_arg.tscn")
var char_change_arg_scene = load("res://editor tools/forms/char_change_arg.tscn")
var reward_e_scene = load("res://editor tools/forms/reward_e.tscn")
var enemy_scene = load("res://editor tools/forms/enemy_pool.tscn")
var event_item_scene = load("res://editor tools/forms/event_pool.tscn")
var dungeon_option_scene = load("res://editor tools/forms/dungeon_option.tscn")
var common_effect_scene = load("res://editor tools/forms/common_effect.tscn")
var land_scene = load("res://editor tools/forms/land.tscn")
var location_scene = load("res://editor tools/forms/location.tscn")
var factiondata_scene = load("res://editor tools/forms/factiondata.tscn")
var questdata_scene = load("res://editor tools/forms/questdata.tscn")
var dungeons_scene = load("res://editor tools/forms/dungeon.tscn")
var pregen_c_scene = load("res://editor tools/forms/pregen_character.tscn")

var desc_panel = "res://editor tools/panels/desc_panel.tscn"
var image_base = "res://editor tools/panels/image_base.tscn"

enum {PANEL_BOOL, PANEL_FORM, PANEL_INT, PANEL_EDIT, PANEL_SELECT, PANEL_NUM, PANEL_OPTION, PANEL_STRING, PANEL_TUNNEL, PANEL_CUSTOM}

var current_mod
var current_table
var current_table_mod
var current_base_table

func get_list(source, mainarg, backuparg):
	var res = []
	for rec in source.values():
		if rec.has(mainarg): res.push_back(rec[mainarg])
		else: res.push_back(rec[backuparg])
	return res

func get_list_cond(source, mainarg, backuparg, arg, value):
	var res = []
	for rec in source.values():
		if !rec.has(arg): continue
		if rec[arg] != value: continue
		if rec.has(mainarg): res.push_back(rec[mainarg])
		else: res.push_back(rec[backuparg])
	return res

func display_res(dir, key = null):
	#to remake, test only
	var tmp = to_display(dir, 0)
	
	if key != null:
		return '"%s" : %s' % [str(key), tmp]
	else: return tmp

func to_display(value, ntabs):
	var res = ""
	if typeof(value) == TYPE_ARRAY:
		var temp: String
		temp = to_json(value)
		if temp.length() > 40:
			temp = "[\n"
			for i in value:
				var tt = input_handler.repeat_string("\t", ntabs + 1)
				tt += to_display(i, ntabs + 1)
				tt += ",\n"
				temp += tt
			temp = temp.trim_suffix(",\n")
			temp += "\n"
			temp += input_handler.repeat_string("\t", ntabs)
			temp += "]"
		res = temp
	elif typeof(value) == TYPE_DICTIONARY:
		var temp = to_json(value)
		if temp.length() > 40:
			temp = "{\n"
			for i in value:
				var tt = input_handler.repeat_string("\t", ntabs + 1)
				tt += to_json(i)
				tt += " : " 
				tt += to_display(value[i], ntabs + 1)
				tt += ",\n"
				temp += tt
			temp = temp.trim_suffix(",\n")
			temp += "\n"
			temp += input_handler.repeat_string("\t", ntabs)
			temp += "}"
		res = temp
	else: res = to_json(value)
	return res

func apply_patch(data, external = false):
	for key in data:
		var tmp = data[key].duplicate(true)
		if !modding_core.tables[current_table].has(current_table_mod):
			modding_core.tables[current_table][current_table_mod] = {}
		modding_core.tables[current_table][current_table_mod][key] = tmp
		if !current_base_table.has(key): current_base_table[key] = {}
		for t in tmp:
			current_base_table[key][t] = tmp[t]
	if external: emit_signal("editor_save")
