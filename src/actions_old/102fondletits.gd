extends Reference

const category = 'caress'
const code = 'fondletits'
const order = 3
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = ['pet','noorgasm']
const takertags = ['pet', 'tits']
const giver_skill = ['petting']
const taker_skill = []
const consent_level = 15


const consent_giver = 0
const consent_taker = 1

func getname(state = null):
	return tr("SEXACTION_FONDLE_CHEST")

func getongoingname(givers, takers):
	return tr("SEXACTION_FONDLETITS_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["SEXACTION_FONDLETITS_ONGOING_DESC_1"]
	return tr(temparray[randi()%temparray.size()])
	
func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	for i in givers + takers:
		if i.limbs == false:
			valid = false
	return valid

func givereffect(member):
	var effects = {sens = 90, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 125, horny = 25}
	if member.person.get_stat('sex') == 'male':
		effects.sens /= 2
	return effects

func initiate():
	var text = ''
	var kissable = true
	var temparray = []
	for i in givers:
		if i.mouth != null:
			kissable = false
	temparray += ["SEXACTION_FONDLETITS_INITIATE_1"]
	temparray += ["SEXACTION_FONDLETITS_INITIATE_2"]
	text += tr(temparray[randi()%temparray.size()])
	temparray.clear()
	temparray += ["SEXACTION_FONDLETITS_INITIATE_SUFFIX_1"]
	temparray += ["SEXACTION_FONDLETITS_INITIATE_SUFFIX_2"]
	temparray += [". "]
	if kissable:
		temparray += ["SEXACTION_FONDLETITS_INITIATE_KISSABLE_1"]
		temparray += ["SEXACTION_FONDLETITS_INITIATE_KISSABLE_2"]
	text += tr(temparray[randi()%temparray.size()])
	temparray.clear()
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_FONDLETITS_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_FONDLETITS_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_FONDLETITS_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_FONDLETITS_REACTION_3")
	else:
		text = tr("SEXACTION_FONDLETITS_REACTION_4")
	return text
