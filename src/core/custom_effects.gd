extends Node

var person

func hairdye(character):
	person = character
	input_handler.active_character = person
	var node = input_handler.get_spec_node(input_handler.NODE_TEXTEDIT) #input_handler.GetTextEditNode()
	node.open(self, 'set_hair_color', person.get_stat('hair_color'), person.translate("Select new hair color for [name]"))

func set_hair_color(text):
	person.set_stat('hair_color', text)

func minorus_potion(character):
	person = character
	input_handler.active_character = person
	input_handler.interactive_message("minorus_potion_select",'custom_effect', {})

func majorus_potion(character):
	person = character
	input_handler.active_character = person
	input_handler.interactive_message("majorus_potion_select",'custom_effect', {})

func minorus_tits():
	var character = person
	if !character.get_stat('tits_size') in ['masculine','flat']:
		character.set_stat('tits_size', variables.slave_basic_sizes[variables.slave_basic_sizes.find(character.get_stat('tits_size')) - 1])
		input_handler.interactive_message_follow("minorus_potion_tits",'char_translate',character)
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func minorus_ass():
	var character = person
	if !character.get_stat('ass_size') in ['masculine','flat']:
		character.set_stat('ass_size', variables.slave_basic_sizes[variables.slave_basic_sizes.find(character.get_stat('ass_size')) - 1])
		input_handler.interactive_message_follow("minorus_potion_ass",'char_translate',character)
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func minorus_balls():
	var character = person
	if !character.get_stat('balls_size') in ['small']:
		character.set_stat('balls_size', variables.slave_genital_sizes[variables.slave_genital_sizes.find(character.get_stat('balls_size')) - 1])
		input_handler.interactive_message_follow("minorus_potion_balls",'char_translate',character)
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func minorus_penis():
	var character = person
	if !character.get_stat('penis_size') in ['small']:
		character.set_stat('penis_size', variables.slave_genital_sizes[variables.slave_genital_sizes.find(character.get_stat('penis_size')) - 1])
		input_handler.interactive_message_follow("minorus_potion_penis",'char_translate',character)
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func majorus_tits():
	var character = person
	if !character.get_stat('tits_size') in ['huge']:
		character.set_stat('tits_size', variables.slave_basic_sizes[variables.slave_basic_sizes.find(character.get_stat('tits_size')) + 1])
		input_handler.interactive_message_follow("majorus_potion_tits",'char_translate',character)
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func majorus_ass():
	var character = person
	if !character.get_stat('ass_size') in ['huge']:
		character.set_stat('ass_size', variables.slave_basic_sizes[variables.slave_basic_sizes.find(character.get_stat('ass_size')) + 1])
		input_handler.interactive_message_follow("majorus_potion_ass",'char_translate',character)
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func majorus_balls():
	var character = person
	if !character.get_stat('balls_size') in ['big']:
		character.set_stat('balls_size', variables.slave_genital_sizes[variables.slave_genital_sizes.find(character.get_stat('balls_size')) + 1])
		input_handler.interactive_message_follow("majorus_potion_balls",'char_translate',character)
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func majorus_penis():
	var character = person
	if !character.get_stat('penis_size') in ['big']:
		character.set_stat('penis_size', variables.slave_genital_sizes[variables.slave_genital_sizes.find(character.get_stat('penis_size')) + 1])
		input_handler.interactive_message_follow("majorus_potion_penis",'char_translate',character)
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})
	#input_handler.update_slave_panel()

func writ_of_exemption(character):
	person = character
	input_handler.active_character = person
	input_handler.interactive_message_follow("writ_of_exemption",'custom_effect', {})

func writ_of_exemption_use():
	var character = person
	var acceptance_req = 100
	var acceptance_chance = 0
	ResourceScripts.game_res.remove_item("writ_of_exemption", 1)
	input_handler.get_spec_node(input_handler.NODE_GUI_WORLD).close_scene(input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW))
	input_handler.scene_characters = [person]
	if character.get_stat('loyalty') == 100 && character.get_stat('submission') == 100:
		acceptance_chance = 100
	else:
		acceptance_chance = (character.get_stat('loyalty') + character.get_stat('submission')) / 2
		acceptance_chance = acceptance_chance - acceptance_chance*variables.personality_conversion_rates[character.get_stat('personality')]
	if acceptance_chance >= randf()*acceptance_req:
		input_handler.interactive_message_follow("writ_of_exemption_success",'char_translate',character)
		character.set_slave_category('servant')
		character.add_stat('loyalty', 25)
	else:
		input_handler.interactive_message_follow("writ_of_exemption_failure",'char_translate',character)
		ResourceScripts.game_party.remove_slave(character)
	input_handler.rebuild_slave_list()

func oblivionpot(character):
	character.remove_all_classes()
	input_handler.active_character = character
	input_handler.interactive_message("oblivion_potion_use",'custom_effect', character)


func pheromones(character):
	input_handler.active_character = character
	if character.get_stat('race') in races.race_groups.halfbreeds + races.race_groups.beast:
		character.add_stat("lust", character.get_stat("lustmax"))
	input_handler.interactive_message("pheromones_use",'char_translate',character)

func sensetivity_pot(character):
	character.add_stat("lust", character.get_stat("lustmax"))
	input_handler.interactive_message("sensetivity_pot_use",'char_translate',character)

func close():#for the cancel function
	input_handler.get_spec_node(input_handler.NODE_DIALOGUE).close()
