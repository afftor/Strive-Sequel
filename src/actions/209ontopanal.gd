extends Reference

const category = 'fucking'
const code = 'ontopanal'
const order = 7
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'anus'
const virginloss = true
const givertags = ['penis','sub']
const takertags = ['anal', 'penetration','dom']
const giver_skill = ['penetration']
const taker_skill = ['anal']
const consent_level = 35

const consent_giver = 4
const consent_taker = 5

const enthusiasm_giver = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_ONTOPANAL_GIVER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_ONTOP_G_CHOICE_THRUST", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_ONTOP_G_THRUST_LOVE_1", "INTERACTION_ENTHUSIASM_ONTOP_G_THRUST_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_ONTOP_G_THRUST_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_ONTOP_G_CHOICE_GRIP", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_ONTOP_G_GRIP_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_ONTOP_G_GRIP_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_ONTOP_G_CHOICE_KISS", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_ONTOP_G_KISS_LOVE_1", "INTERACTION_ENTHUSIASM_ONTOP_G_KISS_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_ONTOP_G_KISS_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_ONTOP_G_CHOICE_HOLD", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_ONTOP_G_HOLD_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_ONTOP_G_HOLD_HATE_1"]},
	],
	training_upgrades = [{skill = 'penetration', target = 'skilled'}],
}

const enthusiasm_taker = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_ONTOPANAL_TAKER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_ONTOP_T_CHOICE_HARDER", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_ONTOP_T_HARDER_LOVE_1", "INTERACTION_ENTHUSIASM_ONTOP_T_HARDER_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_ONTOP_T_HARDER_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_ONTOP_T_CHOICE_BRACE", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_ONTOP_T_BRACE_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_ONTOP_T_BRACE_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_ONTOP_T_CHOICE_PRAISE", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_ONTOP_T_PRAISE_LOVE_1", "INTERACTION_ENTHUSIASM_ONTOP_T_PRAISE_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_ONTOP_T_PRAISE_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_ONTOP_T_CHOICE_LEAN", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_ONTOP_T_LEAN_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_ONTOP_T_LEAN_HATE_1"]},
	],
	training_upgrades = [{skill = 'anal', target = 'skilled'}],
}

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	for i in givers:
		if i.person.get_stat('penis_size') == '' && i.strapon == false:
			valid = false
	return valid

func getname(state = null):
	return tr("SEXACTION_ON_TOP_ANAL")

func getongoingname(givers, takers):
	return tr("SEXACTION_ONTOPANAL_ONGOING_1")

func givereffect(member):
	var effects = {sens = 230}
	if member.person.get_stat('penis_size') == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 210}
	return effects

#orientation of givers/takers
const parallel = true
const facing = false

const initiate = ['start_1_lotus','start_2_sexa']

const ongoing = ['main_1_sexa','main_2_sexa','main_3_sex']

const reaction = ['react_1_sex','react_2_sex','react_3_sexa']

const linkset = "sex"

const act_lines = {

start_2_sexv = {
	
	shift = {
	conditions = {
		orifice = ["shift"],
	},
	lines = [
		"SEXACTION_ONTOPANAL_ACT_1",
	]},
	
},

main_3_sex = {
	
	locational = {
	conditions = {
	},
	lines = [
		". ",
		"SEXACTION_ONTOPANAL_ACT_3",
	]},
	
},

react_3_sexv = {
	
	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_ONTOPANAL_ACT_4",
	]},
	
},

}
