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
const givertags = ['penis', 'group','dom']
const takertags = ['vagina', 'anal', 'penetration', 'group','sub']
const giver_skill = ['penetration']
const taker_skill = ['pussy','anal']
const consent_level = 40

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 2:
		valid = false
	for i in givers:
		if i.person.get_stat('penis_size') == '' && i.strapon == false:
			valid = false
	for i in takers:
		if i.person.get_stat('has_pussy') == false:
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
	var effects = {sens = 210, horny = 15}
	if member.person.get_stat('penis_size') == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 310, horny = 5}
	member.person_metrics.anal += 1
	member.person_metrics.vag += 1
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] put [names2] between them and [fuck1] [his2] {^orifices:holes}. "]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	return text
