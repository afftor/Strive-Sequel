extends Node

var slave_number = 0

func start():
	if state.starting_preset == '' || starting_presets.preset_data.has(state.starting_preset) == false:
		print('Error: no preset exists')
		return
	var data = starting_presets.preset_data[state.starting_preset]
	state.money = data.gold
	slave_number = data.free_slave_number
	for i in data.materials:
		state.materials[i] = data.materials[i]
	for i in data.upgrades:
		state.upgrades[i] = data.upgrades[i]
	
	input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['master'])
	yield(input_handler, 'CharacterCreated')
	if data.code != 'default':
		while slave_number > 0:
			slave_number -= 1
			input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['slave'])
			yield(input_handler, 'CharacterCreated')
	
	finish()

func finish():
	input_handler.emit_signal("StartingSequenceComplete")

