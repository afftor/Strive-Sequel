extends Reference

const category = 'caress'
const code = 'titjob'
const order = 7
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'penis'
const virginloss = false
const givertags = ['pet','noorgasm', 'tits']
const takertags = ['pet','penis']
const giver_skill = ['petting']
const taker_skill = []
const consent_level = 20


const consent_giver = 2
const consent_taker = 3

func getname(state = null):
	if givers.size() + takers.size() == 2:
		return tr("SEXACTION_TITJOB")
	else:
		return tr("SEXACTION_SMLT_TITJOB")

func getongoingname(givers, takers):
	return tr("SEXACTION_TITJOB_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["SEXACTION_TITJOB_ONGOING_DESC_1"]
	return tr(temparray[randi()%temparray.size()])

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	else:
		for i in givers:
			if i.person.get_stat('tits_size') in ['masculine','flat']:
				valid = false
			if i.limbs == false:
				valid = false
		for i in takers:
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 90, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 25}
	return effects

func initiate():
	return tr("SEXACTION_TITJOB_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_TITJOB_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_TITJOB_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_TITJOB_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_TITJOB_REACTION_3")
	else:
		text = tr("SEXACTION_TITJOB_REACTION_4")
	return text
