extends Node

const category = 'fucking'
const code = 'ontopanal'
const order = 7
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'anus'
const virginloss = true
const givertags = ['penis','sub']
const takertags = ['anal', 'penetration','dom']
const giver_skill = ['penetration']
const taker_skill = ['anal']
const consent_level = 35

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	for i in givers:
		if i.person.get_stat('penis_size') == '' && i.strapon == false:
			valid = false
	
	return valid

func getname(state = null):
	return "On Top Anal"

func getongoingname(givers, takers):
	return "[name1] has [name2] anally riding on top of [him1]."

func givereffect(member):
	var effects = {sens = 230, horny = 25}
	if member.person.get_stat('penis_size') == '':
		effects.sens /= 1.2
	return effects

func takereffect(member):
	var effects = {sens = 210, horny = 5}
	member.person_metrics.anal += 1
	return effects

#orientation of givers/takers
const rotation1 = Quat(0.0,0.0,0.0,0.0)
const rotation2 = Quat(0.0,0.0,0.0,1.0)

const initiate = ['start_1_lotus','start_2_sexa']

const ongoing = ['main_1_sexa','main_2_sexa','main_3_sex']

const reaction = ['react_1_sex','react_2_sex','react_3_sexa']

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
		" as [name1] make[s/1] a show of [him2].",
	]},
	
},

}
