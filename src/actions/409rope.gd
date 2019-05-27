extends Node

const category = 'SM'
const code = 'rope'
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = 'acc4'#body extra to change some getname into restrained getname
const virginloss = false
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = []
const takertags = ['punish']

func getname(state = null):
	return "Rope"

func getongoingname(givers, takers):
	return "[name1] bind[s/1] [names2] bod[y/ies2] with [a /2]rope[/s2]."

func getongoingdescription(givers, takers):
	return ""
	
func requirements():
	var valid = true
#	if globals.state.getCountStackableItem('rope') <= 0:
#		valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
	for i in givers + takers:
		if i.limbs == false:
			valid = false
	return valid

func givereffect(member):
	var result
	var effects = {}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 10):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 10):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] {^wrap:tie}[s/1] a rope around [names2] body to restrict [his2] movements."]
	text += temparray[randi()%temparray.size()]
	for i in takers:
		#globals.state.removeStackableItem('rope')
		i.effects.append('tied')
	temparray.clear()
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, with [his2] body still tied down."

	return text
