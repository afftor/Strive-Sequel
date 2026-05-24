extends Reference

const category = 'caress'
const code = 'fondletits'
const order = 3
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = ['pet','noorgasm']
const takertags = ['pet', 'tits']
const giver_skill = ['petting']
const taker_skill = []
const consent_level = 15

const consent_giver = 0
const consent_taker = 1

const parallel = true
const facing = true
const linkset = "caress"

const initiate = ['start_fondletits']
const ongoing = ['ongoing_fondletits']
const reaction = ['react_fondletits']

func getname(state = null):
	return tr("SEXACTION_FONDLE_CHEST")

func getongoingname(givers, takers):
	return tr("SEXACTION_FONDLETITS_ONGOING_1")

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	for i in givers + takers:
		if i.limbs == false:
			valid = false
	return valid

const enthusiasm = {
	trigger_text = "INTERACTION_ENTHUSIASM_TRIGGER_FONDLETITS",
	btn_text = "INTERACTION_ENTHUSIASM_BTN",
	choices = [
		{name_key = "INTERACTION_ENTHUSIASM_FONDLETITS_CHOICE_SQUEEZE", personality = 'bold',
			love_keys = ["INTERACTION_ENTHUSIASM_FONDLETITS_SQUEEZE_LOVE_1", "INTERACTION_ENTHUSIASM_FONDLETITS_SQUEEZE_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_FONDLETITS_SQUEEZE_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_FONDLETITS_CHOICE_NIPPLES", personality = 'serious',
			love_keys = ["INTERACTION_ENTHUSIASM_FONDLETITS_NIPPLES_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_FONDLETITS_NIPPLES_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_FONDLETITS_CHOICE_CLOSENESS", personality = 'shy',
			love_keys = ["INTERACTION_ENTHUSIASM_FONDLETITS_CLOSENESS_LOVE_1", "INTERACTION_ENTHUSIASM_FONDLETITS_CLOSENESS_LOVE_2"],
			hate_keys = ["INTERACTION_ENTHUSIASM_FONDLETITS_CLOSENESS_HATE_1"]},
		{name_key = "INTERACTION_ENTHUSIASM_FONDLETITS_CHOICE_PRAISE", personality = 'kind',
			love_keys = ["INTERACTION_ENTHUSIASM_FONDLETITS_PRAISE_LOVE_1"],
			hate_keys = ["INTERACTION_ENTHUSIASM_FONDLETITS_PRAISE_HATE_1"]},
	],
	training_upgrades = [{skill = 'petting', target = 'skilled'}],
}

func givereffect(member):
	var effects = {sens = 90}
	return effects

func takereffect(member):
	var effects = {sens = 125, horny = 30}
	if member.person.get_stat('sex') == 'male':
		effects.sens /= 2
	return effects

const act_lines = {

start_fondletits = {

	from_behind_nice = {
	conditions = {
		link_facing = [false],
		consent = [true],
	},
	lines = [
		"SEXACTION_FONDLETITS_FROM_BEHIND_NICE_1",
		"SEXACTION_FONDLETITS_FROM_BEHIND_NICE_2",
	]},

	from_behind_mean = {
	conditions = {
		link_facing = [false],
		consent = [false],
	},
	lines = [
		"SEXACTION_FONDLETITS_FROM_BEHIND_MEAN_1",
	]},

	nice = {
	conditions = {
		link_facing = [true, null],
		consent = [true],
	},
	lines = [
		"SEXACTION_FONDLETITS_START_NICE_1",
		"SEXACTION_FONDLETITS_START_NICE_2",
		"SEXACTION_FONDLETITS_START_NICE_3",
	]},

	mean = {
	conditions = {
		link_facing = [true, null],
		consent = [false],
	},
	lines = [
		"SEXACTION_FONDLETITS_START_MEAN_1",
		"SEXACTION_FONDLETITS_START_MEAN_2",
	]},

},

ongoing_fondletits = {

	default = {
	conditions = {
	},
	lines = [
		"SEXACTION_FONDLETITS_ONGOING_DESC_1",
	]},

},

react_fondletits = {

	arousal_4 = {
	conditions = {
		arousal = [4,5],
	},
	lines = [
		"SEXACTION_FONDLETITS_REACTION_4",
	]},

	arousal_3 = {
	conditions = {
		arousal = [3],
	},
	lines = [
		"SEXACTION_FONDLETITS_REACTION_3",
	]},

	arousal_2 = {
	conditions = {
		arousal = [2],
	},
	lines = [
		"SEXACTION_FONDLETITS_REACTION_2",
	]},

	arousal_1 = {
	conditions = {
		arousal = [1],
	},
	lines = [
		"SEXACTION_FONDLETITS_REACTION_1",
	]},

},

}
