extends Reference

const category = 'SM'
const code = 'cum_select'
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = ['noorgasm']
const takertags = ['nooragsm']
const giver_skill = []
const taker_skill = []
const consent_level = 10
const consent_giver = 0
const consent_taker = 0

func getname(state = null):
	return "Selectively Cum"

func getongoingname(givers, takers):
	return ""

func getongoingdescription(givers, takers):
	return ""

func requirements():
	var valid = true
	if givers.size() != 1 || takers.size() != 1 || givers[0].sens < 900:
		valid = false
	for i in givers:
		if i.subduing != null || i.person.get_stat('penis_size') == '' || i.strapon == true:
			valid = false
	return valid

func givereffect(member):
	var effects = {lust = 0}
	return effects

func takereffect(member):
	var effects = {lust = 0}
	return effects
	

func initiate():
	return "As [name1] prepares to cum, [he1] focuses [his1] attention on [name2]..."
