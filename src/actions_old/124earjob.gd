extends Reference

const category = 'caress'
const code = 'earjob'
const order = 10
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = ''
const virginloss = false
const givertags = ['pet','penis','noorgasm','dom']
const takertags = ['pet','noorgasm','sub']
const giver_skill = []
const taker_skill = ['petting']
const consent_level = 30


const consent_giver = 0
const consent_taker = 3

func getname(state = null):
	return tr("SEXACTION_EARJOB")

func getongoingname(givers, takers):
	return tr("SEXACTION_EARJOB_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["SEXACTION_EARJOB_ONGOING_DESC_1"]
	return tr(temparray[randi()%temparray.size()])

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
		for i in givers:
#			if i.penis != null || i.person.penis_size == '':
#				valid = false
			if i.person.get_stat('penis_size') == '':
				valid = false
		for i in takers:
			if i.person.get_stat('ears') in ['normal','orcish']:
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 125, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 50, horny = 5}
	return effects


func initiate():
	return tr("SEXACTION_EARJOB_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_EARJOB_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_EARJOB_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_EARJOB_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_EARJOB_REACTION_3")
	else:
		text = tr("SEXACTION_EARJOB_REACTION_4")
	return text
