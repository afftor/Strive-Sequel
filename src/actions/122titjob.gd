extends Reference

const category = 'caress'
const code = 'titjob'
const order = 7
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'penis'
const virginloss = false
const givertags = ['pet','noorgasm', 'tits']
const takertags = ['pet','penis']
const giver_skill = ['petting']
const taker_skill = []
const consent_level = 20

const consent_giver = 2
const consent_taker = 3

const parallel = true
const facing = true

const linkset = "none"
const initiate = ['start_titjob']
const ongoing = ['ongoing_titjob']
const reaction = ['react_titjob', 'react_2_sex', 'react_titjob_skill']

func getname(state = null):
	if givers.size() + takers.size() == 2:
		return tr("SEXACTION_TITJOB")
	else:
		return tr("SEXACTION_SMLT_TITJOB")

func getongoingname(givers, takers):
	return tr("SEXACTION_TITJOB_ONGOING_1")

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	else:
		for i in givers:
			if i.person.get_stat('tits_size') in ['masculine','flat']:
				valid = false
			if i.limbs == false:
				valid = false
		for i in takers:
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 90}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 45}
	return effects

const act_lines = {

start_titjob = {

	nice = {
	conditions = {
		consent = [true],
	},
	lines = [
		"SEXACTION_TITJOB_START_NICE_1",
	]},

	mean = {
	conditions = {
		consent = [false],
	},
	lines = [
		"SEXACTION_TITJOB_START_MEAN_1",
		"SEXACTION_TITJOB_START_MEAN_2",
	]},

	novice_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_TITJOB_START_NOVICE_NICE_1",
	]},

	novice_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_TITJOB_START_NOVICE_MEAN_1",
	]},

	skilled_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_TITJOB_START_SKILLED_NICE_1",
	]},

	skilled_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_TITJOB_START_SKILLED_MEAN_1",
	]},

	mastered_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_TITJOB_START_MASTERED_NICE_1",
	]},

	mastered_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_TITJOB_START_MASTERED_MEAN_1",
	]},

},

ongoing_titjob = {

	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_TITJOB_ONGOING_DESC_1",
	]},

},

react_titjob = {

	arousal_4_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_AROUSAL4_NICE_1",
		"SEXACTION_TITJOB_REACT_AROUSAL4_NICE_2",
	]},

	arousal_4_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_AROUSAL4_MEAN_1",
		"SEXACTION_TITJOB_REACT_AROUSAL4_MEAN_2",
	]},

	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_AROUSAL3_NICE_1",
		"SEXACTION_TITJOB_REACT_AROUSAL3_NICE_2",
	]},

	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_AROUSAL3_MEAN_1",
		"SEXACTION_TITJOB_REACT_AROUSAL3_MEAN_2",
	]},

	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_AROUSAL2_NICE_1",
	]},

	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_AROUSAL2_MEAN_1",
	]},

	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_AROUSAL1_NICE_1",
	]},

	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_AROUSAL1_MEAN_1",
		"SEXACTION_TITJOB_REACT_AROUSAL1_MEAN_2",
	]},

},

react_titjob_skill = {

	giver_novice_low = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_SKILL_NOVICE_LOW_1",
	]},

	giver_novice_high = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_SKILL_NOVICE_HIGH_1",
	]},

	giver_skilled_low = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_SKILL_SKILLED_LOW_1",
	]},

	giver_skilled_high = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_SKILL_SKILLED_HIGH_1",
	]},

	giver_mastered_low = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_SKILL_MASTERED_LOW_1",
	]},

	giver_mastered_high = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_TITJOB_REACT_SKILL_MASTERED_HIGH_1",
	]},

},

}
