 extends Control

var file = File.new()
var dir = Directory.new()

var characterkeys = {
	A = 'ARRON',
	R = 'ROSE',
	GRD = 'GUARD',
	L = 'LYRA',
	N = 'NORBERT',
	G = 'GOBLIN',
	E = 'EMBER',
	
}

func _ready():
	$FileDialog.popup()

func turn_text_to_event(textarray, eventname):
	var dict = {}
	var array = []
	var counter = 0
	textarray = textarray.split('\n')
	eventname = eventname.replace('.txt', '').to_upper()
	for i in textarray:
		var source
		var string = i.split(' - ')
		if string.size() > 1:
			if characterkeys.has(string[0]):
				source = characterkeys[string[0]]
			else:
				source = 'Error'
			string = string[1]
		else:
			source = 'narrator'
			string = string[0]
		dict = {effect = 'text', source = source, portrait = null, sound = null, value = string}
		#dict = str(dict)
		#dict = dict.insert(dict.find("sound = Null") + 12, '\n')
		array.append(dict.duplicate())
		counter += 1
	file.open($FileDialog.current_path + '.json', File.WRITE)
	file.store_string(to_json(array))
	file.close()
#	var dict = {}
#	var eventdict = {}
#	var array = []
#	var counter = 0
#	textarray = textarray.split('\n')
#	eventname = eventname.replace('.txt', '').to_upper()
#	for i in textarray:
#		var source
#		var string = i.split(' - ')
#		var linename = eventname + str(counter)
#		if string.size() > 1:
#			string = string[1]
#			source = characterkeys[string[0]]
#		dict = {effect = 'text', value = linename, source = source, portrait = null, sound = null}
#		array.apend(dict.duplicate())
#		eventdict[linename] = string
#		counter += 1
#
#	eventdict = to_json(eventdict)
#	file.open($FileDialog.current_path + '_new.json', File.WRITE)
#	file.store_string(eventdict)
#	file.close()
#	file.open($FileDialog.current_path + '_data.json', File.WRITE)
#	file.store_string(array)
#	file.close()

var currentfilename
var currentpath

func _on_FileDialog_file_selected(path):
	currentfilename = $FileDialog.current_file
	currentpath = $FileDialog.current_path
	file.open(path, File.READ)
	var temp = file.get_as_text()
	file.close()
	turn_text_to_event(temp, $FileDialog.current_file)
	