extends Reference

const category = 'fucking'
const code = 'doggy'
const order = 2
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'vagina'
const virginloss = true
const givertags = ['penis','dom']
const takertags = ['vagina', 'penetration','sub']
const giver_skill = ['penetration']
const taker_skill = ['pussy']
const consent_level = 25

const consent_giver = 3
const consent_taker = 4

const enthusiasm_giver = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_DOGGY_GIVER",
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
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_DOGGY_TAKER",
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
	return tr("SEXACTION_DOGGY_STYLE")

func getongoingname(givers, takers):
	return tr("SEXACTION_DOGGY_ONGOING_1")

func givereffect(member):
	var effects = {sens = 220}
	if member.person.get_stat('penis_size') == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 200}
	return effects

#orientation of givers/takers
const parallel = false
const facing = false

const initiate = ['start_1_doggy','start_2_sexv']

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
		"SEXACTION_DOGGY_ACT_1",
	]},
	
	insert = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
	},
	lines = [
		"SEXACTION_DOGGY_ACT_2",
		"SEXACTION_DOGGY_ACT_3",
	]},
	
},

main_3_sex = {

	locational = {
	conditions = {
	},
	lines = [
		". ",
		"SEXACTION_DOGGY_ACT_5",
		"SEXACTION_DOGGY_ACT_6",
	]},

},

react_3_sexv = {
	
	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_DOGGY_ACT_7",
	]},
	
},

}
