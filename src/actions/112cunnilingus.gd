extends Reference

const category = 'caress'
const code = 'cunnilingus'
const order = 7
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = 'clit'
const virginloss = false
const givertags = ['oral','noorgasm','sub']
const takertags = ['vagina','dom']
const giver_skill = ['oral']
const taker_skill = ['pussy']
const consent_level = 15

const consent_giver = 2
const consent_taker = 3

const parallel = true
const facing = true
const linkset = "none"

const initiate = ['start_cunnilingus']
const ongoing = ['ongoing_cunnilingus']
const reaction = ['react_cunnilingus', 'react_2_sex', 'react_cunnilingus_skill']

const enthusiasm_giver = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_CUNNILINGUS_GIVER",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	orgasm_target = 'partner',
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_CUNNILINGUS_G_CHOICE_GUIDE", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_CUNNILINGUS_G_GUIDE_LOVE_1", "INTERACTION_ENTHUSIASM_CUNNILINGUS_G_GUIDE_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_CUNNILINGUS_G_GUIDE_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_CUNNILINGUS_G_CHOICE_STEADY", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_CUNNILINGUS_G_STEADY_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_CUNNILINGUS_G_STEADY_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_CUNNILINGUS_G_CHOICE_TOUCH", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_CUNNILINGUS_G_TOUCH_LOVE_1", "INTERACTION_ENTHUSIASM_CUNNILINGUS_G_TOUCH_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_CUNNILINGUS_G_TOUCH_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_CUNNILINGUS_G_CHOICE_PRAISE", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_CUNNILINGUS_G_PRAISE_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_CUNNILINGUS_G_PRAISE_HATE_1"]},
	],
	training_upgrades = [{skill = 'oral', target = 'skilled'}],
}

func getname(state = null):
	return tr("SEXACTION_CUNNILINGUS")

func getongoingname(givers, takers):
	return tr("SEXACTION_CUNNILINGUS_ONGOING_1")

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
		for i in takers:
			if i.person.get_stat('has_pussy') == false:
				valid = false
			elif i.person.get_stat('sex') == 'male':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 90}
	return effects

func takereffect(member):
	var effects = {sens = 180, horny = 45}
	return effects

const act_lines = {

start_cunnilingus = {

	nice = {
	conditions = {
		consent = [true],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_START_NICE_1",
		"SEXACTION_CUNNILINGUS_START_NICE_2",
	]},

	mean = {
	conditions = {
		consent = [false],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_START_MEAN_1",
		"SEXACTION_CUNNILINGUS_START_MEAN_2",
	]},

	novice_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_START_NOVICE_NICE_1",
	]},

	novice_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_START_NOVICE_MEAN_1",
	]},

	skilled_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_START_SKILLED_NICE_1",
	]},

	skilled_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_START_SKILLED_MEAN_1",
	]},

	mastered_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_START_MASTERED_NICE_1",
	]},

	mastered_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_START_MASTERED_MEAN_1",
	]},

},

ongoing_cunnilingus = {

	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_CUNNILINGUS_ONGOING_DESC_1",
		"SEXACTION_CUNNILINGUS_ONGOING_DESC_2",
	]},

},

react_cunnilingus = {

	arousal_4_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_AROUSAL4_NICE_1",
		"SEXACTION_CUNNILINGUS_REACT_AROUSAL4_NICE_2",
	]},

	arousal_4_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_AROUSAL4_MEAN_1",
	]},

	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_AROUSAL3_NICE_1",
		"SEXACTION_CUNNILINGUS_REACT_AROUSAL3_NICE_2",
	]},

	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_AROUSAL3_MEAN_1",
	]},

	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_AROUSAL2_NICE_1",
	]},

	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_AROUSAL2_MEAN_1",
	]},

	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_AROUSAL1_NICE_1",
	]},

	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_AROUSAL1_MEAN_1",
		"SEXACTION_CUNNILINGUS_REACT_AROUSAL1_MEAN_2",
	]},

},

react_cunnilingus_skill = {

	giver_novice_low = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_SKILL_NOVICE_LOW_1",
	]},

	giver_novice_high = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_SKILL_NOVICE_HIGH_1",
	]},

	giver_skilled_low = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_SKILL_SKILLED_LOW_1",
	]},

	giver_skilled_high = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_SKILL_SKILLED_HIGH_1",
	]},

	giver_mastered_low = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_SKILL_MASTERED_LOW_1",
	]},

	giver_mastered_high = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_CUNNILINGUS_REACT_SKILL_MASTERED_HIGH_1",
	]},

},

}
