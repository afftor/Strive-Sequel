extends Control

func _ready():
	build_lines()

func add_new_chatter(character, line):
	var newnode = globals.DuplicateContainerTemplate(self)
	newnode.texture = character.get_icon()
	newnode.get_node("Text").text = character.translate(line)


var personalities = {
	shy = {},
	bold = {},
	kind = {},
	serious = {},
}

var lines = {
	hire = [],
	sell = [],
	fight_win = [],
	fight_lose = [],
}

var individual_lines = {
	hire_line1 = {text = "...Pleased to meet you, [master].", events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},#tags: oneshot (1 time use per game), outweight (will always be presented if is in pool)
	hire_line2 = {text = "Please, take care of me, [master].", events = ['hire'], personalities = ['shy', 'serious', 'kind'], reqs = [], weight = 1, tags = []},
	hire_line3 = {text = "So you are my new [master]! Pleased to meet you!", events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
}
func build_lines():
	for i in lines:
		for k in individual_lines.values():
			if k.events.has(i):
				lines[i].append(k.duplicate(true))

func select_chat_line(character, event):
	var array = []
	for i in lines[event]:
		if i.personalities.has(character.personality) && character.checkreqs(i.reqs) == true:
			array.append([i.text, i.weight])
	if array.size() > 0:
		var line = input_handler.weightedrandom(array)
		add_new_chatter(character, line)
