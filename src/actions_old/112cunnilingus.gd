extends Reference

const category = 'caress'
const code = 'cunnilingus'
const order = 7
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = 'clit'
const virginloss = false
const givertags = ['oral','noorgasm','sub']
const takertags = ['vagina','dom']
const giver_skill = ['oral']
const taker_skill = ['pussy']
const consent_level = 15


const consent_giver = 2
const consent_taker = 3

func getname(state = null):
	return tr("SEXACTION_CUNNILINGUS")

func getongoingname(givers, takers):
	return tr("SEXACTION_CUNNILINGUS_ONGOING_1")

func getongoingdescription(givers, takers):
	return tr("SEXACTION_CUNNILINGUS_ONGOING_DESC_1")

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
#		for i in givers:
#			if i.mouth != null:
#				valid = false
		for i in takers:
#			if i.vagina != null || i.person.has_pussy == false:
#				valid = false
			if i.person.get_stat('has_pussy') == false:
				valid = false
#			elif i.clit != null:
#				valid = false
			elif i.person.get_stat('sex') == 'male':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 90, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 180, horny = 25}
	return effects

func initiate():
	return tr("SEXACTION_CUNNILINGUS_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_CUNNILINGUS_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_CUNNILINGUS_REACTION_1")
	elif member.sens < 300:
		text = tr("SEXACTION_CUNNILINGUS_REACTION_2")
	elif member.sens < 600:
		text = tr("SEXACTION_CUNNILINGUS_REACTION_3")
	else:
		text = tr("SEXACTION_CUNNILINGUS_REACTION_4")
	return text
