extends Node

const category = 'fucking'
const code = 'doubledildo'
const order = 9
var givers
var takers
const canlast = true
const giverpart = 'vagina'
const takerpart = 'vagina'
const virginloss = true
const givertags = ['vagina', 'penetration']
const takertags = ['vagina', 'penetration']
const giver_skill = ['penetration','pussy']
const taker_skill = ['penetration','pussy']
const consent_level = 30

func getname(state = null):
	return "Double Dildo"

func getongoingname(givers, takers):
	return "[name1] and [name2] fuck each other with a double-ended dildo."

func getongoingdescription(givers, takers):
	return "[name1] and [name2] {^shake:grind:pump} [their] hips together, as the dildo trusts in and out of [their] [pussy3]."

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	else:
		for i in givers:
			if i.person.get_stat('has_pussy') == false :
				valid = false
		for i in takers:
			if i.person.get_stat('has_pussy') == false :
				valid = false
#			elif i.vagina != null:
#				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 200, horny = 10}
	member.person_metrics.vag += 1
	return effects

func takereffect(member):
	var effects = {sens = 200, horny = 10}
	member.person_metrics.vag += 1
	return effects

func initiate():
	var text = ''
	text += "[name1] insert[s/1] a double dildo into [his1] and [names2] pussies, {^grinding:pumping:gyrating} [his1] hips against [partner2]."

	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[names2] [pussy2] {^trembles:twitches}, {^responding:reacting} to {^the stimulation:[names1] efforts:the dildo inside [him2]} even in [his2] unconcious state."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[names2] [pussy2] {^presents:gives} some resistance to {^the intrusion:[names1] efforts:the dildo inside [him2]}{^, still somewhat unprepared:, not yet fully prepared:}."
	elif member.sens < 300:
		text = "[names2] [pussy2] {^begins:starts} to {^respond:react} to the {^sensation:feeling} of {^the intrusion:[names1] dildo:the dildo inside [him2]}."
	elif member.sens < 600:
		text = "[names2] [pussy2] {^trembles:quivers} in {^response:reaction} to the {^sensation:feeling} of {^[names1] dildo:the dildo inside [him2]}, [his2] arousal {^made clear:apparent:clearly showing}."
	else:
		text = "[names2] [pussy2] {^violently trembles:clenches:quivers} {^with every movement of [names1] hips:in response to [names1] efforts}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
