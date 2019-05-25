extends Node

const category = 'fucking'
const code = 'doubledildoass'
const order = 10
var givers
var takers
const canlast = true
const giverpart = 'anus'
const takerpart = 'anus'
const virginloss = true
const giverconsent = 'advanced'
const takerconsent = 'advanced'
const givertags = ['anal', 'penetration']
const takertags = ['anal', 'penetration']

func getname(state = null):
	return "Double Anal Dildo"

func getongoingname(givers, takers):
	return "[name1] and [name2] fuck each other's assholes with a double-ended dildo."

func getongoingdescription(givers, takers):
	return "[name1] and [name2] {^shake:grind:pump} [their] hips together, as the dildo trusts in and out of [their] [ass3]."

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	return valid

func givereffect(member):
	var result
	var effects = {sens = 190}
	member.person.metrics.anal += 1
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.sens >= 500) && member.lube >= 5:
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
	member.lube()
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.sens >= 500) && member.lube >= 5:
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var text = ''
	text += "[name1] insert[s/1] a double dildo into [his1] and [names2] [ass3], {^grinding:pumping:gyrating} [his1] hips against [partners2]."
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[names2] [ass2] {^trembles:twitches}, {^responding:reacting} to {^the stimulation:[names1] efforts:the dildo inside [him2]} even in [his2] unconcious state."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[names2] [ass2] {^presents:gives} some resistance to {^the intrusion:[names1] efforts:the dildo inside [him2]}{^, still somewhat unprepared:, not yet fully prepared:}."
	elif member.sens < 300:
		text = "[names2] [ass2] {^begins:starts} to {^respond:react} to the {^sensation:feeling} of {^the intrusion:[names1] dildo:the dildo inside [him2]}."
	elif member.sens < 600:
		text = "[names2] [ass2] {^trembles:quivers} in {^response:reaction} to the {^sensation:feeling} of {^[names1] dildo:the dildo inside [him2]}, [his2] arousal {^made clear:apparent:clearly showing}."
	else:
		text = "[names2] [ass2] {^violently trembles:clenches:quivers} {^with every movement of [names1] hips:in response to [names1] efforts}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text