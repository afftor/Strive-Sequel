extends Reference

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
const consent_giver = 3
const consent_taker = 5

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
	return tr("SEXACTION_DOUBLE_PENETRATE")

func getongoingname(givers, takers):
	return tr("SEXACTION_DOUBLEPEN_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["SEXACTION_DOUBLEPEN_ONGOING_DESC_1"]
	return tr(temparray[randi()%temparray.size()])



func givereffect(member):
	var effects = {sens = 210, horny = 15}
	if member.person.get_stat('penis_size') == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 310, horny = 5}
	return effects

func initiate():
	return tr("SEXACTION_DOUBLEPEN_INITIATE_1")
