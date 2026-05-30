extends Reference

const category = 'caress'
const code = 'fingering'
const order = 5
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'clit'
const occupied_check_part = 'vagina'
const virginloss = false
const givertags = ['pet','noorgasm']
const takertags = ['pet', 'vagina']
const giver_skill = ['petting']
const taker_skill = ['pussy']
const consent_level = 15

const consent_giver = 0
const consent_taker = 2

const parallel = true
const facing = true
const linkset = "caress"

const vaginal_codes = ['missionary', 'doggy', 'lotus', 'revlotus', 'ontop', 'doubledildo', 'inserttailv', 'tribadism', 'doublepen', 'spitroast', 'insertinturns', 'fisting', 'vibrator', 'mastshow']

const initiate = ['start_fingering']
const ongoing = ['ongoing_fingering']
const reaction = ['react_fingering', 'react_2_sex', 'react_fingering_skill']

func _vagina_occupied(member):
	for act in member.activeactions:
		if act.scene_code in vaginal_codes:
			return true
	return false

func getname(state = null):
	if takers != null && takers.size() > 0:
		if _vagina_occupied(takers[0]):
			return tr("SEXACTION_FINGERING_CLIT")
	return tr("SEXACTION_FINGERING")

func getongoingname(givers, takers):
	if takers != null && takers.size() > 0:
		if _vagina_occupied(takers[0]):
			return tr("SEXACTION_FINGERING_CLIT_ONGOING_1")
	return tr("SEXACTION_FINGERING_ONGOING_1")

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	for i in givers:
		if i.limbs == false:
			valid = false
	for i in takers:
		if i.person.get_stat('sex') == 'male':
			valid = false
	return valid

func givereffect(member):
	var effects = {sens = 100}
	return effects

func takereffect(member):
	var effects = {sens = 125, horny = 30}
	return effects

const act_lines = {

start_fingering = {

	from_behind_clit_nice = {
	conditions = {
		link_facing = [false],
		taker_vaginal_ongoing = [true],
		consent = [true],
	},
	lines = [
		"SEXACTION_FINGERING_CLIT_FROM_BEHIND_NICE_1",
		"SEXACTION_FINGERING_CLIT_FROM_BEHIND_NICE_2",
	]},

	from_behind_clit_mean = {
	conditions = {
		link_facing = [false],
		taker_vaginal_ongoing = [true],
		consent = [false],
	},
	lines = [
		"SEXACTION_FINGERING_CLIT_FROM_BEHIND_MEAN_1",
	]},

	from_behind_nice = {
	conditions = {
		link_facing = [false],
		taker_vaginal_ongoing = [false],
		consent = [true],
	},
	lines = [
		"SEXACTION_FINGERING_FROM_BEHIND_NICE_1",
		"SEXACTION_FINGERING_FROM_BEHIND_NICE_2",
	]},

	from_behind_mean = {
	conditions = {
		link_facing = [false],
		taker_vaginal_ongoing = [false],
		consent = [false],
	},
	lines = [
		"SEXACTION_FINGERING_FROM_BEHIND_MEAN_1",
	]},

	clit_nice = {
	conditions = {
		link_facing = [true, null],
		taker_vaginal_ongoing = [true],
		consent = [true],
	},
	lines = [
		"SEXACTION_FINGERING_CLIT_NICE_1",
		"SEXACTION_FINGERING_CLIT_NICE_2",
	]},

	clit_mean = {
	conditions = {
		link_facing = [true, null],
		taker_vaginal_ongoing = [true],
		consent = [false],
	},
	lines = [
		"SEXACTION_FINGERING_CLIT_MEAN_1",
	]},

	nice = {
	conditions = {
		link_facing = [true, null],
		taker_vaginal_ongoing = [false],
		consent = [true],
	},
	lines = [
		"SEXACTION_FINGERING_START_NICE_1",
		"SEXACTION_FINGERING_START_NICE_2",
	]},

	mean = {
	conditions = {
		link_facing = [true, null],
		taker_vaginal_ongoing = [false],
		consent = [false],
	},
	lines = [
		"SEXACTION_FINGERING_START_MEAN_1",
		"SEXACTION_FINGERING_START_MEAN_2",
	]},

	novice_nice = {
	conditions = {
		link_facing = [true, null],
		taker_vaginal_ongoing = [false],
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_FINGERING_START_NOVICE_NICE_1",
	]},

	novice_mean = {
	conditions = {
		link_facing = [true, null],
		taker_vaginal_ongoing = [false],
		consent = [false],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_FINGERING_START_NOVICE_MEAN_1",
	]},

	skilled_nice = {
	conditions = {
		link_facing = [true, null],
		taker_vaginal_ongoing = [false],
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_FINGERING_START_SKILLED_NICE_1",
	]},

	skilled_mean = {
	conditions = {
		link_facing = [true, null],
		taker_vaginal_ongoing = [false],
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_FINGERING_START_SKILLED_MEAN_1",
	]},

	mastered_nice = {
	conditions = {
		link_facing = [true, null],
		taker_vaginal_ongoing = [false],
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_FINGERING_START_MASTERED_NICE_1",
	]},

	mastered_mean = {
	conditions = {
		link_facing = [true, null],
		taker_vaginal_ongoing = [false],
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_FINGERING_START_MASTERED_MEAN_1",
	]},

},

ongoing_fingering = {

	clit = {
	conditions = {
		taker_vaginal_ongoing = [true],
	},
	lines = [
		"SEXACTION_FINGERING_CLIT_ONGOING_DESC_1",
		"SEXACTION_FINGERING_CLIT_ONGOING_DESC_2",
	]},

	default = {
	conditions = {
		taker_vaginal_ongoing = [false],
	},
	lines = [
		"SEXACTION_FINGERING_ONGOING_DESC_1",
		"SEXACTION_FINGERING_ONGOING_DESC_2",
	]},

},

react_fingering = {

	arousal_4_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_AROUSAL4_NICE_1",
		"SEXACTION_FINGERING_REACT_AROUSAL4_NICE_2",
	]},

	arousal_4_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_AROUSAL4_MEAN_1",
	]},

	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_AROUSAL3_NICE_1",
		"SEXACTION_FINGERING_REACT_AROUSAL3_NICE_2",
	]},

	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_AROUSAL3_MEAN_1",
	]},

	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_AROUSAL2_NICE_1",
	]},

	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_AROUSAL2_MEAN_1",
	]},

	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_AROUSAL1_NICE_1",
	]},

	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_AROUSAL1_MEAN_1",
		"SEXACTION_FINGERING_REACT_AROUSAL1_MEAN_2",
	]},

},

react_fingering_skill = {

	giver_novice_low = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_SKILL_NOVICE_LOW_1",
	]},

	giver_novice_high = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_SKILL_NOVICE_HIGH_1",
	]},

	giver_skilled_low = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_SKILL_SKILLED_LOW_1",
	]},

	giver_skilled_high = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_SKILL_SKILLED_HIGH_1",
	]},

	giver_mastered_low = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [1,2],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_SKILL_MASTERED_LOW_1",
	]},

	giver_mastered_high = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [3,4,5],
	},
	lines = [
		"SEXACTION_FINGERING_REACT_SKILL_MASTERED_HIGH_1",
	]},

},

}
