extends Node

const category = 'fucking'
const code = 'missionary'
const order = 1
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'vagina'
const virginloss = true
const givertags = ['penis','dom']
const takertags = ['vagina', 'penetration','sub']
const giver_skill = ['penetration']
const taker_skill = ['pussy']
const consent_level = 25

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
#	elif givers.size() + takers.size() == 2 && (!givers[0].penis in [takers[0].vagina, takers[0].anus] ):
#		valid = false
	for i in givers:
		if i.person.penis_size == '' && i.strapon == false:
			valid = false
#		elif i.penis != null && givers.size() > 1:
#			valid = false
	for i in takers:
		if i.person.has_pussy == false:
			valid = false
#		elif i.vagina != null && takers.size() == 1:
#			valid = false
	
	return valid

func getname(state = null):
	return "Missionary"

func getongoingname(givers, takers):
	return "[name1] fuck[s/1] [name2] in the missionary position."

func givereffect(member):
	var effects = {sens = 220, horny = 25}
	if member.person.penis_size == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 200, horny = 10}
	member.person.metrics.vag += 1
	return effects

#orientation of givers/takers
const rotation1 = Quat(0.5,0.0,0.0,0.0)
const rotation2 = Quat(0.5,0.0,0.0,0.0)

const initiate = ['start_1_missionary','start_2_sexv']

const ongoing = ['main_1_sexv','main_2_sexv','main_3_sex']

const reaction = ['react_1_sex','react_2_sex','react_3_sexv']

const linkset = "sex"

const act_lines = {

start_2_sexv = {
	
	shift = {
	conditions = {
		orifice = ["shift"],
	},
	lines = [
		", {^enjoying:relishing in} the closeness of [partners2] [body2]. ",
	]},
	
	insert = {
	conditions = {
		orifice = ["insert"],
	},
	lines = [
		", {^spreading:parting:pulling apart:holding apart} [his2] thighs to expose [his2] [pussy2]. ",
	]},
	
},

main_3_sex = {
	
	locational = {
	conditions = {
	},
	lines = [
		". ",
		" from above. ",
	]},
	
},

react_3_sexv = {
	
	default = {
	conditions = {
	},
	lines = [
		" as [name1] [fucks1] [partner2].",
	]},
	
},

}
