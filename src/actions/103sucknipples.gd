extends Reference

const category = 'caress'
const code = 'sucknipples'
const order = 4
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = ''
const virginloss = false
const givertags = ['oral','noorgasm']
const takertags = ['tits']
const giver_skill = ['oral']
const taker_skill = []
const consent_level = 20

const consent_giver = 0
const consent_taker = 2

const parallel = true
const facing = true
const linkset = "none"

const initiate = ['start_sucknipples']
const ongoing = ['ongoing_sucknipples']
const reaction = ['react_sucknipples', 'react_2_sex', 'react_sucknipples_skill']

func getname(state = null):
	return tr("SEXACTION_NIPPLE_SUCKING")

func getongoingname(givers, takers):
	return tr("SEXACTION_SUCKNIPPLES_ONGOING_1")

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
	return valid

func givereffect(member):
	var effects = {sens = 80}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 40}
	if member.person.get_stat('sex') == 'male':
		effects.sens /= 1.3
	return effects

const act_lines = {

start_sucknipples = {

	nice = {
	conditions = {
		consent = [true],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_START_NICE_1",
		"SEXACTION_SUCKNIPPLES_START_NICE_2",
	]},

	mean = {
	conditions = {
		consent = [false],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_START_MEAN_1",
		"SEXACTION_SUCKNIPPLES_START_MEAN_2",
	]},

	novice_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_START_NOVICE_NICE_1",
	]},

	novice_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_START_NOVICE_MEAN_1",
	]},

	skilled_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_START_SKILLED_NICE_1",
	]},

	skilled_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_START_SKILLED_MEAN_1",
	]},

	mastered_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_START_MASTERED_NICE_1",
	]},

	mastered_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_START_MASTERED_MEAN_1",
	]},

},

ongoing_sucknipples = {

	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_ONGOING_DESC_FULL_1",
		"SEXACTION_SUCKNIPPLES_ONGOING_DESC_FULL_2",
		"SEXACTION_SUCKNIPPLES_ONGOING_DESC_FULL_3",
	]},

},

react_sucknipples = {

	arousal_4_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_AROUSAL4_NICE_1",
		"SEXACTION_SUCKNIPPLES_REACT_AROUSAL4_NICE_2",
	]},

	arousal_4_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_AROUSAL4_MEAN_1",
	]},

	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_AROUSAL3_NICE_1",
		"SEXACTION_SUCKNIPPLES_REACT_AROUSAL3_NICE_2",
	]},

	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_AROUSAL3_MEAN_1",
	]},

	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_AROUSAL2_NICE_1",
	]},

	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_AROUSAL2_MEAN_1",
	]},

	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_AROUSAL1_NICE_1",
	]},

	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_AROUSAL1_MEAN_1",
		"SEXACTION_SUCKNIPPLES_REACT_AROUSAL1_MEAN_2",
	]},

},

react_sucknipples_skill = {

	giver_novice_low = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_SKILL_NOVICE_LOW_1",
	]},

	giver_novice_high = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_SKILL_NOVICE_HIGH_1",
	]},

	giver_skilled_low = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_SKILL_SKILLED_LOW_1",
	]},

	giver_skilled_high = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_SKILL_SKILLED_HIGH_1",
	]},

	giver_mastered_low = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_SKILL_MASTERED_LOW_1",
	]},

	giver_mastered_high = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_SUCKNIPPLES_REACT_SKILL_MASTERED_HIGH_1",
	]},

},

}
