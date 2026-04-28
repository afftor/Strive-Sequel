extends Reference

const category = 'caress'
const code = 'blowjob'
const order = 6
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = 'penis'
const virginloss = false
const givertags = ['oral','noorgasm','sub']
const takertags = ['penis','dom']
const giver_skill = ['oral']
const taker_skill = []
const consent_level = 15


const consent_giver = 3
const consent_taker = 3

func getname(state = null):
	if givers.size() == 0 || takers.size() == 0 || givers.size() + takers.size() == 2:
		return tr("SEXACTION_BLOWJOB")
	else:
		return tr("SEXACTION_SMLT_BLOWJOB")

func getongoingname(givers, takers):
	return tr("SEXACTION_BLOWJOB_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["SEXACTION_BLOWJOB_ONGOING_DESC_1"]
	temparray += ["SEXACTION_BLOWJOB_ONGOING_DESC_2"]
	return tr(temparray[randi()%temparray.size()])

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	else:
#		for i in givers:
#			if i.mouth != null:
#				valid = false
		for i in takers:
#			if i.penis != null || i.person.penis_size == '':
#				valid = false
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 75, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 180, horny = 25}
	return effects

func initiate():
	var temparray = []
	temparray += ["SEXACTION_BLOWJOB_INITIATE_1"]
	temparray += ["SEXACTION_BLOWJOB_INITIATE_2"]
	return tr(temparray[randi()%temparray.size()])

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_BLOWJOB_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_BLOWJOB_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_BLOWJOB_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_BLOWJOB_REACTION_3")
	else:
		text = tr("SEXACTION_BLOWJOB_REACTION_4")
	return text
