extends Reference

const category = 'caress'
const code = 'handjob'
const order = 5
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'penis'
const virginloss = false
const givertags = ['pet','noorgasm']
const takertags = ['pet','penis']
const giver_skill = ['petting']
const taker_skill = []
const consent_level = 10

const consent_giver = 0
const consent_taker = 2

const parallel = true
const facing = true

const linkset = "caress"
const initiate = ['start_handjob']
const ongoing = ['ongoing_handjob']
const reaction = ['react_handjob', 'react_2_sex', 'react_handjob_skill']

func getname(state = null):
	if givers.size() + takers.size() == 2:
		return tr("SEXACTION_HANDJOB")
	else:
		return tr("SEXACTION_SMLT_HANDJOB")

func getongoingname(givers, takers):
	return tr("SEXACTION_HANDJOB_ONGOING_1")

func requirements():
	var valid = true
	for i in givers:
		if i.limbs == false:
			valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	else:
		for i in takers:
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 65}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 45}
	return effects

const act_lines = {

start_handjob = {

	from_behind_nice = {
	conditions = {
		link_facing = [false],
		consent = [true],
	},
	lines = [
		"SEXACTION_HANDJOB_FROM_BEHIND_NICE_1",
		"SEXACTION_HANDJOB_FROM_BEHIND_NICE_2",
	]},

	from_behind_mean = {
	conditions = {
		link_facing = [false],
		consent = [false],
	},
	lines = [
		"SEXACTION_HANDJOB_FROM_BEHIND_MEAN_1",
	]},

	nice = {
	conditions = {
		link_facing = [true, null],
		consent = [true],
	},
	lines = [
		"SEXACTION_HANDJOB_START_NICE_1",
	]},

	mean = {
	conditions = {
		link_facing = [true, null],
		consent = [false],
	},
	lines = [
		"SEXACTION_HANDJOB_START_MEAN_1",
		"SEXACTION_HANDJOB_START_MEAN_2",
	]},

	novice_nice = {
	conditions = {
		link_facing = [true, null],
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_HANDJOB_START_NOVICE_NICE_1",
		"SEXACTION_HANDJOB_START_NOVICE_NICE_2",
	]},

	novice_mean = {
	conditions = {
		link_facing = [true, null],
		consent = [false],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_HANDJOB_START_NOVICE_MEAN_1",
	]},

	skilled_nice = {
	conditions = {
		link_facing = [true, null],
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_HANDJOB_START_SKILLED_NICE_1",
	]},

	skilled_mean = {
	conditions = {
		link_facing = [true, null],
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_HANDJOB_START_SKILLED_MEAN_1",
	]},

	mastered_nice = {
	conditions = {
		link_facing = [true, null],
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_HANDJOB_START_MASTERED_NICE_1",
	]},

	mastered_mean = {
	conditions = {
		link_facing = [true, null],
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_HANDJOB_START_MASTERED_MEAN_1",
	]},

},

ongoing_handjob = {

	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_HANDJOB_ONGOING_DESC_1",
		"SEXACTION_HANDJOB_ONGOING_DESC_2",
	]},

},

react_handjob = {

	arousal_4_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_AROUSAL4_NICE_1",
		"SEXACTION_HANDJOB_REACT_AROUSAL4_NICE_2",
	]},

	arousal_4_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_AROUSAL4_MEAN_1",
		"SEXACTION_HANDJOB_REACT_AROUSAL4_MEAN_2",
	]},

	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_AROUSAL3_NICE_1",
		"SEXACTION_HANDJOB_REACT_AROUSAL3_NICE_2",
	]},

	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_AROUSAL3_MEAN_1",
		"SEXACTION_HANDJOB_REACT_AROUSAL3_MEAN_2",
	]},

	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_AROUSAL2_NICE_1",
	]},

	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_AROUSAL2_MEAN_1",
	]},

	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_AROUSAL1_NICE_1",
	]},

	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_AROUSAL1_MEAN_1",
		"SEXACTION_HANDJOB_REACT_AROUSAL1_MEAN_2",
	]},

},

react_handjob_skill = {

	giver_novice_low = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_SKILL_NOVICE_LOW_1",
	]},

	giver_novice_high = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_SKILL_NOVICE_HIGH_1",
	]},

	giver_skilled_low = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_SKILL_SKILLED_LOW_1",
	]},

	giver_skilled_high = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_SKILL_SKILLED_HIGH_1",
	]},

	giver_mastered_low = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_SKILL_MASTERED_LOW_1",
	]},

	giver_mastered_high = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_HANDJOB_REACT_SKILL_MASTERED_HIGH_1",
	]},

},

}
