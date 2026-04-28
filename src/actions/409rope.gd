extends Reference

const category = 'SM'
const code = 'rope'
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = 'acc4'#body extra to change some getname into restrained getname
const virginloss = false
const givertags = []
const takertags = ['punish']
const giver_skill = []
const taker_skill = []
const consent_level = 25

const consent_giver = 0
const consent_taker = 0

func getname(state = null):
	return tr("SEXACTION_ROPE")

func getongoingname(givers, takers):
	return tr("SEXACTION_ROPE_ONGOING_1")

func getongoingdescription(givers, takers):
	return ""
	
func requirements():
	var valid = true
#	if ResourceScripts.game_res.materials.rope < takers.size():
#		valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
	for i in givers + takers:
		if i.limbs == false:
			valid = false
#	for i in givers:
#		if !i.person.has_status('sex_adv'):
#			valid = false
	return valid

func givereffect(member):
	var effects = {}
	return effects

func takereffect(member):
	var effects = {}
	return effects

func initiate():
	for i in takers:
		ResourceScripts.game_res.materials.rope -= 1
		i.effects.append('tied')
	return tr("SEXACTION_ROPE_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_ROPE_REACTION_UNCONSCIOUS")

	return text
