extends Reference

const category = 'caress'
const code = 'kiss'
const order = 2
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = 'mouth'
const virginloss = false
const givertags = ['oral','noorgasm']
const takertags = ['oral','noorgasm']
const giver_skill = ['oral']
const taker_skill = ['oral']
const consent_level = 15

const consent_giver = 1
const consent_taker = 1

func getname(state = null):
	if givers.size() == 0 || takers.size() == 0:
		return tr("SEXACTION_KISS")
	elif givers.size() > 1 || takers.size() > 1:
		return tr("SEXACTION_DOUBLE_KISS")
	else:
		return tr("SEXACTION_KISS")

func getongoingname(givers, takers):
	return tr("SEXACTION_KISS_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	if givers.size() + takers.size() == 2:
		temparray += ["SEXACTION_KISS_ONGOING_DESC_1"]
	elif givers.size() == 2:
		temparray += ["SEXACTION_KISS_ONGOING_DESC_2"]
	else:
		temparray += ["SEXACTION_KISS_ONGOING_DESC_3"]
	return tr(temparray[randi()%temparray.size()])

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
#	else:
#		for i in givers+takers:
#			if i.mouth != null:
#				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 120, horny = 25}
	return effects

func takereffect(member):
	var effects = {sens = 120, horny = 25}
	return effects


func initiate():
	var temparray = []
	if givers.size() == 2:
		temparray += ["SEXACTION_KISS_INITIATE_DOUBLE_1"]
		temparray += ["SEXACTION_KISS_INITIATE_DOUBLE_2"]
	else:
		temparray += ["SEXACTION_KISS_INITIATE_1"]
		temparray += ["SEXACTION_KISS_INITIATE_2"]
	temparray += ["SEXACTION_KISS_INITIATE_3"]
	return tr(temparray[randi()%temparray.size()])


func taker_resist():
	var temparray = []
	if takers[0].stamina > 20:
		temparray += ["SEXACTION_KISS_RESIST_1"]
	else:
		temparray += ["SEXACTION_KISS_RESIST_2"]
	return tr(temparray[randi()%temparray.size()])
