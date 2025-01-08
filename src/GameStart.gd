extends Node

var slave_number = 0
var got_back = false

func start():
	if ResourceScripts.game_globals.skip_prologue and !ResourceScripts.game_globals.diff_solo:
		slave_number = 2
	
	gui_controller.char_creation = input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['master'])
	yield(input_handler, 'CharacterCreated')
	if got_back:
		finish()
		return
	yield(globals.get_tree(), 'idle_frame')
#	if data.code != 'default':
	while slave_number > 0:
		slave_number -= 1
		input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['slave'])
		yield(input_handler, 'CharacterCreated')
		if got_back:
			finish()
			return
		yield(globals.get_tree(), 'idle_frame')
	
	finish()

func finish():
	input_handler.emit_signal("StartingSequenceComplete")

