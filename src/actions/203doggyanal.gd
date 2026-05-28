extends Reference

const category = 'fucking'
const code = 'doggyanal'
const order = 6
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
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_DOGGYANAL_GIVER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_DOGGY_G_CHOICE_PULL", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_DOGGY_G_PULL_LOVE_1", "INTERACTION_ENTHUSIASM_DOGGY_G_PULL_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_DOGGY_G_PULL_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_DOGGY_G_CHOICE_DEEPER", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_DOGGY_G_DEEPER_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_DOGGY_G_DEEPER_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_DOGGY_G_CHOICE_LEAN", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_DOGGY_G_LEAN_LOVE_1", "INTERACTION_ENTHUSIASM_DOGGY_G_LEAN_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_DOGGY_G_LEAN_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_DOGGY_G_CHOICE_DONTSTOP", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_DOGGY_G_DONTSTOP_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_DOGGY_G_DONTSTOP_HATE_1"]},
	],
	training_upgrades = [{skill = 'penetration', target = 'skilled'}],
}

const enthusiasm_taker = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_DOGGYANAL_TAKER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_DOGGY_T_CHOICE_PUSHBACK", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_DOGGY_T_PUSHBACK_LOVE_1", "INTERACTION_ENTHUSIASM_DOGGY_T_PUSHBACK_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_DOGGY_T_PUSHBACK_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_DOGGY_T_CHOICE_STILLNESS", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_DOGGY_T_STILLNESS_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_DOGGY_T_STILLNESS_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_DOGGY_T_CHOICE_STROKE", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_DOGGY_T_STROKE_LOVE_1", "INTERACTION_ENTHUSIASM_DOGGY_T_STROKE_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_DOGGY_T_STROKE_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_DOGGY_T_CHOICE_HAND", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_DOGGY_T_HAND_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_DOGGY_T_HAND_HATE_1"]},
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
		return tr("SEXACTION_DOGGY_ANAL")
	elif givers[0].strapon == true && takers[0].person.get_stat('penis_size') != '':
		return tr("SEXACTION_DOGGY_PEGGING")
	else:
		return tr("SEXACTION_DOGGY_ANAL")

func getongoingname(givers, takers):
	return tr("SEXACTION_DOGGYANAL_ONGOING_1")

func givereffect(member):
	var effects = {sens = 200}
	return effects

func takereffect(member):
	var effects = {sens = 190}
	if member.person.get_stat('penis_size') == '':
		effects.sens /= 1.2
	return effects

#orientation of givers/takers
const parallel = false
const facing = false

const initiate = ['start_1_doggy','start_2_sexa']

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
		"SEXACTION_DOGGYANAL_ACT_1",
	]},
	
	insert = {
	conditions = {
		orifice = ["insert"],
	},
	lines = [
		"SEXACTION_DOGGYANAL_ACT_2",
		"SEXACTION_DOGGYANAL_ACT_3",
	]},
	
},

main_3_sex = {
	
	locational = {
	conditions = {
	},
	lines = [
		". ",
		"SEXACTION_DOGGYANAL_ACT_5",
		"SEXACTION_DOGGYANAL_ACT_6",
	]},
	
},

react_3_sexa = {
	
	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_DOGGYANAL_ACT_7",
	]},
	
},

}
