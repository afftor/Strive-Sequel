extends Reference

const category = 'SM'
const code = 'deepthroat'
const order = 3
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'mouth'
const virginloss = false
const givertags = ['penis','dom']
const takertags = ['mouth','penetration','pain','sub']
const giver_skill = ['penetration']
const taker_skill = ['oral']
const consent_level = 30
const consent_giver = 3
const consent_taker = 4

func getname(state = null):
	return tr("SEXACTION_DEEPTHROAT")

func getongoingname(givers, takers):
	return tr("SEXACTION_DEEPTHROAT_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["SEXACTION_DEEPTHROAT_ONGOING_DESC_1"]
	#temparray += ["SEXACTION_DEEPTHROAT_ONGOING_DESC_2"]
	return tr(temparray[randi()%temparray.size()])

func requirements():
	var valid = true
	#if takers.size() < 1 || givers.size() < 1:
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
		for i in givers:
			if i.person.get_stat('penis_size') == '' && !i.strapon:
				valid = false
#			elif i.penis != null && givers.size() > 1:
#				valid = false
		for i in takers:
#			if i.mouth != null && givers.size() > 1:
#				valid = false
			if i.acc1 == null:
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 220, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 80, horny = 10}
	return effects

func initiate():
	return tr("SEXACTION_DEEPTHROAT_INITIATE_1")

func reaction(member):
	var text = ''
	#elif member.consent == false:
		#TBD
	if member.sens < 300:
		text = tr("SEXACTION_DEEPTHROAT_REACTION_1")
	elif member.sens < 600:
		text = tr("SEXACTION_DEEPTHROAT_REACTION_2")
	elif member.sens < 950:
		text = tr("SEXACTION_DEEPTHROAT_REACTION_3")
	else:
		text = tr("SEXACTION_DEEPTHROAT_REACTION_4")

	return text
