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
const givertags = ['penis','group']
const takertags = ['vagina','penetration', 'group']

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif takers.size() < 2 && givers.size() < 2:
		valid = false
	for i in givers:
		if i.person.penis_size == '' && i.strapon == null:
			valid = false
	for i in takers:
		if i.person.has_pussy == false:
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
	var effects = {sens = 220, horny = 15}
	if member.person.penis_size == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 240, horny = 5}
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] [fuck1] [names2] [pussy2] periodically taking turns and switching."]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	return text
