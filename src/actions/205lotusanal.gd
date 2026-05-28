extends Reference

const category = 'fucking'
const code = 'lotusanal'
const order = 7
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'anus'
const virginloss = true
const givertags = ['penis']
const takertags = ['anal', 'penetration']
const giver_skill = ['penetration']
const taker_skill = ['anal']
const consent_level = 30

const consent_giver = 4
const consent_taker = 5

const enthusiasm_giver = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_LOTUSANAL_GIVER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_LOTUS_G_CHOICE_PULL", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_LOTUS_G_PULL_LOVE_1", "INTERACTION_ENTHUSIASM_LOTUS_G_PULL_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_LOTUS_G_PULL_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_LOTUS_G_CHOICE_GUIDE", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_LOTUS_G_GUIDE_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_LOTUS_G_GUIDE_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_LOTUS_G_CHOICE_KISS", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_LOTUS_G_KISS_LOVE_1", "INTERACTION_ENTHUSIASM_LOTUS_G_KISS_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_LOTUS_G_KISS_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_LOTUS_G_CHOICE_HOLD", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_LOTUS_G_HOLD_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_LOTUS_G_HOLD_HATE_1"]},
	],
	training_upgrades = [{skill = 'penetration', target = 'skilled'}],
}

const enthusiasm_taker = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_LOTUSANAL_TAKER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_LOTUS_T_CHOICE_GRIP", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_LOTUS_T_GRIP_LOVE_1", "INTERACTION_ENTHUSIASM_LOTUS_T_GRIP_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_LOTUS_T_GRIP_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_LOTUS_T_CHOICE_STEADY", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_LOTUS_T_STEADY_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_LOTUS_T_STEADY_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_LOTUS_T_CHOICE_KISS", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_LOTUS_T_KISS_LOVE_1", "INTERACTION_ENTHUSIASM_LOTUS_T_KISS_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_LOTUS_T_KISS_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_LOTUS_T_CHOICE_FOREHEADS", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_LOTUS_T_FOREHEADS_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_LOTUS_T_FOREHEADS_HATE_1"]},
	],
	training_upgrades = [{skill = 'anal', target = 'skilled'}],
}

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
#	elif givers.size() + takers.size() == 2 && (!givers[0].penis in [takers[0].vagina, takers[0].anus] ):
#		valid = false
	for i in givers:
		if i.person.get_stat('penis_size') == '' && i.strapon == false:
			valid = false
#		elif i.penis != null && givers.size() > 1:
#			valid = false
#	for i in takers:
#		if i.anus != null && takers.size() > 1:
#			valid = false
	
	return valid

func getname(state = null):
	if givers.size() == 0 || takers.size() == 0:
		return tr("SEXACTION_LOTUS_ANAL")
	elif givers[0].strapon == true && givers[0].person.get_stat('penis_size') != '':
		return tr("SEXACTION_LOTUS_PEGGING")
	else:
		return tr("SEXACTION_LOTUS_ANAL")

func getongoingname(givers, takers):
	return tr("SEXACTION_LOTUSANAL_ONGOING_1")

func givereffect(member):
	var effects = {sens = 200}
	if member.person.get_stat('penis_size') == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 180}
	
	return effects

#orientation of givers/takers
const parallel = true
const facing = true

const initiate = ['start_1_lotus','start_2_sexa']

const ongoing = ['main_1_sexa','main_2_sexa','main_3_sex']

const reaction = ['react_1_sex','react_2_sex','react_3_sexa']

const linkset = "sex"

const act_lines = {

start_2_sexa = {
	
	shift = {
	conditions = {
		orifice = ["shift"],
	},
	lines = [
		"SEXACTION_LOTUSANAL_ACT_1",
	]},
	
},

main_3_sex = {
	
	locational = {
	conditions = {
	},
	lines = [
		". ",
		"SEXACTION_LOTUSANAL_ACT_3",
	]},
	
},

react_3_sexa = {
	
	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_LOTUSANAL_ACT_4",
	]},
	
},

}
