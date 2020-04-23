extends Node

const category = 'fucking'
const code = 'ontop'
const order = 6
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'vagina'
const virginloss = true
const givertags = ['penis','sub']
const takertags = ['vagina', 'penetration','dom']
const giver_skill = ['penetration']
const taker_skill = ['pussy']
const consent_level = 30

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	for i in givers:
		if i.person.penis_size == '' && i.strapon == false:
			valid = false
	for i in takers:
		if i.person.has_pussy == false:
			valid = false
	
	return valid

func getname(state = null):
	return "On Top"

func getongoingname(givers, takers):
	return "[name1] has [name2] riding on top of [him1]."

func givereffect(member):
	var effects = {sens = 220, horny = 25}
	if member.person.penis_size == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 220, horny = 15}
	member.person.metrics.vag += 1
	return effects

#orientation of givers/takers
const rotation1 = Quat(0.0,0.0,0.0,0.0)
const rotation2 = Quat(0.0,0.0,0.0,1.0)

const initiate = ['start_1_lotus','start_2_sexv']

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
		", {^enjoying:finding glee in} putting [partner2] in such an embarassing position. ",
	]},
	
},

main_3_sex = {
	
	locational = {
	conditions = {
	},
	lines = [
		". ",
		" from below. ",
	]},
	
},

react_3_sexv = {

	default = {
	conditions = {
	},
	lines = [
		" as [name2] ride[s/1] on [him1].",
	]},

},

}
