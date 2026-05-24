extends Reference

const category = 'fucking'
const code = 'missionaryanal'
const order = 5
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'anus'
const virginloss = true
const givertags = ['penis','dom']
const takertags = ['anal', 'penetration','sub']
const giver_skill = ['penetration']
const taker_skill = ['anal']
const consent_level = 30
const consent_giver = 4
const consent_taker = 5

const enthusiasm_giver = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_MISSIONARYANAL_GIVER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_MISSIONARY_G_CHOICE_HARDER", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_G_HARDER_LOVE_1", "INTERACTION_ENTHUSIASM_MISSIONARY_G_HARDER_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_G_HARDER_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_MISSIONARY_G_CHOICE_CONTROL", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_G_CONTROL_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_G_CONTROL_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_MISSIONARY_G_CHOICE_PRAISE", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_G_PRAISE_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_G_PRAISE_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_MISSIONARY_G_CHOICE_HOLD", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_G_HOLD_LOVE_1", "INTERACTION_ENTHUSIASM_MISSIONARY_G_HOLD_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_G_HOLD_HATE_1"]},
	],
	training_upgrades = [{skill = 'penetration', target = 'skilled'}],
}

const enthusiasm_taker = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_MISSIONARYANAL_TAKER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_MISSIONARY_T_CHOICE_PIN", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_T_PIN_LOVE_1", "INTERACTION_ENTHUSIASM_MISSIONARY_T_PIN_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_T_PIN_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_MISSIONARY_T_CHOICE_STILLNESS", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_T_STILLNESS_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_T_STILLNESS_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_MISSIONARY_T_CHOICE_ENCOURAGE", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_T_ENCOURAGE_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_T_ENCOURAGE_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_MISSIONARY_T_CHOICE_FREE", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_T_FREE_LOVE_1", "INTERACTION_ENTHUSIASM_MISSIONARY_T_FREE_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_MISSIONARY_T_FREE_HATE_1"]},
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
	
	return tr("SEXACTION_MISSIONARY_ANAL")

func getongoingname(givers, takers):
	return tr("SEXACTION_MISSIONARYANAL_ONGOING_1")

func givereffect(member):
	var effects = {sens = 200}
	if member.person.get_stat('penis_size') == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 190}
	return effects

#orientation of givers/takers
const parallel = true
const facing = true

const initiate = ['start_1_missionary','start_2_sexa']

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
		"SEXACTION_MISSIONARYANAL_ACT_1",
	]},
	
	insert = {
	conditions = {
		orifice = ["insert"],
	},
	lines = [
		"SEXACTION_MISSIONARYANAL_ACT_2",
	]},
	
},

main_3_sex = {
	
	locational = {
	conditions = {
	},
	lines = [
		". ",
		"SEXACTION_MISSIONARYANAL_ACT_4",
	]},
	
},

react_3_sexa = {
	
	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_MISSIONARYANAL_ACT_5",
	]},
	
},

}
