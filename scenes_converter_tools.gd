extends Panel
onready var editor = $TextEdit
onready var keyword = $LineEdit
onready var newkeyword = $LineEdit2
onready var color = $LineEdit3

var scenecounter = 1
var optioncounter = 1
var textcounter = 1

func _ready():
	keyword.connect('text_changed', self, 'on_keyword_change')
	$b1.connect('pressed', self, 'replace_keyword')
	$b2.connect('pressed', self, 'make_text_key')
	$b3.connect('pressed', self, 'make_option_text_key')
	$b4.connect('pressed', self, 'make_text_line_simple')
	$b5.connect('pressed', self, 'make_text_lines_full')
	$b6.connect('pressed', self, 'wrap_options')
	$b7.connect('pressed', self, 'insert_continue')
	$b8.connect('pressed', self, 'wrap_scene')
	$b9.connect('pressed', self, 'wrap_char')
	$b10.connect('pressed', self, 'duplicate_line')
	$b11.connect('pressed', self, 'wrap_data')
	$b12.connect('pressed', self, 'add_translate_tag')


func on_keyword_change(arg = null):
	scenecounter = 1
	textcounter = 1
	optioncounter = 1


func duplicate_line():
	var line = editor.cursor_get_line()
	var wraptext = editor.get_line(line) + '\n'
	editor.cursor_set_column(0)
	editor.insert_text_at_cursor(wraptext)
	editor.update()


func make_text_key():
	var temptext
	if editor.is_selection_active():
		temptext = editor.get_selection_text()
	else:
		var line = editor.cursor_get_line()
		temptext = editor.get_line(line)
	var newkey = keyword.text.to_upper() + "_" + str(textcounter)
	if '[' in temptext:
		newkey += '!'
	textcounter += 1
	var newstring = '\t%s = """%s""",\n' % [newkey, temptext]
	var alltext = editor.text
	alltext = alltext.replacen(temptext, newkey)
	alltext += newstring
	editor.text = alltext 


func wrap_char():
	var temptext
	var wraptext
	var line = editor.cursor_get_line()
	temptext = editor.get_line(line)
	if editor.is_selection_active():
		wraptext = editor.get_selection_text()
	else:
		wraptext = editor.get_line(line)
	var newstring = '{color=%s|%s}' % [color.text, wraptext]
	temptext = temptext.replacen(wraptext, newstring)
	editor.set_line(line, temptext)
	editor.update()



func make_option_text_key():
	var temptext
	var line = editor.cursor_get_line()
	temptext = editor.get_line(line)
	var newkey = keyword.text.to_upper() + "_OPTION_" + str(optioncounter)
	if '[' in temptext:
		newkey += '!'
	optioncounter += 1
	var newstring = '\t%s = "%s",\n' % [newkey, temptext.trim_prefix('>')]
	var alltext = editor.text
	alltext = alltext.replacen(temptext, newkey)
	alltext += newstring
	editor.text = alltext 


func make_text_line_simple():
	var temptext
	var line = editor.cursor_get_line()
	temptext = editor.get_line(line)
	temptext  = 'text = "%s",' % temptext
	editor.set_line(line, temptext)
	editor.update()


func make_text_lines_full():
	if !editor.is_selection_active():
		return
	var linesarray = []
	var line = editor.get_selection_from_line()
	var line2 = editor.get_selection_to_line()
	for i in range(line, line2 + 1):
		linesarray.push_back(editor.get_line(i))
	editor.select(line, 0, line2, editor.get_line(line2).length() + 1)
	editor.cut()
	var newtext = 'text = [\n'
	for _str in linesarray:
		newtext += '\t{text = "%s", reqs = [], previous_dialogue_option = 0},\n' % [_str]
	newtext += '],'
	editor.insert_text_at_cursor(newtext)
	editor.update()


func wrap_options():
	if !editor.is_selection_active():
		return
	var linesarray = []
	var line = editor.get_selection_from_line()
	var line2 = editor.get_selection_to_line()
	for i in range(line, line2 + 1):
		linesarray.push_back(editor.get_line(i))
	editor.select(line, 0, line2, editor.get_line(line2).length() + 1)
	editor.cut()
	var newtext = 'options = [\n'
	for _str in linesarray:
		newtext += '\t{code = "", text = "%s", reqs = [], dialogue_argument = 1, type = \'next_dialogue\',},\n' % [_str]
	newtext += '],'
	editor.insert_text_at_cursor(newtext)
	editor.update()


func wrap_data():
	if !editor.is_selection_active():
		return
	var linesarray = []
	var line = editor.get_selection_from_line()
	var line2 = editor.get_selection_to_line()
	for i in range(line, line2 + 1):
		linesarray.push_back(editor.get_line(i))
	editor.select(line, 0, line2, editor.get_line(line2).length() + 1)
	editor.cut()
	var newtext = 'data = {\n'
	for _str in linesarray:
		newtext += '\t' + _str + '\n'
	newtext += '}'
	editor.insert_text_at_cursor(newtext)
	editor.update()


func insert_continue():
	editor.cursor_set_column(0)
	var newtext = 'options = [{code = "", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = \'next_dialogue\',}],\n'
	editor.insert_text_at_cursor(newtext)
	editor.update()


func wrap_scene():
	if !editor.is_selection_active():
		return
	var newkey = keyword.text + "_" + str(scenecounter)
	scenecounter += 1
	var linesarray = []
	var line = editor.get_selection_from_line()
	var line2 = editor.get_selection_to_line()
	for i in range(line, line2 + 1):
		linesarray.push_back(editor.get_line(i))
	editor.select(line, 0, line2, editor.get_line(line2).length() + 1)
	editor.cut()
	var newtext = '%s = {\n' % newkey
	if newkeyword.text != "":
		newtext += '\timage = null, character = "%s",\n' % newkeyword.text
	else:
		newtext += '\timage = null,\n'
	newtext += '\treqs = [], tags = ["dialogue_scene"],\n'
	for _str in linesarray:
		newtext += '\t' + _str + '\n'
	newtext += '},'
	editor.insert_text_at_cursor(newtext)
	editor.update()


func replace_keyword():
	if newkeyword.text == "":
		return
	var newkey = newkeyword.text
	var oldkey = keyword.text
	var alltext = editor.text
	alltext = alltext.replacen(oldkey, newkey)
	editor.text = alltext 
	newkeyword.text = ""
	on_keyword_change()


func add_translate_tag():
	editor.insert_text_at_cursor(', "master_translate",')
