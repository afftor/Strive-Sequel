extends Node

const category = 'fucking'
const code = 'insertinturnsass'
const order = 10.4
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'anus'
const virginloss = true
const givertags = ['penis','group']
const takertags = ['anal','penetration', 'group']
const giver_skill = ['penetration']
const taker_skill = ['anal']
const consent_level = 40

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif takers.size() < 2 && givers.size() < 2:
		valid = false
	for i in givers:
		if i.person.get_stat('penis_size') == '' && !i.strapon:
			valid = false
	return valid

func getname(state = null):
	return "Fuck ass in turns"

func getongoingname(givers, takers):
	return "[name1] [fuck1] [names2] [anus2] periodically taking turns and switching."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] continue {^passionately :eagerly :} [fucking1] [names2] [anus2] in turns."]
	return temparray[randi()%temparray.size()]



func givereffect(member):
	var effects = {sens = 210, horny = 10}
	if member.person.get_stat('penis_size') == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 200, horny = 5}
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] [fuck1] [names2] [anus2] periodically taking turns and switching."]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	return text
