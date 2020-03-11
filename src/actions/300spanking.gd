extends Node

const category = 'SM'
const code = 'spanking'
const order = 1
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = ['pet','noorgasm','dom']
const takertags = ['pet', 'punish', 'pain','sub']
const giver_skill = []
const taker_skill = []
const consent_level = 25

func getname(state = null):
	return "Spanking"

#func getongoingname(givers, takers):
#	return "[name1] spank[s/1] [names2] ass."

#func getongoingdescription(givers, takers):
#	var temparray = []
#	return temparray[rand_range(0,temparray.size())]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	return valid

func givereffect(member):
	var effects = {sens = 10, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 90, horny = 20}
	return effects

func initiate():
	var temparray = []
	temparray += ["[name1] {^spank:slap:beat:swat}[s/1] [names2] [ass2]{^ with [an /1]open hand[/s1]: until it turns red:, intent on humiliating [him2]}."]
	temparray += ["[name1] {^spank:slap:beat:swat}[s/1] [name2] {^right :square :}{^across:on} [his2] [ass2] {^repeatedly:again and again:over and over}."]
	return temparray[randi()%temparray.size()]

func reaction(member):
	var text = ''
	#elif member.consent == false:
		#TBD
	if member.sens < 300:
		text = "[name2] {^jerk:wince:writhe}[s/2] in pain from the {^humiliating:demeaning:embarassing} punishment."
	elif member.sens < 600:
		text = "[name2] cries out with each blow to [his2] buttox, though [his2] voice betrays some enjoyment."
	elif member.sens < 950:
		text = "[names2] moans make it {^hard:difficult} to tell if [he2] in pain or enjoying [himself2]."
	else:
		text = "[names2] body {^trembles:quivers} {^with each swat:each time [name1] slap[s/1] [his2] [ass2]}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	
	return text