extends Reference

const category = 'fucking'
const code = 'lotus'
const order = 3
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'vagina'
const virginloss = true
const givertags = ['penis']
const takertags = ['vagina', 'penetration']
const giver_skill = ['penetration']
const taker_skill = ['pussy']
const consent_level = 25

const consent_giver = 3
const consent_taker = 4

const enthusiasm_giver = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_LOTUS_GIVER",
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
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_LOTUS_TAKER",
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
	training_upgrades = [{skill = 'pussy', target = 'skilled'}],
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
	for i in takers:
		if i.person.get_stat('has_pussy') == false:
			valid = false
#		elif i.vagina != null && takers.size() > 1:
#			valid = false
	
	return valid

func getname(state = null):
	return tr("SEXACTION_LOTUS")

func getongoingname(givers, takers):
	return tr("SEXACTION_LOTUS_ONGOING_1")

func givereffect(member):
	var effects = {sens = 220}
	if member.person.get_stat('penis_size') == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 200}
	return effects

#orientation of givers/takers
const parallel = true
const facing = true

const initiate = ['start_1_lotus','start_2_sexv']

const ongoing = ['main_1_sexv','main_2_sexv','main_3_sex']

const reaction = ['react_1_sex','react_2_sex','react_3_sexv']

const linkset = "sex"

const act_lines = {

start_2_sexv = {
	
	shift = {
	conditions = {
		orifice = ["shift"],
	},
	lines = [
		"SEXACTION_LOTUS_ACT_1",
	]},
	
},

main_3_sex = {
	
	locational = {
	conditions = {
	},
	lines = [
		". ",
		"SEXACTION_LOTUS_ACT_3",
	]},
	
},

react_3_sexv = {
	
	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_LOTUS_ACT_4",
	]},
	
},

}
