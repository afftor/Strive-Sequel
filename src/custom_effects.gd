extends Node

var person

func hairdye(character):
	person = character
	var node = input_handler.get_spec_node(input_handler.NODE_TEXTEDIT) #input_handler.GetTextEditNode()
	node.open(self, 'set_hair_color', person.hair_color, person.translate("Select new hair color for [name]"))

func set_hair_color(text):
	person.hair_color = text
	input_handler.update_slave_panel()

func minorus_potion(character):
	person = character
	input_handler.interactive_message("minorus_potion_select",'custom_effect', {})
func majorus_potion(character):
	person = character
	input_handler.interactive_message("majorus_potion_select",'custom_effect', {})

func minorus_tits():
	var character = person
	if !character.tits_size in ['masculine','flat']:
		character.tits_size = variables.slave_basic_sizes[variables.slave_basic_sizes.find(character.tits_size) - 1]
		input_handler.interactive_message("minorus_potion_tits",'char_translate',character)
	else:
		input_handler.interactive_message("potion_no_effect", '', {})
	input_handler.update_slave_panel()
func minorus_ass():
	var character = person
	if !character.ass_size in ['masculine','flat']:
		character.ass_size = variables.slave_basic_sizes[variables.slave_basic_sizes.find(character.ass_size) - 1]
		input_handler.interactive_message("minorus_potion_ass",'char_translate',character)
	else:
		input_handler.interactive_message("potion_no_effect", '', {})
	input_handler.update_slave_panel()
func minorus_balls():
	var character = person
	if !character.balls_size in ['small']:
		character.balls_size = variables.slave_genital_sizes[variables.slave_genital_sizes.find(character.balls_size) - 1]
		input_handler.interactive_message("minorus_potion_balls",'char_translate',character)
	else:
		input_handler.interactive_message("potion_no_effect", '', {})
	input_handler.update_slave_panel()
func minorus_penis():
	var character = person
	if !character.penis_size in ['small']:
		character.penis_size = variables.slave_genital_sizes[variables.slave_genital_sizes.find(character.penis_size) - 1]
		input_handler.interactive_message("minorus_potion_balls",'char_translate',character)
	else:
		input_handler.interactive_message("potion_no_effect", '', {})
	input_handler.update_slave_panel()

func majorus_tits():
	var character = person
	if !character.tits_size in ['huge']:
		character.tits_size = variables.slave_basic_sizes[variables.slave_basic_sizes.find(character.tits_size) + 1]
		input_handler.interactive_message("majorus_potion_tits",'char_translate',character)
	else:
		input_handler.interactive_message("potion_no_effect", '', {})
	input_handler.update_slave_panel()
func majorus_ass():
	var character = person
	if !character.ass_size in ['huge']:
		character.ass_size = variables.slave_basic_sizes[variables.slave_basic_sizes.find(character.ass_size) + 1]
		input_handler.interactive_message("majorus_potion_ass",'char_translate',character)
	else:
		input_handler.interactive_message("potion_no_effect", '', {})
	input_handler.update_slave_panel()
func majorus_balls():
	var character = person
	if !character.balls_size in ['big']:
		character.balls_size = variables.slave_genital_sizes[variables.slave_genital_sizes.find(character.balls_size) + 1]
		input_handler.interactive_message("majorus_potion_balls",'char_translate',character)
	else:
		input_handler.interactive_message("potion_no_effect", '', {})
	input_handler.update_slave_panel()
func majorus_penis():
	var character = person
	if !character.penis_size in ['big']:
		character.penis_size = variables.slave_genital_sizes[variables.slave_genital_sizes.find(character.penis_size) + 1]
		input_handler.interactive_message("majorus_potion_balls",'char_translate',character)
	else:
		input_handler.interactive_message("potion_no_effect", '', {})
	input_handler.update_slave_panel()