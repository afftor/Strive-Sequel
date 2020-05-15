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
const givertags = ['penis', 'group','dom']
const takertags = ['anal', 'mouth', 'penetration','group','sub']
const giver_skill = ['penetration']
const taker_skill = ['anal','oral']
const consent_level = 40

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 2:
		valid = false
	for i in givers:
		if i.person.get_stat('penis_size') == '' && i.strapon == false:
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
	var effects = {sens = 210, horny = 15}
	if member.person.get_stat('penis_size') == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 250, horny = 5}
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] {^passionately :eagerly :}[fuck1] [names2]'s [anus2] and mouth. "]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	return text
