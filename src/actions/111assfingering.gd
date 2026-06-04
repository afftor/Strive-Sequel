extends Reference

const category = 'caress'
const code = 'assfingering'
const order = 6
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'anus'
const virginloss = false
const givertags = ['pet', 'noorgasm']
const takertags = ['pet', 'anal']
const giver_skill = ['petting']
const taker_skill = ['anal']
const consent_level = 25

const consent_giver = 0
const consent_taker = 3

const parallel = true
const facing = true
const linkset = "caress"

const initiate = ['start_assfingering']
const ongoing = ['ongoing_assfingering']
const reaction = ['react_assfingering', 'react_2_sex', 'react_assfingering_skill']

func getname(state = null):
	return tr("SEXACTION_ASS_FINGERING")

func getongoingname(givers, takers):
	return tr("SEXACTION_ASSFINGERING_ONGOING_1")

func requirements():
	var valid = true
	for i in givers:
		if i.limbs == false:
			valid = false
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	return valid

const enthusiasm = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_ASSFINGERING",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	orgasm_target = 'partner',
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_ASSFINGERING_CHOICE_DEEPER", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_ASSFINGERING_DEEPER_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_ASSFINGERING_DEEPER_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_ASSFINGERING_CHOICE_RHYTHM", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_ASSFINGERING_RHYTHM_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_ASSFINGERING_RHYTHM_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_ASSFINGERING_CHOICE_STEADY", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_ASSFINGERING_STEADY_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_ASSFINGERING_STEADY_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_ASSFINGERING_CHOICE_PRAISE", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_ASSFINGERING_PRAISE_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_ASSFINGERING_PRAISE_HATE_1"]},
	],
	training_upgrades = [{skill = 'petting', target = 'skilled'}],
}

func givereffect(member):
	var effects = {lust = 75}
	return effects

func takereffect(member):
	var effects = {sens = 120, horny = 30}
	return effects

const act_lines = {

start_assfingering = {

	from_front_nice = {
	conditions = {
		link_facing = [true],
		consent = [true],
	},
	lines = [
		"SEXACTION_ASSFINGERING_FROM_FRONT_NICE_1",
		"SEXACTION_ASSFINGERING_FROM_FRONT_NICE_2",
	]},

	from_front_mean = {
	conditions = {
		link_facing = [true],
		consent = [false],
	},
	lines = [
		"SEXACTION_ASSFINGERING_FROM_FRONT_MEAN_1",
	]},

	nice = {
	conditions = {
		link_facing = [false, null],
		consent = [true],
	},
	lines = [
		"SEXACTION_ASSFINGERING_START_NICE_1",
		"SEXACTION_ASSFINGERING_START_NICE_2",
	]},

	mean = {
	conditions = {
		link_facing = [false, null],
		consent = [false],
	},
	lines = [
		"SEXACTION_ASSFINGERING_START_MEAN_1",
		"SEXACTION_ASSFINGERING_START_MEAN_2",
	]},

	novice_nice = {
	conditions = {
		link_facing = [false, null],
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_ASSFINGERING_START_NOVICE_NICE_1",
	]},

	novice_mean = {
	conditions = {
		link_facing = [false, null],
		consent = [false],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_ASSFINGERING_START_NOVICE_MEAN_1",
	]},

	skilled_nice = {
	conditions = {
		link_facing = [false, null],
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_ASSFINGERING_START_SKILLED_NICE_1",
	]},

	skilled_mean = {
	conditions = {
		link_facing = [false, null],
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_ASSFINGERING_START_SKILLED_MEAN_1",
	]},

	mastered_nice = {
	conditions = {
		link_facing = [false, null],
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_ASSFINGERING_START_MASTERED_NICE_1",
	]},

	mastered_mean = {
	conditions = {
		link_facing = [false, null],
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_ASSFINGERING_START_MASTERED_MEAN_1",
	]},

},

ongoing_assfingering = {

	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_ASSFINGERING_ONGOING_DESC_1",
		"SEXACTION_ASSFINGERING_ONGOING_DESC_2",
	]},

},

react_assfingering = {

	arousal_4_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_AROUSAL4_NICE_1",
		"SEXACTION_ASSFINGERING_REACT_AROUSAL4_NICE_2",
	]},

	arousal_4_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_AROUSAL4_MEAN_1",
	]},

	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_AROUSAL3_NICE_1",
		"SEXACTION_ASSFINGERING_REACT_AROUSAL3_NICE_2",
	]},

	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_AROUSAL3_MEAN_1",
	]},

	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_AROUSAL2_NICE_1",
	]},

	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_AROUSAL2_MEAN_1",
	]},

	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_AROUSAL1_NICE_1",
	]},

	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_AROUSAL1_MEAN_1",
		"SEXACTION_ASSFINGERING_REACT_AROUSAL1_MEAN_2",
	]},

},

react_assfingering_skill = {

	giver_novice_low = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_SKILL_NOVICE_LOW_1",
	]},

	giver_novice_high = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_SKILL_NOVICE_HIGH_1",
	]},

	giver_skilled_low = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_SKILL_SKILLED_LOW_1",
	]},

	giver_skilled_high = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_SKILL_SKILLED_HIGH_1",
	]},

	giver_mastered_low = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_SKILL_MASTERED_LOW_1",
	]},

	giver_mastered_high = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_ASSFINGERING_REACT_SKILL_MASTERED_HIGH_1",
	]},

},

}
