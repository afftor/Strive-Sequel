extends Node

const category = 'fucking'
const code = 'spitroast'
const order = 10.1
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'vagina'
const takerpart2 = 'mouth'
const virginloss = true
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = ['penis', 'group']
const takertags = ['vagina', 'mouth', 'penetration']

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 2:
		valid = false
	for i in givers:
		if i.person.penis == 'none' && i.strapon == null:
			valid = false
	for i in takers:
		if i.person.vagina == 'none':
			valid = false
	
	return valid

func getname(state = null):
	return "Spit-roast"

func getongoingname(givers, takers):
	return "[name1] spit-roast[s/1] [name2]'s pussy and mouth."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] continue {^passionately :eagerly :}[fucking1] [name2] [pussy2] and mouth."]
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
	var effects = {sens = 260, tags = ['group']}
	if (member.consent == true || member.person.traits.find("Likes it rough") >= 0) && member.sens >= 400 && member.lube >= 3 && member.person.traits.has("Fickle"):
		result = 'good'
	elif (member.consent == true || member.person.traits.find("Likes it rough") >= 0):
		result = 'average'
	else:
		result = 'bad'
	if member.lube < 3:
		effects.pain = 2
	return [result, effects]

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] {^passionately :eagerly :}[fuck1] [names2]'s [pussy2] and mouth. "]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	return text
