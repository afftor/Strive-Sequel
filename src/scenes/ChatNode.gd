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
	var newnode = input_handler.DuplicateContainerTemplate($VBoxContainer)
	var data = {name = character.get_short_name(), text = character.translate(line), time = str(ResourceScripts.game_globals.date) + "-" + str(ResourceScripts.game_globals.hour) + ":00"}
	newnode.get_node("Icon").texture = character.get_icon()
	newnode.get_node("Text").text = data.text
	newnode.get_node("Name").text = data.name
	ResourceScripts.core_animations.UnfadeAnimation(newnode,0.3)
	input_handler.PlaySound("chat_click")
	storedlines.append(data)
	yield(get_tree().create_timer(10),"timeout")
	ResourceScripts.core_animations.FadeAnimation(newnode, 1)
	yield(get_tree().create_timer(1),"timeout")
	newnode.hide()


var personalities = {
	shy = {},
	bold = {},
	kind = {},
	serious = {},
}

var lines = {
}

var individual_lines = {
#	hire_line1 = {text = "...Pleased to meet you, [Master].", events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},#tags: oneshot (1 time use per game), outweight (will always be presented if is in pool)
	hire_line1 = {text = "...Pleased to meet you, [Master].", events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	hire_line2 = {text = "Please, take care of me, [Master].", events = ['hire'], personalities = ['shy', 'serious', 'kind'], reqs = [], weight = 1, tags = []},
	hire_line3 = {text = "So you are my new [Master]! Pleased to meet you!", events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line4 = {text = "I hope you aren't taking me just for lewd affairs.", events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line5 = {text = "Ah, yes... I-it's a pleasure to meet you, [Master]!", events = ['hire'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	hire_line6 = {text = "So you're my new [Master] huh? You don't look that impressive to me.", events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line7 = {text = "Great. Let's get out of here. Can't wait to see my new place!", events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line8 = {text = "You look like a lot of fun. Let's get going, [Master]. My talents are wasted here anyways.", events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line9 = {text = "We going, or what, [Master]?", events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line10 = {text = "About time! Thought I'd never get out of here. Let's go, [Master]!", events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line11 = {text = "Oh my... I'm so honored to be of service, [Master]. I hope to serve you well.", events = ['hire'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	hire_line12 = {text = "I will gladly entrust myself to you, [Master].", events = ['hire'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	hire_line13 = {text = "I'm so excited! I can't wait to show what I can do for you,[Master]!", events = ['hire'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	hire_line14 = {text = "Secretly... I hoped you would pick me. I won't disappoint you, [Master].", events = ['hire'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	hire_line15 = {text = "I shall take good care of you, [Master]. If you would do the same?", events = ['hire'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	hire_line16 = {text = "Indeed. A wise choice, [Master]. Let us take our leave.", events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line17 = {text = "Oh? I suppose this will be a learning experience. Wouldn't you agree, [Master]?", events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line18 = {text = "I see they sent someone worthy of my talents. Let us quit this place [Master].", events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line19 = {text = "Hmm? Ahh... Sorry. You're my new [Master] correct? Please do not use me for your perversions.", events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line20 = {text = "I suppose it can't be helped. My skills are yours, [Master].", events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line21 = {text = "M-me? I mean... if you're sure about this, [Master]...", events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	hire_line22 = {text = "O-oh! I thought no one would take me... I'll do my best...", events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	hire_line23 = {text = "Pleased to meet you. I hope I don't get in your way, [Master]...", events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	hire_line24 = {text = "W-wow... You look really strong, [Master]... Please look after me.", events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	hire_line25 = {text = "Y-you're not going to take advantage of me... Are you [Master]?", events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	
	slavery_line1 = {text = "You... made me into a slave? No... *sob*", events = ['enslave'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	slavery_line2 = {text = "Why have you done this!?", events = ['enslave'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	slavery_line3 = {text = "Why...? *sob*", events = ['enslave'], personalities = ['shy','kind','serious'], reqs = [], weight = 1, tags = []},
	slavery_line4 = {text = "This is despicable! I'll not take it!", events = ['enslave'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	slavery_line5 = {text = "How could you?! I hate you!", events = ['enslave'], personalities = ['serious','bold','kind','shy'], reqs = [], weight = 0.5, tags = []},
	slavery_line6 = {text = "I-I see... Maybe it's better this way...?", events = ['enslave'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	slavery_line7 = {text = "I knew this would happen to me...", events = ['enslave'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	slavery_line8 = {text = "Why did I ever trust you!?", events = ['enslave'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	slavery_line9 = {text = "Was it something I did? Please... How could you?", events = ['enslave'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	slavery_line10 = {text = "I-I guess this was my true purpose after all...", events = ['enslave'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	slavery_line11 = {text = "Though I'm not quite happy about this. I shall serve you like I always have...", events = ['enslave'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	slavery_line12 = {text = "Was I not good enough for you...?", events = ['enslave'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	slavery_line13 = {text = "Please Tell me you're not serious... why...?", events = ['enslave'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	slavery_line14 = {text = "Just when I was growing fond of you...", events = ['enslave'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	slavery_line15 = {text = "I suppose... this is still better than parting...", events = ['enslave'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	slavery_line16 = {text = "I knew you had lecherousintentions the moment I laid my eyes on you.", events = ['enslave'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	slavery_line17 = {text = "How utterly revolting.", events = ['enslave'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	slavery_line18 = {text = "Have you no sense of decency?", events = ['enslave'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	slavery_line19 = {text = "To think my life lead to this...", events = ['enslave'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	slavery_line20 = {text = "Tsk. I won't forgive you for this.", events = ['enslave'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	slavery_line21 = {text = "How dare you do this to me!?", events = ['enslave'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	slavery_line22 = {text = "You jerk! If only I was stronger!", events = ['enslave'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	slavery_line23 = {text = "I don't like this, or you!", events = ['enslave'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	slavery_line24 = {text = "You think you're so tough now huh!?", events = ['enslave'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	slavery_line25 = {text = "So cruel! I won't do anything for you!", events = ['enslave'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	
	experience_line1 = {text = "I've learned so much recently... I think I'm ready for bigger things!", events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line2 = {text = "My skills have grown. ", events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line3 = {text = "I feel like I've learned a lot... what do you think, [Master]?", events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line5 = {text = "Um, [Master], I think I can learn something new to be useful to you...", events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line6 = {text = "[Master], with all experience I got, I'm sure I can be more useful to you.", events = ['exp_for_level'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	experience_line61 = {text = "Isn't this wonderful [Master]? I hope to make myself even better for you.", events = ['exp_for_level'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	experience_line7 = {text = "[Master]! I've learned a lot from you. Maybe it's time to learn new things?", events = ['exp_for_level'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	experience_line8 = {text = "Oh! I think I have the hang of this! Thank you for teaching me!", events = ['exp_for_level'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	experience_line9 = {text = "Wow! I feel so energized! I'm ready to learn even more!", events = ['exp_for_level'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	experience_line10 = {text = "Thank you for being so patient with me [Master]! I feel stronger already!", events = ['exp_for_level'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	experience_line11 = {text = "Hmm? I suppose I should dabble in other skills.", events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line12 = {text = "Already? Seems I'm quite the natural.", events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line13 = {text = "Ahh... I think it's time to learn new things.", events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line14 = {text = "It's only natural for me to progress so elegantly.", events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line15 = {text = "Oh. [Master]. I have aquired new talents.", events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line16 = {text = "Getting better, and better every day!", events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line17 = {text = "You see this, [Master]? Aren't I great?", events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line18 = {text = "Ha! pretty soon I'll be stronger than you, [Master]", events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line19 = {text = "Yeah... I'm pretty great, but I'm about to be even greater!", events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line20 = {text = "Looks like I'm ready to learn even more!", events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line21 = {text = "O-oh... [Master]. I think I'm ready to learn new things...", events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line22 = {text = "I-I see... I think I can learn more now...", events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line23 = {text = "[Master]. I think my skills are improving...", events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line24 = {text = "So that's how it's done... I think I get it now...", events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line25 = {text = "Right... maybe I am getting better?", events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	
	item_created_line1 = {text = "That's finally done...", events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line2 = {text = "I've done it, [Master].", events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line3 = {text = "That thing you asked to make, [Master]...", events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line4 = {text = "Here, [Master], I've done my best.", events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line5 = {text = "Seriously, [Master]? Can you give me a real challenge?", events = ['item_created'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	item_created_line6 = {text = "Yeah Yeah... It's done.", events = ['item_created'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	item_created_line7 = {text = "This is too easy!", events = ['item_created'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	item_created_line8 = {text = "I could do this all day!", events = ['item_created'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	item_created_line9 = {text = "Another one for the collection!", events = ['item_created'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	item_created_line10 = {text = "Flawless... As usual.", events = ['item_created'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	item_created_line11 = {text = "Finished with this one, [Master].", events = ['item_created'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	item_created_line12 = {text = "Here we are... Finished.", events = ['item_created'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	item_created_line13 = {text = "Ahh. Such a simple design.", events = ['item_created'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	item_created_line14 = {text = "Hmm? I suppose it's ready.", events = ['item_created'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	item_created_line15 = {text = "Look, [Master]! It's finished!", events = ['item_created'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	item_created_line16 = {text = "Such fun! It came out great!", events = ['item_created'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	item_created_line17 = {text = "Here you go. All done!", events = ['item_created'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	item_created_line18 = {text = "This will make, [Master] happy! ", events = ['item_created'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	item_created_line19 = {text = "Finished just in time!", events = ['item_created'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	item_created_line20 = {text = "I-I hope it came out okay...", events = ['item_created'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	item_created_line21 = {text = "I-It's finished, [Master]...", events = ['item_created'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	item_created_line22 = {text = "Oh... That was really hard to make.", events = ['item_created'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	item_created_line23 = {text = "H-how did I manage it...?", events = ['item_created'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	item_created_line24 = {text = "All done...", events = ['item_created'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	
	combat_win_line1 = {text = "Phew, we did it, [Master]...", events = ['combat_won'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	combat_win_line2 = {text = "Hah, piece of cake. Who's next?", events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line3 = {text = "Well fought. Lets move on, [Master]. ", events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line4 = {text = "I'm glad we won, but let's keep cautious. ", events = ['combat_won'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	combat_win_line5 = {text = "Hah, I didn't even break a sweat.", events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line6 = {text = "That was really scary. I hope there's not more of them...", events = ['combat_won'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	combat_win_line7 = {text = "I... Can't believe we won...", events = ['combat_won'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	combat_win_line8 = {text = "A-and don't come back...", events = ['combat_won'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	combat_win_line9 = {text = "I hope I helped...", events = ['combat_won'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	combat_win_line10 = {text = "T-they made us do it...", events = ['combat_won'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	combat_win_line11 = {text = "We've dealt a decisive blow.", events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line12 = {text = "Was that all they could muster?", events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line13 = {text = "A feeble struggle. Barely worth the effort.", events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line14 = {text = "Let's move on.", events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line15 = {text = "A fight barely worth mentioning.", events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line16 = {text = "That's what you get!", events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line17 = {text = "Shouldn't have challenged me!", events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line18 = {text = "Done already!?", events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line19 = {text = "Damn! I wanted to fight some more.", events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line20 = {text = "Pathetic. Why even bother attacking?", events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line21 = {text = "I hope they're okay...", events = ['combat_won'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	combat_win_line22 = {text = "Is everyone alright?", events = ['combat_won'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	combat_win_line23 = {text = "Why did we have to fight?", events = ['combat_won'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	combat_win_line24 = {text = "We couldn't talk this out...?", events = ['combat_won'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	combat_win_line25 = {text = "Let's hope we don't have to fight again...", events = ['combat_won'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	
	sex_start_line1 = {text = "Um... you really want me to do this? I'm not sure I'm ready...", events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_start_line2 = {text = "You want me for lewd things, [Master]...", events = ['sex_start'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	sex_start_line3 = {text = "I'm not too eager for this, but if you insist.", events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line4 = {text = "Hmh, leering over my body, [Master]?", events = ['sex_start'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	sex_start_line5 = {text = "Alright, if you want me...", events = ['sex_start'], personalities = ['bold','serious','kind'], reqs = [], weight = 1, tags = []},
	sex_start_line6 = {text = "I...like being with you, [Master]...", events = ['sex_start','sex_finish'], personalities = ['bold','kind','serious','shy'], reqs = [], weight = 5, tags = [], arg_reqs = ['partner_is_master']},
	sex_start_line7 = {text = "Ugh... Really? Fine, but you better not be gentle!", events = ['sex_start'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_start_line8 = {text = "I knew you were lusting over me!", events = ['sex_start'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_start_line9 = {text = "Don't think I'm easy, or anything. I need relief too you know.", events = ['sex_start'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_start_line10 = {text = "What's the hold up? Let's get to it!", events = ['sex_start'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_start_line11 = {text = "Looks like we were both thinking the same thing!", events = ['sex_start'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_start_line12 = {text = "Let me tend to your every need.", events = ['sex_start'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_start_line13 = {text = "I've been waiting for you.", events = ['sex_start'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_start_line14 = {text = "Let's make this fun for the both of us.", events = ['sex_start'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_start_line15 = {text = "Oh my... I can hardly contain myself!", events = ['sex_start'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_start_line16 = {text = "These intimate moments make it all the better.", events = ['sex_start'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_start_line17 = {text = "Hmm? I suppose we could use a break.", events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line18 = {text = "Ahh... Indulging yourself with me are you?", events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line19 = {text = "You've chosen me have you?", events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line20 = {text = "I have been thinking about this all day...", events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line21 = {text = "Keeping composure around you is... difficult.", events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line22 = {text = "M-me? I hope I can sate your desires...", events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_start_line23 = {text = "P-please spend time with me. I'll do anything...", events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_start_line24 = {text = "O-oh? You want me for your... needs?", events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_start_line25 = {text = "I-I'll do my best to serve you...", events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_start_line26 = {text = "M-my body is yours... Please be gentle...", events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	
	sex_finish_line1 = {text = "...I-I'm not against doing it again.", events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line3 = {text = "Ahh, it feels like a waste to work after this.", events = ['sex_finish'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line4 = {text = "Uh, my body is all sweaty now... Can I take a bath, [Master]?", events = ['sex_finish'], personalities = ['serious','shy','kind'], reqs = [], weight = 1, tags = []},
	sex_finish_line5 = {text = "I'll be sore for awhile, but it was worth it.", events = ['sex_finish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_finish_line6 = {text = "Done already!? I wanted to go all night!", events = ['sex_finish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_finish_line7 = {text = "That's exactly what I needed!", events = ['sex_finish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_finish_line8 = {text = "Don't think for a second that this means I like you.", events = ['sex_finish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_finish_line9 = {text = "What a workout!", events = ['sex_finish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_finish_line10 = {text = "That was wonderful.", events = ['sex_finish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_finish_line11 = {text = "I've never felt such pleasure.", events = ['sex_finish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_finish_line12 = {text = "Was it good for you?", events = ['sex_finish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_finish_line13 = {text = "We should do this more often.", events = ['sex_finish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_finish_line14 = {text = "I want to stay in bed longer with you.", events = ['sex_finish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_finish_line15 = {text = "Such primitive pleasures...", events = ['sex_finish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line16 = {text = "Hnn... Perhaps this is better than I thought.", events = ['sex_finish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line17 = {text = "My my... quite the capable lover aren't you?", events = ['sex_finish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line18 = {text = "Perhaps we should do this again sometime...", events = ['sex_finish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line19 = {text = "That was... pleasant to say the least...", events = ['sex_finish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line20 = {text = "Could we... do this again sometime?", events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line21 = {text = "Can we cuddle a bit...?", events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line22 = {text = "That felt... really good.", events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line23 = {text = "O-oh... it's over?", events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line24 = {text = "I-I hope that I was okay...", events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	
	master_praise_line1 = {text = "I've got praised by [Master]... It makes me happy", events = ['master_praise'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	master_praise_line2 = {text = "I've earned it, haven't I, [Master]?", events = ['master_praise'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	master_praise_line3 = {text = "O-oh! Thank you, [Master]. I'm glad I could make you happy...", events = ['master_praise'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_praise_line4 = {text = "I.... I did do good... right, [Master]?", events = ['master_praise'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_praise_line5 = {text = "B-being praised by [Master]... ", events = ['master_praise'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_praise_line6 = {text = "T-thank you. I've been trying my best, [Master].", events = ['master_praise'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_praise_line7 = {text = "It was nothing... really...", events = ['master_praise'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_praise_line8 = {text = "About time I got recognized!", events = ['master_praise'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_praise_line9 = {text = "Yeah yeah... I know I'm great.", events = ['master_praise'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_praise_line10 = {text = "Please. It was nothing, [Master].", events = ['master_praise'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_praise_line11 = {text = "Keep the praises coming, [Master]!", events = ['master_praise'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_praise_line12 = {text = "Who's the best? I'm the best!", events = ['master_praise'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_praise_line13 = {text = "It's nice to be noticed once in awhile.", events = ['master_praise'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_praise_line14 = {text = "Hmm? Oh. You're quite welcome, [Master].", events = ['master_praise'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_praise_line15 = {text = "Are you trying to butter me up, [Master]?", events = ['master_praise'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_praise_line16 = {text = "Ahh... it was nothing. ", events = ['master_praise'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_praise_line17 = {text = "Honeyed words won't sway me, [Master]... But thank you.", events = ['master_praise'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_praise_line18 = {text = "I'm glad to be of service!", events = ['master_praise'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_praise_line19 = {text = "Thank you, [Master]! I won't disappoint you!", events = ['master_praise'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_praise_line20 = {text = "Stop it , [Master]. You're making me blush.", events = ['master_praise'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_praise_line21 = {text = "Wow! I didn't think you thought so highly of me!", events = ['master_praise'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_praise_line22 = {text = "I'll make sure to keep this up! Just for you, [Master].", events = ['master_praise'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	
	master_punish_line1 = {text = "Sorry, I'll be good, [Master]...", events = ['master_punish','date_punish_light','date_punish_heavy'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	master_punish_line2 = {text = "Ugh... it really hurts, [Master].", events = ['master_punish','date_punish_light','date_punish_heavy'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	master_punish_line3 = {text = "I understand... this is for the order.", events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_punish_line4 = {text = "Hmh! Just so you know, it didn't hurt at all!", events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_punish_line5 = {text = "No... Take pity of a kitty!", events = ['master_punish'], personalities = ['bold','kind','serious','shy'], reqs = [{code = 'one_of_races', value = ['HalfkinCat','BeastkinCat']}], weight = 0.01, tags = []},
	master_punish_line6 = {text = "I'm so sorry... I know I can do better, [Master]...", events = ['master_punish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_punish_line7 = {text = "I didn't mean to upset you. I'm sorry [Master].", events = ['master_punish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_punish_line8 = {text = "[Master]? Is this really necessary?", events = ['master_punish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_punish_line9 = {text = "If this is to make me better... than I accept, [Master].", events = ['master_punish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_punish_line10 = {text = "Ow... Why are you doing this to me, [Master]?", events = ['master_punish','date_punish_light'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_punish_line11 = {text = "Like I need you to tell me I screwed up, [Master].", events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_punish_line12 = {text = "Why am I letting this happen?", events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_punish_line13 = {text = "I'll remember this...", events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_punish_line14 = {text = "Almost felt good for a second there, [Master].", events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_punish_line15 = {text = "Really? is that all you got, [Master]?", events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_punish_line16 = {text = "D-did I do something wrong, [Master]?", events = ['master_punish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_punish_line17 = {text = "I-it's all my fault... isn't it?", events = ['master_punish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_punish_line18 = {text = "I-I should have done better... Sorry...", events = ['master_punish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_punish_line19 = {text = "T-that sort of felt... good...", events = ['master_punish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_punish_line20 = {text = "I w-wont do it again. I promise, [Master]...", events = ['master_punish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_punish_line21 = {text = "I see you're not above primitive punishments...", events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_punish_line22 = {text = "Really? For what, [Master]?", events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_punish_line23 = {text = "I suppose this is the right course for my failures...", events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_punish_line24 = {text = "[Master]? Ahh I see... It will be a lesson not soon forgotten...", events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_punish_line25 = {text = "I'll feel that sting for quite awhile...", events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	
	master_abuse_line1 = {text = "Why... *sob*", events = ['abuse','date_punish_light'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line2 = {text = "This is horrible... You are horrible!", events = ['abuse'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	master_abuse_line3 = {text = "Ah! Please, not the ears!", events = ['abuse'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line4 = {text = "Please... no more...", events = ['abuse','date_punish_light','date_punish_heavy'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line5 = {text = "What have I done to deserve this, [Master]? *sob*", events = ['abuse','date_punish_heavy'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line6 = {text = "No! Stop! That really hurts!", events = ['abuse','date_punish_light','date_punish_heavy'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line7 = {text = "Why are you so mean to me!?", events = ['abuse','date_punish_light','date_punish_heavy'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line8 = {text = "Why do I even try to please you!?", events = ['abuse'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line9 = {text = "*sobs* That's okay... I know you still care, [Master]...", events = ['abuse'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line10 = {text = "W-why are you so mean, [Master]...?", events = ['abuse','date_punish_light'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line11 = {text = "S-should I... just accept this?", events = ['abuse'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line12 = {text = "I-it hurts so much...", events = ['abuse','date_punish_light','date_punish_heavy'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line13 = {text = "I-I guess this is all I'm good for...", events = ['abuse'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line14 = {text = "P-please don't let anyone see this...", events = ['abuse'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line15 = {text = "How dare you!? Let me go!", events = ['abuse','date_punish_light'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_abuse_line16 = {text = "One of these days I'll get you back for this!", events = ['abuse'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_abuse_line17 = {text = "Damn! my cheeks stings so much...", events = ['abuse'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_abuse_line18 = {text = "You're lucky you're not the one in this position...", events = ['abuse'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_abuse_line19 = {text = "Gah! don't think you've bested me..", events = ['abuse'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_abuse_line20 = {text = "Careful... This is too much, [Master]...", events = ['abuse'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_abuse_line21 = {text = "This has simply gone out of hand.", events = ['abuse'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_abuse_line22 = {text = "How dare you do this to me?", events = ['abuse'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_abuse_line23 = {text = "Ow... I'll be feeling that for weeks...", events = ['abuse'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_abuse_line24 = {text = "I should have known you have a temper...", events = ['abuse','date_punish_light'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	
	sex_reward_line1 = {text = "Such reward? There's no... Ah...", events = ['sexreward'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line2 = {text = "[Master]? *gulp* I haven't really asked for this...", events = ['sexreward'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line3 = {text = "A lewd reward?.. Huh, fine, I could use a break.", events = ['sexreward'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	sex_reward_line4 = {text = "Finally! It's about time you take care of my needs.", events = ['sexreward'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_reward_line5 = {text = "Ugh. I guess I did need a bit of relief.", events = ['sexreward'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_reward_line6 = {text = "This just some excuse for you to have your way with me?", events = ['sexreward'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_reward_line7 = {text = "Fine... Guess I did kind of need this right now.", events = ['sexreward'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_reward_line8 = {text = "Guess we're both in a mood huh?", events = ['sexreward'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_reward_line9 = {text = "Ahh. I quite needed that. Thank you.", events = ['sexreward'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_reward_line10 = {text = "If you would be so kind. I have been feeling in need...", events = ['sexreward'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_reward_line11 = {text = "I suppose I have been tense lately...", events = ['sexreward'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_reward_line12 = {text = "Oh my... I will gladly enjoy this.", events = ['sexreward'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_reward_line13 = {text = "Don't tell the others of this...", events = ['sexreward'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_reward_line14 = {text = "Please? I really need this...", events = ['sexreward'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line15 = {text = "Thank you so much! I knew I could rely on you for this.", events = ['sexreward'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line16 = {text = "I was just thinking about you, and got all excited...", events = ['sexreward'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line17 = {text = "Great, but you better let me take care of you after...", events = ['sexreward'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line18 = {text = "You're the best! I really wanted help with this...", events = ['sexreward'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line19 = {text = "M-me? Really? Okay...", events = ['sexreward'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_reward_line20 = {text = "I-I didn't want anyone to notice...", events = ['sexreward'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_reward_line21 = {text = "P-please don't tell anyone...", events = ['sexreward'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_reward_line22 = {text = "Haaaa... I can't resist you...", events = ['sexreward'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_reward_line23 = {text = "O-oh... D-do I have to beg?", events = ['sexreward'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	
	loyalty_line1 = {text = "I... could I pledge my loyalty to [Master]? For all good you've done to me...", events = ['loyalty'], personalities = ['shy','kind','bold','serious'], reqs = [], weight = 1, tags = []},
	loyalty_line2 = {text = "My body and soul both belong to you, [Master].", events = ['loyalty'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	loyalty_line3 = {text = "[Master]...? P-please, let me stay by your side... ", events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_line4 = {text = "What’s this feeling... I want to stay with [Master]? ", events = ['loyalty'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	loyalty_line5 = {text = "Don't get any funny ideas. I just like it here is all!", events = ['loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_line6 = {text = "You're not so bad after all, [Master]!", events = ['loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_line7 = {text = "Ha! Guess I need you just as much as you need me.", events = ['loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_line8 = {text = "I guess following your orders isn't so bad after all!", events = ['loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_line9 = {text = "You must have done something to me! There's no way I should like you this much.", events = ['loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_line10 = {text = "A worthy [Master] to serve. It's a pleasure.", events = ['loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_line11 = {text = "It would seem I've grown fond of you, [Master].", events = ['loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_line12 = {text = "I knew this day was to come. I can't find any reason to leave.", events = ['loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_line13 = {text = "I wish to continue serving you, [Master]. Indefinitely.", events = ['loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_line14 = {text = "My mind is filled with nothing but thoughts of serving you. A strange feeling indeed.", events = ['loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_line15 = {text = "I just knew I would love it here, [Master]!", events = ['loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_line16 = {text = "Please don't let this be a dream. I really like you, [Master]!", events = ['loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_line17 = {text = "I get to stay with [Master], and serve them!", events = ['loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_line18 = {text = "I'm so glad I can serve you, [Master]!", events = ['loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_line19 = {text = "No way... Could it be that I've fallen for you, [Master]?", events = ['loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_line20 = {text = "Please don't ever make me leave... I really want to stay here, [Master]...", events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_line21 = {text = "I-I want to do the best I can to serve [Master]...", events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_line22 = {text = "O-oh... I just feel so safe around you, [Master]...", events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_line23 = {text = "Hmm? Why do I feel so... compelled to serve [Master]?", events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_line24 = {text = "Ahh... I j-just want to say that I'm here for you, [Master]", events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	
	submission_line1 = {text = "I yield, [Master]. Please, I'll do anything...", events = ['submission'], personalities = ['shy','bold','serious','kind'], reqs = [], weight = 1, tags = []},
	submission_line2 = {text = "N-no, please, no more punishments... *sob*", events = ['submission'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	submission_line3 = {text = "I give up... You win... [Master]...", events = ['submission'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	submission_line4 = {text = "Damn it... Fine... I'll obey you, [Master].", events = ['submission'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	submission_line5 = {text = "Okay! no more! I'll be good.", events = ['submission'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	submission_line6 = {text = "I don't have enough strength to defy you anymore... [Master]", events = ['submission'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	submission_line7 = {text = "So this is my life now huh?", events = ['submission'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	submission_line8 = {text = "You've won. I can't fight you anymore, [Master].", events = ['submission'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	submission_line9 = {text = "Such vulgar discipline. Though I can't fight it any longer...", events = ['submission'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	submission_line10 = {text = "As you wish. I won't challenge your words any longer, [Master].", events = ['submission'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	submission_line11 = {text = "There's not an ounce of strength left in me. I submit.", events = ['submission'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	submission_line12 = {text = "You have broken my will, along with my body, [Master]. I yield.", events = ['submission'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	submission_line13 = {text = "To think I once thought I would have a much brighter future...", events = ['submission'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	submission_line14 = {text = "Though you treated me poorly... I will serve you as always, [Master]", events = ['submission'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	submission_line15 = {text = "I simply wished to serve you, but... not like this...", events = ['submission'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	submission_line16 = {text = "Deep down I know you're a nice person, [Master]...", events = ['submission'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	submission_line17 = {text = "I can't bare this torture any longer. I'll do anything you want, [Master]", events = ['submission'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	submission_line18 = {text = "I'll do my best... to stay on your good side, [Master]...", events = ['submission'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	submission_line19 = {text = "I-I guess this is all someone like me could ever hope for.", events = ['submission'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	submission_line20 = {text = "If only I were better... Maybe It wouldn't be like this.", events = ['submission'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	submission_line21 = {text = "M-maybe this is better? Just to follow my [Master]'s orders...", events = ['submission'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	submission_line22 = {text = "O-oh... I guess this is better than nothing...", events = ['submission'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	submission_line23 = {text = "O-odly enough. This is... comforting? ", events = ['submission'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	
	loyalty_submission_line1 = {text = "[Master]... I understand, I will do as you want.", events = ['submission_loyalty'], personalities = ['shy','bold','serious','kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line2 = {text = "This feels crazy, but I'm ready to do anything for you.", events = ['submission_loyalty'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line3 = {text = "...I-I understand, I will do everything for you.", events = ['submission_loyalty'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line4 = {text = "I understand, [Master]... I just hope I can be of use to you...", events = ['submission_loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line5 = {text = "I-I will devote everything to you, [Master]...", events = ['submission_loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line6 = {text = "I-I'll do anything you ask, [Master]... Honest!", events = ['submission_loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line7 = {text = "M-my new life with [Master] begins today...", events = ['submission_loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line8 = {text = "This is all I could have ever hoped for...", events = ['submission_loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line9 = {text = "I just want to do everything for you, [Master]!", events = ['submission_loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line10 = {text = "[Master] is the greatest! I never ever want to leave.", events = ['submission_loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line11 = {text = "I truly wish to be nothing but the best for you, [Master]", events = ['submission_loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line12 = {text = "I can't see myself anywhere else, but at [Master]'s side.", events = ['submission_loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line13 = {text = "If only others could see how truly wonderful you are, [Master].", events = ['submission_loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line14 = {text = "I pledge my eternal loyalty to you, [Master].", events = ['submission_loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line15 = {text = "You needn't ask, [Master]. Your will shall be done.", events = ['submission_loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line16 = {text = "I knew I made the right choice in coming here.", events = ['submission_loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line17 = {text = "A true [Master] know when to use charm as well as an iron fist.", events = ['submission_loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line18 = {text = "Will that be all? You can always count on me to do your bidding.", events = ['submission_loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line19 = {text = "Yeah! I'll do anything you say!", events = ['submission_loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line20 = {text = "I knew you would want to keep me around [Master]!", events = ['submission_loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line21 = {text = "Leave it to me, [Master]! I won't let you down.", events = ['submission_loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line22 = {text = "Surprisingly enough... I'm okay with you being my [Master].", events = ['submission_loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line23 = {text = "Gah! Fine! I'll do anything you want, [Master].", events = ['submission_loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	
	writ_success1 = {text = "...This is very kind of you, [master], but please allow me to stay by your side.", events = ['writ_success'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	writ_success2 = {text = "Wow, are you serious about this? But I can't leave you alone, can I. ", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_success3 = {text = "I appreciate this gesture, but my place is at your side, [master]. ", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_success4 = {text = "I... I don't think I can make it out on my own... Please let me stay, [Master]...", events = ['writ_success'], personalities = ['Shy'], reqs = [], weight = 1, tags = []},
	writ_success5 = {text = "C-can I stay here? Please...?", events = ['writ_success'], personalities = ['Shy'], reqs = [], weight = 1, tags = []},
	writ_success6 = {text = "R-really? Me? are you sure? I just want to be with you...", events = ['writ_success'], personalities = ['Shy'], reqs = [], weight = 1, tags = []},
	writ_success7 = {text = "I-I can't see myself anywhere except by your side, [Master]...", events = ['writ_success'], personalities = ['Shy'], reqs = [], weight = 1, tags = []},
	writ_success8 = {text = "Please... Let me stay here with you...", events = ['writ_success'], personalities = ['Shy'], reqs = [], weight = 1, tags = []},
	writ_success9 = {text = "Freedom means nothing if I can't be with you, [Master].", events = ['writ_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_success10 = {text = "So nice of you to do this for me, but... I want to stay.", events = ['writ_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_success11 = {text = "That's so nice of you, but I want to stay here.", events = ['writ_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_success12 = {text = "I like it here, [Master]. I don't want to leave your side.", events = ['writ_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_success13 = {text = "Your heart is in the right place, and so am I. I'll stay here with you.", events = ['writ_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_success14 = {text = "Thank you, [Master], but my place is here with you.", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_success15 = {text = "Freedom? What makes you think my being here isn't enjoyed?", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_success16 = {text = "I see... Never the less. I belong here.", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_success17 = {text = "Fate brought us together, and though you grant me freedom. My place is here.", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_success18 = {text = "My staying here would benefit us both, no?", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_success19 = {text = "No way! I'm staying right here!", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_success20 = {text = "Setting me free? Not going to happen. you need me!", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_success21 = {text = "What!? Freeing me? What's the big idea!? I'm staying put!", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_success22 = {text = "Just don't think I owe you anything, but I'll stay with you", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_success23 = {text = "If this is some sort of trick... I'm keeping a close eye on you...", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	
	writ_fail1 = {text = "I... Thank you, but I must go.", events = ['writ_failure'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	writ_fail2 = {text = "Thanks, I guess... I must go now.", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail3 = {text = "This is unexpected... You have my gratitude, but I'm afraid, it won't include my service.", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail4 = {text = "...I'm sorry. ", events = ['writ_failure'], personalities = ['shy','bold','kind','serious'], reqs = [], weight = 1, tags = []},
	writ_fail5 = {text = "Though I do appreciate what you've done for me.. I must part ways.", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail6 = {text = "Thank you. Do take care of yourself.", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail7 = {text = "I see. Perhaps we will meet again...", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail8 = {text = "I owe you a great debt. One that I can't repay with my service.", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail9 = {text = "I'm overjoyed, but... this isn't where I belong.", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail10 = {text = "Thanks, but I've got better places to be.", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail11 = {text = "Freeing me are you? Guess you're not too bad after all. See you later.", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail12 = {text = "Oh? Don't think for a second That I'm staying here with you.", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail13 = {text = "Yeah yeah... Thanks, but I'm gone.", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail14 = {text = "Ha! Guess I'm finally free from all this!", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail15 = {text = "T-thank you, but my family must be really worried. I have to go...", events = ['writ_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	writ_fail16 = {text = "I-I'm sorry... you've been so nice, but I have to go.", events = ['writ_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	writ_fail17 = {text = "D-don't take it personally... I'm just not ready to stay here.", events = ['writ_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	writ_fail18 = {text = "Oh... So I can go then? Thank you...", events = ['writ_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	writ_fail19 = {text = "Phew... I guess I can finally leave...", events = ['writ_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	writ_fail20 = {text = "Thank you so much for this! I'll pay you back someday!", events = ['writ_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_fail21 = {text = "Such a kind heart, but I can't stay.", events = ['writ_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_fail22 = {text = "I'm so greatful! I'll miss you greatly!", events = ['writ_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_fail23 = {text = "How wonderful! Please understand that I have to leave your side...", events = ['writ_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_fail24 = {text = "Ahh! I'm so happy! I'll be sure to write you once in awhile!", events = ['writ_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	
	recruit_success5 = {text = "I-if you would have me....", events = ['recruit_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_success6 = {text = "R-really? Me? are you sure? Okay...", events = ['recruit_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_success7 = {text = "I don't know how much help I'll be, but... I'll join you.", events = ['recruit_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_success8 = {text = "M-maybe... this is for the best?", events = ['recruit_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_success9 = {text = "You want me to join you? I would be delighted!", events = ['recruit_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_success10 = {text = "I only hope to serve you well.", events = ['recruit_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_success11 = {text = "Guess it's my turn to help you now, [Master]!", events = ['recruit_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_success12 = {text = "I'll pack my things as soon as possible.", events = ['recruit_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_success13 = {text = "Oh! I'm so excited to see my new home!", events = ['recruit_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_success14 = {text = "I suppose this should prove advantageous for the both of us.", events = ['recruit_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_success15 = {text = "I can't see a reason to decline.", events = ['recruit_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_success16 = {text = "Let us part this place together, [Master].", events = ['recruit_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_success17 = {text = "Seems that fate has brought us together for a reason.", events = ['recruit_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_success18 = {text = "Might as well join forces. Would benefit us both, no?", events = ['recruit_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_success19 = {text = "Fine, but only because you seem strong enough.", events = ['recruit_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_success20 = {text = "Saw the potential in me did you? let's go.", events = ['recruit_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_success21 = {text = "I hope you exceed my expectations.", events = ['recruit_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_success22 = {text = "Just don't think I owe you anything, but I'll join you.", events = ['recruit_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_success23 = {text = "Ha! I knew you would need someone like me!", events = ['recruit_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	
	
	
	recruit_fail5 = {text = "Though I do appreciate the offer. I must respectfully decline... Do take care of yourself.", events = ['recruit_fail'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_fail6 = {text = "I don't think I'm quite ready to make such a commitment.", events = ['recruit_fail'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_fail7 = {text = "Sorry. I don't think I can join you at this time.", events = ['recruit_fail'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_fail8 = {text = "Perhaps you should seek aid elsewhere?", events = ['recruit_fail'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_fail9 = {text = "Apologies. I can't join your cause.", events = ['recruit_fail'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_fail10 = {text = "What? No way! why would I ever join you?", events = ['recruit_fail'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_fail11 = {text = "There's no way I'd join someone on a whim.", events = ['recruit_fail'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_fail12 = {text = "Oh please... Like I would leave my home behind for you.", events = ['recruit_fail'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_fail13 = {text = "Don't even think about it. I'm leaving.", events = ['recruit_fail'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_fail14 = {text = "Thanks, but no thanks. I'm fine on my own.", events = ['recruit_fail'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_fail15 = {text = "Uhm... I'm sorry... I just can't.", events = ['recruit_fail'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_fail16 = {text = "I-I don't really trust you... sorry...", events = ['recruit_fail'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_fail17 = {text = "D-don't take it personally... I'm just not ready for this...", events = ['recruit_fail'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_fail18 = {text = "Y-you can find someone better. I know it...", events = ['recruit_fail'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_fail19 = {text = "P-please. I don't want to go with you...", events = ['recruit_fail'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_fail20 = {text = "You seem really nice, but I just can't. Sorry.", events = ['recruit_fail'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_fail21 = {text = "There's too much I have to do. Please understand.", events = ['recruit_fail'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_fail22 = {text = "A tempting offer, but I just can't.", events = ['recruit_fail'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_fail23 = {text = "I wish you luck on your travels, but I can't come with you.", events = ['recruit_fail'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_fail24 = {text = "Maybe if we meet again, but not right now.", events = ['recruit_fail'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	
	aphrodisiac1 = {text = "Ah... What's going on... It feels so hot...", events = ['aphrodisiac'], personalities = ['shy','kind','bold','serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac2 = {text = "My body... is getting hotter...", events = ['aphrodisiac'], personalities = ['shy','kind','bold','serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac3 = {text = "AAhhh... What is this... Feeling...", events = ['aphrodisiac'], personalities = ['shy','kind','bold','serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac4 = {text = "Hnnn... you better take responsibility for this...", events = ['aphrodisiac'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	aphrodisiac5 = {text = "How dare you do this to me... But hey. Feels kinda nice.", events = ['aphrodisiac'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	aphrodisiac6 = {text = "Ugh. My whole body is burning up!", events = ['aphrodisiac'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	aphrodisiac7 = {text = "Gah! I really need to take care of this.", events = ['aphrodisiac'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	aphrodisiac8 = {text = "I can't control myself. What did you do to me?", events = ['aphrodisiac'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	aphrodisiac9 = {text = "Ahh... It would seem I crave a bit of relief...", events = ['aphrodisiac'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac10 = {text = "Such an odd concoction...", events = ['aphrodisiac'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac11 = {text = "Perhaps this feeling of lust isn't so bad...", events = ['aphrodisiac'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac12 = {text = "Trying to get me in a mood hmm? It's working.", events = ['aphrodisiac'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac13 = {text = "My mind is swarmed with thoughts of pleasure...", events = ['aphrodisiac'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac14 = {text = "M-my body's getting warmer.", events = ['aphrodisiac'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	aphrodisiac15 = {text = "O-oh no... I can't stop myself from...", events = ['aphrodisiac'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	aphrodisiac16 = {text = "It feels so good... please don't let it end...", events = ['aphrodisiac'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	aphrodisiac17 = {text = "S-so hard to resist...", events = ['aphrodisiac'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	aphrodisiac18 = {text = "W-why have you done this to me...?", events = ['aphrodisiac'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	aphrodisiac19 = {text = "In a mood are we? So am I.", events = ['aphrodisiac'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	aphrodisiac20 = {text = "Ahh... you know just what to do.", events = ['aphrodisiac'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	aphrodisiac21 = {text = "Are we about to have some fun?", events = ['aphrodisiac'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	aphrodisiac22 = {text = "Does this mean I can please you?", events = ['aphrodisiac'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	aphrodisiac23 = {text = "I'm getting so excited!", events = ['aphrodisiac'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	
	lockpick_success1 = {text = "I did it, [Master]. Let's see what's inside.", events = ['lockpick_success'], personalities = ['bold','serious','kind','shy'], reqs = [], weight = 1, tags = []},
	lockpick_success2 = {text = "Hmph, piece of cake.", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_success3 = {text = "I-I did it.", events = ['lockpick_success'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	lockpick_success4 = {text = "It's done.", events = ['lockpick_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_success5 = {text = "This lock is no match for me.", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_success6 = {text = "Is it... Okay to do this? It's open...", events = ['lockpick_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_success7 = {text = "O-oh! I actually did it!", events = ['lockpick_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_success8 = {text = "W-wow... I wonder what's inside?", events = ['lockpick_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_success9 = {text = "Ahh! Oh? I actually got it open?", events = ['lockpick_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_success10 = {text = "I-I can't believe I actually did it...", events = ['lockpick_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_success11 = {text = "I did it! Now we can get what's inside.", events = ['lockpick_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_success12 = {text = "I sure hope no one misses this...", events = ['lockpick_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_success13 = {text = "We can use this treasure to make everyone happy!", events = ['lockpick_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_success14 = {text = "Looks like I have a great teacher!", events = ['lockpick_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_success15 = {text = "If only it was always this easy.", events = ['lockpick_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_success16 = {text = "A trivial matter for the likes of me.", events = ['lockpick_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_success17 = {text = "A twist, and turn, and there you have it.", events = ['lockpick_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_success18 = {text = "Hmm? Was that all this lock could muster?", events = ['lockpick_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_success19 = {text = "It would seem I have gotten better at this.", events = ['lockpick_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_success20 = {text = "The treasure is ours to claim.", events = ['lockpick_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_success21 = {text = "No lock can beat me!", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_success22 = {text = "This loot better be worth it.", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_success23 = {text = "Ugh. Really? That was too easy!", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_success24 = {text = "We could have just smashed it you know, but I got it.", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_success25 = {text = "This is why you need someone like me!", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	
	lockpick_failure1 = {text = "Oh, uh... I'm sorry.", events = ['lockpick_failure'], personalities = ['bold','serious','kind','shy'], reqs = [], weight = 1, tags = []},
	lockpick_failure2 = {text = "T-this can't be my fault.", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure3 = {text = "I'm sorry!", events = ['lockpick_failure'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	lockpick_failure4 = {text = "...This can't be helped.", events = ['lockpick_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_failure5 = {text = "This stupid lock... I'll get it next time", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure6 = {text = "Stupid lock! I can't get it open!", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure7 = {text = "It broke my pick!", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure8 = {text = "Whatever! I bet the treasure wasn't even worth it.", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure9 = {text = "I failed!? No way!", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure10 = {text = "Gah! It's too hard for me!", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure11 = {text = "It would seem I have failed.", events = ['lockpick_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_failure12 = {text = "The lock is too complex for the likes of me.", events = ['lockpick_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_failure13 = {text = "A shame. I wanted to see what was inside.", events = ['lockpick_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_failure14 = {text = "Perhaps this is outside of my talents?", events = ['lockpick_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_failure15 = {text = "I can't get it to open.", events = ['lockpick_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_failure16 = {text = "I'm sorry. This is too hard.", events = ['lockpick_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_failure17 = {text = "Oh no. My pick broke.", events = ['lockpick_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_failure18 = {text = "Darn. I thought I had it too...", events = ['lockpick_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_failure19 = {text = "Aww... I bet it was something good too...", events = ['lockpick_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_failure20 = {text = "I'll get it next time!", events = ['lockpick_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_failure21 = {text = "I-I knew I couldn't do it...", events = ['lockpick_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_failure22 = {text = "S-sorry. It's too hard...", events = ['lockpick_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_failure23 = {text = "O-oh. I guess I'm not good enough...", events = ['lockpick_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_failure24 = {text = "P-please forgive me. I failed...", events = ['lockpick_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_failure25 = {text = "T-this is too much... I can't handle it.", events = ['lockpick_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	
	
	greeting_line_positive1 = {text = "[Master] would like to spend time {^together:with me}...?", events = ['date_greet_positive'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	greeting_line_positive2 = {text = "It's my pleasure to accompany you, [Master].", events = ['date_greet_positive'], personalities = ['kind', 'serious'], reqs = [], weight = 1, tags = []},
	greeting_line_positive3 = {text = "Let's have some fun together, [Master]!", events = ['date_greet_positive'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	
	greeting_line_cautious1 = {text = "Yes, [Master], what do you want me for?", events = ['date_greet_cautious'], personalities = ['serious','shy','bold','kind'], reqs = [], weight = 1, tags = []},
	greeting_line_cautious2 = {text = "I still have a work today, can we get over it quickly?", events = ['date_greet_cautious'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	greeting_line_cautious3 = {text = "What do you want of me? *grumble*", events = ['date_greet_cautious'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	greeting_line_cautious4 = {text = "Y-yes, [Master]. What can I do for you?", events = ['date_greet_cautious'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	
	punish_line_light1 = {text = "Ouch! It hurts!", events = ['date_punish_light'], personalities = ['bold','kind','serious','shy'], reqs = [], weight = 100, tags = []},
	punish_line_light2 = {text = "What was that for!?", events = ['date_punish_light'], personalities = ['bold','kind','serious'], reqs = [], weight = 1, tags = []},
	punish_line_light3 = {text = "Ugh!... You...", events = ['date_punish_light'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	punish_line_light4 = {text = "No! Stop...", events = ['date_punish_light'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	
	punish_line_heavy1 = {text = "Ouch! Please stop!", events = ['date_punish_heavy'], personalities = ['bold','kind','serious'], reqs = [], weight = 1, tags = []},
	
	public_line1 = {text = "N-no way, please don't do this in front of everyone...", events = ['date_public'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	public_line2 = {text = "Wha... Why you brought everyone here!?", events = ['date_public'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	public_line3 = {text = "This... is going to be humiliating.", events = ['date_public'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	public_line4 = {text = "Are you trying to scare me like this? See if I care.", events = ['date_public'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	public_line5 = {text = "P-please, [Master], I don't like being watched.", events = ['date_public'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	public_line6 = {text = "W-why everyone is here? I don't...", events = ['date_public'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	public_line7 = {text = "N-no... No! please...", events = ['date_public'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	
	#[2* in next cases will automatically translate from dated person
	public_observe_line1 = {text = "[Master] is going to punish you, [2name]...?", events = ['date_public_observe'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	public_observe_line2 = {text = "Hmph, serves you right.", events = ['date_public_observe'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	public_observe_line3 = {text = "Looks like [2name] is being punished. At least I get a break from work.", events = ['date_public_observe'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	public_observe_line4 = {text = "Please accept this with dignity.", events = ['date_public_observe'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	public_observe_line5 = {text = "......", events = ['date_public_observe'], personalities = ['shy','kind','serious'], reqs = [], weight = 1, tags = []},
	public_observe_line6 = {text = "If [he] dies, I call dibs on [his] stuff.", events = ['date_public_observe'], personalities = ['bold'], reqs = [], weight = 1, tags = ['second_character_translation']},
	public_observe_line7 = {text = "Looks like you will be getting a good lesson, [2name]. ", events = ['date_public_observe'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	
	date_propose_agree1 = {text = "I-I would like to get closer with you, [Master]. ", events = ['date_proposal_agree'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	date_propose_agree2 = {text = "Well, your charm worked this time on me. ", events = ['date_proposal_agree'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	date_propose_agree3 = {text = "Okay, why not be naughty?", events = ['date_proposal_agree'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_propose_agree4 = {text = "This is to help our bodily needs, correct?", events = ['date_proposal_agree'], personalities = ['serious','kind'], reqs = [], weight = 1, tags = []},
	date_propose_agree5 = {text = "W-well, if you don't mind someone like me...", events = ['date_proposal_agree'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_propose_agree6 = {text = "It's a pleasure you feel the same way.", events = ['date_proposal_agree'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	
	date_propose_refuse1 = {text = "Sorry, I don't feel about you in same way.", events = ['date_proposal_refuse'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	date_propose_refuse2 = {text = "P-please, maybe some other time...", events = ['date_proposal_refuse'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	date_propose_refuse3 = {text = "I'd rather not.", events = ['date_proposal_refuse'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	date_propose_refuse4 = {text = "Uh, no. This is awkward.", events = ['date_proposal_refuse'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_propose_refuse5 = {text = "I'm sure there's someone better than me.", events = ['date_proposal_refuse'], personalities = ['kind','shy','serious'], reqs = [], weight = 1, tags = []},
	
	date_sex_offer1 = {text = "...[Master]? I'd like to continue this affair.", events = ['date_sex_offer'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	date_sex_offer2 = {text = "Uhm, [Master], we could do, you know, lewd stuff... If you don't mind.", events = ['date_sex_offer'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_sex_offer3 = {text = "Hey, you are not going to leave me just now?", events = ['date_sex_offer'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_sex_offer4 = {text = "Hey, would you mind keeping me a company for some longer?", events = ['date_sex_offer'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	date_sex_offer5 = {text = "My body feels like... It could use some more attention.", events = ['date_sex_offer'], personalities = ['bold','serious','kind'], reqs = [], weight = 1, tags = []},
	date_sex_offer6 = {text = "Uhm, can we continue this? I don't want to leave you. ", events = ['date_sex_offer'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	
	date_affection1 = {text = "This... Feels nice.", events = ['date_affection'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	date_affection2 = {text = "I might get used to it.", events = ['date_affection'], personalities = ['kind','serious','bold'], reqs = [], weight = 1, tags = []},
	date_affection3 = {text = "You will spoil me like this, [Master].", events = ['date_affection'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	date_affection4 = {text = "Please, I didn't... Deserve it... [Master].", events = ['date_affection'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_affection5 = {text = "You are being too nice to me.", events = ['date_affection'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	date_affection6 = {text = "I don't mind you praising me some more.", events = ['date_affection'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_affection7 = {text = "Your affection is appreciated, [Master].", events = ['date_affection'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	
	date_scold1 = {text = "I'm sorry [Master]. ", events = ['date_scold'], personalities = ['kind','serious','shy'], reqs = [], weight = 1, tags = []},
	date_scold2 = {text = "You don't have to yell at me. ", events = ['date_scold'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_scold3 = {text = "I'm sorry, please don't be angry. ", events = ['date_scold'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	date_scold4 = {text = "Stop, I didn't deserve this! ", events = ['date_scold'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_scold5 = {text = "I'm sorry you feel this way.", events = ['date_scold'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	
	mimic_eat1 = {text = "Oh no! It's alive!", events = ['mimic_eat'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_eat2 = {text = "Noo! It's got me! Help!", events = ['mimic_eat','mimic_rape'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_eat3 = {text = "Ugh, I can't get out!", events = ['mimic_eat','mimic_rape'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	
	
	mimic_molest1 = {text = "Agh... It's touching me all over!", events = ['mimic_rape'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_molest2 = {text = "What's the... Ah! Stop!", events = ['mimic_rape'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_molest3 = {text = "N-no, stop! No there!", events = ['mimic_rape'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	
	mimic_leave1 = {text = "N-no, stop! You can't leave me!", events = ['mimic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_leave2 = {text = "Please, wait! Help me!", events = ['mimic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_leave3 = {text = "No! *sob* Please, I beg...", events = ['mimic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_leave4 = {text = "Wait, I don't wanna die!", events = ['mimic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	
	mimic_erotic_leave1 = {text = "Y-you gonna leave me- Ah!.. Like this?", events = ['mimic_erotic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_erotic_leave2 = {text = "No, I hate it! Please help!", events = ['mimic_erotic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = [{code = 'trait', trait = 'deviant', check = false }]},
	mimic_erotic_leave3 = {text = "Noooo! This feels gross!", events = ['mimic_erotic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = [{code = 'trait', trait = 'deviant', check = false }]},
	mimic_erotic_leave4 = {text = "Agh, why you don't help me?!", events = ['mimic_erotic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = [{code = 'trait', trait = 'deviant', check = false }]},
	
	mimic_erotic_leave5 = {text = "Ooh! I starting to... Like this...", events = ['mimic_erotic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = [{code = 'trait', trait = 'deviant', check = true }]},
	mimic_erotic_leave6 = {text = "Ah.. This... Is not too bad...", events = ['mimic_erotic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = [{code = 'trait', trait = 'deviant', check = true }]},
}

func build_lines():
	for i in individual_lines.values():
		for k in i.events:
			if !lines.has(k):
				lines[k] = []
			lines[k].append(i.duplicate(true))
#
#	var dict = {
#		shy = 0,
#		kind = 0,
#		serious = 0,
#		bold = 0,
#	}
#	for i in lines['date_punish_heavy']: #+ lines['date_punish_heavy']:
#		for k in i.personalities:
#			dict[k] += 1
#	print(dict)

func return_chat_line(character, event):
	var array = []
	for i in lines[event]:
		if i.personalities.has(character.get_stat('personality')) && character.checkreqs(i.reqs) == true:
			if i.has('arg_reqs'):
				var check = false
				for k in i.arg_reqs:
					match k:
						'partner_is_master':
							if input_handler.get_spec_node(input_handler.NODE_GUI_WORLD).gui_data["INTERACTION"].main_module.has_master():
								check = true
							
				if check == false:
					continue
			array.append([i.text, i.weight])
	if array.size() > 0:
		var line = character.translate(input_handler.weightedrandom(array))
		if character.get_stat('race') in ['BeastkinCat','HalfkinCat'] && input_handler.globalsettings.meowing == true:
			line = process_meowing(line)
		return line

func show_chat_line(character, event):
	var line = return_chat_line(character, event)
	add_new_chatter(character, line)



func rebuild_text(words):
	var res := ''
	for w in words:
		res = res + ' ' + w
	if words.size() > 0:
		res = res.substr(1)
	return res

func process_stutter(text:String, num = 1, mlen = 3, esc_list = []):
	var words = text.split(' ')
	
	var buf = []
	for i in range(words.size()):
		var w = words[i]
		if w in esc_list: continue
		if w.length() < mlen: continue
		buf.push_back(i)
	
	for i in range(num):
		if buf.empty(): break
		var tmp = randi() % buf.size()
		words[tmp] = words[tmp][0] + '-' + words[tmp]
	
	return rebuild_text(words)

func process_drunk(text: String, insert:Array, num = 1):
	var res = ' ' + text + ' '
	for i in range(num):
		var count = res.count(' ')
		var pos = randi() % count
		var tpos = res.find(' ')
		for ii in range(pos):
			tpos = res.find(' ', tpos + 1)
		var word = insert[randi() % insert.size()]
		res = res.insert(tpos, ' ' + word)
	return res.trim_prefix(' ').trim_suffix(' ')


var meowing_replacements = {
	ma = ['mya'],
	mo = ['myo'],
	mi = ['meow'],
	na = ['nya'],
	no = ['nyo'],
	ni = ['neow'],
	
}

func process_meowing(text: String, num = 1):
	var words = text.split(' ')
	
	var buf = []
	for i in range(words.size()):
		var w = words[i]
		for k in meowing_replacements.keys():
			if w.findn(k) >= 0:
				var pos = w.findn(k)
				var word = w.substr(pos, pos + k.length())
				var replace_word = meowing_replacements[k][randi()%meowing_replacements[k].size()]
				replace_word = case_compare(word, replace_word)
				w = w.insert(w.findn(k), '#').replacen('#' + k, replace_word) 
				words[i] = w
				break
	
	return rebuild_text(words)

func case_compare(word1, word2):
	if word1 == word1.to_upper():
		word2 = word2.to_upper()
	if word1 == word1.capitalize():
		word2 = word2.capitalize()
	return word2

