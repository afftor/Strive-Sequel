extends Node

var slave_number = 0

func start():
	if ResourceScripts.game_globals.starting_preset == '' || starting_presets.preset_data.has(ResourceScripts.game_globals.starting_preset) == false:
		print('Error: no preset exists')
		return
	var data = starting_presets.preset_data[ResourceScripts.game_globals.starting_preset].duplicate()
	slave_number = data.free_slave_number
	if !ResourceScripts.game_globals.skip_prologue:
		slave_number -= 1 #stub
#	for i in data.materials:
#		ResourceScripts.game_res.materials[i] = data.materials[i]
	for i in data.items:
		if Items.itemlist[i].type == 'usable':
			globals.AddItemToInventory(globals.CreateUsableItem(i, data.items[i]))
		elif Items.itemlist[i].type == 'gear':
			while data.items[i] > 0:
				data.items[i] -= 1
				globals.AddItemToInventory(globals.CreateGearItem(i, {}))
#	ResourceScripts.game_res.money = data.gold #magic with signal emitting for correct clock updating
	for i in data.upgrades:
		ResourceScripts.game_res.upgrades[i] = data.upgrades[i]
	
	gui_controller.char_creation = input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['master'])
	yield(input_handler, 'CharacterCreated')
	yield(globals.get_tree(), 'idle_frame')
#	if data.code != 'default':
	while slave_number > 0:
		slave_number -= 1
		input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['slave'])
		yield(input_handler, 'CharacterCreated')
		yield(globals.get_tree(), 'idle_frame')
	
	finish()

func finish():
	input_handler.emit_signal("StartingSequenceComplete")

