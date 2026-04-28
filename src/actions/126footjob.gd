extends Reference

const category = 'caress'
const code = 'footjob'
const order = 10
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'penis'
const virginloss = false
const givertags = ['pet','noorgasm','dom']
const takertags = ['pet','penis','sub']
const giver_skill = ['petting']
const taker_skill = []
const consent_level = 25


const consent_giver = 0
const consent_taker = 3

func getname(state = null):
	return tr("SEXACTION_FOOTJOB")

func getongoingname(givers, takers):
	return tr("SEXACTION_FOOTJOB_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["SEXACTION_FOOTJOB_ONGOING_DESC_1"]
	return tr(temparray[randi()%temparray.size()])

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
		for i in takers:
#			if i.penis != null || i.person.penis_size == '':
#				valid = false
			if i.person.get_stat('penis_size') == '':
				valid = false
		for i in givers:
			if i.person.get_stat('legs') in ['horse','spider', 'snake']:
				valid = false
			if i.limbs == false:
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 50, horny = 10}
	return effects

func takereffect(member):
	var effects = {sens = 125, horny = 15}
	return effects


func initiate():
	return tr("SEXACTION_FOOTJOB_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_FOOTJOB_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_FOOTJOB_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_FOOTJOB_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_FOOTJOB_REACTION_3")
	else:
		text = tr("SEXACTION_FOOTJOB_REACTION_4")
	return text
