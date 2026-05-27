extends Reference

const category = 'fucking'
const code = 'inserttaila'
const order = 12
var givers
var takers
const canlast = true
const giverpart = 'tail'
const takerpart = 'anus'
const virginloss = true
const givertags = ['tail', 'noorgasm']
const takertags = ['anal', 'penetration']
const giver_skill = ['tail']
const taker_skill = ['anal']
const consent_level = 40
const consent_giver = 4
const consent_taker = 5

func getname(state = null):
	return tr("SEXACTION_INSERT_TAIL_ASS")

func getongoingname(givers, takers):
	return tr("SEXACTION_INSERTTAILA_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["SEXACTION_INSERTTAILA_ONGOING_DESC_1"]
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
	return valid

func givereffect(member):
	var effects = {sens = 90, horny = 5}
	return effects

func takereffect(member):
	var effects = {sens = 190, horny = 5}
	return effects


func initiate():
	return tr("SEXACTION_INSERTTAILA_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_INSERTTAILA_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_INSERTTAILA_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_INSERTTAILA_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_INSERTTAILA_REACTION_3")
	else:
		text = tr("SEXACTION_INSERTTAILA_REACTION_4")
	return text
