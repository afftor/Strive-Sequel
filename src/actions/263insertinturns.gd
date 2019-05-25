extends Node

const category = 'fucking'
const code = 'insertinturns'
const order = 10.3
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'vagina'
const virginloss = true
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = ['penis']
const takertags = ['vagina','penetration', 'group']

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif takers.size() < 2 && givers.size() < 2:
		valid = false
	for i in givers:
		if i.person.penis == 'none' && i.strapon == null:
			valid = false
	for i in takers:
		if i.person.vagina == 'none':
			valid = false
	return valid

func getname(state = null):
	return "Fuck in turns"

func getongoingname(givers, takers):
	return "[name1] [fuck1] [name2] [pussy2] periodically taking turns and switching."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] continue {^passionately :eagerly :} [fucking1] [name2] in turns."]
	return temparray[randi()%temparray.size()]



func givereffect(member):
	var result
	var effects = {sens = 220, tags = ['group']}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.sens >= 200) && member.person.traits.has("Fickle"):
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
	var effects = {sens = 240, tags = ['group']}
	if (member.consent == true || member.person.traits.find("Likes it rough") >= 0) && member.sens >= 400 && member.lube >= 3  && member.person.traits.has("Fickle"):
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
	temparray += ["[name1] [fuck1] [names2] [pussy2] periodically taking turns and switching."]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	return text
