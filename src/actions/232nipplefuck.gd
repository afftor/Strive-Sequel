extends Reference

const category = 'fucking'
const code = 'nipplefuck'
const order = 15
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'nipples'
const virginloss = false
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = ['penis']
const takertags = ['tits', 'penetration']
const giver_skill = ['penetration']
const taker_skill = []
const consent_level = 25
const consent_level_max = 50

const consent_giver = 4
const consent_taker = 5
func getname(state = null):
	return tr("SEXACTION_NIPPLE_FUCK")

func getongoingname(givers, takers):
	return tr("SEXACTION_NIPPLEFUCK_ONGOING_1")

func getongoingdescription(givers, takers):
	return tr("SEXACTION_NIPPLEFUCK_ONGOING_DESC_1")

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() < 1 || givers.size() > 2:
		valid = false
	else:
		for i in givers:
			if i.person.get_stat('penis_size') == '':
				valid = false
		for i in takers:
			if !i.person_mods.has("upgrade_nipples"):
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 220, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 5}
	return effects

func initiate():
	return tr("SEXACTION_NIPPLEFUCK_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_NIPPLEFUCK_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_NIPPLEFUCK_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_NIPPLEFUCK_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_NIPPLEFUCK_REACTION_3")
	else:
		text = tr("SEXACTION_NIPPLEFUCK_REACTION_4")
	return text
