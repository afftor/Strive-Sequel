extends Control

onready var positions_node = $PrefightPanel/Positions
var group = {}
var enemy_group = [['arena_test1', 1], ['arena_test2', 1], ['arena_test3', 1]]

func _ready():
	positions_node.open_defined(group, self, 'start_combat', true)
	
	$PrefightPanel/Button2.connect("pressed",self,'hide')

func start_combat():
	var test_char_id
	for i in group:
		if group[i] != null:
			test_char_id = group[i]
			break
	
	var test_char = ResourceScripts.game_party.characters[test_char_id]
	test_char.clone()
#	var test = test_char.clone()
#	var all_effects = test_char.get_all_effects()
#	var test = {}# = test_char.serialize()
#	for eff in all_effects:
#		test[eff] = effects_pool.get_effect_by_id(eff).serialize()
#	var file_handler = File.new()
#	file_handler.open("user://output.gd", File.WRITE)
#	file_handler.store_string(to_json(test))
#	file_handler.close()
	
#	if input_handler.combat_node == null:
#		input_handler.combat_node = input_handler.get_combat_node()
#	var data
#	input_handler.encounter_win_script = null
#	input_handler.encounter_lose_script = null
#
#	if ResourceScripts.game_globals.skip_combat == true:
#		input_handler.finish_combat()
#		return
#
#	var enemies = globals.make_enemies(enemy_group, true)
#
#	input_handler.combat_node.encountercode = 'arena'
#	input_handler.combat_node.set_norun_mode(false)
#	input_handler.combat_node.start_combat(group, enemies, 'background')
