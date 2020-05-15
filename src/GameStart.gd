extends Node

var slave_number = 0

func start():
	if ResourceScripts.game_globals.starting_preset == '' || starting_presets.preset_data.has(ResourceScripts.game_globals.starting_preset) == false:
		print('Error: no preset exists')
		return
	var data = starting_presets.preset_data[ResourceScripts.game_globals.starting_preset]
	ResourceScripts.game_res.money = data.gold
	slave_number = data.free_slave_number
	for i in data.materials:
		ResourceScripts.game_res.materials[i] = data.materials[i]
	for i in data.upgrades:
		ResourceScripts.game_res.upgrades[i] = data.upgrades[i]
	
	input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['master'])
	yield(input_handler, 'CharacterCreated')
	if data.code != 'default':
		ResourceScripts.game_progress.mainprogress = 1
		while slave_number > 0:
			slave_number -= 1
			input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['slave'])
			yield(input_handler, 'CharacterCreated')
	else:
		ResourceScripts.game_progress.mainprogress = 0
	
	finish()

func finish():
	input_handler.emit_signal("StartingSequenceComplete")

