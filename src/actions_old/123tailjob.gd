extends Reference

const category = 'caress'
const code = 'tailjob'
const order = 10
var givers
var takers
const canlast = true
const giverpart = 'tail'
const takerpart = 'penis'
const virginloss = false
const givertags = ['pet', 'tail', 'noorgasm']
const takertags = ['pet','penis']
const giver_skill = ['tail']
const taker_skill = []
const consent_level = 25


const consent_giver = 3
const consent_taker = 3

func getname(state = null):
	return tr("SEXACTION_TAILJOB")

func getongoingname(givers, takers):
	return tr("SEXACTION_TAILJOB_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["SEXACTION_TAILJOB_ONGOING_DESC_1"]
	temparray += ["SEXACTION_TAILJOB_ONGOING_DESC_2"]
	return tr(temparray[randi()%temparray.size()])

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif takers.size() > givers.size():
		valid = false
	else:
		for i in givers:
			if !variables.longtails.has(i.person.get_stat('tail')):
				valid = false
			if i.limbs == false:
				valid = false
		for i in takers:
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 75, horny = 20}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 25}
	return effects

func initiate():
	var temparray = []
	temparray += ["SEXACTION_TAILJOB_INITIATE_1"]
	temparray += ["SEXACTION_TAILJOB_INITIATE_2"]
	return tr(temparray[randi()%temparray.size()])

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_TAILJOB_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_TAILJOB_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_TAILJOB_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_TAILJOB_REACTION_3")
	else:
		text = tr("SEXACTION_TAILJOB_REACTION_4")
	return text
