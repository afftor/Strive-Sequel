extends Reference

const category = 'caress'
const code = 'kiss'
const order = 2
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = 'mouth'
const virginloss = false
const givertags = ['oral','noorgasm']
const takertags = ['oral','noorgasm']
const giver_skill = ['oral']
const taker_skill = ['oral']
const consent_level = 15

const consent_giver = 1
const consent_taker = 1

const parallel = true
const facing = true

const linkset = "caress"

const initiate = ['start_kiss']
const ongoing = ['ongoing_kiss']
const reaction = ['react_kiss', 'react_2_sex', 'react_kiss_skill']

func getname(state = null):
	if givers.size() == 0 || takers.size() == 0:
		return tr("SEXACTION_KISS")
	elif givers.size() > 1 || takers.size() > 1:
		return tr("SEXACTION_DOUBLE_KISS")
	else:
		return tr("SEXACTION_KISS")

func getongoingname(givers, takers):
	return tr("SEXACTION_KISS_ONGOING_1")

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	return valid

func givereffect(member):
	var effects = {sens = 120}
	return effects

func takereffect(member):
	var effects = {sens = 120, horny = 35}
	return effects

const act_lines = {

start_kiss = {

	from_behind_nice = {
	conditions = {
		link_facing = [false],
		consent = [true],
	},
	lines = [
		"SEXACTION_KISS_FROM_BEHIND_NICE_1",
		"SEXACTION_KISS_FROM_BEHIND_NICE_2",
	]},

	from_behind_mean = {
	conditions = {
		link_facing = [false],
		consent = [false],
	},
	lines = [
		"SEXACTION_KISS_FROM_BEHIND_MEAN_1",
	]},

	nice = {
	conditions = {
		link_facing = [true, null],
		consent = [true],
	},
	lines = [
		"SEXACTION_KISS_INITIATE_1",
		"SEXACTION_KISS_INITIATE_2",
		"SEXACTION_KISS_INITIATE_3",
	]},

	mean = {
	conditions = {
		link_facing = [true, null],
		consent = [false],
	},
	lines = [
		"SEXACTION_KISS_INITIATE_1",
		"SEXACTION_KISS_INITIATE_3",
	]},

	novice_nice = {
	conditions = {
		link_facing = [true, null],
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_KISS_INITIATE_NOVICE_NICE_1",
		"SEXACTION_KISS_INITIATE_NOVICE_NICE_2",
	]},

	novice_mean = {
	conditions = {
		link_facing = [true, null],
		consent = [false],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_KISS_INITIATE_NOVICE_MEAN_1",
	]},

	skilled_nice = {
	conditions = {
		link_facing = [true, null],
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_KISS_INITIATE_SKILLED_NICE_1",
		"SEXACTION_KISS_INITIATE_SKILLED_NICE_2",
	]},

	skilled_mean = {
	conditions = {
		link_facing = [true, null],
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_KISS_INITIATE_SKILLED_MEAN_1",
	]},

	mastered_nice = {
	conditions = {
		link_facing = [true, null],
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_KISS_INITIATE_MASTERED_NICE_1",
		"SEXACTION_KISS_INITIATE_MASTERED_NICE_2",
	]},

	mastered_mean = {
	conditions = {
		link_facing = [true, null],
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_KISS_INITIATE_MASTERED_MEAN_1",
	]},

},

ongoing_kiss = {

	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_KISS_ONGOING_DESC_1",
		"SEXACTION_KISS_ONGOING_DESC_2",
		"SEXACTION_KISS_ONGOING_DESC_3",
	]},

},

react_kiss = {

	arousal_4_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_KISS_REACT_AROUSAL4_NICE_1",
		"SEXACTION_KISS_REACT_AROUSAL4_NICE_2",
		"SEXACTION_KISS_REACT_AROUSAL4_NICE_3",
	]},

	arousal_4_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_KISS_REACT_AROUSAL4_MEAN_1",
		"SEXACTION_KISS_REACT_AROUSAL4_MEAN_2",
	]},

	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"SEXACTION_KISS_REACT_AROUSAL3_NICE_1",
		"SEXACTION_KISS_REACT_AROUSAL3_NICE_2",
	]},

	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		"SEXACTION_KISS_REACT_AROUSAL3_MEAN_1",
		"SEXACTION_KISS_REACT_AROUSAL3_MEAN_2",
	]},

	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"SEXACTION_KISS_REACT_AROUSAL2_NICE_1",
		"SEXACTION_KISS_REACT_AROUSAL2_NICE_2",
	]},

	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		"SEXACTION_KISS_REACT_AROUSAL2_MEAN_1",
	]},

	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"SEXACTION_KISS_REACT_AROUSAL1_NICE_1",
		"SEXACTION_KISS_REACT_AROUSAL1_NICE_2",
	]},

	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		"SEXACTION_KISS_REACT_AROUSAL1_MEAN_1",
		"SEXACTION_KISS_REACT_AROUSAL1_MEAN_2",
	]},

},

react_kiss_skill = {

	taker_novice_low = {
	conditions = {
		taker_skill_level = ['novice'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_KISS_REACT_SKILL_TAKER_NOVICE_LOW_1",
		"SEXACTION_KISS_REACT_SKILL_TAKER_NOVICE_LOW_2",
	]},

	taker_novice_high = {
	conditions = {
		taker_skill_level = ['novice'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_KISS_REACT_SKILL_TAKER_NOVICE_HIGH_1",
	]},

	taker_skilled_low = {
	conditions = {
		taker_skill_level = ['skilled'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_KISS_REACT_SKILL_TAKER_SKILLED_LOW_1",
		"SEXACTION_KISS_REACT_SKILL_TAKER_SKILLED_LOW_2",
	]},

	taker_skilled_high = {
	conditions = {
		taker_skill_level = ['skilled'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_KISS_REACT_SKILL_TAKER_SKILLED_HIGH_1",
		"SEXACTION_KISS_REACT_SKILL_TAKER_SKILLED_HIGH_2",
	]},

	taker_mastered_low = {
	conditions = {
		taker_skill_level = ['mastered'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_KISS_REACT_SKILL_TAKER_MASTERED_LOW_1",
	]},

	taker_mastered_high = {
	conditions = {
		taker_skill_level = ['mastered'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_KISS_REACT_SKILL_TAKER_MASTERED_HIGH_1",
		"SEXACTION_KISS_REACT_SKILL_TAKER_MASTERED_HIGH_2",
	]},

},

}
