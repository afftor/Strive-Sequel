extends Reference

const category = 'caress'
const code = 'handjob'
const order = 5
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'penis'
const virginloss = false
const givertags = ['pet','noorgasm']
const takertags = ['pet','penis']
const giver_skill = ['petting']
const taker_skill = []
const consent_level = 10


const consent_giver = 0
const consent_taker = 2

func getname(state = null):
	if givers.size() + takers.size() == 2:
		return tr("SEXACTION_HANDJOB")
	else:
		return tr("SEXACTION_SMLT_HANDJOB")

func getongoingname(givers, takers):
	return tr("SEXACTION_HANDJOB_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["SEXACTION_HANDJOB_ONGOING_DESC_1"]
	temparray += ["SEXACTION_HANDJOB_ONGOING_DESC_2"]
	return tr(temparray[randi()%temparray.size()])

func requirements():
	var valid = true
	for i in givers:
		if i.limbs == false:
			valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	else:
		for i in takers:
#			if i.penis != null || i.person.penis_size == '':
#				valid = false
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 65, horny = 10}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 25}
	return effects


func initiate():
	var temparray = []
	temparray += ["SEXACTION_HANDJOB_INITIATE_1"]
	temparray += ["SEXACTION_HANDJOB_INITIATE_2"]
	return tr(temparray[randi()%temparray.size()])

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_HANDJOB_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_HANDJOB_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_HANDJOB_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_HANDJOB_REACTION_3")
	else:
		text = tr("SEXACTION_HANDJOB_REACTION_4")
	return text
