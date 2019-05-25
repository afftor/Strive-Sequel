extends Node

const category = 'fucking'
const code = 'doggyanal'
const order = 6
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'anus'
const virginloss = true
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = ['penis']
const takertags = ['anal', 'penetration']

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
#	elif givers.size() + takers.size() == 2 && (!givers[0].penis in [takers[0].vagina, takers[0].anus] ):
#		valid = false
	for i in givers:
		if i.person.penis == 'none' && i.strapon == null:
			valid = false
#		elif i.penis != null && givers.size() > 1:
#			valid = false
#	for i in takers:
#		if i.anus != null && takers.size() > 1:
#			valid = false
	
	return valid

func getname(state = null):
	if givers[0].strapon != null && takers[0].person.penis != 'none':
		return "Doggy Pegging"
	else:
		return "Doggy Anal"

func getongoingname(givers, takers):
	return "[name1] fuck[s/1] [names2] ass[/es2] doggy style."

func givereffect(member):
	var result
	var effects = {sens = 200}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.sens >= 200):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {sens = 190}
	member.person.metrics.anal += 1
	if (member.consent == true || member.person.traits.find("Likes it rough") >= 0) && member.sens >= 300 && member.lube >= 5:
		result = 'good'
	elif (member.consent == true || member.person.traits.find("Likes it rough") >= 0):
		result = 'average'
	else:
		result = 'bad'
	if member.lube < 5:
		effects.pain = 3
	if member.person.penis == 'none':
		effects.sens /= 1.2
	return [result, effects]

#orientation of givers/takers
const rotation1 = Quat(0.0,0.0,0.0,0.0)
const rotation2 = Quat(0.5,0.0,0.0,1.0)

const initiate = ['start_1_doggy','start_2_sexa']

const ongoing = ['main_1_sexa','main_2_sexa','main_3_sex']

const reaction = ['react_1_sex','react_2_sex','react_3_sexa']

const linkset = "sex"

const act_lines = {

start_2_sexa = {
	
	shift = {
	conditions = {
		orifice = ["shift"],
	},
	lines = [
		", {^enjoying:relishing in} the {^fine:perfect} view of [partners2] [ass2]. ",
	]},
	
	insert = {
	conditions = {
		orifice = ["insert"],
	},
	lines = [
		", {^adjusting:rolling} [his2] hips forward to expose [his2] [anus2]. ",
		", {^pressing:pushing} [his2] upper body downward to expose [his2] [anus2]. ",
	]},
	
},

main_3_sex = {
	
	locational = {
	conditions = {
	},
	lines = [
		". ",
		" from behind. ",
		" like [an /2]animal[/s2]. ",
	]},
	
},

react_3_sexa = {
	
	default = {
	conditions = {
	},
	lines = [
		" as [name1] [fucks1] [partners2] [anus2] {^like [an /2]animal[/s2]:like a dog in heat}.",
	]},
	
},

}