extends Reference

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
const givertags = ['penis', 'group','dom']
const takertags = ['vagina', 'mouth', 'penetration', 'group','sub']
const giver_skill = ['penetration']
const taker_skill = ['pussy','oral']
const consent_level = 40
const consent_giver = 3
const consent_taker = 4

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
	return tr("SEXACTION_SPIT_ROAST")

func getongoingname(givers, takers):
	return tr("SEXACTION_SPITROAST_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["SEXACTION_SPITROAST_ONGOING_DESC_1"]
	return tr(temparray[randi()%temparray.size()])



func givereffect(member):
	var effects = {sens = 210, horny = 15}
	if member.person.get_stat('penis_size') == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 260, horny = 5}
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] {^passionately :eagerly :}[fuck1] [names2]'s [pussy2] and mouth. "]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	return text
