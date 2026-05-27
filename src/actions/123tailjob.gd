extends Reference

const category = 'caress'
const code = 'tailjob'
const order = 10
var givers
var takers
const canlast = true
const giverpart = 'tail'
const takerpart = 'penis'
const virginloss = false
const givertags = ['pet', 'tail', 'noorgasm']
const takertags = ['pet','penis']
const giver_skill = ['tail']
const taker_skill = []
const consent_level = 25

const consent_giver = 3
const consent_taker = 3

const parallel = true
const facing = true
const linkset = "none"

const initiate = ['start_tailjob']
const ongoing = ['ongoing_tailjob']
const reaction = ['react_tailjob', 'react_tailjob_skill']

func getname(state = null):
	return tr("SEXACTION_TAILJOB")

func getongoingname(givers, takers):
	return tr("SEXACTION_TAILJOB_ONGOING_1")

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif takers.size() > givers.size():
		valid = false
	else:
		for i in givers:
			if !variables.longtails.has(i.person.get_stat('tail')):
				valid = false
			if i.limbs == false:
				valid = false
		for i in takers:
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 75}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 40}
	return effects

const act_lines = {

start_tailjob = {

	furry_novice = {
	conditions = {
		giver_tail_type = ['furry'],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_TAILJOB_START_FURRY_NOVICE_1",
	]},

	furry_skilled = {
	conditions = {
		giver_tail_type = ['furry'],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_TAILJOB_START_FURRY_SKILLED_1",
	]},

	furry_mastered = {
	conditions = {
		giver_tail_type = ['furry'],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_TAILJOB_START_FURRY_MASTERED_1",
	]},

	scaly_novice = {
	conditions = {
		giver_tail_type = ['scaly'],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_TAILJOB_START_SCALY_NOVICE_1",
	]},

	scaly_skilled = {
	conditions = {
		giver_tail_type = ['scaly'],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_TAILJOB_START_SCALY_SKILLED_1",
	]},

	scaly_mastered = {
	conditions = {
		giver_tail_type = ['scaly'],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_TAILJOB_START_SCALY_MASTERED_1",
	]},

},

ongoing_tailjob = {

	furry_novice = {
	conditions = {
		giver_tail_type = ['furry'],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_TAILJOB_ONGOING_FURRY_NOVICE_1",
		"SEXACTION_TAILJOB_ONGOING_FURRY_NOVICE_2",
	]},

	furry_skilled = {
	conditions = {
		giver_tail_type = ['furry'],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_TAILJOB_ONGOING_FURRY_SKILLED_1",
		"SEXACTION_TAILJOB_ONGOING_FURRY_SKILLED_2",
	]},

	furry_mastered = {
	conditions = {
		giver_tail_type = ['furry'],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_TAILJOB_ONGOING_FURRY_MASTERED_1",
		"SEXACTION_TAILJOB_ONGOING_FURRY_MASTERED_2",
	]},

	scaly_novice = {
	conditions = {
		giver_tail_type = ['scaly'],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXACTION_TAILJOB_ONGOING_SCALY_NOVICE_1",
		"SEXACTION_TAILJOB_ONGOING_SCALY_NOVICE_2",
	]},

	scaly_skilled = {
	conditions = {
		giver_tail_type = ['scaly'],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXACTION_TAILJOB_ONGOING_SCALY_SKILLED_1",
		"SEXACTION_TAILJOB_ONGOING_SCALY_SKILLED_2",
	]},

	scaly_mastered = {
	conditions = {
		giver_tail_type = ['scaly'],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXACTION_TAILJOB_ONGOING_SCALY_MASTERED_1",
		"SEXACTION_TAILJOB_ONGOING_SCALY_MASTERED_2",
	]},

},

react_tailjob = {

	arousal_4 = {
	conditions = {
		arousal = [4, 5],
	},
	lines = [
		"SEXACTION_TAILJOB_REACTION_4",
	]},

	arousal_3 = {
	conditions = {
		arousal = [3],
	},
	lines = [
		"SEXACTION_TAILJOB_REACTION_3",
	]},

	arousal_2 = {
	conditions = {
		arousal = [2],
	},
	lines = [
		"SEXACTION_TAILJOB_REACTION_2",
	]},

	arousal_1 = {
	conditions = {
		arousal = [1],
	},
	lines = [
		"SEXACTION_TAILJOB_REACTION_1",
	]},

},

react_tailjob_skill = {

	novice_low = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [1, 2],
	},
	lines = [
		"SEXACTION_TAILJOB_SKILL_NOVICE_LOW_1",
	]},

	novice_high = {
	conditions = {
		giver_skill_level = ['novice'],
		arousal = [3, 4, 5],
	},
	lines = [
		"SEXACTION_TAILJOB_SKILL_NOVICE_HIGH_1",
	]},

	skilled_low = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [1, 2],
	},
	lines = [
		"SEXACTION_TAILJOB_SKILL_SKILLED_LOW_1",
	]},

	skilled_high = {
	conditions = {
		giver_skill_level = ['skilled'],
		arousal = [3, 4, 5],
	},
	lines = [
		"SEXACTION_TAILJOB_SKILL_SKILLED_HIGH_1",
	]},

	mastered_low = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [1, 2],
	},
	lines = [
		"SEXACTION_TAILJOB_SKILL_MASTERED_LOW_1",
	]},

	mastered_high = {
	conditions = {
		giver_skill_level = ['mastered'],
		arousal = [3, 4, 5],
	},
	lines = [
		"SEXACTION_TAILJOB_SKILL_MASTERED_HIGH_1",
	]},

},

}
