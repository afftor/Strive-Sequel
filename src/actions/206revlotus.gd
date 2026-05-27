extends Reference

const category = 'fucking'
const code = 'revlotus'
const order = 4
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
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_REVLOTUS_GIVER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_REVLOTUS_G_CHOICE_THRUST", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_G_THRUST_LOVE_1", "INTERACTION_ENTHUSIASM_REVLOTUS_G_THRUST_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_G_THRUST_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_REVLOTUS_G_CHOICE_CONTROL", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_G_CONTROL_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_G_CONTROL_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_REVLOTUS_G_CHOICE_REACH", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_G_REACH_LOVE_1", "INTERACTION_ENTHUSIASM_REVLOTUS_G_REACH_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_G_REACH_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_REVLOTUS_G_CHOICE_TOUCH", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_G_TOUCH_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_G_TOUCH_HATE_1"]},
	],
	training_upgrades = [{skill = 'penetration', target = 'skilled'}],
}

const enthusiasm_taker = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_REVLOTUS_TAKER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_REVLOTUS_T_CHOICE_FASTER", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_T_FASTER_LOVE_1", "INTERACTION_ENTHUSIASM_REVLOTUS_T_FASTER_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_T_FASTER_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_REVLOTUS_T_CHOICE_GUIDE", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_T_GUIDE_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_T_GUIDE_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_REVLOTUS_T_CHOICE_PRAISE", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_T_PRAISE_LOVE_1", "INTERACTION_ENTHUSIASM_REVLOTUS_T_PRAISE_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_T_PRAISE_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_REVLOTUS_T_CHOICE_HAND", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_T_HAND_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_REVLOTUS_T_HAND_HATE_1"]},
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
	return tr("SEXACTION_LAP_SITTING")

func getongoingname(givers, takers):
	return tr("SEXACTION_REVLOTUS_ONGOING_1")

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
const facing = false

const initiate = ['start_1_revlotus','start_2_sexv']

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
		"SEXACTION_REVLOTUS_ACT_1",
	]},
	
},

main_3_sex = {
	
	locational = {
	conditions = {
	},
	lines = [
		". ",
		"SEXACTION_REVLOTUS_ACT_3",
	]},
	
},

react_3_sexv = {
	
	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_REVLOTUS_ACT_4",
	]},
	
},

}
