extends Node

func get_custom_text(data):
	return call(data)

var elect_support_dict = {
	servants_election_support = "You have support of Servants Guild",
	fighters_election_support = "You have support of Fighters Guild",
	workers_election_support = "You have support of Workers Guild",
	mages_election_support = "You have support of Mages Guild",
}

func election_quest_text():
	var text = ''
	var counter = 0
	for i in ['servants_election_support','fighters_election_support','workers_election_support','mages_election_support']:
		if ResourceScripts.game_progress.decisions.has(i):
			counter += 1
			text += elect_support_dict[i] + "\n"
	
	text += "\nTotal support: " + str(counter) + "/3"
	
	return text


func lock_difficulty(value):
	var text = ''
	if value < 25:
		text = 'Very Easy'
	elif value < 45:
		text = 'Easy'
	elif value < 65:
		text = 'Medium'
	elif value < 85:
		text = "Hard"
	else:
		text = "Very Hard"
		
	return text

func transform_number(number):
	var magnitude = 0
	var array = ['', 'K', 'M']
	while abs(number) >= 1000:
		magnitude += 1
		number /= 1000.0
	
	return str(stepify(number, 0.1)) + array[magnitude]# % (num,[magnitude])

func RomanNumberConvert(value):
	var rval = ''
	match value:
		1:
			rval = 'I'
		2:
			rval = 'II'
		3:
			rval = 'III'
		4:
			rval = 'IV'
		5:
			rval = 'V'
		6:
			rval = 'VI'
		7:
			rval = 'VII'
		8:
			rval = 'VIII' 
		9:
			rval = 'IX'
		10:
			rval = 'X'
	return rval
