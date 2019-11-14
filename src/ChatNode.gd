extends Control
# warning-ignore-all:return_value_discarded

func _init():
	build_lines()

func _ready():
	$Button.connect("mouse_entered", self, "show_log")

func show_log():
	print(storedlines)

var storedlines = []

func add_new_chatter(character, line):
	var newnode = globals.DuplicateContainerTemplate($VBoxContainer)
	var data = {name = character.get_short_name(), text = character.translate(line), time = str(state.date) + "-" + str(state.hour) + ":00"}
	newnode.get_node("Icon").texture = character.get_icon()
	newnode.get_node("Text").text = data.text
	newnode.get_node("Name").text = data.name
	input_handler.UnfadeAnimation(newnode,0.3)
	storedlines.append(data)
	yield(get_tree().create_timer(10),"timeout")
	input_handler.FadeAnimation(newnode, 1)
	yield(get_tree().create_timer(1),"timeout")
	newnode.hide()


var personalities = {
	shy = {},
	bold = {},
	kind = {},
	serious = {},
}

var lines = {
#	hire = [],
#	sell = [],
#	fight_win = [],
#	fight_lose = [],
}

var individual_lines = {
	hire_line1 = {text = "...Pleased to meet you, [Master].", events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},#tags: oneshot (1 time use per game), outweight (will always be presented if is in pool)
	hire_line2 = {text = "Please, take care of me, [Master].", events = ['hire'], personalities = ['shy', 'serious', 'kind'], reqs = [], weight = 1, tags = []},
	hire_line3 = {text = "So you are my new [Master]! Pleased to meet you!", events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line4 = {text = "I hope you aren't taking me just for lewd affairs.", events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line5 = {text = "Ah, yes... I-it's a pleasure to meet you, [Master]!", events = ['hire'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	
	slavery_line1 = {text = "You... made me into a slave? No...", events = ['enslave'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	slavery_line2 = {text = "I'm slave now?! What the hell!", events = ['enslave'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	slavery_line3 = {text = "Why...? *sob*", events = ['enslave'], personalities = ['shy','kind','serious'], reqs = [], weight = 1, tags = []},
	slavery_line4 = {text = "This is despicable!", events = ['enslave'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	slavery_line5 = {text = "No... I hate you!", events = ['enslave'], personalities = ['serious','bold','kind','shy'], reqs = [], weight = 0.5, tags = []},
	
	experience_line1 = {text = "I've learned so much recently... I think I'm ready for bigger things!", events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line2 = {text = "My skills have grown. ", events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line3 = {text = "I feel like I've learned a lot... what do you think, [Master]?", events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line5 = {text = "Um, [Master], I think I can learn something new to be useful to you...", events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line6 = {text = "[Master], with all experience I got, I'm sure I can be more useful to you.", events = ['exp_for_level'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	
	item_created_line1 = {text = "That's finally done...", events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line2 = {text = "I've done it, [Master].", events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line3 = {text = "That thing you asked to make, [Master]...", events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line4 = {text = "Here, [Master], I've done my best.", events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	
	combat_win_line1 = {text = "Phew, we did it...", events = ['combat_won'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	combat_win_line2 = {text = "Hah, piece of cake.", events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line3 = {text = "Well fought. Lets move on. ", events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line4 = {text = "That wasn't too bad...", events = ['combat_won'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	combat_win_line5 = {text = "Haha, that felt good.", events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	
	sex_start_line1 = {text = "Um... we are going to do this...", events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_start_line2 = {text = "We are going to have sex...", events = ['sex_start'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	sex_start_line3 = {text = "I'm not too eager for this, but if you insist.", events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line4 = {text = "Hmh, leering over my body, [Master]?", events = ['sex_start'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	sex_start_line5 = {text = "Alright, lets have some fun time.", events = ['sex_start'], personalities = ['bold','serious','kind'], reqs = [], weight = 1, tags = []},
	
	sex_finish_line1 = {text = "...I-I'm not against doing it again.", events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line2 = {text = "♥", events = ['sex_start'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line3 = {text = "Ahh, it feels like a waste to work after this.", events = ['sex_start'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line4 = {text = "Uh, my body is all sweaty now...", events = ['sex_start'], personalities = ['serious','shy','kind'], reqs = [], weight = 1, tags = []},
	
	master_praise_line1 = {text = "I've got praised by [Master]...", events = ['master_praise'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	master_praise_line2 = {text = "I've earned it, haven't I, [Master]?", events = ['master_praise'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	
	master_punish_line1 = {text = "Sorry, I'll be good, [Master]...", events = ['master_punish'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	master_punish_line2 = {text = "Ugh... it really hurts, [Master].", events = ['master_punish'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	master_punish_line3 = {text = "I understand... this is for the order.", events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_punish_line4 = {text = "Hmh! Just so you know, it didn't hurt at all!", events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	
	
}

func build_lines():
	for i in individual_lines.values():
		for k in i.events:
			if !lines.has(k):
				lines[k] = []
			lines[k].append(i.duplicate(true))
		
#	for i in lines:
#		for k in individual_lines.values():
#			if k.events.has(i):
#				lines[i].append(k.duplicate(true))

func select_chat_line(character, event):
	var array = []
	for i in lines[event]:
		if i.personalities.has(character.personality) && character.checkreqs(i.reqs) == true:
			array.append([i.text, i.weight])
	if array.size() > 0:
		var line = input_handler.weightedrandom(array)
		add_new_chatter(character, line)
