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
	input_handler.PlaySound("chat_click")
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
	
	slavery_line1 = {text = "You... made me into a slave? No... *sob*", events = ['enslave'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	slavery_line2 = {text = "Why have you done this!?", events = ['enslave'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	slavery_line3 = {text = "Why...? *sob*", events = ['enslave'], personalities = ['shy','kind','serious'], reqs = [], weight = 1, tags = []},
	slavery_line4 = {text = "This is despicable! I'll not take it!", events = ['enslave'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	slavery_line5 = {text = "How could you?! I hate you!", events = ['enslave'], personalities = ['serious','bold','kind','shy'], reqs = [], weight = 0.5, tags = []},
	
	experience_line1 = {text = "I've learned so much recently... I think I'm ready for bigger things!", events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line2 = {text = "My skills have grown. ", events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line3 = {text = "I feel like I've learned a lot... what do you think, [Master]?", events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line5 = {text = "Um, [Master], I think I can learn something new to be useful to you...", events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line6 = {text = "[Master], with all experience I got, I'm sure I can be more useful to you.", events = ['exp_for_level'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	
	item_created_line1 = {text = "That's finally done...", events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line2 = {text = "I've done it, [Master].", events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line3 = {text = "That thing you asked to make, [Master]...", events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line4 = {text = "Here, [Master], I've done my best.", events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	
	combat_win_line1 = {text = "Phew, we did it, [Master]...", events = ['combat_won'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	combat_win_line2 = {text = "Hah, piece of cake. Who's next?", events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line3 = {text = "Well fought. Lets move on, [Master]. ", events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line4 = {text = "I'm glad we won, but let's keep cautious. ", events = ['combat_won'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	combat_win_line5 = {text = "Hah, I didn't even break a sweat.", events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	
	sex_start_line1 = {text = "Um... you really want me to do this? I'm not sure I'm ready...", events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_start_line2 = {text = "You want me for lewd things, [Master]...", events = ['sex_start'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	sex_start_line3 = {text = "I'm not too eager for this, but if you insist.", events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line4 = {text = "Hmh, leering over my body, [Master]?", events = ['sex_start'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	sex_start_line5 = {text = "Alright, if you want me...", events = ['sex_start'], personalities = ['bold','serious','kind'], reqs = [], weight = 1, tags = []},
	sex_start_line6 = {text = "I...like being with you, [Master]...", events = ['sex_start','sex_finish'], personalities = ['bold','kind','serious','shy'], reqs = [], weight = 2, tags = [], arg_reqs = ['partner_is_master']},
	
	
	
	sex_finish_line1 = {text = "...I-I'm not against doing it again.", events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	#sex_finish_line2 = {text = "♥", events = ['sex_finish'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line3 = {text = "Ahh, it feels like a waste to work after this.", events = ['sex_finish'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line4 = {text = "Uh, my body is all sweaty now... Can I take a bath, [Master]?", events = ['sex_finish'], personalities = ['serious','shy','kind'], reqs = [], weight = 1, tags = []},
	
	master_praise_line1 = {text = "I've got praised by [Master]... It makes me happy", events = ['master_praise'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	master_praise_line2 = {text = "I've earned it, haven't I, [Master]?", events = ['master_praise'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	
	master_punish_line1 = {text = "Sorry, I'll be good, [Master]...", events = ['master_punish'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	master_punish_line2 = {text = "Ugh... it really hurts, [Master].", events = ['master_punish'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	master_punish_line3 = {text = "I understand... this is for the order.", events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_punish_line4 = {text = "Hmh! Just so you know, it didn't hurt at all!", events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	
	master_abuse_line1 = {text = "Why... *sob*", events = ['abuse'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line2 = {text = "This is horrible... You are horrible!", events = ['abuse'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	master_abuse_line3 = {text = "Ah! Please, not the ears!", events = ['abuse'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line4 = {text = "Please... no more...", events = ['abuse'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	
	sex_reward_line1 = {text = "Such reward? There's no... Ah...", events = ['sexreward'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line2 = {text = "[Master]? *gulp* I haven't really asked for this...", events = ['sexreward'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line3 = {text = "A lewd reward?.. Huh, fine, I could use a break.", events = ['sexreward'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	
	loyalty_line1 = {text = "I... could I pledge my loyalty to [Master]? For all good you've done to me...", events = ['loyalty'], personalities = ['shy','kind','bold','serious'], reqs = [], weight = 1, tags = []},
	loyalty_line2 = {text = "My body and soul both belong to you, [Master].", events = ['loyalty'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	loyalty_line3 = {text = "[Master]...? P-please, let me stay by your side... ", events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_line4 = {text = "Whats this feeling... I want to stay with [Master]? ", events = ['loyalty'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	
	
	submission_line1 = {text = "I yield, [Master]. Please, I'll do anything...", events = ['submission'], personalities = ['shy','bold','serious','kind'], reqs = [], weight = 1, tags = []},
	submission_line2 = {text = "N-no, please, no more punishments... *sob*", events = ['submission'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	submission_line3 = {text = "I give up... You win... [Master]...", events = ['submission'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	
	
	loyalty_submission_line1 = {text = "[Master]... I understand, I will do as you want.", events = ['submission_loyalty'], personalities = ['shy','bold','serious','kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line2 = {text = "This feels crazy, but I'm ready to do anything for you.", events = ['submission_loyalty'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line3 = {text = "...I-I understand, I will do everything for you.", events = ['submission_loyalty'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	
	writ_success1 = {text = "...This is very kind of you, [master], but please allow me to stay by your side.", events = ['writ_success'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	writ_success2 = {text = "Wow, are you serious about this? But I can't leave you alone, can I. ", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_success3 = {text = "I appreciate this gesture, but my place is at your side, [master]. ", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	
	writ_fail1 = {text = "I... Thank you, but I must go.", events = ['writ_failure'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	writ_fail2 = {text = "Thanks, I guess... I must go now.", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail3 = {text = "This is unexpected... You have my gratitude, but I'm afraid, it won't include my service.", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail4 = {text = "...I'm sorry. ", events = ['writ_failure'], personalities = ['shy','bold','kind','serious'], reqs = [], weight = 1, tags = []},
	
	aphrodisiac1 = {text = "Ah... What's going on... It feels so hot...", events = ['aphrodisiac'], personalities = ['shy','kind','bold','serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac2 = {text = "My body... is getting hotter...", events = ['aphrodisiac'], personalities = ['shy','kind','bold','serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac3 = {text = "AAhhh... What is this... Feeling...", events = ['aphrodisiac'], personalities = ['shy','kind','bold','serious'], reqs = [], weight = 1, tags = []},
	
}

func build_lines():
	for i in individual_lines.values():
		for k in i.events:
			if !lines.has(k):
				lines[k] = []
			lines[k].append(i.duplicate(true))
		

func select_chat_line(character, event, bonus_args):
	var array = []
	for i in lines[event]:
		if i.personalities.has(character.personality) && character.checkreqs(i.reqs) == true:
			if i.has('arg_reqs'):
				for k in i.arg_reqs:
					if k[0] == '!' && bonus_args.has(k[0].replace("!","")) == true:
						continue
					elif bonus_args.has(k[0]) == false:
						continue
			array.append([i.text, i.weight])
	if array.size() > 0:
		var line = input_handler.weightedrandom(array)
		add_new_chatter(character, line)

func return_chat_line(character,event):
	var array = []
	for i in lines[event]:
		if i.personalities.has(character.personality) && character.checkreqs(i.reqs) == true:
			array.append([i.text, i.weight])
	if array.size() > 0:
		return input_handler.weightedrandom(array)
