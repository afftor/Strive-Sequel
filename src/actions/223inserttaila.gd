extends Reference

const category = 'fucking'
const code = 'inserttaila'
const order = 12
var givers
var takers
const canlast = true
const giverpart = 'tail'
const takerpart = 'anus'
const virginloss = true
const givertags = ['tail', 'noorgasm']
const takertags = ['anal', 'penetration']
const giver_skill = ['tail']
const taker_skill = ['anal']
const consent_level = 40
const consent_giver = 4
const consent_taker = 5

const linkset = "tail"

const initiate = ['start_inserttaila']
const ongoing = ['ongoing_inserttaila']
const reaction = ['react_inserttaila', 'react_inserttaila_skill']

func getname(state = null):
	return tr("SEXACTION_INSERT_TAIL_ASS")

func getongoingname(givers, takers):
	return tr("SEXACTION_INSERTTAILA_ONGOING_1")

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
		for i in givers:
			if i.limbs == false:
				valid = false
			if !variables.longtails.has(i.person.get_stat('tail')):
				valid = false
	return valid

const enthusiasm_giver = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_INSERTTAILA_GIVER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	orgasm_target = 'partner',
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_INSERTTAIL_G_CHOICE_DEEPER", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_G_DEEPER_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_G_DEEPER_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_INSERTTAIL_G_CHOICE_RHYTHM", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_G_RHYTHM_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_G_RHYTHM_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_INSERTTAIL_G_CHOICE_TOUCH", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_G_TOUCH_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_G_TOUCH_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_INSERTTAIL_G_CHOICE_PRAISE", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_G_PRAISE_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_G_PRAISE_HATE_1"]},
	],
	training_upgrades = [{skill = 'tail', target = 'skilled'}],
}

const enthusiasm_taker = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_INSERTTAILA_TAKER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_INSERTTAIL_T_CHOICE_PRESS", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_T_PRESS_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_T_PRESS_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_INSERTTAIL_T_CHOICE_STEADY", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_T_STEADY_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_T_STEADY_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_INSERTTAIL_T_CHOICE_HAND", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_T_HAND_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_T_HAND_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_INSERTTAIL_T_CHOICE_PRAISE", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_T_PRAISE_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_INSERTTAIL_T_PRAISE_HATE_1"]},
	],
	training_upgrades = [{skill = 'anal', target = 'skilled'}],
}

func givereffect(member):
	var effects = {sens = 90}
	return effects

func takereffect(member):
	var effects = {sens = 190}
	return effects

const act_lines = {

start_inserttaila = {

	shift = {
	conditions = {
		orifice = ["shift"],
	},
	lines = [
		"SEXACTION_INSERTTAILA_SHIFT_1",
	]},

	insert_furry_novice = {
	conditions = {
		orifice = ["insert"],
		giver_tail_type = ['furry'],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_INSERTTAILA_START_FURRY_NOVICE_1",
	]},

	insert_furry_skilled = {
	conditions = {
		orifice = ["insert"],
		giver_tail_type = ['furry'],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_INSERTTAILA_START_FURRY_SKILLED_1",
	]},

	insert_furry_mastered = {
	conditions = {
		orifice = ["insert"],
		giver_tail_type = ['furry'],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_INSERTTAILA_START_FURRY_MASTERED_1",
	]},

	insert_scaly_novice = {
	conditions = {
		orifice = ["insert"],
		giver_tail_type = ['scaly'],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_INSERTTAILA_START_SCALY_NOVICE_1",
	]},

	insert_scaly_skilled = {
	conditions = {
		orifice = ["insert"],
		giver_tail_type = ['scaly'],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_INSERTTAILA_START_SCALY_SKILLED_1",
	]},

	insert_scaly_mastered = {
	conditions = {
		orifice = ["insert"],
		giver_tail_type = ['scaly'],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_INSERTTAILA_START_SCALY_MASTERED_1",
	]},

},

ongoing_inserttaila = {

	furry_novice = {
	conditions = {
		giver_tail_type = ['furry'],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_INSERTTAILA_ONGOING_FURRY_NOVICE_1",
		"SEXACTION_INSERTTAILA_ONGOING_FURRY_NOVICE_2",
	]},

	furry_skilled = {
	conditions = {
		giver_tail_type = ['furry'],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_INSERTTAILA_ONGOING_FURRY_SKILLED_1",
		"SEXACTION_INSERTTAILA_ONGOING_FURRY_SKILLED_2",
	]},

	furry_mastered = {
	conditions = {
		giver_tail_type = ['furry'],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_INSERTTAILA_ONGOING_FURRY_MASTERED_1",
		"SEXACTION_INSERTTAILA_ONGOING_FURRY_MASTERED_2",
	]},

	scaly_novice = {
	conditions = {
		giver_tail_type = ['scaly'],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_INSERTTAILA_ONGOING_SCALY_NOVICE_1",
		"SEXACTION_INSERTTAILA_ONGOING_SCALY_NOVICE_2",
	]},

	scaly_skilled = {
	conditions = {
		giver_tail_type = ['scaly'],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_INSERTTAILA_ONGOING_SCALY_SKILLED_1",
		"SEXACTION_INSERTTAILA_ONGOING_SCALY_SKILLED_2",
	]},

	scaly_mastered = {
	conditions = {
		giver_tail_type = ['scaly'],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_INSERTTAILA_ONGOING_SCALY_MASTERED_1",
		"SEXACTION_INSERTTAILA_ONGOING_SCALY_MASTERED_2",
	]},

},

react_inserttaila = {

	arousal_4 = {
	conditions = {
		arousal = [4, 5],
	},
	lines = [
		"SEXACTION_INSERTTAILA_REACTION_4",
	]},

	arousal_3 = {
	conditions = {
		arousal = [3],
	},
	lines = [
		"SEXACTION_INSERTTAILA_REACTION_3",
	]},

	arousal_2 = {
	conditions = {
		arousal = [2],
	},
	lines = [
		"SEXACTION_INSERTTAILA_REACTION_2",
	]},

	arousal_1 = {
	conditions = {
		arousal = [1],
	},
	lines = [
		"SEXACTION_INSERTTAILA_REACTION_1",
	]},

},

react_inserttaila_skill = {

	novice_low = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [1, 2],
	},
	lines = [
		"SEXACTION_INSERTTAILA_SKILL_NOVICE_LOW_1",
	]},

	novice_high = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [3, 4, 5],
	},
	lines = [
		"SEXACTION_INSERTTAILA_SKILL_NOVICE_HIGH_1",
	]},

	skilled_low = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [1, 2],
	},
	lines = [
		"SEXACTION_INSERTTAILA_SKILL_SKILLED_LOW_1",
	]},

	skilled_high = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [3, 4, 5],
	},
	lines = [
		"SEXACTION_INSERTTAILA_SKILL_SKILLED_HIGH_1",
	]},

	mastered_low = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [1, 2],
	},
	lines = [
		"SEXACTION_INSERTTAILA_SKILL_MASTERED_LOW_1",
	]},

	mastered_high = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [3, 4, 5],
	},
	lines = [
		"SEXACTION_INSERTTAILA_SKILL_MASTERED_HIGH_1",
	]},

},

}
