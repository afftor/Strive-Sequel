extends Node

const category = 'fucking'
const code = 'tribadism'
const order = 9
var givers
var takers
const canlast = true
const giverpart = 'vagina'
const takerpart = 'vagina'
const virginloss = false
const givertags = ['vagina', 'pet']
const takertags = ['vagina', 'pet']
const giver_skill = ['pussy']
const taker_skill = ['pussy']
const consent_level = 25

func getname(state = null):
	return "Tribadism"

func getongoingname(givers, takers):
	return "[name1] and [name2] rub [their] pussies together."

func getongoingdescription(givers, takers):
	return "[name1] and [name2] continue to grind [their] [pussy3] together."

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	else:
		for i in givers:
			if i.person.get_stat('has_pussy') == false:
				valid = false
		for i in takers:
			if i.person.get_stat('has_pussy') == false:
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 160, horny = 10}
	return effects

func takereffect(member):
	var effects = {sens = 160, horny = 10}
	return effects

func initiate():
	var text = ''
	text += "[name1] and [name2] {^sway:shake} [their] hips and {^grind:rub} [their] [pussy3] together."
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[names2] [pussy2] {^trembles:twitches}, {^responding:reacting} to {^the stimulation:[names1] efforts:[name1] against [him2]} even in [his2] unconcious state."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] efforts:[name1] against [him2]}{^, still somewhat unprepared:, not yet fully prepared:}."
	elif member.sens < 300:
		text = "[names2] [pussy2] {^begins:starts} to {^respond:react} to the {^sensation:feeling} of {^[names1] efforts:[name1] against [him2]}."
	elif member.sens < 600:
		text = "[names2] [pussy2] {^trembles:quivers} in {^response:reaction} to the {^sensation:feeling} of {^[names1] efforts:[name1] against [him2]}, [his2] arousal {^made clear:apparent:clearly showing}."
	else:
		text = "[names2] [pussy2] {^violently trembles:clenches:quivers} {^with every movement of [names1] hips:in response to [names1] efforts}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
