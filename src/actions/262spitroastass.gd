extends Node

const category = 'fucking'
const code = 'spitroastass'
const order = 10.2
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'anus'
const takerpart2 = 'mouth'
const virginloss = true
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = ['penis', 'group']
const takertags = ['anal', 'mouth', 'penetration']

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 2:
		valid = false
	for i in givers:
		if i.person.penis == 'none' && i.strapon == null:
			valid = false
	
	return valid

func getname(state = null):
	return "Spit-roast Anal"

func getongoingname(givers, takers):
	return "[name1] spit-roast[s/1] [name2]'s [anus2] and mouth."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] continue {^passionately :eagerly :}spit-roasting [name2]."]
	return temparray[randi()%temparray.size()]



func givereffect(member):
	var result
	var effects = {sens = 210, tags = ['group']}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.sens >= 300) && member.person.traits.has("Fickle"):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	if member.person.penis == 'none':
		effects.sens /= 1.2
	return [result, effects]

func takereffect(member):
	var result
	var effects = {sens = 250, tags = ['group']}
	if (member.consent == true || member.person.traits.find("Likes it rough") >= 0) && member.sens >= 400 && member.lube >= 5 && member.person.traits.has("Fickle"):
		result = 'good'
	elif (member.consent == true || member.person.traits.find("Likes it rough") >= 0):
		result = 'average'
	else:
		result = 'bad'
	if member.lube < 5:
		effects.pain = 4
	return [result, effects]

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] {^passionately :eagerly :}[fuck1] [names2]'s [anus2] and mouth. "]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	return text
