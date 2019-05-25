extends Node

const category = 'fucking'
const code = 'doublepen'
const order = 10
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'vagina'
const takerpart2 = 'anus'
const virginloss = true
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = ['penis', 'group']
const takertags = ['vagina', 'anal', 'penetration']

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
	return "Double Penetrate"

func getongoingname(givers, takers):
	return "[name1] double penetrate[s/1] [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] continue {^passionately :eagerly :}[fucking1] [name2] {^together:in union}."]
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
	var effects = {sens = 310, tags = ['group']}
	member.person.metrics.anal += 1
	member.person.metrics.vag += 1
	if (member.consent == true || member.person.traits.find("Likes it rough") >= 0) && member.sens >= 400 && member.lube >= 3 && member.person.traits.has("Fickle"):
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
	temparray += ["[name1] put [names2] between them and [fuck1] [his2] {^orifices:holes}. "]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	return text
