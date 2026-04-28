extends Reference

const category = 'fucking'
const code = 'inserttailv'
const order = 11
var givers
var takers
const canlast = true
const giverpart = 'tail'
const takerpart = 'vagina'
const virginloss = true
const givertags = ['tail', 'noorgasm']
const takertags = ['vagina', 'penetration']
const giver_skill = ['tail']
const taker_skill = ['pussy']
const consent_level = 35
const consent_giver = 4
const consent_taker = 5

func getname(state = null):
	return tr("SEXACTION_INSERT_TAIL_PUSSY")

func getongoingname(givers, takers):
	return tr("SEXACTION_INSERTTAILV_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["SEXACTION_INSERTTAILV_ONGOING_DESC_1"]
	return tr(temparray[randi()%temparray.size()])

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
		for i in givers:
			if i.limbs == false:
				valid = false
			if !variables.longtails.has(i.person.get_stat('tail')):
				valid = false
		for i in takers:
			if i.person.get_stat('has_pussy') == false:
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 100, horny = 5}
	return effects

func takereffect(member):
	var effects = {sens = 240, horny = 10}
	return effects


func initiate():
	return tr("SEXACTION_INSERTTAILV_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_INSERTTAILV_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_INSERTTAILV_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_INSERTTAILV_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_INSERTTAILV_REACTION_3")
	else:
		text = tr("SEXACTION_INSERTTAILV_REACTION_4")
	return text
