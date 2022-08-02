extends Node

var slave_number = 0

func start():
	if ResourceScripts.game_globals.starting_preset == '' || starting_presets.preset_data.has(ResourceScripts.game_globals.starting_preset) == false:
		print('Error: no preset exists')
		return
	var data = starting_presets.preset_data[ResourceScripts.game_globals.starting_preset].duplicate()
	slave_number = data.free_slave_number
	for i in data.materials:
		ResourceScripts.game_res.materials[i] = data.materials[i]
	for i in data.items:
		if Items.itemlist[i].type == 'usable':
			globals.AddItemToInventory(globals.CreateUsableItem(i, data.items[i]))
		elif Items.itemlist[i].type == 'gear':
			while data.items[i] > 0:
				data.items[i] -= 1
				globals.AddItemToInventory(globals.CreateGearItem(i, {}))
	ResourceScripts.game_res.money = data.gold #magic with signal emitting for correct clock updating
	for i in data.upgrades:
		ResourceScripts.game_res.upgrades[i] = data.upgrades[i]
	
	ResourceScripts.game_progress.decisions = data.decisions.duplicate()
	ResourceScripts.game_progress.active_quests = data.active_quests.duplicate()
	ResourceScripts.game_progress.completed_quests = data.completed_quests.duplicate()
	if data.has('seen_dialogues'):
		ResourceScripts.game_progress.seen_dialogues = data.seen_dialogues.duplicate()
	if data.has("unlocked_classes"):
		ResourceScripts.game_progress.unlocked_classes = data.unlocked_classes.duplicate()
	
	if data.has("total_reputation"):
		for i in ['fighters','workers','servants','mages']:
			globals.common_effects([{code = 'reputation', name = i, operant = '+', value = data.total_reputation}])
	
	gui_controller.char_creation = input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['master'])
	yield(input_handler, 'CharacterCreated')
	if data.code != 'default':
		while slave_number > 0:
			slave_number -= 1
			input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['slave'])
			yield(input_handler, 'CharacterCreated')
	
	finish()

func finish():
	input_handler.emit_signal("StartingSequenceComplete")

